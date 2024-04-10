// ----------------------------------------------------------------------------
// Project:     Lab_1
// Module:      count4
// Description: 
// Author:      Wang Mingjie
// Student ID:  21003160314
// Date:        2024/03/07
// ----------------------------------------------------------------------------

module count4 ( clk,reset,clr,ld,init,out );
input           clk     ;
input           reset   ;
input           clr     ;
input           ld      ;
input   [3:0]   init    ;
output	[3:0]	out     ;

reg	[3:0]   out;

always@(posedge clk or posedge reset) begin
    if(reset) 
        out <= 0;
    else if(clr)
        out <= 0;
    else if(ld)
        out <= init;
    else
        out <= out + 1;
end

endmodule 