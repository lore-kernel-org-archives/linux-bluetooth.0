Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50289207FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHDURv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:17:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:64991 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgHDURt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 16:17:49 -0400
IronPort-SDR: Y84rKC+WdpIY3/mwNE06/XNqOyKWhx49z9zytu6uDqDCWSGukSxbWcZP01FrEbm9aiOcBm9uJJ
 llQshrNDe3tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153565394"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="153565394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 13:17:48 -0700
IronPort-SDR: 8zBlRNszDlZ13myN52ktE+5K2fi+7V8QI3upRMXBsBid4aF3jr3hA+25iytvZybtlovWly4qRd
 /LuzoUtzFq9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="324783846"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.65])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 13:17:48 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 07/10] mesh: Clean up handling of config poll timeout message
Date:   Tue,  4 Aug 2020 13:17:41 -0700
Message-Id: <20200804201744.23327-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804201744.23327-1-inga.stotland@intel.com>
References: <20200804201744.23327-1-inga.stotland@intel.com>
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

