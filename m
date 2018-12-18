Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C41C43612
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A642184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeLRWcH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:32:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:60673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeLRWb4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 17:31:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="101704197"
Received: from bgix-dell-lap.sea.intel.com ([10.241.111.161])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2018 14:31:52 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ v4 20/30] mesh: restructure model services for multiple nodes
Date:   Tue, 18 Dec 2018 14:31:29 -0800
Message-Id: <20181218223139.8041-21-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
References: <20181218223139.8041-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/model.c | 811 ++++++++++++++++++++++++++++++++++++++++++-----------------
 mesh/model.h |  66 ++---
 2 files changed, 612 insertions(+), 265 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index d50817843..5687e5cfa 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -30,12 +30,15 @@
 #include "mesh/mesh.h"
 #include "mesh/crypto.h"
 #include "mesh/node.h"
+#include "mesh/mesh-db.h"
 #include "mesh/net.h"
 #include "mesh/appkey.h"
-#include "mesh/model.h"
-#include "mesh/display.h"
 #include "mesh/cfgmod.h"
 #include "mesh/storage.h"
+#include "mesh/error.h"
+#include "mesh/dbus.h"
+#include "mesh/util.h"
+#include "mesh/model.h"
 
 struct mesh_model {
 	const struct mesh_model_ops *cbs;
@@ -67,6 +70,7 @@ struct mod_forward {
 	uint8_t ttl;
 	int8_t rssi;
 	bool szmict;
+	bool has_dst;
 	bool done;
 };
 
@@ -75,6 +79,14 @@ static struct l_queue *mesh_virtuals;
 static uint32_t virt_id_next = VIRTUAL_BASE;
 static struct timeval tx_start;
 
+static bool is_internal(uint32_t id)
+{
+	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
+		return true;
+
+	return false;
+}
+
 static void unref_virt(void *data)
 {
 	struct mesh_virtual *virt = data;
@@ -94,6 +106,17 @@ static bool simple_match(const void *a, const void *b)
 	return a == b;
 }
 
+static bool has_binding(struct l_queue *bindings, uint16_t idx)
+{
+	const struct l_queue_entry *l;
+
+	for (l = l_queue_get_entries(bindings); l; l = l->next) {
+		if (L_PTR_TO_UINT(l->data) == idx)
+			return true;
+	}
+	return false;
+}
+
 static bool find_virt_by_id(const void *a, const void *b)
 {
 	const struct mesh_virtual *virt = a;
@@ -110,13 +133,39 @@ static bool find_virt_by_addr(const void *a, const void *b)
 	return memcmp(virt->addr, addr, 16) == 0;
 }
 
-static struct mesh_model *find_model(struct mesh_net *net, uint16_t addr,
+static bool match_model_id(const void *a, const void *b)
+{
+	const struct mesh_model *model = a;
+	uint32_t id = L_PTR_TO_UINT(b);
+
+	return (mesh_model_get_model_id(model) == id);
+}
+
+static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
+						uint32_t id, int *status)
+{
+	struct l_queue *models;
+	struct mesh_model *model;
+
+	models = node_get_element_models(node, ele_idx, status);
+	if (!models) {
+		*status = MESH_STATUS_INVALID_ADDRESS;
+		return NULL;
+	}
+
+	model = l_queue_find(models, match_model_id, L_UINT_TO_PTR(id));
+
+	if (status)
+		*status = (model) ? MESH_STATUS_SUCCESS :
+						MESH_STATUS_INVALID_MODEL;
+
+	return model;
+}
+
+static struct mesh_model *find_model(struct mesh_node *node, uint16_t addr,
 						uint32_t mod_id, int *fail)
 {
 	int ele_idx;
-	struct mesh_node *node;
-
-	node = mesh_net_local_node_get(net);
 
 	ele_idx = node_get_element_idx(node, addr);
 
@@ -126,7 +175,126 @@ static struct mesh_model *find_model(struct mesh_net *net, uint16_t addr,
 		return NULL;
 	}
 
-	return node_get_model(node, (uint8_t) ele_idx, mod_id, fail);
+	return get_model(node, (uint8_t) ele_idx, mod_id, fail);
+}
+
+static uint32_t convert_pub_period_to_ms(uint8_t pub_period)
+{
+	int n;
+
+	n = (pub_period & 0x3f);
+
+	switch (pub_period >> 6) {
+	default:
+		return n * 100;
+	case 2:
+		n *= 10;
+		/* Fall Through */
+	case 1:
+		return n * 1000;
+	case 3:
+		return n * 10 * 60 * 1000;
+	}
+}
+
+static struct l_dbus_message *create_config_update_msg(struct mesh_node *node,
+					uint8_t ele_idx, uint32_t id,
+					struct l_dbus_message_builder **builder)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	const char *owner;
+	const char *path;
+	uint16_t model_id;
+
+	owner = node_get_owner(node);
+	path = node_get_element_path(node, ele_idx);
+	if (!path || !owner)
+		return NULL;
+
+	l_debug("Send \"UpdateModelConfiguration\"");
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+						MESH_ELEMENT_INTERFACE,
+						"UpdateModelConfiguration");
+
+	*builder = l_dbus_message_builder_new(msg);
+
+	model_id = (uint16_t) id;
+
+	l_dbus_message_builder_append_basic(*builder, 'q', &model_id);
+
+	l_dbus_message_builder_enter_array(*builder, "{sv}");
+
+	if ((id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
+		uint16_t vendor = id >> 16;
+		dbus_append_dict_entry_basic(*builder, "Vendor", "q", &vendor);
+	}
+
+	return msg;
+}
+
+static void config_update_model_pub_period(struct mesh_node *node,
+					uint8_t ele_idx, uint32_t model_id,
+					uint32_t period)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+
+	msg = create_config_update_msg(node, ele_idx, model_id, &builder);
+	if (!msg)
+		return;
+
+	dbus_append_dict_entry_basic(builder, "PublicationPeriod", "u",
+								&period);
+
+	l_dbus_message_builder_leave_array(builder);
+	if (l_dbus_message_builder_finalize(builder))
+		l_dbus_send(dbus, msg);
+
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
+					struct l_queue *q, const char *key)
+{
+	const struct l_queue_entry *entry;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, "aq");
+	l_dbus_message_builder_enter_array(builder, "q");
+
+	for (entry = l_queue_get_entries(q); entry; entry = entry->next) {
+		uint16_t value = (uint16_t) L_PTR_TO_UINT(entry->data);
+
+		l_dbus_message_builder_append_basic(builder,'q', &value);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void config_update_model_bindings(struct mesh_node *node,
+							struct mesh_model *mod)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+
+	msg = create_config_update_msg(node, mod->ele_idx, mod->id,
+								&builder);
+	if (!msg)
+		return;
+
+	append_dict_uint16_array(builder, mod->bindings, "Bindings");
+
+	l_dbus_message_builder_leave_array(builder);
+	if (l_dbus_message_builder_finalize(builder))
+		l_dbus_send(dbus, msg);
+
+	l_dbus_message_builder_destroy(builder);
 }
 
 static void forward_model(void *a, void *b)
