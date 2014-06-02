Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 4/5] android/hal-audio-aptx: Load aptX encoder library
Date: Mon, 2 Jun 2014 13:20:10 +0200
Message-ID: <1401708011-12828-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds loading of aptX encoder library which should be provided
by user. hal-audio-aptx will try to load 'libbt-aptx.so' so it should be
available in search patch, preferably in /system/lib.
---
 android/hal-audio-aptx.c | 51 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
index b7b5dfc..28db0f6 100644
--- a/android/hal-audio-aptx.c
+++ b/android/hal-audio-aptx.c
@@ -27,6 +27,8 @@
 #include "../src/shared/util.h"
 #include "../profiles/audio/a2dp-codecs.h"
 
+#define APTX_SO_NAME	"libbt-aptx.so"
+
 struct aptx_data {
 	a2dp_aptx_t aptx;
 
@@ -61,20 +63,61 @@ static const a2dp_aptx_t aptx_presets[] = {
 	},
 };
 
+static void *aptx_dl;
+static int aptx_sizeof = 0;
+static int (*aptx_init)(void *, short);
+static int (*aptx_encode)(void *, void *, void *, void *);
+
 static bool aptx_load(void)
 {
-	/* TODO: load aptX codec library */
-	return false;
+	const char * (*aptx_version)(void);
+	const char * (*aptx_build)(void);
+	int (*aptx_sizeofenc)(void);
+
+	aptx_dl = dlopen(APTX_SO_NAME, RTLD_LAZY);
+	if (!aptx_dl) {
+		error("APTX: failed to open library %s (%s)", APTX_SO_NAME,
+								dlerror());
+		return false;
+	}
+
+	aptx_version = dlsym(aptx_dl, "aptxbtenc_version");
+	aptx_build = dlsym(aptx_dl, "aptxbtenc_build");
+
+	if (aptx_version && aptx_build)
+		info("APTX: using library version %s build %s", aptx_version(),
+								aptx_build());
+	else
+		warn("APTX: cannot retrieve library version");
+
+	aptx_sizeofenc = dlsym(aptx_dl, "SizeofAptxbtenc");
+	aptx_init = dlsym(aptx_dl, "aptxbtenc_init");
+	aptx_encode = dlsym(aptx_dl, "aptxbtenc_encodestereo");
+	if (!aptx_sizeofenc || !aptx_init || !aptx_encode) {
+		error("APTX: failed initialize library");
+		dlclose(aptx_dl);
+		aptx_dl = NULL;
+		return false;
+	}
+
+	aptx_sizeof = aptx_sizeofenc();
+
+	info("APTX: codec library initialized (size=%d)", aptx_sizeof);
+
+	return true;
 }
 
 static void aptx_unload(void)
 {
-	/* TODO: unload aptX codec library */
+	if (aptx_dl) {
+		dlclose(aptx_dl);
+		aptx_dl = NULL;
+	}
 }
 
 static bool aptx_available(void)
 {
-	return false;
+	return aptx_dl != NULL;
 }
 
 static int aptx_get_presets(struct audio_preset *preset, size_t *len)
-- 
1.9.3

