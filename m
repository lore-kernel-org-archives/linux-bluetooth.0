Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Use GFP_KERNEL for HCI socket allocations
Date: Mon, 20 Feb 2012 11:58:33 +0100
Message-Id: <1329735520-23539-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For all HCI socket allocations it is safe to use GFP_KERNEL since they
are processed in process context now.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9e854d9..43a0491 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -138,7 +138,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
 		}
 
 clone:
-		nskb = skb_clone(skb, GFP_ATOMIC);
+		nskb = skb_clone(skb, GFP_KERNEL);
 		if (!nskb)
 			continue;
 
@@ -731,7 +731,7 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &hci_sock_ops;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hci_sk_proto);
+	sk = sk_alloc(net, PF_BLUETOOTH, GFP_KERNEL, &hci_sk_proto);
 	if (!sk)
 		return -ENOMEM;
 
-- 
1.7.7.6

