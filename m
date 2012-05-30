Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 10/15] input: Move UUID defintion to core
Date: Wed, 30 May 2012 15:00:03 +0200
Message-Id: <1338382808-29725-11-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 input/device.c  |    1 +
 input/device.h  |    3 ---
 input/manager.c |    1 +
 input/server.c  |    1 +
 src/uuid.h      |    2 ++
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/input/device.c b/input/device.c
index e2c48b9..1989384 100644
--- a/input/device.c
+++ b/input/device.c
@@ -50,6 +50,7 @@
 #include "../src/storage.h"
 #include "../src/manager.h"
 #include "../src/dbus-common.h"
+#include "../src/uuid.h"
 
 #include "device.h"
 #include "error.h"
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
index 4ac5686..2a523dc 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -37,6 +37,7 @@
 #include "log.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "../src/uuid.h"
 
 #include "device.h"
 #include "server.h"
diff --git a/input/server.c b/input/server.c
index 17e7547..b42a00f 100644
--- a/input/server.c
+++ b/input/server.c
@@ -35,6 +35,7 @@
 #include <dbus/dbus.h>
 
 #include "log.h"
+#include "../src/uuid.h"
 
 #include "glib-helper.h"
 #include "btio.h"
diff --git a/src/uuid.h b/src/uuid.h
index 27e8ab5..4bcc397 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -63,3 +63,5 @@
 #define HDP_UUID		"00001400-0000-1000-8000-00805f9b34fb"
 #define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805f9b34fb"
 #define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
+
+#define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

