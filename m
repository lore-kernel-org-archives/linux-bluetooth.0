Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] l2test: Add option 'K' to set delay before receiving
Date: Thu, 5 Jan 2012 10:23:39 +0100
Message-ID: <1325755419-6157-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1325755419-6157-1-git-send-email-szymon.janc@tieto.com>
References: <1325755419-6157-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 35f8ce3..c5bc3d3 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -97,7 +97,10 @@ static int num_frames = -1;
 static int count = 1;
 
 /* Default delay after sending count number of frames */
-static unsigned long delay = 0;
+static unsigned long send_delay = 0;
+
+/* Default delay before receiving */
+static unsigned long recv_delay = 0;
 
 static char *filename = NULL;
 
@@ -722,6 +725,9 @@ static void recv_mode(int sk)
 			syslog(LOG_INFO, "Initial bytes %d", len);
 	}
 
+	if (recv_delay)
+		usleep(recv_delay);
+
 	syslog(LOG_INFO, "Receiving ...");
 
 	memset(ts, 0, sizeof(ts));
@@ -865,8 +871,8 @@ static void do_send(int sk)
 			size -= len;
 		}
 
-		if (num_frames && delay && count && !(seq % count))
-			usleep(delay);
+		if (num_frames && send_delay && count && !(seq % count))
+			usleep(send_delay);
 	}
 }
 
@@ -1173,6 +1179,7 @@ static void usage(void)
 		"\t[-N num] send num frames (default = infinite)\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
+		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
@@ -1196,7 +1203,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1306,7 +1313,11 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'D':
-			delay = atoi(optarg) * 1000;
+			send_delay = atoi(optarg) * 1000;
+			break;
+
+		case 'K':
+			recv_delay = atoi(optarg) * 1000;
 			break;
 
 		case 'X':
-- 
on behalf of ST-Ericsson

