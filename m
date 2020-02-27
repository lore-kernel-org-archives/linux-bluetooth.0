Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB936C4BA24
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 06:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B129424683
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 06:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgB0G4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:56:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:27222 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgB0G4K (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 01:56:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 22:56:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="232076651"
Received: from ingas-nuc1.sea.intel.com ([10.255.71.226])
  by fmsmga008.fm.intel.com with ESMTP; 26 Feb 2020 22:56:08 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Remove unused parameters from internal rx functions
Date:   Wed, 26 Feb 2020 22:56:07 -0800
Message-Id: <20200227065607.21081-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes unused ttl parameter from mesh_model_rx(). The TTL value
is not processed at the access layer, so there is no need to pass it
to a model.
Also, remove "uint32_t dst" parameter from the typedef of
mesh_model_recv_cb: providing a just destination address is sufficient
for internally implemented models (currently, it's only Config Server)
---
 mesh/cfgmod-server.c | 29 ++++++++++++++---------------
 mesh/model.c         | 17 +++++++----------
 mesh/model.h         | 11 +++++------
 mesh/net.c           |  4 ++--
 4 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 3eb7316fc..a1f682765 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -704,10 +704,9 @@ static void node_reset(struct l_timeout *timeout, void *user_data)
 	node_remove(node);
 }
 
-static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
-				uint16_t app_idx, uint16_t net_idx,
-				const uint8_t *data, uint16_t size,
-				uint8_t ttl, const void *user_data)
+static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
+				uint16_t net_idx, const uint8_t *data,
+				uint16_t size, const void *user_data)
 {
 	struct mesh_node *node = (struct mesh_node *) user_data;
 	struct mesh_net *net;
@@ -782,7 +781,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		if (size != 25 && size != 27)
 			return true;
 
-		config_pub_set(node, net_idx, src, unicast, pkt, 14, size == 27,
+		config_pub_set(node, net_idx, src, dst, pkt, 14, size == 27,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
@@ -790,26 +789,26 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		if (size != 11 && size != 13)
 			return true;
 
-		config_pub_set(node, net_idx, src, unicast, pkt, 0, size == 13,
+		config_pub_set(node, net_idx, src, dst, pkt, 0, size == 13,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
-		config_pub_get(node, net_idx, src, unicast, pkt, size);
+		config_pub_get(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_CONFIG_VEND_MODEL_SUB_GET:
 		if (size != 6)
 			return true;
 
-		config_sub_get(node, net_idx, src, unicast, pkt, size);
+		config_sub_get(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_GET:
 		if (size != 4)
 			return true;
 
-		config_sub_get(node, net_idx, src, unicast, pkt, size);
+		config_sub_get(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
@@ -821,7 +820,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 	case OP_CONFIG_MODEL_SUB_DELETE:
 	case OP_CONFIG_MODEL_SUB_ADD:
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		config_sub_set(node, net_idx, src, unicast, pkt, size, virt,
+		config_sub_set(node, net_idx, src, dst, pkt, size, virt,
 									opcode);
 		break;
 
@@ -1087,20 +1086,20 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 
 	case OP_MODEL_APP_BIND:
 	case OP_MODEL_APP_UNBIND:
-		model_app_bind(node, net_idx, src, unicast, pkt, size,
+		model_app_bind(node, net_idx, src, dst, pkt, size,
 				opcode != OP_MODEL_APP_BIND);
 		break;
 
 	case OP_VEND_MODEL_APP_GET:
 		if (size != 6)
 			return true;
-		model_app_list(node, net_idx, src, unicast, pkt, size);
+		model_app_list(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_MODEL_APP_GET:
 		if (size != 4)
 			return true;
-		model_app_list(node, net_idx, src, unicast, pkt, size);
+		model_app_list(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_SET:
@@ -1225,7 +1224,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 	case OP_NODE_RESET:
 		n = mesh_model_opcode_set(OP_NODE_RESET_STATUS, msg);
 		/*
-		 * delay node removal to give it a chance to send back the
+		 * Delay node removal to give it a chance to send back the
 		 * status
 		 */
 		l_timeout_create(1, node_reset, node, NULL);
@@ -1234,7 +1233,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 
 	if (n) {
 		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
-		mesh_model_send(node, unicast, src,
+		mesh_model_send(node, dst, src,
 				APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
 				long_msg ? long_msg : msg, n);
 	}
diff --git a/mesh/model.c b/mesh/model.c
index e02658363..d11c95ab9 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -71,7 +71,6 @@ struct mod_forward {
 	uint16_t app_idx;
 	uint16_t net_idx;
 	uint16_t size;
-	uint8_t ttl;
 	int8_t rssi;
 	bool szmict;
 	bool has_dst;
@@ -359,17 +358,16 @@ static void forward_model(void *a, void *b)
 	uint16_t dst;
 	bool result;
 
-	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->app_idx);
-
 	if (fwd->app_idx != APP_IDX_DEV_LOCAL &&
 				fwd->app_idx != APP_IDX_DEV_REMOTE &&
 				!has_binding(mod->bindings, fwd->app_idx))
 		return;
 
 	dst = fwd->dst;
-	if (dst == fwd->unicast || IS_FIXED_GROUP_ADDRESS(dst))
+
+	if (dst == fwd->unicast || IS_FIXED_GROUP_ADDRESS(dst)) {
 		fwd->has_dst = true;
-	else if (fwd->virt) {
+	} else if (fwd->virt) {
 		virt = l_queue_find(mod->virtuals, simple_match, fwd->virt);
 		if (virt) {
 			fwd->has_dst = true;
@@ -390,9 +388,9 @@ static void forward_model(void *a, void *b)
 	result = false;
 
 	if (mod->cbs->recv)
-		result = mod->cbs->recv(fwd->src, dst, fwd->unicast,
-				fwd->app_idx, fwd->net_idx,
-				fwd->data, fwd->size, fwd->ttl, mod->user_data);
+		result = mod->cbs->recv(fwd->src, dst, fwd->app_idx,
+				fwd->net_idx,
+				fwd->data, fwd->size, mod->user_data);
 
 	if (dst == fwd->unicast && result)
 		fwd->done = true;
@@ -899,7 +897,7 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 }
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-			uint32_t seq, uint32_t iv_index, uint8_t ttl,
+			uint32_t seq, uint32_t iv_index,
 			uint16_t net_idx, uint16_t src, uint16_t dst,
 			uint8_t key_aid, const uint8_t *data, uint16_t size)
 {
@@ -909,7 +907,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		.dst = dst,
 		.data = NULL,
 		.size = size - (szmict ? 8 : 4),
-		.ttl = ttl,
 		.virt = NULL,
 	};
 	struct mesh_net *net = node_get_net(node);
diff --git a/mesh/model.h b/mesh/model.h
index 0613c9cca..153ab9bfd 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -46,10 +46,9 @@ struct mesh_model_pub {
 };
 
 typedef void (*mesh_model_unregister)(void *user_data);
-typedef bool (*mesh_model_recv_cb)(uint16_t src, uint32_t dst, uint16_t unicast,
+typedef bool (*mesh_model_recv_cb)(uint16_t src, uint16_t unicast,
 					uint16_t app_idx, uint16_t net_idx,
-					const uint8_t *data,
-					uint16_t len, uint8_t ttl,
+					const uint8_t *data, uint16_t len,
 					const void *user_data);
 typedef int (*mesh_model_bind_cb)(uint16_t app_idx, int action);
 typedef int (*mesh_model_pub_cb)(struct mesh_model_pub *pub);
@@ -101,9 +100,9 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 int mesh_model_publish(struct mesh_node *node, uint32_t mod_id, uint16_t src,
 				uint8_t ttl, const void *msg, uint16_t msg_len);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-			uint32_t seq, uint32_t iv_index, uint8_t ttl,
-			uint16_t net_idx, uint16_t src, uint16_t dst,
-			uint8_t key_aid, const uint8_t *data, uint16_t size);
+			uint32_t seq, uint32_t iv_index, uint16_t net_idx,
+			uint16_t src, uint16_t dst, uint8_t key_aid,
+			const uint8_t *data, uint16_t size);
 void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
 void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
 								uint16_t idx);
diff --git a/mesh/net.c b/mesh/net.c
index 5cf358fbd..d3325e073 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1778,8 +1778,8 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	}
 
 not_for_friend:
-	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index, ttl,
-					net_idx, src, dst, key_aid, data, size);
+	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index, net_idx,
+						src, dst, key_aid, data, size);
 }
 
 static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
-- 
2.21.1

