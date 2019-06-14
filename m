Return-Path: <SRS0=cJ+v=UN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E2DC31E4D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC62C2133D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="n7pVpxpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFNMpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:45:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36050 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNMpX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jun 2019 08:45:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so2277764ljj.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2019 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2V4PxO+0k4ejhOAcWivPzRjGvmgmEHDhBkCtb3FW8E4=;
        b=n7pVpxpozZr427C3Ry4vueaRGcF5Ku/7tfjZYa9wfsKurbS4zhT4MMCjQYp0R61qEs
         qeg0GF45kJTyyaR8JS2joi+T4WQadjUSHB6/ktIVM2NB+spHdrI+5VFX8hegG887DyZC
         /cNIZY4scdPAFrohgYS8y2QHRBjKoFQJ/p6sD8Wxy3zB7Gq/3PYsxj8x/HNADt1vx1i0
         4DAmHr5WKnd/tSvUz5g9SASGEeEE+bvLS7Mkoz/+25ohFgogppwusdeqFWt+RUIXtg14
         PmRTfDjHgkxzYUXxBz2b1NgT+8wOwzFcl3JINMVmDxm7rPjVGWPnnqAcDSThML9Mx+n9
         yGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2V4PxO+0k4ejhOAcWivPzRjGvmgmEHDhBkCtb3FW8E4=;
        b=Ie5AthPq3dvtaccOz+PegVFwWK4vip4AovEnHmMzFa3e0IL+N+2qHGB+ntIGDnHrNv
         SH7rzItDaxPy8/wJbQKoqhhuoBhSegtLhgu5BWCv3LR1k/y542n/3Kss1RljMpog++B/
         Rxy40zGEcrHdW9h10Ky5dPu9/G+AQQIcFeT1XYMF0IWBwRNNNtrr53lIhc4XuNYR+xqr
         85Lrcs/CYPP2vBFWeltk98vjzYEgM8IXLUVp7kOEoCWlWjCslx8YrF6L2PkoNZ0JeVpU
         K/ANKq2B+QA/iZsyTTCDqNgS0QRCxZ7SWHZqGnCdB0GXBjxbuckofw5BScF31/u6n7gu
         GZfw==
X-Gm-Message-State: APjAAAUIhmVucYyRTOiHFwFU86/7Z2C7XFyrFHdCZo3ycVYu1tcNIvy+
        EkB6LK5RrKr0Dy3/HlGkBHSn1hvbFaM2QA==
X-Google-Smtp-Source: APXvYqxMLqGQ0gWqxZpTYzD0MAqviRDUvhl2gteIW2mR/l9mcZwjdh59f1jFkx1ib6iexYFXxqJ9kQ==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr22218059ljj.100.1560516320236;
        Fri, 14 Jun 2019 05:45:20 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v4sm572722lji.103.2019.06.14.05.45.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:45:19 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH 2/3] mesh: Added functionality of import local node
Date:   Fri, 14 Jun 2019 14:45:10 +0200
Message-Id: <20190614124512.19062-3-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614124512.19062-1-jakub.witowski@silvair.com>
References: <20190614124512.19062-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements node_import() which provides full functionality
of importing node via dbus from json format
---
 mesh/mesh.c  |  10 +-
 mesh/model.c |   5 +-
 mesh/node.c  | 474 ++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 437 insertions(+), 52 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index bcbd9ada4..a3f44bc8e 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -66,7 +66,7 @@ struct bt_mesh {
 	uint8_t max_filters;
 };
 
-struct join_data{
+struct join_data {
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
 	const char *sender;
@@ -531,8 +531,8 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 
 	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
 				mesh.prov_timeout, agent, prov_complete_cb,
-				&mesh))
-	{
+				&mesh)) {
+
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning acceptor");
 		goto fail;
@@ -792,13 +792,13 @@ static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
 
 	sender = l_dbus_message_get_sender(msg);
 	pending_msg = l_dbus_message_ref(msg);
+
 	if (!pending_queue)
 		pending_queue = l_queue_new();
 
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	node_import(sender, jnode, uuid, create_node_ready_cb,
-								pending_msg);
+	node_import(sender, jnode, uuid, create_node_ready_cb, pending_msg);
 
 	return NULL;
 }
