Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 03/12] android/audio: Add Audio SCO message API
Date: Thu,  8 May 2014 11:01:34 +0300
Message-Id: <1399536103-19052-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

SCO API will be used when communicating with SCO Audio HAL.
---
 android/sco-ipc-api.txt | 36 ++++++++++++++++++++++++++++++++++++
 android/sco-msg.h       | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 android/sco-ipc-api.txt
 create mode 100644 android/sco-msg.h

diff --git a/android/sco-ipc-api.txt b/android/sco-ipc-api.txt
new file mode 100644
index 0000000..75b2cba
--- /dev/null
+++ b/android/sco-ipc-api.txt
@@ -0,0 +1,36 @@
+Bluetooth SCO Audio Plugin
+==========================
+
+The SCO Audio Plugin communicate through abstract socket name
+"\0bluez_sco_socket".
+
+	.---Audio---.                             .--Android--.
+	|  Plugin   |                             |   Daemon  |
+	|           |          Command            |           |
+	|           | --------------------------> |           |
+	|           |                             |           |
+	|           | <-------------------------- |           |
+	|           |          Response           |           |
+	|           |                             |           |
+	|           |                             |           |
+	|           |                             |           |
+	'-----------'                             '-----------'
+
+
+	Audio HAL                               Daemon
+	----------------------------------------------------
+
+	call connect_sco()                    --> create SCO socket
+	return connect_sco()                  <-- return socket fd and mtu
+
+SCO Audio Service (ID 0)
+========================
+
+	Opcode 0x00 - Error response
+
+		Response parameters: Status (1 octet)
+
+	Opcode 0x01 - Connect Audio SCO command
+
+		Command parameters: <none>
+		Response parameters: MTU (2 octets)
diff --git a/android/sco-msg.h b/android/sco-msg.h
new file mode 100644
index 0000000..cd2f894
--- /dev/null
+++ b/android/sco-msg.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+static const char BLUEZ_SCO_SK_PATH[] = "\0bluez_sco_socket";
+
+#define AUDIO_SERVICE_SCO_ID		1
+
+#define AUDIO_STATUS_SUCCESS		IPC_STATUS_SUCCESS
+#define AUDIO_STATUS_FAILED		0x01
+
+#define AUDIO_OP_STATUS			IPC_OP_STATUS
+
+#define AUDIO_OP_CONNECT_SCO		0x01
+struct audio_rsp_connect_sco {
+	uint16_t mtu;
+} __attribute__((packed));
-- 
1.8.3.2

