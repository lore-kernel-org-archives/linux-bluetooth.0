Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/9] android/ahl-sock: Add connect signal to socket
Date: Mon, 11 Nov 2013 14:37:12 +0200
Message-Id: <1384173438-21708-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Connect signal is used to pass information to framework that socket
is accepted.
---
 android/hal-msg.h |    2 ++
 android/socket.h  |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 569c8ea..68cc8ed 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -232,6 +232,8 @@ struct hal_cmd_sock_connect {
 	uint8_t  flags;
 } __attribute__((packed));
 
+/* Bluetooth Hidhost HAL api */
+
 #define HAL_OP_HIDHOST_CONNECT		0x01
 struct hal_cmd_hidhost_connect {
 	uint8_t bdaddr[6];
diff --git a/android/socket.h b/android/socket.h
index 7aa5574..ba56c9b 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -21,6 +21,13 @@
  *
  */
 
+struct hal_sock_connect_signal {
+	short   size;
+	uint8_t bdaddr[6];
+	int     channel;
+	int     status;
+} __attribute__((packed));
+
 void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
 bool bt_socket_register(int sk, const bdaddr_t *addr);
-- 
1.7.10.4