diff --git a/mesh/model.c b/mesh/model.c
index f29ad9af2..1d69236ca 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -228,6 +228,7 @@ static struct l_dbus_message *create_config_update_msg(struct mesh_node *node,
 
 	if ((id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
 		uint16_t vendor = id >> 16;
+
 		dbus_append_dict_entry_basic(*builder, "Vendor", "q", &vendor);
 	}
 
@@ -269,7 +270,7 @@ static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
 	for (entry = l_queue_get_entries(q); entry; entry = entry->next) {
 		uint16_t value = (uint16_t) L_PTR_TO_UINT(entry->data);
 
-		l_dbus_message_builder_append_basic(builder,'q', &value);
+		l_dbus_message_builder_append_basic(builder, 'q', &value);
 	}
 
 	l_dbus_message_builder_leave_array(builder);
@@ -1597,6 +1598,7 @@ void model_build_config(void *model, void *msg_builder)
 	/* For vendor models, add vendor id */
 	if ((mod->id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
 		uint16_t vendor = mod->id >> 16;
+
 		dbus_append_dict_entry_basic(builder, "Vendor", "q", &vendor);
 	}
 
@@ -1607,6 +1609,7 @@ void model_build_config(void *model, void *msg_builder)
 	/* Model periodic publication interval, if present */
 	if (mod->pub) {
 		uint32_t period = pub_period_to_ms(mod->pub->period);
+
 		dbus_append_dict_entry_basic(builder, "PublicationPeriod", "u",
 								&period);
 	}
diff --git a/mesh/node.c b/mesh/node.c
index b55e2b72a..fab5780cb 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -27,6 +27,9 @@
 
 #include <ell/ell.h>
 #include <json-c/json.h>
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
@@ -1078,6 +1081,7 @@ static bool validate_model_property(struct node_element *ele,
 		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
 								&mod_id)) {
 			struct mesh_model *mod;
+
 			mod = l_queue_find(ele->models, match_model_id,
 				L_UINT_TO_PTR((vendor_id << 16) | mod_id));
 			if (!mod)
@@ -1366,17 +1370,366 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 	return true;
 }
 
-static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
-				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
-				uint16_t net_key_idx, uint8_t net_key[16])
+static bool parse_imported_composition(json_object *jcomp,
+						struct mesh_db_node *node)
 {
-	node->net = mesh_net_new(node);
+	json_object *jvalue;
+	char *str;
 
-	if (!nodes)
-		nodes = l_queue_new();
+	/* All the fields in node composition are mandatory */
+	if (!json_object_object_get_ex(jcomp, "cid", &jvalue))
+		return false;
 
-	l_queue_push_tail(nodes, node);
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", &node->cid) != 1)
+		return false;
+
+	if (!json_object_object_get_ex(jcomp, "pid", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", &node->pid) != 1)
+		return false;
+
+	if (!json_object_object_get_ex(jcomp, "vid", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", &node->vid) != 1)
+		return false;
+
+	return true;
+}
+
+static bool parse_imported_iv_index(json_object *jobj, uint32_t *idx,
+								bool *update)
+{
+	int tmp;
+	json_object *jvalue;
+
+	if (!json_object_object_get_ex(jobj, "IVindex", &jvalue))
+		return false;
+
+	tmp = json_object_get_int(jvalue);
+	*idx = (uint32_t) tmp;
+
+	if (!json_object_object_get_ex(jobj, "IVupdate", &jvalue))
+		return false;
+
+	tmp = json_object_get_int(jvalue);
+	*update = (bool)tmp;
+
+	return true;
+}
+
+static bool parse_imported_unicast_addr(json_object *jobj, uint16_t *unicast)
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+
+	if (sscanf(str, "%04hx", unicast) != 1)
+		return false;
+
+	return true;
+}
+
+static bool parse_imported_device_key(json_object *jobj, uint8_t key_buf[16])
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!key_buf)
+		return false;
+
+	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+
+	if (!str2hex(str, strlen(str), key_buf, 16))
+		return false;
+
+	return true;
+}
+
+static bool parse_imported_net_key(json_object *jobj, uint8_t key_buf[16],
+				bool *kr, uint16_t *net_idx, uint8_t *ph)
+{
+	json_object *jobject;
+	struct json_object_iterator iter, iend;
+	const char *jidx;
+	json_object *jtemp, *jvalue;
+
+	if (!json_object_object_get_ex(jobj, "netKeys", &jobject))
+		return false;
+
+	if (json_object_get_type(jobject) != json_type_object)
+		return false;
+
+	iter = json_object_iter_begin(jobject);
+	iend = json_object_iter_end(jobject);
+
+	while (!json_object_iter_equal(&iter, &iend)) {
+		uint16_t idx;
+		char *str, *end;
+		bool key_refresh = false;
+		uint8_t phase;
+		uint8_t key[16];
+		uint8_t new_key[16];
+
+		jidx = json_object_iter_peek_name(&iter);
+		jtemp = json_object_iter_peek_value(&iter);
+
+		if (!*jidx)
+			return false;
+
+		idx = (uint16_t)strtol(jidx, &end, 10);
+		if (*end || (idx > 4095))
+			return false;
+
+		*net_idx = idx;
+		if (json_object_get_type(jtemp) != json_type_object)
+			return false;
+
+		json_object_object_get_ex(jtemp, "oldKey", &jvalue);
+
+		if (jvalue) {
+			str = (char *)json_object_get_string(jvalue);
+			if (!str2hex(str, strlen(str), key, 16))
+				return false;
+			key_refresh = true;
+		}
+
+		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
+			return false;
+
+		str = (char *)json_object_get_string(jvalue);
+		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
+			return false;
+
+		memcpy(&key_buf[0], key_refresh ? new_key : key, 16);
 
+		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
+			return false;
+
+		if (!jvalue)
+			phase = KEY_REFRESH_PHASE_NONE;
+		else
+			phase = (uint8_t)json_object_get_int(jvalue);
+
+		*ph = phase;
+		*kr = key_refresh;
+		json_object_iter_next(&iter);
+	}
+
+	return true;
+}
+
+static bool parse_imported_models(json_object *jmodels,
+						struct mesh_db_element *ele)
+{
+	struct json_object_iterator iter, end;
+
+	if (json_object_get_type(jmodels) != json_type_object)
+		return false;
+
+	iter = json_object_iter_begin(jmodels);
+	end = json_object_iter_end(jmodels);
+
+	while (!json_object_iter_equal(&iter, &end)) {
+		uint32_t id;
+		const char *jidx;
+		struct mesh_db_model *mod;
+
+		mod = l_new(struct mesh_db_model, 1);
+		if (!mod)
+			goto fail;
+
+		jidx = json_object_iter_peek_name(&iter);
+
+		if (!*jidx)
+			return false;
+
+		switch (strlen(jidx)) {
+
+		case 4: {
+			if (sscanf(jidx, "%04x", &id) != 1)
+				goto fail;
+
+			id |= VENDOR_ID_MASK;
+			break;
+		}
+
+		case 8: {
+			if (sscanf(jidx, "%08x", &id) != 1)
+				goto fail;
+
+			mod->vendor = true;
+			break;
+		}
+
+		default:
+			goto fail;
+		}
+
+		mod->id = id;
+		l_queue_push_tail(ele->models, mod);
+		json_object_iter_next(&iter);
+	}
+	return true;
+
+fail:
+	l_queue_destroy(ele->models, l_free);
+	return false;
+}
+
+static bool parse_imported_elements(json_object *jelements,
+						struct mesh_db_node *db_node)
+{
+	json_object *jvalue;
+	json_object *jtemp;
+	struct json_object_iterator iter, end;
+	struct mesh_db_element *ele;
+	const char *jidx;
+
+	if (!json_object_object_get_ex(jelements, "elements", &jvalue))
+		return false;
+
+	if (json_object_get_type(jelements) != json_type_object)
+		return false;
+
+	if (jvalue && json_object_get_type(jvalue) != json_type_object)
+		return false;
+
+	db_node->elements = l_queue_new();
+
+	if (!db_node->elements)
+		return false;
+
+	iter = json_object_iter_begin(jvalue);
+	end = json_object_iter_end(jvalue);
+
+	while (!json_object_iter_equal(&iter, &end)) {
+
+		json_object *jmodels, *jlocation;
+
+		char *str_end, *str;
+		uint8_t idx;
+
+		jidx = json_object_iter_peek_name(&iter);
+		jtemp = json_object_iter_peek_value(&iter);
+
+		if (!*jidx)
+			return false;
+
+		idx = (uint8_t)strtol(jidx, &str_end, 10);
+
+		if (*str_end)
+			return false;
+
+		if (json_object_get_type(jtemp) != json_type_object)
+			return false;
+
+		ele = l_new(struct mesh_db_element, 1);
+
+		if (!ele)
+			goto fail;
+
+		ele->index = idx;
+		ele->models = l_queue_new();
+
+		if (!ele->models)
+			goto fail;
+
+		if (!json_object_object_get_ex(jtemp, "location", &jlocation))
+			goto fail;
+
+		str = (char *)json_object_get_string(jlocation);
+
+		if (sscanf(str, "%04hx", &(ele->location)) != 1)
+			goto fail;
+
+		if (json_object_object_get_ex(jtemp, "models", &jmodels)) {
+
+			if (json_object_get_type(jmodels) != json_type_object)
+				goto fail;
+
+			if (!parse_imported_models(jmodels, ele))
+				goto fail;
+		}
+
+		l_queue_push_tail(db_node->elements, ele);
+		json_object_iter_next(&iter);
+	}
+	return true;
+
+fail:
+	l_queue_destroy(db_node->elements, l_free);
+	db_node->elements = NULL;
+
+	if (ele->models) {
+		l_queue_destroy(ele->models, l_free);
+		ele->models = NULL;
+	}
+
+	return false;
+}
+
+static bool parse_imported_finalize(struct mesh_db_node *db_node,
+							struct mesh_node *node)
+{
+	struct mesh_net *net;
+	uint8_t mode, cnt;
+	uint16_t interval;
+
+	if (!node_init_from_storage(node, db_node)) {
+		node_remove(node);
+		return false;
+	}
+
+	net = node_get_net(node);
+	mesh_net_set_seq_num(net, node_get_sequence_number(node));
+	mesh_net_set_default_ttl(net, node_default_ttl_get(node));
+
+	mode = node_proxy_mode_get(node);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_proxy_mode(net, mode == MESH_MODE_ENABLED);
+
+	mode = node_friend_mode_get(node);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_friend_mode(net, mode == MESH_MODE_ENABLED);
+
+	mode = node_relay_mode_get(node, &cnt, &interval);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_relay_mode(net, mode == MESH_MODE_ENABLED, cnt,
+								interval);
+
+	mode = node_beacon_mode_get(node);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_beacon_mode(net, mode == MESH_MODE_ENABLED);
+
+	if (!IS_UNASSIGNED(db_node->unicast) &&
+			!mesh_net_register_unicast(net, db_node->unicast,
+			node_get_num_elements(node))) {
+		node_remove(node);
+		return false;
+	}
+
+	if (node_uuid_get(node))
+		mesh_net_id_uuid_set(net, node_uuid_get(node));
+
+	return true;
+}
+
+static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
+				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
+				uint16_t net_key_idx, uint8_t net_key[16])
+{
 	if (!storage_set_iv_index(node->net, iv_idx, ivu))
 		return false;
 
@@ -1444,7 +1797,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 	if (is_new) {
-		node = l_new(struct mesh_node, 1);
+		node = node_new(req->data);
 		node->elements = l_queue_new();
 	} else {
 		node = req->data;
@@ -1675,79 +2028,108 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 void node_import(const char *sender, void *json_data, const uint8_t *uuid,
 			node_ready_func_t cb, void *user_data)
 {
+	struct mesh_node *node;
+	struct mesh_net *net;
+	struct mesh_db_node db_node;
+	struct keyring_net_key network_key;
+
 	json_object *jnode = json_data;
-	struct mesh_node *node = NULL;
-	struct keyring_net_key net_key;
+	uint16_t unicast;
 	uint8_t dev_key[16];
+	uint8_t net_key[16];
+	bool key_refresh;
+	uint16_t net_idx;
+	uint8_t phase;
+	uint32_t iv_idx;
+	bool iv_update;
 
-	node = l_new(struct mesh_node, 1);
-	node->elements = l_queue_new();
+	l_info("Node import method call");
+
+	node = node_new(uuid);
+	memset(&db_node, 0, sizeof(db_node));
+
+	net = node_get_net(node);
+	assert(net);
 
-	(void)jnode;
-	/*
-	 * TODO:
-	 * add elements from json
-	 */
-	node->num_ele = l_queue_length(node->elements);
 	set_defaults(node);
-	memcpy(node->uuid, uuid, 16);
 
-	if (!create_node_config(node)) {
-		l_error("create config");
+	if (!parse_imported_iv_index(jnode, &iv_idx, &iv_update)) {
+		l_error("Failed to parse imported iv idx");
 		goto fail;
 	}
 
-	/*
-	 * TODO:
-	 * get primary (dev and net) keys from jnode
-	 */
-	l_getrandom(dev_key, sizeof(dev_key));
-	l_getrandom(net_key.old_key, sizeof(net_key.old_key));
+	if (!parse_imported_composition(jnode, &db_node)) {
+		l_error("Failed to parse composition data");
+		goto fail;
+	}
 
-	net_key.net_idx = PRIMARY_NET_IDX;
-	net_key.phase = KEY_REFRESH_PHASE_NONE;
+	if (!parse_imported_unicast_addr(jnode, &unicast)) {
+		l_error("Failed to parse unicast address");
+		goto fail;
+	}
 
-	if (!add_local_node(node, DEFAULT_NEW_UNICAST, false, false,
-					DEFAULT_IV_INDEX, dev_key,
-					PRIMARY_NET_IDX,
-					net_key.old_key)) {
-		l_error("add local node");
+	if (!parse_imported_device_key(jnode, &dev_key[0])) {
+		l_error("Failed to parse device key");
 		goto fail;
 	}
 
-	if (!keyring_put_remote_dev_key(node, node->primary,
-					node->num_ele, dev_key)) {
-		l_error("put remote key");
+	if (!parse_imported_net_key(jnode, &net_key[0], &key_refresh,
+							&net_idx, &phase)) {
+		l_error("Failed to parse imported network key");
 		goto fail;
 	}
 
-	/*
-	 * TODO:
-	 * add remaining keys from json
-	 */
-	if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key)) {
-		l_error("put net key");
+	if (!parse_imported_elements(jnode, &db_node)) {
+		l_error("Failed to parse elements");
 		goto fail;
 	}
 
+	if (!parse_imported_finalize(&db_node, node)) {
+		l_error("Failed to finalize imported node");
+		goto fail;
+	}
+
+	if (!create_node_config(node)) {
+		l_error("Failed to create config");
+		goto fail;
+	}
+
+	if (!add_local_node(node, unicast, key_refresh, iv_update, iv_idx,
+					dev_key, net_idx, &net_key[0])) {
+		l_error("Failed to add local node");
+		goto fail;
+	}
+
+	memcpy(network_key.old_key, net_key, 16);
+	network_key.net_idx = net_idx;
+	network_key.phase = phase;
+
+	if (!keyring_put_remote_dev_key(node, unicast, node->num_ele, dev_key))
+		goto fail;
+
+	if (!keyring_put_net_key(node, net_idx, &network_key))
+		goto fail;
+
 	cb(user_data, MESH_ERROR_NONE, node);
 	return;
 
 fail:
-	if (node)
-		free_node_resources(node);
-
 	cb(user_data, MESH_ERROR_FAILED, NULL);
+	json_object_put(jnode);
 
+	if (node)
+		node_remove(node);
 }
 
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
 	struct managed_obj_request *req;
+	struct mesh_node *node;
 
 	l_debug("");
 
+	node = node_new(uuid);
 	req = l_new(struct managed_obj_request, 1);
 	req->data = (void *) uuid;
 	req->cb = cb;
-- 
2.20.1

