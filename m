Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 01/10] Bluetooth: Change chan_ready param from sk to chan
Date: Fri,  3 Feb 2012 16:36:20 +0200
Message-Id: <1328279789-10870-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change is needed to remove dependency on sk when possible
before introducing l2cap channel lock.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09cd860..80fbfcf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -907,9 +907,9 @@ clean:
 	release_sock(parent);
 }
 
-static void l2cap_chan_ready(struct sock *sk)
+static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct sock *sk = chan->sk;
 	struct sock *parent = bt_sk(sk)->parent;
 
 	BT_DBG("sk %p, parent %p", sk, parent);
@@ -945,7 +945,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
-				l2cap_chan_ready(sk);
+				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
@@ -2874,7 +2874,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		if (chan->mode == L2CAP_MODE_ERTM)
 			l2cap_ertm_init(chan);
 
-		l2cap_chan_ready(sk);
+		l2cap_chan_ready(chan);
 		goto unlock;
 	}
 
@@ -3005,7 +3005,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		if (chan->mode ==  L2CAP_MODE_ERTM)
 			l2cap_ertm_init(chan);
 
-		l2cap_chan_ready(sk);
+		l2cap_chan_ready(chan);
 	}
 
 done:
@@ -4524,7 +4524,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		if (chan->scid == L2CAP_CID_LE_DATA) {
 			if (!status && encrypt) {
 				chan->sec_level = hcon->sec_level;
-				l2cap_chan_ready(sk);
+				l2cap_chan_ready(chan);
 			}
 
 			bh_unlock_sock(sk);
-- 
1.7.8.3

