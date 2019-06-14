Return-Path: <SRS0=cJ+v=UN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD2C31E4B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4542F2133D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="NFNcyZbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfFNMpY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:45:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34598 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfFNMpY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jun 2019 08:45:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so2289567ljg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2019 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyHFY8XFvhBf1qfjptFjrjSpQPwU+8TF3g6UDozviVw=;
        b=NFNcyZbHT4oTaZ4/l7SrF5lE1IqVRU1F2gKQNonKi+dnFEsTuRU5y9nl/5XQLB3z43
         gION/ee9I52XIEac+Gvmtr6HFxrBQDHXrYlaZNgnBYlIzES1ISUSLWDDwLKfKBVPEU6v
         Y6cos/HNOCCZZIch31ONYM5cSjvs7dtGNbfdw61WH31CxwNq1eusdX7mz+e7XmZp9E/k
         2LqdioZpw9JD9n6WDbq/HoUsbF9nBDz4gMm6W+Ad/2NBiZ16qnyWBa8jBcJSEJYIoGTI
         ZeFKaJajxV3abrPRMNiDkTd9zaV38c/caE0Sr5Ut3WzPstqK9O1CIXf8gyv7MrWgYOMq
         eviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyHFY8XFvhBf1qfjptFjrjSpQPwU+8TF3g6UDozviVw=;
        b=X5TOn019gXmNgr4awWLaAGewDnNioWhNQq+7+w9qJeIRvdNMDbzjiQUjrX1+fTflf9
         v8+etTluwbnQTkFD2E33o88lZFKYCAjMTOVExFsQ2PcSyWg8N4yeWgBzHpUjWyqfir+w
         8HyS7Lvj7SevYa2eDpnXfz+l1hDi7hr089BTYJYwVaNZjgMGczrVaggP3FfbqAqnUwbh
         iKOTp7BnwoQ5cnHCWOLMGVAwVJL16Brngd5824YxjoPydbk+Hf0K9sa6lPwZbTE/S70P
         DAdctHdfj4hlcSX6Upl0RInpacLQTUYduJRIVN3nUSVwX9TASujQVYF2p4slgfGZFB8Y
         zBSA==
X-Gm-Message-State: APjAAAVF51NKOeZBL4cXZManBQIX1RFL8KkdLfmn0KlGenXZJ+HxNGfW
        x6WDC8WwVE9iKNNp4YnPiPpHWC4UJPamog==
X-Google-Smtp-Source: APXvYqxc/ccbfnU+ac2ZKOP8J1BahGTTaC4DmwItnZfSzOXfHMUT2MH3IDXb0idp3UOd96od5VdPBw==
X-Received: by 2002:a2e:3a05:: with SMTP id h5mr39856691lja.114.1560516321445;
        Fri, 14 Jun 2019 05:45:21 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v4sm572722lji.103.2019.06.14.05.45.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:45:20 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH 3/3] mesh: Allow to import multiple network keys
Date:   Fri, 14 Jun 2019 14:45:11 +0200
Message-Id: <20190614124512.19062-4-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614124512.19062-1-jakub.witowski@silvair.com>
References: <20190614124512.19062-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements allows to import local node with
multiple network keys
---
 mesh/keyring.h |   1 +
 mesh/net.c     |   2 +-
 mesh/node.c    | 264 ++++++++++++++++++++++++++-----------------------
 3 files changed, 144 insertions(+), 123 deletions(-)

diff --git a/mesh/keyring.h b/mesh/keyring.h
index 167191013..8607f6497 100644
--- a/mesh/keyring.h
+++ b/mesh/keyring.h
@@ -22,6 +22,7 @@ struct keyring_net_key {
 	uint8_t phase;
 	uint8_t old_key[16];
 	uint8_t new_key[16];
+	bool key_refresh;
 };
 
 struct keyring_app_key {
diff --git a/mesh/net.c b/mesh/net.c
index 1cb29e1e8..a597b8794 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -56,7 +56,7 @@
 #define DEFAULT_MIN_DELAY		0
 #define DEFAULT_MAX_DELAY		25
 
-#define DEFAULT_TRANSMIT_COUNT		3
+#define DEFAULT_TRANSMIT_COUNT		1
 #define DEFAULT_TRANSMIT_INTERVAL	100
 
 #define BEACON_INTERVAL_MIN	10
diff --git a/mesh/node.c b/mesh/node.c
index fab5780cb..40def0fba 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1457,77 +1457,92 @@ static bool parse_imported_device_key(json_object *jobj, uint8_t key_buf[16])
 	return true;
 }
 
