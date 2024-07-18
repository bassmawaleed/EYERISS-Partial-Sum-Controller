module Psum_control_unit (
    input wire clk,
    input wire rst,
    input wire row_0_done,
    input wire row_1_done,
    input wire row_2_done,
    input wire row_3_done,
    input wire row_4_done,
    output reg Rd_En_row0,
    output reg Rd_En_row1, 
    output reg Rd_En_row2, 
    output reg Rd_En_row3, 
    output reg Rd_En_row4, 
    output reg Rd_En_row5, 
    output reg Rd_En_row6, 
    output reg Rd_En_row7, 
    output reg Rd_En_row8, 
    output reg Rd_En_row9, 
    output reg Rd_En_row10, 
    output reg Rd_En_row11, 
    output reg Rd_En_row12, 
    output reg Rd_En_row13,
    output reg Accum_InPsum_row0, 
    output reg Accum_InPsum_row1, 
    output reg Accum_InPsum_row2, 
    output reg Accum_InPsum_row3, 
    output reg Accum_InPsum_row4, 
    output reg Accum_InPsum_row5, 
    output reg Accum_InPsum_row6, 
    output reg Accum_InPsum_row7, 
    output reg Accum_InPsum_row8, 
    output reg Accum_InPsum_row9, 
    output reg Accum_InPsum_row10, 
    output reg Accum_InPsum_row11, 
    output reg Accum_InPsum_row12, 
    output reg Accum_InPsum_row13,

    output reg PE_Enable_1, 
    output reg PE_Enable_2, 
    output reg PE_Enable_3, 
    output reg PE_Enable_4, 
    output reg PE_Enable_5, 
    output reg PE_Enable_6, 
    output reg PE_Enable_7, 
    output reg PE_Enable_8, 
    output reg PE_Enable_9, 
    output reg PE_Enable_10, 
    output reg PE_Enable_11, 
    output reg PE_Enable_12, 
    output reg PE_Enable_13, 
    output reg PE_Enable_14,

    output reg Mux_select,
    output reg DeMux_select,
    output reg [15:0] memory_addr,
    output reg glb_WrEn,
    output reg ready

);

/* States definition */
parameter Idle = 3'b000;
parameter done_row_0 = 3'b001;
parameter done_row_1 = 3'b010;
parameter done_row_2 = 3'b011;
parameter done_row_3 = 3'b100;
parameter write_mem = 3'b101;

reg [2:0] next_state , current_state;

/* Define the counter */
reg [5:0] counter;


reg [11:0] base_address;
reg [3:0] mem_counter;


/* Current State Logic */
always @(posedge clk or negedge rst) begin
    if(!rst)
        current_state <= Idle ;
    else
        current_state <= next_state ;
end

