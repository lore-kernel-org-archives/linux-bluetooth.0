Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH 01/10] battery: Add generic device battery documentation
Date: Tue, 11 Sep 2012 10:38:12 +0300
Message-ID: <1347349100-24228-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1347349100-24228-1-git-send-email-chen.ganir@ti.com>
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add documentation for the generic battery D-Bus interface.
---
 doc/battery-api.txt |   33 +++++++++++++++++++++++++++++++++
 doc/device-api.txt  |    5 +++++
 2 files changed, 38 insertions(+)
 create mode 100644 doc/battery-api.txt

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
new file mode 100644
index 0000000..d5ef5ed
--- /dev/null
+++ b/doc/battery-api.txt
@@ -0,0 +1,33 @@
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
+		void Refresh()
+
+			Refresh the batterty level. If the battery level changed, the
+			PropertyChanged signal will be sent with the new value.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	uint16 Level [readonly]
+
+			Battery level (0-100).
+
+
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

