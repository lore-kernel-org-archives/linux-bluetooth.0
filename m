Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A653C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5231320855
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHGBio (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:38:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:44001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHGBin (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 21:38:43 -0400
IronPort-SDR: hqPlxLHPANRWYA6VDhO5yN0zK+Lzy7zJlG39GBmfn5ourxD04qxRV9tmJ7GkywpAPRlvz5+DBO
 1lPctfE4eXYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140558049"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140558049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 18:38:42 -0700
IronPort-SDR: d0+DkxrQIk/MRWpMjC+d2blzVC8eWQV9gV8j9RaJSWH4d1DhkdUN4BQWfdAiwvzyBvLOJGGt26
 gXzz5PevfvvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="397442094"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.119.50])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2020 18:38:42 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 08/10] mesh: Clean up handling of config net transmit messages
Date:   Thu,  6 Aug 2020 18:38:32 -0700
Message-Id: <20200807013834.123263-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807013834.123263-1-inga.stotland@intel.com>
References: <20200807013834.123263-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modification allows using a single point for sending out
the composed status messages by the Config Server.
---
 mesh/cfgmod-server.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index f3cc18ae0..191c5b8ef 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -662,6 +662,28 @@ static uint16_t cfg_poll_timeout_msg(struct mesh_node *node, const uint8_t *pkt)
 	return n;
 }
 
+static uint16_t cfg_net_tx_msg(struct mesh_node *node, const uint8_t *pkt,
+								int opcode)
+{
+	uint8_t cnt;
+	uint16_t interval, n;
+	struct mesh_net *net = node_get_net(node);
+
+	cnt = (pkt[0] & 0x7) + 1;
+	interval = ((pkt[0] >> 3) + 1) * 10;
+
+	if (opcode == OP_CONFIG_NETWORK_TRANSMIT_SET &&
+			mesh_config_write_net_transmit(node_config_get(node),
+							cnt, interval))
+		mesh_net_transmit_params_set(net, cnt, interval);
+
+	n = mesh_model_opcode_set(OP_CONFIG_NETWORK_TRANSMIT_STATUS, msg);
+
+	mesh_net_transmit_params_get(net, &cnt, &interval);
+	msg[n++] = (cnt - 1) + ((interval/10 - 1) << 3);
+	return n;
+}
+
 static uint16_t get_composition(struct mesh_node *node, uint8_t page,
 								uint8_t *buf)
 {
@@ -704,8 +726,6 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	uint8_t state, status;
 	uint8_t phase;
 	bool virt = false;
-	uint8_t count;
-	uint16_t interval;
 	uint16_t n;
 
 	if (app_idx != APP_IDX_DEV_LOCAL)
@@ -827,25 +847,13 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	case OP_CONFIG_NETWORK_TRANSMIT_SET:
 		if (size != 1)
 			return true;
-
-		count = (pkt[0] & 0x7) + 1;
-		interval = ((pkt[0] >> 3) + 1) * 10;
-
-		if (mesh_config_write_net_transmit(node_config_get(node), count,
-								interval))
-			mesh_net_transmit_params_set(net, count, interval);
 		/* Fall Through */
 
 	case OP_CONFIG_NETWORK_TRANSMIT_GET:
 		if (opcode == OP_CONFIG_NETWORK_TRANSMIT_GET && size != 0)
 			return true;
 
-		n = mesh_model_opcode_set(OP_CONFIG_NETWORK_TRANSMIT_STATUS,
-									msg);
-		mesh_net_transmit_params_get(net, &count, &interval);
-		msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
-
-		l_debug("Get/Set Network Transmit Config");
+		n = cfg_net_tx_msg(node, pkt, opcode);
 		break;
 
 	case OP_CONFIG_PROXY_SET:
-- 
2.26.2

