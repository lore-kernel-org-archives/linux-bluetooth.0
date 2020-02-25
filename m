Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C7C35E0F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114F1218AC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgBYSoX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:44:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:29706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYSoX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 13:44:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 10:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,485,1574150400"; 
   d="scan'208";a="231546551"
Received: from ingas-nuc1.sea.intel.com ([10.254.39.252])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2020 10:44:22 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 4/6] mesh: Simplify model virtual pub/sub logic
Date:   Tue, 25 Feb 2020 10:44:16 -0800
Message-Id: <20200225184418.12660-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225184418.12660-1-inga.stotland@intel.com>
References: <20200225184418.12660-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reorganizes the part of the code that handles model publishing
and subscribitng to virtual labels.
---
 mesh/model.c | 271 +++++++++++++++++++++------------------------------
 mesh/model.h |   9 +-
 2 files changed, 118 insertions(+), 162 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 4e5856292..e02658363 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -42,6 +42,8 @@
 /* Divide and round to ceiling (up) to calculate segment count */
 #define CEILDIV(val, div) (((val) + (div) - 1) / (div))
 
+#define VIRTUAL_BASE			0x10000
+
 struct mesh_model {
 	const struct mesh_model_ops *cbs;
 	void *user_data;
@@ -54,7 +56,6 @@ struct mesh_model {
 };
 
 struct mesh_virtual {
-	uint32_t id; /* Internal ID of a stored virtual addr, min val 0x10000 */
 	uint16_t ref_cnt;
 	uint16_t addr; /* 16-bit virtual address, used in messages */
 	uint8_t label[16]; /* 128 bit label UUID */
@@ -79,7 +80,6 @@ struct mod_forward {
 
 static struct l_queue *mesh_virtuals;
 
-static uint32_t virt_id_next = VIRTUAL_BASE;
 static struct timeval tx_start;
 
 static bool is_internal(uint32_t id)
@@ -120,14 +120,6 @@ static bool has_binding(struct l_queue *bindings, uint16_t idx)
 	return false;
 }
 
-static bool find_virt_by_id(const void *a, const void *b)
-{
-	const struct mesh_virtual *virt = a;
-	uint32_t id = L_PTR_TO_UINT(b);
-
-	return virt->id == id;
-}
-
 static bool find_virt_by_label(const void *a, const void *b)
 {
 	const struct mesh_virtual *virt = a;
@@ -307,7 +299,7 @@ static void append_dict_subs_array(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_enter_variant(builder, "av");
 	l_dbus_message_builder_enter_array(builder, "v");
 
-	if (!subs)
+	if (l_queue_isempty(subs))
 		goto virts;
 
 	for (entry = l_queue_get_entries(subs); entry; entry = entry->next) {
@@ -319,7 +311,7 @@ static void append_dict_subs_array(struct l_dbus_message_builder *builder,
 	}
 
 virts:
-	if (!virts)
+	if (l_queue_isempty(virts))
 		goto done;
 
 	for (entry = l_queue_get_entries(virts); entry; entry = entry->next) {
@@ -364,7 +356,7 @@ static void forward_model(void *a, void *b)
 	struct mesh_model *mod = a;
 	struct mod_forward *fwd = b;
 	struct mesh_virtual *virt;
-	uint32_t dst;
+	uint16_t dst;
 	bool result;
 
 	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->app_idx);
@@ -379,20 +371,9 @@ static void forward_model(void *a, void *b)
 		fwd->has_dst = true;
 	else if (fwd->virt) {
 		virt = l_queue_find(mod->virtuals, simple_match, fwd->virt);
-
-		/* Check that this is not own publication */
-		if (mod->pub && (virt && virt->id == mod->pub->addr))
-			return;
-
 		if (virt) {
-			/*
-			 * Map Virtual addresses to a usable namespace that
-			 * prevents us for forwarding a false positive
-			 * (multiple Virtual Addresses that map to the same
-			 * 16-bit virtual address identifier)
-			 */
 			fwd->has_dst = true;
-			dst = virt->id;
+			dst = virt->addr;
 		}
 	} else {
 		if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(dst)))
@@ -627,8 +608,13 @@ done:
 
 static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
 {
-	l_free(mod->pub);
-	mod->pub = NULL;
+	if (mod->pub) {
+		if (mod->pub->virt)
+			unref_virt(mod->pub->virt);
+
+		l_free(mod->pub);
+		mod->pub = NULL;
+	}
 
 	if (!mod->cbs)
 		/* External models */
@@ -650,11 +636,9 @@ static void model_unbind_idx(struct mesh_node *node, struct mesh_model *mod,
 		/* Internal model */
 		mod->cbs->bind(idx, ACTION_DELETE);
 
-	if (mod->pub && idx != mod->pub->idx)
-		return;
-
 	/* Remove model publication if the publication key is unbound */
-	remove_pub(node, mod);
+	if (mod->pub && idx == mod->pub->idx)
+		remove_pub(node, mod);
 }
 
 static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
@@ -746,65 +730,64 @@ static struct mesh_virtual *add_virtual(const uint8_t *v)
 
 	memcpy(virt->label, v, 16);
 	virt->ref_cnt = 1;
-	virt->id = virt_id_next++;
 	l_queue_push_head(mesh_virtuals, virt);
 
 	return virt;
 }
 
-static int set_pub(struct mesh_model *mod, const uint8_t *pub_addr,
+static int set_pub(struct mesh_model *mod, uint16_t pub_addr,
 			uint16_t idx, bool cred_flag, uint8_t ttl,
-			uint8_t period, uint8_t retransmit, bool b_virt,
-			uint16_t *dst)
+			uint8_t period, uint8_t retransmit)
 {
-	struct mesh_virtual *virt = NULL;
-	uint16_t grp;
+	if (!mod->pub)
+		mod->pub = l_new(struct mesh_model_pub, 1);
 
-	if (dst) {
-		if (b_virt)
-			*dst = 0;
-		else
-			*dst = l_get_le16(pub_addr);
-	}
+	mod->pub->addr = pub_addr;
+	mod->pub->credential = cred_flag;
+	mod->pub->idx = idx;
+	mod->pub->ttl = ttl;
+	mod->pub->period = period;
+	mod->pub->retransmit = retransmit;
 
-	if (b_virt) {
-		virt = add_virtual(pub_addr);
-		if (!virt)
-			return MESH_STATUS_STORAGE_FAIL;
+	return MESH_STATUS_SUCCESS;
+}
 
-	}
+static int set_virt_pub(struct mesh_model *mod, const uint8_t *label,
+			uint16_t idx, bool cred_flag, uint8_t ttl,
+			uint8_t period, uint8_t retransmit)
+{
+	struct mesh_virtual *virt = NULL;
 
-	/* If the old publication address is virtual, remove it from lists */
-	if (mod->pub && mod->pub->addr >= VIRTUAL_BASE) {
-		struct mesh_virtual *old_virt;
+	virt = add_virtual(label);
+	if (!virt)
+		return MESH_STATUS_STORAGE_FAIL;
 
-		old_virt = l_queue_find(mod->virtuals, find_virt_by_id,
-						L_UINT_TO_PTR(mod->pub->addr));
-		if (old_virt) {
-			l_queue_remove(mod->virtuals, old_virt);
-			unref_virt(old_virt);
-		}
-	}
+	if (!mod->pub)
+		mod->pub = l_new(struct mesh_model_pub, 1);
+
+	mod->pub->virt = virt;
+	return set_pub(mod, virt->addr, idx, cred_flag, ttl, period,
+								retransmit);
+}
+
+static int add_virt_sub(struct mesh_net *net, struct mesh_model *mod,
+			     const uint8_t *label, uint16_t *dst)
+{
+	struct mesh_virtual *virt = l_queue_find(mod->virtuals,
+						find_virt_by_label, label);
 
-	mod->pub = l_new(struct mesh_model_pub, 1);
+	if (!virt) {
+		virt = add_virtual(label);
+		if (!virt)
+			return MESH_STATUS_STORAGE_FAIL;
 
-	if (b_virt) {
 		l_queue_push_head(mod->virtuals, virt);
-		grp = virt->addr;
-		mod->pub->addr = virt->id;
-	} else {
-		grp = l_get_le16(pub_addr);
-		mod->pub->addr = grp;
+		mesh_net_dst_reg(net, virt->addr);
+		l_debug("Added virtual sub addr %4.4x", virt->addr);
 	}
 
 	if (dst)
-		*dst = grp;
-
-	mod->pub->credential = cred_flag;
-	mod->pub->idx = idx;
-	mod->pub->ttl = ttl;
-	mod->pub->period = period;
-	mod->pub->retransmit = retransmit;
+		*dst = virt->addr;
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -812,42 +795,25 @@ static int set_pub(struct mesh_model *mod, const uint8_t *pub_addr,
 static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
-	struct mesh_virtual *virt = NULL;
 	uint16_t grp;
 
-	if (b_virt) {
-		virt = add_virtual(group);
-		if (!virt)
-			return MESH_STATUS_STORAGE_FAIL;
-
-		grp = virt->addr;
-	} else {
-		grp = l_get_le16(group);
-	}
+	if (b_virt)
+		return add_virt_sub(net, mod, group, dst);
 
+	grp = l_get_le16(group);
 	if (dst)
 		*dst = grp;
 
-	if (!mod->subs)
-		mod->subs = l_queue_new();
+	if (!l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp))) {
 
-	/* Check if this group already exists */
-	if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp))) {
-		if (b_virt)
-			unref_virt(virt);
+		if (!mod->subs)
+			mod->subs = l_queue_new();
 
-		return MESH_STATUS_SUCCESS;
+		l_queue_push_tail(mod->subs, L_UINT_TO_PTR(grp));
+		mesh_net_dst_reg(net, grp);
+		l_debug("Added group subscription %4.4x", grp);
 	}
 
-	if (b_virt)
-		l_queue_push_head(mod->virtuals, virt);
-
-	l_queue_push_tail(mod->subs, L_UINT_TO_PTR(grp));
-
-	l_debug("Added %4.4x", grp);
-
-	mesh_net_dst_reg(net, grp);
-
 	return MESH_STATUS_SUCCESS;
 }
 
@@ -1096,9 +1062,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 {
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
-	uint32_t target;
 	uint8_t *label = NULL;
-	uint16_t dst;
 	uint16_t net_idx;
 	bool result;
 	int status;
@@ -1125,35 +1089,21 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 
 	gettimeofday(&tx_start, NULL);
 
-	target = mod->pub->addr;
-
-	if (IS_UNASSIGNED(target))
+	if (IS_UNASSIGNED(mod->pub->addr))
 		return MESH_ERROR_DOES_NOT_EXIST;
 
-	if (target >= VIRTUAL_BASE) {
-		struct mesh_virtual *virt;
+	if (mod->pub->virt)
+		label = mod->pub->virt->label;
 
-		virt = l_queue_find(mesh_virtuals, find_virt_by_id,
-						L_UINT_TO_PTR(target));
-		if (!virt)
-			return MESH_ERROR_NOT_FOUND;
-
-		label = virt->label;
-		dst = virt->addr;
-	} else {
-		dst = target;
-	}
-
-	l_debug("publish dst=%x", dst);
+	l_debug("publish dst=%x", mod->pub->addr);
 
 	net_idx = appkey_net_idx(net, mod->pub->idx);
 
 	result = msg_send(node, mod->pub->credential != 0, src,
-				dst, mod->pub->idx, net_idx, label, ttl,
-				msg, msg_len);
+				mod->pub->addr, mod->pub->idx, net_idx,
+				label, ttl, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
-
 }
 
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -1179,7 +1129,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
-			bool b_virt, uint16_t *dst)
+			bool is_virt, uint16_t *dst)
 {
 	struct mesh_model *mod;
 	int status;
@@ -1198,13 +1148,25 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	 * If the publication address is set to unassigned address value,
 	 * remove the publication
 	 */
-	if (!b_virt && IS_UNASSIGNED(l_get_le16(pub_addr))) {
+	if (!is_virt && IS_UNASSIGNED(l_get_le16(pub_addr))) {
 		remove_pub(node, mod);
 		return MESH_STATUS_SUCCESS;
 	}
 
-	status = set_pub(mod, pub_addr, idx, cred_flag, ttl, period, retransmit,
-								b_virt, dst);
+	/* Check if the old publication destination is a virtual label */
+	if (mod->pub && mod->pub->virt) {
+		unref_virt(mod->pub->virt);
+		mod->pub->virt = NULL;
+	}
+
+	if (!is_virt) {
+		status = set_pub(mod, l_get_le16(pub_addr), idx, cred_flag,
+						ttl, period, retransmit);
+	} else
+		status = set_virt_pub(mod, pub_addr, idx, cred_flag, ttl,
+						period, retransmit);
+
+	*dst = mod->pub->addr;
 
 	if (status != MESH_STATUS_SUCCESS)
 		return status;
@@ -1412,12 +1374,25 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 		n += 2;
 	}
 
+	entry = l_queue_get_entries(mod->virtuals);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_virtual *virt = entry->data;
+
+		if ((n + 2) > buf_size)
+			return MESH_STATUS_UNSPECIFIED_ERROR;
+
+		l_put_le16((uint16_t) L_PTR_TO_UINT(virt->addr), buf);
+		buf += 2;
+		n += 2;
+	}
+
 	*size = n;
 	return MESH_STATUS_SUCCESS;
 }
 
 int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *group, bool b_virt, uint16_t *dst)
