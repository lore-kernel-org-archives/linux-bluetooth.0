Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 04/15] deviceinfo: Move UUID defintion to core
Date: Wed, 30 May 2012 14:59:57 +0200
Message-Id: <1338382808-29725-5-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 deviceinfo/deviceinfo.c |    4 ++--
 deviceinfo/manager.c    |    4 ++--
 src/uuid.h              |    3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 5dd9293..410b8ff 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -27,6 +27,8 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
+#include "../src/uuid.h"
+
 #include "adapter.h"
 #include "device.h"
 #include "gattrib.h"
@@ -37,8 +39,6 @@
 #include "log.h"
 #include "deviceinfo.h"
 
-#define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
-
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
diff --git a/deviceinfo/manager.c b/deviceinfo/manager.c
index c2378c2..52fdf46 100644
--- a/deviceinfo/manager.c
+++ b/deviceinfo/manager.c
@@ -24,6 +24,8 @@
 #include <errno.h>
 #include <bluetooth/uuid.h>
 
+#include "../src/uuid.h"
+
 #include "adapter.h"
 #include "device.h"
 #include "att.h"
@@ -32,8 +34,6 @@
 #include "deviceinfo.h"
 #include "manager.h"
 
-#define DEVICE_INFORMATION_UUID		"0000180a-0000-1000-8000-00805f9b34fb"
-
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_primary *prim = a;
diff --git a/src/uuid.h b/src/uuid.h
index 61ea6e5..7ef19cc 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -41,3 +41,6 @@
 #define NAP_UUID		"00001116-0000-1000-8000-00805f9b34fb"
 #define GN_UUID			"00001117-0000-1000-8000-00805f9b34fb"
 #define BNEP_SVC_UUID		"0000000f-0000-1000-8000-00805f9b34fb"
+
+#define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
+#define DEVICE_INFORMATION_UUID	"0000180a-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

