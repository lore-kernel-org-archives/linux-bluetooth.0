Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCHv6 07/17] Bluetooth: AMP: Remote AMP ctrl definitions
Date: Tue, 18 Sep 2012 17:28:19 +0300
Message-Id: <1347978509-12133-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347978509-12133-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347978509-12133-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create remote AMP controllers structure. It is used to keep information
about discovered remote AMP controllers by A2MP protocol.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 ++
 include/net/bluetooth/amp.h  |   15 ++++++++
 net/bluetooth/a2mp.c         |    5 +++
 net/bluetooth/amp.c          |   79 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index d547671..99c7389 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -33,6 +33,9 @@ struct amp_mgr {
 	__u8			handle;
 	enum amp_mgr_state	state;
 	unsigned long		flags;
+
+	struct list_head	amp_ctrls;
+	struct mutex		amp_ctrls_lock;
 };
 
 struct a2mp_cmd {
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 3414dfd..f57854f 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -14,6 +14,21 @@
 #ifndef __AMP_H
 #define __AMP_H
 
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
+
 struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 			     u8 remote_id);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index f04c441..35e188c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -594,6 +594,7 @@ static void amp_mgr_destroy(struct kref *kref)
 	list_del(&mgr->list);
 	mutex_unlock(&amp_mgr_list_lock);
 
+	amp_ctrl_list_flush(mgr);
 	kfree(mgr);
 }
 
@@ -630,6 +631,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 
 	kref_init(&mgr->kref);
 
+	/* Remote AMP ctrl list initialization */
+	INIT_LIST_HEAD(&mgr->amp_ctrls);
+	mutex_init(&mgr->amp_ctrls_lock);
+
 	mutex_lock(&amp_mgr_list_lock);
 	list_add(&mgr->list, &amp_mgr_list);
 	mutex_unlock(&amp_mgr_list_lock);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 50a7b2f..b26ca7c 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -17,6 +17,85 @@
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/amp.h>
 
+/* Remote AMP Controllers interface */
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
+	kfree(ctrl->assoc);
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
 static u8 __next_handle(struct amp_mgr *mgr)
 {
-- 
1.7.9.5
