Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDD0C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5028D20818
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tmMHe4NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfGQIhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:37:11 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39170 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 04:37:10 -0400
Received: by mail-lf1-f45.google.com with SMTP id v85so15770199lfa.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a6k0HnrbmXR8UkJC1hMYcdpAl2ZUsvxSYTUJrKJkfrw=;
        b=tmMHe4NBJUCABTQJB0w2sdrQhFMOzY1Z1zztSuaQe00DN1VIXkRX3elNZqhQ3f7LGz
         TI66IPgSKsWfQbSIBhVPKLqOEAjmfmzwp+8LV5HbKUBuue2r6EnlVf0WksQt/btWZWhL
         X4OTWwuWxTT2uTv31JGWY752i96kGXok5ZpC3ev3lpqq3fbyw+1eCm+HNF7el9aw11n+
         c5dv1Qou6MvrbcsbREZdm8lrSFYXs0aRBiL7ITwkHJUkVGsWMgLp8z9f0zJMnTaV+iIm
         hfqHJkb5Fus2SzD9rjiQEr7mP0YjlLqKGOxRQwv9LYu3a2jEmefBqLnyvF32LZr4IR+f
         LXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6k0HnrbmXR8UkJC1hMYcdpAl2ZUsvxSYTUJrKJkfrw=;
        b=PSslJERfLQCkAqcBHilRGUhqClBUEFl58ZDoWr2XbMcmE3NNavOU4TyXT++cnSPtuU
         uPtoyVtJO5cS5Wn/x6lgJQPDekLKifBpSpBbJAMNKzKKdRS2EL4oT1C4nTuYDxyZ8gjD
         sSMRdL6MoqHeWf1hM4ZxpEAsBKHlXqaHmV+OmALykH+/PnFPKAx7cO5gboxAS8YrvOOR
         XF/8zQTD23r8R+egvC1UVXAgqvsqg+5RfD5iJrXxibzRzJIVJjMSycqxuEAh7RNb3Yg2
         FYf7ShzN0lK7ILrBbGivmILbvCJxh9FHDr0KNgrZSlWgKMygfaPUVndYgiKso0lJe4sb
         DxmQ==
X-Gm-Message-State: APjAAAWys6tqWWB958x4I6nW4erx/esqNmEaNTW6vv8B/oJA5hStCWQx
        KD+h5TxHhdOmIqn7/+HduqKKffjqbGw=
X-Google-Smtp-Source: APXvYqyNPGg76oGx37bwy1nM2U1r1yWl9C31BgRsrW9qDcxa+Y71KCgVVOYsHVsz+fZifkprhU++8A==
X-Received: by 2002:ac2:48bc:: with SMTP id u28mr3922519lfg.126.1563352627236;
        Wed, 17 Jul 2019 01:37:07 -0700 (PDT)
Received: from localhost.localdomain ([31.0.84.191])
        by smtp.gmail.com with ESMTPSA id v202sm3338708lfa.28.2019.07.17.01.37.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:37:06 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/4] mesh: Implement ImportLocalNode() method
Date:   Wed, 17 Jul 2019 10:36:49 +0200
Message-Id: <20190717083650.26346-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements ImportLocalNode() method of org.bluez.mesh.Network1
interface, allowing applications to create provisioned nodes based on
passed import data, without relying on external provisioner.
---
 mesh/mesh-config-json.c |  85 ++++++++++++++++++++++++++++++++
 mesh/mesh-config.h      |  10 ++++
 mesh/mesh-defs.h        |   3 ++
 mesh/mesh.c             |  90 +++++++++++++++++++++++++++++++++-
 mesh/net.h              |   2 -
 mesh/node.c             | 106 ++++++++++++++++++++++++++++++++++------
 mesh/node.h             |   5 ++
 7 files changed, 282 insertions(+), 19 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 6df7f7b3f..e80df19a5 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -472,6 +472,25 @@ static bool read_net_key(struct mesh_config_netkey *net_key,
 	return true;
 }
 
