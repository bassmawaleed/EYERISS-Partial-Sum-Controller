`timescale 1ns / 1ps

module Psum_control_unit_tb;

    // Parameters
    parameter CLOCK_PERIOD = 10;

    // Inputs
    reg clk_tb;
    reg rst_tb;
    reg row_0_done_tb;
    reg row_1_done_tb;
    reg row_2_done_tb;
    reg row_3_done_tb;
    reg row_4_done_tb;

    // Outputs
    wire Rd_En_row0_tb;
    wire Rd_En_row1_tb;
    wire Rd_En_row2_tb;
    wire Rd_En_row3_tb;
    wire Rd_En_row4_tb;
    wire Rd_En_row5_tb;
    wire Rd_En_row6_tb;
    wire Rd_En_row7_tb;
    wire Rd_En_row8_tb;
    wire Rd_En_row9_tb;
    wire Rd_En_row10_tb;
    wire Rd_En_row11_tb;
    wire Rd_En_row12_tb;
    wire Rd_En_row13_tb;
    wire Accum_InPsum_row0_tb;
    wire Accum_InPsum_row1_tb;
    wire Accum_InPsum_row2_tb;
    wire Accum_InPsum_row3_tb;
    wire Accum_InPsum_row4_tb;
    wire Accum_InPsum_row5_tb;
    wire Accum_InPsum_row6_tb;
    wire Accum_InPsum_row7_tb;
    wire Accum_InPsum_row8_tb;
    wire Accum_InPsum_row9_tb;
    wire Accum_InPsum_row10_tb;
    wire Accum_InPsum_row11_tb;
    wire Accum_InPsum_row12_tb;
    wire Accum_InPsum_row13_tb;
    wire PE_Enable_1_tb;
    wire PE_Enable_2_tb;
    wire PE_Enable_3_tb;
    wire PE_Enable_4_tb;
    wire PE_Enable_5_tb;
    wire PE_Enable_6_tb;
    wire PE_Enable_7_tb;
    wire PE_Enable_8_tb;
    wire PE_Enable_9_tb;
    wire PE_Enable_10_tb;
    wire PE_Enable_11_tb;
    wire PE_Enable_12_tb;
    wire PE_Enable_13_tb;
    wire Mux_select_tb;
    wire DeMux_select_tb;
    wire [15:0] memory_addr_tb;
    wire ready_tb;
    wire glb_WrEn_tb;

    integer i;
    // Instantiate the Unit Under Test (UUT)
    Psum_control_unit uut (
        .clk(clk_tb), 
        .rst(rst_tb),
        .row_0_done(row_0_done_tb),
        .row_1_done(row_1_done_tb),
        .row_2_done(row_2_done_tb),
        .row_3_done(row_3_done_tb),
        .row_4_done(row_4_done_tb),
        .Rd_En_row0(Rd_En_row0_tb), 
        .Rd_En_row1(Rd_En_row1_tb), 
        .Rd_En_row2(Rd_En_row2_tb), 
        .Rd_En_row3(Rd_En_row3_tb), 
        .Rd_En_row4(Rd_En_row4_tb), 
        .Rd_En_row5(Rd_En_row5_tb), 
        .Rd_En_row6(Rd_En_row6_tb), 
        .Rd_En_row7(Rd_En_row7_tb), 
        .Rd_En_row8(Rd_En_row8_tb), 
        .Rd_En_row9(Rd_En_row9_tb), 
        .Rd_En_row10(Rd_En_row10_tb), 
        .Rd_En_row11(Rd_En_row11_tb), 
        .Rd_En_row12(Rd_En_row12_tb), 
        .Rd_En_row13(Rd_En_row13_tb), 
        .Accum_InPsum_row0(Accum_InPsum_row0_tb), 
        .Accum_InPsum_row1(Accum_InPsum_row1_tb), 
        .Accum_InPsum_row2(Accum_InPsum_row2_tb), 
        .Accum_InPsum_row3(Accum_InPsum_row3_tb), 
        .Accum_InPsum_row4(Accum_InPsum_row4_tb), 
        .Accum_InPsum_row5(Accum_InPsum_row5_tb), 
        .Accum_InPsum_row6(Accum_InPsum_row6_tb), 
        .Accum_InPsum_row7(Accum_InPsum_row7_tb), 
        .Accum_InPsum_row8(Accum_InPsum_row8_tb), 
        .Accum_InPsum_row9(Accum_InPsum_row9_tb), 
        .Accum_InPsum_row10(Accum_InPsum_row10_tb), 
        .Accum_InPsum_row11(Accum_InPsum_row11_tb), 
        .Accum_InPsum_row12(Accum_InPsum_row12_tb), 
        .Accum_InPsum_row13(Accum_InPsum_row13_tb), 
        .PE_Enable_1(PE_Enable_1_tb), 
        .PE_Enable_2(PE_Enable_2_tb), 
        .PE_Enable_3(PE_Enable_3_tb), 
        .PE_Enable_4(PE_Enable_4_tb), 
        .PE_Enable_5(PE_Enable_5_tb), 
        .PE_Enable_6(PE_Enable_6_tb), 
        .PE_Enable_7(PE_Enable_7_tb), 
        .PE_Enable_8(PE_Enable_8_tb), 
        .PE_Enable_9(PE_Enable_9_tb), 
        .PE_Enable_10(PE_Enable_10_tb), 
        .PE_Enable_11(PE_Enable_11_tb), 
        .PE_Enable_12(PE_Enable_12_tb), 
        .PE_Enable_13(PE_Enable_13_tb), 
        .PE_Enable_14(PE_Enable_14_tb),
        .Mux_select(Mux_select_tb), 
        .DeMux_select(DeMux_select_tb),
        .memory_addr(memory_addr_tb),
        .glb_WrEn(glb_WrEn_tb),
        .ready(ready_tb)
    );

    // Clock generation
    always begin
        #(CLOCK_PERIOD / 2) clk_tb = ~clk_tb;
    end

    // Task to initialize inputs
    task initialize;
    begin
        clk_tb = 0;
        rst_tb = 0;
        row_0_done_tb = 0;
        row_1_done_tb = 0;
        row_2_done_tb = 0;
        row_3_done_tb = 0;
        row_4_done_tb = 0;
    end
    endtask

    // Task to apply reset
    task apply_reset;
    begin
        rst_tb = 1;
        #(CLOCK_PERIOD/2);
        rst_tb = 0;
        #(CLOCK_PERIOD/2);
        rst_tb = 1;
    end
    endtask

    // Task to test row done signals
    task test_row_done;
    input [4:0] row_done_signals;
    begin
        row_0_done_tb = row_done_signals[0];
        row_1_done_tb = row_done_signals[1];
        row_2_done_tb = row_done_signals[2];
        row_3_done_tb = row_done_signals[3];
        row_4_done_tb = row_done_signals[4];
        #(CLOCK_PERIOD);
        row_0_done_tb = 0;
        row_1_done_tb = 0;
        row_2_done_tb = 0;
        row_3_done_tb = 0;
        row_4_done_tb = 0;
    end
    endtask

    // Stimulus block
    initial begin
        // Initialize Inputs
        initialize;
        
        // Apply reset
        apply_reset;


    for(i = 0; i < 229; i = i + 'b1) begin
        
        test_row_done(5'b00001);
        #(100*CLOCK_PERIOD);

        // Test case 3: Rows 1 done
        test_row_done(5'b00010);
        #(100*CLOCK_PERIOD);

        // Test case 4: Rows 2 done
        test_row_done(5'b00100);
        #(100*CLOCK_PERIOD);
        
        // Test case 5: Rows 3 done
        test_row_done(5'b01000);
        #(100*CLOCK_PERIOD);

        // Test case 6: Rows 1 done
        test_row_done(5'b10000);
        #(100*CLOCK_PERIOD);
    end

    

        


        // End simulation
        $stop;
    end
      
endmodule
