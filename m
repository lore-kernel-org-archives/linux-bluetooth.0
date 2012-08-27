Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/3] rctest: add option to save received data to file
Date: Mon, 27 Aug 2012 08:14:51 -0500
Message-Id: <1346073291-7001-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1346073291-7001-1-git-send-email-gustavo@padovan.org>
References: <1346073291-7001-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

works only for automated test option for now
---
 test/rctest.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index 4aca99a..280da10 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -78,6 +78,8 @@ static uint16_t uuid = 0x0000;
 static uint8_t channel = 10;
 
 static char *filename = NULL;
+static char *savefile = NULL;
+static int save_fd = 0;
 
 static int master = 0;
 static int auth = 0;
@@ -448,6 +450,23 @@ static void dump_mode(int sk)
 		syslog(LOG_INFO, "Received %d bytes", len);
 }
 
+static void save_mode(int sk)
+{
+	int len, ret;
+	char *b;
+
+	b = malloc(data_size);
+	if (!b)
+		syslog(LOG_ERR, "Failed to open file to save recv data");
+
+	syslog(LOG_INFO, "Receiving ...");
+	while ((len = read(sk, b, data_size)) > 0) {
+		ret = write(save_fd, b, len);
+		if (!ret)
+			return;
+	}
+}
+
 static void recv_mode(int sk)
 {
 	struct timeval tv_beg, tv_end, tv_diff;
@@ -603,7 +622,20 @@ static void automated_send_recv()
 	char device[18];
 
 	if (fork()) {
-		do_listen(recv_mode);
+		if (!savefile) {
+			do_listen(recv_mode);
+			return;
+		}
+
+		save_fd = open(savefile, O_CREAT | O_WRONLY,
+						S_IRUSR | S_IWUSR);
+		if (!save_fd)
+			syslog(LOG_ERR, "Failed to open file to save "
+							"recv data");
+
+		do_listen(save_mode);
+
+		close(save_fd);
 	} else {
 		ba2str(&bdaddr, device);
 
@@ -614,6 +646,15 @@ static void automated_send_recv()
 	}
 }
 
+static void sig_child_exit(int code)
+{
+	syslog(LOG_INFO, "Exit");
+	exit(0);
+
+	if (save_fd)
+		close(save_fd);
+}
+
 static void usage(void)
 {
 	printf("rctest - RFCOMM testing\n"
@@ -635,6 +676,7 @@ static void usage(void)
 		"\t[-L seconds] enabled SO_LINGER option\n"
 		"\t[-W seconds] enable deferred setup\n"
 		"\t[-B filename] use data packets from file\n"
+		"\t[-O filename] save received data to file\n"
 		"\t[-N num] number of frames to send\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
@@ -654,7 +696,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 	bacpy(&auto_bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:N:MAESL:W:C:D:Y:T")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:MAESL:W:C:D:Y:T")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -754,6 +796,10 @@ int main(int argc, char *argv[])
 			filename = strdup(optarg);
 			break;
 
+		case 'O':
+			savefile = strdup(optarg);
+			break;
+
 		case 'N':
 			num_frames = atoi(optarg);
 			break;
@@ -791,7 +837,10 @@ int main(int argc, char *argv[])
 	}
 
 	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_IGN;
+	if (mode == AUTO)
+		sa.sa_handler = sig_child_exit;
+	else
+		sa.sa_handler = SIG_IGN;
 	sa.sa_flags   = SA_NOCLDSTOP;
 	sigaction(SIGCHLD, &sa, NULL);
 
-- 
1.7.11.2

