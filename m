Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/8] android/avdtp: Fix SEID generation
Date: Fri, 13 Feb 2015 11:22:58 +0200
Message-Id: <1423819382-20018-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423819382-20018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423819382-20018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes SEID generation for avdtp. Currently SEIDs were assigned assuming
that SEID are registered and unregistered in the same order like:
seid = g_slist_length(seps) + 1
which makes it possible to reuse similar SEIDs
---
 android/Makefile.am |  1 +
 android/avdtp.c     | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 9e73be4..ebbb28e 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -102,6 +102,7 @@ noinst_PROGRAMS += android/avdtptest
 android_avdtptest_SOURCES = android/avdtptest.c \
 				src/log.h src/log.c \
 				btio/btio.h btio/btio.c \
+				src/shared/util.h src/shared/util.c \
 				android/avdtp.h android/avdtp.c
 android_avdtptest_CFLAGS = $(AM_CFLAGS)
 android_avdtptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
diff --git a/android/avdtp.c b/android/avdtp.c
index 853fdf3..728f3fd 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -41,10 +41,12 @@
 
 #include "lib/bluetooth.h"
 #include "src/log.h"
+#include "src/shared/util.h"
 #include "avdtp.h"
 #include "../profiles/audio/a2dp-codecs.h"
 
 #define MAX_SEID 0x3E
+static uint64_t seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
@@ -3342,6 +3344,22 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
+static uint8_t avdtp_get_seid(void)
+{
+	uint8_t id = util_get_bitmap64_uid(&seids, MAX_SEID);
+
+	DBG("seids 0x%04lx id %d", seids, id);
+
+	return id;
+}
+
+static void avdtp_clear_seid(uint8_t seid)
+{
+	util_clear_bitmap64(&seids, seid);
+
+	DBG("seids 0x%04lx cleared bit %d ", seids, seid);
+}
+
 struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -3357,7 +3375,7 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-	sep->info.seid = g_slist_length(lseps) + 1;
+	sep->info.seid = avdtp_get_seid();
 	sep->info.type = type;
 	sep->info.media_type = media_type;
 	sep->codec = codec_type;
@@ -3393,6 +3411,7 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 	DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
 
+	avdtp_clear_seid(sep->info.seid);
 	g_free(sep);
 
 	return 0;
-- 
2.1.0

