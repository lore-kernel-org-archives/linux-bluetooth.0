Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add management command for adding devices for passive scanning
Date: Sun, 29 Jun 2014 11:49:16 +0200
Message-Id: <1404035356-37352-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d329d4a66d9c..d428f7718512 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1866,6 +1866,68 @@ Get Clock Information Command
 				Invalid Index
 
 
+Add Device Command
+==================
+
+	Command Code:		0x0034
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Action (1 Octet)
+	Return Parameters:
+
+	This command is used to add a device to the action list. The
+	action list allows scanning for devices and auto-connection
+	to known devices.
+
+	Possible values for the Action parameter:
+		0	Background scan for device
+		1	Auto-connect device
+
+	With the Action 0, when the device is found, a new Device Found
+	event will be send indicating this device is available. Devices
+	using direct advertising will be connected.
+
+	With the Action 1, when the device is found, it will be connected
+	and if successful a Device Connected event will be send.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Invalid Parameters
+				Invalid Index
+
+
+Remove Device Command
+=====================
+
+	Command Code:		0x0035
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:
+
+	This command is used to remove a device from the action list
+	previously added by using the Add Device command.
+
+	When the Address parameter is 00:00:00:00:00:00, then all
+	previously added devices wil be removed.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.9.3

