Return-Path: <SRS0=cJ+v=UN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6382BC31E4B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E92133D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="WRq3MPtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfFNMpW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:45:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34595 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfFNMpW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jun 2019 08:45:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so2289432ljg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2019 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kc3Rurul8chfYe//wD10uTREq+SE7ba6Gqc7Zgukrmc=;
        b=WRq3MPtRgXHpKuBxSWJhLjb3JgVZ9A4omeQxxKBzonGUXuqoo/hpatn0HErmgIpsSx
         iQqhvOqEYU5B0Oj+TkV+sNVt+j/zZjnC3uR+Z+qKWzVw2oTUBtfUg2lfq69sVM1hzCKF
         F76syyU27zt84gXGIegKU9oCLGeTsJFlbpGIIvfLu+0Ri89AucYmZcfaq5NC0Fz/c7cq
         AiY2nF65Q9s4JX8vhUkEwGO2KP98TitxPUI+xFh+OsXtKz4ykbCIG2bYCAjPi3nnyT+0
         uHuX+NAi8q8qEvu86cS52damH46plwIzPAW9fOlLbVCR++zwm6QAh6fVKjSfu7s0bzGS
         VVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kc3Rurul8chfYe//wD10uTREq+SE7ba6Gqc7Zgukrmc=;
        b=YlibNJ3NB03FE4TtkCKYMun14apaFPHIZ42z/xRXPO7Tq8C0rp0+IS4e0majal+oNZ
         v604YnFkF5x6aDmnxwMglBcOc2kE0MSnl2u9XbBvu/7npYaQmVkq8X8u7xfN5+FQwcB2
         WYy59sWt3pIP/JsdgnXIuVMpRRXFlq4Oirk+xZAbn8iKy1bH+BSNlW3SOh7is6Z6ujAt
         A+htPNc3eLsgKPqk3o/ZzTOrt0shReOGu8yOmToqGxj5QkiEVh0LN1GnQ2mlal2Gl3DL
         jqOjVchNbgmuqpNoCg4ntafYMbiqn+XVBcXx0n6qGfiVop7ZCBu6xZNvwxkX5dJwuKvO
         PZ9Q==
X-Gm-Message-State: APjAAAUDIx4Wr0MkbxvKJmehlIDIcsJssIWtw71+CBm8bZMRteRRfSS/
        eoHFUAvyw85nhu+JzAgw0ISrsH9lfZsX9w==
X-Google-Smtp-Source: APXvYqxnGyfLl2rW3SCFqs5k91LHB1c+ZqSO9b40n2lc1UcsURj6bU3qzxV/z5tQOSHyBfUqPmNNhA==
X-Received: by 2002:a2e:29d:: with SMTP id y29mr41335723lje.134.1560516319176;
        Fri, 14 Jun 2019 05:45:19 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v4sm572722lji.103.2019.06.14.05.45.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:45:18 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH 1/3] mesh: Added ImportLocalNode call
Date:   Fri, 14 Jun 2019 14:45:09 +0200
Message-Id: <20190614124512.19062-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614124512.19062-1-jakub.witowski@silvair.com>
References: <20190614124512.19062-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>

This implements ImportLocalNode() method on org.bluez.mesh.Network1
interface. Invoking this method creates a self-provisioned node based on
passed JSON definition.
---
 doc/mesh-api.txt |  2 +-
 mesh/mesh.c      | 49 ++++++++++++++++++++++++++++++++--
 mesh/net.c       |  2 +-
 mesh/node.c      | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/node.h      |  4 ++-
 5 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 2a800468b..aeb3167fc 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -151,7 +151,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
 