@@ -135,22 +303,22 @@ static void forward_model(void *a, void *b)
 	struct mod_forward *fwd = b;
 	struct mesh_virtual *virt;
 	uint32_t dst;
-	bool has_dst = false;
-
-	if (!mod->cbs || !mod->cbs->recv)
-		return;
+	bool result;
 
 	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->idx);
-	if (fwd->idx != APP_IDX_DEV &&
-		!l_queue_find(mod->bindings, simple_match,
-						L_UINT_TO_PTR(fwd->idx)))
+	if (fwd->idx != APP_IDX_DEV && !has_binding(mod->bindings, fwd->idx))
 		return;
 
 	dst = fwd->dst;
 	if (dst == fwd->unicast || IS_ALL_NODES(dst))
-		has_dst = true;
+		fwd->has_dst = true;
 	else if (fwd->virt) {
 		virt = l_queue_find(mod->virtuals, simple_match, fwd->virt);
+
+		/* Check that this is not own publication */
+		if (mod->pub && (virt && virt->id == mod->pub->addr))
+			return;
+
 		if (virt) {
 			/*
 			 * Map Virtual addresses to a usable namespace that
@@ -158,42 +326,38 @@ static void forward_model(void *a, void *b)
 			 * (multiple Virtual Addresses that map to the same
 			 * u16 OTA addr)
 			 */
-			has_dst = true;
+			fwd->has_dst = true;
 			dst = virt->id;
 		}
 	} else {
 		if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(dst)))
-			has_dst = true;
+			fwd->has_dst = true;
 	}
 
+	if (!fwd->has_dst)
+		return;
 
-	if (!has_dst)
+	/* Return, if this is not a internal model */
+	if (!mod->cbs)
 		return;
 
-	/*
-	 * TODO: models shall be registered with a list of supported opcodes and
-	 * element address. Iterate through the list of opcodes to see if the
-	 * model is an addressee.
-	 * If this is an internal registered model, check for a "bind" callback.
-	 * For an external ("user") model, send D-Bus method (signal?) (TBD)
-	 */
+	result = false;
+
 	if (mod->cbs->recv)
-		mod->cbs->recv(fwd->src, dst, fwd->unicast, fwd->idx,
+		result = mod->cbs->recv(fwd->src, dst, fwd->unicast, fwd->idx,
 				fwd->data, fwd->size, fwd->ttl, mod->user_data);
 
-	if (dst == fwd->unicast)
+	if (dst == fwd->unicast && result)
 		fwd->done = true;
 }
 
