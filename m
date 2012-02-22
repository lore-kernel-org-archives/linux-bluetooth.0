Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/3] Bluetooth: Add unlocked __l2cap_chan_add function
Date: Wed, 22 Feb 2012 12:43:07 +0200
Message-Id: <1329907389-31173-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329907389-31173-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329907389-31173-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add unlocked L2CAP channel add function. Unlocked version will
be used in later patches.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>
Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c0640b7..0e4f4cb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -300,7 +300,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
@@ -346,8 +346,13 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
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
1.7.9

