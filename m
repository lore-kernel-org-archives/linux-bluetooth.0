Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v7 1/5] input: Documentation for new Input1 interface
Date: Tue, 16 Apr 2013 14:58:37 -0700
Message-Id: <1366149521-26908-2-git-send-email-deymo@chromium.org>
In-Reply-To: <1366149521-26908-1-git-send-email-deymo@chromium.org>
References: <1366149521-26908-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Adds documentation for a new Input1 interface explaining a new
"ReconnectMode" property that exposes the Connectability mode of
a HID device.
---
 doc/input-api.txt | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 doc/input-api.txt

diff --git a/doc/input-api.txt b/doc/input-api.txt
new file mode 100644
index 0000000..67da08b
--- /dev/null
+++ b/doc/input-api.txt
@@ -0,0 +1,32 @@
+BlueZ D-Bus Input API description
+*********************************
+
+Input hierarchy
+===============
+
+Service		org.bluez
+Interface	org.bluez.Input1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	string ReconnectMode [readonly]
+
+			Determines the Connectability mode of the HID device as
+			defined by the HID Profile specification, Section 5.4.2.
+
+			This mode is based in the two properties
+			HIDReconnectInitiate (see Section 5.3.4.6) and
+			HIDNormallyConnectable (see Section 5.3.4.14) which
+			define the following four possible values:
+
+			"none"		Device and host are not required to
+					automatically restore the connection.
+
+			"host"		Bluetooth HID host restores connection.
+
+			"device"	Bluetooth HID device restores
+					connection.
+
+			"any"		Bluetooth HID device shall attempt to
+					restore the lost connection, but
+					Bluetooth HID Host may also restore the
+					connection.
-- 
1.8.1.3
