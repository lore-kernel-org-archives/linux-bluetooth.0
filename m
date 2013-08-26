Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix handling of getsockname() for HCI sockets
Date: Mon, 26 Aug 2013 00:20:37 -0700
Message-Id: <1377501637-40861-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_dev check is not protected and so move it into the socket lock. In
addition return the HCI channel identifier instead of always 0 channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d858941..49c5c62 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -695,25 +695,30 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
 {
 	struct sockaddr_hci *haddr = (struct sockaddr_hci *) addr;
 	struct sock *sk = sock->sk;
-	struct hci_dev *hdev = hci_pi(sk)->hdev;
+	struct hci_dev *hdev;
+	int err = 0;
 
 	BT_DBG("sock %p sk %p", sock, sk);
 
 	if (peer)
 		return -EOPNOTSUPP;
 
-	if (!hdev)
-		return -EBADFD;
-
 	lock_sock(sk);
 
+	hdev = hci_pi(sk)->hdev;
+	if (!hdev) {
+		err = -EBADFD;
+		goto done;
+	}
+
 	*addr_len = sizeof(*haddr);
 	haddr->hci_family = AF_BLUETOOTH;
 	haddr->hci_dev    = hdev->id;
-	haddr->hci_channel= 0;
+	haddr->hci_channel= hci_pi(sk)->channel;
 
+done:
 	release_sock(sk);
-	return 0;
+	return err;
 }
 
 static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
-- 
1.8.3.1

