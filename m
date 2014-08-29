Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android/avdtptest: Add support for streaming
Date: Fri, 29 Aug 2014 15:17:54 +0200
Message-Id: <1409318278-798-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
References: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index a986a9b..402d931 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -48,6 +48,76 @@ struct avdtp_stream *avdtp_stream = NULL;
 struct avdtp_local_sep *local_sep = NULL;
 static GIOChannel *io = NULL;
 
+static guint media_player = 0;
+
+static const char sbc_codec[] = {0x00, 0x00, 0x11, 0x15, 0x02, 0x40};
+static const char sbc_media_frame[] = {
+	0x00, 0x60, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x01, 0x9c, 0xfd, 0x40, 0xbd, 0xde, 0xa9, 0x75, 0x43, 0x20, 0x87, 0x64,
+	0x44, 0x32, 0x7f, 0xbe, 0xf7, 0x76, 0xfe, 0xf7, 0xbb, 0xbb, 0x7f, 0xbe,
+	0xf7, 0x76, 0xfe, 0xf7, 0xbb, 0xbb, 0x7f, 0xbe, 0xf7, 0x76, 0xfe, 0xf7,
+	0xbb, 0xbb, 0x80, 0x3e, 0xf7, 0x76, 0xfe, 0xf7, 0xbb, 0xbb, 0x83, 0x41,
+	0x07, 0x77, 0x09, 0x07, 0x43, 0xb3, 0x81, 0xbc, 0xf8, 0x77, 0x02, 0xe5,
+	0xa4, 0x3a, 0xa0, 0xcb, 0x38, 0xbb, 0x57, 0x90, 0xd9, 0x08, 0x9c, 0x1d,
+	0x86, 0x59, 0x01, 0x0c, 0x21, 0x44, 0x68, 0x35, 0xa8, 0x57, 0x97, 0x0e,
+	0x9b, 0xbb, 0x62, 0xc4, 0xca, 0x57, 0x04, 0xa1, 0xca, 0x3b, 0xa3, 0x48,
+	0xd2, 0x66, 0x11, 0x33, 0x6a, 0x3b, 0xb4, 0xbb, 0x08, 0x77, 0x17, 0x03,
+	0xb4, 0x3b, 0x79, 0x3b, 0x46, 0x97, 0x0e, 0xf7, 0x3d, 0xbb, 0x3d, 0x49,
+	0x25, 0x86, 0x88, 0xb4, 0xad, 0x3b, 0x62, 0xbb, 0xa4, 0x47, 0x29, 0x99,
+	0x3b, 0x3b, 0xaf, 0xc6, 0xd4, 0x37, 0x68, 0x94, 0x0a, 0xbb
+	};
+
+static gboolean media_writer(gpointer user_data)
+{
+	uint16_t omtu;
+	int fd;
+	int to_write;
+
+	if (!avdtp_stream_get_transport(avdtp_stream, &fd, NULL, &omtu, NULL))
+		return TRUE;
+
+	if (omtu < sizeof(sbc_media_frame))
+		to_write = omtu;
+	else
+		to_write = sizeof(sbc_media_frame);
+
+	if (write(fd, sbc_media_frame, to_write))
+		return TRUE;
+
+	return TRUE;
+}
+
+static bool start_media_player(void)
+{
+	int fd;
+	uint16_t omtu;
+
+	printf("Media streaming started\n");
+
+	if (media_player || !avdtp_stream)
+		return false;
+
+	if (!avdtp_stream_get_transport(avdtp_stream, &fd, NULL, &omtu, NULL))
+		return false;
+
+	media_player = g_timeout_add(200, media_writer, NULL);
+	if (!media_player)
+		return false;
+
+	return true;
+}
+
+static void stop_media_player(void)
+{
+	if (!media_player)
+		return;
+
+	printf("Media streaming stopped\n");
+
+	g_source_remove(media_player);
+	media_player = 0;
+}
+
 static void set_configuration_cfm(struct avdtp *session,
 					struct avdtp_local_sep *lsep,
 					struct avdtp_stream *stream,
@@ -78,6 +148,8 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 			void *user_data)
 {
 	printf("%s\n", __func__);
+
+	start_media_player();
 }
 
 static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
@@ -85,6 +157,8 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 			struct avdtp_error *err, void *user_data)
 {
 	printf("%s\n", __func__);
+
+	stop_media_player();
 }
 
 static void close_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
@@ -93,6 +167,7 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
+	stop_media_player();
 	avdtp_stream = NULL;
 }
 
@@ -102,6 +177,7 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
+	stop_media_player();
 	avdtp_stream = NULL;
 }
 
@@ -133,8 +209,6 @@ static struct avdtp_sep_cfm sep_cfm = {
 	.delay_report		= delay_report_cfm,
 };
 
-static const char sbc_codec[] = {0x00, 0x00, 0xff, 0xff, 0x02, 0x40};
-
 static gboolean get_capability_ind(struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					GSList **caps, uint8_t *err,
@@ -196,6 +270,8 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
+	start_media_player();
+
 	return TRUE;
 }
 
@@ -206,7 +282,9 @@ static gboolean suspend_ind(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
-	return FALSE;
+	stop_media_player();
+
+	return TRUE;
 }
 
 static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -215,7 +293,10 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 {
 	printf("%s\n", __func__);
 
-	return FALSE;
+	stop_media_player();
+	avdtp_stream = NULL;
+
+	return TRUE;
 }
 
 static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -223,6 +304,9 @@ static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	printf("%s\n", __func__);
+
+	stop_media_player();
+	avdtp_stream = NULL;
 }
 
 static gboolean reconfigure_ind(struct avdtp *session,
-- 
1.9.1

