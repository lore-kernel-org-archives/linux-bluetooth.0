Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 17/17] Bluetooth: A2MP: Manage incoming connections
Date: Tue, 29 May 2012 13:59:17 +0300
Message-Id: <1338289158-25655-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle incoming A2MP connection by creating AMP manager and
processing A2MP messages.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    4 ++++
 net/bluetooth/a2mp.c         |   16 ++++++++++++++++
 net/bluetooth/l2cap_core.c   |   19 +++++++++++++++----
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 96f9cc2..6a76e0a 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -15,6 +15,8 @@
 #ifndef __A2MP_H
 #define __A2MP_H
 
+#include <net/bluetooth/l2cap.h>
+
 #define A2MP_FEAT_EXT	0x8000
 
 struct amp_mgr {
@@ -118,5 +120,7 @@ struct a2mp_physlink_rsp {
 
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
+struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
+				       struct sk_buff *skb);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 2019fe3..859a055 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -571,3 +571,19 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 
 	return mgr;
 }
+
+struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
+				       struct sk_buff *skb)
+{
+	struct amp_mgr *mgr;
+
+	mgr = amp_mgr_create(conn);
+	if (!mgr) {
+		BT_ERR("Could not create AMP manager");
+		return NULL;
+	}
+
+	BT_DBG("mgr: %p chan %p", mgr, mgr->a2mp_chan);
+
+	return mgr->a2mp_chan;
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 621da9d..953ac53 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -37,6 +37,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <net/bluetooth/a2mp.h>
 
 bool disable_ertm;
 
@@ -5131,10 +5132,20 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 	chan = l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
-		BT_DBG("unknown cid 0x%4.4x", cid);
-		/* Drop packet and return */
-		kfree_skb(skb);
-		return 0;
+		if (cid == L2CAP_CID_A2MP) {
+			chan = a2mp_channel_create(conn, skb);
+			if (!chan) {
+				kfree_skb(skb);
+				return 0;
+			}
+
+			l2cap_chan_lock(chan);
+		} else {
+			BT_DBG("unknown cid 0x%4.4x", cid);
+			/* Drop packet and return */
+			kfree_skb(skb);
+			return 0;
+		}
 	}
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
-- 
1.7.9.5

