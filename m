Return-Path: <SRS0=/Akc=U5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA07C5B57E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jun 2019 06:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9A22089C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jun 2019 06:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF3GoA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Jun 2019 02:44:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:7272 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfF3Gn7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Jun 2019 02:43:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 23:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,434,1557212400"; 
   d="scan'208";a="314543832"
Received: from ingas-nuc1.sea.intel.com ([10.254.64.161])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2019 23:43:58 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/4 v4] mesh: Clean up model.c and cfg-server.c
Date:   Sat, 29 Jun 2019 23:43:53 -0700
Message-Id: <20190630064356.12660-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630064356.12660-1-inga.stotland@intel.com>
References: <20190630064356.12660-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes a number of redundancies, fixes naming conventions and
style.
---
 mesh/cfgmod-server.c |  47 ++++++--------
 mesh/model.c         | 143 ++++++++++++++++---------------------------
 mesh/model.h         |  30 ++++-----
 3 files changed, 87 insertions(+), 133 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 060d7f4e4..634ac006b 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -58,6 +58,7 @@ static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 	msg[n++] = ttl;
 	msg[n++] = period;
 	msg[n++] = retransmit;
+
 	if (mod_id < 0x10000 || mod_id > VENDOR_ID_MASK) {
 		l_put_le16(mod_id, msg + n);
 		n += 2;
@@ -68,8 +69,7 @@ static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src,
-			APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
 }
 
 static bool config_pub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -121,8 +121,6 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	int status;
 	bool cred_flag, b_virt = false;
 	bool vendor = false;
-	struct mesh_model_pub *pub;
-	uint8_t ele_idx;
 
 	switch (size) {
 	default:
@@ -168,6 +166,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		vendor = true;
 		break;
 	}
+
 	ele_addr = l_get_le16(pkt);
 	pub_addr = pkt + 2;
 
@@ -204,22 +203,16 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		goto done;
 	}
 
-	if (status != MESH_STATUS_SUCCESS)
-		goto done;
-
-	ele_idx = node_get_element_idx(node, ele_addr);
-	pub = mesh_model_pub_get(node, ele_idx, mod_id, &status);
-
-	if (pub) {
+	if (status == MESH_STATUS_SUCCESS) {
 		struct mesh_db_pub db_pub = {
 			.virt = b_virt,
 			.addr = ota,
 			.idx = idx,
 			.ttl = ttl,
-			.credential = pub->credential,
+			.credential = cred_flag,
 			.period = period,
-			.count = pub->retransmit >> 5,
-			.interval = ((0x1f & pub->retransmit) + 1) * 50
+			.count = retransmit >> 5,
+			.interval = ((0x1f & retransmit) + 1) * 50
 		};
 
 		if (b_virt)
@@ -270,8 +263,8 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 	uint16_t ele_addr;
 	uint32_t mod_id;
 	uint16_t n = 0;
-	int ret = 0;
-	uint8_t *status;
+	int status;
+	uint8_t *msg_status;
 	uint16_t buf_size;
 	uint8_t msg[5 + sizeof(uint16_t) * MAX_GRP_PER_MOD];
 
@@ -286,7 +279,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 	case 4:
 		mod_id = l_get_le16(pkt + 2);
 		n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_LIST, msg);
-		status = msg + n;
+		msg_status = msg + n;
 		msg[n++] = 0;
 		l_put_le16(ele_addr, msg + n);
 		n += 2;
@@ -299,7 +292,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 		mod_id = l_get_le16(pkt + 2) << 16;
 		mod_id |= l_get_le16(pkt + 4);
 		n = mesh_model_opcode_set(OP_CONFIG_VEND_MODEL_SUB_LIST, msg);
-		status = msg + n;
+		msg_status = msg + n;
 		msg[n++] = 0;
 		l_put_le16(ele_addr, msg + n);
 		n += 2;
@@ -311,13 +304,13 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 	}
 
 	buf_size = sizeof(uint16_t) * MAX_GRP_PER_MOD;
