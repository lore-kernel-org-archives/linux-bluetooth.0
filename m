Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 08/20] Bluetooth: AMP: Remote AMP ctrl definitions
Date: Tue, 24 Jul 2012 16:21:49 +0300
Message-Id: <1343136121-22476-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create remote AMP controllers structure. It is used to keep information
about discovered remote AMP controllers by A2MP protocol.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 ++
 include/net/bluetooth/pal.h  |   14 ++++++++
 net/bluetooth/a2mp.c         |    5 +++
 net/bluetooth/pal.c          |   81 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 012f573..8ba236c 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -29,6 +29,9 @@ struct amp_mgr {
 
 	struct list_head	phy_links;
 	struct mutex		phy_links_lock;
+
+	struct list_head	amp_ctrls;
+	struct mutex		amp_ctrls_lock;
 };
 
 struct a2mp_cmd {
diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 201c501..3223ec2 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -32,6 +32,20 @@ struct phy_link {
 	struct kref		kref;
 };
 
+struct amp_ctrl {
+	struct list_head	list;
+	struct kref		kref;
+	__u8			id;
+	__u16			assoc_len_so_far;
+	__u16			assoc_rem_len;
+	__u16			assoc_len;
+	__u8			*assoc;
+};
+
+int amp_ctrl_put(struct amp_ctrl *ctrl);
+struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr);
+struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
+void amp_ctrl_list_flush(struct amp_mgr *mgr);
 struct phy_link *phylink_add(struct amp_mgr *mgr, u8 local_id, u8 remote_id,
 			     u8 *rem_assoc, u16 assoc_size);
 struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index f711b75..7b4af39 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -595,6 +595,7 @@ static void amp_mgr_destroy(struct kref *kref)
 
 	BT_DBG("mgr %p", mgr);
 
+	amp_ctrl_list_flush(mgr);
 	phylink_list_flush(mgr);
 	kfree(mgr);
 }
@@ -634,6 +635,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 	INIT_LIST_HEAD(&mgr->phy_links);
 	mutex_init(&mgr->phy_links_lock);
 
+	/* Remote AMP ctrl list initialization */
+	INIT_LIST_HEAD(&mgr->amp_ctrls);
+	mutex_init(&mgr->amp_ctrls_lock);
+
 	kref_init(&mgr->kref);
 
 	return mgr;
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index 24fb3aa..335cbc3 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -22,6 +22,87 @@ enum pal_states {
 	DISCONNECTING
 };
 
+/* Remote AMP Controllers handling */
+static void amp_ctrl_get(struct amp_ctrl *ctrl)
+{
+	BT_DBG("ctrl %p orig refcnt %d", ctrl,
+	       atomic_read(&ctrl->kref.refcount));
+
+	kref_get(&ctrl->kref);
+}
+
+static void amp_ctrl_destroy(struct kref *kref)
+{
+	struct amp_ctrl *ctrl = container_of(kref, struct amp_ctrl, kref);
+
+	BT_DBG("ctrl %p", ctrl);
+
+	if (ctrl->assoc)
+		kfree(ctrl->assoc);
+
+	kfree(ctrl);
+}
+
+int amp_ctrl_put(struct amp_ctrl *ctrl)
+{
+	BT_DBG("ctrl %p orig refcnt %d", ctrl,
+	       atomic_read(&ctrl->kref.refcount));
+
+	return kref_put(&ctrl->kref, &amp_ctrl_destroy);
+}
+
+struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr)
+{
+	struct amp_ctrl *ctrl;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return NULL;
+
+	mutex_lock(&mgr->amp_ctrls_lock);
+	list_add(&ctrl->list, &mgr->amp_ctrls);
+	mutex_unlock(&mgr->amp_ctrls_lock);
+
+	kref_init(&ctrl->kref);
+
+	BT_DBG("mgr %p ctrl %p", mgr, ctrl);
+
+	return ctrl;
+}
+
+void amp_ctrl_list_flush(struct amp_mgr *mgr)
+{
+	struct amp_ctrl *ctrl, *n;
+
+	BT_DBG("mgr %p", mgr);
+
+	mutex_lock(&mgr->amp_ctrls_lock);
+	list_for_each_entry_safe(ctrl, n, &mgr->amp_ctrls, list) {
+		list_del(&ctrl->list);
+		amp_ctrl_put(ctrl);
+	}
+	mutex_unlock(&mgr->amp_ctrls_lock);
+}
+
+struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id)
+{
+	struct amp_ctrl *ctrl = NULL;
+
+	mutex_lock(&mgr->amp_ctrls_lock);
+	list_for_each_entry(ctrl, &mgr->amp_ctrls, list) {
+		if (ctrl->id == id)
+			break;
+	}
+	mutex_unlock(&mgr->amp_ctrls_lock);
+
+	BT_DBG("mgr %p id %d ctrl %p", mgr, id, ctrl);
+
+	if (ctrl)
+		amp_ctrl_get(ctrl);
+
+	return ctrl;
+}
+
 /* Physical Link interface */
 void phylink_get(struct phy_link *plink)
 {
-- 
1.7.9.5

