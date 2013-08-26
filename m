Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix handling of getpeername() for HCI sockets
Date: Mon, 26 Aug 2013 00:06:30 -0700
Message-Id: <1377500790-36821-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI sockets do not have a peer associated with it and so make sure
that getpeername() returns EOPNOTSUPP since this operation is actually
not supported on HCI sockets.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c45ec25..d858941 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -699,6 +699,9 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	BT_DBG("sock %p sk %p", sock, sk);
 
+	if (peer)
+		return -EOPNOTSUPP;
+
 	if (!hdev)
 		return -EBADFD;
 
-- 
1.8.3.1