+static bool import_net_key(struct mesh_config_netkey *net_key,
+							void *user_data)
+{
+	struct mesh_config_import *import = user_data;
+
+	if (!net_key)
+		return false;
+
+	if (import->net_key.idx != UNUSED_KEY_IDX)
+		return false;
+
+	if (net_key->phase != KEY_REFRESH_PHASE_NONE)
+		return false;
+
+	memcpy(&import->net_key, net_key, sizeof(import->net_key));
+
+	return true;
+}
+
 static bool read_net_keys(json_object *jobj, read_net_key_cb cb,
 							void *user_data)
 {
@@ -2256,3 +2275,69 @@ void mesh_config_destroy(struct mesh_config *cfg)
 	/* Release node config object */
 	mesh_config_release(cfg);
 }
+
+
+struct mesh_config_import *mesh_config_import_create(const char *import_data)
+{
+	json_object *jobj = json_tokener_parse(import_data);
+	struct mesh_config_import *import = NULL;
+
+	if (!jobj || json_object_get_type(jobj) != json_type_object)
+		goto fail;
+
+	import = l_new(struct mesh_config_import, 1);
+	import->node = l_new(struct mesh_config_node, 1);
+	import->net_key.idx = UNUSED_KEY_IDX;
+
+	if (!read_device_key(jobj, import->dev_key)) {
+		l_error("Failed to parse imported device key");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "deviceKey");
+
+	if (!read_unicast_address(jobj, &import->node->unicast)) {
+		l_error("Failed to parse imported unicast");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "unicastAddress");
+
+	if (!read_iv_index(jobj, &import->iv_index,
+							&import->iv_update)) {
+		l_error("Failed to parse iv_index");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "IVindex");
+	json_object_object_del(jobj, "IVupdate");
+
+	if (!read_net_keys(jobj, import_net_key, import)) {
+		l_error("Failed to parse imported network key");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "netKeys");
+
+	if (!read_seq_number(jobj, &import->node->seq_number))
+		import->node->seq_number = DEFAULT_SEQUENCE_NUMBER;
+
+	json_object_object_del(jobj, "sequenceNumber");
+
+	if (json_object_object_length(jobj) != 0) {
+		l_error("Unexpected keys in import data");
+		goto fail;
+	}
+
+	return import;
+fail:
+	if (jobj)
+		json_object_put(jobj);
+
+	if (import) {
+		l_free(import->node);
+		l_free(import);
+	}
+
+	return NULL;
+}
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 44e3b3ad6..0061862b5 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -104,6 +104,15 @@ struct mesh_config_node {
 	uint8_t dev_key[16];
 	uint8_t token[8];
 };
+
+struct mesh_config_import {
+       struct mesh_config_node *node;
+       struct mesh_config_netkey net_key;
+       uint8_t dev_key[16];
+       uint32_t iv_index;
+       bool iv_update;
+};
+
 typedef void (*mesh_config_status_func_t)(void *user_data, bool result);
 typedef bool (*mesh_config_node_func_t)(struct mesh_config_node *node,
 							const uint8_t uuid[16],
@@ -119,6 +128,7 @@ bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 struct mesh_config *mesh_config_create(const char *cfg_path,
 						const uint8_t uuid[16],
 						struct mesh_config_node *node);
+struct mesh_config_import *mesh_config_import_create(const char *import_data);
 
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval);
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 1a199f156..79b38c56c 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -37,6 +37,7 @@
 #define KEY_REFRESH_PHASE_THREE	0x03
 
 #define DEFAULT_TTL		0xff
+#define DEFAULT_SEQUENCE_NUMBER	0
 
 /* Supported algorithms for provisioning */
 #define ALG_FIPS_256_ECC	0x0001
@@ -76,6 +77,8 @@
 
 #define PRIMARY_NET_IDX		0x0000
 #define MAX_KEY_IDX		0x0fff
