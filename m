Return-Path: <ohad@bencohen.org>
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH bluez-utils] add random delays to l2test
MIME-Version: 1.0
Date: Sun, 6 May 2007 10:31:38 -0400
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705061031.38762.ohad@bencohen.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Add random delays to l2test.
Useful for stress tests.

The patch is against the current CVS tree of bluez-utils.

---
 test/l2test.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 test/l2test.c

diff --git a/test/l2test.c b/test/l2test.c
old mode 100644
new mode 100755
index 733c052..08745f1
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -84,6 +84,9 @@ static int count = 1;
 /* Default delay after sending count number of frames */
 static unsigned long delay = 0;
 
+/* Default delay random switch  (0 is off, else is on) */
+static int random_delay = 0;
+
 static char *filename = NULL;
 
 static int flowctl = 0;
@@ -580,10 +583,16 @@ static void recv_mode(int sk)
 	}
 }
 
+static double double_random(void)
+{
+	return ((double)rand())/((double)RAND_MAX);
+}
+
 static void do_send(int sk)
 {
 	uint32_t seq;
 	int i, fd, len;
+	unsigned long tmp_delay;
 
 	syslog(LOG_INFO, "Sending ...");
 
@@ -615,8 +624,10 @@ static void do_send(int sk)
 			exit(1);
 		}
 
-		if (num_frames && delay && count && !(seq % count))
-			usleep(delay);
+		if (num_frames && delay && count && !(seq % count)) {
+			tmp_delay = random_delay?delay*double_random():delay;
+			usleep(tmp_delay);
+		}
 	}
 }
 
@@ -814,6 +825,7 @@ static void usage(void)
 		"\t[-N num] send num frames (default = infinite)\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
+		"\t[-Z] random delay between 0 to the value that is set using -D\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-F] enable flow control\n"
@@ -830,7 +842,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnxyzb:i:P:I:O:B:N:L:C:D:RGFAESM")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnxyzb:i:P:I:O:B:N:L:C:D:ZRGFAESM")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -953,6 +965,10 @@ int main(int argc, char *argv[])
 			socktype = SOCK_DGRAM;
 			break;
 
+		case 'Z':
+			random_delay = 1;
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.5.0.6
