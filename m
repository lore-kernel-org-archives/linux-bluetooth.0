Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 02/14] audio: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:26 +0200
Message-Id: <1338471818-20894-3-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 audio/avctp.c     |    1 +
 audio/avdtp.c     |    1 +
 audio/avrcp.c     |    1 +
 audio/device.h    |   16 ----------------
 audio/manager.c   |    1 +
 audio/media.c     |    2 ++
 audio/transport.c |    2 ++
 lib/uuid.h        |   16 ++++++++++++++++
 8 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 5f9afa1..ae3c04e 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -40,6 +40,7 @@
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
diff --git a/audio/avdtp.c b/audio/avdtp.c
index 34d49d2..eb3f213 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -38,6 +38,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
diff --git a/audio/avrcp.c b/audio/avrcp.c
index a040099..89ee112 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -40,6 +40,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
diff --git a/audio/device.h b/audio/device.h
index 5117fca..75f1da9 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -22,22 +22,6 @@
  *
  */
 
-#define GENERIC_AUDIO_UUID	"00001203-0000-1000-8000-00805f9b34fb"
-
-#define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
-#define HSP_AG_UUID		"00001112-0000-1000-8000-00805f9b34fb"
-
-#define HFP_HS_UUID		"0000111e-0000-1000-8000-00805f9b34fb"
-#define HFP_AG_UUID		"0000111f-0000-1000-8000-00805f9b34fb"
-
-#define ADVANCED_AUDIO_UUID	"0000110d-0000-1000-8000-00805f9b34fb"
-
-#define A2DP_SOURCE_UUID	"0000110a-0000-1000-8000-00805f9b34fb"
-#define A2DP_SINK_UUID		"0000110b-0000-1000-8000-00805f9b34fb"
-
-#define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
-#define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
-
 struct source;
 struct control;
 struct target;
diff --git a/audio/manager.c b/audio/manager.c
index 0b21322..d442d1d 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -41,6 +41,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
diff --git a/audio/media.c b/audio/media.c
index 147538c..1956653 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -29,6 +29,8 @@
 
 #include <errno.h>
 
+#include <bluetooth/uuid.h>
+
 #include <glib.h>
 #include <gdbus.h>
 
diff --git a/audio/transport.c b/audio/transport.c
index 40d093b..1fccff8 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -28,6 +28,8 @@
 
 #include <errno.h>
 
+#include <bluetooth/uuid.h>
+
 #include <glib.h>
 #include <gdbus.h>
 
diff --git a/lib/uuid.h b/lib/uuid.h
index 9c082d3..a44426a 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -32,6 +32,22 @@ extern "C" {
 #include <stdint.h>
 #include <bluetooth/bluetooth.h>
 
+#define GENERIC_AUDIO_UUID	"00001203-0000-1000-8000-00805f9b34fb"
+
+#define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
+#define HSP_AG_UUID		"00001112-0000-1000-8000-00805f9b34fb"
+
+#define HFP_HS_UUID		"0000111e-0000-1000-8000-00805f9b34fb"
+#define HFP_AG_UUID		"0000111f-0000-1000-8000-00805f9b34fb"
+
+#define ADVANCED_AUDIO_UUID	"0000110d-0000-1000-8000-00805f9b34fb"
+
+#define A2DP_SOURCE_UUID	"0000110a-0000-1000-8000-00805f9b34fb"
+#define A2DP_SINK_UUID		"0000110b-0000-1000-8000-00805f9b34fb"
+
+#define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
+#define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
1.7.10.130.g36e6c

