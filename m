Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/avdtptest: Add support for sending commands
Date: Tue,  2 Sep 2014 15:53:57 +0200
Message-Id: <1409666038-19754-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409666038-19754-1-git-send-email-szymon.janc@tieto.com>
References: <1409666038-19754-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index c8f7340..58168be 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -60,6 +60,17 @@ static guint idle_id = 0;
 
 static bool fragment = false;
 
+static enum {
+	CMD_GET_CONF,
+	CMD_OPEN,
+	CMD_START,
+	CMD_SUSPEND,
+	CMD_CLOSE,
+	CMD_ABORT,
+	CMD_DELAY,
+	CMD_NONE,
+} command = CMD_NONE;
+
 static const char sbc_codec[] = {0x00, 0x00, 0x11, 0x15, 0x02, 0x40};
 static const char sbc_media_frame[] = {
 	0x00, 0x60, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
@@ -77,6 +88,64 @@ static const char sbc_media_frame[] = {
 	0x3b, 0x3b, 0xaf, 0xc6, 0xd4, 0x37, 0x68, 0x94, 0x0a, 0xbb
 	};
 
+static void parse_command(const char *cmd)
+{
+	if (!strncmp(cmd, "getconf", sizeof("getconf"))) {
+		command = CMD_GET_CONF;
+	} else if (!strncmp(cmd, "open", sizeof("open"))) {
+		command = CMD_OPEN;
+	} else if (!strncmp(cmd, "start", sizeof("start"))) {
+		command = CMD_START;
+	} else if (!strncmp(cmd, "suspend", sizeof("suspend"))) {
+		command = CMD_SUSPEND;
+	} else if (!strncmp(cmd, "close", sizeof("close"))) {
+		command = CMD_CLOSE;
+	} else if (!strncmp(cmd, "abort", sizeof("abort"))) {
+		command = CMD_ABORT;
+	} else if (!strncmp(cmd, "delay", sizeof("delay"))) {
+		command = CMD_DELAY;
+	} else {
+		printf("Unknown command '%s'\n", cmd);
+		printf("(getconf open start suspend close abort delay)\n");
+		exit(1);
+	}
+}
+
+static void send_command(void)
+{
+	avdtp_state_t state = avdtp_sep_get_state(local_sep);
+
+	switch (command) {
+	case CMD_GET_CONF:
+		avdtp_get_configuration(avdtp, avdtp_stream);
+		break;
+	case CMD_OPEN:
+		if (state == AVDTP_STATE_CONFIGURED)
+			avdtp_open(avdtp, avdtp_stream);
+		break;
+	case CMD_START:
+		if (state == AVDTP_STATE_OPEN)
+			avdtp_start(avdtp, avdtp_stream);
+		break;
+	case CMD_SUSPEND:
+		if (state == AVDTP_STATE_STREAMING)
+			avdtp_suspend(avdtp , avdtp_stream);
+		break;
+	case CMD_CLOSE:
+		if (state == AVDTP_STATE_STREAMING)
+			avdtp_close(avdtp, avdtp_stream, FALSE);
+		break;
+	case CMD_ABORT:
+		avdtp_abort(avdtp , avdtp_stream);
+		break;
+	case CMD_DELAY:
+		avdtp_delay_report(avdtp , avdtp_stream , 250);
+		break;
+	default:
+		break;
+	}
+}
+
 static gboolean media_writer(gpointer user_data)
 {
 	uint16_t omtu;
@@ -91,9 +160,11 @@ static gboolean media_writer(gpointer user_data)
 	else
 		to_write = sizeof(sbc_media_frame);
 
-	if (write(fd, sbc_media_frame, to_write))
+	if (write(fd, sbc_media_frame, to_write) < 0)
 		return TRUE;
 
+	send_command();
+
 	return TRUE;
 }
 
@@ -190,6 +261,8 @@ static gboolean media_reader(GIOChannel *source, GIOCondition condition,
 		decode = true;
 	}
 
+	send_command();
+
 	return TRUE;
 }
 
@@ -324,6 +397,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 		g_io_channel_set_close_on_unref(chan, FALSE);
 
+		send_command();
+
 		return;
 	}
 
@@ -522,6 +597,8 @@ static gboolean set_configuration_ind(struct avdtp *session,
 
 	cb(session, stream, NULL);
 
+	send_command();
+
 	return TRUE;
 }
 
@@ -546,6 +623,8 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *lsep,
 	if (reject)
 		return FALSE;
 
+	send_command();
+
 	return TRUE;
 }
 
@@ -563,6 +642,8 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *lsep,
 	else
 		start_media_recorder();
 
+	send_command();
+
 	return TRUE;
 }
 
@@ -667,7 +748,8 @@ static void usage(void)
 		"\t-l                 listen\n"
 		"\t-r                 reject commands\n"
 		"\t-f                 fragment\n"
-		"-t-p                 configure stream\n");
+		"\t-p                 configure stream\n"
+		"\t-s <command>       send command\n");
 }
 
 static struct option main_options[] = {
@@ -679,6 +761,7 @@ static struct option main_options[] = {
 	{ "reject",		0, 0, 'r' },
 	{ "fragment",		0, 0, 'f' },
 	{ "preconf",		0, 0, 'p' },
+	{ "send",		1, 0, 's' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -714,7 +797,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "d:hi:c:lrfp",
+	while ((opt = getopt_long(argc, argv, "d:hi:s:c:lrfp",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -752,6 +835,9 @@ int main(int argc, char *argv[])
 		case 'p':
 			preconf = true;
 			break;
+		case 's':
+			parse_command(optarg);
+			break;
 		case 'h':
 		default:
 			usage();
-- 
1.9.1