-	ret = mesh_model_sub_get(node, ele_addr, mod_id, msg + n, buf_size,
+	status = mesh_model_sub_get(node, ele_addr, mod_id, msg + n, buf_size,
 									&size);
 
-	if (!ret)
+	if (status == MESH_STATUS_SUCCESS)
 		n += size;
-	else if (ret > 0)
-		*status = ret;
+
+	*msg_status = (uint8_t) status;
 
 	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
 	return true;
@@ -361,9 +354,9 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 {
 	uint16_t grp, ele_addr;
 	bool unreliable = !!(opcode & OP_UNRELIABLE);
-	uint32_t mod_id, func;
+	uint32_t mod_id;
 	const uint8_t *addr = NULL;
-	int status = 0;
+	int status = MESH_STATUS_SUCCESS;
 	bool vendor = false;
 
 	switch (size) {
@@ -408,6 +401,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		mod_id |= l_get_le16(pkt + 20);
 		break;
 	}
+
 	ele_addr = l_get_le16(pkt);
 
 	if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL) {
@@ -416,10 +410,9 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	} else
 		grp = UNASSIGNED_ADDRESS;
 
-	func = opcode & ~OP_UNRELIABLE;
-	switch (func) {
+	switch (opcode & ~OP_UNRELIABLE) {
 	default:
-		l_debug("Bad opcode: %x", func);
+		l_debug("Bad opcode: %x", opcode);
 		return;
 
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
diff --git a/mesh/model.c b/mesh/model.c
index f29ad9af2..9fd3aac6c 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -152,7 +152,7 @@ static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
 
 	models = node_get_element_models(node, ele_idx, status);
 	if (!models) {
-		*status = MESH_STATUS_INVALID_ADDRESS;
+		*status = MESH_STATUS_INVALID_MODEL;
 		return NULL;
 	}
 
@@ -164,19 +164,18 @@ static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
 }
 
 static struct mesh_model *find_model(struct mesh_node *node, uint16_t addr,
-						uint32_t mod_id, int *fail)
+						uint32_t mod_id, int *status)
 {
 	int ele_idx;
 
 	ele_idx = node_get_element_idx(node, addr);
 
 	if (ele_idx < 0) {
-		if (fail)
-			*fail = MESH_STATUS_INVALID_ADDRESS;
+		*status = MESH_STATUS_INVALID_ADDRESS;
 		return NULL;
 	}
 
-	return get_model(node, (uint8_t) ele_idx, mod_id, fail);
+	return get_model(node, (uint8_t) ele_idx, mod_id, status);
 }
 
 static uint32_t pub_period_to_ms(uint8_t pub_period)
@@ -429,16 +428,6 @@ static void cmplt(uint16_t remote, uint8_t status,
 	}
 }
 
-static bool pub_frnd_cred(struct mesh_node *node, uint16_t src, uint32_t mod_id)
-{
-	struct mesh_model *mod = find_model(node, src, mod_id, NULL);
-
-	if (!mod || !mod->pub)
-		return false;
-
-	return (mod->pub->credential != 0);
-}
-
 static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		uint32_t dst, uint8_t key_id, const uint8_t *key,
 		uint8_t *aad, uint8_t ttl, const void *msg, uint16_t msg_len)
@@ -463,22 +452,17 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 	iv_index = mesh_net_get_iv_index(net);
 
 	seq_num = mesh_net_get_seq_num(net);
-	if (!mesh_crypto_payload_encrypt(aad, msg, out, msg_len,
-				src, dst, key_id,
-				seq_num, iv_index,
-				szmic, key)) {
+	if (!mesh_crypto_payload_encrypt(aad, msg, out, msg_len, src, dst,
+				key_id, seq_num, iv_index, szmic, key)) {
 		l_error("Failed to Encrypt Payload");
 		goto done;
 	}
 
 	/* print_packet("Encrypted with", key, 16); */
 
-	ret = mesh_net_app_send(net, credential,
-				src, dst, key_id, ttl,
-				seq_num, iv_index,
-				szmic,
-				out, out_len,
-				cmplt, NULL);
+	ret = mesh_net_app_send(net, credential, src, dst, key_id, ttl,
+					seq_num, iv_index, szmic, out, out_len,
+								cmplt, NULL);
 done:
 	l_free(out);
 	return ret;
@@ -489,10 +473,6 @@ static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
 	l_free(mod->pub);
 	mod->pub = NULL;
 
-	/*
-	 * TODO: Instead of reporting  period of 0, report publication
-	 * address as unassigned
-	 */
 	if (!mod->cbs)
 		/* External models */
 		config_update_model_pub_period(node, mod->ele_idx, mod->id, 0);
@@ -539,16 +519,16 @@ static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 }
 
 static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
