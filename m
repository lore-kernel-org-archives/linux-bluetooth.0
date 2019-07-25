Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1AEC41514
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3922BED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="h+8KwXxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbfGYIOh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:14:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37448 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfGYIOg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so47202662ljn.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=39ZHnXKhJrr/CGGekiegfIl3M4oZQ+aJyFVnU9d29oM=;
        b=h+8KwXxbsvrJdcLfimWEWSi7cTEzdniXvmoTTkBYPDAGALESqu9ZSNDHpCfYybAu/J
         9zYqprlMWXUl/wIybMHKHX9eGUx21gTHennopJHZrLQ+hdrVOtncLt4HQRXQmBXqZ487
         iIB5fD9bclIY01fAMhYmtYBON4IDh45UyFfoSzUH8DFjdcx416GJXSZN57Zw19YEoRsD
         L7Cy07e+6KWNMKI6NzIqYntRz4eIt0vjiOQvKGUcRcdu6T6vQipfHL5w+zQhz3Fj8mqZ
         HoiZ0vRz1kNtYmgNPlXfF1ZvGW0uZWaa7vLquUC1iv4kHZUxtB/1IIQXJ4zAUws/7qKi
         BRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39ZHnXKhJrr/CGGekiegfIl3M4oZQ+aJyFVnU9d29oM=;
        b=XC7qq2Nc51M8Vljq2yMvhgbe0B9SCJK2/0sJ+dnzgs8CPoICL/uLR+6KHgIRxkfsJX
         FxYEXu8p870L+Xa/06dpif/ZAccTfF3LyEALAcoUW95wdKsHTse/rpDSHsUzs4iDpV2E
         ZDahOSPCL9cU9aVk/mPaZ+p+pm1EA4to/JeBn2t+FBWlJf3ga0NIBgpo8nb/iLKT3YbS
         N4FN+OQzMMCUAhQcrxtc1rpdL0GEPsoGVRcauUMbGYFlE3jA+YCIw/uzk1e7lpVPZEDg
         rxx5Nx5apYAVw5iYWdrg3FiYWgGPmrJ+eD7TN+m413VDGwL5FqoNTijoahCwroE2QVRz
         CJ7Q==
X-Gm-Message-State: APjAAAULQrqjDUbK1/ENFCTRRkmpSrZ2bR8rAkGvm28ld4Kbp6vPV3og
        Jgf5wXHmsbCDnZBSbOa6P/MskGtQp34=
X-Google-Smtp-Source: APXvYqx9oWPFjb7QiwrxCpIemWl212Oolxt5ANE7mvCC6F1Zg97sjvzwstth4CImpxfMVbPQji/x3Q==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr43187796lji.206.1564042473212;
        Thu, 25 Jul 2019 01:14:33 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm9015251ljf.44.2019.07.25.01.14.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:14:32 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] mesh: Validate application by comparing composition data
Date:   Thu, 25 Jul 2019 10:14:21 +0200
Message-Id: <20190725081424.22621-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
References: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of validating application by enumerating D-Bus objects, create a
temporary node instance and check if composition data generated for the
temporary matches the node loaded from storage.

This allows node validation logic (primary element, mandatory models etc)
to be confined in node_generate_comp() function.

This also streamlines code implementing Attach(), Join(),
CreateNetwork() and ImportLocalNode() calls.
---
 mesh/mesh-defs.h |   2 +
 mesh/node.c      | 423 +++++++++++++++++++++--------------------------
 2 files changed, 189 insertions(+), 236 deletions(-)

diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 1a199f156..4988b9e0a 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -79,6 +79,8 @@
 #define MAX_MODEL_COUNT		0xff
 #define MAX_ELE_COUNT		0xff
 
+#define MAX_MSG_LEN 380
+
 #define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
 #define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
 					((x) < VIRTUAL_ADDRESS_LOW))
diff --git a/mesh/node.c b/mesh/node.c
index e51913edf..4e5586ab7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -112,16 +112,16 @@ struct mesh_node {
 };
 
 struct managed_obj_request {
-	union {
-		const uint8_t *uuid;
-		struct mesh_node *node;
-	};
+	struct mesh_node *node;
 	union {
 		node_ready_func_t ready_cb;
 		node_join_ready_func_t join_ready_cb;
 	};
 	struct l_dbus_message *pending_msg;
 	enum request_type type;
+	union {
+		struct mesh_node *attach;
+	};
 };
 
 static struct l_queue *nodes;
