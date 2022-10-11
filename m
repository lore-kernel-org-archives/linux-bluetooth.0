Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB034C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 11:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJKLab (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJKLa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 07:30:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4536C10C
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665487825; x=1697023825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NnWy9ySSBrEEXEGgo6v6sDc2YbcWd8NFsmoMjr16Dkw=;
  b=EvVKVeW98GlooqkACf8lXi7cG9iR29jkqfJ/7cv/gp93eQNOrYESbRNA
   Z9BvGKao/fhILaZGEqWz6QQVvvCjOpPGm6Vyoxp0Anu4pWpvVAiYnxgwf
   +CyJue34tkADdR+OhlnO4gKCHGAO0sGqxqM1ww5hbqGdf4sovXucSW+IN
   T00cQ52xDnLsSjmQFTnZXYavGuvud7Wag4dpIwlmU/F/HYH/QSdgZ3/o1
   zorCqBBAs2sM+WK+KaA1GSqa/7e67CPcvKISZBQGwd1Fi2fOToQW5+xpz
   PZlX4NoDLbVI588drLsLEs+vPusdxP8uY59GOmgaDSRUBcid25Nq4IzYQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366469734"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="366469734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 04:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577406192"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="577406192"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 04:30:17 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 2/3] shared/vcp: Add callback to update media volume
Date:   Tue, 11 Oct 2022 17:01:15 +0530
Message-Id: <20221011113116.70514-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011113116.70514-1-sathish.narasimman@intel.com>
References: <20221011113116.70514-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for callback functions to update media transport volume.
Fix to register debug functions. Also invoke vcp_attached function the
right place. Fix check for existing session if available and attach.
---
 src/shared/vcp.c | 139 +++++++++++++++++++++++++++++++++++++++++------
 src/shared/vcp.h |   7 +++
 2 files changed, 130 insertions(+), 16 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 5459cf892a7d..8e1964234338 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -41,6 +41,11 @@ struct bt_vcp_db {
 	struct bt_vcs *vcs;
 };
 
+struct ev_cb {
+	const struct bt_vcp_vr_ops *ops;
+	void *data;
+};
+
 typedef void (*vcp_func_t)(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data);
@@ -89,11 +94,16 @@ struct bt_vcp {
 	unsigned int vstate_id;
 	unsigned int vflag_id;
 
+	unsigned int disconn_id;
 	struct queue *notify;
 	struct queue *pending;
 
 	bt_vcp_debug_func_t debug_func;
 	bt_vcp_destroy_func_t debug_destroy;
+
+	struct bt_vcp_vr_ops *ops;
+	struct ev_cb *cb;
+
 	void *debug_data;
 	void *user_data;
 };
@@ -124,6 +134,18 @@ static struct queue *vcp_db;
 static struct queue *vcp_cbs;
 static struct queue *sessions;
 
+static void vcp_debug(struct bt_vcp *vcp, const char *format, ...)
+{
+	va_list ap;
+
+	if (!vcp || !format || !vcp->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(vcp->debug_func, vcp->debug_data, format, ap);
+	va_end(ap);
+}
+
 static void *iov_pull_mem(struct iovec *iov, size_t len)
 {
 	void *data = iov->iov_base;
@@ -183,12 +205,17 @@ static void vcp_detached(void *data, void *user_data)
 
 void bt_vcp_detach(struct bt_vcp *vcp)
 {
+	DBG(vcp, "%p", vcp);
+
 	if (!queue_remove(sessions, vcp))
 		return;
 
 	bt_gatt_client_unref(vcp->client);
 	vcp->client = NULL;
 
+	bt_att_unregister_disconnect(vcp->att, vcp->disconn_id);
+	vcp->att = NULL;
+
 	queue_foreach(vcp_cbs, vcp_detached, vcp);
 }
 
@@ -267,24 +294,14 @@ void bt_vcp_unref(struct bt_vcp *vcp)
 	vcp_free(vcp);
 }
 
-static void vcp_debug(struct bt_vcp *vcp, const char *format, ...)
-{
-	va_list ap;
-
-	if (!vcp || !format || !vcp->debug_func)
-		return;
-
-	va_start(ap, format);
-	util_debug_va(vcp->debug_func, vcp->debug_data, format, ap);
-	va_end(ap);
-}
-
 static void vcp_disconnected(int err, void *user_data)
 {
 	struct bt_vcp *vcp = user_data;
 
 	DBG(vcp, "vcp %p disconnected err %d", vcp, err);
 
+	vcp->disconn_id = 0;
+
 	bt_vcp_detach(vcp);
 }
 
@@ -303,12 +320,9 @@ static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
 	vcp = bt_vcp_new(db, NULL);
 	vcp->att = att;
 
-	bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
-
 	bt_vcp_attach(vcp, NULL);
 
 	return vcp;
-
 }
 
 static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
@@ -317,6 +331,7 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "Volume Down");
 
@@ -344,6 +359,9 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, vstate->vol_set, cb->data);
+
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
 				 bt_vcp_get_att(vcp));
@@ -356,6 +374,7 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "Volume Up");
 
@@ -383,6 +402,9 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, vstate->vol_set, cb->data);
+
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
 				 bt_vcp_get_att(vcp));
@@ -395,6 +417,7 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "Un Mute and Volume Down");
 
@@ -423,6 +446,9 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, vstate->vol_set, cb->data);
+
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
 				 bt_vcp_get_att(vcp));
