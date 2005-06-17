Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Bastien Nocera <hadess@hadess.net>
Message-ID: <loom.20050617T115730-392@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] GCC-4 Patch for btsco
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 17 Jun 2005 10:05:08 +0000 (UTC)

Heya,

As it looks like the btsco people hang out here, I posted a patch earlier this
week on the sourceforce page.

The patch is at:
http://makeashorterlink.com/?A3F66174B

- Fixes "argument differ in signedness issues"
- Fix hci_switch_role expecting a bdaddr_t as the second argument (not a
"bdaddr_t *")
- Fix compilation with 2.6 kernels where
/lib/modules/<kernel-version>/build is a symlink to the necessary headers to
compile a kernel module

Cheers

PS: Please CC: me on the answers as I'm not subscribed to the list.

Index: a2play.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2play.c,v
retrieving revision 1.80
diff -u -r1.80 a2play.c
--- a2play.c	4 Jun 2005 07:41:29 -0000	1.80
+++ a2play.c	15 Jun 2005 09:16:30 -0000
@@ -278,7 +278,8 @@
 {
 	struct sockaddr_l2 addr;
 	struct l2cap_options opts;
-	int sk, opt;
+	int sk;
+	unsigned int opt;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sk < 0) {
Index: a2recv.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2recv.c,v
retrieving revision 1.13
diff -u -r1.13 a2recv.c
--- a2recv.c	11 May 2005 15:17:07 -0000	1.13
+++ a2recv.c	15 Jun 2005 09:16:31 -0000
@@ -152,9 +152,8 @@
 {
 	struct sockaddr_l2 addr;
 	struct l2cap_options opts;
-	
 	int sk;
-	int opt;
+	unsigned int opt;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sk < 0) {
@@ -205,8 +204,8 @@
 	struct l2cap_options opts;
 	socklen_t addrlen;
 	int nsk;
-	int opt;
-	
+	unsigned int opt;
+
 	memset(&addr, 0, sizeof(addr));
 	addrlen = sizeof(addr);
 
@@ -278,7 +277,7 @@
 		return;
         }
 
-        if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
+        if (hci_switch_role(dd, bdaddr, role, 10000) < 0) {
                 perror("Switch role request failed");
         }
 
Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/btsco.c,v
retrieving revision 1.27
diff -u -r1.27 btsco.c
--- btsco.c	24 May 2005 13:34:17 -0000	1.27
+++ btsco.c	15 Jun 2005 09:16:32 -0000
@@ -139,7 +139,8 @@
 	struct sockaddr_sco addr;
 	struct sco_conninfo conn;
 	struct sco_options opts;
-	int s, size;
+	int s;
+	unsigned int size;
 
 	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) {
 		return -1;
@@ -443,7 +444,7 @@
 	struct sigaction sa;
 
 	//struct timeval timeout;
-	unsigned char buf[2048];
+	char buf[2048];
 	//int sel, rlen, wlen;
 	int rlen, wlen;
 
@@ -640,7 +641,7 @@
 			perror("poll");
 			sleep(1); /* Don't steal the CPU in case of non-transient errors. */
 		} else if (ret > 0) {
-			short revents;
+			unsigned short revents;
 
 			/*printf("inner loop\n"); */
 			/* Volume polling (sound card) */
Index: btsco2.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/btsco2.c,v
retrieving revision 1.2
diff -u -r1.2 btsco2.c
--- btsco2.c	21 Feb 2005 16:52:43 -0000	1.2
+++ btsco2.c	15 Jun 2005 09:16:33 -0000
@@ -377,7 +377,7 @@
 
 static int headset_from_bt(struct s_headset *headset)
 {
-	unsigned char buf[2048];
+	char buf[2048];
 	int rlen;
 	int opdone;
 	
@@ -535,7 +535,7 @@
 
 	/* we are not yet connected */
 	while (!terminate) {
-		short revents;
+		unsigned short revents;
 		int nfds;
 		nfds = 0;
 		/* set up data polling description */
Index: kernel/Makefile
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/kernel/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- kernel/Makefile	23 Jan 2005 06:23:02 -0000	1.3
+++ kernel/Makefile	15 Jun 2005 09:16:33 -0000
@@ -10,10 +10,10 @@
 
 
 default:
-	@make -C /lib/modules/`uname -r`/source M=`pwd` modules
+	@make -C /lib/modules/`uname -r`/build M=`pwd` modules
 
 install:
-	@make -C /lib/modules/`uname -r`/source M=`pwd` modules_install
+	@make -C /lib/modules/`uname -r`/build M=`pwd` modules_install
 
 clean:
-	@make -C /lib/modules/`uname -r`/source M=`pwd` clean
+	@make -C /lib/modules/`uname -r`/build M=`pwd` clean




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
