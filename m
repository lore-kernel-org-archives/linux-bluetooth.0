Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 10/14] input: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:34 +0200
Message-Id: <1338471818-20894-11-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 input/device.c  |    1 +
 input/device.h  |    3 ---
 input/manager.c |    1 +
 input/server.c  |    1 +
 lib/uuid.h      |    3 +++
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/input/device.c b/input/device.c
index e2c48b9..0e3f4a9 100644
--- a/input/device.c
+++ b/input/device.c
@@ -37,6 +37,7 @@
 #include <bluetooth/hidp.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
diff --git a/input/device.h b/input/device.h
index c14b81a..509a353 100644
--- a/input/device.h
+++ b/input/device.h
@@ -21,9 +21,6 @@
  *
  */
 
-#define HSP_HS_UUID		"00001108-0000-1000-8000-00805F9B34FB"
-#define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
-
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
 
diff --git a/input/manager.c b/input/manager.c
index 4ac5686..5cc552b 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -31,6 +31,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <gdbus.h>
 
diff --git a/input/server.c b/input/server.c
index 17e7547..86e2ac8 100644
--- a/input/server.c
+++ b/input/server.c
@@ -30,6 +30,7 @@
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
diff --git a/lib/uuid.h b/lib/uuid.h
index 32f51b7..7e34259 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -75,6 +75,9 @@ extern "C" {
 #define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805f9b34fb"
 #define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
 
+#define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
+#define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
1.7.10.130.g36e6c

