Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B1FC433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061342173E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgG3UjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:39:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:35025 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgG3Ui7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 16:38:59 -0400
IronPort-SDR: c5rJEF0Km5popbUGrEAKxmFX5aacffKL6JZkWFy8thjbRUz8aOACTXNFZV2sdzFei/y6WKlsJT
 sFydq7oYLfKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169803100"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="169803100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 13:38:58 -0700
IronPort-SDR: uyW+kIw57m+r6LEE7v60ai7gM/9UHIEczmFx55yZSVjxg+QYBwUSfNql9GJ82+pe4pDM6ANm67
 kq9Lo1gsGluw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="330864964"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 13:38:58 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 04/10] mesh: Clean up handling of config publication messages
Date:   Thu, 30 Jul 2020 13:38:45 -0700
Message-Id: <20200730203851.32043-5-inga.stotland@intel.com>
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
 mesh/cfgmod-server.c | 70 ++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 1cd0bcdd5..871ecf878 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -44,11 +44,9 @@ static const uint8_t supported_pages[] = {
 
 static uint8_t msg[MAX_MSG_LEN];
 
-static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
-			uint16_t src, uint16_t dst,
-			uint8_t status, uint16_t ele_addr, uint32_t id,
-			uint16_t pub_addr, uint16_t idx, bool cred_flag,
-			uint8_t ttl, uint8_t period, uint8_t retransmit)
+static uint16_t set_pub_status(uint8_t status, uint16_t ele_addr, uint32_t id,
+				uint16_t pub_addr, uint16_t idx, bool cred_flag,
+				uint8_t ttl, uint8_t period, uint8_t retransmit)
 {
 	size_t n;
 
@@ -72,41 +70,32 @@ static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 		n += 4;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-								false, msg, n);
+	return n;
 }
 
-static void config_pub_get(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, uint16_t size)
+static uint16_t config_pub_get(struct mesh_node *node, const uint8_t *pkt,
+								bool vendor)
 {
 	uint32_t id;
 	uint16_t ele_addr;
 	struct mesh_model_pub *pub;
 	int status;
 
-	if (size == 4) {
-		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 2));
-	} else if (size == 6) {
-		id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
-	} else
-		return;
-
 	ele_addr = l_get_le16(pkt);
+	id = CFG_SET_ID(vendor, pkt + 2);
+
 	pub = mesh_model_pub_get(node, ele_addr, id, &status);
 
 	if (pub && status == MESH_STATUS_SUCCESS)
-		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-				id, pub->addr, pub->idx, pub->credential,
-				pub->ttl, pub->period, pub->retransmit);
+		return set_pub_status(status, ele_addr, id, pub->addr, pub->idx,
+					pub->credential, pub->ttl, pub->period,
+					pub->retransmit);
 	else
-		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-				id, 0, 0, 0, 0, 0, 0);
+		return set_pub_status(status, ele_addr, id, 0, 0, 0, 0, 0, 0);
 }
 
-static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
-				uint16_t src, uint16_t dst,
-				const uint8_t *pkt, bool virt, bool vendor)
+static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
+							bool virt, bool vendor)
 {
 	uint32_t id;
 	uint16_t ele_addr, idx, ota = UNASSIGNED_ADDRESS;
@@ -125,17 +114,12 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 	ttl = pkt[6];
 	period = pkt[7];
 	retransmit = pkt[8];
-	id = l_get_le16(pkt + 9);
-
-	if (!vendor)
-		id = SET_ID(SIG_VENDOR, id);
-	else
-		id = SET_ID(id, l_get_le16(pkt + 11));
+	id = CFG_SET_ID(vendor, pkt + 9);
 
 	/* Don't accept virtual seeming addresses */
 	test_addr = l_get_le16(pub_addr);
 	if (!virt && IS_VIRTUAL(test_addr))
-		return;
+		return 0;
 
 	cred_flag = !!(CREDFLAG_MASK & idx);
 	idx &= APP_IDX_MASK;
@@ -144,15 +128,11 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 					cred_flag, ttl, period, retransmit,
 					virt, &ota);
 
-	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
+	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, id: %x, idx: %3.3x",
 					status, ele_addr, ota, id, idx);
 
-	if (status != MESH_STATUS_SUCCESS) {
-		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-						id, 0, 0, 0, 0, 0, 0);
-
-		return;
-	}
+	if (status != MESH_STATUS_SUCCESS)
+		return set_pub_status(status, ele_addr, id, 0, 0, 0, 0, 0, 0);
 
 	if (IS_UNASSIGNED(test_addr) && !virt) {
 		ttl = period = idx = 0;
@@ -180,12 +160,12 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 		/* Save model publication to config file */
 		if (!mesh_config_model_pub_add(node_config_get(node), ele_addr,
 						vendor ? id : MODEL_ID(id),
-							vendor, &db_pub))
+						vendor, &db_pub))
 			status = MESH_STATUS_STORAGE_FAIL;
 	}
 
-	send_pub_status(node, net_idx, src, dst, status, ele_addr, id, ota,
-				idx, cred_flag, ttl, period, retransmit);
+	return set_pub_status(status, ele_addr, id, ota, idx, cred_flag, ttl,
+							period, retransmit);
 }
 
 static uint16_t cfg_sub_get_msg(struct mesh_node *node, uint16_t net_idx,
@@ -664,14 +644,14 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (!virt && (size != 11 && size != 13))
 			return true;
 
-		config_pub_set(node, net_idx, src, dst, pkt, virt,
-						size == 13 || size == 27);
+		n = config_pub_set(node, pkt, virt, size == 13 || size == 27);
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
 		if (size != 4 && size != 6)
 			return true;
-		config_pub_get(node, net_idx, src, dst, pkt, size);
+
+		n = config_pub_get(node, pkt, size == 6);
 		break;
 
 	case OP_CONFIG_VEND_MODEL_SUB_GET:
-- 
2.26.2

