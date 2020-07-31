Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C29B2250E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgGaGTk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:19:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:44828 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731404AbgGaGTj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 02:19:39 -0400
IronPort-SDR: fITy5npkKJaWx3eSj1c+pBSu0tBcQd6gkC3NOJeE6gJ/VReppvp7VzXdwbJ4OUe0NqP517vacC
 cnh5L9m6bNBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213269549"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="213269549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 23:19:39 -0700
IronPort-SDR: ReR8ykOfQVZ/CK4YzQ1mNkXilhY2beSYcUDnkAMoBxS0yI0lRwbh8F00xrk+iRI04X/zP8FEfy
 zlfryhmE+Glg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="329163338"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2020 23:19:38 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 02/10] mesh: Clean up handling of config model binding messages
Date:   Thu, 30 Jul 2020 23:19:28 -0700
Message-Id: <20200731061936.56952-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731061936.56952-1-inga.stotland@intel.com>
References: <20200731061936.56952-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modification allows using a single point for sending out
the composed status messages by the Config Server.
---
 mesh/cfgmod-server.c | 128 +++++++++++--------------------------------
 mesh/model.c         |  16 +-----
 2 files changed, 35 insertions(+), 109 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index cd0e8b94c..8a92c6cd7 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -112,8 +112,7 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 	uint16_t ele_addr, idx, ota = UNASSIGNED_ADDRESS;
 	const uint8_t *pub_addr;
 	uint16_t test_addr;
-	uint8_t ttl, period;
-	uint8_t retransmit;
+	uint8_t ttl, period, retransmit;
 	int status;
 	bool cred_flag;
 
@@ -362,115 +361,52 @@ static uint16_t config_sub_del_all(struct mesh_node *node, const uint8_t *pkt,
 	return n;
 }
 
-static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					uint8_t status, uint16_t addr,
-					uint32_t id, uint16_t idx)
-{
-	size_t n = mesh_model_opcode_set(OP_MODEL_APP_STATUS, msg);
-
-	msg[n++] = status;
-	l_put_le16(addr, msg + n);
-	n += 2;
-	l_put_le16(idx, msg + n);
-	n += 2;
-
-	if (IS_VENDOR(id)) {
-		l_put_le16(VENDOR_ID(id), msg + n);
-		n += 2;
-	}
-
-	l_put_le16(MODEL_ID(id), msg + n);
-	n += 2;
-
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-								false, msg, n);
-}
-
-static void model_app_list(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
+static uint16_t model_app_list(struct mesh_node *node,
 					const uint8_t *pkt, uint16_t size)
 {
-	uint16_t ele_addr;
+	uint16_t ele_addr, n, bnd_len;
 	uint32_t id;
-	uint8_t *status;
-	uint16_t n;
-	int result;
+	int opcode;
 
+	opcode = (size == 4) ? OP_MODEL_APP_LIST : OP_VEND_MODEL_APP_LIST;
 	ele_addr = l_get_le16(pkt);
 
-	switch (size) {
-	default:
-		return;
-	case 4:
-		n = mesh_model_opcode_set(OP_MODEL_APP_LIST, msg);
-		status = msg + n;
-		id = l_get_le16(pkt + 2);
-		l_put_le16(ele_addr, msg + 1 + n);
-		l_put_le16((uint16_t) id, msg + 3 + n);
-		id = SET_ID(SIG_VENDOR, id);
-		n += 5;
-		break;
-	case 6:
-		n = mesh_model_opcode_set(OP_VEND_MODEL_APP_LIST, msg);
-		status = msg + n;
-		id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
+	n = mesh_model_opcode_set(opcode, msg);
+	memcpy(msg + n + 1, pkt, size);
 
-		l_put_le16(ele_addr, msg + 1 + n);
-		l_put_le16((uint16_t) VENDOR_ID(id), msg + 3 + n);
-		l_put_le16((uint16_t) MODEL_ID(id), msg + 5 + n);
-		n += 7;
-		break;
-	}
+	id = CFG_SET_ID(size == 6, pkt + 2);
 
-	result = mesh_model_get_bindings(node, ele_addr, id, msg + n,
-						MAX_MSG_LEN - n, &size);
-	n += size;
+	msg[n] = mesh_model_get_bindings(node, ele_addr, id, msg + n + 1 + size,
+					MAX_MSG_LEN - (n + 1 + size), &bnd_len);
 
-	if (result >= 0) {
-		*status = result;
-		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
-						DEFAULT_TTL, false, msg, n);
-	}
+	if (msg[n] == MESH_STATUS_SUCCESS)
+		n += bnd_len;
+
+	n += (size + 1);
+	return n;
 }
 
