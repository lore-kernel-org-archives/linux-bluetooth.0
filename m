Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 01/17] android/socket: Add connect signal to socket
Date: Mon, 18 Nov 2013 15:20:38 +0200
Message-Id: <1384780854-20970-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Connect signal is used to pass information to framework that socket
is accepted.
---
 android/socket.h |    7 +++++++
 1 file changed, 7 insertions(+)

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

