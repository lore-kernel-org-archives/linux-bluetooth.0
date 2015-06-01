Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] tools/l2test: Add -g option
Date: Mon,  1 Jun 2015 11:27:07 +0200
Message-Id: <1433150827-17629-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
References: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This option allow to sleep before disconnecting socket.
---
 tools/l2test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 55955d8..5148328 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -108,6 +108,9 @@ static unsigned long send_delay = 0;
 /* Default delay before receiving */
 static unsigned long recv_delay = 0;
 
+/* Default delay before disconnecting */
+static unsigned long disc_delay = 0;
+
 /* Initial sequence value when sending frames */
 static int seq_start = 0;
 
@@ -1013,6 +1016,9 @@ static void send_mode(int sk)
 {
 	do_send(sk);
 
+	if (disc_delay)
+		usleep(disc_delay);
+
 	syslog(LOG_INFO, "Closing channel ...");
 	if (shutdown(sk, SHUT_RDWR) < 0)
 		syslog(LOG_INFO, "Close failed: %m");
@@ -1317,6 +1323,7 @@ static void usage(void)
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
+		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
 		"\t[-a policy] chan policy (help for list, default = bredr)\n"
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
@@ -1554,6 +1561,10 @@ int main(int argc, char *argv[])
 			seq_start = atoi(optarg);
 			break;
 
+		case 'g':
+			disc_delay = atoi(optarg) * 1000;
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.9.3

