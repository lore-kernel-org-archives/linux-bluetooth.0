Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0778EC5B54D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 22:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3412084B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 22:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0Wst (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:48:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:6157 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF0Wss (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 18:48:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 15:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,425,1557212400"; 
   d="scan'208";a="183556394"
Received: from ingas-nuc1.sea.intel.com ([10.252.196.161])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2019 15:48:47 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4 v2] mesh: Fix virtual address processing
Date:   Thu, 27 Jun 2019 15:48:43 -0700
Message-Id: <20190627224845.20762-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627224845.20762-1-inga.stotland@intel.com>
References: <20190627224845.20762-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This tightens up the accounting for locally stored virtual addresses.
Alos, use meaningful variable names to identify components of a
mesh virtual address.
---
 mesh/model.c | 171 +++++++++++++++++++++++----------------------------
 mesh/model.h |   6 +-
 2 files changed, 77 insertions(+), 100 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 9fd3aac6c..4d8118908 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -55,10 +55,10 @@ struct mesh_model {
 };
 
 struct mesh_virtual {
-	uint32_t id; /*Identifier of internally stored addr, min val 0x10000 */
-	uint16_t ota;
+	uint32_t id; /* Internal ID of a stored virtual addr, min val 0x10000 */
 	uint16_t ref_cnt;
-	uint8_t addr[16];
+	uint16_t addr; /* 16-bit virtual address, used in messages */
+	uint8_t label[16]; /* 128 bit label UUID */
 };
 
 /* These struct is used to pass lots of params to l_queue_foreach */
@@ -128,12 +128,12 @@ static bool find_virt_by_id(const void *a, const void *b)
 	return virt->id == id;
 }
 
-static bool find_virt_by_addr(const void *a, const void *b)
+static bool find_virt_by_label(const void *a, const void *b)
 {
 	const struct mesh_virtual *virt = a;
-	const uint8_t *addr = b;
+	const uint8_t *label = b;
 
-	return memcmp(virt->addr, addr, 16) == 0;
+	return memcmp(virt->label, label, 16) == 0;
 }
 
 static bool match_model_id(const void *a, const void *b)
@@ -324,7 +324,7 @@ static void forward_model(void *a, void *b)
 			 * Map Virtual addresses to a usable namespace that
 			 * prevents us for forwarding a false positive
 			 * (multiple Virtual Addresses that map to the same
-			 * u16 OTA addr)
+			 * 16-bit virtual address identifier)
 			 */
 			fwd->has_dst = true;
 			dst = virt->id;
@@ -381,12 +381,12 @@ static int virt_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 		struct mesh_virtual *virt = v->data;
 		int decrypt_idx;
 
