Return-Path: <SRS0=Arr2=V4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE5C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C08218A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bBfVZEwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfGaHQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:16:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38387 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGaHQ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Jul 2019 03:16:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so46634870lfj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2019 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yg6rBtWavRZTaKQ4UeBo4YUT6l3tGnzIfQDlwSgoKpg=;
        b=bBfVZEwgKONfmFUHn+JyvOtzju0ufrZ3D+0H9tyOwl7UDInOSM2ccs0oeoDNPcARWd
         9GEdCp8dDEXt/lc6zE2GFXK3PV0mRhGcHgvdhGjjVSJc8FUGsYAdGrEHuNsxRcxQCv/T
         Dr6uEOPgOxEP4OZjXWJ5VNH6ZFfkyMu+jQ1JXJrxv8WGNgJzgOVftgDq6B+FtZsVRF23
         3YZtTc1BV1zx15SaUgxjOvOwekBw0Ocwrk7lrMXiZQxtU9ES/aghPgkwWQWDXCDLCbk7
         fMTsWZ4JaTtedxrXtI2J6CiXknHBev6ndVR8ZU3/fs+8UtRK77/Beti0Tp4bZEZ3XfXe
         zerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yg6rBtWavRZTaKQ4UeBo4YUT6l3tGnzIfQDlwSgoKpg=;
        b=qVNeVgwWz23TVEjRyeahe1dezeUCoyqgmv+oEcymzlJU4YQL0ZHMVHrZ5NA4i9eQ7X
         pwYCAZlNOsajBCM5O/TeHIv5uNfxMiVWNmTnU9Qo7B/Hj19AxUt9YCTUxFQHh4ggdpaw
         OG4pRoCljrgvyEwkrUPmsIG+czFIEm1f1Q02iJkSrb5dOojNM1sC3pzAX/fHNh36DKRM
         LsM10UFoQhVmcA1httYCJWHR6p7LIXwvUXHGpQODLMpvYHAupT63w0aqdL5l/rs3GWRe
         WtQqwn2Q2VZmE3SDAgd7jSgiQqoGMB7soRsKyTzjvoUa1iYwC28E27Kdkx/Q3UC91rbV
         9IXg==
X-Gm-Message-State: APjAAAW0UgPehqIb9t3h0cclxbHr0uS+xy1TSRi7VPoyuVZdgJWYv+g/
        cdSS3jArMbctqCKKu9kQDpYUNeZpC1g=
X-Google-Smtp-Source: APXvYqxLG/kG/54xC3CI9WdFnAWRA9jc1Ie7G4XXFaK/Jw3nVQ6kGPS0P7/anwnoffDRpX1hT0Az/w==
X-Received: by 2002:a19:6602:: with SMTP id a2mr55268368lfc.25.1564557415761;
        Wed, 31 Jul 2019 00:16:55 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n10sm11662477lfe.24.2019.07.31.00.16.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 00:16:55 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 3/3] mesh: Implement Import() D-Bus API of org.bluez.mesh.Network1 interface
Date:   Wed, 31 Jul 2019 09:16:47 +0200
Message-Id: <20190731071647.27217-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
References: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
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

