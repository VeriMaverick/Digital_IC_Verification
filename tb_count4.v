// ----------------------------------------------------------------------------
// Project:     Lab_1
// Module:      tb_count4
// Description: This is the testbench for the "count4.v" module.
// Author:      Wang Mingjie
// Student ID:  21003160314
// Date:        2024/03/08
// Version:     v2.1
// ----------------------------------------------------------------------------

`timescale 1ns/1ns
module tb_count4(); 
reg             clk;
reg             reset;
reg             clr;
reg             ld;
reg     [3:0]   init;

wire    [3:0]   out;

reg             clr_reg;
reg             ld_reg;
reg     [3:0]   init_reg;  

// Instantiate the Unit Under Test (UUT)
count4 count4(
    .clk	( clk   )   ,
    .reset	( reset )   ,
    .clr	( clr   )   ,
    .ld		( ld    )   ,
    .init	( init  )   ,
    .out	( out   )
);

// Clock cycle parameter
parameter CYCLE = 10;

integer file;

// Clock generation
initial begin
    clk = 0;
    forever begin
        #(CYCLE/2);
        clk = 1;
        #(CYCLE/2);
        clk = 0;
    end
end

// Reset generation
initial begin
    reset = 1;
    #(5*CYCLE)
    reset = 0;
end 

// 
always @(posedge clk) begin
    clr_reg     <= clr;
    ld_reg      <= ld;
    init_reg    <= init;
end



// Write the output to the file
always @(posedge clk) begin
    $fwrite(file, "Time: %d, clr: %d, ld: %d, init: %d, out: %d\n", $time, clr_reg, ld_reg, init_reg, out);
end

initial begin
    $display($time,"sim start!!!");

    // Open the output file
    file = $fopen("output.txt", "w"); 

    // Initialize Inputs
    ld          = 0;
    init        = 0;
    clr         = 0;

    // Initialize the register
    ld_reg      = 0;
    init_reg    = 0;
    clr_reg     = 0;

    // Wait for reset release
    @(negedge reset);  

    // Test case1 :The clr signal has 1 cycle
    clr = 1;
    #(CYCLE);
    clr = 0;
    #(CYCLE);           // Wait for 1 cycle

    // Test case2 :The clr signal has 2 cycle
    clr = 1;
    #(2*CYCLE);
    clr = 0;
    #(CYCLE);           // Wait for 1 cycle

    // Test case3 :The clr signal has 1ns
    clr = 1;
    #1;
    clr = 0;
    #9;
    #(CYCLE);           // Wait for 1 cycle

    // Test case4 :The ld signal has 1 cycle
    ld      = 1;
    init    = 4'd5;
    #(CYCLE);
    ld      = 0;
    init    = 4'd7;
    #(CYCLE);           // Wait for 1 cycle

    // Test case5 :The ld signal has 2 cycle
    ld      = 1;
    init    = 4'd5;
    #(CYCLE);
    init    = 4'd8;
    #(CYCLE);
    ld      = 0;
    init    = 4'd7;
    #(CYCLE);           // Wait for 1 cycle

    // Test case6 :The ld signal has 1ns
    ld      = 1;
    init    = 4'd5;
    #1;
    ld      = 0;
    #9;
    init    =4'd7;
    #(CYCLE);           // Wait for 1 cycle

    // Test case7 :
    ld      = 1;
    init    = 4'd0;
    #(CYCLE);
    ld      = 0;
    init    = 4'd7;
    #(CYCLE);           // Wait for 1 cycle

    // Test case8 : 
    ld      = 1;
    init    = 4'd15;
    #(CYCLE);
    ld      = 0;
    init    = 4'd7; 
    #(2*CYCLE);           // Wait for 1 cycle 

    // Test case9 :
    clr     = 1;
    ld      = 1;
    init    = 4'd5;
    #(CYCLE);
    clr     = 0;
    ld      = 0;
    init    = 4'd7;

    #(10*CYCLE);        // Wait for 10 cycle	
    
    $fclose(file);      // Close the output file
    $display($time,"sim end!!!");
    $finish;            // End the simulation
end

endmodule 