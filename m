Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Restrict ioctls to HCI raw channel sockets
Date: Mon, 26 Aug 2013 09:39:55 -0700
Message-Id: <1377535195-12121-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The various legacy ioctls used with HCI sockets are limited to raw
channel only. They are not used on the other channels and also have
no meaning there. So return an error if tried to use them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f92e913..ab57038 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -547,6 +547,15 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
+	lock_sock(sk);
+
+	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	release_sock(sk);
+
 	switch (cmd) {
 	case HCIGETDEVLIST:
 		return hci_get_dev_list(argp);
@@ -591,13 +600,15 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 
 	case HCIINQUIRY:
 		return hci_inquiry(argp);
-
-	default:
-		lock_sock(sk);
-		err = hci_sock_bound_ioctl(sk, cmd, arg);
-		release_sock(sk);
-		return err;
 	}
+
+	lock_sock(sk);
+
+	err = hci_sock_bound_ioctl(sk, cmd, arg);
+
+done:
+	release_sock(sk);
+	return err;
 }
 
 static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
-- 
1.8.3.1

