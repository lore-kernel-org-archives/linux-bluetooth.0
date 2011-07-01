Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] Use new macro for ARRAY_SIZE
Date: Fri,  1 Jul 2011 15:53:21 -0300
Message-Id: <1309546401-19867-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1309546401-19867-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309546401-19867-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/ipc.c           |    3 +--
 audio/pcm_bluetooth.c |   13 ++++++-------
 lib/sdp.c             |    3 +--
 test/ipctest.c        |    3 +--
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/audio/ipc.c b/audio/ipc.c
index 1bdad78..cf4e8e4 100644
--- a/audio/ipc.c
+++ b/audio/ipc.c
@@ -21,8 +21,7 @@
  */
 
 #include "ipc.h"
-
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#include "util.h"
 
 /* This table contains the string representation for messages types */
 static const char *strtypes[] = {
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index e633d1a..b20c653 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -43,6 +43,7 @@
 #include "ipc.h"
 #include "sbc.h"
 #include "rtp.h"
+#include "util.h"
 
 /* #define ENABLE_DEBUG */
 
@@ -1213,8 +1214,6 @@ static snd_pcm_ioplug_callback_t bluetooth_a2dp_capture = {
 	.poll_revents		= bluetooth_poll_revents,
 };
 
-#define ARRAY_NELEMS(a) (sizeof((a)) / sizeof((a)[0]))
-
 static int bluetooth_hsp_hw_constraint(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
@@ -1232,13 +1231,13 @@ static int bluetooth_hsp_hw_constraint(snd_pcm_ioplug_t *io)
 
 	/* access type */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
-					ARRAY_NELEMS(access_list), access_list);
+					ARRAY_SIZE(access_list), access_list);
 	if (err < 0)
 		return err;
 
 	/* supported formats */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
-					ARRAY_NELEMS(format_list), format_list);
+					ARRAY_SIZE(format_list), format_list);
 	if (err < 0)
 		return err;
 
@@ -1294,13 +1293,13 @@ static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
 
 	/* access type */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
-					ARRAY_NELEMS(access_list), access_list);
+					ARRAY_SIZE(access_list), access_list);
 	if (err < 0)
 		return err;
 
 	/* supported formats */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
-					ARRAY_NELEMS(format_list), format_list);
+					ARRAY_SIZE(format_list), format_list);
 	if (err < 0)
 		return err;
 
@@ -1335,7 +1334,7 @@ static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
 
 	/* supported block sizes: */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-				ARRAY_NELEMS(period_list), period_list);
+				ARRAY_SIZE(period_list), period_list);
 	if (err < 0)
 		return err;
 
diff --git a/lib/sdp.c b/lib/sdp.c
index a48ee14..7f94cd9 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -48,12 +48,11 @@
 #include "l2cap.h"
 #include "sdp.h"
 #include "sdp_lib.h"
+#include "util.h"
 
 #define SDPINF(fmt, arg...) syslog(LOG_INFO, fmt "\n", ## arg)
 #define SDPERR(fmt, arg...) syslog(LOG_ERR, "%s: " fmt "\n", __func__ , ## arg)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 #ifdef SDP_DEBUG
 #define SDPDBG(fmt, arg...) syslog(LOG_DEBUG, "%s: " fmt "\n", __func__ , ## arg)
 #else
diff --git a/test/ipctest.c b/test/ipctest.c
index 9fdfac4..33801ba 100644
--- a/test/ipctest.c
+++ b/test/ipctest.c
@@ -42,14 +42,13 @@
 
 #include "ipc.h"
 #include "sbc.h"
+#include "util.h"
 
 #define DBG(fmt, arg...)				\
 	printf("debug %s: " fmt "\n" , __FUNCTION__ , ## arg)
 #define ERR(fmt, arg...)				\
 	fprintf(stderr, "ERROR %s: " fmt "\n" , __FUNCTION__ , ## arg)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 #ifndef MIN
 # define MIN(x, y) ((x) < (y) ? (x) : (y))
 #endif
-- 
1.7.6

