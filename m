Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C5BC2D0C1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 20:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95882206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 20:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFU5w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:57:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:41333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfLFU5v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Dec 2019 15:57:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 12:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="219502254"
Received: from ingas-nuc1.sea.intel.com ([10.255.83.133])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 12:57:50 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/3] mesh: Delete unused function
Date:   Fri,  6 Dec 2019 12:57:47 -0800
Message-Id: <20191206205749.12918-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206205749.12918-1-inga.stotland@intel.com>
References: <20191206205749.12918-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes node_parse_composition() implementation as it is not used
anywhere in the rest of the code base.
---
 mesh/node.c | 131 ----------------------------------------------------
 mesh/node.h |   1 -
 2 files changed, 132 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 7b4ee0505..b8c30c30a 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -994,137 +994,6 @@ element_done:
 	return n;
 }
 
-
-#define MIN_COMPOSITION_LEN 16
-
-bool node_parse_composition(struct mesh_node *node, uint8_t *data,
-								uint16_t len)
-{
-	struct node_composition *comp;
-	uint16_t features;
-	uint8_t num_ele;
-	bool mode;
-
-	if (!len)
-		return false;
-
-	/* Skip page -- We only support Page Zero */
-	data++;
-	len--;
-
-	if (len < MIN_COMPOSITION_LEN)
-		return false;
-
-	comp = l_new(struct node_composition, 1);
-	if (!comp)
-		return false;
-
-	node->elements = l_queue_new();
-	if (!node->elements) {
-		l_free(comp);
-		return false;
-	}
-
-	node->comp = l_new(struct node_composition, 1);
-	comp->cid = l_get_le16(&data[0]);
-	comp->pid = l_get_le16(&data[2]);
-	comp->vid = l_get_le16(&data[4]);
-	comp->crpl = l_get_le16(&data[6]);
-	features = l_get_le16(&data[8]);
-	data += 10;
-	len -= 10;
-
-	mode = !!(features & FEATURE_PROXY);
-	node->proxy = mode ? MESH_MODE_DISABLED : MESH_MODE_UNSUPPORTED;
-
-	mode = !!(features & FEATURE_LPN);
-	node->lpn = mode ? MESH_MODE_DISABLED : MESH_MODE_UNSUPPORTED;
-
-	mode = !!(features & FEATURE_FRIEND);
-	node->friend = mode ? MESH_MODE_DISABLED : MESH_MODE_UNSUPPORTED;
-
-	mode = !!(features & FEATURE_RELAY);
-	node->relay.mode = mode ? MESH_MODE_DISABLED : MESH_MODE_UNSUPPORTED;
-
-	num_ele = 0;
-
-	do {
-		uint8_t m, v;
-		uint16_t mod_id;
-		uint16_t vendor_id;
-		struct node_element *ele;
-		struct mesh_model *mod;
-
-		ele = l_new(struct node_element, 1);
-		if (!ele)
-			return false;
-
-		ele->idx = num_ele;
-		ele->location = l_get_le16(data);
-		len -= 2;
-		data += 2;
-
-		m = *data++;
-		v = *data++;
-		len -= 2;
-
-		/* Parse SIG models */
-		while (len >= 2 && m--) {
-			mod_id = l_get_le16(data);
-			mod = mesh_model_new(ele->idx, mod_id);
-			if (!mod || !element_add_model(ele, mod)) {
-				mesh_model_free(mod);
-				element_free(ele);
-				goto fail;
-			}
-
-			data += 2;
-			len -= 2;
-		}
-
-		if (v && len < 4) {
-			element_free(ele);
-			goto fail;
-		}
-
-		/* Parse vendor models */
-		while (len >= 4 && v--) {
-			mod_id = l_get_le16(data + 2);
-			vendor_id = l_get_le16(data);
-			mod_id |= (vendor_id << 16);
-			mod = mesh_model_vendor_new(ele->idx, vendor_id,
-									mod_id);
-			if (!mod || !element_add_model(ele, mod)) {
-				mesh_model_free(mod);
-				element_free(ele);
-				goto fail;
-			}
-
-			data += 4;
-			len -= 4;
-		}
-
-		num_ele++;
-		l_queue_push_tail(node->elements, ele);
-
-	} while (len >= 6);
-
-	/* Check the consistency for the remote node */
-	if (node->num_ele > num_ele)
-		goto fail;
-
-	node->comp = comp;
-	node->num_ele = num_ele;
-
-	return true;
-
-fail:
-	l_queue_destroy(node->elements, element_free);
-	l_free(comp);
-
-	return false;
-}
-
 static void attach_io(void *a, void *b)
 {
 	struct mesh_node *node = a;
diff --git a/mesh/node.h b/mesh/node.h
index be57d5e67..7448756ae 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -50,7 +50,6 @@ void node_set_device_key(struct mesh_node *node, uint8_t key[16]);
 const uint8_t *node_get_device_key(struct mesh_node *node);
 void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
 uint8_t node_get_num_elements(struct mesh_node *node);
-bool node_parse_composition(struct mesh_node *node, uint8_t *buf, uint16_t len);
 bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
 			uint32_t model_id, uint16_t app_idx);
 bool node_del_binding(struct mesh_node *node, uint8_t ele_idx,
-- 
2.21.0

