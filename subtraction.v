module subtraction(input [31:0]in1,
					input [31:0]in2,
					output [31:0]s,
					output overflow);
	
	wire [31:0]re2;
	wire [32:0]c;
	
	wire res31;
	wire rein1_31;
	
	wire [3:0]ofc;
	
	//subtraction
	not resB(re2[0], in2[0]);//reverse input2
	fadder sub0(in1[0], re2[0], 1, c[0], s[0]); // first adder to get the first carry
	
	genvar i; //generate counter
	generate // full adders for 1 to 31 bit.
		for(i = 1; i <= 31; i = i + 1) begin : sub_loop
			not res_in2(re2[i], in2[i]);//reverse input2
			fadder sub1_31(in1[i], re2[i], c[i-1], c[i], s[i]);
		end
	endgenerate
	
	//check sub overflow = in1[31]&in2reverse[31]&sreverse[31] + in1reverse[31]&in2[31]&s[31]
	not re_s_31(res31, s[31]);
	not re_in1_31(rein1_31, in1[31]);
	
	and of1(ofc[0], in1[31], re2[31]);
	and of2(ofc[1], ofc[0], res31);
	and of3(ofc[2], rein1_31, in2[31]);
	and of4(ofc[3], ofc[2], s[31]);
	or ofr(overflow, ofc[1], ofc[3]);
	
endmodule