@@ -160,14 +160,6 @@ static bool match_element_idx(const void *a, const void *b)
 	return (element->idx == index);
 }
 
-static bool match_model_id(const void *a, const void *b)
-{
-	const struct mesh_model *mod = a;
-	uint32_t mod_id = L_PTR_TO_UINT(b);
-
-	return mod_id == mesh_model_get_model_id(mod);
-}
-
 static bool match_element_path(const void *a, const void *b)
 {
 	const struct node_element *element = a;
@@ -212,11 +204,6 @@ static struct mesh_node *node_new(const uint8_t uuid[16])
 	node->net = mesh_net_new(node);
 	memcpy(node->uuid, uuid, sizeof(node->uuid));
 
-	if (!nodes)
-		nodes = l_queue_new();
-
-	l_queue_push_tail(nodes, node);
-
 	return node;
 }
 
@@ -412,6 +399,11 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 
 	struct mesh_node *node = node_new(uuid);
 
+	if (!nodes)
+		nodes = l_queue_new();
+
+	l_queue_push_tail(nodes, node);
+
 	node->comp = l_new(struct node_composition, 1);
 	node->comp->cid = db_node->cid;
 	node->comp->pid = db_node->pid;
@@ -436,7 +428,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	memcpy(node->token, db_node->token, 8);
 
 	num_ele = l_queue_length(db_node->elements);
-	if (num_ele > 0xff)
+	if (num_ele > MAX_ELE_COUNT)
 		goto fail;
 
 	node->num_ele = num_ele;
@@ -1140,58 +1132,6 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	free_node_dbus_resources(node);
 }
 
-static bool validate_model_property(struct node_element *ele,
-					struct l_dbus_message_iter *property,
-					uint8_t *num_models, bool vendor)
-{
-	struct l_dbus_message_iter ids;
-	uint16_t mod_id, vendor_id;
-	uint8_t count;
-	const char *signature = !vendor ? "aq" : "a(qq)";
-
-	if (!l_dbus_message_iter_get_variant(property, signature, &ids)) {
-		/* Allow empty elements */
-		if (l_queue_length(ele->models) == 0) {
-			*num_models = 0;
-			return true;
-		} else
-			return false;
-	}
-
-	count = 0;
-	if (!vendor) {
-		/* Bluetooth SIG defined models */
-		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
-			struct mesh_model *mod;
-
-			/* Skip internally implemented models */
-			if ((VENDOR_ID_MASK | mod_id) == CONFIG_SRV_MODEL)
-				continue;
-
-			mod = l_queue_find(ele->models, match_model_id,
-					L_UINT_TO_PTR(VENDOR_ID_MASK | mod_id));
-			if (!mod)
-				return false;
-			count++;
-		}
-	} else {
-		/* Vendor defined models */
-		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
-								&mod_id)) {
-			struct mesh_model *mod;
-
-			mod = l_queue_find(ele->models, match_model_id,
-				L_UINT_TO_PTR((vendor_id << 16) | mod_id));
-			if (!mod)
-				return false;
-			count++;
-		}
-	}
-
-	*num_models = count;
-	return true;
-}
-
 static void get_models_from_properties(struct node_element *ele,
 					struct l_dbus_message_iter *property,
 								bool vendor)
@@ -1231,94 +1171,60 @@ static void get_models_from_properties(struct node_element *ele,
 }
 
 static bool get_element_properties(struct mesh_node *node, const char *path,
-					struct l_dbus_message_iter *properties,
-								bool is_new)
+					struct l_dbus_message_iter *properties)
 {
-	struct node_element *ele;
+	struct node_element *ele = l_new(struct node_element, 1);
 	const char *key;
 	struct l_dbus_message_iter var;
-	bool have_index = false;
-	uint8_t idx, mod_cnt, vendor_cnt;
+	bool idx = false;
+	bool mods = false;
+	bool vendor_mods = false;
 
 	l_debug("path %s", path);
 
+	ele->location = DEFAULT_LOCATION;
+
 	while (l_dbus_message_iter_next_entry(properties, &key, &var)) {
-		if (!strcmp(key, "Index")) {
-			if (!l_dbus_message_iter_get_variant(&var, "y", &idx))
-				return false;
-			have_index = true;
-			break;
+		if (!idx && !strcmp(key, "Index")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y",
+								&ele->idx))
+				goto fail;
+			idx = true;
+			continue;
 		}
-	}
-
-	if (!have_index) {
-		l_debug("Mandatory property \"Index\" not found");
-		return false;
-	}
 
