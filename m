Return-Path: <SRS0=ILT4=BQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB14221E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 22:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHFWz0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:55:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:48214 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHFWzZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 18:55:25 -0400
IronPort-SDR: Tx7noXLfpz4FAqMezlgkrm1hQ1eE9rDDCh2wVLawFBRlG3Q0yjir9c4L7SOUGK82xzATimT7iP
 yejRH2uhEYNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140823975"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140823975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 15:55:24 -0700
IronPort-SDR: vRn9TaQZhoqfWV6yBzo5VwZT94eYaA13PcaqTTDmFELlEvQg7xQ7V3JZP0HJVvC1djQ8GzUUXM
 2jvIn+pH2VlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="493364627"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.119.50])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2020 15:55:24 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Use correct TTL value to send model publication
Date:   Thu,  6 Aug 2020 15:55:23 -0700
Message-Id: <20200806225523.109092-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When sending model publishing data, use TTL value configured for
that publication instead of the default TTL value used for regular
messages.
---
 mesh/model.c |  4 ++--
 mesh/model.h |  2 +-
 mesh/node.c  | 11 ++++-------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index ef7668147..043ad1d70 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1022,7 +1022,7 @@ done:
 }
 
 int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
-				uint8_t ttl, const void *msg, uint16_t msg_len)
+					const void *msg, uint16_t msg_len)
 {
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
@@ -1063,7 +1063,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
 
 	result = msg_send(node, mod->pub->credential != 0, src,
 				mod->pub->addr, mod->pub->idx, net_idx,
-				label, ttl, false, msg, msg_len);
+				label, mod->pub->ttl, false, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 }
diff --git a/mesh/model.h b/mesh/model.h
index 0d8dddf92..e4906e330 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -103,7 +103,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len);
 int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
-				uint8_t ttl, const void *msg, uint16_t msg_len);
+					const void *msg, uint16_t msg_len);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint16_t net_idx,
 			uint16_t src, uint16_t dst, uint8_t key_aid,
diff --git a/mesh/node.c b/mesh/node.c
index 3dca73cef..4b70587ae 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1983,7 +1983,7 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter_data;
 	uint16_t mod_id, src;
 	struct node_element *ele;
-	uint8_t *data, ttl;
+	uint8_t *data;
 	uint32_t len, id;
 	int result;
 
@@ -2010,10 +2010,8 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	ttl = mesh_net_get_default_ttl(node->net);
-
 	id = SET_ID(SIG_VENDOR, mod_id);
-	result = mesh_model_publish(node, id, src, ttl, data, len);
+	result = mesh_model_publish(node, id, src, data, len);
 
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
@@ -2030,7 +2028,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter_data;
 	uint16_t src, mod_id, vendor_id;
 	struct node_element *ele;
-	uint8_t ttl, *data = NULL;
+	uint8_t *data = NULL;
 	uint32_t len;
 	int result;
 
@@ -2057,8 +2055,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	ttl = mesh_net_get_default_ttl(node->net);
-	result = mesh_model_publish(node, SET_ID(vendor_id, mod_id), src, ttl,
+	result = mesh_model_publish(node, SET_ID(vendor_id, mod_id), src,
 								data, len);
 
 	if (result != MESH_ERROR_NONE)
-- 
2.26.2

