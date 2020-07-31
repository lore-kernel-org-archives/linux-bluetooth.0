Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A577BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E9E208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgGaGTn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:19:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:44828 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731415AbgGaGTm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 02:19:42 -0400
IronPort-SDR: zZsHICX3sMYFIz3pX/tjXQ/eXqy+lMEwitJ9dDJ7/nTqX7Q7lKisa7aNLdM+UY+t3rq1nExXHg
 rLbnzk6v79Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213269555"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="213269555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 23:19:42 -0700
IronPort-SDR: FyA+DWj941kBdfgUaZD8mhRgItvoqQrH1r6fuedk12NKtBv6q5FUYm2CeEvT/QGpaAcofXZ7mW
 E27yXP1VRjsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="329163352"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2020 23:19:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 06/10] mesh: Clean up handling of config relay messages
Date:   Thu, 30 Jul 2020 23:19:32 -0700
Message-Id: <20200731061936.56952-6-inga.stotland@intel.com>
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
 mesh/cfgmod-server.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9d243dd8b..8d5ec7438 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -386,6 +386,30 @@ static uint16_t model_app_bind(struct mesh_node *node, const uint8_t *pkt,
 	return n;
 }
 
+static uint16_t cfg_relay_msg(struct mesh_node *node, const uint8_t *pkt,
+								int opcode)
+{
+	uint8_t count;
+	uint16_t interval;
+	uint16_t n;
+
+	if (pkt[0] > 0x01)
+		return 0;
+
+	if (opcode == OP_CONFIG_RELAY_SET) {
+		count = (pkt[1] & 0x7) + 1;
+		interval = ((pkt[1] >> 3) + 1) * 10;
+		node_relay_mode_set(node, !!pkt[0], count, interval);
+	}
+
+	n = mesh_model_opcode_set(OP_CONFIG_RELAY_STATUS, msg);
+
+	msg[n++] = node_relay_mode_get(node, &count, &interval);
+	msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
+
+	return n;
+}
+
 static void hb_pub_timeout_func(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
@@ -755,24 +779,14 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_RELAY_SET:
-		if (size != 2 || pkt[0] > 0x01)
+		if (size != 2)
 			return true;
-
-		count = (pkt[1] & 0x7) + 1;
-		interval = ((pkt[1] >> 3) + 1) * 10;
-		node_relay_mode_set(node, !!pkt[0], count, interval);
 		/* Fall Through */
-
 	case OP_CONFIG_RELAY_GET:
 		if (opcode == OP_CONFIG_RELAY_GET && size != 0)
 			return true;
 
-		n = mesh_model_opcode_set(OP_CONFIG_RELAY_STATUS, msg);
-
-		msg[n++] = node_relay_mode_get(node, &count, &interval);
-		msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
-
-		l_debug("Get/Set Relay Config (%d)", msg[n-1]);
+		n = cfg_relay_msg(node, pkt, opcode);
 		break;
 
 	case OP_CONFIG_NETWORK_TRANSMIT_SET:
-- 
2.26.2

