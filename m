Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 28/34] Bluetooth: A2MP: Manage incoming connections
Date: Thu, 19 Jan 2012 11:20:17 +0200
Message-Id: <1326964823-26747-29-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle incoming A2MP connection by creating AMP manager and
processing A2MP messages.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 +++
 net/bluetooth/a2mp.c         |   11 +++++++++++
 net/bluetooth/l2cap_core.c   |   10 ++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index a748ab0..783f6d4 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -15,6 +15,8 @@
 #ifndef __A2MP_H
 #define __A2MP_H
 
+#include <net/bluetooth/l2cap.h>
+
 #define A2MP_FEAT_EXT	0x8000
 
 struct amp_mgr {
@@ -117,5 +119,6 @@ struct a2mp_physlink_rsp {
 
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
+void a2mp_channel_create(struct l2cap_conn *conn, struct sk_buff *skb);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d4324f6..b40b079 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -507,3 +507,14 @@ struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 finished:
 	return mgr;
 }
+
+void a2mp_channel_create(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct amp_mgr *mgr;
+
+	mgr = amp_mgr_create(conn);
+
+	BT_DBG("mgr: %p chan %p", mgr, mgr->a2mp_chan);
+
+	l2cap_ertm_data_rcv(mgr->a2mp_chan, skb);
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a0d50c..6e4d69a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -56,6 +56,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <net/bluetooth/a2mp.h>
 
 int disable_ertm;
 
@@ -4256,8 +4257,13 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 	chan = l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
-		BT_DBG("unknown cid 0x%4.4x", cid);
-		goto drop;
+		if (cid == L2CAP_CID_A2MP) {
+			a2mp_channel_create(conn, skb);
+			goto done;
+		} else {
+			BT_DBG("unknown cid 0x%4.4x", cid);
+			goto drop;
+		}
 	}
 
 	sk = chan->sk;
-- 
1.7.4.1

