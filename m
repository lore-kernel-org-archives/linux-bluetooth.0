Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Bastien Nocera <hadess@hadess.net>
Message-ID: <loom.20050617T124909-183@post.gmane.org>
References: <loom.20050617T115730-392@post.gmane.org> <1119003833.8980.116.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: GCC-4 Patch for btsco
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
Date: Fri, 17 Jun 2005 10:51:07 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

Hey Marcel,

> Hi Bastien,
> 
> > - Fix hci_switch_role expecting a bdaddr_t as the second argument (not a
> > "bdaddr_t *")
> 
> this was a bug in the earlier library versions. The correct argument is
> a "bdaddr_t *" as for all other functions.

I believe you mean that there was a bug in the headers. In which version of the
bluez-libs was this fixed?

Slightly updated patch attached, we would want to require a newer version of
bluez-libs in the configure.

Index: a2play.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2play.c,v
retrieving revision 1.80
diff -u -p -r1.80 a2play.c
--- a2play.c	4 Jun 2005 07:41:29 -0000	1.80
+++ a2play.c	17 Jun 2005 10:53:12 -0000
@@ -278,7 +278,8 @@ static int do_connect(bdaddr_t *src, bda
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
diff -u -p -r1.13 a2recv.c
--- a2recv.c	11 May 2005 15:17:07 -0000	1.13
+++ a2recv.c	17 Jun 2005 10:53:13 -0000
@@ -152,9 +152,8 @@ static int do_listen(bdaddr_t *src, unsi
 {
 	struct sockaddr_l2 addr;
 	struct l2cap_options opts;
-	
 	int sk;
-	int opt;
+	unsigned int opt;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sk < 0) {
@@ -205,8 +204,8 @@ static int do_accept(int serverfd, bdadd
 	struct l2cap_options opts;
 	socklen_t addrlen;
 	int nsk;
-	int opt;
-	
+	unsigned int opt;
+
 	memset(&addr, 0, sizeof(addr));
 	addrlen = sizeof(addr);
 
@@ -278,6 +277,9 @@ static void make_master(bdaddr_t bdaddr)
 		return;
         }
 
+	/* Older versions of bluez-libs got the second argument
+	 * wrong, hci_switch_role is expecting a pointer to
+	 * a bdaddr_t */
         if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
                 perror("Switch role request failed");
         }
Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/btsco.c,v
retrieving revision 1.27
diff -u -p -r1.27 btsco.c
--- btsco.c	24 May 2005 13:34:17 -0000	1.27
+++ btsco.c	17 Jun 2005 10:53:14 -0000
@@ -139,7 +139,8 @@ static int sco_connect(bdaddr_t * src, b
 	struct sockaddr_sco addr;
 	struct sco_conninfo conn;
 	struct sco_options opts;
-	int s, size;
+	int s;
+	unsigned int size;
 
 	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) {
 		return -1;
@@ -443,7 +444,7 @@ int main(int argc, char *argv[])
 	struct sigaction sa;
 
 	//struct timeval timeout;
-	unsigned char buf[2048];
+	char buf[2048];
 	//int sel, rlen, wlen;
 	int rlen, wlen;
 
@@ -640,7 +641,7 @@ int main(int argc, char *argv[])
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
diff -u -p -r1.2 btsco2.c
--- btsco2.c	21 Feb 2005 16:52:43 -0000	1.2
+++ btsco2.c	17 Jun 2005 10:53:14 -0000
@@ -377,7 +377,7 @@ static int headset_micro(struct s_headse
 
 static int headset_from_bt(struct s_headset *headset)
 {
-	unsigned char buf[2048];
+	char buf[2048];
 	int rlen;
 	int opdone;
 	
@@ -535,7 +535,7 @@ int main(int argc, char *argv[])
 
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
diff -u -p -r1.3 Makefile
--- kernel/Makefile	23 Jan 2005 06:23:02 -0000	1.3
+++ kernel/Makefile	17 Jun 2005 10:53:15 -0000
@@ -10,10 +10,10 @@ endif
 
 
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
