Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] android/avdtptest: Add support for receiving media as SINK
Date: Fri, 29 Aug 2014 15:17:58 +0200
Message-Id: <1409318278-798-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
References: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 8 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index e4bb2d1..3cb9412 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -30,6 +30,7 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <stdbool.h>
+#include <errno.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -37,6 +38,7 @@
 
 #include <glib.h>
 
+#include "src/shared/util.h"
 #include "btio/btio.h"
 #include "avdtp.h"
 
@@ -53,6 +55,7 @@ static bdaddr_t src;
 static bdaddr_t dst;
 
 static guint media_player = 0;
+static guint media_recorder = 0;
 static guint idle_id = 0;
 
 static bool fragment = false;
@@ -125,6 +128,107 @@ static void stop_media_player(void)
 	media_player = 0;
 }
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct rtp_header {
+	unsigned cc:4;
+	unsigned x:1;
+	unsigned p:1;
+	unsigned v:2;
+
+	unsigned pt:7;
+	unsigned m:1;
+
+	uint16_t sequence_number;
+	uint32_t timestamp;
+	uint32_t ssrc;
+	uint32_t csrc[0];
+} __attribute__ ((packed));
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct rtp_header {
+	unsigned v:2;
+	unsigned p:1;
+	unsigned x:1;
+	unsigned cc:4;
+
+	unsigned m:1;
+	unsigned pt:7;
+
+	uint16_t sequence_number;
+	uint32_t timestamp;
+	uint32_t ssrc;
+	uint32_t csrc[0];
+} __attribute__ ((packed));
+
+#else
+#error "Unknown byte order"
+#endif
+
+static gboolean media_reader(GIOChannel *source, GIOCondition condition,
+								gpointer data)
+{
+	char buf[UINT16_MAX];
+	struct rtp_header *rtp = (void *) buf;
+	static bool decode = false;
+	uint16_t imtu;
+	int fd;
+
+	if (!avdtp_stream_get_transport(avdtp_stream, &fd, &imtu, NULL, NULL))
+		return TRUE;
+
+	if (read(fd, buf, imtu) < 0) {
+		printf("Reading failed (%s)\n", strerror(errno));
+		return TRUE;
+	}
+
+	if (!decode) {
+		printf("V=%u P=%u X=%u CC=%u M=%u PT=%u SeqNr=%d\n",
+			rtp->v, rtp->p, rtp->x, rtp->cc, rtp->m, rtp->pt,
+			be16_to_cpu(rtp->sequence_number));
+		decode = true;
+	}
+
+	return TRUE;
+}
+
+static bool start_media_recorder(void)
+{
+	int fd;
+	uint16_t omtu;
+	GIOChannel *chan;
+
+	printf("Media recording started\n");
+
+	if (media_recorder || !avdtp_stream)
+		return false;
+
+	if (!avdtp_stream_get_transport(avdtp_stream, &fd, NULL, &omtu, NULL))
+		return false;
+
+	chan = g_io_channel_unix_new(fd);
+
+	media_recorder = g_io_add_watch(chan, G_IO_IN, media_reader, NULL);
+	g_io_channel_unref(chan);
+
+	if (!media_recorder)
+		return false;
+
+	return true;
+}
+
+static void stop_media_recorder(void)
+{
+	if (!media_recorder)
+		return;
+
+	printf("Media recording stopped\n");
+
+	g_source_remove(media_recorder);
+	media_recorder = 0;
+}
+
 static void set_configuration_cfm(struct avdtp *session,
 					struct avdtp_local_sep *lsep,
 					struct avdtp_stream *stream,
@@ -308,7 +412,10 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
-	start_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		start_media_player();
+	else
+		start_media_recorder();
 }
 
 static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
@@ -317,7 +424,10 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
-	stop_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		stop_media_player();
+	else
+		stop_media_recorder();
 }
 
 static void close_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
@@ -326,7 +436,11 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
-	stop_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		stop_media_player();
+	else
+		stop_media_recorder();
+
 	avdtp_stream = NULL;
 }
 
@@ -336,7 +450,11 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
-	stop_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		stop_media_player();
+	else
+		stop_media_recorder();
+
 	avdtp_stream = NULL;
 }
 
@@ -466,7 +584,10 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *lsep,
 	if (reject)
 		return FALSE;
 
-	start_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		start_media_player();
+	else
+		start_media_recorder();
 
 	return TRUE;
 }
@@ -481,7 +602,10 @@ static gboolean suspend_ind(struct avdtp *session,
 	if (reject)
 		return FALSE;
 
-	stop_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		stop_media_player();
+	else
+		stop_media_recorder();
 
 	return TRUE;
 }
@@ -495,7 +619,11 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (reject)
 		return FALSE;
 
-	stop_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		stop_media_player();
+	else
+		stop_media_recorder();
+
 	avdtp_stream = NULL;
 
 	return TRUE;
@@ -507,7 +635,11 @@ static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 {
 	printf("%s\n", __func__);
 
-	stop_media_player();
+	if (dev_role == AVDTP_SEP_TYPE_SOURCE)
+		stop_media_player();
+	else
+		stop_media_recorder();
+
 	avdtp_stream = NULL;
 }
 
-- 
1.9.1

