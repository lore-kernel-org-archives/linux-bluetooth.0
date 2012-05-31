Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 07/14] thermometer: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:31 +0200
Message-Id: <1338471818-20894-8-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h                |    6 ++++++
 thermometer/manager.c     |    2 --
 thermometer/thermometer.c |    5 -----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 71af5ae..d47a6af 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -63,6 +63,12 @@ extern "C" {
 
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
+#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
+#define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
+#define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
+#define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
+#define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/thermometer/manager.c b/thermometer/manager.c
index 8982beb..3d5452b 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -32,8 +32,6 @@
 #include "thermometer.h"
 #include "manager.h"
 
-#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
-
 static DBusConnection *connection = NULL;
 
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4df9d2c..85f0811 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -41,11 +41,6 @@
 
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

