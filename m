Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android: Add initial Android Bluetooth Audio protocol API doc
Date: Fri, 13 Dec 2013 14:41:20 +0200
Message-Id: <1386938480-12049-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This IPC is used to communicate Android BlueZ daemon and AudioFlinger
plugin.
---
 android/audio-ipc-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 android/audio-ipc-api.txt

diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
new file mode 100644
index 0000000..e2b85ab
--- /dev/null
+++ b/android/audio-ipc-api.txt
@@ -0,0 +1,50 @@
+Bluetooth Audio Plugin
+======================
+
+The audio plugin happen to be in a different socket but all the rules for
+HAL socket apply here as well, the abstract socket name is
+"\0bluez_audio_socket" (tentative):
+
+	.--Android--.                             .---Audio---.
+	|  daemon   |                             |   Plugin  |
+	|           |          Command            |           |
+	|           | <-------------------------- |           |
+	|           |                             |           |
+	|           | --------------------------> |           |
+	|           |          Response           |           |
+	|           |                             |           |
+	|           |                             |           |
+	|           |        Notification         |           |
+	|           | --------------------------> |           |
+	|           |                             |           |
+	'-----------'                             '-----------'
+
+
+Identifier: "audio" (BT_AUDIO_ID)
+
+	Opcode 0x00 - Error response
+
+		Response parameters: Status (1 octet)
+
+	Opcode 0x01 - Register Audio Endpoint commmand
+
+		Command parameters: Service UUID (16 octets)
+				    Codec ID (1 octets)
+				    Codec capabilities length (1 octets)
+				    Codec capabilities (variable)
+				    Number of codec presets (1 octets)
+				    Codec preset # length (1 octets)
+				    Codec preset # configuration (variable)
+				    ...
+		Response parameters: Endpoint ID (1 octets)
+
+	Opcode 0x02 - Unregister Audio Endpoint command
+
+		Command parameters: Endpoint ID (1 octets)
+		Response parameters: <none>
+
+	Opcode 0x81 - New Audio Connection notification
+
+		Notification parameters: Endpoint ID (1 octets)
+					 Codec preset # (1 octets)
+					 File descriptor (inline)
-- 
1.8.3.1

