Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 02/13] test: Add UUID alias table to bluezutils.py
Date: Mon,  6 May 2013 10:43:19 +0200
Message-Id: <1367829810-8262-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a helper function to parse human-friendly strings that can be
translated into UUID strings. The input string can be one of the
following types:
	- Full UUID: e.g. "00001108-0000-1000-8000-00805f9b34fb"
	- Short UUID: e.g. "00001108"
	- Alias: e.g. HSP_HS_UUID
	- Short alias: e.g. HSP_HS
---
 test/bluezutils.py | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/test/bluezutils.py b/test/bluezutils.py
index de08cbd..6fc55cb 100644
--- a/test/bluezutils.py
+++ b/test/bluezutils.py
@@ -3,6 +3,64 @@ import dbus
 SERVICE_NAME = "org.bluez"
 ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter1"
 DEVICE_INTERFACE = SERVICE_NAME + ".Device1"
+UUID_ALIAS_TABLE = {
+	"GENERIC_AUDIO_UUID": "00001203-0000-1000-8000-00805f9b34fb",
+	"HSP_HS_UUID": "00001108-0000-1000-8000-00805f9b34fb",
+	"HSP_AG_UUID": "00001112-0000-1000-8000-00805f9b34fb",
+	"HFP_HS_UUID": "0000111e-0000-1000-8000-00805f9b34fb",
+	"HFP_AG_UUID": "0000111f-0000-1000-8000-00805f9b34fb",
+	"ADVANCED_AUDIO_UUID": "0000110d-0000-1000-8000-00805f9b34fb",
+	"A2DP_SOURCE_UUID": "0000110a-0000-1000-8000-00805f9b34fb",
+	"A2DP_SINK_UUID": "0000110b-0000-1000-8000-00805f9b34fb",
+	"AVRCP_REMOTE_UUID": "0000110e-0000-1000-8000-00805f9b34fb",
+	"AVRCP_TARGET_UUID": "0000110c-0000-1000-8000-00805f9b34fb",
+	"PANU_UUID": "00001115-0000-1000-8000-00805f9b34fb",
+	"NAP_UUID": "00001116-0000-1000-8000-00805f9b34fb",
+	"GN_UUID": "00001117-0000-1000-8000-00805f9b34fb",
+	"BNEP_SVC_UUID": "0000000f-0000-1000-8000-00805f9b34fb",
+	"PNPID_UUID": "00002a50-0000-1000-8000-00805f9b34fb",
+	"DEVICE_INFORMATION_UUID": "0000180a-0000-1000-8000-00805f9b34fb",
+	"GATT_UUID": "00001801-0000-1000-8000-00805f9b34fb",
+	"IMMEDIATE_ALERT_UUID": "00001802-0000-1000-8000-00805f9b34fb",
+	"LINK_LOSS_UUID": "00001803-0000-1000-8000-00805f9b34fb",
+	"TX_POWER_UUID": "00001804-0000-1000-8000-00805f9b34fb",
+	"SAP_UUID": "0000112D-0000-1000-8000-00805f9b34fb",
+	"HEART_RATE_UUID": "0000180d-0000-1000-8000-00805f9b34fb",
+	"HEART_RATE_MEASUREMENT_UUID": "00002a37-0000-1000-8000-00805f9b34fb",
+	"BODY_SENSOR_LOCATION_UUID": "00002a38-0000-1000-8000-00805f9b34fb",
+	"HEART_RATE_CONTROL_POINT_UUID": "00002a39-0000-1000-8000-00805f9b34fb",
+	"HEALTH_THERMOMETER_UUID": "00001809-0000-1000-8000-00805f9b34fb",
+	"TEMPERATURE_MEASUREMENT_UUID": "00002a1c-0000-1000-8000-00805f9b34fb",
+	"TEMPERATURE_TYPE_UUID": "00002a1d-0000-1000-8000-00805f9b34fb",
+	"INTERMEDIATE_TEMPERATURE_UUID": "00002a1e-0000-1000-8000-00805f9b34fb",
+	"MEASUREMENT_INTERVAL_UUID": "00002a21-0000-1000-8000-00805f9b34fb",
+	"CYCLING_SC_UUID": "00001816-0000-1000-8000-00805f9b34fb",
+	"CSC_MEASUREMENT_UUID": "00002a5b-0000-1000-8000-00805f9b34fb",
+	"CSC_FEATURE_UUID": "00002a5c-0000-1000-8000-00805f9b34fb",
+	"SENSOR_LOCATION_UUID": "00002a5d-0000-1000-8000-00805f9b34fb",
+	"SC_CONTROL_POINT_UUID": "00002a55-0000-1000-8000-00805f9b34fb",
+	"RFCOMM_UUID_STR": "00000003-0000-1000-8000-00805f9b34fb",
+	"HDP_UUID": "00001400-0000-1000-8000-00805f9b34fb",
+	"HDP_SOURCE_UUID": "00001401-0000-1000-8000-00805f9b34fb",
+	"HDP_SINK_UUID": "00001402-0000-1000-8000-00805f9b34fb",
+	"HSP_HS_UUID": "00001108-0000-1000-8000-00805f9b34fb",
+	"HID_UUID": "00001124-0000-1000-8000-00805f9b34fb",
+	"DUN_GW_UUID": "00001103-0000-1000-8000-00805f9b34fb",
+	"GAP_UUID": "00001800-0000-1000-8000-00805f9b34fb",
+	"PNP_UUID": "00001200-0000-1000-8000-00805f9b34fb",
+	"SPP_UUID": "00001101-0000-1000-8000-00805f9b34fb",
+	"OBEX_SYNC_UUID": "00001104-0000-1000-8000-00805f9b34fb",
+	"OBEX_OPP_UUID": "00001105-0000-1000-8000-00805f9b34fb",
+	"OBEX_FTP_UUID": "00001106-0000-1000-8000-00805f9b34fb",
+	"OBEX_PCE_UUID": "0000112e-0000-1000-8000-00805f9b34fb",
+	"OBEX_PSE_UUID": "0000112f-0000-1000-8000-00805f9b34fb",
+	"OBEX_PBAP_UUID": "00001130-0000-1000-8000-00805f9b34fb",
+	"OBEX_MAS_UUID": "00001132-0000-1000-8000-00805f9b34fb",
+	"OBEX_MNS_UUID": "00001133-0000-1000-8000-00805f9b34fb",
+	"OBEX_MAP_UUID": "00001134-0000-1000-8000-00805f9b34fb"
+}
+
+INV_UUID_ALIAS_TABLE = { v:k for k, v in UUID_ALIAS_TABLE.items() }
 
 def get_managed_objects():
 	bus = dbus.SystemBus()
@@ -45,3 +103,29 @@ def find_device_in_objects(objects, device_address, adapter_pattern=None):
 			return dbus.Interface(obj, DEVICE_INTERFACE)
 
 	raise Exception("Bluetooth device not found")
+
+def parse_uuid(s):
+	hex_digits = "0123456789abcdef"
+	uuid_digits = hex_digits + "-"
+	suffix = "-0000-1000-8000-00805f9b34fb"
+	short_len = 8
+	long_len = short_len + len(suffix)
+	us = s.upper()
+	ls = s.lower()
+
+	uuid = UUID_ALIAS_TABLE.get(us)
+	if uuid is None:
+		uuid = UUID_ALIAS_TABLE.get(us + "_UUID")
+	if not(uuid is None):
+		return uuid
+
+	if len(ls) == short_len and all((c in hex_digits) for c in ls):
+		return ls + suffix
+	elif len(ls) == long_len and all((c in uuid_digits) for c in ls):
+		return ls
+
+	raise Exception("Invalid profile UUID")
+
+def get_uuid_alias(uuid):
+	ul = uuid.lower()
+	return INV_UUID_ALIAS_TABLE.get(ul)
-- 
1.8.1.4

