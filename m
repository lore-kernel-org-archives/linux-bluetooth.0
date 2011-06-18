Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/3] Bluetooth: Fix crash when setting a LE socket to ready
Date: Fri, 17 Jun 2011 22:46:26 -0300
Message-Id: <1308361587-8338-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should not try to do any other type of configuration for
LE links when they become ready.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4af61fb..bbe5306 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -917,11 +917,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		bh_lock_sock(sk);
 
-		if (conn->hcon->type == LE_LINK)
+		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(sk);
 
-		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
 			l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
-- 
1.7.5.4

