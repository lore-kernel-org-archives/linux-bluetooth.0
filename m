Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android: Add audio plugin protocol to API doc
Date: Mon, 21 Oct 2013 10:59:36 +0300
Message-Id: <1382342376-6116-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds audio plugin IPC is used to communicate Android BlueZ daemon
and audio plugin.
---
 android/hal-ipc-api.txt | 76 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9a8b770..bc8a128 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1245,3 +1245,79 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x9c - Request Write notification
 	Opcode 0x9d - Request Execute Write notification
 	Opcode 0x9e - Response Confirmation notification
+
+Bluetooth Audio Plugin (ID = 10)
+================================
+
+The audio plugin happen to be in a different socket but all the rules for
+HAL socket apply here as well.
+
+	.--Android--.                             .---Audio---.
+	|  daemon   |                             |   Plugin  |
+	|           |          Command            |           |
+	|           | <-------------------------- |           |
+	|           | --------------------------> |           |
+	|           |          Response           |           |
+	|           |                             |           |
+	|           |                             |           |
+	|           |        Notification         |           |
+	|           | --------------------------> |           |
+	|           |                             |           |
+	'-----------'                             '-----------'
+
+Android HAL name: "audio" (BT_AUDIO_ID)
+
+	Opcode 0x00 - Error response
+
+		Response parameters: Status (1 octet)
+
+		Valid status values: 0x01 = Fail
+		                     0x02 = Not ready
+		                     0x03 = No memory
+		                     0x04 = Busy
+		                     0x05 = Done (already completed)
+		                     0x06 = Unsupported
+		                     0x07 = Parameter invalid
+		                     0x08 = Unhandled
+		                     0x09 = Authentication failure
+		                     0x0a = Remote device down
+
+	Opcode 0x01 - Register Audio Endpoint commmand
+
+		Command parameters: Service UUID (16 octets)
+		                    Codec ID (1 octets)
+		                    Codec capabilities length (1 octets)
+		                    Codec capabilities (variable)
+		                    Codec configuration length (1 octets)
+		                    Codec configuration (variable)
+		Response parameters: Endpoint ID (1 octets)
+
+	Opcode 0x02 - Unregister Audio Endpoint command
+
+		Command parameters: Endpoint ID (1 octets)
+
+	Opcode 0x03 - Resume Audio command
+
+		Command parameters: Endpoint ID (1 octets)
+
+	Opcode 0x04 - Suspend Audio command
+
+		Command parameters: Endpoint ID (1 octets)
+
+Notifications:
+
+	Opcode 0x80 - Audio State Changed notification
+
+		Notification paremters: Endpoint ID (1 octets)
+		                        State (1 octets)
+
+		Valid state values: 0x01 = Idle
+		                    0x02 = Suspended
+		                    0x03 = Running
+
+	Opcode 0x81 - New Audio Connection notification
+
+		Notification parameters: Endpoint ID (1 octets)
+		                         Codec configuration length (1 octets)
+		                         Codec configuration (variable)
+		                         File descriptor (inline)
-- 
1.8.3.1

