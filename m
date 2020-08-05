Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B716C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3179F206D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHETVT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:21:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:42218 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgHERr1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 13:47:27 -0400
IronPort-SDR: J9rjp3oVY9xGPmS7hmZjJc8/uqil547rGxBETq+KSm2PT1arymo26ZtDL/kjtHIZuV+kLhvVxb
 vYGGYC3rworQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="237470658"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="237470658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 10:45:01 -0700
IronPort-SDR: SPTRrvFqEXg3XhXh3+VEu2X5rEqDgzBzydNUNM/cg7j6h0/m7S6HUlOMn64W67Sl18Pw02AkxF
 KIETEP5Ei3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="437245758"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.189])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2020 10:45:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 07/10] mesh: Clean up handling of config poll timeout message
Date:   Wed,  5 Aug 2020 10:44:53 -0700
Message-Id: <20200805174456.49342-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805174456.49342-1-inga.stotland@intel.com>
References: <20200805174456.49342-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modification allows using a single point for sending out
the composed status messages by the Config Server.
---
 mesh/cfgmod-server.c | 34 +++++++++++++++++++++++-----------
 mesh/cfgmod.h        |  2 +-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 6ca1c1dd1..9b1375317 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -638,6 +638,25 @@ static uint16_t cfg_get_appkeys_msg(struct mesh_node *node, const uint8_t *pkt)
 	return n + 3 + sz;
 }
 
+static uint16_t cfg_poll_timeout_msg(struct mesh_node *node, const uint8_t *pkt)
+{
+	uint16_t n, addr = l_get_le16(pkt);
+	uint32_t poll_to;
+
+	if (!IS_UNICAST(addr))
+		return 0;
+
+	n = mesh_model_opcode_set(OP_CONFIG_POLL_TIMEOUT_STATUS, msg);
+	l_put_le16(addr, msg + n);
+	n += 2;
+
+	poll_to = mesh_net_friend_timeout(node_get_net(node), addr);
+	msg[n++] = poll_to;
+	msg[n++] = poll_to >> 8;
+	msg[n++] = poll_to >> 16;
+	return n;
+}
+
 static uint16_t get_composition(struct mesh_node *node, uint8_t page,
 								uint8_t *buf)
 {
@@ -673,7 +692,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	struct mesh_net *net;
 	const uint8_t *pkt = data;
 	struct timeval time_now;
-	uint32_t opcode, tmp32;
+	uint32_t opcode;
 	int b_res = MESH_STATUS_SUCCESS;
 	struct mesh_net_heartbeat *hb;
 	uint16_t n_idx;
@@ -1109,18 +1128,11 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		msg[n++] = hb->sub_max_hops;
 		break;
 
-	case OP_CONFIG_POLL_TIMEOUT_LIST:
-		if (size != 2 || l_get_le16(pkt) == 0 ||
-						l_get_le16(pkt) > 0x7fff)
+	case OP_CONFIG_POLL_TIMEOUT_GET:
+		if (size != 2)
 			return true;
 
-		n = mesh_model_opcode_set(OP_CONFIG_POLL_TIMEOUT_STATUS, msg);
-		l_put_le16(l_get_le16(pkt), msg + n);
-		n += 2;
-		tmp32 = mesh_net_friend_timeout(net, l_get_le16(pkt));
-		msg[n++] = tmp32;
-		msg[n++] = tmp32 >> 8;
-		msg[n++] = tmp32 >> 16;
+		n = cfg_poll_timeout_msg(node, pkt);
 		break;
 
 	case OP_NODE_RESET:
diff --git a/mesh/cfgmod.h b/mesh/cfgmod.h
index 7b6a95807..6d73656a7 100644
--- a/mesh/cfgmod.h
+++ b/mesh/cfgmod.h
@@ -66,7 +66,7 @@
 #define OP_CONFIG_MODEL_SUB_LIST		0x802A
 #define OP_CONFIG_VEND_MODEL_SUB_GET		0x802B
 #define OP_CONFIG_VEND_MODEL_SUB_LIST		0x802C
-#define OP_CONFIG_POLL_TIMEOUT_LIST		0x802D
+#define OP_CONFIG_POLL_TIMEOUT_GET		0x802D
 #define OP_CONFIG_POLL_TIMEOUT_STATUS		0x802E
 /* Health opcodes in health-mod.h */
 #define OP_CONFIG_HEARTBEAT_PUB_GET		0x8038
-- 
2.26.2