+#define UNUSED_KEY_IDX		0xffff
+
 #define MAX_MODEL_COUNT		0xff
 #define MAX_ELE_COUNT		0xff
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 9c6b9a70e..ca268e4c9 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -33,6 +33,7 @@
 #include "mesh/error.h"
 #include "mesh/agent.h"
 #include "mesh/mesh.h"
+#include "mesh/mesh-config.h"
 
 /*
  * The default values for mesh configuration. Can be
@@ -69,6 +70,10 @@ struct join_data{
 	uint8_t *uuid;
 };
 
+static const char * const supported_import_data_types[] = {
+	"json"
+};
+
 static struct bt_mesh mesh;
 
 /* We allow only one outstanding Join request */
@@ -383,6 +388,18 @@ fail:
 	free_pending_join_call(true);
 }
 
+static bool validate_data_type(const char *data_type)
+{
+	uint8_t idx = 0;
+	uint8_t len = L_ARRAY_SIZE(supported_import_data_types);
+
+	for (idx = 0; idx < len; idx++) {
+		if (strcmp(data_type, supported_import_data_types[idx]) == 0)
+			return true;
+	}
+	return false;
+}
+
 static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -536,7 +553,7 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_network_ready_cb(void *user_data, int status,
+static void create_node_ready_cb(void *user_data, int status,
 							struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
@@ -593,12 +610,74 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 
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
+	struct mesh_config_import *import;
+	const char *data_type, *import_data;
+	uint8_t *uuid;
+	uint32_t n;
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
+	import = mesh_config_import_create(import_data);
+
+	if (!import)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+						"Failed to parse import_data");
+
+	sender = l_dbus_message_get_sender(msg);
+	pending_msg = l_dbus_message_ref(msg);
+
+	if (!pending_queue)
+		pending_queue = l_queue_new();
+
+	l_queue_push_tail(pending_queue, pending_msg);
+
+	if (!node_import(app_path, sender, import, uuid, create_node_ready_cb,
+								pending_msg))
+		goto fail;
+
+	return NULL;
+
+fail:
+	l_free(import);
+	l_dbus_message_unref(msg);
+	l_queue_remove(pending_queue, pending_msg);
+	return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Node import failed");
+}
+
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
@@ -612,8 +691,15 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 
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
diff --git a/mesh/net.h b/mesh/net.h
index 8848e6df0..7e6af8714 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -26,8 +26,6 @@ struct mesh_node;
 
 #define DEV_ID	0
 
-#define UNUSED_KEY_IDX	0xffff
-
 #define APP_ID_DEV	0
 #define APP_ID_ANY	((unsigned int) -1)
 #define NET_ID_ANY	(APP_ID_ANY - 1)
diff --git a/mesh/node.c b/mesh/node.c
index 652551756..d1b37a5da 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -56,11 +56,13 @@
 #define DEFAULT_LOCATION 0x0000
 
 #define DEFAULT_CRPL 10
-#define DEFAULT_SEQUENCE_NUMBER 0
 
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
@@ -112,8 +114,9 @@ struct mesh_node {
 struct managed_obj_request {
 	void *data;
 	void *cb;
-	void *user_data;
-	uint8_t type;
+	struct l_dbus_message *pending_msg;
+	enum request_type type;
+	struct mesh_config_import *import;
 };
 
 static struct l_queue *nodes;
@@ -1568,14 +1571,13 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
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
@@ -1652,7 +1654,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 			node->disc_watch = l_dbus_add_disconnect_watch(bus,
 					node->owner, app_disc_cb, node, NULL);
-			cb(req->user_data, MESH_ERROR_NONE, node);
+			cb(req->pending_msg, MESH_ERROR_NONE, node);
 		} else
 			goto fail;
 
@@ -1674,6 +1676,51 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 		cb(node, agent);
 
