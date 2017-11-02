Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v5 1/2] battery: Add BT SIG reserved number used by Battery Service
Date: Thu,  2 Nov 2017 15:38:46 +0100
Message-Id: <20171102143847.3614-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the Battery Level UUID as per:
https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.battery_level.xml
---
 lib/uuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2c57a3378..7e13e0fda 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -119,6 +119,7 @@ extern "C" {
 #define GATT_CHARAC_RECONNECTION_ADDRESS		0x2A03
 #define GATT_CHARAC_PERIPHERAL_PREF_CONN		0x2A04
 #define GATT_CHARAC_SERVICE_CHANGED			0x2A05
+#define GATT_CHARAC_BATTERY_LEVEL			0x2A19
 #define GATT_CHARAC_SYSTEM_ID				0x2A23
 #define GATT_CHARAC_MODEL_NUMBER_STRING			0x2A24
 #define GATT_CHARAC_SERIAL_NUMBER_STRING		0x2A25
-- 
2.14.3

