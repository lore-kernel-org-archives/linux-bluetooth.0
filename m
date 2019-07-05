Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D49C4649B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C51218A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="04+/K0kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGEPW2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:22:28 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:39900 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGEPW2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 11:22:28 -0400
Received: by mail-lj1-f175.google.com with SMTP id v18so9604736ljh.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wA1wbT8ng9pR1E5nT+4JIcqWyC62XOm97zn7YHmgOc4=;
        b=04+/K0kGu4/7ZJbNkBahKoR0QP3h+No1/+bIfnA7bMTAdy+dyY+4iNUJt6vwpyUn3z
         1EbjF6usd3dvxNFpYJtxtF1iwQQmAULQG6dvVb414RzMJt+kCbmmqtAxnwcQAyM+x1k1
         ZCJ8J/idttewDr9eyjnvZolyLvYCuRJUQSd2NGAt1oJ7CRMBRfNsh9J6fLL/7n72XgPK
         vW513RGflVUq91oTja3iLIrUyoRm1vsPxsonxooVK1r4A8NPvwn03MpUrpr4U0C6Tl0s
         Cg2lvKL42JPqOm6BzBBvRAXNQWSC/Kd8tagz4ItzVlRt66AjWAOpMcmlyjMW/NBLDbIn
         XgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA1wbT8ng9pR1E5nT+4JIcqWyC62XOm97zn7YHmgOc4=;
        b=RuMRrgJc5qfBRRIQxvxl26NPV+TzQLnTzUPdvOHRWbsRUdmj+i2ogcdJeiBks80TqY
         OBYqhD26XIRqsbwq3qMTmRpksp32DhfAxKvVpk55q5NUUjnzemvaHXMQcLJLiBGmk/gZ
         X0tBQZDY6iQjGgxdT9v6wbvksy0i+CG1BVtQQS2P2fBIw5JzOiSq0owzYUKAVzocJVXA
         r6melKu2k0vclNGofF+Gf+Pp5Np6kENJBDSP34kLYcrH8lCXXFEjXUovSAsYoXTmvVCO
         U0BsGE3sBxEzH5r89/IYtZECHfmO+KigGItva0QsGmuZQDcFTwqwbUTRRdWZk3IQQh+2
         3USQ==
X-Gm-Message-State: APjAAAVklzndqZHcS3PApYC8dpJXM6DeRHyDMDum5cJAMuGI7uqUSQvF
        Ow5+J1sJPnqrpexjH1i10ZJ9ypaBRzycaA==
X-Google-Smtp-Source: APXvYqz0YEhtbl9DTksZe3VsynZmonUQgIASWlQp4xk7yo3Wmf5OJNp/9Zqpkg6c7saTG/UbAn2BQw==
X-Received: by 2002:a2e:63cd:: with SMTP id s74mr2496356lje.164.1562340144718;
        Fri, 05 Jul 2019 08:22:24 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u22sm2016989ljd.18.2019.07.05.08.22.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 08:22:24 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 2/3] mesh: Added ImportLocalNode call with its API
Date:   Fri,  5 Jul 2019 17:22:15 +0200
Message-Id: <20190705152216.27766-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705152216.27766-1-jakub.witowski@silvair.com>
References: <20190705152216.27766-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements ImportLocalNode() method on org.bluez.mesh.Network1
interface. Invoking this method creates a self-provisioned node based on
passed JSON definition. Also full functionality of import local node has
been implemented
---
 mesh/mesh.c |  90 +++++++++++++++++--
 mesh/node.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++++----
 mesh/node.h |   2 +
 3 files changed, 317 insertions(+), 22 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 26acfd4dc..b3def7817 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -22,6 +22,8 @@
 #endif
 
 #define _GNU_SOURCE
+#include <json-c/json.h>
+#include <string.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-io.h"
@@ -60,7 +62,7 @@ struct bt_mesh {
 	uint8_t max_filters;
 };
 
-struct join_data{
+struct join_data {
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
 	const char *sender;
@@ -70,6 +72,10 @@ struct join_data{
 	uint8_t *uuid;
 };
 
+static const char * const supported_import_data_types[] = {
+	"json"
+};
+
 static struct bt_mesh mesh;
 
 /* We allow only one outstanding Join request */
@@ -365,8 +371,8 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 
 	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
 				mesh.prov_timeout, agent, prov_complete_cb,
-				&mesh))
-	{
+				&mesh)) {
+
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning acceptor");
 		goto fail;
@@ -383,6 +389,18 @@ fail:
 	free_pending_join_call(true);
 }
 