-	if (!is_new) {
-		/* Validate composition: check the element index */
-		ele = l_queue_find(node->elements, match_element_idx,
-							L_UINT_TO_PTR(idx));
-		if (!ele) {
-			l_debug("Element with index %u not found", idx);
-			return false;
+		if (!mods && !strcmp(key, "Models")) {
+			get_models_from_properties(ele, &var, false);
+			mods = true;
+			continue;
 		}
-	} else {
-		ele = l_new(struct node_element, 1);
-		ele->location = DEFAULT_LOCATION;
-		ele->idx = idx;
-	}
 
-	mod_cnt = 0;
-	vendor_cnt = 0;
+		if (!vendor_mods && !strcmp(key, "VendorModels")) {
+			get_models_from_properties(ele, &var, true);
+			vendor_mods = true;
+			continue;
+		}
 
-	while (l_dbus_message_iter_next_entry(properties, &key, &var)) {
 		if (!strcmp(key, "Location")) {
-			uint16_t loc;
-
-			l_dbus_message_iter_get_variant(&var, "q", &loc);
-
-			/* Validate composition: location match */
-			if (!is_new && (ele->location != loc))
-				return false;
-
-			ele->location = loc;
-
-		} else if (!strcmp(key, "Models")) {
-
-			if (is_new)
-				get_models_from_properties(ele, &var, false);
-			else if (!validate_model_property(ele, &var, &mod_cnt,
-									false))
-				return false;
-
-		} else if (!strcmp(key, "VendorModels")) {
-
-			if (is_new)
-				get_models_from_properties(ele, &var, true);
-			else if (!validate_model_property(ele, &var,
-							&vendor_cnt, true))
-				return false;
-
+			if (!l_dbus_message_iter_get_variant(&var, "q",
+							&ele->location))
+				goto fail;
+			continue;
 		}
 	}
 
-	if (is_new) {
-		l_queue_push_tail(node->elements, ele);
-	} else {
-		/* Account for internal Configuration Server model */
-		if (idx == 0)
-			mod_cnt += 1;
+	if (!idx || !mods || !vendor_mods)
+		goto fail;
 
-		/* Validate composition: number of models must match */
-		if (l_queue_length(ele->models) != (mod_cnt + vendor_cnt))
-			return false;
+	l_queue_push_tail(node->elements, ele);
 
-		ele->path = l_strdup(path);
-	}
+	ele->path = l_strdup(path);
 
 	return true;
+fail:
+	l_free(ele);
+
+	return false;
 }
 
 static void convert_node_to_storage(struct mesh_node *node,
@@ -1415,65 +1321,61 @@ static void set_defaults(struct mesh_node *node)
 }
 
 static bool get_app_properties(struct mesh_node *node, const char *path,
-					struct l_dbus_message_iter *properties,
-								bool is_new)
+					struct l_dbus_message_iter *properties)
 {
 	const char *key;
 	struct l_dbus_message_iter variant;
-	uint16_t value;
+	bool cid = false;
+	bool pid = false;
+	bool vid = false;
 
 	l_debug("path %s", path);
 
-	if (is_new) {
-		node->comp = l_new(struct node_composition, 1);
-		node->comp->crpl = DEFAULT_CRPL;
-	}
+	node->comp = l_new(struct node_composition, 1);
+	node->comp->crpl = DEFAULT_CRPL;
 
 	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
-
-		if (!strcmp(key, "CompanyID")) {
+		if (!cid && !strcmp(key, "CompanyID")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-									&value))
-				return false;
-
-			if (!is_new && node->comp->cid != value)
-				return false;
-
-			node->comp->cid = value;
+							&node->comp->cid))
+				goto fail;
+			cid = true;
+			continue;
+		}
 
-		} else if (!strcmp(key, "ProductID")) {
+		if (!pid && !strcmp(key, "ProductID")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-									&value))
-				return false;
-
-			if (!is_new && node->comp->pid != value)
-				return false;
-
-			node->comp->pid = value;
+							&node->comp->pid))
+				goto fail;
+			pid = true;
+			continue;
+		}
 