-static int dev_packet_decrypt(struct mesh_net *net, const uint8_t *data,
+static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t size, bool szmict, uint16_t src,
 				uint16_t dst, uint8_t key_id, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out)
 {
-	struct mesh_node *node;
 	const uint8_t *dev_key;
 
-	node = mesh_net_local_node_get(net);
 	dev_key = node_get_device_key(node);
 	if (!dev_key)
 		return false;
@@ -241,32 +405,32 @@ static void cmplt(uint16_t remote, uint8_t status,
 	struct timeval tx_end;
 
 	if (status)
-		l_info("Tx-->%4.4x (%d octets) Failed (%d)",
+		l_debug("Tx-->%4.4x (%d octets) Failed (%d)",
 				remote, size, status);
 	else
-		l_info("Tx-->%4.4x (%d octets) Succeeded", remote, size);
+		l_debug("Tx-->%4.4x (%d octets) Succeeded", remote, size);
 
 	/* print_packet("Sent Data", data, size); */
 
 	gettimeofday(&tx_end, NULL);
 	if (tx_end.tv_sec == tx_start.tv_sec) {
-		l_info("Duration 0.%zu seconds",
+		l_debug("Duration 0.%zu seconds",
 				tx_end.tv_usec - tx_start.tv_usec);
 	} else {
 		if (tx_start.tv_usec > tx_end.tv_usec)
-			l_info("Duration %zu.%zu seconds",
+			l_debug("Duration %zu.%zu seconds",
 				tx_end.tv_sec - tx_start.tv_sec - 1,
 				tx_end.tv_usec + 1000000 - tx_start.tv_usec);
 		else
-			l_info("Duration %zu.%zu seconds",
+			l_debug("Duration %zu.%zu seconds",
 					tx_end.tv_sec - tx_start.tv_sec,
 					tx_end.tv_usec - tx_start.tv_usec);
 	}
 }
 
-static bool pub_frnd_cred(struct mesh_net *net, uint16_t src, uint32_t mod_id)
+static bool pub_frnd_cred(struct mesh_node *node, uint16_t src, uint32_t mod_id)
 {
-	struct mesh_model *mod = find_model(net, src, mod_id, NULL);
+	struct mesh_model *mod = find_model(node, src, mod_id, NULL);
 
 	if (!mod || !mod->pub)
 		return false;
@@ -274,17 +438,16 @@ static bool pub_frnd_cred(struct mesh_net *net, uint16_t src, uint32_t mod_id)
 	return (mod->pub->credential != 0);
 }
 
-static unsigned int msg_send(struct mesh_net *net, uint32_t mod_id,
-				uint16_t src, uint32_t dst,
-				uint8_t key_id, const uint8_t *key,
-				uint8_t *aad, uint8_t ttl,
-				const void *msg, uint16_t msg_len)
+static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
+		uint32_t dst, uint8_t key_id, const uint8_t *key,
+		uint8_t *aad, uint8_t ttl, const void *msg, uint16_t msg_len)
 {
-	unsigned int ret = 0;
+	bool ret = false;
 	uint32_t iv_index, seq_num;
 	uint8_t *out;
 	bool szmic = false;
 	uint16_t out_len = msg_len + sizeof(uint32_t);
+	struct mesh_net *net = node_get_net(node);
 
 	/* Use large MIC if it doesn't affect segmentation */
 	if (msg_len > 11 && msg_len <= 376) {
@@ -309,7 +472,7 @@ static unsigned int msg_send(struct mesh_net *net, uint32_t mod_id,
 
 	/* print_packet("Encrypted with", key, 16); */
 
-	ret = mesh_net_app_send(net, pub_frnd_cred(net, src, mod_id),
+	ret = mesh_net_app_send(net, credential,
 				src, dst, key_id, ttl,
 				seq_num, iv_index,
 				szmic,
@@ -320,79 +483,100 @@ done:
 	return ret;
 }
 
-static void model_unbind_idx(void *a, void *b)
+static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
 {
-	struct mesh_model *mod = a;
-	uint16_t idx = L_PTR_TO_UINT(b);
+	l_free(mod->pub);
+	mod->pub = NULL;
 
-	if (idx == mod->pub->idx) {
-		mod->pub->addr = UNASSIGNED_ADDRESS;
-		/*
-		 * TODO: callback for internal model or
-		 * D-Bus signal/method "model publication changed" (TBD)
-		 */
-	}
+	/* TODO: remove from storage */
 
-	l_queue_remove(mod->bindings, b);
+	if (!mod->cbs)
+		/* External models */
+		config_update_model_pub_period(node, mod->ele_idx, mod->id, 0);
+	else if (mod->cbs && mod->cbs->pub)
+		/* Internal models */
+		mod->cbs->pub(NULL);
+}
+
+static void model_unbind_idx(struct mesh_node *node, struct mesh_model *mod,
+								uint16_t idx)
+{
+	l_queue_remove(mod->bindings, L_UINT_TO_PTR(idx));
 
-	if (mod->cbs->bind)
+	if (!mod->cbs)
+		/* External model */
+		config_update_model_bindings(node, mod);
+	else if (mod->cbs->bind)
+		/* Internal model */
 		mod->cbs->bind(idx, ACTION_DELETE);
+
+	if (mod->pub && idx != mod->pub->idx)
+		return;
+
+	/* Remove model publication if the publication key is unbound */
+	remove_pub(node, mod);
 }
 
-static int model_bind_idx(struct mesh_model *mod, uint16_t idx)
+static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
+								uint16_t idx)
 {
-	if (l_queue_length(mod->bindings) >= MAX_BINDINGS)
-		return MESH_STATUS_INSUFF_RESOURCES;
+	l_queue_push_tail(mod->bindings, L_UINT_TO_PTR(idx));
 
-	if (!l_queue_push_tail(mod->bindings, L_UINT_TO_PTR(idx)))
-		return MESH_STATUS_INSUFF_RESOURCES;
+	l_debug("Add %4.4x to model %8.8x", idx, mod->id);
 
-	if (mod->cbs->bind)
+	if (!mod->cbs)
+		/* External model */
+		config_update_model_bindings(node, mod);
+	else if (mod->cbs->bind)
+		/* Internal model */
 		mod->cbs->bind(idx, ACTION_ADD);
-
-	return MESH_STATUS_SUCCESS;
-
 }
 
-static int update_binding(struct mesh_net *net, uint16_t addr, uint32_t id,
+static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint16_t app_idx, bool unbind)
 {
 	int fail;
 	struct mesh_model *mod;
-	int status;
+	bool is_present;
 
-	mod = find_model(net, addr, id, &fail);
+	mod = find_model(node, addr, id, &fail);
 	if (!mod) {
-		l_info("model not found");
+		l_debug("Model not found");
 		return fail;
 	}
 
+	id = (id >= VENDOR_ID_MASK) ? (id & 0xffff) : id;
+
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_MODEL;
 
-	if (!l_queue_find(mod->bindings, simple_match, L_UINT_TO_PTR(app_idx)))
-		return MESH_STATUS_CANNOT_BIND;
-
-	if (!appkey_have_key(net, app_idx))
+	if (!appkey_have_key(node_get_net(node), app_idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
+	is_present = has_binding(mod->bindings, app_idx);
+
+	if (!is_present && unbind)
+		return MESH_STATUS_SUCCESS;
+
+	if (is_present && !unbind)
+		return MESH_STATUS_SUCCESS;
+
 	if (unbind) {
-		model_unbind_idx(mod, &app_idx);
+		model_unbind_idx(node, mod, app_idx);
 
-		if (!storage_model_bind(net, addr, id, app_idx, true))
+		if (!storage_model_bind(node, addr, id, app_idx, true))
 			return MESH_STATUS_STORAGE_FAIL;
 
 		return MESH_STATUS_SUCCESS;
 	}
 
-	status = model_bind_idx(mod, app_idx);
-	if (status != MESH_STATUS_SUCCESS)
-		return status;
+	if (l_queue_length(mod->bindings) >= MAX_BINDINGS)
+		return MESH_STATUS_INSUFF_RESOURCES;
 
-	if (!storage_model_bind(net, addr, id, app_idx, false)) {
-		model_unbind_idx(mod, &app_idx);
+	if (!storage_model_bind(node, addr, id, app_idx, false))
 		return MESH_STATUS_STORAGE_FAIL;
-	}
+
+	model_bind_idx(node, mod, app_idx);
 
 	return MESH_STATUS_SUCCESS;
 
@@ -428,6 +612,7 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 		}
 	}
 
+	mod->pub = l_new(struct mesh_model_pub, 1);
 	if (b_virt) {
 		virt = l_queue_find(mesh_virtuals, find_virt_by_addr, mod_addr);
 		if (!virt) {
@@ -511,14 +696,57 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 
 	l_queue_push_tail(mod->subs, L_UINT_TO_PTR(grp));
 
-	l_info("Added %4.4x", grp);
-	if (net)
-		mesh_net_dst_reg(net, grp);
+	l_debug("Added %4.4x", grp);
+
+	mesh_net_dst_reg(net, grp);
 
 	return MESH_STATUS_SUCCESS;
 }
 
-bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
+static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
+					uint16_t src, uint16_t key_idx,
+					uint16_t size, const uint8_t *data)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+	const char *owner;
+	const char *path;
+
+	owner = node_get_owner(node);
+	path = node_get_element_path(node, ele_idx);
+	if (!path || !owner)
+		return;
+
+	l_debug("Send \"MessageReceived\"");
+
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+				MESH_ELEMENT_INTERFACE, "MessageReceived");
+
+	builder = l_dbus_message_builder_new(msg);
+
+	if (!l_dbus_message_builder_append_basic(builder, 'q', &src))
+		goto error;
+
+	if (!l_dbus_message_builder_append_basic(builder, 'q', &key_idx))
+		goto error;
+
+	if (!l_dbus_message_builder_append_basic(builder, 'b', &is_sub))
+		goto error;
+
+	if (!dbus_append_byte_array(builder, data, size))
+		goto error;
+
+	if (!l_dbus_message_builder_finalize(builder))
+		goto error;
+
+	l_dbus_send(dbus, msg);
+
+error:
+	l_dbus_message_builder_destroy(builder);
+}
+
+bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint8_t ttl,
 			uint16_t src, uint16_t dst, uint8_t key_id,
 			const uint8_t *data, uint16_t size)
@@ -531,30 +759,25 @@ bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
 		.size = size - (szmict ? 8 : 4),
 		.ttl = ttl,
 		.virt = NULL,
-		.done = false,
 	};
-
-	struct mesh_node *node;
+	struct mesh_net *net = node_get_net(node);
 	uint8_t num_ele;
 	int decrypt_idx, i, ele_idx;
 	uint16_t addr;
 	struct mesh_virtual *decrypt_virt = NULL;
+	bool result = false;
+	bool is_subscription;
 
 	l_debug("iv_index %8.8x key_id = %2.2x", iv_index, key_id);
 	if (!dst)
 		return false;
 
-	node = mesh_net_local_node_get(net);
-	if (!node)
-		return false;
-
 	ele_idx = node_get_element_idx(node, dst);
 
 	if (dst < 0x8000 && ele_idx < 0)
 		/* Unicast and not addressed to us */
 		return false;
 
-
 	clear_text = l_malloc(size);
 	if (!clear_text)
 		return false;
@@ -566,7 +789,7 @@ bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
 	 * is hinted by key_id, but is not necessarily definitive
 	 */
 	if (key_id == APP_ID_DEV || mesh_net_provisioner_mode_get(net))
-		decrypt_idx = dev_packet_decrypt(net, data, size, szmict, src,
+		decrypt_idx = dev_packet_decrypt(node, data, size, szmict, src,
 						dst, key_id, seq0, iv_index,
 						clear_text);
 	else if ((dst & 0xc000) == 0x8000)
@@ -582,18 +805,18 @@ bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
 
 	if (decrypt_idx < 0) {
 		l_error("model.c - Failed to decrypt application payload");
-		forward.done = false;
+		result = false;
 		goto done;
 	}
 
 	/* print_packet("Clr Rx (pre-cache-check)", clear_text, size - 4); */
 
 	if (key_id != APP_ID_DEV) {
-		uint16_t crpl = mesh_net_get_crpl(net);
+		uint16_t crpl = node_get_crpl(node);
 
 		if (appkey_msg_in_replay_cache(net, (uint16_t) decrypt_idx, src,
 							crpl, seq, iv_index)) {
-			forward.done = true;
+			result = true;
 			goto done;
 		}
 	}
@@ -608,59 +831,86 @@ bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
 	if (!num_ele || IS_UNASSIGNED(addr))
 		goto done;
 
+	is_subscription = !(IS_UNICAST(dst));
+
 	for (i = 0; i < num_ele; i++) {
 		struct l_queue *models;
 
-		if (dst < 0x8000 && ele_idx != i)
+		if (!is_subscription && ele_idx != i)
 			continue;
 
 		forward.unicast = addr + i;
+		forward.has_dst = false;
+
 		models = node_get_element_models(node, i, NULL);
+
+		/* Internal models */
 		l_queue_foreach(models, forward_model, &forward);
 
-		if (dst < 0x8000 && ele_idx == i)
+		/*
+		 * Cycle through external models if the message has not been
+		 * handled by internal models
+		 */
+		if (forward.has_dst && !forward.done)
+			send_msg_rcvd(node, i, is_subscription, src,
+					forward.idx, forward.size,
+					forward.data);
+
+		/*
+		 * Either the message has been processed internally or
+		 * has been passed on to an external model.
+		 */
+		result = forward.has_dst | forward.done;
+
+		/* If the message was to unicast address, we are done */
+		if (!is_subscription && ele_idx == i)
 			break;
 	}
+
 done:
 	l_free(clear_text);
-	return forward.done;
+	return result;
 }
 
-unsigned int mesh_model_send(struct mesh_net *net, uint32_t mod_id,
-				uint16_t src, uint32_t target,
-				uint16_t app_idx, uint8_t ttl,
+int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
+				uint16_t src, uint8_t ttl,
 				const void *msg, uint16_t msg_len)
 {
+	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
+	uint32_t target;
 	uint8_t *aad = NULL;
 	uint16_t dst;
 	uint8_t key_id;
 	const uint8_t *key;
+	bool result;
 
 	/* print_packet("Mod Tx", msg, msg_len); */
 
 	if (!net || msg_len > 380)
-		return 0;
+		return MESH_ERROR_INVALID_ARGS;
 
 	/* If SRC is 0, use the Primary Element */
 	if (src == 0)
 		src = mesh_net_get_address(net);
 
-	mod = find_model(net, src, mod_id, NULL);
+	mod = find_model(node, src, mod_id, NULL);
 	if (!mod) {
-		l_info("model %x not found", mod_id);
-		return 0;
+		l_debug("model %x not found", mod_id);
+		return MESH_ERROR_NOT_FOUND;
+	}
+
+	if (!mod->pub) {
+		l_debug("publication doesn't exist (model %x)", mod_id);
+		return MESH_ERROR_DOES_NOT_EXIST;
 	}
 
 	gettimeofday(&tx_start, NULL);
 
-	if (target == USE_PUB_VALUE) {
-		target = mod->pub->addr;
-		app_idx = mod->pub->idx;
-	}
+	target = mod->pub->addr;
 
 	if (IS_UNASSIGNED(target))
-		return 0;
+		return false;
 
 	if (target >= VIRTUAL_BASE) {
 		struct mesh_virtual *virt = l_queue_find(mesh_virtuals,
@@ -668,101 +918,139 @@ unsigned int mesh_model_send(struct mesh_net *net, uint32_t mod_id,
 				L_UINT_TO_PTR(target));
 
 		if (!virt)
-			return 0;
+			return false;
 
 		aad = virt->addr;
 		dst = virt->ota;
-	} else
+	} else {
 		dst = target;
+	}
+
+	l_debug("publish dst=%x", dst);
+
+	key = appkey_get_key(net, mod->pub->idx, &key_id);
+	if (!key) {
+		l_debug("no app key for (%x)", mod->pub->idx);
+		return false;
+	}
+
+	l_debug("(%x) %p", mod->pub->idx, key);
+	l_debug("key_id %x", key_id);
+
+	result = msg_send(node, pub_frnd_cred(node, src, mod_id), src,
+				dst, key_id, key, aad, ttl, msg, msg_len);
+
+	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
+
+}
+
+bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
+					uint16_t app_idx, uint8_t ttl,
+					const void *msg, uint16_t msg_len)
+{
+	uint8_t key_id;
+	const uint8_t *key;
+
+	/* print_packet("Mod Tx", msg, msg_len); */
+
+	/* If SRC is 0, use the Primary Element */
+	if (src == 0)
+		src = node_get_primary(node);
 
-	l_debug("dst=%x", dst);
-	if (app_idx == APP_IDX_DEV && mesh_net_provisioner_mode_get(net)) {
-		key = node_get_device_key(mesh_net_local_node_get(net));
-	} else if (app_idx == APP_IDX_DEV) {
-		key = node_get_device_key(mesh_net_local_node_get(net));
+	gettimeofday(&tx_start, NULL);
+
+	if (IS_UNASSIGNED(target))
+		return false;
+
+	if (app_idx == APP_IDX_DEV) {
+		key = node_get_device_key(node);
 		if (!key)
-			return 0;
+			return false;
 
 		l_debug("(%x)", app_idx);
 		key_id = APP_ID_DEV;
 	} else {
-		key = appkey_get_key(net, app_idx, &key_id);
+		key = appkey_get_key(node_get_net(node), app_idx, &key_id);
 		if (!key) {
 			l_debug("no app key for (%x)", app_idx);
-			return 0;
+			return false;
 		}
 
 		l_debug("(%x) %p", app_idx, key);
 		l_debug("key_id %x", key_id);
 	}
 
-	return msg_send(net, mod_id, src, dst, key_id, key, aad, ttl,
+	return msg_send(node, false, src, target, key_id, key, NULL, ttl,
 			msg, msg_len);
-
 }
 
-int mesh_model_pub_set(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *mod_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool b_virt, uint16_t *dst)
 {
 	int fail = MESH_STATUS_SUCCESS;
-	int ele_idx = -1;
+	int ele_idx;
 	struct mesh_model *mod;
-	struct mesh_node *node;
+	int result;
 
-	node = mesh_net_local_node_get(net);
-	if (node)
-		ele_idx = node_get_element_idx(node, addr);
+	ele_idx = node_get_element_idx(node, addr);
 
-	if (!node || ele_idx < 0) {
+	if (ele_idx < 0) {
 		fail = MESH_STATUS_INVALID_ADDRESS;
 		return false;
 	}
 
-	mod = node_get_model(node, (uint8_t) ele_idx, id, &fail);
+	mod = get_model(node, (uint8_t) ele_idx, id, &fail);
 	if (!mod)
 		return fail;
 
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_PUB_PARAM;
 
-	if (!appkey_have_key(net, idx))
+	if (!appkey_have_key(node_get_net(node), idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
-	return set_pub(mod, mod_addr, idx, cred_flag, ttl, period, retransmit,
+	result = set_pub(mod, mod_addr, idx, cred_flag, ttl, period, retransmit,
 								b_virt, dst);
+
+	if (result != MESH_STATUS_SUCCESS)
+		return result;
+
+	/* TODO: save to storage */
+
 	/*
-	 * TODO: Add standardized Publication Change notification to model
-	 * definition
+	 * If the publication address is set to unassigned address value,
+	 * remove publication
 	 */
+	if (IS_UNASSIGNED(*dst))
+		remove_pub(node, mod);
+
+	/* Internal model, call registered callbacks */
+	if (mod->cbs && mod->cbs->pub) {
+		mod->cbs->pub(mod->pub);
+		return MESH_STATUS_SUCCESS;
+	}
+
+	/* External model */
+	config_update_model_pub_period(node, ele_idx, id,
+					convert_pub_period_to_ms(period));
+
+	return MESH_STATUS_SUCCESS;
 }
 
-struct mesh_model_pub *mesh_model_pub_get(struct mesh_net *net, uint8_t ele_idx,
-						uint32_t mod_id, int *status)
+struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
+				 uint8_t ele_idx, uint32_t mod_id, int *status)
 {
 	struct mesh_model *mod;
-	struct mesh_node *node = mesh_net_local_node_get(net);
-
-	if (!node) {
-		*status = MESH_STATUS_INVALID_ADDRESS;
-		return NULL;
-	}
 
-	mod = node_get_model(node, ele_idx, mod_id, status);
+	mod = get_model(node, ele_idx, mod_id, status);
 	if (!mod)
 		return NULL;
 
 	return mod->pub;
 }
 
-uint32_t mesh_model_get_model_id(const struct mesh_model *model)
-{
-	if (!model)
-		return 0xffffffff; /* TODO: use define */
-	return model->id;
-}
-
 void mesh_model_free(void *data)
 {
 	struct mesh_model *mod = data;
@@ -774,33 +1062,39 @@ void mesh_model_free(void *data)
 	l_free(mod);
 }
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id, bool vendor)
+static struct mesh_model *model_new(uint8_t ele_idx, uint32_t id)
 {
 	struct mesh_model *mod = l_new(struct mesh_model, 1);
 
-	if (!mod)
-		return NULL;
-
-	if (vendor)
-		id |= VENDOR_ID_MASK;
-
 	mod->id = id;
 	mod->ele_idx = ele_idx;
 	mod->virtuals = l_queue_new();
-	if (!mod->virtuals) {
-		l_free(mod);
-		return NULL;
-	}
 	return mod;
 }
 
-static void restore_model_state(void *data)
+struct mesh_model *mesh_model_new(uint8_t ele_idx, uint16_t id)
 {
-	struct mesh_model *mod = data;
+	return model_new(ele_idx, id | VENDOR_ID_MASK);
+}
+
+struct mesh_model *mesh_model_vendor_new(uint8_t ele_idx, uint16_t vendor_id,
+								uint16_t mod_id)
+{
+	uint32_t id = mod_id | (vendor_id << 16);
+
+	return model_new(ele_idx, id);
+}
+
+/* Internal models only */
+static void restore_model_state(struct mesh_model *mod)
+{
+
 	const struct mesh_model_ops *cbs;
 	const struct l_queue_entry *b;
 
 	cbs = mod->cbs;
+	if (!cbs)
+		return;
 
 	if (l_queue_isempty(mod->bindings) || !mod->cbs->bind) {
 		for (b = l_queue_get_entries(mod->bindings); b; b = b->next) {
@@ -812,63 +1106,64 @@ static void restore_model_state(void *data)
 
 	if (mod->pub && cbs->pub)
 		cbs->pub(mod->pub);
+
 }
 
-bool mesh_model_vendor_register(struct mesh_net *net, uint8_t ele_idx,
+uint32_t mesh_model_get_model_id(const struct mesh_model *model)
+{
+	return model->id;
+}
+
+/* This registers an internal model, i.e. implemented within meshd */
+bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
 					uint32_t mod_id,
 					const struct mesh_model_ops *cbs,
 					void *user_data)
 {
 	struct mesh_model *mod;
-	struct mesh_node *node;
 
-	node = mesh_net_local_node_get(net);
-	if (!node)
-		return false;
+	/* Internal models are always SIG models */
+	mod_id = VENDOR_ID_MASK | mod_id;
 
-	mod = node_get_model(node, ele_idx, mod_id, NULL);
+	mod = get_model(node, ele_idx, mod_id, NULL);
 	if (!mod)
 		return false;
 
 	mod->cbs = cbs;
 	mod->user_data = user_data;
 
-	l_idle_oneshot(restore_model_state, mod, NULL);
+	restore_model_state(mod);
 
 	return true;
 }
 
-bool mesh_model_register(struct mesh_net *net, uint8_t ele_idx,
-					uint32_t mod_id,
-					const struct mesh_model_ops *cbs,
-					void *user_data)
+void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
+							uint16_t app_idx)
 {
-	uint32_t id = VENDOR_ID_MASK | mod_id;
+	const struct l_queue_entry *entry = l_queue_get_entries(models);
 
-	return mesh_model_vendor_register(net, ele_idx, id, cbs, user_data);
-}
+	for (; entry; entry = entry->next) {
+		struct mesh_model *model = entry->data;
 
-void mesh_model_app_key_delete(struct mesh_net *net, struct l_queue *models,
-							uint16_t app_idx)
-{
-	l_queue_foreach(models, model_unbind_idx, L_UINT_TO_PTR(app_idx));
+		model_unbind_idx(node, model, app_idx);
+	}
 }
 
-int mesh_model_binding_del(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_binding_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx)
 {
 	l_debug("0x%x, 0x%x, %d", addr, id, app_idx);
-	return update_binding(net, addr, id, app_idx, true);
+	return update_binding(node, addr, id, app_idx, true);
 }
 
-int mesh_model_binding_add(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx)
 {
 	l_debug("0x%x, 0x%x, %d", addr, id, app_idx);
-	return update_binding(net, addr, id, app_idx, false);
+	return update_binding(node, addr, id, app_idx, false);
 }
 
-int mesh_model_get_bindings(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
 	int fail;
@@ -878,7 +1173,7 @@ int mesh_model_get_bindings(struct mesh_net *net, uint16_t addr, uint32_t id,
 	uint32_t idx_pair;
 	int i;
 
-	mod = find_model(net, addr, id, &fail);
+	mod = find_model(node, addr, id, &fail);
 
 	if (!mod) {
 		*size = 0;
@@ -922,7 +1217,7 @@ done:
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_get(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
 	int fail = MESH_STATUS_SUCCESS;
@@ -930,7 +1225,7 @@ int mesh_model_sub_get(struct mesh_net *net, uint16_t addr, uint32_t id,
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
 
-	mod = find_model(net, addr, id, &fail);
+	mod = find_model(node, addr, id, &fail);
 	if (!mod)
 		return fail;
 
@@ -951,32 +1246,29 @@ int mesh_model_sub_get(struct mesh_net *net, uint16_t addr, uint32_t id,
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_add(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
 	int fail = MESH_STATUS_SUCCESS;
 	int ele_idx = -1;
 	struct mesh_model *mod;
-	struct mesh_node *node;
 
-	node = mesh_net_local_node_get(net);
-	if (node)
-		ele_idx = node_get_element_idx(node, addr);
+	ele_idx = node_get_element_idx(node, addr);
 
 	if (!node || ele_idx < 0) {
 		fail = MESH_STATUS_INVALID_ADDRESS;
 		return false;
 	}
 
-	mod = node_get_model(node, (uint8_t) ele_idx, id, &fail);
+	mod = get_model(node, (uint8_t) ele_idx, id, &fail);
 	if (!mod)
 		return fail;
 
-	return add_sub(net, mod, group, b_virt, dst);
+	return add_sub(node_get_net(node), mod, group, b_virt, dst);
 	/* TODO: communicate to registered models that sub has changed */
 }
 
-int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
 	int fail = MESH_STATUS_SUCCESS;
@@ -984,7 +1276,7 @@ int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
 	struct mesh_virtual *virt;
 	struct mesh_model *mod;
 
-	mod = find_model(net, addr, id, &fail);
+	mod = find_model(node, addr, id, &fail);
 	if (!mod)
 		return fail;
 
@@ -1009,7 +1301,7 @@ int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
 		}
 	}
 
-	fail = mesh_model_sub_add(net, addr, id, group, b_virt, dst);
+	fail = mesh_model_sub_add(node, addr, id, group, b_virt, dst);
 
 	if (fail) {
 		/* Adding new group failed, so revert to old list */
@@ -1019,6 +1311,7 @@ int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
 		mod->virtuals = virtuals;
 	} else {
 		const struct l_queue_entry *entry;
+		struct mesh_net *net = node_get_net(node);
 
 		entry = l_queue_get_entries(subs);
 		for (; entry; entry = entry->next)
@@ -1032,14 +1325,14 @@ int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
 	return fail;
 }
 
-int mesh_model_sub_del(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool b_virt, uint16_t *dst)
 {
 	int fail = MESH_STATUS_SUCCESS;
 	uint16_t grp;
 	struct mesh_model *mod;
 
-	mod = find_model(net, addr, id, &fail);
+	mod = find_model(node, addr, id, &fail);
 	if (!mod)
 		return fail;
 
@@ -1062,18 +1355,19 @@ int mesh_model_sub_del(struct mesh_net *net, uint16_t addr, uint32_t id,
 	*dst = grp;
 
 	if (l_queue_remove(mod->subs, L_UINT_TO_PTR(grp)))
-		mesh_net_dst_unreg(net, grp);
+		mesh_net_dst_unreg(node_get_net(node), grp);
 
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_del_all(struct mesh_net *net, uint16_t addr, uint32_t id)
+int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 {
 	int fail = MESH_STATUS_SUCCESS;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
+	struct mesh_net *net = node_get_net(node);
 
-	mod = find_model(net, addr, id, &fail);
+	mod = find_model(node, addr, id, &fail);
 	if (!mod)
 		return fail;
 
@@ -1088,15 +1382,22 @@ int mesh_model_sub_del_all(struct mesh_net *net, uint16_t addr, uint32_t id)
 	return fail;
 }
 
-struct mesh_model *mesh_model_init(struct mesh_net *net, uint8_t ele_idx,
-						struct mesh_db_model *db_mod)
+struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
+								void *data)
 {
+	struct mesh_db_model *db_mod = data;
 	struct mesh_model *mod;
+	struct mesh_net *net;
 	uint32_t i;
 
-	mod = mesh_model_new(ele_idx, db_mod->id, db_mod->vendor);
-	if (!mod)
+	if (db_mod->num_bindings > MAX_BINDINGS) {
+		l_warn("Binding list too long %u (max %u)",
+					db_mod->num_bindings, MAX_BINDINGS);
 		return NULL;
+	}
+
+	mod = model_new(ele_idx, db_mod->vendor ? db_mod->id :
+						db_mod->id | VENDOR_ID_MASK);
 
 	/* Implicitly bind config server model to device key */
 	if (db_mod->id == CONFIG_SRV_MODEL) {
@@ -1113,35 +1414,27 @@ struct mesh_model *mesh_model_init(struct mesh_net *net, uint8_t ele_idx,
 		return mod;
 	}
 
+	net = node_get_net(node);
+
 	/* Add application key bindings if present */
 	if (db_mod->bindings) {
 		mod->bindings = l_queue_new();
-
-		if (!mod->bindings) {
-			mesh_model_free(mod);
-			return NULL;
-		}
-
-		for (i = 0; i < db_mod->num_bindings; i++) {
-			if (!model_bind_idx(mod, db_mod->bindings[i])) {
-				mesh_model_free(mod);
-				return NULL;
-			}
-		}
+		for (i = 0; i < db_mod->num_bindings; i++)
+			model_bind_idx(node, mod, db_mod->bindings[i]);
 	}
 
 	/* Add publication if present */
 	if (db_mod->pub) {
-		uint16_t mod_addr;
-		uint8_t *dst;
+		struct mesh_db_pub *pub = db_mod->pub;
+		uint8_t mod_addr[2];
+		uint8_t *pub_addr;
 
-		l_put_le16(db_mod->pub->addr, &mod_addr);
-		dst = db_mod->pub->virt ? db_mod->pub->virt_addr :
-							(uint8_t *) &mod_addr;
+		/* Add publication */
+		l_put_le16(pub->addr, &mod_addr);
+		pub_addr = pub->virt ? pub->virt_addr : (uint8_t *) &mod_addr;
 
-		if (set_pub(mod, dst, db_mod->pub->idx, db_mod->pub->credential,
-			db_mod->pub->ttl, db_mod->pub->period,
-			db_mod->pub->retransmit, db_mod->pub->virt, NULL) !=
+		if (set_pub(mod, pub_addr, pub->idx, pub->credential, pub->ttl,
+			pub->period, pub->retransmit, pub->virt, NULL) !=
 							MESH_STATUS_SUCCESS) {
 			mesh_model_free(mod);
 			return NULL;
@@ -1192,7 +1485,7 @@ uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf)
 		return 3;
 	}
 
-	l_info("Illegal Opcode %x", opcode);
+	l_debug("Illegal Opcode %x", opcode);
 	return 0;
 }
 
@@ -1238,7 +1531,7 @@ bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
 	return true;
 }
 
-void mesh_model_add_virtual(struct mesh_net *net, const uint8_t *v)
+void mesh_model_add_virtual(struct mesh_node *node, const uint8_t *v)
 {
 	struct mesh_virtual *virt = l_queue_find(mesh_virtuals,
 						find_virt_by_addr, v);
@@ -1263,7 +1556,7 @@ void mesh_model_add_virtual(struct mesh_net *net, const uint8_t *v)
 	l_queue_push_head(mesh_virtuals, virt);
 }
 
-void mesh_model_del_virtual(struct mesh_net *net, uint32_t va24)
+void mesh_model_del_virtual(struct mesh_node *node, uint32_t va24)
 {
 	struct mesh_virtual *virt = l_queue_remove_if(mesh_virtuals,
 						find_virt_by_id,
@@ -1272,3 +1565,55 @@ void mesh_model_del_virtual(struct mesh_net *net, uint32_t va24)
 	if (virt)
 		unref_virt(virt);
 }
+
+void model_build_config(void *model, void *msg_builder)
+{
+	struct l_dbus_message_builder *builder = msg_builder;
+	struct mesh_model *mod = model;
+	uint16_t id;
+
+	if (is_internal(mod->id))
+		return;
+
+	if (!l_queue_length(mod->subs) && !l_queue_length(mod->virtuals) &&
+				!mod->pub && !l_queue_length(mod->bindings))
+		return;
+
+	l_dbus_message_builder_enter_struct(builder, "qa{sv}");
+
+	/* Model id */
+	id = mod->id & 0xffff;
+	l_dbus_message_builder_append_basic(builder, 'q', &id);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	/* For vendor models, add vendor id */
+	if ((mod->id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
+		uint16_t vendor = mod->id >> 16;
+		dbus_append_dict_entry_basic(builder, "Vendor", "q", &vendor);
+	}
+
+	/* Model bindings, if present */
+	if (l_queue_length(mod->bindings))
+		append_dict_uint16_array(builder, mod->bindings, "Bindings");
+
+	/* Model periodic publication interval, if present */
+	if (mod->pub) {
+		uint32_t period = convert_pub_period_to_ms(mod->pub->period);
+		dbus_append_dict_entry_basic(builder, "PublicationPeriod", "u",
+								&period);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_struct(builder);
+}
+
+void mesh_model_init(void)
+{
+	mesh_virtuals = l_queue_new();
+}
+
+void mesh_model_cleanup(void)
+{
+	l_queue_destroy(mesh_virtuals, l_free);
+}
diff --git a/mesh/model.h b/mesh/model.h
index 3a41bd722..95acfe588 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -85,62 +85,64 @@ struct mesh_model_ops {
 	mesh_model_sub_cb sub;
 };
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id, bool vendor);
+struct mesh_model *mesh_model_new(uint8_t ele_idx, uint16_t mod_id);
+struct mesh_model *mesh_model_vendor_new(uint8_t ele_idx, uint16_t vendor_id,
+							uint16_t mod_id);
 void mesh_model_free(void *data);
 uint32_t mesh_model_get_model_id(const struct mesh_model *model);
-bool mesh_model_vendor_register(struct mesh_net *net, uint8_t ele_idx,
-					uint32_t mod_id,
-					const struct mesh_model_ops *cbs,
-					void *user_data);
-bool mesh_model_register(struct mesh_net *net, uint8_t ele_idx, uint32_t mod_id,
-					const struct mesh_model_ops *cbs,
+bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t mod_id, const struct mesh_model_ops *cbs,
 							void *user_data);
-struct mesh_model_pub *mesh_model_pub_get(struct mesh_net *net, uint8_t ele_idx,
-						uint32_t mod_id, int *status);
-int mesh_model_pub_set(struct mesh_net *net, uint16_t addr, uint32_t id,
+struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
+				uint8_t ele_idx, uint32_t mod_id, int *status);
+int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *mod_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool b_virt, uint16_t *dst);
-struct mesh_model *mesh_model_init(struct mesh_net *net, uint8_t ele_idx,
-						struct mesh_db_model *db_mod);
+struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
+								void *data);
 
-int mesh_model_binding_add(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx);
-int mesh_model_binding_del(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_binding_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t idx);
-int mesh_model_get_bindings(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint8_t *buf, uint16_t buf_len, uint16_t *size);
-int mesh_model_sub_add(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 						const uint8_t *grp, bool b_virt,
 						uint16_t *dst);
-int mesh_model_sub_del(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 						const uint8_t *grp, bool b_virt,
 						uint16_t *dst);
-int mesh_model_sub_del_all(struct mesh_net *net, uint16_t addr, uint32_t id);
-int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id);
+int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 						const uint8_t *grp, bool b_virt,
 						uint16_t *dst);
-int mesh_model_sub_get(struct mesh_net *net, uint16_t addr, uint32_t id,
+int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
-unsigned int mesh_model_send(struct mesh_net *net, uint32_t mod_id,
-				uint16_t src, uint32_t target,
-				uint16_t app_idx, uint8_t ttl,
+bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
+					uint16_t app_idx, uint8_t ttl,
+					const void *msg, uint16_t msg_len);
+int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
+				uint16_t src, uint8_t ttl,
 				const void *msg, uint16_t msg_len);
-
-bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
+bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint8_t ttl,
 			uint16_t src, uint16_t dst, uint8_t key_id,
 			const uint8_t *data, uint16_t size);
 
-void mesh_model_app_key_generate_new(struct mesh_net *net, uint16_t net_idx);
-void mesh_model_app_key_delete(struct mesh_net *net, struct l_queue *models,
+void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
+void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
 								uint16_t idx);
-struct l_queue *mesh_model_get_appkeys(struct mesh_net *net);
-void *mesh_model_get_local_node_data(struct mesh_net *net);
-void mesh_model_add_virtual(struct mesh_net *net, const uint8_t *v);
-void mesh_model_del_virtual(struct mesh_net *net, uint32_t va24);
-void mesh_model_list_virtual(struct mesh_net *net);
+struct l_queue *mesh_model_get_appkeys(struct mesh_node *node);
+void mesh_model_add_virtual(struct mesh_node *node, const uint8_t *v);
+void mesh_model_del_virtual(struct mesh_node *node, uint32_t va24);
+void mesh_model_list_virtual(struct mesh_node *node);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
 bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
 					uint32_t *opcode, uint16_t *n);
+void model_build_config(void *model, void *msg_builder);
+
+void mesh_model_init(void);
+void mesh_model_cleanup(void);
-- 
2.14.5

