Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2D1C433FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A135F206DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="k5kjnUW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfG2NlA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:41:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36992 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfG2NlA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 09:41:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so4388335ljn.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yg6rBtWavRZTaKQ4UeBo4YUT6l3tGnzIfQDlwSgoKpg=;
        b=k5kjnUW2XZYLhtYYY54E/n2Yy0OOVnUsyqvgY2ES67PZfw2XdKDAOkr9jtOXi1yraG
         bsf+nL9VJOqCnGswt7/3e4X7aA5cN3ya8iR2ZhTl0JSQBaLdFt/yUyTTHAZRBSF6AzoY
         s7+8s8EXy9zCSvBkmRWKVsHOrYWIslmAybXDqQvh2ngxsO3wK2InC/g0JcXA5OT5ZPSq
         HYRKUo6xHI3xjRiEluGLe8Q42/x5bRQIsJ9gSi036XWI3MClmwHKW+na3WqovjzlNV4D
         UNkSitAwRD2IMgbDjKIceQONycli90OeFnBzpJjrmTd4NN71LvVkyfJM2gGzZMpsub7b
         GkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yg6rBtWavRZTaKQ4UeBo4YUT6l3tGnzIfQDlwSgoKpg=;
        b=QNdUbbdmyZI7e8EDNSUXhJNTEZccgsNDDp8lTC1vYe61dtPtw0B0bEU5zRT5uSALMX
         Tvpbm7T/o+hVDcsfWUEjVVbBcGkRKCpBczoodLEOQdRfOHOf4LIvjBwsXa6RRaucHJL1
         qUtbKTjcT/f4l4eh6cv4sjcE2Axw0zdHr9T+96AWBwReWzFecuuoIb6VSSqD+X/0cZ0n
         yvBhWP6pz5P7vGrF/kdu8Doqf32w+h1V4OKnRX4h9lYBRecoPgcZeKlzD6Ci4wOACD/z
         eE+0ncQ+15HpGm7Cbs4FSIh6sKACk2j2PWFRG654qsl/D+ZSBppFHMdKW4bRSjNU6z+2
         4z1w==
X-Gm-Message-State: APjAAAX/QKzGQyA6YOYogIctUfOtErmmS4KUn1Gk7uvlV4X+mva2ijXx
        zECM80znthJq2d+2qYSJgwl5FKB/IMQ=
X-Google-Smtp-Source: APXvYqyXQtEzusOTW3gCJGfHAEY9O+nxMYz+kRqS7BcU2X+jTheQcssO0N0pbtWe0X+7OB+Y6IYGOA==
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr18669114lja.238.1564407656703;
        Mon, 29 Jul 2019 06:40:56 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h84sm12762220ljf.42.2019.07.29.06.40.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:40:56 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 3/3] mesh: Implement Import() D-Bus API of org.bluez.mesh.Network1 interface
Date:   Mon, 29 Jul 2019 15:40:47 +0200
Message-Id: <20190729134047.21033-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
References: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This method allows local nodes to be imported from an external
provisioning database, enabling applications to create mesh nodes
without using provisioning procedure.

The procedure is similar to provisioning procedure, but all data
exchange happens over D-Bus.
---
 mesh/mesh.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 mesh/node.c |  87 ++++++++++++++++++++++++++++++++++++++-
 mesh/node.h |   5 +++
 3 files changed, 204 insertions(+), 3 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 9c6b9a70e..b660a7ef2 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -33,6 +33,7 @@
 #include "mesh/error.h"
 #include "mesh/agent.h"
 #include "mesh/mesh.h"
