Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Make L2CAP chan_add functions static
Date: Fri, 23 Mar 2012 16:31:49 +0200
Message-Id: <1332513110-10507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove sparse warnings below:

...
net/bluetooth/l2cap_core.c:302:6: warning: symbol '__l2cap_chan_add' was
not declared. Should it be static?
net/bluetooth/l2cap_core.c:351:6: warning: symbol 'l2cap_chan_add' was
not declared. Should it be static?
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 887aea0..e66c9da 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -299,7 +299,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			__le16_to_cpu(chan->psm), chan->dcid);
@@ -348,7 +348,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	list_add(&chan->list, &conn->chan_l);
 }
 
-void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	mutex_lock(&conn->chan_lock);
 	__l2cap_chan_add(conn, chan);
-- 
1.7.9.1

