Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2] gatt: Update characteristic names translation table
Date: Mon, 12 Nov 2012 13:08:48 +0100
Message-ID: <1352722128-12100-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/attrib/client.c b/attrib/client.c
index cda5bc0..51c2b83 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -115,9 +115,16 @@ static const struct {
 	{ "00002a44-0000-1000-8000-00805f9b34fb", "Alert Notification Control Point" },
 	{ "00002a3f-0000-1000-8000-00805f9b34fb", "Alert Status" },
 	{ "00002a01-0000-1000-8000-00805f9b34fb", "Appearance" },
+	{ "00002a19-0000-1000-8000-00805f9b34fb", "Battery Level" },
+	{ "00002a1b-0000-1000-8000-00805f9b34fb", "Battery Level State" },
 	{ "00002a49-0000-1000-8000-00805f9b34fb", "Blood Pressure Feature" },
 	{ "00002a35-0000-1000-8000-00805f9b34fb", "Blood Pressure Measurement" },
 	{ "00002a38-0000-1000-8000-00805f9b34fb", "Body Sensor Location" },
+	{ "00002a22-0000-1000-8000-00805f9b34fb", "Boot Keyboard Input Report" },
+	{ "00002a32-0000-1000-8000-00805f9b34fb", "Boot Keyboard Output Report" },
+	{ "00002a33-0000-1000-8000-00805f9b34fb", "Boot Mouse Input Report" },
+	{ "00002a5c-0000-1000-8000-00805f9b34fb", "CSC Feature" },
+	{ "00002a5b-0000-1000-8000-00805f9b34fb", "CSC Measurement" },
 	{ "00002a2b-0000-1000-8000-00805f9b34fb", "Current Time" },
 	{ "00002a08-0000-1000-8000-00805f9b34fb", "Date Time" },
 	{ "00002a0a-0000-1000-8000-00805f9b34fb", "Day Date Time" },
@@ -126,9 +133,14 @@ static const struct {
 	{ "00002a0d-0000-1000-8000-00805f9b34fb", "DST Offset" },
 	{ "00002a0c-0000-1000-8000-00805f9b34fb", "Exact Time 256" },
 	{ "00002a26-0000-1000-8000-00805f9b34fb", "Firmware Revision String" },
+	{ "00002a51-0000-1000-8000-00805f9b34fb", "Glucose Feature" },
+	{ "00002a18-0000-1000-8000-00805f9b34fb", "Glucose Measurement" },
+	{ "00002a34-0000-1000-8000-00805f9b34fb", "Glucose Measurement Context" },
 	{ "00002a27-0000-1000-8000-00805f9b34fb", "Hardware Revision String" },
 	{ "00002a39-0000-1000-8000-00805f9b34fb", "Heart Rate Control Point" },
 	{ "00002a37-0000-1000-8000-00805f9b34fb", "Heart Rate Measurement" },
+	{ "00002a4c-0000-1000-8000-00805f9b34fb", "HID Control Point" },
+	{ "00002a4a-0000-1000-8000-00805f9b34fb", "HID Information" },
 	{ "00002a2a-0000-1000-8000-00805f9b34fb", "IEEE 11073-20601 Regulatory" },
 	{ "00002a36-0000-1000-8000-00805f9b34fb", "Intermediate Cuff Pressure" },
 	{ "00002a1e-0000-1000-8000-00805f9b34fb", "Intermediate Temperature" },
@@ -139,10 +151,21 @@ static const struct {
 	{ "00002a46-0000-1000-8000-00805f9b34fb", "New Alert" },
 	{ "00002a04-0000-1000-8000-00805f9b34fb", "Peripheral Preferred Connection Parameters" },
 	{ "00002a02-0000-1000-8000-00805f9b34fb", "Peripheral Privacy Flag" },
+	{ "00002a50-0000-1000-8000-00805f9b34fb", "PnP ID" },
+	{ "00002a4e-0000-1000-8000-00805f9b34fb", "Protocol Mode" },
 	{ "00002a03-0000-1000-8000-00805f9b34fb", "Reconnection Address" },
+	{ "00002a52-0000-1000-8000-00805f9b34fb", "Record Access Control Point" },
 	{ "00002a14-0000-1000-8000-00805f9b34fb", "Reference Time Information" },
+	{ "00002a4d-0000-1000-8000-00805f9b34fb", "Report" },
+	{ "00002a4b-0000-1000-8000-00805f9b34fb", "Report Map" },
 	{ "00002a40-0000-1000-8000-00805f9b34fb", "Ringer Control Point" },
 	{ "00002a41-0000-1000-8000-00805f9b34fb", "Ringer Setting" },
+	{ "00002a54-0000-1000-8000-00805f9b34fb", "RSC Feature" },
+	{ "00002a53-0000-1000-8000-00805f9b34fb", "RSC Measurement" },
+	{ "00002a55-0000-1000-8000-00805f9b34fb", "SC Control Point" },
+	{ "00002a4f-0000-1000-8000-00805f9b34fb", "Scan Interval Window" },
+	{ "00002a31-0000-1000-8000-00805f9b34fb", "Scan Refresh" },
+	{ "00002a5d-0000-1000-8000-00805f9b34fb", "Sensor Location" },
 	{ "00002a25-0000-1000-8000-00805f9b34fb", "Serial Number String" },
 	{ "00002a05-0000-1000-8000-00805f9b34fb", "Service Changed" },
 	{ "00002a28-0000-1000-8000-00805f9b34fb", "Software Revision String" },
-- 
1.8.0