-static bool parse_imported_net_key(json_object *jobj, uint8_t key_buf[16],
-				bool *kr, uint16_t *net_idx, uint8_t *ph)
+static struct l_queue *parse_imported_net_key(json_object *jobj)
 {
 	json_object *jobject;
 	struct json_object_iterator iter, iend;
 	const char *jidx;
 	json_object *jtemp, *jvalue;
+	struct l_queue *keys;
+	struct keyring_net_key *net_keyring;
 
 	if (!json_object_object_get_ex(jobj, "netKeys", &jobject))
-		return false;
+		return NULL;
 
 	if (json_object_get_type(jobject) != json_type_object)
-		return false;
+		return NULL;
+
+	keys = l_queue_new();
 
 	iter = json_object_iter_begin(jobject);
 	iend = json_object_iter_end(jobject);
 
 	while (!json_object_iter_equal(&iter, &iend)) {
+
 		uint16_t idx;
 		char *str, *end;
-		bool key_refresh = false;
-		uint8_t phase;
-		uint8_t key[16];
 		uint8_t new_key[16];
+		uint8_t old_key[16];
+
+		net_keyring = l_new(struct keyring_net_key, 1);
 
+		net_keyring->key_refresh = false;
 		jidx = json_object_iter_peek_name(&iter);
 		jtemp = json_object_iter_peek_value(&iter);
 
 		if (!*jidx)
-			return false;
+			goto fail;
 
 		idx = (uint16_t)strtol(jidx, &end, 10);
 		if (*end || (idx > 4095))
-			return false;
+			goto fail;
 
-		*net_idx = idx;
+		net_keyring->net_idx = idx;
 		if (json_object_get_type(jtemp) != json_type_object)
-			return false;
+			goto fail;
 
 		json_object_object_get_ex(jtemp, "oldKey", &jvalue);
 
 		if (jvalue) {
 			str = (char *)json_object_get_string(jvalue);
-			if (!str2hex(str, strlen(str), key, 16))
-				return false;
-			key_refresh = true;
+			if (!str2hex(str, strlen(str), old_key, 16))
+				goto fail;
+
+			net_keyring->key_refresh = true;
 		}
 
 		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
-			return false;
+			goto fail;
 
 		str = (char *)json_object_get_string(jvalue);
-		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
-			return false;
 
-		memcpy(&key_buf[0], key_refresh ? new_key : key, 16);
+		if (!str2hex(str, strlen(str), net_keyring->key_refresh ?
+							new_key : old_key, 16))
+			goto fail;
+
+		memcpy(net_keyring->old_key, old_key, 16);
+
+		if (net_keyring->key_refresh)
+			memcpy(net_keyring->new_key, new_key, 16);
 
 		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
-			return false;
+			goto fail;
 
 		if (!jvalue)
-			phase = KEY_REFRESH_PHASE_NONE;
+			net_keyring->phase = KEY_REFRESH_PHASE_NONE;
 		else
-			phase = (uint8_t)json_object_get_int(jvalue);
+			net_keyring->phase =
+					(uint8_t)json_object_get_int(jvalue);
 
-		*ph = phase;
-		*kr = key_refresh;
+		l_queue_push_tail(keys, net_keyring);
 		json_object_iter_next(&iter);
 	}
 
-	return true;
+	return keys;
+fail:
+	l_queue_destroy(keys, l_free);
+	l_free(net_keyring);
+	return NULL;
 }
 
 static bool parse_imported_models(json_object *jmodels,
@@ -1548,7 +1563,7 @@ static bool parse_imported_models(json_object *jmodels,
 
 		mod = l_new(struct mesh_db_model, 1);
 		if (!mod)
-			goto fail;
+			return false;
 
 		jidx = json_object_iter_peek_name(&iter);
 
@@ -1557,35 +1572,30 @@ static bool parse_imported_models(json_object *jmodels,
 
 		switch (strlen(jidx)) {
 
-		case 4: {
+		case 4:
 			if (sscanf(jidx, "%04x", &id) != 1)
-				goto fail;
+				return false;
 
 			id |= VENDOR_ID_MASK;
 			break;
-		}
 
-		case 8: {
+		case 8:
 			if (sscanf(jidx, "%08x", &id) != 1)
-				goto fail;
+				return false;
 
 			mod->vendor = true;
 			break;
-		}
 
 		default:
-			goto fail;
+			return false;
 		}
 
 		mod->id = id;
 		l_queue_push_tail(ele->models, mod);
 		json_object_iter_next(&iter);
 	}
-	return true;
 
-fail:
-	l_queue_destroy(ele->models, l_free);
-	return false;
+	return true;
 }
 
 static bool parse_imported_elements(json_object *jelements,
@@ -1638,54 +1648,54 @@ static bool parse_imported_elements(json_object *jelements,
 		ele = l_new(struct mesh_db_element, 1);
 
 		if (!ele)
-			goto fail;
+			return false;
 
 		ele->index = idx;
 		ele->models = l_queue_new();
 
 		if (!ele->models)
-			goto fail;
+			return false;
 
 		if (!json_object_object_get_ex(jtemp, "location", &jlocation))
-			goto fail;
+			return false;
 
 		str = (char *)json_object_get_string(jlocation);
 
 		if (sscanf(str, "%04hx", &(ele->location)) != 1)
-			goto fail;
+			return false;
 
 		if (json_object_object_get_ex(jtemp, "models", &jmodels)) {
 
 			if (json_object_get_type(jmodels) != json_type_object)
-				goto fail;
+				return false;
 
 			if (!parse_imported_models(jmodels, ele))
-				goto fail;
+				return false;
 		}
 
 		l_queue_push_tail(db_node->elements, ele);
 		json_object_iter_next(&iter);
 	}
+
 	return true;
+}
 
-fail:
-	l_queue_destroy(db_node->elements, l_free);
-	db_node->elements = NULL;
+static void put_net_keyrings(void *net_keys, void *_node)
+{
+	struct mesh_node *node = _node;
+	struct keyring_net_key *net_key = net_keys;
 
-	if (ele->models) {
-		l_queue_destroy(ele->models, l_free);
-		ele->models = NULL;
-	}
+	if (!node || !net_key)
+		return;
 
-	return false;
+	if (!keyring_put_net_key(node, net_key->net_idx, net_key))
+		return;
 }
 
 static bool parse_imported_finalize(struct mesh_db_node *db_node,
 							struct mesh_node *node)
 {
 	struct mesh_net *net;
-	uint8_t mode, cnt;
-	uint16_t interval;
 
 	if (!node_init_from_storage(node, db_node)) {
 		node_remove(node);
@@ -1693,42 +1703,48 @@ static bool parse_imported_finalize(struct mesh_db_node *db_node,
 	}
 
 	net = node_get_net(node);
-	mesh_net_set_seq_num(net, node_get_sequence_number(node));
-	mesh_net_set_default_ttl(net, node_default_ttl_get(node));
-
-	mode = node_proxy_mode_get(node);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_proxy_mode(net, mode == MESH_MODE_ENABLED);
-
-	mode = node_friend_mode_get(node);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_friend_mode(net, mode == MESH_MODE_ENABLED);
-
-	mode = node_relay_mode_get(node, &cnt, &interval);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_relay_mode(net, mode == MESH_MODE_ENABLED, cnt,
-								interval);
-
-	mode = node_beacon_mode_get(node);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_beacon_mode(net, mode == MESH_MODE_ENABLED);
 
 	if (!IS_UNASSIGNED(db_node->unicast) &&
 			!mesh_net_register_unicast(net, db_node->unicast,
 			node_get_num_elements(node))) {
+
 		node_remove(node);
 		return false;
 	}
 
-	if (node_uuid_get(node))
-		mesh_net_id_uuid_set(net, node_uuid_get(node));
-
+	mesh_net_id_uuid_set(net, node_uuid_get(node));
 	return true;
 }
 
-static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
-				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
-				uint16_t net_key_idx, uint8_t net_key[16])
+static void add_keys(void *net_keys, void *_node)
+{
+	struct mesh_node *node = _node;
+	struct keyring_net_key *net_key = net_keys;
+
+	if (!node || !net_key) {
+		l_info("Add network key error");
+		return;
+	}
+
+	if (mesh_net_add_key(node->net, net_key->net_idx, net_key->old_key) !=
+					MESH_STATUS_SUCCESS)
+		return;
+
+	if (net_key->key_refresh) {
+		/* Duplicate net key, if the key refresh is on */
+		if (mesh_net_update_key(node->net, net_key->net_idx,
+				net_key->old_key) != MESH_STATUS_SUCCESS)
+			return;
+
+		if (!mesh_db_net_key_set_phase(node->jconfig, net_key->net_idx,
+							KEY_REFRESH_PHASE_TWO))
+			return;
+	}
+}
+
+static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool ivu,
+					uint32_t iv_idx, uint8_t dev_key[16],
+					struct l_queue *net_keys)
 {
 	if (!storage_set_iv_index(node->net, iv_idx, ivu))
 		return false;
@@ -1750,21 +1766,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	node->primary = unicast;
 	mesh_net_register_unicast(node->net, unicast, node->num_ele);
 
-	if (mesh_net_add_key(node->net, net_key_idx, net_key) !=
-							MESH_STATUS_SUCCESS)
-		return false;
-
-	if (kr) {
-		/* Duplicate net key, if the key refresh is on */
-		if (mesh_net_update_key(node->net, net_key_idx, net_key) !=
-							MESH_STATUS_SUCCESS)
-			return false;
-
-		if (!mesh_db_net_key_set_phase(node->jconfig, net_key_idx,
-							KEY_REFRESH_PHASE_TWO))
-			return false;
-	}
-
+	l_queue_foreach(net_keys, add_keys, node);
 	storage_save_config(node, true, NULL, NULL);
 
 	/* Initialize configuration server model */
@@ -1779,6 +1781,8 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	struct managed_obj_request *req = user_data;
 	const char *path;
 	struct mesh_node *node = NULL;
+	struct l_queue *net_keys = NULL;
+	struct keyring_net_key *net_key = NULL;
 	void *agent = NULL;
 	bool have_app = false;
 	bool is_new;
@@ -1902,9 +1906,10 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 	} else {
 		/* Callback for create node request */
-		node_ready_func_t cb = req->cb;
-		struct keyring_net_key net_key;
 		uint8_t dev_key[16];
+		node_ready_func_t cb = req->cb;
+
+		net_key = l_new(struct keyring_net_key, 1);
 
 		node->num_ele = num_ele;
 		set_defaults(node);
@@ -1915,21 +1920,22 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 		/* Generate device and primary network keys */
 		l_getrandom(dev_key, sizeof(dev_key));
-		l_getrandom(net_key.old_key, sizeof(net_key.old_key));
-		net_key.net_idx = PRIMARY_NET_IDX;
-		net_key.phase = KEY_REFRESH_PHASE_NONE;
-
-		if (!add_local_node(node, DEFAULT_NEW_UNICAST, false, false,
-						DEFAULT_IV_INDEX, dev_key,
-						PRIMARY_NET_IDX,
-						net_key.old_key))
+		l_getrandom(net_key->old_key, sizeof(net_key->old_key));
+		net_key->net_idx = PRIMARY_NET_IDX;
+		net_key->phase = KEY_REFRESH_PHASE_NONE;
+
+		net_keys = l_queue_new();
+		l_queue_push_tail(net_keys, net_key);
+
+		if (!add_local_node(node, DEFAULT_NEW_UNICAST, false,
+					DEFAULT_IV_INDEX, dev_key, net_keys))
 			goto fail;
 
 		if (!keyring_put_remote_dev_key(node, DEFAULT_NEW_UNICAST,
 							num_ele, dev_key))
 			goto fail;
 
-		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
+		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, net_key))
 			goto fail;
 
 		cb(req->user_data, MESH_ERROR_NONE, node);