/* Next State Logic */
always @(*) begin
    case (current_state)
        Idle: begin
            if(row_0_done == 1)
                next_state = done_row_0;
            else
                next_state = Idle;
        end
        done_row_0: begin
            if(row_1_done == 1)
                next_state = done_row_1;
            else
                next_state = done_row_0;
        end
        done_row_1: begin
            if(row_2_done == 1)
                next_state = done_row_2;
            else
                next_state = done_row_1;
        end
        done_row_2: begin
            if(row_3_done == 1)
                next_state = done_row_3;
            else
                next_state = done_row_2;
        end
        done_row_3: begin
            if(row_4_done == 1)
                next_state = write_mem;
            else
                next_state = done_row_3;
        end
        write_mem: begin
            if (mem_counter == 4'd15) begin
                next_state = Idle;
            end 
            else begin
                next_state = write_mem;
            end
            
        end

        default: next_state = Idle;
    endcase
end

/* Output Logic */
always @(*) begin
            Rd_En_row0 = 1'b0; 
            Rd_En_row1 = 1'b0; 
            Rd_En_row2 = 1'b0; 
            Rd_En_row3 = 1'b0; 
            Rd_En_row4 = 1'b0; 
            Rd_En_row5 = 1'b0; 
            Rd_En_row6 = 1'b0; 
            Rd_En_row7 = 1'b0; 
            Rd_En_row8 = 1'b0; 
            Rd_En_row9 = 1'b0; 
            Rd_En_row10 = 1'b0; 
            Rd_En_row11 = 1'b0; 
            Rd_En_row12 = 1'b0; 
            Rd_En_row13 = 1'b0;
            Accum_InPsum_row0 = 1'b0; 
            Accum_InPsum_row1 = 1'b0; 
            Accum_InPsum_row2 = 1'b0; 
            Accum_InPsum_row3 = 1'b0; 
            Accum_InPsum_row4 = 1'b0; 
            Accum_InPsum_row5 = 1'b0; 
            Accum_InPsum_row6 = 1'b0; 
            Accum_InPsum_row7 = 1'b0; 
            Accum_InPsum_row8 = 1'b0; 
            Accum_InPsum_row9 = 1'b0; 
            Accum_InPsum_row10 = 1'b0; 
            Accum_InPsum_row11 = 1'b0; 
            Accum_InPsum_row12 = 1'b0; 
            Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
            Mux_select = 1'b1;
            DeMux_select = 1'b0;
            memory_addr = base_address + mem_counter;
    case (current_state)
        Idle: begin
            
            Rd_En_row0 = 1'b0; 
            Rd_En_row1 = 1'b0; 
            Rd_En_row2 = 1'b0; 
            Rd_En_row3 = 1'b0; 
            Rd_En_row4 = 1'b0; 
            Rd_En_row5 = 1'b0; 
            Rd_En_row6 = 1'b0; 
            Rd_En_row7 = 1'b0; 
            Rd_En_row8 = 1'b0; 
            Rd_En_row9 = 1'b0; 
            Rd_En_row10 = 1'b0; 
            Rd_En_row11 = 1'b0; 
            Rd_En_row12 = 1'b0; 
            Rd_En_row13 = 1'b0;
            Accum_InPsum_row0 = 1'b0; 
            Accum_InPsum_row1 = 1'b0; 
            Accum_InPsum_row2 = 1'b0; 
            Accum_InPsum_row3 = 1'b0; 
            Accum_InPsum_row4 = 1'b0; 
            Accum_InPsum_row5 = 1'b0; 
            Accum_InPsum_row6 = 1'b0; 
            Accum_InPsum_row7 = 1'b0; 
            Accum_InPsum_row8 = 1'b0; 
            Accum_InPsum_row9 = 1'b0; 
            Accum_InPsum_row10 = 1'b0; 
            Accum_InPsum_row11 = 1'b0; 
            Accum_InPsum_row12 = 1'b0; 
            Accum_InPsum_row13 = 1'b0; 
            PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
            Mux_select = 1'b1;
            DeMux_select = 1'b0;
        end 
        done_row_0: begin
                Rd_En_row0 = 1'b0; 
                Rd_En_row1 = 1'b0; 
                Rd_En_row2 = 1'b0; 
                Rd_En_row3 = 1'b0; 
                Rd_En_row4 = 1'b0; 
                Rd_En_row5 = 1'b0; 
                Rd_En_row6 = 1'b0; 
                Rd_En_row7 = 1'b0; 
                Rd_En_row8 = 1'b0; 
                Rd_En_row9 = 1'b0; 
                Rd_En_row10 = 1'b0; 
                Rd_En_row11 = 1'b0; 
                Rd_En_row12 = 1'b0; 
                Rd_En_row13 = 1'b0;
                Accum_InPsum_row0 = 1'b0; 
                Accum_InPsum_row1 = 1'b0; 
                Accum_InPsum_row2 = 1'b0; 
                Accum_InPsum_row3 = 1'b0; 
                Accum_InPsum_row4 = 1'b0; 
                Accum_InPsum_row5 = 1'b0; 
                Accum_InPsum_row6 = 1'b0; 
                Accum_InPsum_row7 = 1'b0; 
                Accum_InPsum_row8 = 1'b0; 
                Accum_InPsum_row9 = 1'b0; 
                Accum_InPsum_row10 = 1'b0; 
                Accum_InPsum_row11 = 1'b0; 
                Accum_InPsum_row12 = 1'b0; 
                Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
                Mux_select = 1'b0;
                DeMux_select = 1'b0;
                
            case (counter)
                'b000010: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b000011:begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b000100: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b000101: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b000110: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b000111: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b001000: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b001001: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b001010: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b001011: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b001100: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b001101: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b001110: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b001111: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b010000: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b010001: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b010010: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b010011: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b010100: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b010101: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b010110: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b010111: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b011000: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b011001: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b011010: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b011011: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b011100: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b011101: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b011110: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b011111: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b100000: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b100001: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b100010: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b100011: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b100100: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b100101: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b100110: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b100111: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b101000: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b101001: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b101010: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b101011: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b101100: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b101101: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b101110: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b101111: begin
                    Rd_En_row0 = 1'b1;  
                    Rd_En_row5 = 1'b1;
                end
                'b110000: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b110001: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
                'b110100: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                    Accum_InPsum_row1 = 1'b1;
                    Accum_InPsum_row6 = 1'b1;
                    if(next_state == done_row_1) begin
                        PE_Enable_1 = 1'b0;
                        PE_Enable_6 = 1'b0;
                    end
                    else begin
                        PE_Enable_1 = 1'b1;
                        PE_Enable_6 = 1'b1;
                    end
                    
                end
                default: begin
                    Rd_En_row0 = 1'b0;  
                    Rd_En_row5 = 1'b0;
                end
            endcase
        end 
        done_row_1: begin
            Rd_En_row0 = 1'b0; 
                Rd_En_row1 = 1'b0; 
                Rd_En_row2 = 1'b0; 
                Rd_En_row3 = 1'b0; 
                Rd_En_row4 = 1'b0; 
                Rd_En_row5 = 1'b0; 
                Rd_En_row6 = 1'b0; 
                Rd_En_row7 = 1'b0; 
                Rd_En_row8 = 1'b0; 
                Rd_En_row9 = 1'b0; 
                Rd_En_row10 = 1'b0; 
                Rd_En_row11 = 1'b0; 
                Rd_En_row12 = 1'b0; 
                Rd_En_row13 = 1'b0;
                Accum_InPsum_row0 = 1'b0; 
                Accum_InPsum_row1 = 1'b0; 
                Accum_InPsum_row2 = 1'b0; 
                Accum_InPsum_row3 = 1'b0; 
                Accum_InPsum_row4 = 1'b0; 
                Accum_InPsum_row5 = 1'b0; 
                Accum_InPsum_row6 = 1'b0; 
                Accum_InPsum_row7 = 1'b0; 
                Accum_InPsum_row8 = 1'b0; 
                Accum_InPsum_row9 = 1'b0; 
                Accum_InPsum_row10 = 1'b0; 
                Accum_InPsum_row11 = 1'b0; 
                Accum_InPsum_row12 = 1'b0; 
                Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
                Mux_select = 1'b0;
                DeMux_select = 1'b0;
            case (counter)
                'b000010: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b000011:begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b000100: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b000101: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b000110: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b000111: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b001000: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b001001: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b001010: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b001011: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b001100: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b001101: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b001110: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b001111: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b010000: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b010001: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b010010: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b010011: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b010100: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b010101: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b010110: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b010111: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b011000: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b011001: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b011010: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b011011: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b011100: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b011101 :begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b011110: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b011111: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b100000: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b100001: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b100010: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b100011: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b100100: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b100101: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b100110: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b100111: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b101000: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b101001: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b101010: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b101011: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b101100: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b101101: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b101110: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b101111: begin
                    Rd_En_row1 = 1'b1;  
                    Rd_En_row6 = 1'b1;
                end
                'b110000: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b110001: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
                'b110100: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                    Accum_InPsum_row2 = 1'b1;
                    Accum_InPsum_row7 = 1'b1;
                    if(next_state == done_row_2) begin
                        PE_Enable_2 = 1'b0;
                        PE_Enable_7 = 1'b0;
                    end
                    else begin
                        PE_Enable_2 = 1'b1;
                        PE_Enable_7 = 1'b1;
                    end
                end
                default: begin
                    Rd_En_row1 = 1'b0;  
                    Rd_En_row6 = 1'b0;
                end
            endcase
        end 
        done_row_2: begin
            Rd_En_row0 = 1'b0; 
                Rd_En_row1 = 1'b0; 
                Rd_En_row2 = 1'b0; 
                Rd_En_row3 = 1'b0; 
                Rd_En_row4 = 1'b0; 
                Rd_En_row5 = 1'b0; 
                Rd_En_row6 = 1'b0; 
                Rd_En_row7 = 1'b0; 
                Rd_En_row8 = 1'b0; 
                Rd_En_row9 = 1'b0; 
                Rd_En_row10 = 1'b0; 
                Rd_En_row11 = 1'b0; 
                Rd_En_row12 = 1'b0; 
                Rd_En_row13 = 1'b0;
                Accum_InPsum_row0 = 1'b0; 
                Accum_InPsum_row1 = 1'b0; 
                Accum_InPsum_row2 = 1'b0; 
                Accum_InPsum_row3 = 1'b0; 
                Accum_InPsum_row4 = 1'b0; 
                Accum_InPsum_row5 = 1'b0; 
                Accum_InPsum_row6 = 1'b0; 
                Accum_InPsum_row7 = 1'b0; 
                Accum_InPsum_row8 = 1'b0; 
                Accum_InPsum_row9 = 1'b0; 
                Accum_InPsum_row10 = 1'b0; 
                Accum_InPsum_row11 = 1'b0; 
                Accum_InPsum_row12 = 1'b0; 
                Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
                Mux_select = 1'b0;
                DeMux_select = 1'b0;
            case (counter)
                'b000010: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b000011:begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b000100: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b000101: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b000110: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b000111: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b001000: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b001001: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b001010: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b001011: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b001100: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b001101: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b001110: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b001111: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b010000: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b010001: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b010010: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b010011: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b010100: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b010101: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b010110: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b010111: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b011000: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b011001: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b011010: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b011011: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b011100: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b011101: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b011110: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b011111: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b100000: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b100001: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b100010: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b100011: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b100100: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b100101: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b100110: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b100111: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b101000: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b101001: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b101010: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b101011: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b101100: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b101101: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b101110: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b101111: begin
                    Rd_En_row2 = 1'b1;  
                    Rd_En_row7 = 1'b1;
                end
                'b110000: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b110001: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
                'b110100: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                    Accum_InPsum_row3 = 1'b1;
                    Accum_InPsum_row8 = 1'b1;
                    if(next_state == done_row_3) begin
                        PE_Enable_3 = 1'b0;
                        PE_Enable_8 = 1'b0;
                    end
                    else begin
                        PE_Enable_3 = 1'b1;
                        PE_Enable_8 = 1'b1;
                    end
                end
                default: begin
                    Rd_En_row2 = 1'b0;  
                    Rd_En_row7 = 1'b0;
                end
            endcase
        end 
        done_row_3: begin
            Rd_En_row0 = 1'b0; 
                Rd_En_row1 = 1'b0; 
                Rd_En_row2 = 1'b0; 
                Rd_En_row3 = 1'b0; 
                Rd_En_row4 = 1'b0; 
                Rd_En_row5 = 1'b0; 
                Rd_En_row6 = 1'b0; 
                Rd_En_row7 = 1'b0; 
                Rd_En_row8 = 1'b0; 
                Rd_En_row9 = 1'b0; 
                Rd_En_row10 = 1'b0; 
                Rd_En_row11 = 1'b0; 
                Rd_En_row12 = 1'b0; 
                Rd_En_row13 = 1'b0;
                Accum_InPsum_row0 = 1'b0; 
                Accum_InPsum_row1 = 1'b0; 
                Accum_InPsum_row2 = 1'b0; 
                Accum_InPsum_row3 = 1'b0; 
                Accum_InPsum_row4 = 1'b0; 
                Accum_InPsum_row5 = 1'b0; 
                Accum_InPsum_row6 = 1'b0; 
                Accum_InPsum_row7 = 1'b0; 
                Accum_InPsum_row8 = 1'b0; 
                Accum_InPsum_row9 = 1'b0; 
                Accum_InPsum_row10 = 1'b0; 
                Accum_InPsum_row11 = 1'b0; 
                Accum_InPsum_row12 = 1'b0; 
                Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
                Mux_select = 1'b0;
                DeMux_select = 1'b0;
            case (counter)
                'b000010: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b000011:begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b000100: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b000101: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b000110: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b000111: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b001000: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b001001: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b001010: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b001011: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b001100: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b001101: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b001110: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b001111: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b010000: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b010001: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b010010: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b010011: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b010100: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b010101: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b010110: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b010111: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b011000: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b011001: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b011010: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b011011: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b011100: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b011101: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b011110: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b011111: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b100000: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b100001: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b100010: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b100011: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b100100: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b100101: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b100110: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b100111: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b101000: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b101001: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b101010: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b101011: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b101100: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b101101: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b101110: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b101111: begin
                    Rd_En_row3 = 1'b1;  
                    Rd_En_row8 = 1'b1;
                end
                'b110000: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b110001: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
                'b110100: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                    Accum_InPsum_row4 = 1'b1;
                    Accum_InPsum_row9 = 1'b1;
                    if(next_state == write_mem) begin
                        PE_Enable_4 = 1'b0;
                        PE_Enable_9 = 1'b0;
                    end
                    else begin
                        PE_Enable_4 = 1'b1;
                        PE_Enable_9 = 1'b1;
                    end
                end
                default: begin
                    Rd_En_row3 = 1'b0;  
                    Rd_En_row8 = 1'b0;
                end
            endcase
        end 
        write_mem: begin
                Rd_En_row0 = 1'b0; 
                Rd_En_row1 = 1'b0; 
                Rd_En_row2 = 1'b0; 
                Rd_En_row3 = 1'b0; 
                Rd_En_row5 = 1'b0; 
                Rd_En_row6 = 1'b0; 
                Rd_En_row7 = 1'b0; 
                Rd_En_row8 = 1'b0; 
                Rd_En_row9 = 1'b0; 
                Rd_En_row11 = 1'b0; 
                Rd_En_row12 = 1'b0; 
                Rd_En_row13 = 1'b0;
                Accum_InPsum_row0 = 1'b0; 
                Accum_InPsum_row1 = 1'b0; 
                Accum_InPsum_row2 = 1'b0; 
                Accum_InPsum_row3 = 1'b0; 
                Accum_InPsum_row4 = 1'b0; 
                Accum_InPsum_row5 = 1'b0; 
                Accum_InPsum_row6 = 1'b0; 
                Accum_InPsum_row7 = 1'b0; 
                Accum_InPsum_row8 = 1'b0; 
                Accum_InPsum_row9 = 1'b0; 
                Accum_InPsum_row10 = 1'b0; 
                Accum_InPsum_row11 = 1'b0; 
                Accum_InPsum_row12 = 1'b0; 
                Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
                Mux_select = 1'b0;
                DeMux_select = 1'b1;
                memory_addr = base_address + mem_counter;
                case (counter)
                'b000010: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b000011:begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b000100: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b000101: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b000110: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b000111: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b001000: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b001001: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b001010: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b001011: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b001100: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b001101: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b001110: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b001111: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b010000: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b010001: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b010010: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b010011: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b010100: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b010101: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b010110: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b010111: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b011000: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b011001: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b011010: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b011011: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b011100: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b011101: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b011110: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b011111: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b100000: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b100001: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b100010: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b100011: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b100100: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b100101: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b100110: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b100111: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b101000: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b101001: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b101010: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b101011: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b101100: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b101101: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b101110: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b101111: begin
                    Rd_En_row4 = 1'b1;  
                    Rd_En_row9 = 1'b1;
                end
                'b110000: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                'b110001: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                    memory_addr = base_address + mem_counter;
                end
                'b110010: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
                default: begin
                    Rd_En_row4 = 1'b0;  
                    Rd_En_row9 = 1'b0;
                end
            endcase
                

        end 
        default: begin
                Rd_En_row0 = 1'b0; 
                Rd_En_row1 = 1'b0; 
                Rd_En_row2 = 1'b0; 
                Rd_En_row3 = 1'b0; 
                Rd_En_row4 = 1'b0; 
                Rd_En_row5 = 1'b0; 
                Rd_En_row6 = 1'b0; 
                Rd_En_row7 = 1'b0; 
                Rd_En_row8 = 1'b0; 
                Rd_En_row9 = 1'b0; 
                Rd_En_row10 = 1'b0; 
                Rd_En_row11 = 1'b0; 
                Rd_En_row12 = 1'b0; 
                Rd_En_row13 = 1'b0;
                Accum_InPsum_row0 = 1'b0; 
                Accum_InPsum_row1 = 1'b0; 
                Accum_InPsum_row2 = 1'b0; 
                Accum_InPsum_row3 = 1'b0; 
                Accum_InPsum_row4 = 1'b0; 
                Accum_InPsum_row5 = 1'b0; 
                Accum_InPsum_row6 = 1'b0; 
                Accum_InPsum_row7 = 1'b0; 
                Accum_InPsum_row8 = 1'b0; 
                Accum_InPsum_row9 = 1'b0; 
                Accum_InPsum_row10 = 1'b0; 
                Accum_InPsum_row11 = 1'b0; 
                Accum_InPsum_row12 = 1'b0; 
                Accum_InPsum_row13 = 1'b0; 
                PE_Enable_1 = 1'b0; 
                PE_Enable_2 = 1'b0; 
                PE_Enable_3 = 1'b0; 
                PE_Enable_4 = 1'b0; 
                PE_Enable_5 = 1'b0; 
                PE_Enable_6 = 1'b0; 
                PE_Enable_7 = 1'b0; 
                PE_Enable_8 = 1'b0; 
                PE_Enable_9 = 1'b0; 
                PE_Enable_10 = 1'b0; 
                PE_Enable_11 = 1'b0; 
                PE_Enable_12 = 1'b0; 
                PE_Enable_13 = 1'b0;
                PE_Enable_14 = 1'b0;
                Mux_select = 1'b1;
                DeMux_select = 1'b0;
                memory_addr = 0;
                
        end
    endcase
end


/* Counter Logic */
always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
    counter <= 'b0; 
    end
    else
    begin
        if(  current_state==Idle ||
           ((current_state==Idle) && (next_state == done_row_0)) || 
           ((current_state==done_row_0) && (next_state == done_row_1)) ||
           ((current_state==done_row_1) && (next_state == done_row_2)) ||
           ((current_state==done_row_2) && (next_state == done_row_3)) ||
            ((current_state==done_row_3) && (next_state == write_mem)) 
               )

            counter <= 0;
        else
        begin
            if( ((current_state == done_row_0) || 
                 (current_state == done_row_1) ||
                 (current_state == done_row_2) ||
                 (current_state == done_row_3) ||
                 (current_state == write_mem)) 
                 && (counter > 'b110011))
                 
                counter <= 'b110100;
            else
                counter <= counter + 1;
        end
    end
end



/* Memory Write Logic */
/* always @(posedge clk or negedge rst) begin
    if (!rst) begin
        base_address <= 12'd0;
        mem_counter <= 4'd0;
    end 
    else if (current_state == write_mem) begin
        if ((mem_counter < 4'd15) && 
        ((counter == 1)||(counter==4)||(counter==7))) begin
            mem_counter <= mem_counter + 1'd1;
        end
        else begin
            if (base_address == 12'd3584 && counter == 'd48) begin  // 3584 = 3599 - 15
                base_address <= 12'd0;
            end
            else begin
                base_address <= base_address + 12'd16;
            end
        end
    end 
    else begin
        mem_counter <= 4'd0;
    end
end */

/* Memory Write Logic */
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        mem_counter <= 4'd0;
    end 
    else if (current_state == write_mem) begin
            if ((mem_counter < 4'd15) && 
                ( (counter=='d4)||(counter=='d7)||(counter=='d10)||
                (counter == 'd13)||(counter=='d16)||(counter=='d19)||(counter=='d22)||
                (counter == 'd25)||(counter=='d28)||(counter=='d31)||(counter=='d34)||
                (counter == 'd37)||(counter=='d40)||(counter=='d43)||(counter=='d46))) begin
                    mem_counter <= mem_counter + 1'd1;
                end
        end 
    else if(current_state == Idle)begin
        mem_counter <= 4'd0;
    end
end 

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        base_address <= 16'd0;
    end 
    else begin
        if (base_address == 16'd54000 && counter == 'd48) begin  // 3584 = 3599 - 15
            base_address <= 16'd0;
        end
        else if (current_state == write_mem && next_state == Idle) begin
            base_address <= base_address + 16'd16;
        end
    end
end


//after each write operation 
always @(posedge clk or negedge rst) begin
    if(!rst)
        ready <= 0;
    else 
    begin
        if((current_state==write_mem)  && (next_state == Idle))
            ready <= 1 ; 
        else    
            ready <=0 ;
    end

end


always @(*) begin
    if(!rst)
        glb_WrEn <= 0;
    else 
    begin
        if(current_state==write_mem)
            glb_WrEn <= 1 ; 
        else    
            glb_WrEn <=0 ;
    end

end




endmodule