+static bool validate_data_type(const char *data_type)
+{
+	uint8_t len = sizeof(supported_import_data_types) /
+					sizeof(supported_import_data_types[0]);
+
+	for (uint8_t idx = 0; idx < len; idx++) {
+		if (strcmp(data_type, supported_import_data_types[idx]) == 0)
+			return true;
+	}
+	return false;
+}
+
 static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -536,7 +554,7 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_network_ready_cb(void *user_data, int status,
+static void create_node_ready_cb(void *user_data, int status,
 							struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
@@ -593,12 +611,67 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	node_create(app_path, sender, uuid, create_network_ready_cb,
+	node_create(app_path, sender, uuid, create_node_ready_cb,
 								pending_msg);
 
 	return NULL;
 }
 
+static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	const char *app_path, *sender;
+	struct l_dbus_message *pending_msg;
+	struct l_dbus_message_iter iter_uuid, iter_import_data;
+	const char *data_type, *import_data;
+	uint8_t *uuid;
+	uint32_t n;
+	struct json_object *jnode;
+
+	l_debug("Import local node request");
+
+	if (!l_dbus_message_get_arguments(msg, "oaysay", &app_path, &iter_uuid,
+						&data_type, &iter_import_data))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!validate_data_type(data_type))
+		return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED,
+						"Unsupported data type");
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n) ||
+									n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad dev UUID");
+
+	if (node_find_by_uuid(uuid))
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
+							"Node already exists");
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_import_data,
+							&import_data, &n))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad import_data");
+
+	jnode = json_tokener_parse(import_data);
+
+	sender = l_dbus_message_get_sender(msg);
+	pending_msg = l_dbus_message_ref(msg);
+
+	if (!pending_queue)
+		pending_queue = l_queue_new();
+
+	l_queue_push_tail(pending_queue, pending_msg);
+
+	if (!node_import(app_path, sender, jnode, uuid, create_node_ready_cb,
+								pending_msg)) {
+		l_dbus_message_unref(msg);
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Node import failed");
+	}
+
+	return NULL;
+}
+
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
@@ -612,8 +685,15 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 
 	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
 								"token");
+
 	l_dbus_interface_method(iface, "CreateNetwork", 0, create_network_call,
 					"t", "oay", "token", "app", "uuid");
+
+	l_dbus_interface_method(iface, "ImportLocalNode", 0,
+					import_local_node_call,
+					"t", "oaysay", "token",
+					"app", "uuid", "data_type",
+					"import_data");
 }
 
 bool mesh_dbus_init(struct l_dbus *dbus)
diff --git a/mesh/node.c b/mesh/node.c
index 1f781cfe9..00c3270fd 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -27,6 +27,7 @@
 
 #include <ell/ell.h>
 #include <json-c/json.h>
+#include <stdio.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
@@ -57,9 +58,12 @@
 #define DEFAULT_CRPL 10
 #define DEFAULT_SEQUENCE_NUMBER 0
 
-#define REQUEST_TYPE_JOIN 0
-#define REQUEST_TYPE_ATTACH 1
-#define REQUEST_TYPE_CREATE 2
+enum request_type {
+	REQUEST_TYPE_JOIN = 0,
+	REQUEST_TYPE_ATTACH,
+	REQUEST_TYPE_CREATE,
+	REQUEST_TYPE_IMPORT,
+};
 
 struct node_element {
 	char *path;
@@ -110,7 +114,19 @@ struct managed_obj_request {
 	void *data;
 	void *cb;
 	void *user_data;
-	uint8_t type;
+	enum request_type type;
+};
+
+struct node_import_request {
+	uint8_t uuid[16];
+	uint8_t dev_key[16];
+	uint8_t net_key[16];
+	uint16_t net_idx;
+	uint16_t unicast;
+	uint32_t iv_idx;
+	bool iv_update;
+	uint32_t sequence;
+	void *user_data;
 };
 
 static struct l_queue *nodes;
@@ -870,7 +886,7 @@ element_done:
 #define MIN_COMPOSITION_LEN 16
 
 bool node_parse_composition(struct mesh_node *node, uint8_t *data,
-								uint16_t len)
+			    uint16_t len)
 {
 	struct node_composition *comp;
 	uint16_t features;
@@ -965,7 +981,7 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data,
 			vendor_id = l_get_le16(data);
 			mod_id |= (vendor_id << 16);
 			mod = mesh_model_vendor_new(ele->idx, vendor_id,
-									mod_id);
+						    mod_id);
 			if (!mod) {
 				element_free(ele);
 				goto fail;
@@ -996,7 +1012,6 @@ fail:
 
 	return false;
 }
