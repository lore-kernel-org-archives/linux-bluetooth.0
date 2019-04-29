Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A9CC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FECD215EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfD2TvQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:51:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:27048 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2TvQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 15:51:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 12:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="144648066"
Received: from ingas-nuc1.sea.intel.com ([10.252.200.123])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2019 12:45:13 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4] mesh: Consolidate processing of mesh element properties
Date:   Mon, 29 Apr 2019 12:45:08 -0700
Message-Id: <20190429194509.3378-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429194509.3378-1-inga.stotland@intel.com>
References: <20190429194509.3378-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Consolidate functions to parse and process properties of mesh
element objects. Also, add validation of element composition
when processing Attach() method.
---
 mesh/node.c | 269 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 167 insertions(+), 102 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index a9eb41e87..0c2fc7262 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -147,6 +147,14 @@ static bool match_element_idx(const void *a, const void *b)
 	return (element->idx == index);
 }
 
+static bool match_model_id(const void *a, const void *b)
+{
+	const struct mesh_model *mod = a;
+	uint32_t mod_id = L_PTR_TO_UINT(b);
+
+	return mod_id == mesh_model_get_model_id(mod);
+}
+
 static bool match_element_path(const void *a, const void *b)
 {
 	const struct node_element *element = a;
@@ -1029,20 +1037,115 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	}
 }
 
