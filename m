Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use const for struct l2cap_ops field
Date: Sun,  8 Jun 2014 10:05:31 +0200
Message-Id: <1402214731-4445-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct l2cap_ops field should not allow any modifications and thus
it is better declared as const.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/a2mp.c          | 2 +-
 net/bluetooth/l2cap_sock.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ca1294260de1..18f4f27e0f74 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -579,7 +579,7 @@ struct l2cap_chan {
 	struct list_head	global_l;
 
 	void			*data;
-	struct l2cap_ops	*ops;
+	const struct l2cap_ops	*ops;
 	struct mutex		lock;
 };
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 0b7ec20981f8..1a5b1eb96d1a 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -704,7 +704,7 @@ static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
 	return skb;
 }
 
-static struct l2cap_ops a2mp_chan_ops = {
+static const struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
 	.recv = a2mp_chan_recv_cb,
 	.close = a2mp_chan_close_cb,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f12c855a5a76..a083a24d80ae 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1382,7 +1382,7 @@ static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 	sk->sk_state_change(sk);
 }
 
-static struct l2cap_ops l2cap_chan_ops = {
+static const struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
 	.recv		= l2cap_sock_recv_cb,
-- 
1.9.3