-
 static void attach_io(void *a, void *b)
 {
 	struct mesh_node *node = a;
@@ -1385,17 +1400,86 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 	return true;
 }
 
-static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
-				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
-				uint16_t net_key_idx, uint8_t net_key[16])
+static bool parse_imported_unicast_addr(json_object *jobj, uint16_t *unicast)
 {
-	node->net = mesh_net_new(node);
+	char *str;
 
-	if (!nodes)
-		nodes = l_queue_new();
+	str = (char *)json_object_get_string(jobj);
 
-	l_queue_push_tail(nodes, node);
+	if (sscanf(str, "%04hx", unicast) != 1)
+		return false;
+
+	return true;
+}
+
+static bool parse_imported_device_key(json_object *jobj, uint8_t key_buf[16])
+{
+	char *str;
+
+	if (!key_buf)
+		return false;
 
+	str = (char *)json_object_get_string(jobj);
+
+	if (!str2hex(str, strlen(str), key_buf, 16))
+		return false;
+
+	return true;
+}
+
+static void parse_imported_sequence_nr(json_object *jobj, uint32_t *seq)
+{
+	json_object *jvalue;
+
+	if (json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+		*seq = (uint32_t) json_object_get_int(jvalue);
+	else
+		*seq = DEFAULT_SEQUENCE_NUMBER;
+}
+
+static bool parse_imported_net_key(json_object *jobj, uint8_t key_buf[16],
+							uint16_t *net_idx)
+{
+	json_object *jtemp, *jvalue;
+	char *str;
+	uint8_t key[16];
+
+	if (json_object_get_type(jobj) != json_type_array)
+		return false;
+
+	jtemp = json_object_array_get_idx(jobj, 0);
+
+	if (!json_object_object_get_ex(jtemp, "index", &jvalue))
+		return false;
+
+	*net_idx = (uint16_t)json_object_get_int(jvalue);
+
+	if (*net_idx > 4095)
+		return false;
+
+	if (!json_object_object_get_ex(jtemp, "key", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (!str2hex(str, strlen(str), key, 16))
+		return false;
+
+	memcpy(&key_buf[0], &key[0], 16);
+
+	/* Imported node shouldn't contain oldKey or keyRefresh */
+	if (json_object_object_get_ex(jtemp, "oldKey", NULL))
+		return false;
+
+	if (json_object_object_get_ex(jtemp, "keyRefresh", NULL))
+		return false;
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
 
@@ -1463,14 +1547,13 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 	if (is_new) {
-		node = l_new(struct mesh_node, 1);
+		node = node_new(req->data);
 		node->elements = l_queue_new();
 	} else {
 		node = req->data;
 	}
 
 	num_ele = 0;
-
 	while (l_dbus_message_iter_next_entry(&objects, &path, &interfaces)) {
 		struct l_dbus_message_iter properties;
 		const char *interface;
@@ -1566,6 +1649,48 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 		cb(node, agent);
 
+	} else if (req->type == REQUEST_TYPE_IMPORT) {
+
+		node_ready_func_t cb = req->cb;
+		struct node_import_request *import_data = req->user_data;
+		struct keyring_net_key net_key;
+
+		if (!agent) {
+			l_error("Interface %s not found",
+						MESH_PROVISION_AGENT_INTERFACE);
+			goto fail;
+		}
+
+		node->num_ele = num_ele;
+		set_defaults(node);
+
+		if (node->seq_number != import_data->sequence)
+			node->seq_number = import_data->sequence;
+
+		memcpy(node->uuid, import_data->uuid, 16);
+
+		if (!create_node_config(node))
+			goto fail;
+
+		if (!add_local_node(node, import_data->unicast, false,
+				import_data->iv_update, import_data->iv_idx,
+				import_data->dev_key, import_data->net_idx,
+							import_data->net_key))
+			goto fail;
+
+		memcpy(net_key.old_key, import_data->net_key, 16);
+		net_key.net_idx = import_data->net_idx;
+		net_key.phase = KEY_REFRESH_PHASE_NONE;
+
+		if (!keyring_put_remote_dev_key(node, import_data->unicast,
+						num_ele, import_data->dev_key))
+			goto fail;
+
+		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
+			goto fail;
+
+		cb(import_data->user_data, MESH_ERROR_NONE, node);
+
 	} else {
 		/* Callback for create node request */
 		node_ready_func_t cb = req->cb;
@@ -1614,7 +1739,7 @@ fail:
 
 		cb(req->user_data, MESH_ERROR_FAILED, node);
 	} else {
-		/* Handle failed Join and Create requests */
+		/* Handle failed Join, Create and Import requests */
 		if (node)
 			node_remove(node);
 
@@ -1622,6 +1747,14 @@ fail:
 			node_join_ready_func_t cb = req->cb;
 
 			cb(NULL, NULL);
+
+		} else if (req->type == REQUEST_TYPE_IMPORT) {
+			struct node_import_request *import_data =
+								req->user_data;
+			node_ready_func_t cb = req->cb;
+
+			cb(import_data->user_data, MESH_ERROR_FAILED, NULL);
+
 		} else {
 			node_ready_func_t cb = req->cb;
 
@@ -1686,6 +1819,86 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 					req, l_free);
 }
 
+static bool node_import_full(const char *app_path, const char *sender,
+					void *json_data, const uint8_t *uuid,
+					node_ready_func_t cb, void *user_data)
+{
+	return false;
+}
+
+static bool node_import_simplified(const char *app_path, const char *sender,
+					void *json_data, const uint8_t *uuid,
+					node_ready_func_t cb, void *user_data)
+{
+	struct managed_obj_request *req = l_new(struct managed_obj_request, 1);
+	struct node_import_request *node = l_new(struct node_import_request, 1);
+
+	json_object_object_foreach(json_data, key, val) {
+
+		if (!strcmp(key, "deviceKey")) {
+			if (!parse_imported_device_key(val, node->dev_key)) {
+				l_error("Failed to parse imported device key");
+				goto fail;
+			}
+
+		} else if (!strcmp(key, "unicastAddress")) {
+			if (!parse_imported_unicast_addr(val, &node->unicast)) {
+				l_error("Failed to parse imported unicast");
+				goto fail;
+			}
+
+		} else if (!strcmp(key, "IVindex")) {
+			node->iv_idx = (uint32_t) json_object_get_int(val);
+
+		} else if (!strcmp(key, "IVupdate")) {
+			node->iv_update = (bool) json_object_get_int(val);
+
+		} else if (!strcmp(key, "netKeys")) {
+			if (!parse_imported_net_key(val,
+					node->net_key, &node->net_idx)) {
+				l_error("Failed to parse imported network key");
+				goto fail;
+			}
+
+		} else {
+			if (strcmp(key, "sequenceNumber"))
+				goto fail;
+		}
+	}
+
+	parse_imported_sequence_nr(json_data, &node->sequence);
+	node->user_data = user_data;
+
+	memcpy(node->uuid, uuid, 16);
+	req->data = (void *) uuid;
+	req->user_data = node;
+	req->cb = cb;
+	req->type = REQUEST_TYPE_IMPORT;
+
+	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+						L_DBUS_INTERFACE_OBJECT_MANAGER,
+						"GetManagedObjects", NULL,
+						get_managed_objects_cb,
+						req, l_free);
+	return true;
+
+fail:
+	json_object_put(json_data);
+	l_free(node);
+	return false;
+}
+
+bool node_import(const char *app_path, const char *sender, void *json_data,
+		const uint8_t *uuid, node_ready_func_t cb, void *user_data)
+{
+	if (!json_object_object_get_ex(json_data, "elements", NULL))
+		return node_import_simplified(app_path, sender, json_data,
+							uuid, cb, user_data);
+	else
+		return node_import_full(app_path, sender, json_data, uuid,
+								cb, user_data);
+}
+
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
diff --git a/mesh/node.h b/mesh/node.h
index 142527b30..9559f9178 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -91,6 +91,8 @@ void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
+bool node_import(const char *app_path, const char *sender, void *jnode,
+		const uint8_t *uuid, node_ready_func_t cb, void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
-- 
2.20.1

