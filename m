Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Make amp_mgr_lookup_by_state function static
Date: Sat, 14 Feb 2015 13:36:05 -0800
Message-Id: <1423949767-8669-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The amp_mgr_lookup_by_state function does not need to be exported. So
just move it to a different location and make it static.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 34 +++++++++++++++++-----------------
 net/bluetooth/a2mp.h |  1 -
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index e4f179117ae2..6bba3044dc7f 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -77,6 +77,23 @@ u8 __next_ident(struct amp_mgr *mgr)
 	return mgr->ident;
 }
 
+static struct amp_mgr *amp_mgr_lookup_by_state(u8 state)
+{
+	struct amp_mgr *mgr;
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_for_each_entry(mgr, &amp_mgr_list, list) {
+		if (test_and_clear_bit(state, &mgr->state)) {
+			amp_mgr_get(mgr);
+			mutex_unlock(&amp_mgr_list_lock);
+			return mgr;
+		}
+	}
+	mutex_unlock(&amp_mgr_list_lock);
+
+	return NULL;
+}
+
 /* hci_dev_list shall be locked */
 static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl)
 {
@@ -862,23 +879,6 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 	return mgr->a2mp_chan;
 }
 
-struct amp_mgr *amp_mgr_lookup_by_state(u8 state)
-{
-	struct amp_mgr *mgr;
-
-	mutex_lock(&amp_mgr_list_lock);
-	list_for_each_entry(mgr, &amp_mgr_list, list) {
-		if (test_and_clear_bit(state, &mgr->state)) {
-			amp_mgr_get(mgr);
-			mutex_unlock(&amp_mgr_list_lock);
-			return mgr;
-		}
-	}
-	mutex_unlock(&amp_mgr_list_lock);
-
-	return NULL;
-}
-
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev)
 {
 	struct amp_mgr *mgr;
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 883266602cbc..652117ebf2a5 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -134,7 +134,6 @@ int amp_mgr_put(struct amp_mgr *mgr);
 u8 __next_ident(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
-struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 void a2mp_discover_amp(struct l2cap_chan *chan);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
-- 
2.1.0

