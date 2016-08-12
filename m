Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix bt_sock_recvmsg when MSG_TRUNC is not set
Date: Fri, 12 Aug 2016 15:11:28 +0300
Message-Id: <1471003888-27124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit b5f34f9420b50c9b5876b9a2b68e96be6d629054 attempt to introduce
proper handling for MSG_TRUNC but recv and variants should still work
as read if no flag is passed, but because the code may set MSG_TRUNC to
msg->msg_flags that shall not be used as it may cause it to be behave as
if MSG_TRUNC is always, so instead of using it this changes the code to
use the flags parameter which shall contain the original flags.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index b8a5caf..1d96ff3 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -251,7 +251,7 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	if (msg->msg_flags & MSG_TRUNC)
+	if (flags & MSG_TRUNC)
 		copied = skblen;
 
 	return err ? : copied;
-- 
2.7.4

