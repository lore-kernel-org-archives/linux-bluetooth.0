Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97202C3279D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 20:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C09B20760
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 20:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgJFUfi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:35:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:60675 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgJFUfi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 16:35:38 -0400
IronPort-SDR: eY2e5ycKXdXsA9y1YPpJOWYIA9OhrC+V+LLkdR/BJTs3XTFDOx0NwRLVJsw57G18/NT2PFvkAC
 WQII6wbp1j/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="182135916"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="182135916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:35:38 -0700
IronPort-SDR: 5xTRd9JXGVgJWk0UODU44uxy1mo+WQwKnkwFD/FnNaPwFIo0eCFYUoPZ5M3pY7uNeJyTgrcmtY
 0Vzo5D2aRtvQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="388045818"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.243.2])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:35:37 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Re-arrange Join/Create/Import/Attach page saving
Date:   Tue,  6 Oct 2020 13:35:29 -0700
Message-Id: <20201006203529.424897-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an App is creating or attaching to a node, it first evaluates the
validity of the Apps composition. Invalid compositions are not allowed
to continue.  Valid compositions need to be saved, which means that
create_node_config() must be called as part of Composition validation.
---
 mesh/node.c | 147 +++++++++++++++++++++++++++-------------------------
 1 file changed, 75 insertions(+), 72 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 76d8fd6e9..4170fad58 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -857,6 +857,75 @@ static bool match_page(const void *a, const void *b)
 	return page->page_num == page_num;
 }
 
+static void convert_node_to_storage(struct mesh_node *node,
+					struct mesh_config_node *db_node)
+{
+	const struct l_queue_entry *entry;
+
+	db_node->cid = node->comp.cid;
+	db_node->pid = node->comp.pid;
+	db_node->vid = node->comp.vid;
+	db_node->crpl = node->comp.crpl;
+	db_node->modes.lpn = node->lpn;
+	db_node->modes.proxy = node->proxy;
+
+	db_node->modes.friend = node->friend;
+	db_node->modes.relay.state = node->relay.mode;
+	db_node->modes.relay.cnt = node->relay.cnt;
+	db_node->modes.relay.interval = node->relay.interval;
+	db_node->modes.beacon = node->beacon;
+
+	db_node->ttl = node->ttl;
+	db_node->seq_number = node->seq_number;
+
+	db_node->elements = l_queue_new();
+
+	entry = l_queue_get_entries(node->elements);
+
+	for (; entry; entry = entry->next) {
+		struct node_element *ele = entry->data;
+		struct mesh_config_element *db_ele;
+
+		db_ele = l_new(struct mesh_config_element, 1);
+
+		db_ele->index = ele->idx;
+		db_ele->location = ele->location;
+		db_ele->models = l_queue_new();
+
+		mesh_model_convert_to_storage(db_ele->models, ele->models);
+
+		l_queue_push_tail(db_node->elements, db_ele);
+	}
+
+}
+
+static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
+{
+	struct mesh_config_node db_node;
+	const struct l_queue_entry *entry;
+	const char *storage_dir;
+
+	convert_node_to_storage(node, &db_node);
+	storage_dir = mesh_get_storage_dir();
+	node->cfg = mesh_config_create(storage_dir, uuid, &db_node);
+
+	if (node->cfg)
+		init_storage_dir(node);
+
+	/* Free temporarily allocated resources */
+	entry = l_queue_get_entries(db_node.elements);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_config_element *db_ele = entry->data;
+
+		l_queue_destroy(db_ele->models, l_free);
+	}
+
+	l_queue_destroy(db_node.elements, l_free);
+
+	return node->cfg != NULL;
+}
+
 bool node_set_comp(struct mesh_node *node, uint8_t page_num,
 					const uint8_t *data, uint16_t len)
 {
@@ -865,6 +934,9 @@ bool node_set_comp(struct mesh_node *node, uint8_t page_num,
 	if (!node || len < MIN_COMP_SIZE)
 		return false;
 
+	if (!node->cfg && !create_node_config(node, node->uuid))
+		return false;
+
 	page = l_queue_remove_if(node->pages, match_page,
 						L_UINT_TO_PTR(page_num));
 
@@ -1107,75 +1179,6 @@ fail:
 	return false;
 }
 
-static void convert_node_to_storage(struct mesh_node *node,
-					struct mesh_config_node *db_node)
-{
-	const struct l_queue_entry *entry;
-
-	db_node->cid = node->comp.cid;
-	db_node->pid = node->comp.pid;
-	db_node->vid = node->comp.vid;
-	db_node->crpl = node->comp.crpl;
-	db_node->modes.lpn = node->lpn;
-	db_node->modes.proxy = node->proxy;
-
-	db_node->modes.friend = node->friend;
-	db_node->modes.relay.state = node->relay.mode;
-	db_node->modes.relay.cnt = node->relay.cnt;
-	db_node->modes.relay.interval = node->relay.interval;
-	db_node->modes.beacon = node->beacon;
-
-	db_node->ttl = node->ttl;
-	db_node->seq_number = node->seq_number;
-
-	db_node->elements = l_queue_new();
-
-	entry = l_queue_get_entries(node->elements);
-
-	for (; entry; entry = entry->next) {
-		struct node_element *ele = entry->data;
-		struct mesh_config_element *db_ele;
-
-		db_ele = l_new(struct mesh_config_element, 1);
-
-		db_ele->index = ele->idx;
-		db_ele->location = ele->location;
-		db_ele->models = l_queue_new();
-
-		mesh_model_convert_to_storage(db_ele->models, ele->models);
-
-		l_queue_push_tail(db_node->elements, db_ele);
-	}
-
-}
-
-static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
-{
-	struct mesh_config_node db_node;
-	const struct l_queue_entry *entry;
-	const char *storage_dir;
-
-	convert_node_to_storage(node, &db_node);
-	storage_dir = mesh_get_storage_dir();
-	node->cfg = mesh_config_create(storage_dir, uuid, &db_node);
-
-	if (node->cfg)
-		init_storage_dir(node);
-
-	/* Free temporarily allocated resources */
-	entry = l_queue_get_entries(db_node.elements);
-
-	for (; entry; entry = entry->next) {
-		struct mesh_config_element *db_ele = entry->data;
-
-		l_queue_destroy(db_ele->models, l_free);
-	}
-
-	l_queue_destroy(db_node.elements, l_free);
-
-	return node->cfg != NULL;
-}
-
 static bool get_app_properties(struct mesh_node *node, const char *path,
 					struct l_dbus_message_iter *properties)
 {
@@ -1516,7 +1519,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 			goto fail;
 		}
 
-		if (!create_node_config(node, node->uuid))
+		if (!node->cfg && !create_node_config(node, node->uuid))
 			goto fail;
 
 		req->join_ready_cb(node, node->agent);
@@ -1524,7 +1527,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		return;
 
 	case REQUEST_TYPE_IMPORT:
-		if (!create_node_config(node, node->uuid))
+		if (!node->cfg && !create_node_config(node, node->uuid))
 			goto fail;
 
 		import = req->import;
@@ -1540,7 +1543,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		return;
 
 	case REQUEST_TYPE_CREATE:
-		if (!create_node_config(node, node->uuid))
+		if (!node->cfg && !create_node_config(node, node->uuid))
 			goto fail;
 
 		/* Generate device and primary network keys */
-- 
2.25.4

