Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v3 1/2] battery: Add BT SIG reserved numbers used by Battery Service
Date: Tue, 24 Oct 2017 14:36:25 +0200
Message-Id: <20171024123626.19147-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the Battery Level and Battery Power State UUIDs as per:
https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.battery_level.xml
https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.battery_power_state.xml
---
 lib/uuid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2c57a3378..614b3c4e4 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -119,6 +119,8 @@ extern "C" {
 #define GATT_CHARAC_RECONNECTION_ADDRESS		0x2A03
 #define GATT_CHARAC_PERIPHERAL_PREF_CONN		0x2A04
 #define GATT_CHARAC_SERVICE_CHANGED			0x2A05
+#define GATT_CHARAC_BATTERY_LEVEL			0x2A19
+#define GATT_CHARAC_BATTERY_POWER_STATE			0x2A1A
 #define GATT_CHARAC_SYSTEM_ID				0x2A23
 #define GATT_CHARAC_MODEL_NUMBER_STRING			0x2A24
 #define GATT_CHARAC_SERIAL_NUMBER_STRING		0x2A25
-- 
2.14.2

