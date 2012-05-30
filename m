Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 07/15] thermometer: Move UUID definition to core
Date: Wed, 30 May 2012 15:00:00 +0200
Message-Id: <1338382808-29725-8-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/uuid.h                |    6 ++++++
 thermometer/manager.c     |    4 ++--
 thermometer/thermometer.c |    7 ++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/uuid.h b/src/uuid.h
index 66164b8..24a0e72 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -51,3 +51,9 @@
 #define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
 
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
+
+#define HEALTH_THERMOMETER_UUID	"00001809-0000-1000-8000-00805f9b34fb"
+#define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
+#define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
+#define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
+#define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
diff --git a/thermometer/manager.c b/thermometer/manager.c
index 8982beb..a436f38 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -24,6 +24,8 @@
 #include <errno.h>
 #include <bluetooth/uuid.h>
 
+#include "../src/uuid.h"
+
 #include "adapter.h"
 #include "device.h"
 #include "att.h"
@@ -32,8 +34,6 @@
 #include "thermometer.h"
 #include "manager.h"
 
-#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
-
 static DBusConnection *connection = NULL;
 
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4df9d2c..43bd821 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -28,6 +28,8 @@
 #include <errno.h>
 #include <bluetooth/uuid.h>
 
+#include "../src/uuid.h"
+
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
@@ -41,11 +43,6 @@
 
 #define THERMOMETER_INTERFACE "org.bluez.Thermometer"
 
-#define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
-#define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
-#define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
-#define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
-
 /* Temperature measurement flag fields */
 #define TEMP_UNITS		0x01
 #define TEMP_TIME_STAMP		0x02
-- 
1.7.10.130.g36e6c

