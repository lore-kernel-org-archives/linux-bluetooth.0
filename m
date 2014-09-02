Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/avdtptest: Add option to enable stream configuration
Date: Tue,  2 Sep 2014 15:53:56 +0200
Message-Id: <1409666038-19754-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of specifing initiator role use option that allows to perform
stream configuration.
---
 android/avdtptest.c | 50 ++++++++++----------------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index adbf7af..c8f7340 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -44,7 +44,7 @@
 
 static GMainLoop *mainloop = NULL;
 static int dev_role = AVDTP_SEP_TYPE_SOURCE;
-static bool initiator = false;
+static bool preconf = false;
 static struct avdtp *avdtp = NULL;
 struct avdtp_stream *avdtp_stream = NULL;
 struct avdtp_local_sep *local_sep = NULL;
@@ -237,7 +237,7 @@ static void set_configuration_cfm(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
-	if (initiator)
+	if (preconf)
 		avdtp_open(avdtp, avdtp_stream);
 }
 
@@ -289,21 +289,6 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 	}
 }
 
-static gboolean idle_timeout(gpointer user_data)
-{
-	int err;
-
-	idle_id = 0;
-
-	err = avdtp_discover(avdtp, discover_cb, NULL);
-	if (err < 0) {
-		printf("avdtp_discover failed: %s", strerror(-err));
-		g_main_loop_quit(mainloop);
-	}
-
-	return FALSE;
-}
-
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	uint16_t imtu, omtu;
@@ -339,9 +324,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 		g_io_channel_set_close_on_unref(chan, FALSE);
 
-		if (initiator)
-			avdtp_start(avdtp, avdtp_stream);
-
 		return;
 	}
 
@@ -355,7 +337,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	avdtp_add_disconnect_cb(avdtp, disconnect_cb, NULL);
 
-	if (initiator) {
+	if (preconf) {
 		int ret;
 
 		ret = avdtp_discover(avdtp, discover_cb, NULL);
@@ -363,8 +345,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 			printf("avdtp_discover failed: %s", strerror(-ret));
 			g_main_loop_quit(mainloop);
 		}
-	} else {
-		idle_id = g_timeout_add_seconds(1, idle_timeout, NULL);
 	}
 }
 
@@ -395,9 +375,6 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 
 	printf("%s\n", __func__);
 
-	if (!initiator)
-		return;
-
 	do_connect(&gerr);
 	if (gerr) {
 		printf("connect failed: %s\n", gerr->message);
@@ -685,23 +662,23 @@ static void usage(void)
 		"\tavdtptest [options]\n");
 	printf("options:\n"
 		"\t-d <device_role>   SRC (source) or SINK (sink)\n"
-		"\t-s <stream_role>   INT (initiator) or ACP (acceptor)\n"
 		"\t-i <hcidev>        HCI adapter\n"
 		"\t-c <bdaddr>        connect\n"
 		"\t-l                 listen\n"
 		"\t-r                 reject commands\n"
-		"\t-f                 fragment\n");
+		"\t-f                 fragment\n"
+		"-t-p                 configure stream\n");
 }
 
 static struct option main_options[] = {
 	{ "help",		0, 0, 'h' },
 	{ "device_role",	1, 0, 'd' },
-	{ "stream_role",	1, 0, 's' },
 	{ "adapter",		1, 0, 'i' },
 	{ "connect",		1, 0, 'c' },
 	{ "listen",		0, 0, 'l' },
 	{ "reject",		0, 0, 'r' },
 	{ "fragment",		0, 0, 'f' },
+	{ "preconf",		0, 0, 'p' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -737,7 +714,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "d:hi:s:c:lrf",
+	while ((opt = getopt_long(argc, argv, "d:hi:c:lrfp",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -757,16 +734,6 @@ int main(int argc, char *argv[])
 				exit(0);
 			}
 			break;
-		case 's':
-			if (!strncasecmp(optarg, "INT", sizeof("INT"))) {
-				initiator = true;
-			} else if (!strncasecmp(optarg, "ACP", sizeof("ACP"))) {
-				initiator = false;
-			} else {
-				usage();
-				exit(0);
-			}
-			break;
 		case 'c':
 			if (str2ba(optarg, &dst) < 0) {
 				usage();
@@ -782,6 +749,9 @@ int main(int argc, char *argv[])
 		case 'f':
 			fragment = true;
 			break;
+		case 'p':
+			preconf = true;
+			break;
 		case 'h':
 		default:
 			usage();
-- 
1.9.1

