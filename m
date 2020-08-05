Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8232075D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgHETUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:20:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:42221 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgHERrb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 13:47:31 -0400
IronPort-SDR: vb2gEmlZG6KKkEMFjhFQjALxpnX5K5lzEwoAumx0lBC4pAnMeXYVCPKXzuf9iu5K45u8PQKLwb
 LRvVPR6by+6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="237470666"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="237470666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 10:45:01 -0700
IronPort-SDR: HXkJqGMiCRMqe4Diix6MVCo3h0L9bv7IxvbKs9UY7roFHr0VguEKsCFzEWmAk3RbBkGhbD26SK
 dVIN/9nlsFlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="437245771"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.189])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2020 10:45:01 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 08/10] mesh: Clean up handling of config net transmit messages
Date:   Wed,  5 Aug 2020 10:44:54 -0700
Message-Id: <20200805174456.49342-9-inga.stotland@intel.com>
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
 mesh/cfgmod-server.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9b1375317..5b3ed3d97 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -657,6 +657,28 @@ static uint16_t cfg_poll_timeout_msg(struct mesh_node *node, const uint8_t *pkt)
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
@@ -699,8 +721,6 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	uint8_t state, status;
 	uint8_t phase;
 	bool virt = false;
-	uint8_t count;
-	uint16_t interval;
 	uint16_t n;
 
 	if (app_idx != APP_IDX_DEV_LOCAL)
@@ -821,25 +841,13 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
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

