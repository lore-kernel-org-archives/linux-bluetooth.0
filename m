Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25AC46499
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9C21721
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="iWcCaB13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfGEPW3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:22:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41647 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfGEPW3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 11:22:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so515509ljg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2d/FddCawfHLWHJSjk2R+8XBD5LNZXDuh8Odx/dOTY=;
        b=iWcCaB13sk0am3aLJVcy4gCyMshLIeJmq/VZOe15K8XCXzds3hJk+K7bIMFNJkUUG0
         2GgrQfggLs5CLZBrCX7NYD4h9aqX/UfbZFVIugVfRKOgFUorf2jvHrKKRVLuXpAfbD3h
         ZF1lm7hFLSMe4A2+TfXs1Hz4U+ze7WpMiN+CLt/9BPPaDTj9+dTRp3+lUFq7Rv/lHRmq
         sT6gwtbEeYcEjEzh9c4FJ5EPH8wB2qD9GK+FsTBTaaM285e8kh+IVpmu1klE4BS8mHOl
         Yx+4Z8ZhQqKcsqJi7gz+eFXom6mb4qsxMpinDNjQKOM9tp+mPNFycnbjPzYxLh4S4Li/
         gjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2d/FddCawfHLWHJSjk2R+8XBD5LNZXDuh8Odx/dOTY=;
        b=A11XBeOxex+I1f98MWfeEzyUtEoATULkqgm9ef7+YiYswGw3ykexWrNXltzAbdnHpp
         1QNFZHkIDNJYOd7FCVMoOsEznvp4oYjgHWdvmM7SqgT3NDkrh4VCLi8n+GF4U0kj0jFC
         6mY91uQY3v73SxFezO93hglLbdRLh7bSjZUZvDy8qRPyPyZ6/O+ba1kPo3yTfQkc2VuS
         Bs95CrjGXYURiLjNoPQBsgWInVtBFJPoPfnmslFzvnltCsYssvonAcGCA1uwyyiNbZGy
         6gIJlFQzdTIzH2UKUsFqu//SlRZLSG0Fwd2WsuSYpMDPkgYE6Ku6pXvEOD7nmqBu3oRT
         N5bQ==
X-Gm-Message-State: APjAAAUSsw6pzYDL8ViwVhm6Ls1BQm4Gtm5HgHbqkt87jifPCQ4fC8c+
        y0/SVbhU2hAXb0mutFcZT0/XNi8w0Kf8xw==
X-Google-Smtp-Source: APXvYqyULOLI5Mp2W+bOJqHE3LP0ly6+jus6rtDkEPUjU1v1jiK0E+eC43yfvHyczB9TvFgAaI9kEA==
X-Received: by 2002:a2e:7614:: with SMTP id r20mr2535908ljc.42.1562340146310;
        Fri, 05 Jul 2019 08:22:26 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u22sm2016989ljd.18.2019.07.05.08.22.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 08:22:25 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 3/3] mesh: Separate json type from the node.c file
