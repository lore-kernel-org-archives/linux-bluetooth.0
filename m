Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/avdtptest: Add option for setting protocol version
Date: Tue,  2 Sep 2014 15:53:58 +0200
Message-Id: <1409666038-19754-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409666038-19754-1-git-send-email-szymon.janc@tieto.com>
References: <1409666038-19754-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index 58168be..d1f2ef4 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -53,7 +53,7 @@ static GIOChannel *io = NULL;
 static bool reject = false;
 static bdaddr_t src;
 static bdaddr_t dst;
-
+static uint16_t version = 0x0103;
 static guint media_player = 0;
 static guint media_recorder = 0;
 static guint idle_id = 0;
@@ -402,8 +402,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	/* TODO allow to set version from command line? */
-	avdtp = avdtp_new(fd, imtu, omtu, 0x0103);
+	avdtp = avdtp_new(fd, imtu, omtu, version);
 	if (!avdtp) {
 		printf("Failed to create avdtp instance\n");
 		g_main_loop_quit(mainloop);
@@ -749,7 +748,8 @@ static void usage(void)
 		"\t-r                 reject commands\n"
 		"\t-f                 fragment\n"
 		"\t-p                 configure stream\n"
-		"\t-s <command>       send command\n");
+		"\t-s <command>       send command\n"
+		"\t-v <version>       set version (0x0100, 0x0102, 0x0103\n");
 }
 
 static struct option main_options[] = {
@@ -762,6 +762,7 @@ static struct option main_options[] = {
 	{ "fragment",		0, 0, 'f' },
 	{ "preconf",		0, 0, 'p' },
 	{ "send",		1, 0, 's' },
+	{ "version",		1, 0, 'v' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -797,7 +798,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "d:hi:s:c:lrfp",
+	while ((opt = getopt_long(argc, argv, "d:hi:s:c:v:lrfp",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -838,6 +839,15 @@ int main(int argc, char *argv[])
 		case 's':
 			parse_command(optarg);
 			break;
+		case 'v':
+			version = strtol(optarg, NULL, 0);
+			if (version != 0x0100 && version != 0x0102 &&
+							version != 0x0103) {
+				printf("invalid version\n");
+				exit(0);
+			}
+
+			break;
 		case 'h':
 		default:
 			usage();
-- 
1.9.1

