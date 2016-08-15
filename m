Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix hci_sock_recvmsg when MSG_TRUNC is not set
Date: Mon, 15 Aug 2016 16:02:20 +0300
Message-Id: <1471266140-6901-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Similar to bt_sock_recvmsg MSG_TRUNC shall be checked using the original
flags not msg_flags.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6ef8a01..96f04b7 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1091,7 +1091,7 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	skb_free_datagram(sk, skb);
 
-	if (msg->msg_flags & MSG_TRUNC)
+	if (flags & MSG_TRUNC)
 		copied = skblen;
 
 	return err ? : copied;
-- 
2.7.4

