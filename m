Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <ulrik.lauren@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Fix usage of sk_sndtimeo value
Date: Thu, 10 Nov 2011 10:37:25 +0100
Message-ID: <1320917845-20135-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sk_sndtimeo timeout value is specified in jiffes and should be
converted to miliseconds when used as input to __set_chan_timer.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/l2cap_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f850684..3b0f807 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -446,7 +446,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
 			__clear_chan_timer(chan);
-			__set_chan_timer(chan, sk->sk_sndtimeo);
+			__set_chan_timer(chan, jiffies_to_msecs(sk->sk_sndtimeo));
 			l2cap_send_disconn_req(conn, chan, reason);
 		} else
 			l2cap_chan_del(chan, reason);
@@ -899,7 +899,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__l2cap_chan_add(conn, chan);
 
-	__set_chan_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, jiffies_to_msecs(sk->sk_sndtimeo));
 
 	l2cap_state_change(chan, BT_CONNECTED);
 	parent->sk_data_ready(parent, 0);
@@ -1176,7 +1176,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	l2cap_chan_add(conn, chan);
 
 	l2cap_state_change(chan, BT_CONNECT);
-	__set_chan_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, jiffies_to_msecs(sk->sk_sndtimeo));
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
@@ -2601,7 +2601,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	dcid = chan->scid;
 
-	__set_chan_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, jiffies_to_msecs(sk->sk_sndtimeo));
 
 	chan->ident = cmd->ident;
 
-- 
on behalf of ST-Ericsson

