Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] core/device: Promote LE related properties to stable
Date: Mon, 18 Jul 2016 14:49:06 +0300
Message-Id: <1468842547-7088-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1468842547-7088-1-git-send-email-luiz.dentz@gmail.com>
References: <1468842547-7088-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This promotes ManufacturerData, ServiceData, TxPower and ServicesResolved
to stable since those might be needed in order to take advantage of the
GATT D-Bus APIs.
---
 doc/device-api.txt |  4 ++--
 src/device.c       | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 96832e8..087efb9 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -196,7 +196,7 @@ Properties	string Address [readonly]
 			Received Signal Strength Indicator of the remote
 			device (inquiry or advertising).
 
-		int16 TxPower [readonly, optional, experimental]
+		int16 TxPower [readonly, optional]
 
 			Advertised transmitted power level (inquiry or
 			advertising).
@@ -212,7 +212,7 @@ Properties	string Address [readonly]
 			Service advertisement data. Keys are the UUIDs in
 			string format followed by its byte array value.
 
-		bool ServicesResolved [readonly, experimental]
+		bool ServicesResolved [readonly]
 
 			Indicate whether or not service discovery has been
 			resolved.
diff --git a/src/device.c b/src/device.c
index 82704f8..264d599 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2523,16 +2523,12 @@ static const GDBusPropertyTable device_properties[] = {
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
 	{ "ManufacturerData", "a{qv}", dev_property_get_manufacturer_data,
-				NULL, dev_property_manufacturer_data_exist,
-				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+				NULL, dev_property_manufacturer_data_exist },
 	{ "ServiceData", "a{sv}", dev_property_get_service_data,
-				NULL, dev_property_service_data_exist,
-				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+				NULL, dev_property_service_data_exist },
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
-					dev_property_exists_tx_power,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+					dev_property_exists_tx_power },
+	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
 
 	{ }
 };
-- 
2.7.4

