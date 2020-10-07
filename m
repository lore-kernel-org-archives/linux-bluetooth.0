Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0175C41604
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626A820739
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 16:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgJGQsI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:48:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:62598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgJGQsH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 12:48:07 -0400
IronPort-SDR: ohZHayB+EobbxgRKes5gL9BGcwKWVthrCvZSD38mcS/3vTS8KSc8gkauSVol6bpbpFamMa/RXu
 AiM87jhQZqQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="165082061"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="165082061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:33:16 -0700
IronPort-SDR: MXA/cZKrIpZYjp84Sp1MW5TJyDjf/o1a1nJZzaz8pOpKM7RXEBcXjnyLMH9kL+zL24td7KwPxL
 4ALfrF3EQFLw==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="518905564"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.194.177])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:33:15 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2] mesh: Re-arrange Join/Create/Import/Attach page saving
Date:   Wed,  7 Oct 2020 09:33:05 -0700
Message-Id: <20201007163305.584272-1-brian.gix@intel.com>
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
 mesh/node.c | 149 +++++++++++++++++++++++++++-------------------------
 mesh/node.h |   2 -
 2 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 76d8fd6e9..2da709c3f 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -857,7 +857,76 @@ static bool match_page(const void *a, const void *b)
 	return page->page_num == page_num;
 }
 
-bool node_set_comp(struct mesh_node *node, uint8_t page_num,
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
+static bool node_set_comp(struct mesh_node *node, uint8_t page_num,
 					const uint8_t *data, uint16_t len)
 {
 	struct mesh_config_comp_page *page;
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
+		if (!node->cfg)
 			goto fail;
 
 		req->join_ready_cb(node, node->agent);
@@ -1524,7 +1527,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		return;
 
 	case REQUEST_TYPE_IMPORT:
-		if (!create_node_config(node, node->uuid))
+		if (!node->cfg)
 			goto fail;
 
 		import = req->import;
@@ -1540,7 +1543,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		return;
 
 	case REQUEST_TYPE_CREATE:
-		if (!create_node_config(node, node->uuid))
+		if (!node->cfg)
 			goto fail;
 
 		/* Generate device and primary network keys */
diff --git a/mesh/node.h b/mesh/node.h
index 30d53db33..2e3d89812 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -52,8 +52,6 @@ bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
 					struct mesh_config_node *db_node);
 const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
 								uint16_t *len);
-bool node_set_comp(struct mesh_node *node, uint8_t page_num,
-					const uint8_t *data, uint16_t len);
 bool node_replace_comp(struct mesh_node *node, uint8_t retire, uint8_t with);
 uint8_t node_lpn_mode_get(struct mesh_node *node);
 bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
-- 
2.25.4

