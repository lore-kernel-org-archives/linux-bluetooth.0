Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40397111.7000903@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------030600010902000106000509"
Subject: [Bluez-devel] [PATCH] Fix some bugs in hcidump.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 Feb 2004 03:18:41 +0000

This is a multi-part message in MIME format.
--------------030600010902000106000509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch to apply to bluez-hcidump-1.5/parser/sdp.c

It fixes some of the printout.

Cheers
James

--------------030600010902000106000509
Content-Type: text/x-patch;
 name="sdp.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdp.c.diff"

--- sdp.c.org	2004-02-23 02:56:03.667767736 +0000
+++ sdp.c	2004-02-23 03:15:48.787602136 +0000
@@ -324,6 +324,7 @@
 	printf("pat");
 
 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
+	        len = frm->len;
 		while (len - frm->len < n1 ) {
 			if (parse_de_hdr(frm,&n2) == SDP_DE_UUID) {
 				print_uuid(n2, frm);
@@ -351,7 +352,8 @@
 	printf("aid(s)");
 
 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
-		while (len - frm->len <= n1 ) {
+                len = frm->len;
+		while (len - frm->len < n1 ) {
 			/* Print AttributeID */
 			if (parse_de_hdr(frm, &n2) == SDP_DE_UINT) {
 				switch(n2) {
@@ -367,13 +369,13 @@
 					break;
 				}
 			} else {
-				printf("\nERROR: Unexpected syntax\n");
+				printf("\nERROR: Unexpected syntax: (aid)\n");
 				raw_dump(level, frm);
 			}
 		}
 		printf("\n");
 	} else {
-		printf("\nERROR: Unexpected syntax\n");
+		printf("\nERROR: Unexpected syntax: (aid)\n");
 		raw_dump(level, frm);
 	}
 }
@@ -385,6 +387,7 @@
 	int   len = frm->len;
 
 	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
+	        len = frm->len;
 		while (len - frm->len < n1 ) {
 			/* Print AttributeID */
 			if ((parse_de_hdr(frm, &n2) == SDP_DE_UINT) &&
@@ -426,7 +429,7 @@
 	int   cnt = 0;
 
 	if (parse_de_hdr(frm, &n) == SDP_DE_SEQ) {
-	printf(" len 0x%x frm->len 0x%x n 0x%x\n", len, frm->len, n);
+	        len = frm->len;
 		while (len - frm->len < n ) {
 			p_indent(level, 0);
 			printf("srv rec #%d\n", cnt++);

--------------030600010902000106000509--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
