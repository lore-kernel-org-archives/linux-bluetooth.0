Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F011CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64542145D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 23:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGMXFc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:05:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:39335 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgGMXFb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 19:05:31 -0400
IronPort-SDR: 4Q+q0twiCZfmSV/K2YvDX9WZp70E47yHDMDzvj84naVz5/UNbt2r74wx0GA3c93gOWDM+mhEkY
 GDfSaNbV6oeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="210285814"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="210285814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:05:31 -0700
IronPort-SDR: tMTv+b5dKee/Tq6WcIDvq5T1Uq7cxLU4/RIFuL+vXSFUhX4NCCdTbs4B6Cf4Co6ooEx4b38ljg
 BrytYOHcWpBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="459465788"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.112.118])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2020 16:05:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Add size checks for every opcode in config server
Date:   Mon, 13 Jul 2020 16:05:27 -0700
Message-Id: <20200713230528.107948-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713230528.107948-1-inga.stotland@intel.com>
References: <20200713230528.107948-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds missing size checks for the incoming config server messages.
---
 mesh/cfgmod-server.c | 46 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 08a74d014..9046a1ad9 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -754,7 +754,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 	case OP_DEV_COMP_GET:
 		if (size != 1)
-			return false;
+			return true;
 
 		n = mesh_model_opcode_set(OP_DEV_COMP_STATUS, msg);
 		n += get_composition(node, pkt[0], msg + n);
@@ -770,6 +770,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_CONFIG_DEFAULT_TTL_GET:
+		if (opcode == OP_CONFIG_DEFAULT_TTL_GET && size != 0)
+			return true;
+
 		l_debug("Get/Set Default TTL");
 
 		n = mesh_model_opcode_set(OP_CONFIG_DEFAULT_TTL_STATUS, msg);
@@ -792,6 +795,8 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
+		if (size != 4 && size != 6)
+			return true;
 		config_pub_get(node, net_idx, src, dst, pkt, size);
 		break;
 
@@ -832,6 +837,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_CONFIG_RELAY_GET:
+		if (opcode == OP_CONFIG_RELAY_GET && size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_CONFIG_RELAY_STATUS, msg);
 
 		msg[n++] = node_relay_mode_get(node, &count, &interval);
@@ -853,6 +861,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_CONFIG_NETWORK_TRANSMIT_GET:
+		if (opcode == OP_CONFIG_NETWORK_TRANSMIT_GET && size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_CONFIG_NETWORK_TRANSMIT_STATUS,
 									msg);
 		mesh_net_transmit_params_get(net, &count, &interval);
@@ -869,6 +880,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_CONFIG_PROXY_GET:
+		if (opcode == OP_CONFIG_PROXY_GET && size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_CONFIG_PROXY_STATUS, msg);
 
 		msg[n++] = node_proxy_mode_get(node);
@@ -883,9 +897,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (n_idx > 0xfff)
 			return true;
 
-		/*
-		 * Currently no support for proxy: node identity not supported
-		 */
+		/* Currently setting node identity not supported */
 
 		/* Fall Through */
 
@@ -918,6 +930,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_CONFIG_BEACON_GET:
+		if (opcode == OP_CONFIG_BEACON_GET && size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_CONFIG_BEACON_STATUS, msg);
 
 		msg[n++] = node_beacon_mode_get(node);
@@ -932,6 +947,8 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_CONFIG_FRIEND_GET:
+		if (opcode == OP_CONFIG_FRIEND_GET && size != 0)
+			return true;
 
 		n = mesh_model_opcode_set(OP_CONFIG_FRIEND_STATUS, msg);
 
@@ -1071,13 +1088,14 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_NETKEY_GET:
+		if (size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_NETKEY_LIST, msg);
 		size = MAX_MSG_LEN - n;
 
 		if (mesh_net_key_list_get(net, msg + n, &size))
 			n += size;
-		else
-			n = 0;
 		break;
 
 	case OP_MODEL_APP_BIND:
@@ -1089,21 +1107,22 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	case OP_VEND_MODEL_APP_GET:
 		if (size != 6)
 			return true;
+
 		model_app_list(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_MODEL_APP_GET:
 		if (size != 4)
 			return true;
+
 		model_app_list(node, net_idx, src, dst, pkt, size);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_SET:
 		l_debug("OP_CONFIG_HEARTBEAT_PUB_SET");
-		if (size != 9) {
-			l_debug("bad size %d", size);
+		if (size != 9)
 			return true;
-		}
+
 		if (pkt[2] > 0x11 || pkt[3] > 0x10 || pkt[4] > 0x7f)
 			return true;
 		else if (IS_VIRTUAL(l_get_le16(pkt)))
@@ -1150,6 +1169,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_GET:
+		if (size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_PUB_STATUS, msg);
 		msg[n++] = b_res;
 		l_put_le16(hb->pub_dst, msg + n);
@@ -1179,6 +1201,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall through */
 
 	case OP_CONFIG_HEARTBEAT_SUB_GET:
+		if (opcode == OP_CONFIG_HEARTBEAT_SUB_GET && size != 0)
+			return true;
+
 		gettimeofday(&time_now, NULL);
 		time_now.tv_sec -= hb->sub_start;
 
@@ -1218,6 +1243,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_NODE_RESET:
+		if (size != 0)
+			return true;
+
 		n = mesh_model_opcode_set(OP_NODE_RESET_STATUS, msg);
 
 		/* Delay node removal to give it a chance to send the status */
-- 
2.26.2

