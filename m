Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android/avdtptest: Add support for fragmentation
Date: Fri, 29 Aug 2014 15:17:57 +0200
Message-Id: <1409318278-798-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
References: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 81 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index 3fad0cc..e4bb2d1 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -55,6 +55,8 @@ static bdaddr_t dst;
 static guint media_player = 0;
 static guint idle_id = 0;
 
+static bool fragment = false;
+
 static const char sbc_codec[] = {0x00, 0x00, 0x11, 0x15, 0x02, 0x40};
 static const char sbc_media_frame[] = {
 	0x00, 0x60, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
@@ -221,6 +223,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
+	printf("Connected (imtu=%d omtu=%d)\n", imtu, omtu);
+
 	fd = g_io_channel_unix_get_fd(chan);
 
 	if (avdtp && avdtp_stream) {
@@ -260,6 +264,25 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
+static GIOChannel *do_connect(GError **err)
+{
+	if (fragment)
+		return bt_io_connect(connect_cb, NULL, NULL, err,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &dst,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_MTU, 48,
+					BT_IO_OPT_INVALID);
+
+	return bt_io_connect(connect_cb, NULL, NULL, err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &dst,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_PSM, AVDTP_PSM,
+				BT_IO_OPT_INVALID);
+}
+
 static void open_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
@@ -271,12 +294,7 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 	if (!initiator)
 		return;
 
-	bt_io_connect(connect_cb, NULL, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &src,
-					BT_IO_OPT_DEST_BDADDR, &dst,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_PSM, AVDTP_PSM,
-					BT_IO_OPT_INVALID);
+	do_connect(&gerr);
 	if (gerr) {
 		printf("connect failed: %s\n", gerr->message);
 		g_error_free(gerr);
@@ -356,6 +374,7 @@ static gboolean get_capability_ind(struct avdtp *session,
 					void *user_data)
 {
 	struct avdtp_service_capability *service;
+	int i;
 
 	printf("%s\n", __func__);
 
@@ -373,7 +392,18 @@ static gboolean get_capability_ind(struct avdtp *session,
 	*caps = g_slist_append(*caps, service);
 
 	service = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, sbc_codec,
+						sizeof(sbc_codec));
+	*caps = g_slist_append(*caps, service);
+
+	if (fragment)
+		for (i = 0; i < 10; i++) {
+			service = avdtp_service_cap_new(AVDTP_MEDIA_CODEC,
+							sbc_codec,
 							sizeof(sbc_codec));
+			*caps = g_slist_append(*caps, service);
+		}
+
+	service = avdtp_service_cap_new(AVDTP_DELAY_REPORTING, NULL, 0);
 	*caps = g_slist_append(*caps, service);
 
 	return TRUE;
@@ -530,7 +560,8 @@ static void usage(void)
 		"\t-i <hcidev>        HCI adapter\n"
 		"\t-c <bdaddr>        connect\n"
 		"\t-l                 listen\n"
-		"\t-r                 reject commands\n");
+		"\t-r                 reject commands\n"
+		"\t-f                 fragment\n");
 }
 
 static struct option main_options[] = {
@@ -541,9 +572,27 @@ static struct option main_options[] = {
 	{ "connect",		1, 0, 'c' },
 	{ "listen",		0, 0, 'l' },
 	{ "reject",		0, 0, 'r' },
+	{ "fragment",		0, 0, 'f' },
 	{ 0, 0, 0, 0 }
 };
 
+static GIOChannel *do_listen(GError **err)
+{
+	if (fragment)
+		return bt_io_listen(connect_cb, NULL, NULL, NULL, err,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, 48,
+					BT_IO_OPT_INVALID);
+
+	return bt_io_listen(connect_cb, NULL, NULL, NULL, err,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+}
+
 int main(int argc, char *argv[])
 {
 	GError *err = NULL;
@@ -559,7 +608,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "d:hi:s:c:lr",
+	while ((opt = getopt_long(argc, argv, "d:hi:s:c:lrf",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -601,6 +650,9 @@ int main(int argc, char *argv[])
 		case 'r':
 			reject = true;
 			break;
+		case 'f':
+			fragment = true;
+			break;
 		case 'h':
 		default:
 			usage();
@@ -617,19 +669,10 @@ int main(int argc, char *argv[])
 
 	if (!bacmp(&dst, BDADDR_ANY)) {
 		printf("Listening...\n");
-		io =  bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, &src,
-					BT_IO_OPT_PSM, AVDTP_PSM,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_INVALID);
+		io = do_listen(&err);
 	} else {
 		printf("Connecting...\n");
-		io = bt_io_connect(connect_cb, NULL, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, &src,
-					BT_IO_OPT_DEST_BDADDR, &dst,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_PSM, AVDTP_PSM,
-					BT_IO_OPT_INVALID);
+		io = do_connect(&err);
 	}
 
 	if (!io) {
-- 
1.9.1

