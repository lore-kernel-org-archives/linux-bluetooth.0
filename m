Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 4/7] Bluetooth: AMP: Factor out amp_ctrl_add
Date: Fri,  5 Oct 2012 16:56:55 +0300
Message-Id: <1349445419-16788-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add ctrl_id parameter to amp_ctrl_add since we always set it
after function ctrl is created.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    2 +-
 net/bluetooth/a2mp.c        |    8 ++------
 net/bluetooth/amp.c         |    7 ++++---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index b1e5490..ae2c3e5 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -26,7 +26,7 @@ struct amp_ctrl {
 
 int amp_ctrl_put(struct amp_ctrl *ctrl);
 void amp_ctrl_get(struct amp_ctrl *ctrl);
-struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr);
+struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr, u8 id);
 struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
 void amp_ctrl_list_flush(struct amp_mgr *mgr);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d4946b5..88a4b58 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -316,12 +316,10 @@ static int a2mp_getinfo_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	if (rsp->status)
 		return -EINVAL;
 
-	ctrl = amp_ctrl_add(mgr);
+	ctrl = amp_ctrl_add(mgr, rsp->id);
 	if (!ctrl)
 		return -ENOMEM;
 
-	ctrl->id = rsp->id;
-
 	req.id = rsp->id;
 	a2mp_send(mgr, A2MP_GETAMPASSOC_REQ, __next_ident(mgr), sizeof(req),
 		  &req);
@@ -461,7 +459,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	ctrl = amp_ctrl_lookup(mgr, rsp.remote_id);
 	if (!ctrl) {
-		ctrl = amp_ctrl_add(mgr);
+		ctrl = amp_ctrl_add(mgr, rsp.remote_id);
 		if (ctrl) {
 			amp_ctrl_get(ctrl);
 		} else {
@@ -474,8 +472,6 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		size_t assoc_len = le16_to_cpu(hdr->len) - sizeof(*req);
 		u8 *assoc;
 
-		ctrl->id = rsp.remote_id;
-
 		assoc = kzalloc(assoc_len, GFP_KERNEL);
 		if (!assoc) {
 			amp_ctrl_put(ctrl);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index b6e1c3a..2fc5562 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -45,7 +45,7 @@ int amp_ctrl_put(struct amp_ctrl *ctrl)
 	return kref_put(&ctrl->kref, &amp_ctrl_destroy);
 }
 
-struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr)
+struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr, u8 id)
 {
 	struct amp_ctrl *ctrl;
 
@@ -53,12 +53,13 @@ struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr)
 	if (!ctrl)
 		return NULL;
 
+	kref_init(&ctrl->kref);
+	ctrl->id = id;
+
 	mutex_lock(&mgr->amp_ctrls_lock);
 	list_add(&ctrl->list, &mgr->amp_ctrls);
 	mutex_unlock(&mgr->amp_ctrls_lock);
 
-	kref_init(&ctrl->kref);
-
 	BT_DBG("mgr %p ctrl %p", mgr, ctrl);
 
 	return ctrl;
-- 
1.7.9.5