@@ -435,6 +461,7 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "UN Mute and Volume Up");
 
@@ -463,6 +490,9 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, vstate->vol_set, cb->data);
+
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
 				 bt_vcp_get_att(vcp));
@@ -475,6 +505,7 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	struct bt_vcs_ab_vol *req;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "Set Absolute Volume");
 
@@ -502,6 +533,9 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->vol_set = req->vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, vstate->vol_set, cb->data);
+
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
 				 bt_vcp_get_att(vcp));
@@ -514,6 +548,7 @@ static uint8_t vcs_unmute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "Un Mute");
 
@@ -541,6 +576,9 @@ static uint8_t vcs_unmute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x00;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, vstate->vol_set, cb->data);
+
 	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
 				 sizeof(struct vol_state),
 				 bt_vcp_get_att(vcp));
@@ -553,6 +591,7 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	struct ev_cb *cb =  vcp->cb;
 
 	DBG(vcp, "MUTE");
 
@@ -580,6 +619,13 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x01;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	if (cb && cb->ops && cb->ops->set_volume)
+		cb->ops->set_volume(vcp, 0, cb->data);
+
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
+					sizeof(struct vol_state),
+					bt_vcp_get_att(vcp));
+
 	return 0;
 }
 
@@ -689,8 +735,10 @@ static void vcs_state_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_vcs *vcs = user_data;
+	struct bt_vcp *vcp = vcp_get_session(att, vcs->vdb->db);
 	struct iovec iov;
 
+	DBG(vcp, "VCP State Read");
 	iov.iov_base = vcs->vstate;
 	iov.iov_len = sizeof(*vcs->vstate);
 
@@ -704,8 +752,10 @@ static void vcs_flag_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_vcs *vcs = user_data;
+	struct bt_vcp *vcp = vcp_get_session(att, vcs->vdb->db);
 	struct iovec iov;
 
+	DBG(vcp, "VCP Flag Read");
 	iov.iov_base = &vcs->vol_flag;
 	iov.iov_len = sizeof(vcs->vol_flag);
 
@@ -868,6 +918,14 @@ bool bt_vcp_unregister(unsigned int id)
 	return true;
 }
 
+static void vcp_attached(void *data, void *user_data)
+{
+	struct bt_vcp_cb *cb = data;
+	struct bt_vcp *vcp = user_data;
+
+	cb->attached(vcp, cb->user_data);
+}
+
 struct bt_vcp *bt_vcp_new(struct gatt_db *ldb, struct gatt_db *rdb)
 {
 	struct bt_vcp *vcp;
@@ -1068,6 +1126,26 @@ static unsigned int vcp_register_notify(struct bt_vcp *vcp,
 	return notify->id;
 }
 
+bool bt_vcp_vr_set_ops(struct bt_vcp *vcp, struct bt_vcp_vr_ops *ops,
+			void *data)
+{
+	struct ev_cb *cb;
+
+	if (!vcp)
+		return false;
+
+	if (vcp->cb)
+		free(vcp->cb);
+
+	cb = new0(struct ev_cb, 1);
+	cb->ops = ops;
+	cb->data = data;
+
+	vcp->cb = cb;
+
+	return true;
+}
+
 static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_vcp *vcp = user_data;
@@ -1141,25 +1219,54 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, foreach_vcs_char, vcp);
 }
 
+static void vcp_attach_att(struct bt_vcp *vcp, struct bt_att *att)
+{
+	if (vcp->disconn_id) {
+		if (att == bt_vcp_get_att(vcp))
+			return;
+		bt_att_unregister_disconnect(vcp->att, vcp->disconn_id);
+	}
+
+	vcp->disconn_id = bt_att_register_disconnect(vcp->att,
+							vcp_disconnected,
+							vcp, NULL);
+}
+
 bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
 
+	if (queue_find(sessions, NULL, vcp)) {
+		/* If instance already been set but there is no client proceed
+		 * to clone it otherwise considered it already attached.
+		 */
+		if (client && !vcp->client)
+			goto clone;
+		return true;
+	}
+
 	if (!sessions)
 		sessions = queue_new();
 
 	queue_push_tail(sessions, vcp);
 
-	if (!client)
+	queue_foreach(vcp_cbs, vcp_attached, vcp);
+
+	if (!client) {
+		vcp_attach_att(vcp, vcp->att);
 		return true;
+	}
 
 	if (vcp->client)
 		return false;
 
+clone:
 	vcp->client = bt_gatt_client_clone(client);
 	if (!vcp->client)
 		return false;
 
+	vcp_attach_att(vcp, bt_gatt_client_get_att(client));
+
 	bt_uuid16_create(&uuid, VCS_UUID);
 	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
 
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index 26db5732d19b..7d70aefe0089 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -33,6 +33,13 @@
 
 struct bt_vcp;
 
+struct bt_vcp_vr_ops {
+	void (*set_volume)(struct bt_vcp *vcp, int8_t volume, void *data);
+};
+
+bool bt_vcp_vr_set_ops(struct bt_vcp *vcp, struct bt_vcp_vr_ops *ops,
+			void *data);
+
 typedef void (*bt_vcp_destroy_func_t)(void *user_data);
 typedef void (*bt_vcp_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_vcp_func_t)(struct bt_vcp *vcp, void *user_data);
-- 
2.25.1