-static bool validate_element_properties(struct mesh_node *node,
-					const char *path,
-					struct l_dbus_message_iter *properties)
+
+static bool validate_model_property(struct node_element *ele,
+					struct l_dbus_message_iter *property,
+					uint8_t *num_models, bool vendor)
+{
+	struct l_dbus_message_iter ids;
+	uint16_t mod_id, vendor_id;
+	uint8_t count;
+	const char *signature = !vendor ? "aq" : "a(qq)";
+
+	if (!l_dbus_message_iter_get_variant(property, signature, &ids)) {
+		/* Allow empty elements */
+		if (l_queue_length(ele->models) == 0) {
+			*num_models = 0;
+			return true;
+		} else
+			return false;
+	}
+
+	count = 0;
+	if (!vendor) {
+		/* Bluetooth SIG defined models */
+		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
+			struct mesh_model *mod;
+			uint32_t m = mod_id;
+
+			/* Skip internally implemented models */
+			if (m == CONFIG_SRV_MODEL)
+				continue;
+
+			mod = l_queue_find(ele->models, match_model_id,
+					L_UINT_TO_PTR(VENDOR_ID_MASK | mod_id));
+			if (!mod)
+				return false;
+			count++;
+		}
+	} else {
+		/* Vendor defined models */
+		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
+								&mod_id)) {
+			struct mesh_model *mod;
+
+			mod = l_queue_find(ele->models, match_model_id,
+				L_UINT_TO_PTR((vendor_id << 16) | mod_id));
+			if (!mod)
+				return false;
+			count++;
+		}
+	}
+
+	*num_models = count;
+	return true;
+}
+
+static void get_models_from_properties(struct node_element *ele,
+					struct l_dbus_message_iter *property,
+								bool vendor)
+{
+	struct l_dbus_message_iter ids;
+	uint16_t mod_id, vendor_id;
+	const char *signature = !vendor ? "aq" : "a(qq)";
+
+	if (!ele->models)
+		ele->models = l_queue_new();
+
+	if (!l_dbus_message_iter_get_variant(property, signature, &ids))
+		return;
+
+	/* Bluetooth SIG defined models */
+	if (!vendor) {
+		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
+			struct mesh_model *mod;
+			uint32_t m = mod_id;
+
+			/* Skip internally implemented models */
+			if (m == CONFIG_SRV_MODEL)
+				continue;
+
+			mod = mesh_model_new(ele->idx, mod_id);
+			l_queue_push_tail(ele->models, mod);
+		}
+		return;
+	}
+
+	/* Vendor defined models */
+	while (l_dbus_message_iter_next_entry(&ids, &vendor_id, &mod_id)) {
+		struct mesh_model *mod;
+
+		mod = mesh_model_vendor_new(ele->idx, vendor_id, mod_id);
+		l_queue_push_tail(ele->models, mod);
+	}
+}
+
+static bool get_element_properties(struct mesh_node *node, const char *path,
+					struct l_dbus_message_iter *properties,
+								bool create_new)
 {
-	uint8_t ele_idx;
 	struct node_element *ele;
 	const char *key;
-	struct l_dbus_message_iter variant;
+	struct l_dbus_message_iter var;
 	bool have_index = false;
+	uint8_t idx, mod_cnt, vendor_cnt;
 
 	l_debug("path %s", path);
 
-	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
+	while (l_dbus_message_iter_next_entry(properties, &key, &var)) {
 		if (!strcmp(key, "Index")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", &idx))
+				return false;
 			have_index = true;
 			break;
 		}
@@ -1053,20 +1156,66 @@ static bool validate_element_properties(struct mesh_node *node,
 		return false;
 	}
 
-	if (!l_dbus_message_iter_get_variant(&variant, "y", &ele_idx))
-		return false;
+	if (!create_new) {
+		/* Validate composition: check the element index */
+		ele = l_queue_find(node->elements, match_element_idx,
+							L_UINT_TO_PTR(idx));
+		if (!ele) {
+			l_debug("Element with index %u not found", idx);
+			return false;
+		}
+	} else {
+		ele = l_new(struct node_element, 1);
+		ele->location = DEFAULT_LOCATION;
+		ele->idx = idx;
+	}
 
-	ele = l_queue_find(node->elements, match_element_idx,
-							L_UINT_TO_PTR(ele_idx));
+	mod_cnt = 0;
+	vendor_cnt = 0;
 
-	if (!ele) {
-		l_debug("Element with index %u not found", ele_idx);
-		return false;
+	while (l_dbus_message_iter_next_entry(properties, &key, &var)) {
+		if (!strcmp(key, "Location")) {
+			uint8_t loc;
+
+			l_dbus_message_iter_get_variant(&var, "q", &loc);
+
+			/* Validate composition: location match */
+			if (!create_new && (ele->location != loc))
+				return false;
+
+			ele->location = loc;
+
+		} else if (!strcmp(key, "Models")) {
+
+			if (create_new)
+				get_models_from_properties(ele, &var, false);
+			else if (!validate_model_property(ele, &var, &mod_cnt,
+									false))
+				return false;
+
+		} else if (!strcmp(key, "VendorModels")) {
+
+			if (create_new)
+				get_models_from_properties(ele, &var, true);
+			else if (!validate_model_property(ele, &var,
+							&vendor_cnt, true))
+				return false;
+		}
 	}
 
-	/* TODO: validate models */
+	if (create_new) {
+		l_queue_push_tail(node->elements, ele);
+	} else {
+		/* Account for internal Configuration Server model */
+		if (idx == 0)
+			mod_cnt += 1;
 
-	ele->path = l_strdup(path);
+		/* Validate composition: number of models must match */
+		if (l_queue_length(ele->models) != (mod_cnt + vendor_cnt))
+			return false;
+
+		ele->path = l_strdup(path);
+	}
 
 	return true;
 }
@@ -1101,8 +1250,8 @@ static void get_managed_objects_attach_cb(struct l_dbus_message *msg,
 			if (strcmp(MESH_ELEMENT_INTERFACE, interface))
 				continue;
 
-			if (!validate_element_properties(node, path,
-								&properties))
+			if (!get_element_properties(node, path, &properties,
+									false))
 				goto fail;
 
 			num_ele++;
@@ -1173,90 +1322,6 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 
 }
 
-static void add_model_from_properties(struct node_element *ele,
-					struct l_dbus_message_iter *property)
-{
-	struct l_dbus_message_iter ids;
-	uint16_t model_id;
-	int i = 0;
-
-	if (!ele->models)
-		ele->models = l_queue_new();
-
-	if (!l_dbus_message_iter_get_variant(property, "aq", &ids))
-		return;
-
-	while (l_dbus_message_iter_next_entry(&ids, &model_id)) {
-		struct mesh_model *mod;
-		l_debug("model_id %4.4x", model_id);
-		mod = mesh_model_new(ele->idx, model_id);
-		l_queue_push_tail(ele->models, mod);
-		i++;
-		if (i > 3)
-			break;
-	}
-}
-
-static void add_vendor_model_from_properties(struct node_element *ele,
-					struct l_dbus_message_iter *property)
-{
-	struct l_dbus_message_iter ids;
-	uint16_t v;
-	uint16_t m;
-
-	if (!ele->models)
-		ele->models = l_queue_new();
-
-	if (!l_dbus_message_iter_get_variant(property, "a(qq)", &ids))
-		return;
-
-	while (l_dbus_message_iter_next_entry(&ids, &v, &m)) {
-		struct mesh_model *mod;
-
-		mod = mesh_model_vendor_new(ele->idx, v, m);
-		l_queue_push_tail(ele->models, mod);
-	}
-}
-
-static bool get_element_properties(struct mesh_node *node, const char *path,
-					struct l_dbus_message_iter *properties)
-{
-	struct node_element *ele;
-	const char *key;
-	struct l_dbus_message_iter variant;
-	bool have_index = false;
-
-	l_debug("path %s", path);
-
-	ele = l_new(struct node_element, 1);
-	ele->location = DEFAULT_LOCATION;
-
-	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
-		if (!strcmp(key, "Index")) {
-			if (!l_dbus_message_iter_get_variant(&variant, "y",
-								&ele->idx))
-				return false;
-			have_index = true;
-		} else if (!strcmp(key, "Location")) {
-			l_dbus_message_iter_get_variant(&variant, "q",
-								&ele->location);
-		} else if (!strcmp(key, "Models")) {
-			add_model_from_properties(ele, &variant);
-		} else if (!strcmp(key, "VendorModels")) {
-			add_vendor_model_from_properties(ele, &variant);
-		}
-	}
-
-	if (!have_index) {
-		l_debug("Mandatory property \"Index\" not found");
-		return false;
-	}
-
-	l_queue_push_tail(node->elements, ele);
-
-	return true;
-}
-
 static bool get_app_properties(struct mesh_node *node, const char *path,
 					struct l_dbus_message_iter *properties)
 {
@@ -1418,7 +1483,7 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 
 			if (!strcmp(MESH_ELEMENT_INTERFACE, interface)) {
 				res = get_element_properties(node, path,
-								&properties);
+							&properties, true);
 				if (!res)
 					goto fail;
 
-- 
2.17.2

