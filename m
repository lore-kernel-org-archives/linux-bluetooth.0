Return-Path: <cyrus@holtmann.org>
From: Yuri Ershov <ext-yuri.ershov@nokia.com>
To: marcel@holtmann.org, davem@davemloft.net, padovan@profusion.mobi,
        jprvita@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
        andrei.emeltchenko@nokia.com, Yuri Ershov <ext-yuri.ershov@nokia.com>
Subject: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
Date: Thu, 25 Nov 2010 12:55:33 +0300
Message-Id: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is an addition to my previous patch for this issue.
The problem is in resynchronization between two loops:
1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
l2cap_config_rsp, l2cap_disconnect_req, etc.)
2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
bt_accept_dequeue, etc.).
In case of fast sequence of connect/disconnect operations the loop #1
makes several cycles, while the loop #2 only has time to make one
cycle and it results crash.
The aim of the patch is to skeep handling of sockets queued for
deletion.

Signed-off-by: Yuri Ershov <ext-yuri.ershov@nokia.com>
---
 net/bluetooth/af_bluetooth.c |    2 ++
 net/bluetooth/l2cap.c        |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index c4cf3f5..f9389da 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -200,6 +200,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 	BT_DBG("parent %p", parent);
 
 	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
+		if (n == p)
+			break;
 		sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
 
 		lock_sock(sk);
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 12b4aa2..29f30b0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -133,7 +133,8 @@ static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
 	struct sock *s;
 	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
-		if (l2cap_pi(s)->dcid == cid)
+		if ((l2cap_pi(s)->dcid == cid) &&
+		    (sk->sk_state != BT_DISCONN) && (sk->sk_state != BT_CLOSED))
 			break;
 	}
 	return s;
@@ -143,7 +144,8 @@ static struct sock *__l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
 {
 	struct sock *s;
 	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
-		if (l2cap_pi(s)->scid == cid)
+		if ((l2cap_pi(s)->scid == cid) &&
+		    (sk->sk_state != BT_DISCONN) && (sk->sk_state != BT_CLOSED))
 			break;
 	}
 	return s;
-- 
1.6.3.3