+			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
 	int status;
 	struct mesh_model *mod;
@@ -1426,7 +1401,7 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod)
 		return status;
 
-	status = add_sub(node_get_net(node), mod, group, b_virt, dst);
+	status = add_sub(node_get_net(node), mod, group, is_virt, dst);
 
 	if (status != MESH_STATUS_SUCCESS)
 		return status;
@@ -1439,11 +1414,10 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 }
 
 int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *group, bool b_virt, uint16_t *dst)
+			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
 	int status;
 	struct l_queue *virtuals, *subs;
-	struct mesh_virtual *virt;
 	struct mesh_model *mod;
 
 	mod = find_model(node, addr, id, &status);
@@ -1458,20 +1432,7 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod->subs || !mod->virtuals)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	/*
-	 * When overwriting the Subscription List,
-	 * make sure any virtual Publication address is preserved
-	 */
-	if (mod->pub && mod->pub->addr >= VIRTUAL_BASE) {
-		virt = l_queue_find(virtuals, find_virt_by_id,
-				L_UINT_TO_PTR(mod->pub->addr));
-		if (virt) {
-			virt->ref_cnt++;
-			l_queue_push_head(mod->virtuals, virt);
-		}
-	}
-
-	status = add_sub(node_get_net(node), mod, group, b_virt, dst);
+	status = add_sub(node_get_net(node), mod, group, is_virt, dst);
 
 	if (status != MESH_STATUS_SUCCESS) {
 		/* Adding new group failed, so revert to old lists */
@@ -1502,7 +1463,7 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 }
 
 int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *group, bool b_virt, uint16_t *dst)
