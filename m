Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 01/22] audio: move interface declarations to their headers
Date: Thu, 11 Aug 2011 12:53:12 -0300
Message-Id: <1313078013-19103-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.h |    4 ----
 audio/unix.c   |    1 +
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/audio/device.h b/audio/device.h
index 35af788..5117fca 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -38,10 +38,6 @@
 #define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
 #define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
 
-/* Move these to respective .h files once they exist */
-#define AUDIO_SOURCE_INTERFACE		"org.bluez.AudioSource"
-#define AUDIO_CONTROL_INTERFACE		"org.bluez.Control"
-
 struct source;
 struct control;
 struct target;
diff --git a/audio/unix.c b/audio/unix.c
index 8ce50b0..1e0ab30 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -49,6 +49,7 @@
 #include "a2dp.h"
 #include "headset.h"
 #include "sink.h"
+#include "source.h"
 #include "gateway.h"
 #include "unix.h"
 #include "glib-helper.h"
-- 
1.7.6

