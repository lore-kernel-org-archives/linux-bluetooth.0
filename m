Return-Path: <James@superbug.demon.co.uk>
Message-ID: <403A1693.1060909@superbug.demon.co.uk>
Date: Mon, 23 Feb 2004 15:04:51 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix some bugs in hcidump.
References: <40397111.7000903@superbug.demon.co.uk>	 <1077522140.2832.70.camel@pegasus>  <403A02FA.60008@superbug.demon.co.uk> <1077545085.13454.1.camel@pegasus>
In-Reply-To: <1077545085.13454.1.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------050906070401060300050803"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050906070401060300050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
>>Do you want me to resubmit the patch as a "cvs -u diff" ?
> 
> 
> yes. And please remove the initial assignment of len.
> 
> Regards
> 
> Marcel
> 
> 
See attached patch.
I have also added some extra checks so that the while loops will not go 
mad if there is a badly formed packet. I.E. n,n1,n2 get given bad values.

Cheers
James



--------------050906070401060300050803
Content-Type: text/x-patch;
 name="hcidump-fix-sdp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump-fix-sdp.patch"

Index: hcidump/parser/sdp.c
===================================================================
RCS file: /cvsroot/bluez/hcidump/parser/sdp.c,v
retrieving revision 1.22
diff -u -r1.22 sdp.c
--- hcidump/parser/sdp.c	1 Sep 2003 15:09:06 -0000	1.22
+++ hcidump/parser/sdp.c	23 Feb 2004 14:44:00 -0000
@@ -279,7 +279,7 @@
 static inline void print_des(uint8_t de_type, int level, int n, struct frame *frm, int *split)
 {
 	int len = frm->len;
-	while (len - frm->len < n )
+	while ( (len - frm->len < n) && (frm->len > 0) ) 
 		print_de(level, frm, split);
 }
 
@@ -328,7 +328,7 @@
 
 static inline void print_srv_srch_pat(int level, struct frame *frm)
 {
-	int len = frm->len;
+	int len;
 	int n1;
 	int n2;
 
@@ -336,7 +336,8 @@
 	printf("pat");
 
 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
-		while (len - frm->len <= n1 ) {
+	        len = frm->len;
+		while ( (len - frm->len < n1) && (frm->len > 0) ) {
 			if (parse_de_hdr(frm,&n2) == SDP_DE_UUID) {
 				print_uuid(n2, frm);
 			} else {
@@ -356,14 +357,15 @@
 {
 	uint16_t attr_id;
 	uint32_t attr_id_range;
-	int len = frm->len;
+	int len;
 	int n1, n2;
 
 	p_indent(level, frm);
 	printf("aid(s)");
 
 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
-		while (len - frm->len <= n1 ) {
+	        len = frm->len;
+		while ( (len - frm->len < n1) && (frm->len > 0) ) {
 			/* Print AttributeID */
 			if (parse_de_hdr(frm, &n2) == SDP_DE_UINT) {
 				char *name;
@@ -398,10 +400,11 @@
 {
 	uint16_t attr_id;
 	int   n1, n2, split;
-	int   len = frm->len;
+	int   len;
 
 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
-		while (len - frm->len < n1 ) {
+	        len = frm->len;
+		while ( (len - frm->len < n1) && (frm->len > 0) ) {
 			/* Print AttributeID */
 			if (parse_de_hdr(frm, &n2) == SDP_DE_UINT && n2 == sizeof(attr_id)) {
 				char *name;
@@ -437,8 +440,7 @@
 	int   cnt = 0;
 
 	if (parse_de_hdr(frm, &n) == SDP_DE_SEQ) {
-//	printf(" len 0x%x frm->len 0x%x n 0x%x\n", len, frm->len, n);
-		while (len - frm->len < n ) {
+		while ( (len - frm->len < n) && (frm->len > 0) ) {
 			p_indent(level, 0);
 			printf("srv rec #%d\n", cnt++);
 			print_attr_list(level+1, frm);

--------------050906070401060300050803--
