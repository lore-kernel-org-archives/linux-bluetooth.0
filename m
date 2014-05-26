Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 09/26] android/hal-audio: Make codecs configurable
Date: Mon, 26 May 2014 15:16:35 +0200
Message-ID: <1401110212-11526-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When supporting more codecs we need way to easily configure which ones
should be registered as endpoints. This patch adds support to specify
list of codecs to be loaded in "persist.sys.bluetooth.codecs" property
which is comma-separated case-insensitive list.

Codecs shall be listed in order of preference, i.e. 1st one is most
preferred. SBC codec is always loaded and there's no need to specify
it.
---
 android/Makefile.am |  1 +
 android/hal-audio.c | 85 ++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 2d74505..6891cbc 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -169,6 +169,7 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hal-audio.h \
 					android/hal-audio.c \
 					android/hal-audio-sbc.c \
+					android/cutils/properties.h \
 					android/hardware/audio.h \
 					android/hardware/audio_effect.h \
 					android/hardware/hardware.h \
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8b82498..e6015f2 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -27,6 +27,7 @@
 #include <arpa/inet.h>
 #include <fcntl.h>
 
+#include <cutils/properties.h>
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
 
@@ -96,8 +97,11 @@ extern int clock_nanosleep(clockid_t clock_id, int flags,
 					struct timespec *remain);
 #endif
 
-static const audio_codec_get_t audio_codecs[] = {
-		codec_sbc,
+static const struct audio_codec_info {
+	const char *name;
+	const struct audio_codec * (*get) (void);
+} audio_codecs[] = {
+		{ "sbc",	codec_sbc },
 };
 
 #define NUM_CODECS (sizeof(audio_codecs) / sizeof(audio_codecs[0]))
@@ -415,27 +419,80 @@ static int ipc_suspend_stream_cmd(uint8_t endpoint_id)
 	return result;
 }
 
-static int register_endpoints(void)
+static void register_endpoint(const char *codec_name)
 {
-	struct audio_endpoint *ep = &audio_endpoints[0];
+	const struct audio_codec *codec = NULL;
+	struct audio_endpoint *ep;
 	size_t i;
 
-	for (i = 0; i < NUM_CODECS; i++, ep++) {
-		const struct audio_codec *codec = audio_codecs[i]();
+	for (i = 0; i < NUM_CODECS; i++)
+		if (!strcasecmp(audio_codecs[i].name, codec_name)) {
+			codec = audio_codecs[i].get();
+			break;
+		}
 
-		if (!codec)
-			return AUDIO_STATUS_FAILED;
+	if (!codec) {
+		error("Failed to register endpoint for %s", codec_name);
+		return;
+	}
 
-		ep->id = ipc_open_cmd(codec);
+	for (i = 0; i < MAX_AUDIO_ENDPOINTS; i++) {
+		/* Do not register the same codec twice */
+		if (audio_endpoints[i].codec == codec)
+			return;
 
-		if (!ep->id)
-			return AUDIO_STATUS_FAILED;
+		if (!audio_endpoints[i].id)
+			break;
+	}
 
-		ep->codec = codec;
-		ep->codec_data = NULL;
-		ep->fd = -1;
+	/* We have the same number of endpoints and codecs so we'll always find
+	 * free endpoint - no need to check this here.
+	 */
+
+	ep = &audio_endpoints[i];
+
+	ep->id = ipc_open_cmd(codec);
+
+	if (!ep->id) {
+		error("Failed to open endpoint for %s", codec_name);
+		return;
 	}
 
+	ep->codec = codec;
+	ep->codec_data = NULL;
+	ep->fd = -1;
+
+	info("Opened endpoint for %s", codec_name);
+}
+
+static int register_endpoints(void)
+{
+	char value[PROPERTY_VALUE_MAX];
+	char *name, *p;
+
+	if (property_get("persist.sys.bluetooth.codecs", value, "") < 0)
+		return AUDIO_STATUS_FAILED;
+
+	p = value;
+
+	do {
+		name = p;
+		p = strchr(name, ',');
+		if (p) {
+			*p = '\0';
+			p++;
+		}
+		if (!strlen(name))
+			continue;
+
+		register_endpoint(name);
+	} while (p);
+
+	/* SBC is mandatory and should always be registered, even if it's not
+	 * specified in prop
+	 */
+	register_endpoint("sbc");
+
 	return AUDIO_STATUS_SUCCESS;
 }
 
-- 
1.9.3

