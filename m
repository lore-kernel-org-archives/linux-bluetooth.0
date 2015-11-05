Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add mising hci_skb_opcode for raw socket commands
Date: Thu,  5 Nov 2015 10:48:45 +0100
Message-Id: <1446716925-58637-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When HCI commands are injected via the raw socket, the core was not
including the decoded opcode value. So ensure that it is actually set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 62e68232ad62..d70c2b5f0ecd 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1262,6 +1262,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto drop;
 		}
 
+		hci_skb_opcode(skb) = opcode;
+
 		/* Include process credentials */
 		hci_sock_creds_to_skb(skb);
 
-- 
2.5.0

