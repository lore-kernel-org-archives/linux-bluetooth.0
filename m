Return-Path: <James@superbug.demon.co.uk>
Message-ID: <403A02FA.60008@superbug.demon.co.uk>
Date: Mon, 23 Feb 2004 13:41:14 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix some bugs in hcidump.
References: <40397111.7000903@superbug.demon.co.uk> <1077522140.2832.70.camel@pegasus>
In-Reply-To: <1077522140.2832.70.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>Attached is a patch to apply to bluez-hcidump-1.5/parser/sdp.c
>>
>>It fixes some of the printout.
> 
> 
> please always do the diff againts the CVS version.
> 
> 
>>--- sdp.c.org	2004-02-23 02:56:03.667767736 +0000
>>+++ sdp.c	2004-02-23 03:15:48.787602136 +0000
>>@@ -324,6 +324,7 @@
>> 	printf("pat");
>> 
>> 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
>>+	        len = frm->len;
>> 		while (len - frm->len < n1 ) {
>> 			if (parse_de_hdr(frm,&n2) == SDP_DE_UUID) {
>> 				print_uuid(n2, frm);
> 
> 
> Your change means this
> 
> 		while (n1 > 0) {
> 			...
> 		}
> 
> If this is what you want then do it this way and remove unneeded
> variables. Give me a short description what this changes do and why you
> did this change.
> 
> Regards
> 
> Marcel
> 
> 

while (len - frm->len < n1)
is NOT the same as
while (n1 > 0)

Each call to parse_de_hdr and print_uuid changes the value of frm->len.
So, each time round the while loop (len - frm->len) becomes larger.

The n1 value is set by the previous line
"if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {"

This means we have n1 bytes of data we wish to parse inside the while loop.
So, we want to start the while loop with (len - frm->len) == 0
Each time round the loop (len - frm->len) will increase( due to calls to 
parse_de_hdr and print_uuid) , and the loop will exit when (len - 
frm->len) >= n1, which is what we want.

If we fail to set "len = frm->len;" just before the while loop, the 
previous line
"if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {"
changes frm->len, so the "int len = frm->len;" at the beginning of the 
function is no longer correct.
I.E. len != frm->len after the "if (parse_de_hdr(frm, &n1) == 
SDP_DE_SEQ) {" statement.

I hope this explanation is clear.

Do you want me to resubmit the patch as a "cvs -u diff" ?

Cheers
James