-static bool model_app_bind(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, uint16_t size,
-					bool unbind)
+static uint16_t model_app_bind(struct mesh_node *node, const uint8_t *pkt,
+						uint16_t size, bool unbind)
 {
-	uint16_t ele_addr;
+	uint16_t ele_addr, idx, n;
 	uint32_t id;
-	uint16_t idx;
-	int result;
-
-	switch (size) {
-	default:
-		return false;
-
-	case 6:
-		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 4));
-		break;
-	case 8:
-		id = SET_ID(l_get_le16(pkt + 4), l_get_le16(pkt + 6));
-		break;
-	}
 
 	ele_addr = l_get_le16(pkt);
 	idx = l_get_le16(pkt + 2);
+	id = CFG_SET_ID(size == 8, pkt + 4);
 
-	if (idx > 0xfff)
-		return false;
+	n = mesh_model_opcode_set(OP_MODEL_APP_STATUS, msg);
 
 	if (unbind)
-		result = mesh_model_binding_del(node, ele_addr, id, idx);
+		msg[n] = mesh_model_binding_del(node, ele_addr, id, idx);
 	else
-		result = mesh_model_binding_add(node, ele_addr, id, idx);
+		msg[n] = mesh_model_binding_add(node, ele_addr, id, idx);
 
-	send_model_app_status(node, net_idx, src, dst, result, ele_addr,
-								id, idx);
+	memcpy(msg + n + 1, pkt, size);
+	n += (size + 1);
 
-	return true;
+	return n;
 }
 
 static void hb_pub_timeout_func(struct l_timeout *timeout, void *user_data)
@@ -703,8 +639,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (size != 1 || pkt[0] > TTL_MASK || pkt[0] == 1)
 			return true;
 
-		if (pkt[0] <= TTL_MASK)
-			node_default_ttl_set(node, pkt[0]);
+		node_default_ttl_set(node, pkt[0]);
 		/* Fall Through */
 
 	case OP_CONFIG_DEFAULT_TTL_GET:
@@ -1048,22 +983,25 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 	case OP_MODEL_APP_BIND:
 	case OP_MODEL_APP_UNBIND:
-		model_app_bind(node, net_idx, src, dst, pkt, size,
-				opcode != OP_MODEL_APP_BIND);
+		if (size != 6 && size != 8)
+			return true;
+
+		n = model_app_bind(node, pkt, size,
+						opcode != OP_MODEL_APP_BIND);
 		break;
 
 	case OP_VEND_MODEL_APP_GET:
 		if (size != 6)
 			return true;
 
-		model_app_list(node, net_idx, src, dst, pkt, size);
+		n = model_app_list(node, pkt, size);
 		break;
 
 	case OP_MODEL_APP_GET:
 		if (size != 4)
 			return true;
 
-		model_app_list(node, net_idx, src, dst, pkt, size);
+		n = model_app_list(node, pkt, size);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_SET:
diff --git a/mesh/model.c b/mesh/model.c
index 3c9b6577a..e2cadfe36 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -111,13 +111,7 @@ static bool simple_match(const void *a, const void *b)
 
 static bool has_binding(struct l_queue *bindings, uint16_t idx)
 {
-	const struct l_queue_entry *l;
-
-	for (l = l_queue_get_entries(bindings); l; l = l->next) {
-		if (L_PTR_TO_UINT(l->data) == idx)
-			return true;
-	}
-	return false;
+	return l_queue_find(bindings, simple_match, L_UINT_TO_PTR(idx)) != NULL;
 }
 
 static bool find_virt_by_label(const void *a, const void *b)
@@ -628,7 +622,6 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind)
 {
 	struct mesh_model *mod;
-	bool is_present;
 	int ele_idx = node_get_element_idx(node, addr);
 
 	if (ele_idx < 0)
@@ -645,12 +638,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!appkey_have_key(node_get_net(node), app_idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
-	is_present = has_binding(mod->bindings, app_idx);
-
-	if (!is_present && unbind)
-		return MESH_STATUS_SUCCESS;
-
-	if (is_present && !unbind)
+	if (unbind ^ has_binding(mod->bindings, app_idx))
 		return MESH_STATUS_SUCCESS;
 
 	if (unbind) {
-- 
2.26.2

