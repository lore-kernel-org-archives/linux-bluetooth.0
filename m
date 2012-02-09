Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 07/16] Bluetooth: Add unlocked __l2cap_chan_add function
Date: Thu,  9 Feb 2012 16:17:28 +0200
Message-Id: <1328797057-26331-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e6515b3..21f9f5d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -324,7 +324,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
@@ -370,8 +370,13 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	l2cap_chan_hold(chan);
 
-	mutex_lock(&conn->chan_lock);
 	list_add(&chan->list, &conn->chan_l);
+}
+
+void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+{
+	mutex_lock(&conn->chan_lock);
+	__l2cap_chan_add(conn, chan);
 	mutex_unlock(&conn->chan_lock);
 }
 
-- 
1.7.8.3

