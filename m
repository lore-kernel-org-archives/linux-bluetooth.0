Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Frank Mandarino <fmandarino@endrelia.com>
Date: Wed, 30 Aug 2006 11:45:37 -0400
Message-ID: <ed4br2$7t9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090109090706000003050604"
Subject: [Bluez-devel] [Patch] Reduce bccmd "Operation timed out" errors
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090109090706000003050604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marcel,

The attached bccmd patch reverses the order of processing the
PACKET_RECEIVED and PACKET_SENT activity bits returned by ubcsp_poll(),
to handle the case where both bits are set.  This condition occurs when
the received packet contains the acknowledgment for the previously sent
packet.  It happens quite often on my system, and results in an
"Operation timed out" error.

Currently, when both bits are set, the PACKET_RECEIVED bit is processed
first, and the received packet is ignored because it hasn't yet
processed the PACKET_SENT bit.  Then when the PACKET_SENT bit is
processed, it sets a flag to indicate that the next received packet will
contain the result, and the loop should be exited at that time.  Since
no further packets are received, the loop times out.

By reversing the order of processing, the packet sent flag gets set
before the PACKET_RECEIVED bit is processed, and the loop is exited.

After making this change, I haven't seen a single operation timed out error.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada

--------------090109090706000003050604
Content-Type: text/plain;
 name="csr_bcsp.c.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csr_bcsp.c.txt"

Index: utils/tools/csr_bcsp.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/csr_bcsp.c,v
retrieving revision 1.6
diff -u -r1.6 csr_bcsp.c
--- utils/tools/csr_bcsp.c	26 Jul 2006 13:32:45 -0000	1.6
+++ utils/tools/csr_bcsp.c	30 Aug 2006 15:06:56 -0000
@@ -188,19 +188,6 @@
 	while (1) {
 		delay = ubcsp_poll(&activity);
 
-		if (activity & UBCSP_PACKET_RECEIVED) {
-			if (sent && receive_packet.channel == 5 &&
-					receive_packet.payload[0] == 0xff) {
-				memcpy(rp, receive_packet.payload,
-							receive_packet.length);
-				break;
-			}
-
-			receive_packet.length = 512;
-			ubcsp_receive_packet(&receive_packet);
-			timeout = 0;
-		}
-
 		if (activity & UBCSP_PACKET_SENT) {
 			switch (varid) {
 			case CSR_VARID_COLD_RESET:
@@ -214,6 +201,19 @@
 			timeout = 0;
 		}
 
+		if (activity & UBCSP_PACKET_RECEIVED) {
+			if (sent && receive_packet.channel == 5 &&
+					receive_packet.payload[0] == 0xff) {
+				memcpy(rp, receive_packet.payload,
+							receive_packet.length);
+				break;
+			}
+
+			receive_packet.length = 512;
+			ubcsp_receive_packet(&receive_packet);
+			timeout = 0;
+		}
+
 		if (delay) {
 			usleep(delay * 100);
 

--------------090109090706000003050604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------090109090706000003050604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090109090706000003050604--
