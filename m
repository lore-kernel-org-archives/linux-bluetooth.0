Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Add HCI CMSG details only to raw sockets
Date: Mon, 20 Feb 2012 11:58:38 +0100
Message-Id: <1329735520-23539-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI CMSG specific data is for raw sockets only. So only add them to
actual raw sockets.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d729dd7..3d4d669 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -488,7 +488,11 @@ static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	skb_reset_transport_header(skb);
 	err = skb_copy_datagram_iovec(skb, 0, msg->msg_iov, copied);
 
-	hci_sock_cmsg(sk, msg, skb);
+	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_RAW:
+		hci_sock_cmsg(sk, msg, skb);
+		break;
+	}
 
 	skb_free_datagram(sk, skb);
 
-- 
1.7.7.6

