Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 2/3] Bluetooth: Clean up l2cap_chan_add
Date: Mon,  6 Feb 2012 15:04:00 +0200
Message-Id: <1328533441-29539-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328533441-29539-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328533441-29539-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change elseif to switch. This make sense even more with following
patches which otherwise have to add more elseifs statements.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 80fbfcf..48fc01e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -320,7 +320,8 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	chan->conn = conn;
 
-	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
+	switch (chan->chan_type) {
+	case L2CAP_CHAN_CONN_ORIENTED:
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
 			chan->omtu = L2CAP_LE_DEFAULT_MTU;
@@ -331,12 +332,16 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
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
1.7.8.3