+#include "mesh/mesh-defs.h"
 
 /*
  * The default values for mesh configuration. Can be
@@ -536,7 +537,7 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_network_ready_cb(void *user_data, int status,
+static void create_node_ready_cb(void *user_data, int status,
 							struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
@@ -593,12 +594,114 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	node_create(app_path, sender, uuid, create_network_ready_cb,
+	node_create(app_path, sender, uuid, create_node_ready_cb,
 								pending_msg);
 
 	return NULL;
 }
 
+static struct l_dbus_message *import_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	const char *app_path, *sender;
+	struct l_dbus_message *pending_msg = NULL;
+	struct l_dbus_message_iter iter_uuid;
+	struct l_dbus_message_iter iter_dev_key;
+	struct l_dbus_message_iter iter_net_key;
+	struct l_dbus_message_iter iter_flags;
+	const char *key;
+	struct l_dbus_message_iter var;
+
+	uint8_t *uuid;
+	uint8_t *dev_key;
+	uint8_t *net_key;
+	uint16_t net_idx;
+	bool kr = false;
+	bool ivu = false;
+	uint32_t iv_index;
+	uint16_t unicast;
+	uint32_t n;
+
+	l_debug("Import local node request");
+
+	if (!l_dbus_message_get_arguments(msg, "oayayayqa{sv}uq",
+						&app_path, &iter_uuid,
+						&iter_dev_key, &iter_net_key,
+						&net_idx, &iter_flags,
+						&iv_index,
+						&unicast))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n) ||
+									n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad dev UUID");
+
+	if (node_find_by_uuid(uuid))
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
+							"Node already exists");
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_dev_key, &dev_key, &n) ||
+									n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad dev key");
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_net_key, &net_key, &n) ||
+									n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad net key");
+
+	if (net_idx > MAX_KEY_IDX)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad net index");
+
+	while (l_dbus_message_iter_next_entry(&iter_flags, &key, &var)) {
+		if (!strcmp(key, "IVUpdate")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b",
+								&ivu))
+				goto fail;
+			continue;
+		}
+
+		if (!strcmp(key, "KeyRefresh")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b",
+								&kr))
+				goto fail;
+			continue;
+		}
+
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad flags");
+	}
+
+	if (!IS_UNICAST(unicast))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad address");
+
+	sender = l_dbus_message_get_sender(msg);
+	pending_msg = l_dbus_message_ref(msg);
+
+	if (!pending_queue)
+		pending_queue = l_queue_new();
+
+	l_queue_push_tail(pending_queue, pending_msg);
+
+	if (!node_import(app_path, sender, uuid, dev_key, net_key, net_idx,
+					kr, ivu, iv_index, unicast,
+					create_node_ready_cb, pending_msg))
+		goto fail;
+
+	return NULL;
+
+fail:
+	if (pending_msg) {
+		l_dbus_message_unref(msg);
+		l_queue_remove(pending_queue, pending_msg);
+	}
+
+	return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Node import failed");
+}
+
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
@@ -612,8 +715,16 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 
 	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
 								"token");
+
 	l_dbus_interface_method(iface, "CreateNetwork", 0, create_network_call,
 					"t", "oay", "token", "app", "uuid");
+
+	l_dbus_interface_method(iface, "Import", 0,
+					import_call,
+					"t", "oayayayqa{sv}uq", "token",
+					"app", "uuid", "dev_key", "net_key",
+					"net_index", "flags", "iv_index",
+					"unicast");
 }
 
 bool mesh_dbus_init(struct l_dbus *dbus)
diff --git a/mesh/node.c b/mesh/node.c
index 579e69892..bff73cfc7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -62,6 +62,7 @@ enum request_type {
 	REQUEST_TYPE_JOIN,
 	REQUEST_TYPE_ATTACH,
 	REQUEST_TYPE_CREATE,
+	REQUEST_TYPE_IMPORT,
 };
 
 struct node_element {
@@ -111,6 +112,19 @@ struct mesh_node {
 	uint8_t beacon;
 };
 
+struct node_import {
+	uint8_t dev_key[16];
+
+	uint8_t net_key[16];
+	uint16_t net_idx;
+	struct {
+		bool ivu;
+		bool kr;
+	} flags;
+	uint32_t iv_index;
+	uint16_t unicast;
+};
+
 struct managed_obj_request {
 	struct mesh_node *node;
 	union {
@@ -121,6 +135,7 @@ struct managed_obj_request {
 	enum request_type type;
 	union {
 		struct mesh_node *attach;
+		struct node_import *import;
 	};
 };
 
@@ -1712,6 +1727,36 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
+	} else if (req->type == REQUEST_TYPE_IMPORT) {
+		struct node_import *import = req->import;
+		struct keyring_net_key net_key;
+
+		if (!create_node_config(node, node->uuid))
+			goto fail;
+
+		if (!add_local_node(node, import->unicast, import->flags.kr,
+					import->flags.ivu,
+					import->iv_index, import->dev_key,
+					import->net_idx, import->net_key))
+			goto fail;
+
+		memcpy(net_key.old_key, import->net_key, 16);
+		net_key.net_idx = import->net_idx;
+		if (import->flags.kr)
+			net_key.phase = KEY_REFRESH_PHASE_TWO;
+		else
+			net_key.phase = KEY_REFRESH_PHASE_NONE;
+
+		/* Initialize directory for storing keyring info */
+		init_storage_dir(node);
+
+		if (!keyring_put_remote_dev_key(node, import->unicast,
+						num_ele, import->dev_key))
+			goto fail;
+
+		if (!keyring_put_net_key(node, import->net_idx, &net_key))
+			goto fail;
+
 	} else {
 		/* Callback for create node request */
 		struct keyring_net_key net_key;
@@ -1749,7 +1794,8 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	else
 		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 
-	return;
+	goto done;
+
 fail:
 	if (agent)
 		mesh_agent_remove(agent);
@@ -1762,6 +1808,10 @@ fail:
 		req->join_ready_cb(NULL, NULL);
 	else
 		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
+
+done:
+	if (req->type == REQUEST_TYPE_IMPORT)
+		l_free(req->import);
 }
 
 /* Establish relationship between application and mesh node */
@@ -1825,6 +1875,41 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 					req, l_free);
 }
 
+bool node_import(const char *app_path, const char *sender, const uint8_t *uuid,
+			const uint8_t dev_key[16], const uint8_t net_key[16],
+			uint16_t net_idx, bool kr, bool ivu,
+			uint32_t iv_index, uint16_t unicast,
+			node_ready_func_t cb, void *user_data)
+{
+	struct managed_obj_request *req;
+
+	l_debug("");
+
+	req = l_new(struct managed_obj_request, 1);
+
+	req->node = node_new(uuid);
+	req->ready_cb = cb;
+	req->pending_msg = user_data;
+
+	req->import = l_new(struct node_import, 1);
+	memcpy(req->import->dev_key, dev_key, 16);
+	memcpy(req->import->net_key, net_key, 16);
+	req->import->net_idx = net_idx;
+	req->import->flags.kr = kr;
+	req->import->flags.ivu = ivu;
+	req->import->iv_index = iv_index;
+	req->import->unicast = unicast;
+
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
diff --git a/mesh/node.h b/mesh/node.h
index 56ca796cd..a4cac028d 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -95,6 +95,11 @@ void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
+bool node_import(const char *app_path, const char *sender, const uint8_t *uuid,
+			const uint8_t dev_key[16], const uint8_t net_key[16],
+			uint16_t net_idx, bool kr, bool ivu,
+			uint32_t iv_index, uint16_t unicast,
+			node_ready_func_t cb, void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
-- 
2.19.1