Date:   Fri,  5 Jul 2019 17:22:16 +0200
Message-Id: <20190705152216.27766-3-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705152216.27766-1-jakub.witowski@silvair.com>
References: <20190705152216.27766-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This creates intermediate layer between imported node data and parser.
---
 mesh/mesh-db.c | 147 ++++++++++++++++++++++++++++++++++++-
 mesh/mesh-db.h |  11 +++
 mesh/mesh.c    |  31 +++++---
 mesh/node.c    | 193 ++++++++++---------------------------------------
 mesh/node.h    |   3 +-
 5 files changed, 215 insertions(+), 170 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index e0a000261..0e8f40470 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -31,7 +31,7 @@
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
-
+#include "mesh/node.h"
 #include "mesh/mesh-db.h"
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
@@ -253,6 +253,118 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
+static bool parse_imported_unicast_addr(json_object *jobj, uint16_t *unicast)
+{
+	char *str = (char *)json_object_get_string(jobj);
+
+	if (sscanf(str, "%04hx", unicast) != 1)
+		return false;
+
+	return true;
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
+static uint32_t parse_imported_sequence(json_object *jobj,
+							uint32_t default_seq_nr)
+{
+	json_object *jvalue;
+
+	if (json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+		return (uint32_t) json_object_get_int(jvalue);
+	else
+		return default_seq_nr;
+}
+
+static bool json_iter(json_object *jobj, struct mesh_db_import *db_node)
+{
+	bool dev_key = false, unicast = false;
+	bool iv_index = false, net_key = false;
+
+	json_object_object_foreach(jobj, key, val) {
+
+		if (!strcmp(key, "deviceKey")) {
+
+			dev_key = true;
+			if (!mesh_db_read_device_key(jobj, db_node->dev_key)) {
+				l_error("Failed to parse imported device key");
+				return false;
+			}
+
+		} else if (!strcmp(key, "unicastAddress")) {
+
+			unicast = true;
+			if (!parse_imported_unicast_addr(val,
+						&db_node->node->unicast)) {
+				l_error("Failed to parse imported unicast");
+				return false;
+			}
+
+		} else if (!strcmp(key, "IVindex")) {
+
+			iv_index = true;
+			if (!mesh_db_read_iv_index(jobj, &db_node->iv_index,
+							&db_node->iv_update)) {
+				l_error("Failed to parse iv_index");
+				return false;
+			}
+
+		} else if (!strcmp(key, "netKeys")) {
+
+			net_key = true;
+			if (!parse_imported_net_key(val, db_node->net_key,
+							&db_node->net_idx)) {
+				l_error("Failed to parse imported network key");
+				return false;
+			}
+
+		} else {
+			if (strcmp(key, "sequenceNumber") &&
+							strcmp(key, "IVupdate"))
+				return false;
+		}
+	}
+
+	return dev_key && unicast && net_key && iv_index;
+}
+
 bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
@@ -1438,7 +1550,8 @@ static void add_model(void *a, void *b)
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
+bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
+{
 
 	struct mesh_db_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
@@ -1783,3 +1896,33 @@ bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
 
 	return delete_model_property(jnode, addr, mod_id, vendor, "subscribe");
 }
+
+
+
+struct mesh_db_import *mesh_db_parse_import_data(const char *import_data)
+{
+	json_object *jobj = json_tokener_parse(import_data);
+	struct mesh_db_import *db_node = l_new(struct mesh_db_import, 1);
+
+	if (!jobj)
+		goto fail;
+
+	db_node->node = l_new(struct mesh_db_node, 1);
+
+	if (!json_iter(jobj, db_node))
+		goto fail;
+
+	db_node->node->seq_number =
+			parse_imported_sequence(jobj, DEFAULT_SEQUENCE_NUMBER);
+
+	return db_node;
+fail:
+	if (jobj)
+		json_object_put(jobj);
+
+	if (db_node->node)
+		l_free(db_node->node);
+
+	l_free(db_node);
+	return NULL;
+}
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index da5efa12a..a227319ca 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -16,6 +16,7 @@
  *  Lesser General Public License for more details.
  *
  */
+#include <json-c/json.h>
 
 struct mesh_db_sub {
 	bool virt;
@@ -93,6 +94,15 @@ struct mesh_db_prov {
 	uint8_t priv_key[32];
 };
 
+struct mesh_db_import {
+	struct mesh_db_node *node;
+	uint8_t dev_key[16];
+	uint8_t net_key[16];
+	uint16_t net_idx;
+	uint32_t iv_index;
+	bool iv_update;
+};
+
 typedef bool (*mesh_db_net_key_cb)(uint16_t idx, uint8_t key[16],
 			uint8_t new_key[16], int phase, void *user_data);
 typedef bool (*mesh_db_app_key_cb)(uint16_t idx, uint16_t net_idx,
@@ -155,3 +165,4 @@ bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase);
 bool mesh_db_write_address(json_object *jobj, uint16_t address);
 bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update);
 void mesh_db_remove_property(json_object *jobj, const char *desc);
+struct mesh_db_import *mesh_db_parse_import_data(const char *import_data);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index b3def7817..6234121c9 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -22,7 +22,6 @@
 #endif
 
 #define _GNU_SOURCE
-#include <json-c/json.h>
 #include <string.h>
 #include <ell/ell.h>
 
@@ -36,6 +35,7 @@
 #include "mesh/error.h"
 #include "mesh/agent.h"
 #include "mesh/mesh.h"
+#include "mesh/mesh-db.h"
 
 /*
  * The default values for mesh configuration. Can be
@@ -391,10 +391,10 @@ fail:
 
 static bool validate_data_type(const char *data_type)
 {
-	uint8_t len = sizeof(supported_import_data_types) /
-					sizeof(supported_import_data_types[0]);
+	uint8_t idx = 0;
+	uint8_t len = L_ARRAY_SIZE(supported_import_data_types);
 
-	for (uint8_t idx = 0; idx < len; idx++) {
+	for (idx = 0; idx < len; idx++) {
 		if (strcmp(data_type, supported_import_data_types[idx]) == 0)
 			return true;
 	}
@@ -624,10 +624,10 @@ static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
 	const char *app_path, *sender;
 	struct l_dbus_message *pending_msg;
 	struct l_dbus_message_iter iter_uuid, iter_import_data;
+	struct mesh_db_import *p_node;
 	const char *data_type, *import_data;
 	uint8_t *uuid;
 	uint32_t n;
-	struct json_object *jnode;
 
 	l_debug("Import local node request");
 
@@ -652,7 +652,11 @@ static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad import_data");
 
-	jnode = json_tokener_parse(import_data);
+	p_node = mesh_db_parse_import_data(import_data);
+
+	if (!p_node)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+						"Failed to parse import_data");
 
 	sender = l_dbus_message_get_sender(msg);
 	pending_msg = l_dbus_message_ref(msg);
@@ -662,14 +666,17 @@ static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
 
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	if (!node_import(app_path, sender, jnode, uuid, create_node_ready_cb,
-								pending_msg)) {
-		l_dbus_message_unref(msg);
-		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
-							"Node import failed");
-	}
+	if (!node_import(app_path, sender, p_node, uuid, create_node_ready_cb,
+								pending_msg))
+		goto fail;
 
 	return NULL;
+
+fail:
+	l_free(p_node);
+	l_dbus_message_unref(msg);
+	l_queue_remove(pending_queue, pending_msg);
+	return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Node import failed");
 }
 
 static void setup_network_interface(struct l_dbus_interface *iface)
diff --git a/mesh/node.c b/mesh/node.c
index 00c3270fd..db04c0c87 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -26,8 +26,6 @@
 #include <sys/time.h>
 
 #include <ell/ell.h>
-#include <json-c/json.h>
-#include <stdio.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
@@ -56,7 +54,6 @@
 #define DEFAULT_LOCATION 0x0000
 
 #define DEFAULT_CRPL 10
-#define DEFAULT_SEQUENCE_NUMBER 0
 
 enum request_type {
 	REQUEST_TYPE_JOIN = 0,
@@ -119,13 +116,7 @@ struct managed_obj_request {
 
 struct node_import_request {
 	uint8_t uuid[16];
-	uint8_t dev_key[16];
-	uint8_t net_key[16];
-	uint16_t net_idx;
-	uint16_t unicast;
-	uint32_t iv_idx;
-	bool iv_update;
-	uint32_t sequence;
+	struct mesh_db_import *import;
 	void *user_data;
 };
 
@@ -885,8 +876,7 @@ element_done:
 
 #define MIN_COMPOSITION_LEN 16
 
-bool node_parse_composition(struct mesh_node *node, uint8_t *data,
-			    uint16_t len)
+bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 {
 	struct node_composition *comp;
 	uint16_t features;
@@ -981,7 +971,7 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data,
 			vendor_id = l_get_le16(data);
 			mod_id |= (vendor_id << 16);
 			mod = mesh_model_vendor_new(ele->idx, vendor_id,
-						    mod_id);
+									mod_id);
 			if (!mod) {
 				element_free(ele);
 				goto fail;
@@ -1012,6 +1002,7 @@ fail:
 
 	return false;
 }
+
 static void attach_io(void *a, void *b)
 {
 	struct mesh_node *node = a;
@@ -1400,82 +1391,6 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 	return true;
 }
 
-static bool parse_imported_unicast_addr(json_object *jobj, uint16_t *unicast)
-{
-	char *str;
-
-	str = (char *)json_object_get_string(jobj);
-
-	if (sscanf(str, "%04hx", unicast) != 1)
-		return false;
-
-	return true;
-}
-
-static bool parse_imported_device_key(json_object *jobj, uint8_t key_buf[16])
-{
-	char *str;
-
-	if (!key_buf)
-		return false;
-
-	str = (char *)json_object_get_string(jobj);
-
-	if (!str2hex(str, strlen(str), key_buf, 16))
-		return false;
-
-	return true;
-}
-
-static void parse_imported_sequence_nr(json_object *jobj, uint32_t *seq)
-{
-	json_object *jvalue;
-
-	if (json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
-		*seq = (uint32_t) json_object_get_int(jvalue);
-	else
-		*seq = DEFAULT_SEQUENCE_NUMBER;
-}
-
-static bool parse_imported_net_key(json_object *jobj, uint8_t key_buf[16],
-							uint16_t *net_idx)
-{
-	json_object *jtemp, *jvalue;
-	char *str;
-	uint8_t key[16];
-
-	if (json_object_get_type(jobj) != json_type_array)
-		return false;
-
-	jtemp = json_object_array_get_idx(jobj, 0);
-
-	if (!json_object_object_get_ex(jtemp, "index", &jvalue))
-		return false;
-
-	*net_idx = (uint16_t)json_object_get_int(jvalue);
-
-	if (*net_idx > 4095)
-		return false;
-
-	if (!json_object_object_get_ex(jtemp, "key", &jvalue))
-		return false;
-
-	str = (char *)json_object_get_string(jvalue);
-	if (!str2hex(str, strlen(str), key, 16))
-		return false;
-
-	memcpy(&key_buf[0], &key[0], 16);
-
-	/* Imported node shouldn't contain oldKey or keyRefresh */
-	if (json_object_object_get_ex(jtemp, "oldKey", NULL))
-		return false;
-
-	if (json_object_object_get_ex(jtemp, "keyRefresh", NULL))
-		return false;
-
-	return true;
-}
-
 static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
 				uint16_t net_key_idx, uint8_t net_key[16])