-		} else if (!strcmp(key, "VersionID")) {
+		if (!vid && !strcmp(key, "VersionID")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-									&value))
-				return false;
-
-			if (!is_new && node->comp->vid != value)
+							&node->comp->vid))
 				return false;
+			vid = true;
+			continue;
+		}
 
-			node->comp->vid = value;
-
-		} else if (!strcmp(key, "CRPL")) {
+		if (!strcmp(key, "CRPL")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-									&value))
-				return false;
-
-			if (!is_new && node->comp->crpl != value)
-				return false;
-
-			node->comp->crpl = value;
+							&node->comp->crpl))
+				goto fail;
+			continue;
 		}
 	}
 
+	if (!cid || !pid || !vid)
+		goto fail;
+
 	return true;
+fail:
+	l_free(node->comp);
+	node->comp = NULL;
+
+	return false;
 }
 
 static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
@@ -1552,18 +1454,77 @@ static bool init_storage_dir(struct mesh_node *node)
 	return true;
 }
 
+static bool check_req_node(struct managed_obj_request *req)
+{
+	uint8_t node_comp[MAX_MSG_LEN - 2];
+	uint8_t attach_comp[MAX_MSG_LEN - 2];
+
+	uint16_t node_len = node_generate_comp(req->node, node_comp,
+							sizeof(node_comp));
+
+	if (!node_len)
+		return false;
+
+	if (req->type == REQUEST_TYPE_ATTACH) {
+		uint16_t attach_len = node_generate_comp(req->attach,
+					attach_comp, sizeof(attach_comp));
+
+		if (node_len != attach_len ||
+				memcmp(node_comp, attach_comp, node_len)) {
+			l_debug("Failed to verify app's composition data");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static struct mesh_node *attach_req_node(struct mesh_node *attach,
+							struct mesh_node *node)
+{
+	const struct l_queue_entry *attach_entry;
+	const struct l_queue_entry *node_entry;
+
+	attach_entry = l_queue_get_entries(attach->elements);
+	node_entry = l_queue_get_entries(node->elements);
+
+	/*
+	 * Update existing node with paths collected in temporary node,
+	 * then remove the temporary.
+	 * */
+	while (attach_entry && node_entry)
+	{
+		struct node_element *attach_ele = node_entry->data;
+		struct node_element *node_ele = node_entry->data;
+
+		l_free(attach_ele->path);
+		attach_ele->path = node_ele->path;
+		node_ele->path = NULL;
+
+		attach_entry = attach_entry->next;
+		node_entry = node_entry->next;
+	}
+
+	mesh_agent_remove(attach->agent);
+	attach->agent = node->agent;
+	node->agent = NULL;
+
+	attach->provisioner = node->provisioner;
+
+	node_remove(node);
+
+	return attach;
+}
+
 static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 {
 	struct l_dbus_message_iter objects, interfaces;
 	struct managed_obj_request *req = user_data;
 	const char *path;
-	struct mesh_node *node = NULL;
+	struct mesh_node *node = req->node;
 	void *agent = NULL;
 	bool have_app = false;
-	bool is_new;
-	uint8_t num_ele;
-
-	is_new = (req->type != REQUEST_TYPE_ATTACH);
+	unsigned int num_ele;
 
 	if (l_dbus_message_is_error(msg)) {
 		l_error("Failed to get app's dbus objects");
@@ -1575,14 +1536,8 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
-	if (is_new) {
-		node = l_new(struct mesh_node, 1);
+	if (!node->elements)
 		node->elements = l_queue_new();
-	} else {
-		node = req->node;
-	}
-
-	num_ele = 0;
 
 	while (l_dbus_message_iter_next_entry(&objects, &path, &interfaces)) {
 		struct l_dbus_message_iter properties;
@@ -1593,21 +1548,14 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 			bool res;
 
 			if (!strcmp(MESH_ELEMENT_INTERFACE, interface)) {
-
-				if (num_ele == MAX_ELE_COUNT)
-					goto fail;
-
 				res = get_element_properties(node, path,
-							&properties, is_new);
+								&properties);
 				if (!res)
 					goto fail;
-
-				num_ele++;
-
 			} else if (!strcmp(MESH_APPLICATION_INTERFACE,
 								interface)) {
 				res = get_app_properties(node, path,
-							&properties, is_new);
+								&properties);
 				if (!res)
 					goto fail;
 
@@ -1637,7 +1585,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
-	if (num_ele == 0) {
+	if (l_queue_isempty(node->elements)) {
 		l_error("Interface %s not found", MESH_ELEMENT_INTERFACE);
 		goto fail;
 	}
@@ -1649,17 +1597,23 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
+	set_defaults(node);
+	num_ele = l_queue_length(node->elements);
+
+	if (num_ele > MAX_ELE_COUNT)
+		goto fail;
+
+	node->num_ele = num_ele;
+
+	if (!check_req_node(req))
+		goto fail;
+
 	if (req->type == REQUEST_TYPE_ATTACH) {
-		if (num_ele != node->num_ele)
-			goto fail;
+		struct l_dbus *bus = dbus_get_bus();
 
-		if (register_node_object(node)) {
-			struct l_dbus *bus = dbus_get_bus();
+		node = attach_req_node(req->attach, node);
 
-			node->disc_watch = l_dbus_add_disconnect_watch(bus,
-					node->owner, app_disc_cb, node, NULL);
-			req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
-		} else
+		if (!register_node_object(node))
 			goto fail;
 
 		/*
@@ -1670,30 +1624,24 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		 */
 		init_storage_dir(node);
 
+		node->disc_watch = l_dbus_add_disconnect_watch(bus,
+				node->owner, app_disc_cb, node, NULL);
+
 	} else if (req->type == REQUEST_TYPE_JOIN) {
-		if (!agent) {
+		if (!node->agent) {
 			l_error("Interface %s not found",
 						MESH_PROVISION_AGENT_INTERFACE);
 			goto fail;
 		}
 
-		node->num_ele = num_ele;
-		set_defaults(node);
-		memcpy(node->uuid, req->uuid, 16);
-
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
-		req->join_ready_cb(node, agent);
 	} else {
 		/* Callback for create node request */
 		struct keyring_net_key net_key;
 		uint8_t dev_key[16];
 
-		node->num_ele = num_ele;
-		set_defaults(node);
-		memcpy(node->uuid, req->uuid, 16);
-
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
@@ -1713,35 +1661,32 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		init_storage_dir(node);
 
 		if (!keyring_put_remote_dev_key(node, DEFAULT_NEW_UNICAST,
-							num_ele, dev_key))
+						node->num_ele, dev_key))
 			goto fail;
 
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 	}
 
+	if (req->type == REQUEST_TYPE_JOIN)
+		req->join_ready_cb(node, node->agent);
+	else
+		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
+
 	return;
 fail:
 	if (agent)
 		mesh_agent_remove(agent);
 
-	if (!is_new) {
-		free_node_dbus_resources(node);
+	/* Handle failed requests */
+	if (node)
+		node_remove(node);
 
-		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, node);
-	} else {
-		/* Handle failed Join and Create requests */
-		if (node)
-			node_remove(node);
-
-		if (req->type == REQUEST_TYPE_JOIN)
-			req->join_ready_cb(NULL, NULL);
-		else
-			req->ready_cb(req->pending_msg, MESH_ERROR_FAILED,
-									NULL);
-	}
+	if (req->type == REQUEST_TYPE_JOIN)
+		req->join_ready_cb(NULL, NULL);
+	else
+		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
 }
 
 /* Establish relationship between application and mesh node */
@@ -1765,9 +1710,15 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	node->owner = l_strdup(sender);
 
 	req = l_new(struct managed_obj_request, 1);
-	req->node = node;
+
+	/*
+	 * Create a temporary node to collect composition data from attaching
+	 * application. Existing node is passed in req->attach.
+	 */
+	req->node = node_new(node->uuid);
 	req->ready_cb = cb;
 	req->pending_msg = user_data;
+	req->attach = node;
 	req->type = REQUEST_TYPE_ATTACH;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
@@ -1789,7 +1740,7 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 	l_debug("");
 
 	req = l_new(struct managed_obj_request, 1);
-	req->uuid = uuid;
+	req->node = node_new(uuid);
 	req->join_ready_cb = cb;
 	req->type = REQUEST_TYPE_JOIN;
 
@@ -1808,7 +1759,7 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 	l_debug("");
 
 	req = l_new(struct managed_obj_request, 1);
-	req->uuid = uuid;
+	req->node = node_new(uuid);
 	req->ready_cb = cb;
 	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
-- 
2.19.1

