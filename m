Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 09/16] Bluetooth: lock socket in defer_cb call
Date: Wed, 12 Dec 2012 02:13:37 -0200
Message-Id: <1355285624-25811-10-git-send-email-gustavo@padovan.org>
In-Reply-To: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Since we removed the lock around the ops->defer() call inside
l2cap_core.c we need now to protect the defer_cb call.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_sock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a6ecf58..c8bbe4e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1095,11 +1095,15 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 
 static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->data;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent, *sk = chan->data;
+
+	lock_sock(sk);
 
+	parent = bt_sk(sk)->parent;
 	if (parent)
 		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
 }
 
 static struct l2cap_ops l2cap_chan_ops = {
-- 
1.7.11.7

