Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 26/34] Bluetooth: Clean up l2cap_chan_add
Date: Thu, 19 Jan 2012 11:20:15 +0200
Message-Id: <1326964823-26747-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change elseif to switch

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0ac81cc..a99009e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -320,7 +320,8 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	chan->conn = conn;
 
-	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
+	switch (chan->chan_type) {
+	case L2CAP_CHAN_CONN_ORIENTED:
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
 			chan->omtu = L2CAP_LE_DEFAULT_MTU;
@@ -331,12 +332,16 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 			chan->scid = l2cap_alloc_cid(conn);
 			chan->omtu = L2CAP_DEFAULT_MTU;
 		}
-	} else if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
+		break;
+
+	case L2CAP_CHAN_CONN_LESS:
 		/* Connectionless socket */
 		chan->scid = L2CAP_CID_CONN_LESS;
 		chan->dcid = L2CAP_CID_CONN_LESS;
 		chan->omtu = L2CAP_DEFAULT_MTU;
-	} else {
+		break;
+
+	default:
 		/* Raw socket can send/recv signalling messages only */
 		chan->scid = L2CAP_CID_SIGNALING;
 		chan->dcid = L2CAP_CID_SIGNALING;
-- 
1.7.4.1