-		if (virt->ota != dst)
+		if (virt->addr != dst)
 			continue;
 
 		decrypt_idx = appkey_packet_decrypt(net, szmict, seq,
 							iv_idx, src, dst,
-							virt->addr, 16, key_id,
+							virt->label, 16, key_id,
 							data, size, out);
 
 		if (decrypt_idx >= 0) {
@@ -430,7 +430,7 @@ static void cmplt(uint16_t remote, uint8_t status,
 
 static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		uint32_t dst, uint8_t key_id, const uint8_t *key,
-		uint8_t *aad, uint8_t ttl, const void *msg, uint16_t msg_len)
+		uint8_t *label, uint8_t ttl, const void *msg, uint16_t msg_len)
 {
 	bool ret = false;
 	uint32_t iv_index, seq_num;
@@ -452,7 +452,7 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 	iv_index = mesh_net_get_iv_index(net);
 
 	seq_num = mesh_net_get_seq_num(net);
-	if (!mesh_crypto_payload_encrypt(aad, msg, out, msg_len, src, dst,
+	if (!mesh_crypto_payload_encrypt(label, msg, out, msg_len, src, dst,
 				key_id, seq_num, iv_index, szmic, key)) {
 		l_error("Failed to Encrypt Payload");
 		goto done;
@@ -568,6 +568,31 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 }
 
+static struct mesh_virtual *add_virtual(const uint8_t *v)
+{
+	struct mesh_virtual *virt = l_queue_find(mesh_virtuals,
+						find_virt_by_label, v);
+
+	if (virt) {
+		virt->ref_cnt++;
+		return virt;
+	}
+
+	virt = l_new(struct mesh_virtual, 1);
+
+	if (!mesh_crypto_virtual_addr(v, &virt->addr)) {
+		l_free(virt);
+		return NULL;
+	}
+
+	memcpy(virt->label, v, 16);
+	virt->ref_cnt++;
+	virt->id = virt_id_next++;
+	l_queue_push_head(mesh_virtuals, virt);
+
+	return virt;
+}
+
 static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 			uint16_t idx, bool cred_flag, uint8_t ttl,
 			uint8_t period, uint8_t retransmit, bool b_virt,
@@ -583,35 +608,30 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 			*dst = l_get_le16(mod_addr);
 	}
 
-	if (b_virt && !mesh_crypto_virtual_addr(mod_addr, &grp))
-		return MESH_STATUS_STORAGE_FAIL;
+	if (b_virt) {
+		virt = add_virtual(mod_addr);
+		if (!virt)
+			return MESH_STATUS_STORAGE_FAIL;
+
+	}
 
-	/* If old publication was Virtual, remove it */
+	/* If the old publication address is virtual, remove it from lists */
 	if (mod->pub && mod->pub->addr >= VIRTUAL_BASE) {
-		virt = l_queue_find(mod->virtuals, find_virt_by_id,
+		struct mesh_virtual *old_virt;
+
+		old_virt = l_queue_find(mod->virtuals, find_virt_by_id,
 						L_UINT_TO_PTR(mod->pub->addr));
-		if (virt) {
-			l_queue_remove(mod->virtuals, virt);
-			unref_virt(virt);
+		if (old_virt) {
+			l_queue_remove(mod->virtuals, old_virt);
+			unref_virt(old_virt);
 		}
 	}
 
 	mod->pub = l_new(struct mesh_model_pub, 1);
 
 	if (b_virt) {
-		virt = l_queue_find(mesh_virtuals, find_virt_by_addr, mod_addr);
-		if (!virt) {
-			virt = l_new(struct mesh_virtual, 1);
-			virt->id = virt_id_next++;
-			virt->ota = grp;
-			memcpy(virt->addr, mod_addr, sizeof(virt->addr));
-			l_queue_push_head(mesh_virtuals, virt);
-		} else {
-			grp = virt->ota;
-		}
-
-		virt->ref_cnt++;
 		l_queue_push_head(mod->virtuals, virt);
+		grp = virt->addr;
 		mod->pub->addr = virt->id;
 	} else {
 		grp = l_get_le16(mod_addr);
@@ -643,28 +663,15 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
-	struct mesh_virtual *virt;
+	struct mesh_virtual *virt = NULL;
 	uint16_t grp;
 
 	if (b_virt) {
-		virt = l_queue_find(mesh_virtuals, find_virt_by_addr, group);
-		if (!virt) {
-			if (!mesh_crypto_virtual_addr(group, &grp))
-				return MESH_STATUS_STORAGE_FAIL;
-
-			virt = l_new(struct mesh_virtual, 1);
-			virt->id = virt_id_next++;
-			virt->ota = grp;
-			memcpy(virt->addr, group, sizeof(virt->addr));
-
-			if (!l_queue_push_head(mesh_virtuals, virt))
-				return MESH_STATUS_STORAGE_FAIL;
-		} else {
-			grp = virt->ota;
-		}
+		virt = add_virtual(group);
+		if (!virt)
+			return MESH_STATUS_STORAGE_FAIL;
 
-		virt->ref_cnt++;
-		l_queue_push_head(mod->virtuals, virt);
+		grp = virt->addr;
 	} else {
 		grp = l_get_le16(group);
 	}
@@ -675,9 +682,16 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 	if (!mod->subs)
 		mod->subs = l_queue_new();
 
-	if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp)))
-		/* Group already exists */
+	/* Check if this group already exists */
+	if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp))) {
+		if (b_virt)
+			unref_virt(virt);
+
 		return MESH_STATUS_SUCCESS;
+	}
+
+	if (b_virt)
+		l_queue_push_head(mod->virtuals, virt);
 
 	l_queue_push_tail(mod->subs, L_UINT_TO_PTR(grp));
 
@@ -864,7 +878,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
 	uint32_t target;
-	uint8_t *aad = NULL;
+	uint8_t *label = NULL;
 	uint16_t dst;
 	uint8_t key_id;
 	const uint8_t *key;
@@ -896,18 +910,18 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	target = mod->pub->addr;
 
 	if (IS_UNASSIGNED(target))