+			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
 	int status;
 	uint16_t grp;
@@ -1512,7 +1473,7 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod)
 		return status;
 
-	if (b_virt) {
+	if (is_virt) {
 		struct mesh_virtual *virt;
 
 		virt = l_queue_find(mod->virtuals, find_virt_by_label, group);
@@ -1611,22 +1572,16 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 	}
 
 	/* Add publication if present */
-	if (pub && (pub->virt || !(IS_UNASSIGNED(pub->addr)))) {
-		uint8_t mod_addr[2];
-		uint8_t *pub_addr;
+	if (pub) {
 		uint8_t retransmit = pub->count +
 					((pub->interval / 50 - 1) << 3);
-
-		/* Add publication */
-		l_put_le16(pub->addr, &mod_addr);
-		pub_addr = pub->virt ? pub->virt_addr : mod_addr;
-
-		if (set_pub(mod, pub_addr, pub->idx, pub->credential, pub->ttl,
-			pub->period, retransmit, pub->virt, NULL) !=
-							MESH_STATUS_SUCCESS) {
-			mesh_model_free(mod);
-			return NULL;
-		}
+		if (pub->virt)
+			set_virt_pub(mod, pub->virt_addr, pub->idx,
+						pub->credential, pub->ttl,
+						pub->period, retransmit);
+		else if (!IS_UNASSIGNED(pub->addr))
+			set_pub(mod, pub->addr, pub->idx, pub->credential,
+				pub->ttl, pub->period, retransmit);
 	}
 
 	/* Add subscriptions if present */
diff --git a/mesh/model.h b/mesh/model.h
index 9c7ce9334..0613c9cca 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -24,8 +24,6 @@ struct mesh_model;
 #define MAX_BINDINGS	10
 #define MAX_GRP_PER_MOD	10
 
-#define VIRTUAL_BASE			0x10000
-
 #define OP_MODEL_TEST			0x8000fffe
 #define OP_MODEL_INVALID		0x8000ffff
 
@@ -35,8 +33,11 @@ struct mesh_model;
 #define ACTION_UPDATE		2
 #define ACTION_DELETE		3
 
+struct mesh_virtual;
+
 struct mesh_model_pub {
-	uint32_t addr;
+	struct mesh_virtual *virt;
+	uint16_t addr;
 	uint16_t idx;
 	uint8_t ttl;
 	uint8_t credential;
@@ -75,7 +76,7 @@ struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
-			bool b_virt, uint16_t *dst);
+			bool is_virt, uint16_t *dst);
 
 int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 								uint16_t idx);
-- 
2.21.1

