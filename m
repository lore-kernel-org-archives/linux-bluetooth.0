Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android/avdtptest: Add support for initiator role and discovery
Date: Fri, 29 Aug 2014 15:17:56 +0200
Message-Id: <1409318278-798-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
References: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 205 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 150 insertions(+), 55 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index 15fecc1..3fad0cc 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -46,10 +46,14 @@ static bool initiator = false;
 static struct avdtp *avdtp = NULL;
 struct avdtp_stream *avdtp_stream = NULL;
 struct avdtp_local_sep *local_sep = NULL;
+struct avdtp_remote_sep *remote_sep = NULL;
 static GIOChannel *io = NULL;
 static bool reject = false;
+static bdaddr_t src;
+static bdaddr_t dst;
 
 static guint media_player = 0;
+static guint idle_id = 0;
 
 static const char sbc_codec[] = {0x00, 0x00, 0x11, 0x15, 0x02, 0x40};
 static const char sbc_media_frame[] = {
@@ -126,6 +130,9 @@ static void set_configuration_cfm(struct avdtp *session,
 					void *user_data)
 {
 	printf("%s\n", __func__);
+
+	if (initiator)
+		avdtp_open(avdtp, avdtp_stream);
 }
 
 static void get_configuration_cfm(struct avdtp *session,
@@ -137,11 +144,144 @@ static void get_configuration_cfm(struct avdtp *session,
 	printf("%s\n", __func__);
 }
 
+static void disconnect_cb(void *user_data)
+{
+	printf("Disconnected\n");
+
+	g_main_loop_quit(mainloop);
+}
+
+static void discover_cb(struct avdtp *session, GSList *seps,
+				struct avdtp_error *err, void *user_data)
+{
+	struct avdtp_service_capability *service;
+	GSList *caps = NULL;
+	int ret;
+
+	remote_sep = avdtp_find_remote_sep(avdtp, local_sep);
+	if (!remote_sep) {
+		printf("Unable to find matching endpoint\n");
+		avdtp_shutdown(session);
+		return;
+	}
+
+	service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
+	caps = g_slist_append(caps, service);
+
+	service = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, sbc_codec,
+							sizeof(sbc_codec));
+	caps = g_slist_append(caps, service);
+
+	ret = avdtp_set_configuration(avdtp, remote_sep, local_sep, caps,
+								&avdtp_stream);
+
+	g_slist_free_full(caps, g_free);
+
+	if (ret < 0) {
+		printf("Failed to set configuration (%s)\n", strerror(-ret));
+		avdtp_shutdown(session);
+	}
+}
+
+static gboolean idle_timeout(gpointer user_data)
+{
+	int err;
+
+	idle_id = 0;
+
+	err = avdtp_discover(avdtp, discover_cb, NULL);
+	if (err < 0) {
+		printf("avdtp_discover failed: %s", strerror(-err));
+		g_main_loop_quit(mainloop);
+	}
+
+	return FALSE;
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	uint16_t imtu, omtu;
+	GError *gerr = NULL;
+	int fd;
+
+	if (err) {
+		printf("%s\n", err->message);
+		g_main_loop_quit(mainloop);
+		return;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		printf("%s\n", gerr->message);
+		g_main_loop_quit(mainloop);
+		return;
+	}
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	if (avdtp && avdtp_stream) {
+		if (!avdtp_stream_set_transport(avdtp_stream, fd, imtu, omtu)) {
+			printf("avdtp_stream_set_transport: failed\n");
+			g_main_loop_quit(mainloop);
+		}
+
+		g_io_channel_set_close_on_unref(chan, FALSE);
+
+		if (initiator)
+			avdtp_start(avdtp, avdtp_stream);
+
+		return;
+	}
+
+	/* TODO allow to set version from command line? */
+	avdtp = avdtp_new(fd, imtu, omtu, 0x0103);
+	if (!avdtp) {
+		printf("Failed to create avdtp instance\n");
+		g_main_loop_quit(mainloop);
+		return;
+	}
+
+	avdtp_add_disconnect_cb(avdtp, disconnect_cb, NULL);
+
+	if (initiator) {
+		int ret;
+
+		ret = avdtp_discover(avdtp, discover_cb, NULL);
+		if (ret < 0) {
+			printf("avdtp_discover failed: %s", strerror(-ret));
+			g_main_loop_quit(mainloop);
+		}
+	} else {
+		idle_id = g_timeout_add_seconds(1, idle_timeout, NULL);
+	}
+}
+
 static void open_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
+	GError *gerr = NULL;
+
 	printf("%s\n", __func__);
+
+	if (!initiator)
+		return;
+
+	bt_io_connect(connect_cb, NULL, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &dst,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_INVALID);
+	if (gerr) {
+		printf("connect failed: %s\n", gerr->message);
+		g_error_free(gerr);
+		g_main_loop_quit(mainloop);
+	}
 }
 
 static void start_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
@@ -219,6 +359,11 @@ static gboolean get_capability_ind(struct avdtp *session,
 
 	printf("%s\n", __func__);
 
+	if (idle_id > 0) {
+		g_source_remove(idle_id);
+		idle_id = 0;
+	}
+
 	if (reject)
 		return FALSE;
 
@@ -246,6 +391,11 @@ static gboolean set_configuration_ind(struct avdtp *session,
 	if (reject)
 		return FALSE;
 
+	if (idle_id > 0) {
+		g_source_remove(idle_id);
+		idle_id = 0;
+	}
+
 	avdtp_stream = stream;
 
 	cb(session, stream, NULL);
@@ -369,60 +519,6 @@ static struct avdtp_sep_ind sep_ind = {
 	.delayreport		= delayreport_ind,
 };
 
-static void disconnect_cb(void *user_data)
-{
-	printf("Disconnected\n");
-
-	g_main_loop_quit(mainloop);
-}
-
-static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-{
-	uint16_t imtu, omtu;
-	GError *gerr = NULL;
-	int fd;
-
-	if (err) {
-		printf("%s\n", err->message);
-		g_main_loop_quit(mainloop);
-		return;
-	}
-
-	bt_io_get(chan, &gerr,
-			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_OMTU, &omtu,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		printf("%s\n", gerr->message);
-		g_main_loop_quit(mainloop);
-		return;
-	}
-
-	fd = g_io_channel_unix_get_fd(chan);
-
-	if (avdtp && avdtp_stream) {
-		if (!avdtp_stream_set_transport(avdtp_stream, fd, imtu, omtu)) {
-			printf("avdtp_stream_set_transport: failed\n");
-			g_main_loop_quit(mainloop);
-		}
-
-		g_io_channel_set_close_on_unref(chan, FALSE);
-		return;
-	}
-
-	/* TODO allow to set version from command line? */
-	avdtp = avdtp_new(fd, imtu, omtu, 0x0103);
-	if (!avdtp) {
-		printf("Failed to create avdtp instance\n");
-		g_main_loop_quit(mainloop);
-		return;
-	}
-
-	avdtp_add_disconnect_cb(avdtp, disconnect_cb, NULL);
-
-	/* TODO handle initiator */
-}
-
 static void usage(void)
 {
 	printf("avdtptest - AVDTP testing ver %s\n", VERSION);
@@ -451,7 +547,6 @@ static struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	GError *err = NULL;
-	bdaddr_t src, dst;
 	int opt;
 
 	bacpy(&src, BDADDR_ANY);
-- 
1.9.1

