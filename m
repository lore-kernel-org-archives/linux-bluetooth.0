Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 18/20] Bluetooth: A2MP: Create amp_mgr global list
Date: Mon, 13 Aug 2012 16:50:36 +0300
Message-Id: <1344865838-9165-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1344865838-9165-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1344865838-9165-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create amp_mgr_list which is used for query for phy_link by
phy_link handler.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    4 ++++
 include/net/bluetooth/pal.h  |    1 +
 net/bluetooth/a2mp.c         |   12 ++++++++++++
 net/bluetooth/pal.c          |   28 ++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index f3f0d7e..eaaa3e4 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -20,6 +20,7 @@
 #define A2MP_FEAT_EXT	0x8000
 
 struct amp_mgr {
+	struct list_head	list;
 	struct l2cap_conn	*l2cap_conn;
 	struct l2cap_chan	*a2mp_chan;
 	struct l2cap_chan	*bredr_chan;
@@ -125,6 +126,9 @@ struct a2mp_physlink_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
 #define A2MP_STATUS_SECURITY_VIOLATION		0x06
 
+extern struct list_head amp_mgr_list;
+extern struct mutex amp_mgr_list_lock;
+
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index d9eb87e..55f4d5b 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -48,6 +48,7 @@ void amp_ctrl_list_flush(struct amp_mgr *mgr);
 struct phy_link *phylink_add(struct amp_mgr *mgr, u8 local_id, u8 remote_id,
 			     u8 *rem_assoc, u16 assoc_size);
 struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id);
+struct phy_link *phylink_lookup_by_handle(u8 handle);
 int phylink_put(struct phy_link *plink);
 void phylink_get(struct phy_link *plink);
 void phylink_list_flush(struct amp_mgr *mgr);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b143331..4b6350f 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -21,6 +21,10 @@
 
 static struct workqueue_struct *amp_workqueue;
 
+/* Global AMP Manager list */
+LIST_HEAD(amp_mgr_list);
+DEFINE_MUTEX(amp_mgr_list_lock);
+
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 {
@@ -736,6 +740,10 @@ static void amp_mgr_destroy(struct kref *kref)
 
 	BT_DBG("mgr %p", mgr);
 
+	mutex_lock(&amp_mgr_list_lock);
+	list_del(&mgr->list);
+	mutex_unlock(&amp_mgr_list_lock);
+
 	amp_ctrl_list_flush(mgr);
 	phylink_list_flush(mgr);
 	kfree(mgr);
@@ -780,6 +788,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 	INIT_LIST_HEAD(&mgr->amp_ctrls);
 	mutex_init(&mgr->amp_ctrls_lock);
 
+	mutex_lock(&amp_mgr_list_lock);
+	list_add(&mgr->list, &amp_mgr_list);
+	mutex_unlock(&amp_mgr_list_lock);
+
 	kref_init(&mgr->kref);
 
 	return mgr;
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index b4eeb6a..f8bb66c 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -222,6 +222,34 @@ struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id)
 	return found;
 }
 
+/* Returns phy_link referenced if found */
+struct phy_link *phylink_lookup_by_handle(u8 handle)
+{
+	struct amp_mgr *mgr;
+	struct phy_link *found = NULL;
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_for_each_entry(mgr, &amp_mgr_list, list) {
+		struct phy_link *plink;
+
+		mutex_lock(&mgr->phy_links_lock);
+		list_for_each_entry(plink, &mgr->phy_links, list) {
+			if (plink->handle == handle) {
+				phylink_get(plink);
+				found = plink;
+				break;
+			}
+		}
+		mutex_unlock(&mgr->phy_links_lock);
+
+		if (found)
+			break;
+	}
+	mutex_unlock(&amp_mgr_list_lock);
+
+	return found;
+}
+
 int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 {
 	int ret = 0;
-- 
1.7.9.5

