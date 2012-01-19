Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 08/34] Bluetooth: Make l2cap_chan_add available
Date: Thu, 19 Jan 2012 11:19:57 +0200
Message-Id: <1326964823-26747-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function will be used when creating fixed channels

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap_core.c    |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3c7406f..33acd7d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -850,4 +850,6 @@ int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_ertm_init(struct l2cap_chan *chan);
 int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb);
 
+void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
+
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 643bab8..0ac81cc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -311,7 +311,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
-- 
1.7.4.1

