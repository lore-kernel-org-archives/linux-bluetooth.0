Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E105C4363C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 21:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD3B20872
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 21:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJGVKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:10:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:45677 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgJGVKW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 17:10:22 -0400
IronPort-SDR: 7tT+sLllgZPqIOQYtiy4dZ2jHJCVwCsS57ECgM69yis/Vsq0Ff+CIFnGxEaMfaCtCmqihLO3sK
 KqlB8poApndg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="161704684"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="161704684"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 14:10:22 -0700
IronPort-SDR: Idv/cdBdu6ZMZ9qX4xq9NPMv1LQuuqQfNde04hV0TDe1JIVZIhwhBup0SrCf7nP3KXe7gB1rzs
 QnJH+JWswj9A==
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="461514922"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.119.103])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 14:10:21 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3] mesh: Re-arrange Join/Create/Import/Attach page saving
Date:   Wed,  7 Oct 2020 14:09:59 -0700
Message-Id: <20201007210959.37565-1-brian.gix@intel.com>
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
 mesh/node.c | 202 +++++++++++++++++++++++++++-------------------------
 mesh/node.h |   2 -
 2 files changed, 104 insertions(+), 100 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 76d8fd6e9..11b0c9442 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -788,15 +788,12 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 	return node->friend;
 }
 
-static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
+static uint16_t generate_node_comp(struct mesh_node *node, uint8_t *buf,
 								uint16_t sz)
 {
 	uint16_t n, features, num_ele = 0;
 	const struct l_queue_entry *entry;
 
-	if (!node || sz < MIN_COMP_SIZE)
-		return 0;
-
 	n = 0;
 
 	l_put_le16(node->comp.cid, buf + n);
@@ -857,12 +854,81 @@ static bool match_page(const void *a, const void *b)
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
+static bool set_node_comp(struct mesh_node *node, uint8_t page_num,
 					const uint8_t *data, uint16_t len)
 {
 	struct mesh_config_comp_page *page;
 
-	if (!node || len < MIN_COMP_SIZE)
+	if (len < MIN_COMP_SIZE)
 		return false;
 
 	page = l_queue_remove_if(node->pages, match_page,
@@ -876,9 +942,17 @@ bool node_set_comp(struct mesh_node *node, uint8_t page_num,
 	memcpy(page->data, data, len);
 	l_queue_push_tail(node->pages, page);
 
-	mesh_config_comp_page_add(node->cfg, page_num, page->data, len);
+	return mesh_config_comp_page_add(node->cfg, page_num, page->data, len);
+}
+
+static bool create_node_comp(struct mesh_node *node)
+{
+	uint16_t len;
+	uint8_t comp[MAX_MSG_LEN - 2];
 
-	return true;
+	len = generate_node_comp(node, comp, sizeof(comp));
+
+	return set_node_comp(node, 0, comp, len);
 }
 
 const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
@@ -1107,75 +1181,6 @@ fail:
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
@@ -1322,31 +1327,32 @@ static void update_model_options(struct mesh_node *node,
 
 static bool check_req_node(struct managed_obj_request *req)
 {
-	struct mesh_node *node;
 	const int offset = 8;
 	uint16_t node_len, len;
 	uint8_t comp[MAX_MSG_LEN - 2];
 	const uint8_t *node_comp;
 
-	if (req->type == REQUEST_TYPE_ATTACH)
-		node = req->attach;
-	else
-		node = req->node;
+	len = generate_node_comp(req->node, comp, sizeof(comp));
 
-	node_comp = node_get_comp(node, 0, &node_len);
-	len = node_generate_comp(req->node, comp, sizeof(comp));
+	if (len < MIN_COMP_SIZE)
+		return false;
+
+	node_comp = node_get_comp(req->attach, 0, &node_len);
 
-	/* If no page 0 exists, save it and return */
-	if (req->type != REQUEST_TYPE_ATTACH || !node_len || !node_comp)
-		return node_set_comp(node, 0, comp, len);
+	/* If no page 0 exists, create it and accept */
+	if (!node_len || !node_comp)
+		return set_node_comp(req->attach, 0, comp, len);
 
+	/* Test Element/Model part of composition and reject if changed */
 	if (node_len != len || memcmp(&node_comp[offset], &comp[offset],
 							node_len - offset))
 		return false;
 
+	/* If comp has changed, but not Element/Models, resave and accept */
 	else if (memcmp(node_comp, comp, node_len))
-		return node_set_comp(node, 0, comp, len);
+		return set_node_comp(req->attach, 0, comp, len);
 
+	/* Nothing has changed */
 	return true;
 }
 
@@ -1494,7 +1500,16 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 	node->num_ele = num_ele;
 
-	if (!check_req_node(req))
+	if (req->type != REQUEST_TYPE_ATTACH) {
+		/* Generate node configuration for a brand new node */
+		if (!create_node_config(node, node->uuid))
+			goto fail;
+
+		/* Create node composition */
+		if (!create_node_comp(node))
+			goto fail;
+	} else if (!check_req_node(req))
+		/* Check the integrity of the node composition */
 		goto fail;
 
 	switch (req->type) {
@@ -1516,17 +1531,11 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 			goto fail;
 		}
 
-		if (!create_node_config(node, node->uuid))
-			goto fail;
-
 		req->join_ready_cb(node, node->agent);
 
 		return;
 
 	case REQUEST_TYPE_IMPORT:
-		if (!create_node_config(node, node->uuid))
-			goto fail;
-
 		import = req->import;
 		if (!add_local_node(node, import->unicast, import->flags.kr,
 					import->flags.ivu,
@@ -1540,9 +1549,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		return;
 
 	case REQUEST_TYPE_CREATE:
-		if (!create_node_config(node, node->uuid))
-			goto fail;
-
 		/* Generate device and primary network keys */
 		l_getrandom(dev_key, sizeof(dev_key));
 		l_getrandom(net_key.old_key, sizeof(net_key.old_key));
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