+	} else if (req->type == REQUEST_TYPE_IMPORT) {
+
+		node_ready_func_t cb = req->cb;
+		struct mesh_config_import *import = req->import;
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
+		if (node->seq_number != import->node->seq_number)
+			node->seq_number = import->node->seq_number;
+
+		memcpy(node->uuid, req->data, 16);
+
+		if (!create_node_config(node, node->uuid))
+			goto fail;
+
+		if (!add_local_node(node, import->node->unicast, false,
+					import->iv_update, import->iv_index,
+					import->dev_key, import->net_key.idx,
+					import->net_key.key))
+			goto fail;
+
+		memcpy(net_key.old_key, import->net_key.key, 16);
+		net_key.net_idx = import->net_key.idx;
+		net_key.phase = KEY_REFRESH_PHASE_NONE;
+
+		/* Initialize directory for storing keyring info */
+		init_storage_dir(node);
+
+		if (!keyring_put_remote_dev_key(node, import->node->unicast,
+						num_ele, import->dev_key))
+			goto fail;
+
+		if (!keyring_put_net_key(node, import->net_key.idx, &net_key))
+			goto fail;
+
+		cb(req->pending_msg, MESH_ERROR_NONE, node);
+
 	} else {
 		/* Callback for create node request */
 		node_ready_func_t cb = req->cb;
@@ -1709,7 +1756,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-		cb(req->user_data, MESH_ERROR_NONE, node);
+		cb(req->pending_msg, MESH_ERROR_NONE, node);
 	}
 
 	return;
@@ -1723,9 +1770,9 @@ fail:
 
 		free_node_dbus_resources(node);
 
-		cb(req->user_data, MESH_ERROR_FAILED, node);
+		cb(req->pending_msg, MESH_ERROR_FAILED, node);
 	} else {
-		/* Handle failed Join and Create requests */
+		/* Handle failed Join, Create and Import requests */
 		if (node)
 			node_remove(node);
 
@@ -1736,7 +1783,7 @@ fail:
 		} else {
 			node_ready_func_t cb = req->cb;
 
-			cb(req->user_data, MESH_ERROR_FAILED, NULL);
+			cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
 		}
 	}
 }
@@ -1764,7 +1811,7 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	req = l_new(struct managed_obj_request, 1);
 	req->data = node;
 	req->cb = cb;
-	req->user_data = user_data;
+	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_ATTACH;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
@@ -1797,6 +1844,35 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 					req, l_free);
 }
 
+bool node_import(const char *app_path, const char *sender,
+				struct mesh_config_import *import,
+				const uint8_t *uuid, node_ready_func_t cb,
+				void *user_data)
+{
+	struct managed_obj_request *req;
+
+	l_debug("");
+
+	/* TODO: implement full import */
+	if (import->node->elements)
+		return false;
+
+	req = l_new(struct managed_obj_request, 1);
+
+	req->data = (void *) uuid;
+	req->cb = cb;
+	req->pending_msg = user_data;
+	req->import = import;
+	req->type = REQUEST_TYPE_IMPORT;
+
+	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+						L_DBUS_INTERFACE_OBJECT_MANAGER,
+						"GetManagedObjects", NULL,
+						get_managed_objects_cb,
+						req, l_free);
+	return true;
+}
+
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
@@ -1807,7 +1883,7 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 	req = l_new(struct managed_obj_request, 1);
 	req->data = (void *) uuid;
 	req->cb = cb;
-	req->user_data = user_data;
+	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
diff --git a/mesh/node.h b/mesh/node.h
index 56ca796cd..fad034f42 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -23,6 +23,7 @@ struct mesh_io;
 struct mesh_agent;
 struct mesh_config;
 struct mesh_config_node;
+struct mesh_config_import;
 
 /* To prevent local node JSON cache thrashing, minimum update times */
 #define MIN_SEQ_TRIGGER	32
@@ -95,6 +96,10 @@ void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
+bool node_import(const char *app_path, const char *sender,
+				struct mesh_config_import *import,
+				const uint8_t *uuid, node_ready_func_t cb,
+				void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
-- 
2.19.1

