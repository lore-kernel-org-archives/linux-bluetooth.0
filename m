Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34114C433E5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F86421473
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 23:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGMXFb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:05:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:39333 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgGMXFa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 19:05:30 -0400
IronPort-SDR: EXHd1WoYKZiJkWy2vYXCtQI2crNu+ZdqGHOGo3rO2o7IPhAp+NH7ZMUx+9dQ9IeuWwdN2hlZLt
 Cn7y7IaJVTkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="210285811"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="210285811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:05:30 -0700
IronPort-SDR: 268xJKY2evXU6iepcid2z6Syo/nJBmKynY+JgsV4egcNvXRlmP/Qa+AF4sJIoe6dlXEh0k77Qt
 yuNrAypC30wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="459465780"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.112.118])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2020 16:05:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/3] mesh: Use static array to hold config server response
Date:   Mon, 13 Jul 2020 16:05:26 -0700
Message-Id: <20200713230528.107948-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713230528.107948-1-inga.stotland@intel.com>
References: <20200713230528.107948-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This eliminates dynamic allocation for long responses and local
arrays for short responses. Instead, aclear text response from
config server is written into a static buffer and then encoded
into dynamically allocated messafe buffer to use in actual
transmission.
---
 mesh/cfgmod-server.c | 53 +++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 14b4a980e..08a74d014 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -32,21 +32,20 @@
 #include "mesh/mesh-config.h"
 #include "mesh/cfgmod.h"
 
-#define CFG_MAX_MSG_LEN 380
-
 /* Supported composition pages, sorted high to low */
 /* Only page 0 is currently supported */
 static const uint8_t supported_pages[] = {
 	0
 };
 
+static uint8_t msg[MAX_MSG_LEN];
+
 static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 			uint16_t src, uint16_t dst,
 			uint8_t status, uint16_t ele_addr, uint32_t mod_id,
 			uint16_t pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit)
 {
-	uint8_t msg[16];
 	size_t n;
 
 	n = mesh_model_opcode_set(OP_CONFIG_MODEL_PUB_STATUS, msg);
@@ -193,7 +192,6 @@ static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
 					uint8_t status, uint16_t ele_addr,
 					uint16_t addr, uint32_t mod)
 {
-	uint8_t msg[12];
 	int n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_STATUS, msg);
 
 	msg[n++] = status;
@@ -224,7 +222,6 @@ static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
 	int status;
 	uint8_t *msg_status;
 	uint16_t buf_size;
-	uint8_t msg[5 + sizeof(uint16_t) * MAX_GRP_PER_MOD];
 
 	/* Incoming message has already been size-checked */
 	ele_addr = l_get_le16(pkt);
@@ -430,7 +427,6 @@ static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
 					uint8_t status, uint16_t addr,
 					uint32_t id, uint16_t idx)
 {
-	uint8_t msg[12];
 	size_t n = mesh_model_opcode_set(OP_MODEL_APP_STATUS, msg);
 
 	msg[n++] = status;
@@ -455,21 +451,14 @@ static void model_app_list(struct mesh_node *node, uint16_t net_idx,
 {
 	uint16_t ele_addr;
 	uint32_t mod_id = 0xffff;
-	uint8_t *msg = NULL;
 	uint8_t *status;
-	uint16_t n, buf_size;
+	uint16_t n;
 	int result;
 
-	buf_size = MAX_BINDINGS * sizeof(uint16_t);
-	msg = l_malloc(7 + buf_size);
-	if (!msg)
-		return;
-
 	ele_addr = l_get_le16(pkt);
 
 	switch (size) {
 	default:
-		l_free(msg);
 		return;
 	case 4:
 		n = mesh_model_opcode_set(OP_MODEL_APP_LIST, msg);
@@ -495,7 +484,7 @@ static void model_app_list(struct mesh_node *node, uint16_t net_idx,
 
 
 	result = mesh_model_get_bindings(node, ele_addr, mod_id, msg + n,
-							buf_size, &size);
+						MAX_MSG_LEN - n, &size);
 	n += size;
 
 	if (result >= 0) {
@@ -503,8 +492,6 @@ static void model_app_list(struct mesh_node *node, uint16_t net_idx,
 		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
 						DEFAULT_TTL, false, msg, n);
 	}
-
-	l_free(msg);
 }
 
 static bool model_app_bind(struct mesh_node *node, uint16_t net_idx,
@@ -736,8 +723,6 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	struct timeval time_now;
 	uint32_t opcode, tmp32;
 	int b_res = MESH_STATUS_SUCCESS;
-	uint8_t msg[11];
-	uint8_t *long_msg = NULL;
 	struct mesh_net_heartbeat *hb;
 	uint16_t n_idx, a_idx;
 	uint8_t state, status;
@@ -771,9 +756,8 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (size != 1)
 			return false;
 
-		long_msg = l_malloc(CFG_MAX_MSG_LEN);
-		n = mesh_model_opcode_set(OP_DEV_COMP_STATUS, long_msg);
-		n += get_composition(node, pkt[0], long_msg + n);
+		n = mesh_model_opcode_set(OP_DEV_COMP_STATUS, msg);
+		n += get_composition(node, pkt[0], msg + n);
 
 		break;
 
@@ -1040,14 +1024,13 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 		n_idx = l_get_le16(pkt);
 
-		long_msg = l_malloc(CFG_MAX_MSG_LEN);
-		n = mesh_model_opcode_set(OP_APPKEY_LIST, long_msg);
+		n = mesh_model_opcode_set(OP_APPKEY_LIST, msg);
 
-		status = appkey_list(net, n_idx, long_msg + n + 3,
-						CFG_MAX_MSG_LEN - n - 3, &size);
+		status = appkey_list(net, n_idx, msg + n + 3,
+						MAX_MSG_LEN - n - 3, &size);
 
-		long_msg[n] = status;
-		l_put_le16(n_idx, long_msg + n + 1);
+		msg[n] = status;
+		l_put_le16(n_idx, msg + n + 1);
 		n += (size + 3);
 		break;
 
@@ -1088,11 +1071,10 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_NETKEY_GET:
-		long_msg = l_malloc(CFG_MAX_MSG_LEN);
-		n = mesh_model_opcode_set(OP_NETKEY_LIST, long_msg);
-		size = CFG_MAX_MSG_LEN - n;
+		n = mesh_model_opcode_set(OP_NETKEY_LIST, msg);
+		size = MAX_MSG_LEN - n;
 
-		if (mesh_net_key_list_get(net, long_msg + n, &size))
+		if (mesh_net_key_list_get(net, msg + n, &size))
 			n += size;
 		else
 			n = 0;
@@ -1244,11 +1226,8 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	}
 
 	if (n)
-		mesh_model_send(node, dst, src,
-				APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL, false,
-				long_msg ? long_msg : msg, n);
-
-	l_free(long_msg);
+		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
+						DEFAULT_TTL, false, msg, n);
 
 	return true;
 }
-- 
2.26.2

