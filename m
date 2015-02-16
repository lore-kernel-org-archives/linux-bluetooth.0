Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 4/8] android/avdtp: Fix SEID generation
Date: Mon, 16 Feb 2015 15:02:26 +0200
Message-Id: <1424091750-29487-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes SEID generation for avdtp. Currently SEIDs were assigned assuming
that SEID are registered and unregistered in the same order like:
seid = g_slist_length(seps) + 1
which makes it possible to reuse similar SEIDs. Note that helper
function allows maximum id of sizeof(int) * 8 which is smaller then
MAX_SEID but more then enough for local SEPs.
---
 android/Android.mk  | 1 +
 android/Makefile.am | 1 +
 android/avdtp.c     | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index 91b9562..1f2095d 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -261,6 +261,7 @@ LOCAL_SRC_FILES := \
 	bluez/btio/btio.c \
 	bluez/lib/bluetooth.c \
 	bluez/lib/hci.c \
+	bluez/src/shared/util.c \
 
 LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/bluez \
diff --git a/android/Makefile.am b/android/Makefile.am
index 4f13c4d..f8c76b3 100644
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
index 853fdf3..ce75615 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -41,10 +41,12 @@
 
 #include "lib/bluetooth.h"
 #include "src/log.h"
+#include "src/shared/util.h"
 #include "avdtp.h"
 #include "../profiles/audio/a2dp-codecs.h"
 
 #define MAX_SEID 0x3E
+static unsigned int seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
@@ -3357,7 +3359,7 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-	sep->info.seid = g_slist_length(lseps) + 1;
+	sep->info.seid = util_get_uid(&seids, MAX_SEID);
 	sep->info.type = type;
 	sep->info.media_type = media_type;
 	sep->codec = codec_type;
@@ -3393,6 +3395,7 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 	DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
 
+	util_clear_uid(&seids, sep->info.seid);
 	g_free(sep);
 
 	return 0;
-- 
2.1.0