-		return false;
+		return MESH_ERROR_DOES_NOT_EXIST;
 
 	if (target >= VIRTUAL_BASE) {
-		struct mesh_virtual *virt = l_queue_find(mesh_virtuals,
-				find_virt_by_id,
-				L_UINT_TO_PTR(target));
+		struct mesh_virtual *virt;
 
+		virt = l_queue_find(mesh_virtuals, find_virt_by_id,
+						L_UINT_TO_PTR(target));
 		if (!virt)
-			return false;
+			return MESH_ERROR_NOT_FOUND;
 
-		aad = virt->addr;
-		dst = virt->ota;
+		label = virt->label;
+		dst = virt->addr;
 	} else {
 		dst = target;
 	}
@@ -924,7 +938,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	l_debug("key_id %x", key_id);
 
 	result = msg_send(node, mod->pub->credential != 0, src,
-				dst, key_id, key, aad, ttl, msg, msg_len);
+				dst, key_id, key, label, ttl, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 
@@ -1063,7 +1077,6 @@ struct mesh_model *mesh_model_vendor_new(uint8_t ele_idx, uint16_t vendor_id,
 /* Internal models only */
 static void restore_model_state(struct mesh_model *mod)
 {
-
 	const struct mesh_model_ops *cbs;
 	const struct l_queue_entry *b;
 
@@ -1310,10 +1323,10 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (b_virt) {
 		struct mesh_virtual *virt;
 
-		virt = l_queue_find(mod->virtuals, find_virt_by_addr, group);
+		virt = l_queue_find(mod->virtuals, find_virt_by_label, group);
 		if (virt) {
 			l_queue_remove(mod->virtuals, virt);
-			grp = virt->ota;
+			grp = virt->addr;
 			unref_virt(virt);
 		} else {
 			if (!mesh_crypto_virtual_addr(group, &grp))
@@ -1505,39 +1518,6 @@ bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
 	return true;
 }
 
-void mesh_model_add_virtual(struct mesh_node *node, const uint8_t *v)
-{
-	struct mesh_virtual *virt = l_queue_find(mesh_virtuals,
-						find_virt_by_addr, v);
-
-	if (virt) {
-		virt->ref_cnt++;
-		return;
-	}
-
-	virt = l_new(struct mesh_virtual, 1);
-
-	if (!mesh_crypto_virtual_addr(v, &virt->ota)) {
-		l_free(virt);
-		return; /* Storage Failure */
-	}
-
-	memcpy(virt->addr, v, 16);
-	virt->ref_cnt++;
-	virt->id = virt_id_next++;
-	l_queue_push_head(mesh_virtuals, virt);
-}
-
-void mesh_model_del_virtual(struct mesh_node *node, uint32_t va24)
-{
-	struct mesh_virtual *virt = l_queue_remove_if(mesh_virtuals,
-						find_virt_by_id,
-						L_UINT_TO_PTR(va24));
-
-	if (virt)
-		unref_virt(virt);
-}
-
 void model_build_config(void *model, void *msg_builder)
 {
 	struct l_dbus_message_builder *builder = msg_builder;
@@ -1588,4 +1568,5 @@ void mesh_model_init(void)
 void mesh_model_cleanup(void)
 {
 	l_queue_destroy(mesh_virtuals, l_free);
+	mesh_virtuals = NULL;
 }
diff --git a/mesh/model.h b/mesh/model.h
index 6094eaf59..f0f97ee0b 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -24,7 +24,7 @@ struct mesh_model;
 #define MAX_BINDINGS	10
 #define MAX_GRP_PER_MOD	10
 
-#define	VIRTUAL_BASE			0x10000
+#define VIRTUAL_BASE			0x10000
 
 #define MESH_MAX_ACCESS_PAYLOAD		380
 
@@ -124,14 +124,10 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint8_t ttl,
 			uint16_t src, uint16_t dst, uint8_t key_id,
 			const uint8_t *data, uint16_t size);
-
 void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
 void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
 								uint16_t idx);
 struct l_queue *mesh_model_get_appkeys(struct mesh_node *node);
-void mesh_model_add_virtual(struct mesh_node *node, const uint8_t *v);
-void mesh_model_del_virtual(struct mesh_node *node, uint32_t va24);
-void mesh_model_list_virtual(struct mesh_node *node);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
 bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size, uint32_t *opcode,
 								uint16_t *n);
-- 
2.21.0

