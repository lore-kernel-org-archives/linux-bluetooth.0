Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44465C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 01:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231AC2072E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 01:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgAJBlr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:41:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:58409 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbgAJBlr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 20:41:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 17:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="236689162"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.252])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 17:41:47 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Fix logic in AppKey deletion
Date:   Thu,  9 Jan 2020 17:41:44 -0800
Message-Id: <20200110014145.1785-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200110014145.1785-1-inga.stotland@intel.com>
References: <20200110014145.1785-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When deleting an AppKey from a node, call mesh_config_app_key_del()
only from appkey level (i.e., keep it contained in appkey.c and
remove the duplicate call in node.c)

Also, simplify the node_app_key_delete() argument list.
---
 mesh/appkey.c |  6 +++---
 mesh/node.c   | 29 ++---------------------------
 mesh/node.h   |  4 ++--
 3 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index e96d5228a..3a1fd8a54 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -419,13 +419,13 @@ int appkey_key_delete(struct mesh_net *net, uint16_t net_idx,
 	if (key->net_idx != net_idx)
 		return MESH_STATUS_INVALID_NETKEY;
 
-	node_app_key_delete(net, mesh_net_get_address(net), net_idx, app_idx);
+	node = mesh_net_node_get(net);
+
+	node_app_key_delete(node, net_idx, app_idx);
 
 	l_queue_remove(app_keys, key);
 	appkey_key_free(key);
 
-	node = mesh_net_node_get(net);
-
 	if (!mesh_config_app_key_del(node_config_get(node), net_idx, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
diff --git a/mesh/node.c b/mesh/node.c
index 3154d6bf4..78219d9d7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -135,15 +135,6 @@ struct managed_obj_request {
 
 static struct l_queue *nodes;
 
-static bool match_node_unicast(const void *a, const void *b)
-{
-	const struct mesh_node *node = a;
-	uint16_t dst = L_PTR_TO_UINT(b);
-
-	return (dst >= node->primary &&
-		dst <= (node->primary + node->num_ele - 1));
-}
-
 static bool match_device_uuid(const void *a, const void *b)
 {
 	const struct mesh_node *node = a;
@@ -216,15 +207,6 @@ static int compare_model_id(const void *a, const void *b, void *user_data)
 	return 0;
 }
 
-
-struct mesh_node *node_find_by_addr(uint16_t addr)
-{
-	if (!IS_UNICAST(addr))
-		return NULL;
-
-	return l_queue_find(nodes, match_node_unicast, L_UINT_TO_PTR(addr));
-}
-
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16])
 {
 	return l_queue_find(nodes, match_device_uuid, uuid);
@@ -627,24 +609,17 @@ bool node_is_provisioned(struct mesh_node *node)
 	return (!IS_UNASSIGNED(node->primary));
 }
 
-bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
-				uint16_t net_idx, uint16_t app_idx)
+void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
+							uint16_t app_idx)
 {
-	struct mesh_node *node;
 	const struct l_queue_entry *entry;
 
-	node = node_find_by_addr(addr);
-	if (!node)
-		return false;
-
 	entry = l_queue_get_entries(node->elements);
 	for (; entry; entry = entry->next) {
 		struct node_element *ele = entry->data;
 
 		mesh_model_app_key_delete(node, ele->models, app_idx);
 	}
-
-	return mesh_config_app_key_del(node->cfg, net_idx, app_idx);
 }
 
 uint16_t node_get_primary(struct mesh_node *node)
diff --git a/mesh/node.h b/mesh/node.h
index c718c038d..a6bc4a2a6 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -40,8 +40,8 @@ struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
 struct mesh_node *node_find_by_token(uint64_t token);
 bool node_is_provisioner(struct mesh_node *node);
 bool node_is_provisioned(struct mesh_node *node);
-bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
-				uint16_t net_idx, uint16_t idx);
+void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
+							uint16_t app_idx);
 uint16_t node_get_primary(struct mesh_node *node);
 uint16_t node_get_primary_net_idx(struct mesh_node *node);
 void node_set_token(struct mesh_node *node, uint8_t token[8]);
-- 
2.21.1

