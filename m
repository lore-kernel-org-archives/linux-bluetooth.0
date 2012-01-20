Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check for chan_type before locking sk
Date: Fri, 20 Jan 2012 16:35:00 +0200
Message-Id: <1327070100-4852-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Removes un-needed locking/unlocking if chan_type is not
L2CAP_CHAN_CONN_ORIENTED and also protects from locking
zero sk.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b303eae..916ddb1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -770,13 +770,12 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
-		bh_lock_sock(sk);
-
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			bh_unlock_sock(sk);
 			continue;
 		}
 
+		bh_lock_sock(sk);
+
 		if (chan->state == BT_CONNECT) {
 			struct l2cap_conn_req req;
 
-- 
1.7.4.1

