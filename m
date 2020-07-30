Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F11C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658AB20838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgG3UjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:39:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:35035 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgG3UjB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 16:39:01 -0400
IronPort-SDR: VgWeTaFlFq9ROzVuTTd8cPijaSbi44VvjvYXhe+J/Suy5+wXaZNeViL1ZJual694+frKlmpA8N
 1zhQzPtxSSRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169803102"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="169803102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 13:39:00 -0700
IronPort-SDR: IMoOCXJbrCDJ3Mg8We/Hllh5h9xdKJKvYr5LwIKKRe+SwcsNU9PX9CxeTFV0VIsLje5Jo1ves2
 /Iv/mZXcp5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="330864974"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 13:38:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 06/10] mesh: Clean up handling of config relay messages
Date:   Thu, 30 Jul 2020 13:38:47 -0700
Message-Id: <20200730203851.32043-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730203851.32043-1-inga.stotland@intel.com>
References: <20200730203851.32043-1-inga.stotland@intel.com>
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
index 67e320eda..f1237b0fe 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -390,6 +390,30 @@ static uint16_t model_app_bind(struct mesh_node *node, const uint8_t *pkt,
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
@@ -759,24 +783,14 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
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