-				uint16_t app_idx, bool unbind)
+						uint16_t app_idx, bool unbind)
 {
-	int fail;
+	int status;
 	struct mesh_model *mod;
 	bool is_present;
 
-	mod = find_model(node, addr, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod) {
 		l_debug("Model not found");
-		return fail;
+		return status;
 	}
 
 	id = (id >= VENDOR_ID_MASK) ? (id & 0xffff) : id;
@@ -889,6 +869,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	uint8_t key_id;
 	const uint8_t *key;
 	bool result;
+	int status;
 
 	/* print_packet("Mod Tx", msg, msg_len); */
 
@@ -899,7 +880,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	if (src == 0)
 		src = mesh_net_get_address(net);
 
-	mod = find_model(node, src, mod_id, NULL);
+	mod = find_model(node, src, mod_id, &status);
 	if (!mod) {
 		l_debug("model %x not found", mod_id);
 		return MESH_ERROR_NOT_FOUND;
@@ -942,7 +923,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	l_debug("(%x) %p", mod->pub->idx, key);
 	l_debug("key_id %x", key_id);
 
-	result = msg_send(node, pub_frnd_cred(node, src, mod_id), src,
+	result = msg_send(node, mod->pub->credential != 0, src,
 				dst, key_id, key, aad, ttl, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
@@ -994,21 +975,12 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool b_virt, uint16_t *dst)
 {
-	int fail = MESH_STATUS_SUCCESS;
-	int ele_idx;
 	struct mesh_model *mod;
-	int result;
-
-	ele_idx = node_get_element_idx(node, addr);
-
-	if (ele_idx < 0) {
-		fail = MESH_STATUS_INVALID_ADDRESS;
-		return false;
-	}
+	int status;
 
-	mod = get_model(node, (uint8_t) ele_idx, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod)
-		return fail;
+		return status;
 
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_PUB_PARAM;
@@ -1016,15 +988,15 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!appkey_have_key(node_get_net(node), idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
-	result = set_pub(mod, mod_addr, idx, cred_flag, ttl, period, retransmit,
+	status = set_pub(mod, mod_addr, idx, cred_flag, ttl, period, retransmit,
 								b_virt, dst);
 
-	if (result != MESH_STATUS_SUCCESS)
-		return result;
+	if (status != MESH_STATUS_SUCCESS)
+		return status;
 
 	/*
 	 * If the publication address is set to unassigned address value,
-	 * remove publication
+	 * remove the publication
 	 */
 	if (IS_UNASSIGNED(*dst))
 		remove_pub(node, mod);
@@ -1036,18 +1008,18 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	}
 
 	/* External model */
-	config_update_model_pub_period(node, ele_idx, id,
+	config_update_model_pub_period(node, mod->ele_idx, id,
 						pub_period_to_ms(period));
 
 	return MESH_STATUS_SUCCESS;
 }
 
-struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
-				 uint8_t ele_idx, uint32_t mod_id, int *status)
+struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node, uint16_t addr,
+						uint32_t mod_id, int *status)
 {
 	struct mesh_model *mod;
 
-	mod = get_model(node, ele_idx, mod_id, status);
+	mod = find_model(node, addr, mod_id, status);
 	if (!mod)
 		return NULL;
 
@@ -1102,7 +1074,7 @@ static void restore_model_state(struct mesh_model *mod)
 	if (l_queue_isempty(mod->bindings) || !mod->cbs->bind) {
 		for (b = l_queue_get_entries(mod->bindings); b; b = b->next) {
 			if (cbs->bind(L_PTR_TO_UINT(b->data), ACTION_ADD) !=
-				MESH_STATUS_SUCCESS)
+							MESH_STATUS_SUCCESS)
 				break;
 		}
 	}
@@ -1170,18 +1142,18 @@ int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
-	int fail;
+	int status;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
 	uint16_t n;
 	uint32_t idx_pair;
 	int i;
 
-	mod = find_model(node, addr, id, &fail);
+	mod = find_model(node, addr, id, &status);
 
 	if (!mod) {
 		*size = 0;
-		return fail;
+		return status;
 	}
 
 	entry = l_queue_get_entries(mod->bindings);
@@ -1197,11 +1169,13 @@ int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 		} else {
 			idx_pair <<= 12;
 			idx_pair += app_idx;
+
 			/* Unlikely, but check for overflow*/
 			if ((n + 3) > buf_size) {
 				l_warn("Binding list too large");
 				goto done;
 			}
+
 			l_put_le32(idx_pair, buf);
 			buf += 3;
 			n += 3;
@@ -1218,21 +1192,20 @@ int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 done:
 	*size = n;
-
 	return MESH_STATUS_SUCCESS;
 }
 
 int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
-	int fail = MESH_STATUS_SUCCESS;
+	int status;
 	int16_t n;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
 
-	mod = find_model(node, addr, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod)
-		return fail;
+		return status;
 
 	entry = l_queue_get_entries(mod->subs);
 	*size = 0;
@@ -1254,36 +1227,27 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
-	int fail = MESH_STATUS_SUCCESS;
-	int ele_idx = -1;
+	int status;
 	struct mesh_model *mod;
 
-	ele_idx = node_get_element_idx(node, addr);
-
-	if (!node || ele_idx < 0) {
-		fail = MESH_STATUS_INVALID_ADDRESS;
-		return false;
-	}
-
-	mod = get_model(node, (uint8_t) ele_idx, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod)
-		return fail;
+		return status;
 
 	return add_sub(node_get_net(node), mod, group, b_virt, dst);
-	/* TODO: communicate to registered models that sub has changed */
 }
 
 int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
-	int fail = MESH_STATUS_SUCCESS;
+	int status;
 	struct l_queue *virtuals, *subs;
 	struct mesh_virtual *virt;
 	struct mesh_model *mod;
 
-	mod = find_model(node, addr, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod)
-		return fail;
+		return status;
 
 	subs = mod->subs;
 	virtuals = mod->virtuals;
@@ -1306,10 +1270,10 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 		}
 	}
 
