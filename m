Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1D0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6BD207FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHDURw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:17:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:64991 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgHDURu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 16:17:50 -0400
IronPort-SDR: W+t0JQX3978lC1+MtHDU7eh/BPLJZYIUL6ajf9H37i+0iGj3fNhtIKwDHvbA68WECrno9tc6tr
 lnsXl/sh2r8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153565397"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="153565397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 13:17:49 -0700
IronPort-SDR: pC75ObEXvPigEStMJPpDfrUKNWXNwTxviKjezXifrdK19TM7mnyvMjDT+6Wd/EXSPzHX6FvuBr
 6I7+MKvF+DRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="324783853"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.65])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 13:17:49 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 09/10] mesh: Clean up handling of config KR phase messages
Date:   Tue,  4 Aug 2020 13:17:43 -0700
Message-Id: <20200804201744.23327-9-inga.stotland@intel.com>
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
 mesh/cfgmod-server.c | 55 +++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 5b3ed3d97..5854f7a1c 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -420,6 +420,31 @@ static uint16_t cfg_relay_msg(struct mesh_node *node, const uint8_t *pkt,
 	return n;
 }
 
+static uint16_t cfg_key_refresh_phase(struct mesh_node *node,
+						const uint8_t *pkt, int opcode)
+{
+	struct mesh_net *net = node_get_net(node);
+	uint16_t n, idx = l_get_le16(pkt);
+	uint8_t phase;
+
+	n = mesh_model_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_STATUS, msg);
+
+	if (opcode == OP_CONFIG_KEY_REFRESH_PHASE_SET) {
+		phase = pkt[2];
+		msg[n] = mesh_net_key_refresh_phase_set(net, idx, phase);
+		l_debug("Set KR Phase: net=%3.3x transition=%d", idx, phase);
+	} else {
+		msg[n] = mesh_net_key_refresh_phase_get(net, idx, &phase);
+		l_debug("Get KR Phase: net=%3.3x phase=%d", idx, phase);
+	}
+
+	l_put_le16(idx, msg + n);
+	msg[n + 2] = (msg[n] != MESH_STATUS_SUCCESS) ?
+						KEY_REFRESH_PHASE_NONE : phase;
+
+	return n + 3;
+}
+
 static void hb_pub_timeout_func(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
@@ -718,8 +743,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	int b_res = MESH_STATUS_SUCCESS;
 	struct mesh_net_heartbeat *hb;
 	uint16_t n_idx;
-	uint8_t state, status;
-	uint8_t phase;
+	uint8_t state;
 	bool virt = false;
 	uint16_t n;
 
@@ -926,37 +950,16 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_KEY_REFRESH_PHASE_SET:
-		if (size != 3 || pkt[2] > 0x03)
+		if (size != 3 || pkt[2] > KEY_REFRESH_PHASE_THREE)
 			return true;
 
-		b_res = mesh_net_key_refresh_phase_set(net, l_get_le16(pkt),
-							pkt[2]);
-		size = 2;
 		/* Fall Through */
 
 	case OP_CONFIG_KEY_REFRESH_PHASE_GET:
-		if (size != 2)
+		if (size != 2 && opcode == OP_CONFIG_KEY_REFRESH_PHASE_GET)
 			return true;
 
-		n_idx = l_get_le16(pkt);
-
-		n = mesh_model_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_STATUS,
-						msg);
-
-		/* State: 0x00-0x03 phase of key refresh */
-		status = mesh_net_key_refresh_phase_get(net, n_idx,
-							&phase);
-		if (status != MESH_STATUS_SUCCESS) {
-			b_res = status;
-			phase = KEY_REFRESH_PHASE_NONE;
-		}
-
-		msg[n++] = b_res;
-		l_put_le16(n_idx, msg + n);
-		n += 2;
-		msg[n++] = phase;
-
-		l_debug("Get/Set Key Refresh State (%d)", msg[n-1]);
+		n = cfg_key_refresh_phase(node, pkt, opcode);
 		break;
 
 	case OP_APPKEY_ADD:
-- 
2.26.2

