Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded parenthesis around MSG_OOB
Date: Sun, 25 Oct 2015 22:45:18 +0100
Message-Id: <1445809518-44473-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are two checks that are still using (MSG_OOB) instead of just
MSG_OOB and so lets just fix them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 net/bluetooth/hci_sock.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index c55717929213..a3bffd1ec2b4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -221,7 +221,7 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	BT_DBG("sock %p sk %p len %zu", sock, sk, len);
 
-	if (flags & (MSG_OOB))
+	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 77e816f91a61..b1eb8c09a660 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1001,7 +1001,7 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	if (flags & (MSG_OOB))
+	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
 	if (sk->sk_state == BT_CLOSED)
-- 
2.4.3