-	fail = mesh_model_sub_add(node, addr, id, group, b_virt, dst);
+	status = mesh_model_sub_add(node, addr, id, group, b_virt, dst);
 
-	if (fail) {
-		/* Adding new group failed, so revert to old list */
+	if (status != MESH_STATUS_SUCCESS) {
+		/* Adding new group failed, so revert to old lists */
 		l_queue_destroy(mod->subs, NULL);
 		mod->subs = subs;
 		l_queue_destroy(mod->virtuals, unref_virt);
@@ -1324,23 +1288,24 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 			mesh_net_dst_unreg(net,
 					(uint16_t) L_PTR_TO_UINT(entry->data));
 
+		/* Destroy old lists */
 		l_queue_destroy(subs, NULL);
 		l_queue_destroy(virtuals, unref_virt);
 	}
 
-	return fail;
+	return status;
 }
 
 int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
-	int fail = MESH_STATUS_SUCCESS;
+	int status;
 	uint16_t grp;
 	struct mesh_model *mod;
 
-	mod = find_model(node, addr, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod)
-		return fail;
+		return status;
 
 	if (b_virt) {
 		struct mesh_virtual *virt;
@@ -1368,14 +1333,14 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 {
-	int fail = MESH_STATUS_SUCCESS;
+	int status;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
 	struct mesh_net *net = node_get_net(node);
 
-	mod = find_model(node, addr, id, &fail);
+	mod = find_model(node, addr, id, &status);
 	if (!mod)
-		return fail;
+		return status;
 
 	entry = l_queue_get_entries(mod->subs);
 
@@ -1386,7 +1351,7 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 	l_queue_destroy(mod->virtuals, unref_virt);
 	mod->virtuals = l_queue_new();
 
-	return fail;
+	return MESH_STATUS_SUCCESS;
 }
 
 struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
diff --git a/mesh/model.h b/mesh/model.h
index fd0b25f31..6094eaf59 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -90,40 +90,36 @@ uint32_t mesh_model_get_model_id(const struct mesh_model *model);
 bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
 			uint32_t mod_id, const struct mesh_model_ops *cbs,
 							void *user_data);
+struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
+								void *data);
 struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
-				uint8_t ele_idx, uint32_t mod_id, int *status);
+				uint16_t addr, uint32_t mod_id, int *status);
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *mod_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool b_virt, uint16_t *dst);
-struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
-								void *data);
 
 int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
-						uint16_t app_idx);
+								uint16_t idx);
 int mesh_model_binding_del(struct mesh_node *node, uint16_t addr, uint32_t id,
-						uint16_t idx);
+								uint16_t idx);
 int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint8_t *buf, uint16_t buf_len, uint16_t *size);
 int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
-						const uint8_t *grp, bool b_virt,
-						uint16_t *dst);
+				const uint8_t *grp, bool b_virt, uint16_t *dst);
 int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
-						const uint8_t *grp, bool b_virt,
-						uint16_t *dst);
+				const uint8_t *grp, bool b_virt, uint16_t *dst);
 int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id);
 int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
-						const uint8_t *grp, bool b_virt,
-						uint16_t *dst);
+				const uint8_t *grp, bool b_virt, uint16_t *dst);
 int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
-bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
+bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint8_t ttl,
 					const void *msg, uint16_t msg_len);
-int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
-				uint16_t src, uint8_t ttl,
-				const void *msg, uint16_t msg_len);
+int mesh_model_publish(struct mesh_node *node, uint32_t mod_id, uint16_t src,
+				uint8_t ttl, const void *msg, uint16_t msg_len);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint8_t ttl,
 			uint16_t src, uint16_t dst, uint8_t key_id,
@@ -137,8 +133,8 @@ void mesh_model_add_virtual(struct mesh_node *node, const uint8_t *v);
 void mesh_model_del_virtual(struct mesh_node *node, uint32_t va24);
 void mesh_model_list_virtual(struct mesh_node *node);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
-bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
-					uint32_t *opcode, uint16_t *n);
+bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size, uint32_t *opcode,
+								uint16_t *n);
 void model_build_config(void *model, void *msg_builder);
 
 void mesh_model_init(void);
-- 
2.21.0

