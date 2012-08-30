Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH RFC] battery: Add generic device battery interface
Date: Thu, 30 Aug 2012 14:26:20 +0300
Message-ID: <1346325980-11411-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1346325980-11411-1-git-send-email-chen.ganir@ti.com>
References: <1346325980-11411-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add the D-Bus API documentation for the new generic device battery
interface. This API provides generic access to peer devcice
batteries.
---
 doc/battery-api.txt |   34 ++++++++++++++++++++++++++++++++++
 doc/device-api.txt  |    5 +++++
 2 files changed, 39 insertions(+)
 create mode 100644 doc/battery-api.txt

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
new file mode 100644
index 0000000..da82024
--- /dev/null
+++ b/doc/battery-api.txt
@@ -0,0 +1,34 @@
+BlueZ D-Bus Battery API description
+****************************************
+
+	Texas Instruments, Inc. <chen.ganir@ti.com>
+
+Device Battery hierarchy
+=====================================
+
+Service		org.bluez
+Interface	org.bluez.Battery
+Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
+YYYY is numeric value between 0 and 9999.
+
+Methods	dict GetProperties()
+
+			Returns all properties for the interface. See the
+			Properties section for the available properties.
+
+Signals		PropertyChanged(string name, variant value)
+
+		This signal indicates a changed value of the given
+		property.
+
+Properties	uint16 Level [readonly]
+
+			Battery level (0-100).
+
+		uint16 Description [readonly]
+
+			Battery description.
+
+		uint16 Namespace [readonly]
+
+			Battery Namespace.
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1f0dc96..c98d539 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -179,3 +179,8 @@ Properties	string Address [readonly]
 			Note that this property can exhibit false-positives
 			in the case of Bluetooth 2.1 (or newer) devices that
 			have disabled Extended Inquiry Response support.
+
+		array{object} Batteries [readonly]
+
+			List of device battery object paths that represents the available
+			batteries on the remote device.
-- 
1.7.9.5