-	 uint64 token ImportLocalNode(string json_data)
+	 uint64 token ImportLocalNode(string json_data, array{byte}[16] uuid)
 
 		This method creates a local mesh node based on node
 		configuration that has been generated outside bluetooth-meshd.
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 231a6bca4..bcbd9ada4 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -22,6 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <json-c/json.h>
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
@@ -701,7 +702,7 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_network_ready_cb(void *user_data, int status,
+static void create_node_ready_cb(void *user_data, int status,
 							struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
@@ -758,7 +759,45 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	node_create(app_path, sender, uuid, create_network_ready_cb,
+	node_create(sender, app_path, uuid, create_node_ready_cb,
+								pending_msg);
+
+	return NULL;
+}
+
+static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	const char *sender;
+	struct l_dbus_message *pending_msg;
+	struct l_dbus_message_iter iter_uuid;
+	const char *json_data;
+	uint8_t *uuid;
+	uint32_t n;
+	struct json_object *jnode;
+
+	l_debug("Import local node request");
+
+	if (!l_dbus_message_get_arguments(msg, "say",
+					&json_data, &iter_uuid))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid,
+						&uuid, &n) || n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad device UUID");
+
+	jnode = json_tokener_parse(json_data);
+
+	sender = l_dbus_message_get_sender(msg);
+	pending_msg = l_dbus_message_ref(msg);
+	if (!pending_queue)
+		pending_queue = l_queue_new();
+
+	l_queue_push_tail(pending_queue, pending_msg);
+
+	node_import(sender, jnode, uuid, create_node_ready_cb,
 								pending_msg);
 
 	return NULL;
@@ -777,8 +816,14 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 
 	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
 								"token");
+
 	l_dbus_interface_method(iface, "CreateNetwork", 0, create_network_call,
 					"t", "oay", "token", "app", "uuid");
+
+	l_dbus_interface_method(iface, "ImportLocalNode", 0,
+					import_local_node_call,
+					"t", "say", "token",
+					"json_data", "uuid");
 }
 
 bool mesh_dbus_init(struct l_dbus *dbus)
diff --git a/mesh/net.c b/mesh/net.c
index a597b8794..1cb29e1e8 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -56,7 +56,7 @@
 #define DEFAULT_MIN_DELAY		0
 #define DEFAULT_MAX_DELAY		25
 
-#define DEFAULT_TRANSMIT_COUNT		1
+#define DEFAULT_TRANSMIT_COUNT		3
 #define DEFAULT_TRANSMIT_INTERVAL	100
 
 #define BEACON_INTERVAL_MIN	10
diff --git a/mesh/node.c b/mesh/node.c
index e99858623..b55e2b72a 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1672,6 +1672,75 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 					req, l_free);
 }
 
+void node_import(const char *sender, void *json_data, const uint8_t *uuid,
+			node_ready_func_t cb, void *user_data)
+{
+	json_object *jnode = json_data;
+	struct mesh_node *node = NULL;
+	struct keyring_net_key net_key;
+	uint8_t dev_key[16];
+
+	node = l_new(struct mesh_node, 1);
+	node->elements = l_queue_new();
+
+	(void)jnode;
+	/*
+	 * TODO:
+	 * add elements from json
+	 */
+	node->num_ele = l_queue_length(node->elements);
+	set_defaults(node);
+	memcpy(node->uuid, uuid, 16);
+
+	if (!create_node_config(node)) {
+		l_error("create config");
+		goto fail;
+	}
+
+	/*
+	 * TODO:
+	 * get primary (dev and net) keys from jnode
+	 */
+	l_getrandom(dev_key, sizeof(dev_key));
+	l_getrandom(net_key.old_key, sizeof(net_key.old_key));
+
+	net_key.net_idx = PRIMARY_NET_IDX;
+	net_key.phase = KEY_REFRESH_PHASE_NONE;
+
+	if (!add_local_node(node, DEFAULT_NEW_UNICAST, false, false,
+					DEFAULT_IV_INDEX, dev_key,
+					PRIMARY_NET_IDX,
+					net_key.old_key)) {
+		l_error("add local node");
+		goto fail;
+	}
+
+	if (!keyring_put_remote_dev_key(node, node->primary,
+					node->num_ele, dev_key)) {
+		l_error("put remote key");
+		goto fail;
+	}
+
+	/*
+	 * TODO:
+	 * add remaining keys from json
+	 */
+	if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key)) {
+		l_error("put net key");
+		goto fail;
+	}
+
+	cb(user_data, MESH_ERROR_NONE, node);
+	return;
+
+fail:
+	if (node)
+		free_node_resources(node);
+
+	cb(user_data, MESH_ERROR_FAILED, NULL);
+
+}
+
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
diff --git a/mesh/node.h b/mesh/node.h
index 142527b30..991adae3a 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -89,7 +89,9 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data);
 void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
-void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
+void node_create(const char *sender, const char *app_path, const uint8_t *uuid,
+					node_ready_func_t cb, void *user_data);
+void node_import(const char *sender, void *jnode, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
-- 
2.20.1