@@ -1652,7 +1567,8 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	} else if (req->type == REQUEST_TYPE_IMPORT) {
 
 		node_ready_func_t cb = req->cb;
-		struct node_import_request *import_data = req->user_data;
+		struct node_import_request *import_req = req->user_data;
+		struct mesh_db_import *db_node = import_req->import;
 		struct keyring_net_key net_key;
 
 		if (!agent) {
@@ -1664,32 +1580,32 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		node->num_ele = num_ele;
 		set_defaults(node);
 
-		if (node->seq_number != import_data->sequence)
-			node->seq_number = import_data->sequence;
+		if (node->seq_number != db_node->node->seq_number)
+			node->seq_number = db_node->node->seq_number;
 
-		memcpy(node->uuid, import_data->uuid, 16);
+		memcpy(node->uuid, import_req->uuid, 16);
 
 		if (!create_node_config(node))
 			goto fail;
 
-		if (!add_local_node(node, import_data->unicast, false,
-				import_data->iv_update, import_data->iv_idx,
-				import_data->dev_key, import_data->net_idx,
-							import_data->net_key))
+		if (!add_local_node(node, db_node->node->unicast, false,
+					db_node->iv_update, db_node->iv_index,
+					db_node->dev_key, db_node->net_idx,
+					db_node->net_key))
 			goto fail;
 
-		memcpy(net_key.old_key, import_data->net_key, 16);
-		net_key.net_idx = import_data->net_idx;
+		memcpy(net_key.old_key, db_node->net_key, 16);
+		net_key.net_idx = db_node->net_idx;
 		net_key.phase = KEY_REFRESH_PHASE_NONE;
 
-		if (!keyring_put_remote_dev_key(node, import_data->unicast,
-						num_ele, import_data->dev_key))
+		if (!keyring_put_remote_dev_key(node, db_node->node->unicast,
+						num_ele, db_node->dev_key))
 			goto fail;
 
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-		cb(import_data->user_data, MESH_ERROR_NONE, node);
+		cb(import_req->user_data, MESH_ERROR_NONE, node);
 
 	} else {
 		/* Callback for create node request */
@@ -1749,11 +1665,10 @@ fail:
 			cb(NULL, NULL);
 
 		} else if (req->type == REQUEST_TYPE_IMPORT) {
-			struct node_import_request *import_data =
-								req->user_data;
+			struct node_import_request *import_req = req->user_data;
 			node_ready_func_t cb = req->cb;
 
-			cb(import_data->user_data, MESH_ERROR_FAILED, NULL);
+			cb(import_req->user_data, MESH_ERROR_FAILED, NULL);
 
 		} else {
 			node_ready_func_t cb = req->cb;
@@ -1820,58 +1735,29 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 }
 
 static bool node_import_full(const char *app_path, const char *sender,
-					void *json_data, const uint8_t *uuid,
+					struct mesh_db_import *db_node,
+					const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
 	return false;
 }
 
 static bool node_import_simplified(const char *app_path, const char *sender,
-					void *json_data, const uint8_t *uuid,
+					struct mesh_db_import *db_node,
+					const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
 	struct managed_obj_request *req = l_new(struct managed_obj_request, 1);
-	struct node_import_request *node = l_new(struct node_import_request, 1);
-
-	json_object_object_foreach(json_data, key, val) {
-
-		if (!strcmp(key, "deviceKey")) {
-			if (!parse_imported_device_key(val, node->dev_key)) {
-				l_error("Failed to parse imported device key");
-				goto fail;
-			}
-
-		} else if (!strcmp(key, "unicastAddress")) {
-			if (!parse_imported_unicast_addr(val, &node->unicast)) {
-				l_error("Failed to parse imported unicast");
-				goto fail;
-			}
+	struct node_import_request *import_req =
+					l_new(struct node_import_request, 1);
 
-		} else if (!strcmp(key, "IVindex")) {
-			node->iv_idx = (uint32_t) json_object_get_int(val);
-
-		} else if (!strcmp(key, "IVupdate")) {
-			node->iv_update = (bool) json_object_get_int(val);
-
-		} else if (!strcmp(key, "netKeys")) {
-			if (!parse_imported_net_key(val,
-					node->net_key, &node->net_idx)) {
-				l_error("Failed to parse imported network key");
-				goto fail;
-			}
-
-		} else {
-			if (strcmp(key, "sequenceNumber"))
-				goto fail;
-		}
-	}
-
-	parse_imported_sequence_nr(json_data, &node->sequence);
-	node->user_data = user_data;
+	l_debug("");
+	import_req->user_data = user_data;
+	import_req->import = db_node;
+	memcpy(import_req->uuid, uuid, 16);
 
-	memcpy(node->uuid, uuid, 16);
 	req->data = (void *) uuid;
-	req->user_data = node;
+	req->user_data = import_req;
 	req->cb = cb;
 	req->type = REQUEST_TYPE_IMPORT;
 
@@ -1881,21 +1767,18 @@ static bool node_import_simplified(const char *app_path, const char *sender,
 						get_managed_objects_cb,
 						req, l_free);
 	return true;
-
-fail:
-	json_object_put(json_data);
-	l_free(node);
-	return false;
 }
 
-bool node_import(const char *app_path, const char *sender, void *json_data,
+bool node_import(const char *app_path, const char *sender, void *import,
 		const uint8_t *uuid, node_ready_func_t cb, void *user_data)
 {
-	if (!json_object_object_get_ex(json_data, "elements", NULL))
-		return node_import_simplified(app_path, sender, json_data,
-							uuid, cb, user_data);
+	struct mesh_db_import *db_node = (struct mesh_db_import *)import;
+
+	if (!db_node->node->elements)
+		return node_import_simplified(app_path, sender, db_node, uuid,
+								cb, user_data);
 	else
-		return node_import_full(app_path, sender, json_data, uuid,
+		return node_import_full(app_path, sender, db_node, uuid,
 								cb, user_data);
 }
 
diff --git a/mesh/node.h b/mesh/node.h
index 9559f9178..7f1093df7 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -26,6 +26,7 @@ struct mesh_agent;
 #define MIN_SEQ_TRIGGER	32
 #define MIN_SEQ_CACHE		(2*MIN_SEQ_TRIGGER)
 #define MIN_SEQ_CACHE_TIME	(5*60)
+#define DEFAULT_SEQUENCE_NUMBER 0
 
 typedef void (*node_ready_func_t) (void *user_data, int status,
 							struct mesh_node *node);
@@ -91,7 +92,7 @@ void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
-bool node_import(const char *app_path, const char *sender, void *jnode,
+bool node_import(const char *app_path, const char *sender, void *import,
 		const uint8_t *uuid, node_ready_func_t cb, void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
-- 
2.20.1

