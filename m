Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 25/26] android/hal-audio-aptx: Load aptX encoder library
Date: Mon, 26 May 2014 15:16:51 +0200
Message-ID: <1401110212-11526-26-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds loding of aptX encoder library which should be provided
by user. Name of library needs to be configured using system property
(persist.sys.bluetooth.aptxlib).
---
 android/hal-audio-aptx.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
index 1cf8afc..4099c07 100644
--- a/android/hal-audio-aptx.c
+++ b/android/hal-audio-aptx.c
@@ -63,15 +63,60 @@ static const a2dp_aptx_t aptx_presets[] = {
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
+	char libname[PROPERTY_VALUE_MAX];
+
+	if (property_get("persist.sys.bluetooth.aptxlib", libname, "") < 0)
+		return AUDIO_STATUS_FAILED;
+
+	aptx_dl = dlopen(libname, RTLD_LAZY);
+	if (!aptx_dl) {
+		error("APTX: failed to open library %s (%s)", libname,
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
 
 static int aptx_get_presets(struct audio_preset *preset, size_t *len)
@@ -84,6 +129,9 @@ static int aptx_get_presets(struct audio_preset *preset, size_t *len)
 
 	DBG("");
 
+	if (!aptx_dl)
+		return 0;
+
 	count = sizeof(aptx_presets) / sizeof(aptx_presets[0]);
 
 	for (i = 0; i < count; i++) {
-- 
1.9.3

