Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH] Bluetooth : Added more testing options to l2test
Date: Tue, 19 Jul 2011 16:09:11 +0300
Message-Id: <1311080951-15820-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Added more options to allow passing ERTM L2CAP PTS tests. The 
options allow to delay between a connection is made and the 
first sent frame,a delay between the last sent frame and 
disocnnection,and the ability to run as "one-shot" instead of
listening for more connections.

Signed-off-by: Chen Ganir <chen.ganir@ti.com>
---
 test/l2test.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 3ac332f..965e3ce 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -98,6 +98,11 @@ static int count = 1;
 
 /* Default delay after sending count number of frames */
 static unsigned long delay = 0;
+static unsigned long delay_before_first_frame = 0;
+static unsigned long delay_after_last_frame = 0;
+
+/* Default operation mode */
+static int one_time = 0;
 
 static char *filename = NULL;
 
@@ -462,13 +467,19 @@ static void do_listen(void (*handler)(int sk))
 							strerror(errno), errno);
 			goto error;
 		}
-		if (fork()) {
-			/* Parent */
-			close(nsk);
-			continue;
+
+		if (one_time == 0) {
+			if (fork()) {
+				/* Parent */
+				close(nsk);
+				continue;
+			}
+			/* Child */
+			close(sk);
+		}
+		else {
+			close(sk);
 		}
-		/* Child */
-		close(sk);
 
 		/* Get current options */
 		memset(&opts, 0, sizeof(opts));
@@ -754,6 +765,7 @@ static void do_send(int sk)
 	}
 
 	seq = 0;
+	sleep(delay_before_first_frame);
 	while ((num_frames == -1) || (num_frames-- > 0)) {
 		*(uint32_t *) buf = htobl(seq);
 		*(uint16_t *) (buf + 4) = htobs(data_size);
@@ -778,6 +790,7 @@ static void do_send(int sk)
 		if (num_frames && delay && count && !(seq % count))
 			usleep(delay);
 	}
+	sleep(delay_after_last_frame);
 }
 
 static void send_mode(int sk)
@@ -1094,7 +1107,10 @@ static void usage(void)
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
 		"\t[-M] become master\n"
-		"\t[-T] enable timestamps\n");
+		"\t[-T] enable timestamps\n"
+		"\t[-H seconds] Delay before first sent frame (default = 0)\n"
+		"\t[-K seconds] Delay after last sent frame, before disconnection (default = 0)\n"
+		"\t[-Y] One time only (do not listen for more incoming connections)");
 }
 
 int main(int argc, char *argv[])
@@ -1104,7 +1120,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:H:K:RUGAESMTY")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1174,6 +1190,14 @@ int main(int argc, char *argv[])
 			data_size = atoi(optarg);
 			break;
 
+		case 'H':
+			delay_before_first_frame = atoi(optarg);
+			break;
+
+		case 'K':
+			delay_after_last_frame = atoi(optarg);
+			break;
+
 		case 'i':
 			if (!strncasecmp(optarg, "hci", 3))
 				hci_devba(atoi(optarg + 3), &bdaddr);
@@ -1272,6 +1296,10 @@ int main(int argc, char *argv[])
 			cid = atoi(optarg);
 			break;
 
+		case 'Y':
+			one_time = 1;
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.7.4.1