@@ -1937,6 +1943,12 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 	return;
 fail:
+	if (net_keys)
+		l_queue_destroy(net_keys, l_free);
+
+	if (net_key)
+		l_free(net_key);
+
 	if (agent)
 		mesh_agent_remove(agent);
 
@@ -2031,15 +2043,12 @@ void node_import(const char *sender, void *json_data, const uint8_t *uuid,
 	struct mesh_node *node;
 	struct mesh_net *net;
 	struct mesh_db_node db_node;
-	struct keyring_net_key network_key;
+	struct l_queue *net_keys = NULL;
 
 	json_object *jnode = json_data;
+
 	uint16_t unicast;
 	uint8_t dev_key[16];
-	uint8_t net_key[16];
-	bool key_refresh;
-	uint16_t net_idx;
-	uint8_t phase;
 	uint32_t iv_idx;
 	bool iv_update;
 
@@ -2073,8 +2082,9 @@ void node_import(const char *sender, void *json_data, const uint8_t *uuid,
 		goto fail;
 	}
 
-	if (!parse_imported_net_key(jnode, &net_key[0], &key_refresh,
-							&net_idx, &phase)) {
+	net_keys = parse_imported_net_key(jnode);
+
+	if (!net_keys) {
 		l_error("Failed to parse imported network key");
 		goto fail;
 	}
@@ -2094,22 +2104,17 @@ void node_import(const char *sender, void *json_data, const uint8_t *uuid,
 		goto fail;
 	}
 
-	if (!add_local_node(node, unicast, key_refresh, iv_update, iv_idx,
-					dev_key, net_idx, &net_key[0])) {
+	if (!add_local_node(node, unicast, iv_update, iv_idx, dev_key,
+								net_keys)) {
 		l_error("Failed to add local node");
 		goto fail;
 	}
 
-	memcpy(network_key.old_key, net_key, 16);
-	network_key.net_idx = net_idx;
-	network_key.phase = phase;
+	l_queue_foreach(net_keys, put_net_keyrings, node);
 
 	if (!keyring_put_remote_dev_key(node, unicast, node->num_ele, dev_key))
 		goto fail;
 
-	if (!keyring_put_net_key(node, net_idx, &network_key))
-		goto fail;
-
 	cb(user_data, MESH_ERROR_NONE, node);
 	return;
 
@@ -2117,6 +2122,9 @@ fail:
 	cb(user_data, MESH_ERROR_FAILED, NULL);
 	json_object_put(jnode);
 
+	if (net_keys)
+		l_queue_destroy(net_keys, l_free);
+
 	if (node)
 		node_remove(node);
 }
@@ -2125,11 +2133,9 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
 	struct managed_obj_request *req;
-	struct mesh_node *node;
 
 	l_debug("");
 
-	node = node_new(uuid);
 	req = l_new(struct managed_obj_request, 1);
 	req->data = (void *) uuid;
 	req->cb = cb;
@@ -2377,11 +2383,25 @@ const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx)
 bool node_add_pending_local(struct mesh_node *node, void *prov_node_info)
 {
 	struct mesh_prov_node_info *info = prov_node_info;
+	struct l_queue *net_keys = l_queue_new();
+	struct keyring_net_key *net_keyring = l_new(struct keyring_net_key, 1);
+
 	bool kr = !!(info->flags & PROV_FLAG_KR);
 	bool ivu = !!(info->flags & PROV_FLAG_IVU);
 
-	return add_local_node(node, info->unicast, kr, ivu, info->iv_index,
-			info->device_key, info->net_index, info->net_key);
+	net_keyring->net_idx = info->net_index;
+	net_keyring->key_refresh = kr;
+	memcpy(net_keyring->old_key, info->net_key, 16);
+
+	l_queue_push_tail(net_keys, net_keyring);
+
+	if (add_local_node(node, info->unicast, ivu, info->iv_index,
+						info->device_key, net_keys))
+		return true;
+
+	l_free(net_keyring);
+	l_queue_destroy(net_keys, l_free);
+	return false;
 }
 
 void node_jconfig_set(struct mesh_node *node, void *jconfig)
-- 
2.20.1

