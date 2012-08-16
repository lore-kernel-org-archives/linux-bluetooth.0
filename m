Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 01/10] Battery: Add Battery Service Gatt Client
Date: Thu, 16 Aug 2012 12:34:54 +0300
Message-ID: <1345109702-5698-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add documentation for new GATT Client Battery service plugin
---
 doc/battery-api.txt |   26 ++++++++++++++++++++++++++
 doc/device-api.txt  |    5 +++++
 2 files changed, 31 insertions(+)
 create mode 100644 doc/battery-api.txt

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
new file mode 100644
index 0000000..6e20a6a
--- /dev/null
+++ b/doc/battery-api.txt
@@ -0,0 +1,26 @@
+BlueZ D-Bus Battery API description
+****************************************
+
+	Texas Instruments, Inc. <chen.ganir@ti.com>
+
+Battery Service hierarchy
+=====================================
+
+Service		org.bluez
+Interface	org.bluez.Battery
+Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATT-NN-DDDD
+
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
+Properties	byte Level [readonly]
+
+			Battery level (0-100).
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1f0dc96..5d760b1 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -179,3 +179,8 @@ Properties	string Address [readonly]
 			Note that this property can exhibit false-positives
 			in the case of Bluetooth 2.1 (or newer) devices that
 			have disabled Extended Inquiry Response support.
+
+		array{string} Batteries [readonly]
+
+			List of device battery object paths that represents the available
+			batteries on the remote device.
-- 
1.7.9.5

