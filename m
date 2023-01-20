Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B391BC05027
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 19:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjATTrr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjATTrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 14:47:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07374971
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g23so6212216plq.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpj4JDp5TgxuKZ4ow3jcf4YT/rAcNMgbf/8QAYkl/7w=;
        b=oXHK441CpPVhxP00Tbwa6y5A2Mn8FKENnUfwsB57nr1PcmGqndtJwlwDbWPsdxySqo
         3KXGtfN3rBuj8WNqeFEO5GRk192BywQrBvTjQlh9+9+/bC0FMw0hdwjAyoGFHheZ7VaP
         YvsDCQZjzLgHQ7NN1OJOMfpH7JwxUdiboGst4rxxHWemzmbIbjdXkURnBeOwNIY2BhbU
         SyWTStKZYnCCOM5DICsl3iyOkNtFA85jSLO+z4zsfpUdXxejkY0ipnmZHUcnjvsbcnDA
         lFmBOilYREqlhuL2jr4tZDLPXhHiemY5CQ/ogh2Wq7pEPrjYtvTl4Tuj0FUvcN3gsLG1
         8cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpj4JDp5TgxuKZ4ow3jcf4YT/rAcNMgbf/8QAYkl/7w=;
        b=O4gXG5ynVFMD0wzA6+B89y6vVgroelL0OQGMMHgQmsb3Cg9Lc4XbZnsrHTRUtVb9CI
         Vc1gA85ltw5gqdCQShBstBdNwQkmFnJRZdlVBZ6WCIqMBq2JXMVvC1m/MljtfOgF2q4l
         l4nCLp95YjZ53ku7/Kj1ov61VW8BAjsokYVqC2EnNaiH1+fRLA+6dcG4NRB9GiHO/hjt
         owO7DM9fmG+dXMAhAqYkFVjJXR7s353OMXqjTIEKQiurp0ePOf2a4Og4Wjo5X3Ufdebs
         mIoPE7NEVYMkpeF9ozqoRUNaQgBZoiQ1aBEbEidUl9ESgrlVr7sOb8iNOC+R3bUc7N+Q
         AJIQ==
X-Gm-Message-State: AFqh2koyM6jl3m1W9/+uPKOoWFv7aHgaGPx8Qyk/J4Bm0aSzdh5Uak5D
        zZ71yl4J0FL3Evuy16/vfnu8iITRl7Dfxw==
X-Google-Smtp-Source: AMrXdXv+9b25blxQMeVy3KEyfRyxTHRT8X9IfrrRnDayfBAAUd+P1lCnW7BjHUfmGCUvQ0gKsN6LzQ==
X-Received: by 2002:a17:902:8488:b0:194:8a6f:ed2c with SMTP id c8-20020a170902848800b001948a6fed2cmr15942798plo.16.1674244058624;
        Fri, 20 Jan 2023 11:47:38 -0800 (PST)
Received: from fedora.. (174-21-24-126.tukw.qwest.net. [174.21.24.126])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm5149967plg.134.2023.01.20.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:47:38 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2 02/11] mesh: Add Remote Provisioning
Date:   Fri, 20 Jan 2023 11:47:22 -0800
Message-Id: <20230120194731.90065-3-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120194731.90065-1-brian.gix@gmail.com>
References: <20230120194731.90065-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Add Remote Provisioning Server
Add Remote Provisioning Client
Remove local scanning/provisioning
Add delete-all dev key function
Add NPPI procedures
---
 Makefile.mesh           |   1 +
 mesh/cfgmod-server.c    |   2 +-
 mesh/keyring.c          |  29 +-
 mesh/keyring.h          |   1 +
 mesh/manager.c          | 533 ++++++++++++++++++-----
 mesh/mesh-config-json.c | 380 +++++++++++------
 mesh/mesh-config.h      |   6 +-
 mesh/model.c            |  27 +-
 mesh/node.c             | 255 +++++++++--
 mesh/node.h             |   3 +
 mesh/pb-adv.c           |   4 +-
 mesh/pb-adv.h           |   2 +-
 mesh/prov-acceptor.c    |  87 ++--
 mesh/prov-initiator.c   | 269 +++++++++++-
 mesh/prov.h             |   4 +-
 mesh/provision.h        |  23 +-
 mesh/remprv-server.c    | 908 ++++++++++++++++++++++++++++++++++++++++
 mesh/remprv.h           |  78 ++++
 18 files changed, 2246 insertions(+), 366 deletions(-)
 create mode 100644 mesh/remprv-server.c
 create mode 100644 mesh/remprv.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 3047f362b..e18a169eb 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -26,6 +26,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/provision.h mesh/prov.h \
 				mesh/model.h mesh/model.c \
 				mesh/cfgmod.h mesh/cfgmod-server.c \
+				mesh/remprv.h mesh/remprv-server.c \
 				mesh/mesh-config.h mesh/mesh-config-json.c \
 				mesh/util.h mesh/util.c \
 				mesh/dbus.h mesh/dbus.c \
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index be90ef8c5..3d7efc44b 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -30,8 +30,8 @@
 		(SET_ID(SIG_VENDOR, l_get_le16(pkt))))
 
 /* Supported composition pages, sorted high to low */
-/* Only page 0 is currently supported */
 static const uint8_t supported_pages[] = {
+	128,
 	0
 };
 
diff --git a/mesh/keyring.c b/mesh/keyring.c
index 995a4b88f..894fb14fa 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -30,9 +30,9 @@
 #include "mesh/node.h"
 #include "mesh/keyring.h"
 
-const char *dev_key_dir = "/dev_keys";
-const char *app_key_dir = "/app_keys";
-const char *net_key_dir = "/net_keys";
+static const char *dev_key_dir = "/dev_keys";
+static const char *app_key_dir = "/app_keys";
+static const char *net_key_dir = "/net_keys";
 
 static int open_key_file(struct mesh_node *node, const char *key_dir,
 							uint16_t idx, int flags)
@@ -295,6 +295,7 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 		close(fd);
 	}
 
+
 	return result;
 }
 
@@ -371,6 +372,28 @@ bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	return true;
 }
 
+bool keyring_del_remote_dev_key_all(struct mesh_node *node, uint16_t unicast)
+{
+	uint8_t dev_key[16];
+	uint8_t test_key[16];
+	uint8_t cnt = 1;
+
+	if (!keyring_get_remote_dev_key(node, unicast, dev_key))
+		return false;
+
+	while (keyring_get_remote_dev_key(node, unicast + cnt, test_key)) {
+		if (memcmp(dev_key, test_key, sizeof(dev_key)))
+			break;
+
+		cnt++;
+	}
+
+	if (cnt > 1)
+		return keyring_del_remote_dev_key(node, unicast + 1, cnt - 1);
+
+	return true;
+}
+
 static DIR *open_key_dir(const char *node_path, const char *key_dir_name)
 {
 	char dir_path[PATH_MAX];
diff --git a/mesh/keyring.h b/mesh/keyring.h
index ecf62cbc1..efc499ac2 100644
--- a/mesh/keyring.h
+++ b/mesh/keyring.h
@@ -39,5 +39,6 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 					uint8_t count, uint8_t dev_key[16]);
 bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 								uint8_t count);
+bool keyring_del_remote_dev_key_all(struct mesh_node *node, uint16_t unicast);
 bool keyring_build_export_keys_reply(struct mesh_node *node,
 					struct l_dbus_message_builder *builder);
diff --git a/mesh/manager.c b/mesh/manager.c
index e66b1a45b..0730fa266 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -21,75 +21,137 @@
 #include "mesh/mesh.h"
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
+#include "mesh/model.h"
 #include "mesh/net.h"
 #include "mesh/keyring.h"
 #include "mesh/agent.h"
 #include "mesh/provision.h"
+#include "mesh/prov.h"
+#include "mesh/remprv.h"
 #include "mesh/manager.h"
 
-struct add_data{
+struct prov_remote_data {
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
 	struct mesh_node *node;
 	uint32_t disc_watch;
+	uint16_t original;
 	uint16_t primary;
 	uint16_t net_idx;
+	uint8_t transport;
 	uint8_t num_ele;
 	uint8_t uuid[16];
 };
 
-static int8_t scan_rssi;
-static uint8_t scan_uuid[16];
-static struct mesh_node *scan_node;
-static struct l_timeout *scan_timeout;
-static struct add_data *add_pending;
+struct scan_req {
+	struct mesh_node *node;
+	struct l_timeout *timeout;
+	uint16_t server;
+	uint16_t net_idx;
+	uint8_t uuid[16];
+	int8_t rssi;
+	bool ext;
+};
+
+static struct l_queue *scans;
+static struct prov_remote_data *prov_pending;
 static const uint8_t prvb[2] = {MESH_AD_TYPE_BEACON, 0x00};
 
+static bool by_scan(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static bool by_node(const void *a, const void *b)
+{
+	const struct scan_req *req = a;
+	const struct mesh_node *node = b;
+
+	return req->node == node;
+}
+
+static bool by_node_svr(const void *a, const void *b)
+{
+	const struct scan_req *req = a;
+	const struct scan_req *test = b;
+
+	return req->node == test->node && req->server == test->server;
+}
+
 static void scan_cancel(struct l_timeout *timeout, void *user_data)
 {
-	struct mesh_node *node = user_data;
+	struct scan_req *req = user_data;
 	struct mesh_io *io;
 	struct mesh_net *net;
+	uint8_t msg[4];
+	int n;
 
 	l_debug("");
 
-	if (scan_timeout)
-		l_timeout_remove(scan_timeout);
+	req = l_queue_remove_if(scans, by_scan, req);
+
+	if (!req)
+		return;
+
+	l_timeout_remove(req->timeout);
+
+	if (req->server) {
+		n = mesh_model_opcode_set(OP_REM_PROV_SCAN_STOP, msg);
+		mesh_model_send(req->node, 0, req->server, APP_IDX_DEV_REMOTE,
+						req->net_idx, DEFAULT_TTL,
+						true, n, msg);
+	} else {
+		net = node_get_net(req->node);
+		io = mesh_net_get_io(net);
+		mesh_io_deregister_recv_cb(io, prvb, sizeof(prvb));
+	}
 
-	net = node_get_net(node);
-	io = mesh_net_get_io(net);
-	mesh_io_deregister_recv_cb(io, prvb, sizeof(prvb));
-	scan_node = NULL;
-	scan_timeout = NULL;
+	initiator_scan_unreg(req->node);
+	l_free(req);
 }
 
 static void free_pending_add_call()
 {
-	if (!add_pending)
+	if (!prov_pending)
 		return;
 
-	if (add_pending->disc_watch)
+	if (prov_pending->disc_watch)
 		l_dbus_remove_watch(dbus_get_bus(),
-						add_pending->disc_watch);
+						prov_pending->disc_watch);
 
-	if (add_pending->msg)
-		l_dbus_message_unref(add_pending->msg);
+	if (prov_pending->msg)
+		l_dbus_message_unref(prov_pending->msg);
 
-	l_free(add_pending);
-	add_pending = NULL;
+	l_free(prov_pending);
+	prov_pending = NULL;
 }
 
 static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 {
-	if (!add_pending)
+	if (!prov_pending)
 		return;
 
-	initiator_cancel(add_pending);
-	add_pending->disc_watch = 0;
+	initiator_cancel(prov_pending);
+	prov_pending->disc_watch = 0;
 
 	free_pending_add_call();
 }
 
+static void append_dict_entry_basic(struct l_dbus_message_builder *builder,
+					const char *key, const char *signature,
+					const void *data)
+{
+	if (!builder)
+		return;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, signature);
+	l_dbus_message_builder_append_basic(builder, signature[0], data);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
 static void send_add_failed(const char *owner, const char *path,
 							uint8_t status)
 {
@@ -102,7 +164,7 @@ static void send_add_failed(const char *owner, const char *path,
 						"AddNodeFailed");
 
 	builder = l_dbus_message_builder_new(msg);
-	dbus_append_byte_array(builder, add_pending->uuid, 16);
+	dbus_append_byte_array(builder, prov_pending->uuid, 16);
 	l_dbus_message_builder_append_basic(builder, 's',
 						mesh_prov_status_str(status));
 	l_dbus_message_builder_finalize(builder);
@@ -115,14 +177,14 @@ static void send_add_failed(const char *owner, const char *path,
 static bool add_cmplt(void *user_data, uint8_t status,
 					struct mesh_prov_node_info *info)
 {
-	struct add_data *pending = user_data;
+	struct prov_remote_data *pending = user_data;
 	struct mesh_node *node = pending->node;
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message_builder *builder;
 	struct l_dbus_message *msg;
 	bool result;
 
-	if (pending != add_pending)
+	if (pending != prov_pending)
 		return false;
 
 	if (status != PROV_ERR_SUCCESS) {
@@ -131,7 +193,12 @@ static bool add_cmplt(void *user_data, uint8_t status,
 		return false;
 	}
 
-	result = keyring_put_remote_dev_key(add_pending->node, info->unicast,
+	/* If Unicast address changing, delete old dev key */
+	if (pending->transport == PB_NPPI_01)
+		keyring_del_remote_dev_key_all(pending->node,
+							pending->original);
+
+	result = keyring_put_remote_dev_key(pending->node, info->unicast,
 					info->num_ele, info->device_key);
 
 	if (!result) {
@@ -140,13 +207,29 @@ static bool add_cmplt(void *user_data, uint8_t status,
 		return false;
 	}
 
-	msg = l_dbus_message_new_method_call(dbus, node_get_owner(node),
+	if (pending->transport > PB_NPPI_02)
+		msg = l_dbus_message_new_method_call(dbus, node_get_owner(node),
 						node_get_app_path(node),
 						MESH_PROVISIONER_INTERFACE,
 						"AddNodeComplete");
+	else
+		msg = l_dbus_message_new_method_call(dbus, node_get_owner(node),
+						node_get_app_path(node),
+						MESH_PROVISIONER_INTERFACE,
+						"ReprovComplete");
 
 	builder = l_dbus_message_builder_new(msg);
-	dbus_append_byte_array(builder, add_pending->uuid, 16);
+
+	if (pending->transport > PB_NPPI_02)
+		dbus_append_byte_array(builder, pending->uuid, 16);
+	else {
+		uint8_t nppi = (uint8_t) pending->transport;
+
+		l_dbus_message_builder_append_basic(builder, 'q',
+							&pending->original);
+		l_dbus_message_builder_append_basic(builder, 'y', &nppi);
+	}
+
 	l_dbus_message_builder_append_basic(builder, 'q', &info->unicast);
 	l_dbus_message_builder_append_basic(builder, 'y', &info->num_ele);
 	l_dbus_message_builder_finalize(builder);
@@ -161,47 +244,66 @@ static bool add_cmplt(void *user_data, uint8_t status,
 
 static void mgr_prov_data (struct l_dbus_message *reply, void *user_data)
 {
-	struct add_data *pending = user_data;
+	struct prov_remote_data *pending = user_data;
 	uint16_t net_idx;
 	uint16_t primary;
 
-	if (pending != add_pending)
+	if (pending != prov_pending)
 		return;
 
 	if (l_dbus_message_is_error(reply))
 		return;
 
-	if (!l_dbus_message_get_arguments(reply, "qq", &net_idx, &primary))
+	if (pending->transport == PB_NPPI_01) {
+		/* If performing NPPI, we only get new primary unicast here */
+		if (!l_dbus_message_get_arguments(reply, "q", &primary))
+			return;
+
+		net_idx = pending->net_idx;
+
+	} else if (!l_dbus_message_get_arguments(reply, "qq", &net_idx,
+								&primary))
 		return;
 
-	add_pending->primary = primary;
-	add_pending->net_idx = net_idx;
-	initiator_prov_data(net_idx, primary, add_pending);
+	pending->primary = primary;
+	pending->net_idx = net_idx;
+	initiator_prov_data(net_idx, primary, pending);
 }
 
 static bool add_data_get(void *user_data, uint8_t num_ele)
 {
-	struct add_data *pending = user_data;
+	struct prov_remote_data *pending = user_data;
 	struct l_dbus_message *msg;
 	struct l_dbus *dbus;
 	const char *app_path;
 	const char *sender;
 
-	if (pending != add_pending)
+	if (pending != prov_pending)
 		return false;
 
 	dbus = dbus_get_bus();
-	app_path = node_get_app_path(add_pending->node);
-	sender = node_get_owner(add_pending->node);
+	app_path = node_get_app_path(pending->node);
+	sender = node_get_owner(pending->node);
 
-	msg = l_dbus_message_new_method_call(dbus, sender, app_path,
+	if (pending->transport > PB_NPPI_02) {
+		msg = l_dbus_message_new_method_call(dbus, sender, app_path,
 						MESH_PROVISIONER_INTERFACE,
 						"RequestProvData");
 
-	l_dbus_message_set_arguments(msg, "y", num_ele);
-	l_dbus_send_with_reply(dbus, msg, mgr_prov_data, add_pending, NULL);
+		l_dbus_message_set_arguments(msg, "y", num_ele);
+	} else if (pending->transport == PB_NPPI_01) {
+		msg = l_dbus_message_new_method_call(dbus, sender, app_path,
+						MESH_PROVISIONER_INTERFACE,
+						"RequestReprovData");
+
+		l_dbus_message_set_arguments(msg, "qy", pending->original,
+								num_ele);
+	} else
+		return false;
 
-	add_pending->num_ele = num_ele;
+	l_dbus_send_with_reply(dbus, msg, mgr_prov_data, pending, NULL);
+
+	pending->num_ele = num_ele;
 
 	return true;
 }
@@ -213,15 +315,95 @@ static void add_start(void *user_data, int err)
 	l_debug("Start callback");
 
 	if (err == MESH_ERROR_NONE)
-		reply = l_dbus_message_new_method_return(add_pending->msg);
+		reply = l_dbus_message_new_method_return(prov_pending->msg);
 	else
-		reply = dbus_error(add_pending->msg, MESH_ERROR_FAILED,
+		reply = dbus_error(prov_pending->msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning initiator");
 
 	l_dbus_send(dbus_get_bus(), reply);
-	l_dbus_message_unref(add_pending->msg);
+	l_dbus_message_unref(prov_pending->msg);
+
+	prov_pending->msg = NULL;
+}
+
+static struct l_dbus_message *reprovision_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct l_dbus_message_iter options, var;
+	struct l_dbus_message *reply;
+	struct mesh_net *net = node_get_net(node);
+	const char *key;
+	uint16_t subidx;
+	uint16_t server = 0;
+	uint8_t nppi = 0;
+
+	l_debug("Reprovision request");
+
+	if (!l_dbus_message_get_arguments(msg, "qa{sv}", &server, &options))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!IS_UNICAST(server))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad Unicast");
+
+	/* Default to nodes primary subnet index */
+	subidx = mesh_net_get_primary_idx(net);
+
+	/* Get Provisioning Options */
+	while (l_dbus_message_iter_next_entry(&options, &key, &var)) {
+		bool failed = true;
+
+		if (!strcmp(key, "NPPI")) {
+			if (l_dbus_message_iter_get_variant(&var, "y", &nppi)) {
+				if (nppi <= 2)
+					failed = false;
+			}
+		} else if (!strcmp(key, "Subnet")) {
+			if (l_dbus_message_iter_get_variant(&var, "q",
+								&subidx)) {
+				if (subidx <= MAX_KEY_IDX)
+					failed = false;
+			}
+		}
+
+		if (failed)
+			return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Invalid options");
+	}
+
+	/* AddNode cancels all outstanding Scanning from node */
+	manager_scan_cancel(node);
 
-	add_pending->msg = NULL;
+	/* Invoke Prov Initiator */
+	prov_pending = l_new(struct prov_remote_data, 1);
+
+	prov_pending->transport = nppi;
+	prov_pending->node = node;
+	prov_pending->original = server;
+	prov_pending->agent = node_get_agent(node);
+
+	if (!node_is_provisioner(node) || (prov_pending->agent == NULL)) {
+		reply = dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+							"Missing Interfaces");
+		goto fail;
+	}
+
+	prov_pending->msg = l_dbus_message_ref(msg);
+	initiator_start(prov_pending->transport, server, subidx, NULL, 99, 60,
+					prov_pending->agent, add_start,
+					add_data_get, add_cmplt, node,
+					prov_pending);
+
+	prov_pending->disc_watch = l_dbus_add_disconnect_watch(dbus,
+						node_get_owner(node),
+						prov_disc_cb, NULL, NULL);
+
+	return NULL;
+fail:
+	l_free(prov_pending);
+	prov_pending = NULL;
+	return reply;
 }
 
 static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
@@ -229,55 +411,101 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
-	struct l_dbus_message_iter iter_uuid, options;
+	struct l_dbus_message_iter iter_uuid, options, var;
 	struct l_dbus_message *reply;
+	struct mesh_net *net = node_get_net(node);
+	const char *key;
 	uint8_t *uuid;
-	uint32_t n = 22;
+	uint32_t n = 0;
+	uint16_t subidx;
+	uint16_t sec = 60;
+	uint16_t server = 0;
 
 	l_debug("AddNode request");
 
 	if (!l_dbus_message_get_arguments(msg, "aya{sv}", &iter_uuid, &options))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
-								|| n != 16)
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n) ||
+									n != 16)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device UUID");
 
-	/* Allow AddNode to cancel Scanning if from the same node */
-	if (scan_node) {
-		if (scan_node != node)
-			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+	/* Default to nodes primary subnet index */
+	subidx = mesh_net_get_primary_idx(net);
 
-		scan_cancel(NULL, node);
+	/* Get Provisioning Options */
+	while (l_dbus_message_iter_next_entry(&options, &key, &var)) {
+		bool failed = true;
+
+		if (!strcmp(key, "Seconds")) {
+			if (l_dbus_message_iter_get_variant(&var, "q", &sec))
+				failed = false;
+		} else if (!strcmp(key, "Server")) {
+			if (l_dbus_message_iter_get_variant(&var, "q",
+								&server)) {
+				if (server < 0x8000)
+					failed = false;
+			}
+		} else if (!strcmp(key, "Subnet")) {
+			if (l_dbus_message_iter_get_variant(&var, "q",
+								&subidx)) {
+				if (subidx <= MAX_KEY_IDX)
+					failed = false;
+			}
+		}
+
+		if (failed)
+			return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Invalid options");
 	}
 
+	/* Device Key update/Composition update requires remote server */
+	if (!n && !server)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Invalid options");
+
+	/* If no server specified, use local */
+	if (!server)
+		server = node_get_primary(node);
+
+	/* AddNode cancels all outstanding Scanning from node */
+	manager_scan_cancel(node);
+
 	/* Invoke Prov Initiator */
-	add_pending = l_new(struct add_data, 1);
-	memcpy(add_pending->uuid, uuid, 16);
-	add_pending->node = node;
-	add_pending->agent = node_get_agent(node);
+	prov_pending = l_new(struct prov_remote_data, 1);
+
+	if (n)
+		memcpy(prov_pending->uuid, uuid, 16);
+	else
+		uuid = NULL;
 
-	if (!node_is_provisioner(node) || (add_pending->agent == NULL)) {
+	prov_pending->transport = PB_ADV;
+	prov_pending->node = node;
+	prov_pending->agent = node_get_agent(node);
+
+	if (!node_is_provisioner(node) || (prov_pending->agent == NULL)) {
 		l_debug("Provisioner: %d", node_is_provisioner(node));
-		l_debug("Agent: %p", add_pending->agent);
+		l_debug("Agent: %p", prov_pending->agent);
 		reply = dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
 							"Missing Interfaces");
 		goto fail;
 	}
 
-	add_pending->msg = l_dbus_message_ref(msg);
-	initiator_start(PB_ADV, uuid, 99, 60, add_pending->agent, add_start,
-				add_data_get, add_cmplt, node, add_pending);
+	prov_pending->msg = l_dbus_message_ref(msg);
+	initiator_start(PB_ADV, server, subidx, uuid, 99, sec,
+					prov_pending->agent, add_start,
+					add_data_get, add_cmplt, node,
+					prov_pending);
 
-	add_pending->disc_watch = l_dbus_add_disconnect_watch(dbus,
+	prov_pending->disc_watch = l_dbus_add_disconnect_watch(dbus,
 						node_get_owner(node),
 						prov_disc_cb, NULL, NULL);
 
 	return NULL;
 fail:
-	l_free(add_pending);
-	add_pending = NULL;
+	l_free(prov_pending);
+	prov_pending = NULL;
 	return reply;
 }
 
@@ -337,38 +565,50 @@ static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void prov_beacon_recv(void *user_data, struct mesh_io_recv_info *info,
+static void manager_scan_result(void *user_data, uint16_t server, bool ext,
 					const uint8_t *data, uint16_t len)
 {
-	struct mesh_node *node = user_data;
+	struct scan_req node_svr = {
+		.node = user_data,
+		.server = server,
+	};
+	struct scan_req *req;
 	struct l_dbus_message_builder *builder;
 	struct l_dbus_message *msg;
 	struct l_dbus *dbus;
 	int16_t rssi;
 
-	if (scan_node != node || len < sizeof(scan_uuid) + 2 || data[1] != 0x00)
+	l_debug("scan_result %4.4x %p", server, user_data);
+	req = l_queue_find(scans, by_node_svr, &node_svr);
+	if (!req) {
+		l_debug("No scan_result req");
 		return;
+	}
 
-	if (!memcmp(data + 2, scan_uuid, sizeof(scan_uuid))) {
-		if (info->rssi <= scan_rssi)
+	/* Filter repeats with weaker signal */
+	if (!memcmp(data + 1, req->uuid, sizeof(req->uuid))) {
+		if (!ext && ((int8_t) data[0] <= req->rssi)) {
+			l_debug("Already Seen");
 			return;
+		}
 	}
 
-	memcpy(scan_uuid, data + 2, sizeof(scan_uuid));
-	scan_rssi = info->rssi;
-	rssi = info->rssi;
+	if (!ext && ((int8_t) data[0] > req->rssi))
+		req->rssi = (int8_t) data[0];
 
+	rssi = req->rssi;
+	memcpy(req->uuid, data + 1, sizeof(req->uuid));
 	dbus = dbus_get_bus();
-	msg = l_dbus_message_new_method_call(dbus, node_get_owner(node),
-						node_get_app_path(node),
+	msg = l_dbus_message_new_method_call(dbus, node_get_owner(req->node),
+						node_get_app_path(req->node),
 						MESH_PROVISIONER_INTERFACE,
 						"ScanResult");
 
 	builder = l_dbus_message_builder_new(msg);
 	l_dbus_message_builder_append_basic(builder, 'n', &rssi);
-	dbus_append_byte_array(builder, data + 2, len -2);
+	dbus_append_byte_array(builder, data + 1, len - 1);
 	l_dbus_message_builder_enter_array(builder, "{sv}");
-	/* TODO: populate with options when defined */
+	append_dict_entry_basic(builder, "Server", "q", &server);
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
@@ -380,27 +620,71 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	struct mesh_node *node = user_data;
-	uint16_t duration = 0;
-	struct mesh_io *io;
+	struct scan_req new_req = {
+		.node = user_data,
+		.server = 0,
+		.timeout = NULL,
+		.ext = false,
+	};
+	struct scan_req *req;
 	struct mesh_net *net;
+	uint8_t *uuid, *ext = NULL;
+	uint8_t scan_req[21];
+	int n;
+	uint32_t ext_len;
+	uint32_t flen = 0;
+	uint16_t sec = 60;
 	const char *key;
 	struct l_dbus_message_iter options, var;
 	const char *sender = l_dbus_message_get_sender(msg);
 
-	if (strcmp(sender, node_get_owner(node)))
+	if (strcmp(sender, node_get_owner(new_req.node)))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
 	if (!l_dbus_message_get_arguments(msg, "a{sv}", &options))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
+	if (!node_is_provisioner(new_req.node))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	net = node_get_net(new_req.node);
+	new_req.net_idx = mesh_net_get_primary_idx(net);
+	memset(new_req.uuid, 0, sizeof(new_req.uuid));
+
 	while (l_dbus_message_iter_next_entry(&options, &key, &var)) {
 		bool failed = true;
 
 		if (!strcmp(key, "Seconds")) {
-			if (l_dbus_message_iter_get_variant(&var, "q",
-							    &duration)) {
+			if (l_dbus_message_iter_get_variant(&var, "q", &sec))
 				failed = false;
+		} else if (!strcmp(key, "Subnet")) {
+			if (l_dbus_message_iter_get_variant(&var, "q",
+							&new_req.net_idx)) {
+				if (new_req.net_idx <= MAX_KEY_IDX)
+					failed = false;
+			}
+		} else if (!strcmp(key, "Server")) {
+			if (l_dbus_message_iter_get_variant(&var, "q",
+							&new_req.server)) {
+				if (new_req.server < 0x8000)
+					failed = false;
+			}
+		} else if (!strcmp(key, "Filter")) {
+			if (l_dbus_message_iter_get_variant(&var, "ay", &var)) {
+				if (l_dbus_message_iter_get_fixed_array(&var,
+								&uuid, &flen)) {
+					if (flen == 16) {
+						memcpy(new_req.uuid, uuid,
+									flen);
+						failed = false;
+					}
+				}
+			}
+		} else if (!strcmp(key, "Extended")) {
+			if (l_dbus_message_iter_get_variant(&var, "ay", &var)) {
+				if (l_dbus_message_iter_get_fixed_array(&var,
+								&ext, &ext_len))
+					failed = false;
 			}
 		}
 
@@ -409,27 +693,51 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 							"Invalid options");
 	}
 
-	if (scan_node && scan_node != node)
-		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+	if (!scans)
+		scans = l_queue_new();
 
-	if (!node_is_provisioner(node))
-		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+	if (new_req.server) {
+		if (!sec || sec > 60)
+			return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Invalid options");
+	} else {
+		new_req.server = node_get_primary(new_req.node);
+		if (!sec || sec > 60)
+			sec = 60;
+	}
+
+	req = l_queue_remove_if(scans, by_node_svr, &new_req);
+
+	if (!req)
+		req = l_malloc(sizeof(new_req));
+
+	if (req->timeout) {
+		l_timeout_remove(req->timeout);
+		req->timeout = NULL;
+	}
+
+	*req = new_req;
+	req->rssi = -128;
+
+	if (sec)
+		req->timeout = l_timeout_create(sec, scan_cancel, req, NULL);
 
-	if (scan_timeout)
-		l_timeout_remove(scan_timeout);
 
-	memset(scan_uuid, 0, sizeof(scan_uuid));
-	scan_rssi = -128;
-	scan_timeout = NULL;
-	net = node_get_net(node);
-	io = mesh_net_get_io(net);
-	scan_node = node;
-	mesh_io_register_recv_cb(io, prvb, sizeof(prvb),
-						prov_beacon_recv, node);
+	n = mesh_model_opcode_set(OP_REM_PROV_SCAN_START, scan_req);
+	scan_req[n++] = 5;
+	scan_req[n++] = sec;
+	if (flen) {
+		memcpy(scan_req + n, req->uuid, flen);
+		n += flen;
+	}
+
+	mesh_model_send(req->node, 0, req->server, APP_IDX_DEV_REMOTE,
+						req->net_idx, DEFAULT_TTL,
+						true, n, scan_req);
 
-	if (duration)
-		scan_timeout = l_timeout_create(duration, scan_cancel,
-								node, NULL);
+	initiator_scan_reg(manager_scan_result, req->node);
+
+	l_queue_push_tail(scans, req);
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -444,12 +752,7 @@ static struct l_dbus_message *cancel_scan_call(struct l_dbus *dbus,
 	if (strcmp(sender, node_get_owner(node)) || !node_is_provisioner(node))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (scan_node) {
-		if (scan_node != node)
-			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
-
-		scan_cancel(NULL, node);
-	}
+	manager_scan_cancel(node);
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -814,6 +1117,8 @@ static void setup_management_interface(struct l_dbus_interface *iface)
 						"aya{sv}", "uuid", "options");
 	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
 				"", "qyay", "primary", "count", "dev_key");
+	l_dbus_interface_method(iface, "Reprovision", 0, reprovision_call,
+					"", "qa{sv}", "unicast", "options");
 	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
 						"", "qy", "primary", "count");
 	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
@@ -849,7 +1154,7 @@ bool manager_dbus_init(struct l_dbus *bus)
 	if (!l_dbus_register_interface(bus, MESH_MANAGEMENT_INTERFACE,
 						setup_management_interface,
 						NULL, false)) {
-		l_info("Unable to register %s interface",
+		l_debug("Unable to register %s interface",
 						MESH_MANAGEMENT_INTERFACE);
 		return false;
 	}
@@ -859,8 +1164,8 @@ bool manager_dbus_init(struct l_dbus *bus)
 
 void manager_scan_cancel(struct mesh_node *node)
 {
-	if (scan_node != node)
-		return;
+	struct scan_req *req;
 
-	scan_cancel(NULL, node);
+	while ((req = l_queue_find(scans, by_node, node)))
+		scan_cancel(NULL, req);
 }
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 7f46c8582..8f321a731 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -58,6 +58,33 @@ static const char *cfgnode_name = "/node.json";
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 
+/* JSON key words */
+static const char *unicastAddress = "unicastAddress";
+static const char *deviceCan = "deviceCan";
+static const char *deviceKey = "deviceKey";
+static const char *defaultTTL = "defaultTTL";
+static const char *sequenceNumber = "sequenceNumber";
+static const char *netKeys = "netKeys";
+static const char *appKeys = "appKeys";
+static const char *elements = "elements";
+static const char *models = "models";
+static const char *modelId = "modelId";
+static const char *address = "address";
+static const char *bind = "bind";
+static const char *publish = "publish";
+static const char *subscribe = "subscribe";
+static const char *boundNetKey = "boundNetKey";
+static const char *keyRefresh = "keyRefresh";
+static const char *subEnabled = "subEnabled";
+static const char *pubEnabled = "pubEnabled";
+static const char *retransmit = "retransmit";
+
+/* Common JSON values */
+static const char *enabled = "enabled";
+static const char *disabled = "disabled";
+static const char *unsupported = "unsupported";
+
+
 static bool save_config(json_object *jnode, const char *fname)
 {
 	FILE *outfile;
@@ -134,14 +161,14 @@ static int get_element_index(json_object *jnode, uint16_t ele_addr)
 	uint16_t addr, num_ele;
 	char *str;
 
-	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue))
+	if (!json_object_object_get_ex(jnode, unicastAddress, &jvalue))
 		return -1;
 
 	str = (char *)json_object_get_string(jvalue);
 	if (sscanf(str, "%04hx", &addr) != 1)
 		return -1;
 
-	if (!json_object_object_get_ex(jnode, "elements", &jelements))
+	if (!json_object_object_get_ex(jnode, elements, &jelements))
 		return -1;
 
 	num_ele = json_object_array_length(jelements);
@@ -160,14 +187,14 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	size_t len;
 	char buf[9];
 
-	if (!json_object_object_get_ex(jnode, "elements", &jelements))
+	if (!json_object_object_get_ex(jnode, elements, &jelements))
 		return NULL;
 
 	jelement = json_object_array_get_idx(jelements, ele_idx);
 	if (!jelement)
 		return NULL;
 
-	if (!json_object_object_get_ex(jelement, "models", &jmodels))
+	if (!json_object_object_get_ex(jelement, models, &jmodels))
 		return NULL;
 
 	num_mods = json_object_array_length(jmodels);
@@ -189,7 +216,7 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 		char *str;
 
 		jmodel = json_object_array_get_idx(jmodels, i);
-		if (!json_object_object_get_ex(jmodel, "modelId", &jvalue))
+		if (!json_object_object_get_ex(jmodel, modelId, &jvalue))
 			return NULL;
 
 		str = (char *)json_object_get_string(jvalue);
@@ -298,7 +325,7 @@ static bool read_unicast_address(json_object *jobj, uint16_t *unicast)
 	json_object *jvalue;
 	char *str;
 
-	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue))
+	if (!json_object_object_get_ex(jobj, unicastAddress, &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
@@ -314,7 +341,7 @@ static bool read_default_ttl(json_object *jobj, uint8_t *ttl)
 	int val;
 
 	/* defaultTTL is optional */
-	if (!json_object_object_get_ex(jobj, "defaultTTL", &jvalue))
+	if (!json_object_object_get_ex(jobj, defaultTTL, &jvalue))
 		return true;
 
 	val = json_object_get_int(jvalue);
@@ -336,7 +363,7 @@ static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
 	int val;
 
 	/* sequenceNumber is optional */
-	if (!json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+	if (!json_object_object_get_ex(jobj, sequenceNumber, &jvalue))
 		return true;
 
 	val = json_object_get_int(jvalue);
@@ -396,7 +423,25 @@ static bool read_device_key(json_object *jobj, uint8_t key_buf[16])
 	if (!key_buf)
 		return false;
 
-	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
+	if (!json_object_object_get_ex(jobj, deviceKey, &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (!str2hex(str, strlen(str), key_buf, 16))
+		return false;
+
+	return true;
+}
+
+static bool read_candidate(json_object *jobj, uint8_t key_buf[16])
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!key_buf)
+		return false;
+
+	if (!json_object_object_get_ex(jobj, deviceCan, &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
@@ -460,7 +505,7 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 	int len;
 	int i;
 
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
+	if (!json_object_object_get_ex(jobj, appKeys, &jarray))
 		return true;
 
 	if (json_object_get_type(jarray) != json_type_array)
@@ -484,7 +529,7 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 		if (!get_key_index(jtemp, "index", &appkey->app_idx))
 			goto fail;
 
-		if (!get_key_index(jtemp, "boundNetKey", &appkey->net_idx))
+		if (!get_key_index(jtemp, boundNetKey, &appkey->net_idx))
 			goto fail;
 
 		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
@@ -516,7 +561,7 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 	int i;
 
 	/* At least one NetKey must be present for a provisioned node */
-	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
+	if (!json_object_object_get_ex(jobj, netKeys, &jarray))
 		return false;
 
 	if (json_object_get_type(jarray) != json_type_array)
@@ -547,7 +592,7 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 		if (!str2hex(str, strlen(str), netkey->new_key, 16))
 			goto fail;
 
-		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
+		if (!json_object_object_get_ex(jtemp, keyRefresh, &jvalue))
 			netkey->phase = KEY_REFRESH_PHASE_NONE;
 		else
 			netkey->phase = (uint8_t) json_object_get_int(jvalue);
@@ -598,7 +643,7 @@ bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 	jnode = cfg->jnode;
 
 	l_debug("netKey %4.4x", idx);
-	json_object_object_get_ex(jnode, "netKeys", &jarray);
+	json_object_object_get_ex(jnode, netKeys, &jarray);
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
 
@@ -616,14 +661,14 @@ bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 	if (!add_key_value(jentry, "key", key))
 		goto fail;
 
-	json_object_object_add(jentry, "keyRefresh",
+	json_object_object_add(jentry, keyRefresh,
 				json_object_new_int(KEY_REFRESH_PHASE_NONE));
 
 	if (!jarray) {
 		jarray = json_object_new_array();
 		if (!jarray)
 			goto fail;
-		json_object_object_add(jnode, "netKeys", jarray);
+		json_object_object_add(jnode, netKeys, jarray);
 	}
 
 	json_object_array_add(jarray, jentry);
@@ -648,7 +693,7 @@ bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 
 	jnode = cfg->jnode;
 
-	if (!json_object_object_get_ex(jnode, "netKeys", &jarray))
+	if (!json_object_object_get_ex(jnode, netKeys, &jarray))
 		return false;
 
 	jentry = get_key_object(jarray, idx);
@@ -667,7 +712,7 @@ bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 	if (!add_key_value(jentry, "key", key))
 		return false;
 
-	json_object_object_add(jentry, "keyRefresh",
+	json_object_object_add(jentry, keyRefresh,
 				json_object_new_int(KEY_REFRESH_PHASE_ONE));
 
 	return save_config(jnode, cfg->node_dir_path);
@@ -682,20 +727,55 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 
 	jnode = cfg->jnode;
 
-	if (!json_object_object_get_ex(jnode, "netKeys", &jarray))
+	if (!json_object_object_get_ex(jnode, netKeys, &jarray))
 		return true;
 
 	jarray_key_del(jarray, idx);
 
 	if (!json_object_array_length(jarray))
-		json_object_object_del(jnode, "netKeys");
+		json_object_object_del(jnode, netKeys);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
 {
-	if (!cfg || !add_key_value(cfg->jnode, "deviceKey", key))
+	if (!cfg || !add_key_value(cfg->jnode, deviceKey, key))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
+bool mesh_config_write_candidate(struct mesh_config *cfg, uint8_t *key)
+{
+	if (!cfg || !add_key_value(cfg->jnode, deviceCan, key))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
+bool mesh_config_read_candidate(struct mesh_config *cfg, uint8_t *key)
+{
+	if (!cfg)
+		return false;
+
+	return read_candidate(cfg->jnode, key);
+}
+
+bool mesh_config_finalize_candidate(struct mesh_config *cfg)
+{
+	uint8_t key[16];
+
+	if (!cfg)
+		return false;
+
+	if (!read_candidate(cfg->jnode, key))
+		return false;
+
+	json_object_object_del(cfg->jnode, deviceCan);
+	json_object_object_del(cfg->jnode, deviceKey);
+
+	if (!add_key_value(cfg->jnode, deviceKey, key))
 		return false;
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
@@ -719,7 +799,7 @@ bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 
 	jnode = cfg->jnode;
 
-	json_object_object_get_ex(jnode, "appKeys", &jarray);
+	json_object_object_get_ex(jnode, appKeys, &jarray);
 	if (jarray)
 		jentry = get_key_object(jarray, app_idx);
 
@@ -734,7 +814,7 @@ bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 	if (!write_int(jentry, "index", app_idx))
 		goto fail;
 
-	if (!write_int(jentry, "boundNetKey", net_idx))
+	if (!write_int(jentry, boundNetKey, net_idx))
 		goto fail;
 
 	if (!add_key_value(jentry, "key", key))
@@ -744,7 +824,7 @@ bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 		jarray = json_object_new_array();
 		if (!jarray)
 			goto fail;
-		json_object_object_add(jnode, "appKeys", jarray);
+		json_object_object_add(jnode, appKeys, jarray);
 	}
 
 	json_object_array_add(jarray, jentry);
@@ -770,7 +850,7 @@ bool mesh_config_app_key_update(struct mesh_config *cfg, uint16_t app_idx,
 
 	jnode = cfg->jnode;
 
-	if (!json_object_object_get_ex(jnode, "appKeys", &jarray))
+	if (!json_object_object_get_ex(jnode, appKeys, &jarray))
 		return false;
 
 	/* The key entry should exist if the key is updated */
@@ -804,13 +884,13 @@ bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
 
 	jnode = cfg->jnode;
 
-	if (!json_object_object_get_ex(jnode, "appKeys", &jarray))
+	if (!json_object_object_get_ex(jnode, appKeys, &jarray))
 		return true;
 
 	jarray_key_del(jarray, idx);
 
 	if (!json_object_array_length(jarray))
-		json_object_object_del(jnode, "appKeys");
+		json_object_object_del(jnode, appKeys);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
@@ -840,7 +920,7 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!jmodel)
 		return false;
 
-	json_object_object_get_ex(jmodel, "bind", &jarray);
+	json_object_object_get_ex(jmodel, bind, &jarray);
 	if (jarray && jarray_has_string(jarray, buf, 4))
 		return true;
 
@@ -854,7 +934,7 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 			json_object_put(jstring);
 			return false;
 		}
-		json_object_object_add(jmodel, "bind", jarray);
+		json_object_object_add(jmodel, bind, jarray);
 	}
 
 	json_object_array_add(jarray, jstring);
@@ -887,13 +967,13 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!jmodel)
 		return false;
 
-	if (!json_object_object_get_ex(jmodel, "bind", &jarray))
+	if (!json_object_object_get_ex(jmodel, bind, &jarray))
 		return true;
 
 	jarray_string_del(jarray, buf, 4);
 
 	if (!json_object_array_length(jarray))
-		json_object_object_del(jmodel, "bind");
+		json_object_object_del(jmodel, bind);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
@@ -963,7 +1043,7 @@ static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 	int len, value;
 	char *str;
 
-	if (!json_object_object_get_ex(jpub, "address", &jvalue))
+	if (!json_object_object_get_ex(jpub, address, &jvalue))
 		return NULL;
 
 	str = (char *)json_object_get_string(jvalue);
@@ -998,9 +1078,10 @@ static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 
 	if (!get_int(jpub, "credentials", &value))
 		goto fail;
+
 	pub->credential = (uint8_t) value;
 
-	if (!json_object_object_get_ex(jpub, "retransmit", &jvalue))
+	if (!json_object_object_get_ex(jpub, retransmit, &jvalue))
 		goto fail;
 
 	if (!get_int(jvalue, "count", &value))
@@ -1093,7 +1174,7 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 
 		l_queue_push_tail(ele->models, mod);
 
-		if (!json_object_object_get_ex(jmodel, "modelId", &jvalue))
+		if (!json_object_object_get_ex(jmodel, modelId, &jvalue))
 			goto fail;
 
 		str = (char *)json_object_get_string(jvalue);
@@ -1112,29 +1193,32 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 
 		mod->id = id;
 
-		if (json_object_object_get_ex(jmodel, "bind", &jarray)) {
+		if (len == 8)
+			mod->vendor = true;
+
+		if (json_object_object_get_ex(jmodel, bind, &jarray)) {
 			if (json_object_get_type(jarray) != json_type_array ||
 					!parse_bindings(jarray, mod))
 				goto fail;
 		}
 
-		if (json_object_object_get_ex(jmodel, "pubEnabled", &jvalue))
+		if (json_object_object_get_ex(jmodel, pubEnabled, &jvalue))
 			mod->pub_enabled = json_object_get_boolean(jvalue);
 		else
 			mod->pub_enabled = true;
 
-		if (json_object_object_get_ex(jmodel, "subEnabled", &jvalue))
+		if (json_object_object_get_ex(jmodel, subEnabled, &jvalue))
 			mod->sub_enabled = json_object_get_boolean(jvalue);
 		else
 			mod->sub_enabled = true;
 
-		if (json_object_object_get_ex(jmodel, "publish", &jvalue)) {
+		if (json_object_object_get_ex(jmodel, publish, &jvalue)) {
 			mod->pub = parse_model_publication(jvalue);
 			if (!mod->pub)
 				goto fail;
 		}
 
-		if (json_object_object_get_ex(jmodel, "subscribe", &jarray)) {
+		if (json_object_object_get_ex(jmodel, subscribe, &jarray)) {
 			if (!parse_model_subscriptions(jarray, mod))
 				goto fail;
 		}
@@ -1187,7 +1271,7 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
 		if (sscanf(str, "%04hx", &(ele->location)) != 1)
 			goto fail;
 
-		if (json_object_object_get_ex(jelement, "models", &jmodels)) {
+		if (json_object_object_get_ex(jelement, models, &jmodels)) {
 			if (json_object_get_type(jmodels) != json_type_array ||
 						!parse_models(jmodels, ele))
 				goto fail;
@@ -1211,13 +1295,13 @@ static int get_mode(json_object *jvalue)
 	if (!str)
 		return 0xffffffff;
 
-	if (!strncasecmp(str, "disabled", strlen("disabled")))
+	if (!strncasecmp(str, disabled, strlen(disabled)))
 		return MESH_MODE_DISABLED;
 
-	if (!strncasecmp(str, "enabled", strlen("enabled")))
+	if (!strncasecmp(str, enabled, strlen(enabled)))
 		return MESH_MODE_ENABLED;
 
-	if (!strncasecmp(str, "unsupported", strlen("unsupported")))
+	if (!strncasecmp(str, unsupported, strlen(unsupported)))
 		return MESH_MODE_UNSUPPORTED;
 
 	return 0xffffffff;
@@ -1323,7 +1407,7 @@ static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
 	uint16_t interval;
 	uint8_t cnt;
 
-	if (!json_object_object_get_ex(jobj, "retransmit", &jrtx))
+	if (!json_object_object_get_ex(jobj, retransmit, &jrtx))
 		return true;
 
 	if (!json_object_object_get_ex(jrtx, "count", &jvalue))
@@ -1386,7 +1470,7 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 	}
 
 	/* Check for required "elements" property */
-	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
+	if (!json_object_object_get_ex(jnode, elements, &jvalue))
 		return false;
 
 	if (!read_net_transmit(jnode, node)) {
@@ -1460,11 +1544,11 @@ static const char *mode_to_string(int mode)
 {
 	switch (mode) {
 	case MESH_MODE_DISABLED:
-		return "disabled";
+		return disabled;
 	case MESH_MODE_ENABLED:
-		return "enabled";
+		return enabled;
 	default:
-		return "unsupported";
+		return unsupported;
 	}
 }
 
@@ -1522,7 +1606,7 @@ fail:
 
 bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast)
 {
-	if (!cfg || !write_uint16_hex(cfg->jnode, "unicastAddress", unicast))
+	if (!cfg || !write_uint16_hex(cfg->jnode, unicastAddress, unicast))
 		return false;
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
@@ -1558,8 +1642,8 @@ bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 	if (!write_int(jrtx, "interval", interval))
 		goto fail;
 
-	json_object_object_del(jnode, "retransmit");
-	json_object_object_add(jnode, "retransmit", jrtx);
+	json_object_object_del(jnode, retransmit);
+	json_object_object_add(jnode, retransmit, jrtx);
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
 
@@ -1599,8 +1683,8 @@ static void add_model(void *a, void *b)
 	if (!jmodel)
 		return;
 
-	result = (mod->vendor) ? write_uint32_hex(jmodel, "modelId", mod->id) :
-			write_uint16_hex(jmodel, "modelId", (uint16_t) mod->id);
+	result = (mod->vendor) ? write_uint32_hex(jmodel, modelId, mod->id) :
+			write_uint16_hex(jmodel, modelId, (uint16_t) mod->id);
 
 	if (!result) {
 		json_object_put(jmodel);
@@ -1608,10 +1692,10 @@ static void add_model(void *a, void *b)
 	}
 
 	jval = json_object_new_boolean(mod->sub_enabled);
-	json_object_object_add(jmodel, "subEnabled", jval);
+	json_object_object_add(jmodel, subEnabled, jval);
 
 	jval = json_object_new_boolean(mod->pub_enabled);
-	json_object_object_add(jmodel, "pubEnabled", jval);
+	json_object_object_add(jmodel, pubEnabled, jval);
 
 	json_object_array_add(jmodels, jmodel);
 }
@@ -1663,11 +1747,11 @@ static struct mesh_config *create_config(const char *cfg_path,
 		return NULL;
 
 	/* Sequence number */
-	json_object_object_add(jnode, "sequenceNumber",
+	json_object_object_add(jnode, sequenceNumber,
 					json_object_new_int(node->seq_number));
 
 	/* Default TTL */
-	json_object_object_add(jnode, "defaultTTL",
+	json_object_object_add(jnode, defaultTTL,
 						json_object_new_int(node->ttl));
 
 	/* Elements */
@@ -1702,11 +1786,11 @@ static struct mesh_config *create_config(const char *cfg_path,
 		if (!jmodels)
 			goto fail;
 
-		json_object_object_add(jelement, "models", jmodels);
+		json_object_object_add(jelement, models, jmodels);
 		l_queue_foreach(ele->models, add_model, jmodels);
 	}
 
-	json_object_object_add(jnode, "elements", jelems);
+	json_object_object_add(jnode, elements, jelems);
 
 	cfg = l_new(struct mesh_config, 1);
 
@@ -1724,6 +1808,55 @@ fail:
 		return NULL;
 }
 
+void mesh_config_reset(struct mesh_config *cfg, struct mesh_config_node *node)
+{
+	json_object *jelems;
+	const struct l_queue_entry *entry;
+
+	if (!cfg || !cfg->jnode)
+		return;
+
+	/* TODO: Recreate Element Array */
+	jelems = json_object_new_array();
+	if (!jelems)
+		return;
+
+	entry = l_queue_get_entries(node->elements);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_config_element *ele = entry->data;
+		json_object *jelement, *jmodels;
+
+		jelement = json_object_new_object();
+
+		if (!jelement) {
+			json_object_put(jelems);
+			return;
+		}
+
+		write_int(jelement, "elementIndex", ele->index);
+		write_uint16_hex(jelement, "location", ele->location);
+		json_object_array_add(jelems, jelement);
+
+		/* Models */
+		if (l_queue_isempty(ele->models))
+			continue;
+
+		jmodels = json_object_new_array();
+		if (!jmodels) {
+			json_object_put(jelems);
+			return;
+		}
+
+		json_object_object_add(jelement, models, jmodels);
+		l_queue_foreach(ele->models, add_model, jmodels);
+	}
+
+	/* Replace element array */
+	json_object_object_del(cfg->jnode, elements);
+	json_object_object_add(cfg->jnode, elements, jelems);
+}
+
 struct mesh_config *mesh_config_create(const char *cfgdir_name,
 		const uint8_t uuid[16], struct mesh_config_node *db_node)
 {
@@ -1768,7 +1901,7 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 	int i, len;
 
 	/* Clean up all the bound appkeys */
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
+	if (!json_object_object_get_ex(jobj, appKeys, &jarray))
 		return;
 
 	len = json_object_array_length(jarray);
@@ -1779,7 +1912,7 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 
 		jentry = json_object_array_get_idx(jarray, i);
 
-		if (!get_key_index(jentry, "boundNetKey", &idx))
+		if (!get_key_index(jentry, boundNetKey, &idx))
 			continue;
 
 		if (idx != net_idx)
@@ -1803,14 +1936,14 @@ bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 
 	jnode = cfg->jnode;
 
-	if (json_object_object_get_ex(jnode, "netKeys", &jarray))
+	if (json_object_object_get_ex(jnode, netKeys, &jarray))
 		jentry = get_key_object(jarray, idx);
 
 	if (!jentry)
 		return false;
 
-	json_object_object_del(jentry, "keyRefresh");
-	json_object_object_add(jentry, "keyRefresh",
+	json_object_object_del(jentry, keyRefresh);
+	json_object_object_add(jentry, keyRefresh,
 					json_object_new_int(phase));
 
 	if (phase == KEY_REFRESH_PHASE_NONE) {
@@ -1842,16 +1975,16 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!jmodel)
 		return false;
 
-	json_object_object_del(jmodel, "publish");
+	json_object_object_del(jmodel, publish);
 
 	jpub = json_object_new_object();
 	if (!jpub)
 		return false;
 
 	if (pub->virt)
-		res = add_key_value(jpub, "address", pub->virt_addr);
+		res = add_key_value(jpub, address, pub->virt_addr);
 	else
-		res = write_uint16_hex(jpub, "address", pub->addr);
+		res = write_uint16_hex(jpub, address, pub->addr);
 
 	if (!res)
 		goto fail;
@@ -1878,8 +2011,8 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!write_int(jrtx, "interval", pub->interval))
 		goto fail;
 
-	json_object_object_add(jpub, "retransmit", jrtx);
-	json_object_object_add(jmodel, "publish", jpub);
+	json_object_object_add(jpub, retransmit, jrtx);
+	json_object_object_add(jmodel, publish, jpub);
 
 	return save_config(jnode, cfg->node_dir_path);
 
@@ -1911,23 +2044,23 @@ bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
 	if (!cfg || !delete_model_property(cfg->jnode, addr, mod_id, vendor,
-								"publish"))
+								publish))
 		return false;
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
-static void del_page(json_object *jarray, uint8_t page)
+static bool del_page(json_object *jarray, uint8_t page)
 {
 	char buf[3];
 	int i, len, ret;
 
 	if (!jarray)
-		return;
+		return false;
 
 	ret = snprintf(buf, 3, "%2.2x", page);
 	if (ret < 0)
-		return;
+		return false;
 
 	len = json_object_array_length(jarray);
 
@@ -1938,10 +2071,29 @@ static void del_page(json_object *jarray, uint8_t page)
 		jentry = json_object_array_get_idx(jarray, i);
 		str = (char *)json_object_get_string(jentry);
 
-		/* Delete matching page(s) */
-		if (!memcmp(str, buf, 2))
+		/* Delete matching page */
+		if (!memcmp(str, buf, 2)) {
 			json_object_array_del_idx(jarray, i, 1);
+			break;
+		}
 	}
+
+	return true;
+}
+
+void mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page)
+{
+	json_object *jnode, *jarray = NULL;
+
+	if (!cfg)
+		return;
+
+	jnode = cfg->jnode;
+
+	json_object_object_get_ex(jnode, "pages", &jarray);
+
+	if (del_page(jarray, page))
+		save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
@@ -1984,56 +2136,6 @@ bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 	return save_config(jnode, cfg->node_dir_path);
 }
 
-bool mesh_config_comp_page_mv(struct mesh_config *cfg, uint8_t old, uint8_t nw)
-{
-	json_object *jnode, *jarray = NULL;
-	uint8_t *data;
-	char *str;
-	char old_buf[3];
-	int i, len, ret, dlen = 0;
-	bool status = true;
-
-	if (!cfg || old == nw)
-		return false;
-
-	ret = snprintf(old_buf, 3, "%2.2x", old);
-	if (ret < 0)
-		return false;
-
-	jnode = cfg->jnode;
-
-	json_object_object_get_ex(jnode, "pages", &jarray);
-
-	if (!jarray)
-		return false;
-
-	data = l_malloc(MAX_MSG_LEN);
-
-	len = json_object_array_length(jarray);
-
-	for (i = 0; i < len; i++) {
-		json_object *jentry;
-
-		jentry = json_object_array_get_idx(jarray, i);
-		str = (char *)json_object_get_string(jentry);
-
-		/* Delete matching page(s) but save data*/
-		if (!memcmp(str, old_buf, 2)) {
-			dlen = strlen(str + 2);
-			str2hex(str + 2, dlen, data, MAX_MSG_LEN);
-			dlen /= 2;
-			json_object_array_del_idx(jarray, i, 1);
-		}
-	}
-
-	if (dlen)
-		status = mesh_config_comp_page_add(cfg, nw, data, dlen);
-
-	l_free(data);
-
-	return status;
-}
-
 bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub)
@@ -2064,7 +2166,7 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 		len = 32;
 	}
 
-	json_object_object_get_ex(jmodel, "subscribe", &jarray);
+	json_object_object_get_ex(jmodel, subscribe, &jarray);
 	if (jarray && jarray_has_string(jarray, buf, len))
 		return true;
 
@@ -2078,7 +2180,7 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 			json_object_put(jstring);
 			return false;
 		}
-		json_object_object_add(jmodel, "subscribe", jarray);
+		json_object_object_add(jmodel, subscribe, jarray);
 	}
 
 	json_object_array_add(jarray, jstring);
@@ -2107,7 +2209,7 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!jmodel)
 		return false;
 
-	if (!json_object_object_get_ex(jmodel, "subscribe", &jarray))
+	if (!json_object_object_get_ex(jmodel, subscribe, &jarray))
 		return true;
 
 	if (!sub->virt) {
@@ -2122,7 +2224,7 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 	jarray_string_del(jarray, buf, len);
 
 	if (!json_object_array_length(jarray))
-		json_object_object_del(jmodel, "subscribe");
+		json_object_object_del(jmodel, subscribe);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
@@ -2131,7 +2233,7 @@ bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
 	if (!cfg || !delete_model_property(cfg->jnode, addr, mod_id, vendor,
-								"subscribe"))
+								subscribe))
 		return false;
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
@@ -2161,7 +2263,7 @@ bool mesh_config_model_pub_enable(struct mesh_config *cfg, uint16_t ele_addr,
 	json_object_object_add(jmodel, "pubDisabled", jval);
 
 	if (!enable)
-		json_object_object_del(jmodel, "publish");
+		json_object_object_del(jmodel, publish);
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
@@ -2184,13 +2286,13 @@ bool mesh_config_model_sub_enable(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!jmodel)
 		return false;
 
-	json_object_object_del(jmodel, "subEnabled");
+	json_object_object_del(jmodel, subEnabled);
 
 	jval = json_object_new_boolean(enable);
-	json_object_object_add(jmodel, "subEnabled", jval);
+	json_object_object_add(jmodel, subEnabled, jval);
 
 	if (!enable)
-		json_object_object_del(jmodel, "subscribe");
+		json_object_object_del(jmodel, subscribe);
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
@@ -2205,14 +2307,14 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		return false;
 
 	if (!cache) {
-		if (!write_int(cfg->jnode, "sequenceNumber", seq))
+		if (!write_int(cfg->jnode, sequenceNumber, seq))
 			return false;
 
 		return mesh_config_save(cfg, true, NULL, NULL);
 	}
 
 	/* If resetting seq to Zero, make sure cached value reset as well */
-	if (seq && get_int(cfg->jnode, "sequenceNumber", &value))
+	if (seq && get_int(cfg->jnode, sequenceNumber, &value))
 		cached = (uint32_t)value;
 
 	/*
@@ -2262,8 +2364,8 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 
 		l_debug("Seq Cache: %d -> %d", seq, cached);
 
-		if (!write_int(cfg->jnode, "sequenceNumber", cached))
-		    return false;
+		if (!write_int(cfg->jnode, sequenceNumber, cached))
+			return false;
 
 		return mesh_config_save(cfg, false, NULL, NULL);
 	}
@@ -2273,7 +2375,7 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 
 bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl)
 {
-	if (!cfg || !write_int(cfg->jnode, "defaultTTL", ttl))
+	if (!cfg || !write_int(cfg->jnode, defaultTTL, ttl))
 		return false;
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 420775829..ed1b610de 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -119,6 +119,7 @@ void mesh_config_release(struct mesh_config *cfg);
 void mesh_config_destroy_nvm(struct mesh_config *cfg);
 bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 				mesh_config_status_func_t cb, void *user_data);
+void mesh_config_reset(struct mesh_config *cfg, struct mesh_config_node *node);
 struct mesh_config *mesh_config_create(const char *cfgdir_name,
 						const uint8_t uuid[16],
 						struct mesh_config_node *node);
@@ -126,6 +127,9 @@ struct mesh_config *mesh_config_create(const char *cfgdir_name,
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval);
 bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key);
+bool mesh_config_write_candidate(struct mesh_config *cfg, uint8_t *key);
+bool mesh_config_read_candidate(struct mesh_config *cfg, uint8_t *key);
+bool mesh_config_finalize_candidate(struct mesh_config *cfg);
 bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token);
 bool mesh_config_write_network_key(struct mesh_config *cfg, uint16_t idx,
 				uint8_t *key, uint8_t *new_key, int phase);
@@ -141,7 +145,7 @@ bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value);
 bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 						uint8_t *data, uint16_t size);
-bool mesh_config_comp_page_mv(struct mesh_config *cfg, uint8_t old, uint8_t nw);
+void mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
 							uint16_t app_idx);
diff --git a/mesh/model.c b/mesh/model.c
index d48e6ef12..e2babea10 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -24,6 +24,8 @@
 #include "mesh/net.h"
 #include "mesh/appkey.h"
 #include "mesh/cfgmod.h"
+#include "mesh/prov.h"
+#include "mesh/remprv.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/util.h"
@@ -76,6 +78,9 @@ static bool is_internal(uint32_t id)
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return true;
 
+	if (id == REM_PROV_SRV_MODEL || id == REM_PROV_CLI_MODEL)
+		return true;
+
 	return false;
 }
 
@@ -457,13 +462,25 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 					dst, key_aid, seq, iv_idx, out, key))
 		return APP_IDX_DEV_LOCAL;
 
-	if (!keyring_get_remote_dev_key(node, src, dev_key))
+	key = dev_key;
+
+	if (keyring_get_remote_dev_key(node, src, dev_key)) {
+		if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict,
+				src, dst, key_aid, seq, iv_idx, out, key))
+			return APP_IDX_DEV_REMOTE;
+	}
+
+	/* See if there is a local Device Key Candidate as last resort */
+	if (!node_get_device_key_candidate(node, dev_key))
 		return -1;
 
-	key = dev_key;
-	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
-					dst, key_aid, seq, iv_idx, out, key))
-		return APP_IDX_DEV_REMOTE;
+	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict,
+				src, dst, key_aid, seq, iv_idx, out, key)) {
+
+		/* If candidate dev_key worked, it is considered finalized */
+		node_finalize_candidate(node);
+		return APP_IDX_DEV_LOCAL;
+	}
 
 	return -1;
 }
diff --git a/mesh/node.c b/mesh/node.c
index cf4ed140e..5150a085a 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -27,9 +27,11 @@
 #include "mesh/appkey.h"
 #include "mesh/mesh-config.h"
 #include "mesh/provision.h"
+#include "mesh/prov.h"
 #include "mesh/keyring.h"
 #include "mesh/model.h"
 #include "mesh/cfgmod.h"
+#include "mesh/remprv.h"
 #include "mesh/util.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
@@ -347,6 +349,15 @@ static bool add_elements_from_storage(struct mesh_node *node,
 		if (!add_element_from_storage(node, entry->data))
 			return false;
 
+	/* Add configuration server model on the primary element */
+	mesh_model_add(node, PRIMARY_ELE_IDX, CONFIG_SRV_MODEL, NULL);
+
+	/* Add remote provisioning models on the primary element */
+	mesh_model_add(node, PRIMARY_ELE_IDX, REM_PROV_SRV_MODEL, NULL);
+
+	if (node->provisioner)
+		mesh_model_add(node, PRIMARY_ELE_IDX, REM_PROV_CLI_MODEL, NULL);
+
 	return true;
 }
 
@@ -489,6 +500,10 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	/* Initialize configuration server model */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 
+	/* Initialize remote provisioning models */
+	remote_prov_server_init(node, PRIMARY_ELE_IDX);
+	remote_prov_client_init(node, PRIMARY_ELE_IDX);
+
 	node->cfg = cfg;
 
 	return true;
@@ -550,12 +565,78 @@ uint16_t node_get_primary(struct mesh_node *node)
 		return node->primary;
 }
 
+bool node_refresh(struct mesh_node *node, bool hard, void *prov_info)
+{
+	struct mesh_prov_node_info *info = prov_info;
+	bool res = true;
+
+	if (!node || !info)
+		return false;
+
+	if (!IS_UNICAST(info->unicast))
+		return false;
+
+	/* Changing Unicast addresses requires a hard node reset */
+	if (!hard && info->unicast != node->primary)
+		return false;
+
+	/*
+	 * Hard refresh results in immediate use of new Device Key.
+	 * Soft refresh saves new device key as Candidate until we
+	 * successfully receive new incoming message on that key.
+	 */
+	if (hard) {
+		if (!mesh_config_write_device_key(node->cfg, info->device_key))
+			return false;
+
+		memcpy(node->dev_key, info->device_key, sizeof(node->dev_key));
+
+	} else if (!mesh_config_write_candidate(node->cfg, info->device_key))
+		return false;
+
+	/* Replace Primary Unicast address if it has changed */
+	if (node->primary != info->unicast) {
+		res = mesh_config_write_unicast(node->cfg, info->unicast);
+		if (res) {
+			node->primary = info->unicast;
+			node->num_ele = info->num_ele;
+			mesh_net_register_unicast(node->net, node->primary,
+								node->num_ele);
+		}
+	}
+
+	/* Replace Page 0 with Page 128 if it exists */
+	if (res) {
+		if (node_replace_comp(node, 0, 128))
+			return true;
+	}
+
+	return res;
+}
+
 const uint8_t *node_get_device_key(struct mesh_node *node)
 {
 	if (!node)
 		return NULL;
-	else
-		return node->dev_key;
+
+	return node->dev_key;
+}
+
+bool node_get_device_key_candidate(struct mesh_node *node, uint8_t *key)
+{
+	if (!node)
+		return false;
+
+	return mesh_config_read_candidate(node->cfg, key);
+}
+
+void node_finalize_candidate(struct mesh_node *node)
+{
+	if (!node)
+		return;
+
+	if (mesh_config_read_candidate(node->cfg, node->dev_key))
+		mesh_config_finalize_candidate(node->cfg);
 }
 
 void node_set_token(struct mesh_node *node, uint8_t token[8])
@@ -785,7 +866,7 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 	return node->friend;
 }
 
-static uint16_t generate_node_comp(struct mesh_node *node, uint8_t *buf,
+static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 								uint16_t sz)
 {
 	uint16_t n, features, num_ele = 0;
@@ -895,6 +976,21 @@ static void convert_node_to_storage(struct mesh_node *node,
 
 }
 
+static void free_db_storage(struct mesh_config_node *db_node)
+{
+	const struct l_queue_entry *entry;
+
+	/* Free temporarily allocated resources */
+	entry = l_queue_get_entries(db_node->elements);
+	for (; entry; entry = entry->next) {
+		struct mesh_config_element *db_ele = entry->data;
+
+		l_queue_destroy(db_ele->models, l_free);
+	}
+
+	l_queue_destroy(db_node->elements, l_free);
+}
+
 static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 {
 	struct mesh_config_node db_node;
@@ -922,7 +1018,22 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 	return node->cfg != NULL;
 }
 
-static bool set_node_comp(struct mesh_node *node, uint8_t page_num,
+static void node_del_comp(struct mesh_node *node, uint8_t page_num)
+{
+	struct mesh_config_comp_page *page;
+
+	if (!node)
+		return;
+
+	page = l_queue_remove_if(node->pages, match_page,
+						L_UINT_TO_PTR(page_num));
+
+	l_free(page);
+
+	mesh_config_comp_page_del(node->cfg, page_num);
+}
+
+static bool node_set_comp(struct mesh_node *node, uint8_t page_num,
 					const uint8_t *data, uint16_t len)
 {
 	struct mesh_config_comp_page *page;
@@ -944,16 +1055,6 @@ static bool set_node_comp(struct mesh_node *node, uint8_t page_num,
 	return mesh_config_comp_page_add(node->cfg, page_num, page->data, len);
 }
 
-static bool create_node_comp(struct mesh_node *node)
-{
-	uint16_t len;
-	uint8_t comp[MAX_MSG_LEN - 2];
-
-	len = generate_node_comp(node, comp, sizeof(comp));
-
-	return set_node_comp(node, 0, comp, len);
-}
-
 const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
 								uint16_t *len)
 {
@@ -975,6 +1076,7 @@ const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
 bool node_replace_comp(struct mesh_node *node, uint8_t retire, uint8_t with)
 {
 	struct mesh_config_comp_page *old_page, *keep;
+	bool status;
 
 	if (!node)
 		return false;
@@ -989,9 +1091,13 @@ bool node_replace_comp(struct mesh_node *node, uint8_t retire, uint8_t with)
 
 	l_free(old_page);
 	keep->page_num = retire;
-	mesh_config_comp_page_mv(node->cfg, with, retire);
+	status = mesh_config_comp_page_add(node->cfg, keep->page_num,
+							keep->data, keep->len);
 
-	return true;
+	if (with != retire)
+		mesh_config_comp_page_del(node->cfg, with);
+
+	return status;
 }
 
 static void attach_io(void *a, void *b)
@@ -1170,8 +1276,13 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	 * daemon. If the model is present in the application properties,
 	 * the operation below will be a "no-op".
 	 */
-	if (ele->idx == PRIMARY_ELE_IDX)
+	if (ele->idx == PRIMARY_ELE_IDX) {
 		mesh_model_add(node, ele->models, CONFIG_SRV_MODEL, NULL);
+		mesh_model_add(node, ele->models, REM_PROV_SRV_MODEL, NULL);
+		if (node->provisioner)
+			mesh_model_add(node, ele->models, REM_PROV_CLI_MODEL,
+									NULL);
+	}
 
 	return true;
 fail:
@@ -1232,6 +1343,15 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 	return true;
 }
 
+static void save_pages(void *data, void *user_data)
+{
+	struct mesh_config_comp_page *page = data;
+	struct mesh_node *node = user_data;
+
+	mesh_config_comp_page_add(node->cfg, page->page_num, page->data,
+								page->len);
+}
+
 static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
 				uint16_t net_key_idx, uint8_t net_key[16])
@@ -1275,10 +1395,14 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 			return false;
 	}
 
+	l_queue_foreach(node->pages, save_pages, node);
+
 	update_net_settings(node);
 
-	/* Initialize configuration server model */
+	/* Initialize internal server models */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
+	remote_prov_server_init(node, PRIMARY_ELE_IDX);
+	remote_prov_client_init(node, PRIMARY_ELE_IDX);
 
 	node->busy = true;
 
@@ -1326,39 +1450,59 @@ static void update_model_options(struct mesh_node *node,
 
 static bool check_req_node(struct managed_obj_request *req)
 {
+	struct mesh_node *node;
 	const int offset = 8;
 	uint16_t node_len, len;
 	uint8_t comp[MAX_MSG_LEN - 2];
 	const uint8_t *node_comp;
 
-	len = generate_node_comp(req->node, comp, sizeof(comp));
+	if (req->type != REQUEST_TYPE_ATTACH) {
+		node = req->node;
 
-	if (len < MIN_COMP_SIZE)
-		return false;
+		if (!create_node_config(node, node->uuid))
+			return false;
+	} else
+		node = req->attach;
 
-	node_comp = node_get_comp(req->attach, 0, &node_len);
+	node_comp = node_get_comp(node, 0, &node_len);
+	len = node_generate_comp(req->node, comp, sizeof(comp));
 
-	/* If no page 0 exists, create it and accept */
-	if (!node_len || !node_comp)
-		return set_node_comp(req->attach, 0, comp, len);
+	/* If no page 0 exists, then current composition as valid */
+	if (req->type != REQUEST_TYPE_ATTACH || !node_len)
+		goto page_zero_valid;
 
-	/* Test Element/Model part of composition and reject if changed */
+	/*
+	 * If composition has materially changed, save new composition
+	 * in page 128 until next NPPI procedure. But we do allow
+	 * for CID, PID, VID and/or CRPL to freely change without
+	 * requiring a NPPI procedure.
+	 */
 	if (node_len != len || memcmp(&node_comp[offset], &comp[offset],
 							node_len - offset))
-		return false;
+		return node_set_comp(node, 128, comp, len);
 
-	/* If comp has changed, but not Element/Models, resave and accept */
-	else if (memcmp(node_comp, comp, node_len))
-		return set_node_comp(req->attach, 0, comp, len);
+page_zero_valid:
+	/* If page 0 represents current App, ensure page 128 doesn't exist */
+	node_del_comp(node, 128);
 
-	/* Nothing has changed */
-	return true;
+	if (len == node_len && !memcmp(node_comp, comp, len))
+		return true;
+
+	return node_set_comp(node, 0, comp, len);
+}
+
+static bool is_zero(const void *a, const void *b)
+{
+	const struct node_element *element = a;
+
+	return !element->idx;
 }
 
 static bool attach_req_node(struct mesh_node *attach, struct mesh_node *node)
 {
 	const struct l_queue_entry *attach_entry;
 	const struct l_queue_entry *node_entry;
+	bool comp_changed = false;
 
 	attach->obj_path = node->obj_path;
 	node->obj_path = NULL;
@@ -1368,6 +1512,34 @@ static bool attach_req_node(struct mesh_node *attach, struct mesh_node *node)
 		return false;
 	}
 
+	if (attach->num_ele != node->num_ele) {
+		struct mesh_config_node db_node;
+		struct node_element *old_ele, *new_ele;
+
+		convert_node_to_storage(node, &db_node);
+
+		/*
+		 * If composition has materially changed, we need to discard
+		 * everything we knew about elements in the old application,
+		 * and start from what they are telling us now.
+		 */
+		old_ele = l_queue_remove_if(attach->elements, is_zero, NULL);
+		new_ele = l_queue_remove_if(node->elements, is_zero, NULL);
+		element_free(new_ele);
+
+		l_queue_destroy(attach->elements, element_free);
+		attach->elements = node->elements;
+		attach->num_ele = node->num_ele;
+
+		/* Restore primary elements */
+		l_queue_push_head(attach->elements, old_ele);
+
+		comp_changed = true;
+
+		mesh_config_reset(attach->cfg, &db_node);
+		free_db_storage(&db_node);
+	}
+
 	attach_entry = l_queue_get_entries(attach->elements);
 	node_entry = l_queue_get_entries(node->elements);
 
@@ -1384,6 +1556,10 @@ static bool attach_req_node(struct mesh_node *attach, struct mesh_node *node)
 
 		attach_entry = attach_entry->next;
 		node_entry = node_entry->next;
+
+		/* Only need the Primary element during Composition change */
+		if (comp_changed)
+			break;
 	}
 
 	mesh_agent_remove(attach->agent);
@@ -1399,8 +1575,12 @@ static bool attach_req_node(struct mesh_node *attach, struct mesh_node *node)
 	node->owner = NULL;
 
 	update_composition(node, attach);
+
 	update_model_options(node, attach);
 
+	if (comp_changed)
+		node->elements = NULL;
+
 	node_remove(node);
 
 	return true;
@@ -1499,16 +1679,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 	node->num_ele = num_ele;
 
-	if (req->type != REQUEST_TYPE_ATTACH) {
-		/* Generate node configuration for a brand new node */
-		if (!create_node_config(node, node->uuid))
-			goto fail;
-
-		/* Create node composition */
-		if (!create_node_comp(node))
-			goto fail;
-	} else if (!check_req_node(req))
-		/* Check the integrity of the node composition */
+	if (!check_req_node(req))
 		goto fail;
 
 	switch (req->type) {
diff --git a/mesh/node.h b/mesh/node.h
index 2e3d89812..a98945223 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -38,6 +38,8 @@ uint16_t node_get_primary_net_idx(struct mesh_node *node);
 void node_set_token(struct mesh_node *node, uint8_t token[8]);
 const uint8_t *node_get_token(struct mesh_node *node);
 const uint8_t *node_get_device_key(struct mesh_node *node);
+bool node_get_device_key_candidate(struct mesh_node *node, uint8_t *key);
+void node_finalize_candidate(struct mesh_node *node);
 void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
 uint8_t node_get_num_elements(struct mesh_node *node);
 uint8_t node_default_ttl_get(struct mesh_node *node);
@@ -89,3 +91,4 @@ const char *node_get_storage_dir(struct mesh_node *node);
 bool node_load_from_storage(const char *storage_dir);
 void node_finalize_new_node(struct mesh_node *node, struct mesh_io *io);
 void node_property_changed(struct mesh_node *node, const char *property);
+bool node_refresh(struct mesh_node *node, bool hard, void *prov_info);
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 180b16258..385d81d65 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -219,7 +219,7 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	cb(user_data, 1);
 }
 
-static void pb_adv_tx(void *user_data, void *data, uint16_t len)
+static void pb_adv_tx(void *user_data, const void *data, uint16_t len)
 {
 	struct pb_adv_session *session = user_data;
 
@@ -478,7 +478,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
 		mesh_prov_close_func_t close_cb,
 		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
-		uint8_t uuid[16], void *user_data)
+		const uint8_t *uuid, void *user_data)
 {
 	struct pb_adv_session *session, *old_session;
 
diff --git a/mesh/pb-adv.h b/mesh/pb-adv.h
index 5b1e03dae..e33ba8e35 100644
--- a/mesh/pb-adv.h
+++ b/mesh/pb-adv.h
@@ -11,5 +11,5 @@
 bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
 		mesh_prov_close_func_t close_cb,
 		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
-		uint8_t uuid[16], void *user_data);
+		const uint8_t *uuid, void *user_data);
 void pb_adv_unreg(void *user_data);
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index bf8c573da..fd9d4cd5d 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -22,6 +22,7 @@
 #include "mesh/net.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
+#include "mesh/remprv.h"
 #include "mesh/pb-adv.h"
 #include "mesh/mesh.h"
 #include "mesh/agent.h"
@@ -169,9 +170,6 @@ static void acp_prov_open(void *user_data, prov_trans_tx_t trans_tx,
 					prov->transport != transport)
 		return;
 
-	if (transport != PB_ADV)
-		return;
-
 	prov->trans_tx = trans_tx;
 	prov->transport = transport;
 	prov->trans_data = trans_data;
@@ -425,9 +423,10 @@ static bool prov_start_check(struct prov_start *start,
 	return true;
 }
 
-static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
+static void acp_prov_rx(void *user_data, const void *dptr, uint16_t len)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
+	const uint8_t *data = dptr;
 	struct mesh_prov_node_info *info;
 	struct prov_fail_msg fail;
 	uint8_t type = *data++;
@@ -654,14 +653,19 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		info->flags = prov->rand_auth_workspace[18];
 		info->iv_index = l_get_be32(prov->rand_auth_workspace + 19);
 		info->unicast = l_get_be16(prov->rand_auth_workspace + 23);
+		info->num_ele = prov->conf_inputs.caps.num_ele;
+
+		/* Send prov complete */
+		prov->rand_auth_workspace[0] = PROV_COMPLETE;
+		prov->trans_tx(prov->trans_data,
+				prov->rand_auth_workspace, 1);
 
 		result = prov->cmplt(prov->caller_data, PROV_ERR_SUCCESS, info);
 		prov->cmplt = NULL;
 		l_free(info);
 
 		if (result) {
-			prov->rand_auth_workspace[0] = PROV_COMPLETE;
-			prov_send(prov, prov->rand_auth_workspace, 1);
+			l_debug("PROV_COMPLETE");
 			goto cleanup;
 		} else {
 			fail.reason = PROV_ERR_UNEXPECTED_ERR;
@@ -721,7 +725,7 @@ static void acp_prov_ack(void *user_data, uint8_t msg_num)
 
 
 /* This starts unprovisioned device beacon */
-bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
+bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 		uint16_t algorithms, uint32_t timeout,
 		struct mesh_agent *agent,
 		mesh_prov_acceptor_complete_func_t complete_cb,
@@ -733,8 +737,10 @@ bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
 	uint8_t len = sizeof(beacon) - sizeof(uint32_t);
 	bool result;
 
-	/* Invoked from Join() method in mesh-api.txt, to join a
-	 * remote mesh network.
+	/*
+	 * Invoked from Join() method in mesh-api.txt, to join a
+	 * remote mesh network. May also be invoked with a NULL
+	 * uuid to perform a Device Key Refresh procedure.
 	 */
 
 	if (prov)
@@ -752,37 +758,50 @@ bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
 
 	caps = mesh_agent_get_caps(agent);
 
-	/* TODO: Should we sanity check values here or elsewhere? */
 	prov->conf_inputs.caps.num_ele = num_ele;
-	prov->conf_inputs.caps.pub_type = caps->pub_type;
-	prov->conf_inputs.caps.static_type = caps->static_type;
-	prov->conf_inputs.caps.output_size = caps->output_size;
-	prov->conf_inputs.caps.input_size = caps->input_size;
-
-	/* Store UINT16 values in Over-the-Air order, in packed structure
-	 * for crypto inputs
-	 */
 	l_put_be16(algorithms, &prov->conf_inputs.caps.algorithms);
-	l_put_be16(caps->output_action, &prov->conf_inputs.caps.output_action);
-	l_put_be16(caps->input_action, &prov->conf_inputs.caps.input_action);
-
-	/* Compose Unprovisioned Beacon */
-	memcpy(beacon + 2, uuid, 16);
-	l_put_be16(caps->oob_info, beacon + 18);
-	if (caps->oob_info & OOB_INFO_URI_HASH){
-		l_put_be32(caps->uri_hash, beacon + 20);
-		len += sizeof(uint32_t);
+
+	if (caps) {
+		/* TODO: Should we sanity check values here or elsewhere? */
+		prov->conf_inputs.caps.pub_type = caps->pub_type;
+		prov->conf_inputs.caps.static_type = caps->static_type;
+		prov->conf_inputs.caps.output_size = caps->output_size;
+		prov->conf_inputs.caps.input_size = caps->input_size;
+
+		/* Store UINT16 values in Over-the-Air order, in packed
+		 * structure for crypto inputs
+		 */
+		l_put_be16(caps->output_action,
+					&prov->conf_inputs.caps.output_action);
+		l_put_be16(caps->input_action,
+					&prov->conf_inputs.caps.input_action);
+
+		/* Populate Caps fields of beacon */
+		l_put_be16(caps->oob_info, beacon + 18);
+		if (caps->oob_info & OOB_INFO_URI_HASH) {
+			l_put_be32(caps->uri_hash, beacon + 20);
+			len += sizeof(uint32_t);
+		}
 	}
 
-	/* Infinitely Beacon until Canceled, or Provisioning Starts */
-	result = mesh_send_pkt(0, 500, beacon, len);
+	if (uuid) {
+		/* Compose Unprovisioned Beacon */
+		memcpy(beacon + 2, uuid, 16);
+
+		/* Infinitely Beacon until Canceled, or Provisioning Starts */
+		result = mesh_send_pkt(0, 500, beacon, len);
 
-	if (!result)
-		goto error_fail;
+		if (!result)
+			goto error_fail;
 
-	/* Always register for PB-ADV */
-	result = pb_adv_reg(false, acp_prov_open, acp_prov_close, acp_prov_rx,
-						acp_prov_ack, uuid, prov);
+		/* Always register for PB-ADV */
+		result = pb_adv_reg(false, acp_prov_open, acp_prov_close,
+					acp_prov_rx, acp_prov_ack, uuid, prov);
+	} else {
+		/* Run Device Key Refresh Procedure */
+		result = register_nppi_acceptor(acp_prov_open, acp_prov_close,
+					acp_prov_rx, acp_prov_ack, prov);
+	}
 
 	if (result)
 		return true;
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index c62577523..653f3ae3e 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -21,10 +21,12 @@
 #include "mesh/crypto.h"
 #include "mesh/net.h"
 #include "mesh/node.h"
+#include "mesh/model.h"
 #include "mesh/keyring.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
 #include "mesh/pb-adv.h"
+#include "mesh/remprv.h"
 #include "mesh/mesh.h"
 #include "mesh/agent.h"
 #include "mesh/error.h"
@@ -82,12 +84,16 @@ struct mesh_prov_initiator {
 	struct l_timeout *timeout;
 	uint32_t to_secs;
 	enum int_state	state;
-	enum trans_type transport;
 	uint16_t net_idx;
+	uint16_t svr_idx;
 	uint16_t unicast;
+	uint16_t server;
+	uint8_t transport;
 	uint8_t material;
 	uint8_t expected;
 	int8_t previous;
+	uint8_t out_num;
+	uint8_t rpr_state;
 	struct conf_input conf_inputs;
 	uint8_t calc_key[16];
 	uint8_t salt[16];
@@ -100,14 +106,23 @@ struct mesh_prov_initiator {
 	uint8_t uuid[16];
 };
 
+struct scan_req {
+	mesh_prov_initiator_scan_result_t scan_result;
+	struct mesh_node *node;
+	int count;
+};
+
 static struct mesh_prov_initiator *prov = NULL;
+static struct l_queue *scans;
 
 static void initiator_free(void)
 {
-	if (prov)
+	if (prov) {
 		l_timeout_remove(prov->timeout);
 
-	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
+		if (!prov->server)
+			mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
+	}
 
 	pb_adv_unreg(prov);
 
@@ -119,6 +134,15 @@ static void int_prov_close(void *user_data, uint8_t reason)
 {
 	struct mesh_prov_initiator *prov = user_data;
 	struct mesh_prov_node_info info;
+	uint8_t msg[4];
+	int n;
+
+	if (prov->server) {
+		n = mesh_model_opcode_set(OP_REM_PROV_LINK_CLOSE, msg);
+		msg[n++] = reason == PROV_ERR_SUCCESS ? 0x00 : 0x02;
+		mesh_model_send(prov->node, 0, prov->server, APP_IDX_DEV_REMOTE,
+				prov->svr_idx, DEFAULT_TTL, true, n, msg);
+	}
 
 	if (reason != PROV_ERR_SUCCESS) {
 		prov->complete_cb(prov->caller_data, reason, NULL);
@@ -626,9 +650,10 @@ static void int_prov_start_auth(const struct mesh_agent_prov_caps *prov_caps,
 	}
 }
 
-static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
+static void int_prov_rx(void *user_data, const void *dptr, uint16_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
+	const uint8_t *data = dptr;
 	uint8_t *out;
 	uint8_t type = *data++;
 	uint8_t fail_code[2];
@@ -651,7 +676,7 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 	if (type >= L_ARRAY_SIZE(expected_pdu_size) ||
 					len != expected_pdu_size[type]) {
 		l_error("Expected PDU size %d, Got %d (type: %2.2x)",
-			len, expected_pdu_size[type], type);
+			expected_pdu_size[type], len, type);
 		fail_code[1] = PROV_ERR_INVALID_FORMAT;
 		goto failure;
 	}
@@ -773,7 +798,12 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			goto failure;
 		}
 
-		if (!prov->data_req_cb(prov->caller_data,
+		if (prov->transport == PB_NPPI_00 ||
+						prov->transport == PB_NPPI_02) {
+			/* No App data needed */
+			initiator_prov_data(prov->svr_idx, prov->server,
+							prov->caller_data);
+		} else if (!prov->data_req_cb(prov->caller_data,
 					prov->conf_inputs.caps.num_ele)) {
 			l_error("Provisioning Failed-Data Get");
 			fail_code[1] = PROV_ERR_CANT_ASSIGN_ADDR;
@@ -851,6 +881,8 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 
 static void initiator_open_cb(void *user_data, int err)
 {
+	uint8_t msg[20];
+	int n;
 	bool result;
 
 	if (!prov)
@@ -859,18 +891,30 @@ static void initiator_open_cb(void *user_data, int err)
 	if (err != MESH_ERROR_NONE)
 		goto fail;
 
-	/* Always register for PB-ADV */
-	result = pb_adv_reg(true, int_prov_open, int_prov_close, int_prov_rx,
-						int_prov_ack, prov->uuid, prov);
+	if (prov->server) {
+		n = mesh_model_opcode_set(OP_REM_PROV_LINK_OPEN, msg);
+
+		if (prov->transport <= PB_NPPI_02) {
+			msg[n++] = prov->transport;
+		} else {
+			memcpy(msg + n, prov->uuid, 16);
+			n += 16;
+		}
+
+		result = mesh_model_send(prov->node, 0, prov->server,
+					APP_IDX_DEV_REMOTE, prov->svr_idx,
+					DEFAULT_TTL, true, n, msg);
+	} else {
+		/* Always register for PB-ADV */
+		result = pb_adv_reg(true, int_prov_open, int_prov_close,
+				int_prov_rx, int_prov_ack, prov->uuid, prov);
+	}
 
 	if (!result) {
 		err = MESH_ERROR_FAILED;
 		goto fail;
 	}
 
-	if (!prov)
-		return;
-
 	prov->start_cb(prov->caller_data, MESH_ERROR_NONE);
 	return;
 fail:
@@ -878,10 +922,20 @@ fail:
 	initiator_free();
 }
 
-bool initiator_start(enum trans_type transport,
-		uint8_t uuid[16],
-		uint16_t max_ele,
-		uint32_t timeout, /* in seconds from mesh.conf */
+static void initiate_to(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_prov_initiator *rx_prov = user_data;
+
+	if (rx_prov != prov) {
+		l_timeout_remove(timeout);
+		return;
+	}
+
+	int_prov_close(user_data, PROV_ERR_TIMEOUT);
+}
+
+bool initiator_start(uint8_t transport, uint16_t server, uint16_t svr_idx,
+		uint8_t uuid[16], uint16_t max_ele, uint32_t timeout,
 		struct mesh_agent *agent,
 		mesh_prov_initiator_start_func_t start_cb,
 		mesh_prov_initiator_data_req_func_t data_req_cb,
@@ -904,6 +958,10 @@ bool initiator_start(enum trans_type transport,
 	prov->data_req_cb = data_req_cb;
 	prov->caller_data = caller_data;
 	prov->previous = -1;
+	prov->server = server;
+	prov->svr_idx = svr_idx;
+	prov->transport = transport;
+	prov->timeout = l_timeout_create(timeout, initiate_to, prov, NULL);
 	memcpy(prov->uuid, uuid, 16);
 
 	mesh_agent_refresh(prov->agent, initiator_open_cb, prov);
@@ -915,3 +973,182 @@ void initiator_cancel(void *user_data)
 {
 	initiator_free();
 }
+
+static void rpr_tx(void *user_data, const void *data, uint16_t len)
+{
+	struct mesh_prov_initiator *prov = user_data;
+	uint8_t msg[72];
+	int n;
+
+	n = mesh_model_opcode_set(OP_REM_PROV_PDU_SEND, msg);
+	msg[n++] = ++prov->out_num;
+	memcpy(msg + n, data, len);
+	l_debug("Send OB %2.2x, with packet type %d", msg[n], prov->out_num);
+	n += len;
+
+	prov->rpr_state = PB_REMOTE_STATE_OB_PKT_TX;
+	mesh_model_send(prov->node, 0, prov->server, APP_IDX_DEV_REMOTE,
+				prov->svr_idx, DEFAULT_TTL, true, n, msg);
+}
+
+static bool match_req_node(const void *a, const void *b)
+{
+	const struct scan_req *req = a;
+	const struct mesh_node *node = b;
+
+	return req->node == node;
+}
+
+static bool remprv_cli_pkt(uint16_t src, uint16_t unicast, uint16_t app_idx,
+					uint16_t net_idx, const uint8_t *data,
+					uint16_t size, const void *user_data)
+{
+	struct mesh_node *node = (struct mesh_node *) user_data;
+	const uint8_t *pkt = data;
+	struct scan_req *req;
+	uint32_t opcode;
+	uint16_t n;
+
+	if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
+		size -= n;
+		pkt += n;
+	} else
+		return false;
+
+	if (opcode < OP_REM_PROV_SCAN_CAP_GET ||
+					opcode > OP_REM_PROV_PDU_REPORT)
+		return false;
+
+	if (app_idx != APP_IDX_DEV_REMOTE && app_idx != APP_IDX_DEV_LOCAL)
+		return true;
+
+	/* Local Dev key only allowed for Loop-backs */
+	if (app_idx == APP_IDX_DEV_LOCAL && unicast != src)
+		return true;
+
+	if (prov && (prov->server != src || prov->node != node))
+		return true;
+
+	n = 0;
+
+	switch (opcode) {
+	default:
+		return false;
+
+	/* Provisioning Opcodes */
+	case OP_REM_PROV_LINK_STATUS:
+		if (size != 2 || !prov)
+			break;
+
+		if (pkt[0] == PB_REM_ERR_SUCCESS)
+			prov->rpr_state = pkt[1];
+
+		break;
+
+	case OP_REM_PROV_LINK_REPORT:
+		if (size != 2 || !prov)
+			return true;
+
+		if (pkt[0] != PB_REM_ERR_SUCCESS) {
+			if (pkt[0] == PB_REM_ERR_CLOSED_BY_DEVICE ||
+				pkt[0] == PB_REM_ERR_CLOSED_BY_SERVER)
+				int_prov_close(prov, pkt[1]);
+
+			break;
+		}
+
+
+		if (prov->rpr_state == PB_REMOTE_STATE_LINK_OPENING)
+			int_prov_open(prov, rpr_tx, prov, prov->transport);
+		else if (prov->rpr_state == PB_REMOTE_STATE_LINK_CLOSING) {
+			prov->rpr_state = PB_REMOTE_STATE_IDLE;
+			int_prov_close(prov, pkt[1]);
+			break;
+		}
+
+		prov->rpr_state = pkt[1];
+
+		break;
+
+	case OP_REM_PROV_PDU_REPORT:
+		int_prov_rx(prov, pkt + 1, size - 1);
+		break;
+
+	case OP_REM_PROV_PDU_OB_REPORT:
+		if (size != 1 || !prov)
+			break;
+
+		l_debug("Got Ack for OB %d", pkt[0]);
+		if (prov->rpr_state == PB_REMOTE_STATE_OB_PKT_TX &&
+							pkt[0] == prov->out_num)
+			int_prov_ack(prov, pkt[0]);
+
+		break;
+
+	/* Scan Opcodes */
+	case OP_REM_PROV_SCAN_CAP_STATUS:
+	case OP_REM_PROV_SCAN_STATUS:
+		break;
+
+	case OP_REM_PROV_SCAN_REPORT:
+	case OP_REM_PROV_EXT_SCAN_REPORT:
+		req = l_queue_find(scans, match_req_node, node);
+		if (req) {
+			req->scan_result(node, src,
+				opcode == OP_REM_PROV_EXT_SCAN_REPORT,
+				pkt, size);
+		}
+	}
+
+	return true;
+}
+
+void initiator_scan_reg(mesh_prov_initiator_scan_result_t scan_result,
+								void *user_data)
+{
+	struct scan_req *req;
+
+	if (!scans)
+		scans = l_queue_new();
+
+	req = l_queue_find(scans, match_req_node, user_data);
+	if (!req) {
+		req = l_new(struct scan_req, 1);
+		l_queue_push_head(scans, req);
+	}
+
+	req->scan_result = scan_result;
+	req->node = user_data;
+	req->count++;
+}
+
+void initiator_scan_unreg(void *user_data)
+{
+	struct scan_req *req;
+
+	req = l_queue_find(scans, match_req_node, user_data);
+	if (req) {
+		req->count--;
+		if (!req->count) {
+			l_queue_remove(scans, req);
+			l_free(req);
+		}
+	}
+}
+
+static void remprv_cli_unregister(void *user_data)
+{
+}
+
+static const struct mesh_model_ops ops = {
+	.unregister = remprv_cli_unregister,
+	.recv = remprv_cli_pkt,
+	.bind = NULL,
+	.sub = NULL,
+	.pub = NULL
+};
+
+void remote_prov_client_init(struct mesh_node *node, uint8_t ele_idx)
+{
+	mesh_model_register(node, ele_idx, REM_PROV_CLI_MODEL, &ops, node);
+}
diff --git a/mesh/prov.h b/mesh/prov.h
index 99e864c50..e86668fe4 100644
--- a/mesh/prov.h
+++ b/mesh/prov.h
@@ -39,14 +39,14 @@ enum mesh_prov_mode {
 
 struct mesh_prov;
 
-typedef void (*prov_trans_tx_t)(void *trans_data, void *data, uint16_t len);
+typedef void (*prov_trans_tx_t)(void *tx_data, const void *data, uint16_t len);
 typedef void (*mesh_prov_open_func_t)(void *user_data, prov_trans_tx_t trans_tx,
 					void *trans_data, uint8_t trans_type);
 
 typedef void (*mesh_prov_close_func_t)(void *user_data, uint8_t reason);
 typedef void (*mesh_prov_send_func_t)(bool success, struct mesh_prov *prov);
 typedef void (*mesh_prov_ack_func_t)(void *user_data, uint8_t msg_num);
-typedef void (*mesh_prov_receive_func_t)(void *user_data, const uint8_t *data,
+typedef void (*mesh_prov_receive_func_t)(void *user_data, const void *data,
 								uint16_t size);
 
 
diff --git a/mesh/provision.h b/mesh/provision.h
index 1634c4d40..cfeb6deba 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -70,10 +70,11 @@ struct mesh_agent;
 #define OOB_INFO_URI_HASH	0x0002
 
 /* PB_REMOTE not supported from unprovisioned state */
-enum trans_type {
-	PB_ADV = 0,
-	PB_GATT,
-};
+#define PB_NPPI_00	0x00
+#define PB_NPPI_01	0x01
+#define PB_NPPI_02	0x02
+#define PB_ADV		0x03 /* Internal only, and may be reassigned */
+#define PB_GATT		0x04 /* Internal only, and may be reassigned */
 
 #define PROV_FLAG_KR	0x01
 #define PROV_FLAG_IVU	0x02
@@ -101,15 +102,21 @@ typedef bool (*mesh_prov_initiator_complete_func_t)(void *user_data,
 					uint8_t status,
 					struct mesh_prov_node_info *info);
 
+typedef void (*mesh_prov_initiator_scan_result_t)(void *user_data,
+					uint16_t server, bool extended,
+					const uint8_t *data, uint16_t len);
+
 /* This starts unprovisioned device beacon */
-bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
+bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 			uint16_t algorithms, uint32_t timeout,
 			struct mesh_agent *agent,
 			mesh_prov_acceptor_complete_func_t complete_cb,
 			void *caller_data);
 void acceptor_cancel(void *user_data);
 
-bool initiator_start(enum trans_type transport,
+bool initiator_start(uint8_t transport,
+		uint16_t server,
+		uint16_t svr_idx,
 		uint8_t uuid[16],
 		uint16_t max_ele,
 		uint32_t timeout, /* in seconds from mesh.conf */
@@ -120,3 +127,7 @@ bool initiator_start(enum trans_type transport,
 		void *node, void *caller_data);
 void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data);
 void initiator_cancel(void *caller_data);
+
+void initiator_scan_reg(mesh_prov_initiator_scan_result_t scan_result,
+							void *user_data);
+void initiator_scan_unreg(void *caller_data);
diff --git a/mesh/remprv-server.c b/mesh/remprv-server.c
new file mode 100644
index 000000000..c6e19ed89
--- /dev/null
+++ b/mesh/remprv-server.c
@@ -0,0 +1,908 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/time.h>
+#include <ell/ell.h>
+
+#include "src/shared/ad.h"
+
+#include "mesh/mesh-defs.h"
+#include "mesh/mesh-io.h"
+#include "mesh/util.h"
+#include "mesh/node.h"
+#include "mesh/net.h"
+#include "mesh/appkey.h"
+#include "mesh/model.h"
+#include "mesh/prov.h"
+#include "mesh/provision.h"
+#include "mesh/pb-adv.h"
+#include "mesh/remprv.h"
+
+#define EXT_LIST_SIZE	60
+
+#define RPR_DEV_KEY	0x00
+#define RPR_ADDR	0x01
+#define RPR_COMP	0x02
+#define RPR_ADV		0xFF	/* Internal use only*/
+
+struct rem_scan_data {
+	struct mesh_node *node;
+	struct l_timeout *timeout;
+	uint8_t *list;
+	uint16_t client;
+	uint16_t oob_info;
+	uint16_t net_idx;
+	uint8_t state;
+	uint8_t scanned_limit;
+	uint8_t addr[6];
+	uint8_t uuid[16];
+	uint8_t to_secs;
+	uint8_t rxed_ads;
+	uint8_t ext_cnt;
+	bool fltr;
+	uint8_t ext[0];
+};
+
+static struct rem_scan_data *rpb_scan;
+
+struct rem_prov_data {
+	struct mesh_node *node;
+	struct l_timeout *timeout;
+	void *trans_data;
+	uint16_t client;
+	uint16_t net_idx;
+	uint8_t svr_pdu_num;
+	uint8_t cli_pdu_num;
+	uint8_t state;
+	uint8_t nppi_proc;
+	union {
+		struct {
+			mesh_prov_open_func_t open_cb;
+			mesh_prov_close_func_t close_cb;
+			mesh_prov_receive_func_t rx_cb;
+			mesh_prov_ack_func_t ack_cb;
+			struct mesh_prov_node_info info;
+		} nppi;
+		struct {
+			uint8_t uuid[17];
+			prov_trans_tx_t tx;
+		} adv;
+	} u;
+};
+
+static struct rem_prov_data *rpb_prov;
+
+static const uint8_t prvb[2] = {BT_AD_MESH_BEACON, 0x00};
+static const uint8_t pkt_filter = BT_AD_MESH_PROV;
+static const char *name = "Test Name";
+
+static const uint8_t zero[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+
+static void srv_open(void *user_data, prov_trans_tx_t adv_tx,
+					void *trans_data, uint8_t nppi_proc)
+{
+	struct rem_prov_data *prov = user_data;
+	uint8_t msg[5];
+	int n;
+
+	if (prov != rpb_prov || prov->state != PB_REMOTE_STATE_LINK_OPENING)
+		return;
+
+	l_debug("Remote Link open confirmed");
+	prov->u.adv.tx = adv_tx;
+	prov->trans_data = trans_data;
+	prov->state = PB_REMOTE_STATE_LINK_ACTIVE;
+
+	n = mesh_model_opcode_set(OP_REM_PROV_LINK_REPORT, msg);
+	msg[n++] = PB_REM_ERR_SUCCESS;
+	msg[n++] = prov->state;
+
+	mesh_model_send(prov->node, 0, prov->client, APP_IDX_DEV_LOCAL,
+				prov->net_idx, DEFAULT_TTL, true, n, msg);
+}
+
+static void srv_rx(void *user_data, const void *dptr, uint16_t len)
+{
+	struct rem_prov_data *prov = user_data;
+	const uint8_t *data = dptr;
+	uint8_t msg[69];
+	int n;
+
+	if (prov != rpb_prov || prov->state < PB_REMOTE_STATE_LINK_ACTIVE ||
+								len > 65)
+		return;
+
+	l_debug("Remote PB IB-PDU");
+
+	prov->svr_pdu_num++;
+	n = mesh_model_opcode_set(OP_REM_PROV_PDU_REPORT, msg);
+	msg[n++] = prov->svr_pdu_num;
+	memcpy(msg + n, data, len);
+	n += len;
+
+	mesh_model_send(prov->node, 0, prov->client, APP_IDX_DEV_LOCAL,
+				prov->net_idx, DEFAULT_TTL, true, n, msg);
+}
+
+static void srv_ack(void *user_data, uint8_t msg_num)
+{
+	struct rem_prov_data *prov = user_data;
+	uint8_t msg[4];
+	int n;
+
+	if (prov != rpb_prov || prov->state != PB_REMOTE_STATE_OB_PKT_TX)
+		return;
+
+	l_debug("Remote PB ACK");
+
+	prov->state = PB_REMOTE_STATE_LINK_ACTIVE;
+	n = mesh_model_opcode_set(OP_REM_PROV_PDU_OB_REPORT, msg);
+	msg[n++] = prov->cli_pdu_num;
+
+	mesh_model_send(prov->node, 0, prov->client, APP_IDX_DEV_LOCAL,
+				prov->net_idx, DEFAULT_TTL, true, n, msg);
+}
+
+static void srv_close(void *user_data, uint8_t reason)
+{
+	struct rem_prov_data *prov = user_data;
+	uint8_t msg[4];
+	int n;
+
+	if (prov != rpb_prov || prov->state < PB_REMOTE_STATE_LINK_ACTIVE)
+		return;
+
+	l_debug("Remote PB Close");
+
+	prov->state = PB_REMOTE_STATE_LINK_CLOSING;
+	n = mesh_model_opcode_set(OP_REM_PROV_LINK_REPORT, msg);
+	msg[n++] = prov->state;
+	msg[n++] = reason;
+
+	mesh_model_send(prov->node, 0, prov->client, APP_IDX_DEV_LOCAL,
+				prov->net_idx, DEFAULT_TTL, true, n, msg);
+}
+
+static void send_prov_status(struct rem_prov_data *prov, uint8_t status)
+{
+	uint16_t n;
+	uint8_t msg[5];
+	bool segmented = prov->state == PB_REMOTE_STATE_LINK_CLOSING ?
+								true : false;
+
+	n = mesh_model_opcode_set(OP_REM_PROV_LINK_STATUS, msg);
+	msg[n++] = status;
+	msg[n++] = prov->state;
+
+	l_info("RPB-Link Status(%d): dst %4.4x", prov->state, prov->client);
+
+	mesh_model_send(prov->node, 0, prov->client, APP_IDX_DEV_LOCAL,
+				prov->net_idx, DEFAULT_TTL, segmented, n, msg);
+}
+
+static void remprv_prov_cancel(struct l_timeout *timeout,
+						void *user_data)
+{
+	struct rem_prov_data *prov = user_data;
+
+	if (prov != rpb_prov)
+		return;
+
+	l_timeout_remove(prov->timeout);
+	l_free(prov);
+	rpb_prov = NULL;
+}
+
+static void deregister_ext_ad_type(uint8_t ad_type)
+{
+	uint8_t short_ad;
+
+	switch (ad_type) {
+	case BT_AD_MESH_BEACON:
+	case BT_AD_MESH_DATA:
+	case BT_AD_MESH_PROV:
+	case BT_AD_UUID16_SOME:
+	case BT_AD_UUID32_SOME:
+	case BT_AD_UUID128_SOME:
+	case BT_AD_NAME_SHORT:
+		return;
+
+	case BT_AD_UUID16_ALL:
+	case BT_AD_UUID32_ALL:
+	case BT_AD_UUID128_ALL:
+	case BT_AD_NAME_COMPLETE:
+		/* Automatically get short versions */
+		short_ad = ad_type - 1;
+		mesh_io_deregister_recv_cb(NULL, &short_ad, 1);
+
+		/* Fallthrough */
+	default:
+		mesh_io_deregister_recv_cb(NULL, &ad_type, 1);
+		break;
+	}
+}
+
+static void remprv_scan_cancel(struct l_timeout *timeout,
+						void *user_data)
+{
+	struct rem_scan_data *scan = user_data;
+	uint8_t msg[22 + EXT_LIST_SIZE];
+	uint16_t i, n;
+
+	if (!scan || scan != rpb_scan)
+		return;
+
+	for (n = 0; n < scan->ext_cnt; n++)
+		deregister_ext_ad_type(scan->ext[n]);
+
+	if (scan->timeout == timeout) {
+		/* Return Extended Results */
+		if (scan->ext_cnt) {
+			/* Return Extended Result */
+			n = mesh_model_opcode_set(
+					OP_REM_PROV_EXT_SCAN_REPORT, msg);
+			msg[n++] = PB_REM_ERR_SUCCESS;
+			memcpy(msg + n, scan->uuid, 16);
+			n += 16;
+
+			if (scan->oob_info) {
+				l_put_le16(0, msg + n);
+				n += 2;
+			}
+
+			i = 0;
+			while (scan->list[i]) {
+				msg[n++] = scan->list[i];
+				memcpy(msg + n, &scan->list[i + 1],
+								scan->list[i]);
+				n += scan->list[i];
+				i += scan->list[i] + 1;
+			}
+		}
+	}
+
+	l_timeout_remove(scan->timeout);
+	l_free(scan->list);
+	l_free(scan);
+	rpb_scan = NULL;
+}
+
+static void scan_pkt(void *user_data, struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	struct rem_scan_data *scan = user_data;
+	uint8_t msg[22 + EXT_LIST_SIZE];
+	uint16_t i, n;
+	uint8_t filled = 0;
+	bool report = false;
+
+	if (scan != rpb_scan)
+		return;
+
+	if (scan->ext_cnt)
+		goto extended_scan;
+
+	/* RX Unprovisioned Beacon */
+	if (data[0] != BT_AD_MESH_BEACON || data[1] ||
+			(len != 18 && len != 20 && len != 24))
+		return;
+
+	data += 2;
+	len -= 2;
+
+	for (n = 0; !report && n < scan->scanned_limit; n++) {
+		if (!memcmp(&scan->list[n * 17 + 1], data, 16)) {
+
+			/* Repeat UUID, check RSSI */
+			if ((int8_t) scan->list[n * 17] < info->rssi) {
+				report = true;
+				scan->list[n * 17] = (uint8_t) info->rssi;
+			}
+
+		} else if (!memcmp(&scan->list[n * 17 + 1], zero, 16)) {
+
+			/* Found Empty slot */
+			report = true;
+			scan->list[n * 17] = (uint8_t) info->rssi;
+			memcpy(&scan->list[n * 17 + 1], data, 16);
+		}
+
+		filled++;
+	}
+
+	if (!report)
+		return;
+
+	n = mesh_model_opcode_set(OP_REM_PROV_SCAN_REPORT, msg);
+	msg[n++] = (uint8_t) info->rssi;
+	memcpy(msg + n, data, len);
+	n += len;
+
+	/* Always return oob_info, even if it wasn't in beacon */
+	if (len == 16) {
+		l_put_le16(0, msg + n);
+		n += 2;
+	}
+
+	goto send_report;
+
+extended_scan:
+	if (data[0] == BT_AD_MESH_BEACON && !data[1]) {
+		if (len != 18 && len != 20 && len != 24)
+			return;
+
+		/* Check UUID */
+		if (memcmp(data + 2, scan->uuid, 16))
+			return;
+
+		/* Zero AD list if prior data RXed from different bd_addr */
+		if (memcmp(scan->addr, info->addr, 6)) {
+			scan->list[0] = 0;
+			scan->rxed_ads = 0;
+		}
+
+		memcpy(scan->addr, info->addr, 6);
+		scan->fltr = true;
+
+		if (len >= 20)
+			scan->oob_info = l_get_le16(data + 18);
+
+		if (scan->rxed_ads != scan->ext_cnt)
+			return;
+
+
+	} else if (data[0] != BT_AD_MESH_BEACON) {
+		if (!scan->fltr || !memcmp(scan->addr, info->addr, 6)) {
+			i = 0;
+			while (scan->list[i]) {
+				/* check if seen */
+				if (scan->list[i + 1] == data[0])
+					return;
+
+				i += scan->list[i] + 1;
+			}
+
+			/* Overflow Protection */
+			if (i + len + 1 > EXT_LIST_SIZE)
+				return;
+
+			scan->list[i] = len;
+			scan->list[i + len + 1] = 0;
+			memcpy(scan->list + i + 1, data, len);
+			scan->rxed_ads++;
+		}
+
+		if (scan->rxed_ads != scan->ext_cnt)
+			return;
+
+	} else
+		return;
+
+	n = mesh_model_opcode_set(OP_REM_PROV_EXT_SCAN_REPORT, msg);
+	msg[n++] = PB_REM_ERR_SUCCESS;
+	memcpy(msg + n, scan->uuid, 16);
+	n += 16;
+	l_put_le16(scan->oob_info, msg + n);
+	n += 2;
+
+	i = 0;
+	while (scan->list[i]) {
+		msg[n++] = scan->list[i];
+		memcpy(msg + n, &scan->list[i + 1], scan->list[i]);
+		n += scan->list[i];
+		i += scan->list[i];
+	}
+
+send_report:
+	print_packet("App Tx", msg, n);
+	mesh_model_send(scan->node, 0, scan->client, APP_IDX_DEV_LOCAL,
+				scan->net_idx, DEFAULT_TTL, true, n, msg);
+
+	/* Clean-up if we are done reporting*/
+	if (filled == scan->scanned_limit || scan->ext_cnt)
+		remprv_scan_cancel(NULL, scan);
+}
+
+static bool register_ext_ad_type(uint8_t ad_type, struct rem_scan_data *scan)
+{
+	uint8_t short_ad;
+
+	switch (ad_type) {
+	case BT_AD_MESH_PROV:
+	case BT_AD_UUID16_SOME:
+	case BT_AD_UUID32_SOME:
+	case BT_AD_UUID128_SOME:
+	case BT_AD_NAME_SHORT:
+		/* Illegal Requests */
+		return false;
+
+	case BT_AD_UUID16_ALL:
+	case BT_AD_UUID32_ALL:
+	case BT_AD_UUID128_ALL:
+	case BT_AD_NAME_COMPLETE:
+		/* Automatically get short versions */
+		short_ad = ad_type - 1;
+		mesh_io_register_recv_cb(NULL, &short_ad, 1, scan_pkt, scan);
+
+		/* Fallthrough */
+	default:
+		mesh_io_register_recv_cb(NULL, &ad_type, 1, scan_pkt, scan);
+
+		/* Fallthrough */
+
+	case BT_AD_MESH_BEACON:
+		/* Ignored/auto request */
+		break;
+	}
+
+	return true;
+}
+
+static void link_active(void *user_data)
+{
+	struct rem_prov_data *prov = user_data;
+	uint8_t msg[5];
+	int n;
+
+	if (prov != rpb_prov || prov->state != PB_REMOTE_STATE_LINK_OPENING)
+		return;
+
+	l_debug("Remote Link open confirmed");
+	prov->state = PB_REMOTE_STATE_LINK_ACTIVE;
+
+	n = mesh_model_opcode_set(OP_REM_PROV_LINK_REPORT, msg);
+	msg[n++] = PB_REM_ERR_SUCCESS;
+	msg[n++] = PB_REMOTE_STATE_LINK_ACTIVE;
+
+	mesh_model_send(prov->node, 0, prov->client, APP_IDX_DEV_LOCAL,
+				prov->net_idx, DEFAULT_TTL, true, n, msg);
+}
+
+bool register_nppi_acceptor(mesh_prov_open_func_t open_cb,
+					mesh_prov_close_func_t close_cb,
+					mesh_prov_receive_func_t rx_cb,
+					mesh_prov_ack_func_t ack_cb,
+					void *user_data)
+{
+	struct rem_prov_data *prov = rpb_prov;
+
+	if (!prov || prov->nppi_proc == RPR_ADV)
+		return false;
+
+	prov->u.nppi.open_cb = open_cb;
+	prov->u.nppi.close_cb = close_cb;
+	prov->u.nppi.rx_cb = rx_cb;
+	prov->u.nppi.ack_cb = ack_cb;
+	prov->trans_data = user_data;
+
+	open_cb(user_data, srv_rx, prov, prov->nppi_proc);
+
+	l_idle_oneshot(link_active, prov, NULL);
+
+	return true;
+}
+
+static bool nppi_cmplt(void *user_data, uint8_t status,
+					struct mesh_prov_node_info *info)
+{
+	struct rem_prov_data *prov = user_data;
+
+	if (prov != rpb_prov)
+		return false;
+
+	/* Save new info to apply on Link Close */
+	prov->u.nppi.info = *info;
+	return true;
+}
+
+static bool start_dev_key_refresh(struct mesh_node *node, uint8_t nppi_proc,
+						struct rem_prov_data *prov)
+{
+	uint8_t num_ele = node_get_num_elements(node);
+
+	prov->nppi_proc = nppi_proc;
+	return acceptor_start(num_ele, NULL, 0x0001, 60, NULL, nppi_cmplt,
+									prov);
+}
+
+static bool remprv_srv_pkt(uint16_t src, uint16_t unicast, uint16_t app_idx,
+					uint16_t net_idx, const uint8_t *data,
+					uint16_t size, const void *user_data)
+{
+	struct rem_prov_data *prov = rpb_prov;
+	struct rem_scan_data *scan = rpb_scan;
+	struct mesh_node *node = (struct mesh_node *) user_data;
+	const uint8_t *pkt = data;
+	bool segmented = false;
+	uint32_t opcode;
+	uint8_t msg[69];
+	uint8_t status;
+	uint16_t n;
+
+	if (app_idx != APP_IDX_DEV_LOCAL)
+		return false;
+
+	if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
+		size -= n;
+		pkt += n;
+	} else
+		return false;
+
+	n = 0;
+
+	switch (opcode) {
+	default:
+		return false;
+
+	case OP_REM_PROV_SCAN_CAP_GET:
+		if (size != 0)
+			return true;
+
+		/* Compose Scan Info Status */
+		n = mesh_model_opcode_set(OP_REM_PROV_SCAN_CAP_STATUS, msg);
+		msg[n++] = PB_REMOTE_MAX_SCAN_QUEUE_SIZE;
+		msg[n++] = 1; /* Active Scanning Supported */
+		break;
+
+	case OP_REM_PROV_EXT_SCAN_START:
+		if (!size || !pkt[0])
+			return true;
+
+		/* Size check the message */
+		if (pkt[0] + 18 == size) {
+			/* Range check the Timeout */
+			if (!pkt[size - 1] || pkt[size - 1] > 5)
+				return true;
+		} else if (pkt[0] + 1 != size)
+			return true;
+
+		/* Get local device extended info */
+		if (pkt[0] + 18 != size) {
+			n = mesh_model_opcode_set(
+					OP_REM_PROV_EXT_SCAN_REPORT, msg);
+			msg[n++] = PB_REM_ERR_SUCCESS;
+			memcpy(msg + n, node_uuid_get(node), 16);
+			n += 16;
+			l_put_le16(0, msg + n);
+			n += 2;
+			size--;
+			pkt++;
+
+			while (size--) {
+				if (*pkt++ == BT_AD_NAME_COMPLETE) {
+					msg[n] = strlen(name) + 1;
+					if (msg[n] > sizeof(msg) - n - 1)
+						msg[n] = sizeof(msg) - n - 1;
+					n++;
+					msg[n++] = BT_AD_NAME_COMPLETE;
+					memcpy(&msg[n], name, msg[n - 2] - 1);
+					n += msg[n - 2] - 1;
+					goto send_pkt;
+				}
+			}
+
+			/* Send internal report */
+			l_debug("Send internal extended info %d", n);
+			goto send_pkt;
+		}
+
+		status = PB_REM_ERR_SUCCESS;
+		if (scan) {
+			if (scan->client != src || scan->node != node ||
+						scan->ext_cnt != pkt[0])
+				status = PB_REM_ERR_SCANNING_CANNOT_START;
+			else if (memcmp(scan->ext, pkt + 1, pkt[0]))
+				status = PB_REM_ERR_SCANNING_CANNOT_START;
+			else if (memcmp(scan->uuid, pkt + 2, 16))
+				status = PB_REM_ERR_SCANNING_CANNOT_START;
+		}
+
+		if (status != PB_REM_ERR_SUCCESS) {
+			n = mesh_model_opcode_set(OP_REM_PROV_EXT_SCAN_REPORT,
+									msg);
+			msg[n++] = status;
+			memset(msg + n, 0, 16);
+			n += 16;
+			segmented = true;
+			break;
+		}
+
+		/* Ignore extended requests while already scanning */
+		if (scan)
+			return true;
+
+		scan = (void *) l_new(uint8_t,
+					sizeof(struct rem_scan_data) + pkt[0]);
+
+		/* Validate and register Extended AD types */
+		for (n = 0; n < pkt[0]; n++) {
+			if (!register_ext_ad_type(pkt[1 + n], scan)) {
+				/* Invalid AD type detected -- Undo */
+				while (n--)
+					deregister_ext_ad_type(pkt[1 + n]);
+
+				l_free(scan);
+				return true;
+			}
+		}
+
+		rpb_scan = scan;
+		scan->client = src;
+		scan->net_idx = net_idx;
+		memcpy(scan->uuid, pkt + size - 17, 16);
+		scan->ext_cnt = pkt[0];
+		memcpy(scan->ext, pkt + 1, pkt[0]);
+		scan->list = l_malloc(EXT_LIST_SIZE);
+		scan->list[0] = 0;
+
+		mesh_io_register_recv_cb(NULL, prvb, sizeof(prvb),
+								scan_pkt, scan);
+
+		scan->timeout = l_timeout_create(pkt[size-1],
+						remprv_scan_cancel, scan, NULL);
+		return true;
+
+	case OP_REM_PROV_SCAN_START:
+		if (size != 2 && size != 18)
+			return true;
+
+		/* Reject Timeout of Zero */
+		if (!pkt[1])
+			return true;
+
+		status = PB_REM_ERR_SUCCESS;
+		if (scan) {
+			if (scan->ext_cnt || scan->client != src ||
+							scan->node != node)
+				status = PB_REM_ERR_SCANNING_CANNOT_START;
+			else if (!!(scan->fltr) != !!(size != 18))
+				status = PB_REM_ERR_SCANNING_CANNOT_START;
+			else if (scan->fltr && memcmp(scan->uuid, pkt + 2, 16))
+				status = PB_REM_ERR_SCANNING_CANNOT_START;
+		}
+
+		if (status != PB_REM_ERR_SUCCESS) {
+			n = mesh_model_opcode_set(OP_REM_PROV_SCAN_STATUS, msg);
+			msg[n++] = status;
+			msg[n++] = scan ? scan->state : 0;
+			msg[n++] = scan ? scan->scanned_limit :
+						PB_REMOTE_MAX_SCAN_QUEUE_SIZE;
+			msg[n++] = scan ? scan->to_secs : 0;
+			break;
+		}
+
+		if (!scan)
+			scan = l_new(struct rem_scan_data, 1);
+
+		rpb_scan = scan;
+
+		if (size == 18) {
+			memcpy(scan->uuid, pkt + 2, 16);
+			scan->fltr = true;
+			scan->state = 0x02; /* Limited */
+		} else {
+			memset(scan->uuid, 0, 16);
+			scan->fltr = false;
+			scan->state = 0x01; /* Unlimited */
+		}
+
+		status = PB_REM_ERR_SUCCESS;
+		scan->client = src;
+		scan->net_idx = net_idx;
+		scan->node = node;
+
+		if (!scan->list)
+			scan->list = l_new(uint8_t,
+					23 * PB_REMOTE_MAX_SCAN_QUEUE_SIZE);
+
+		mesh_io_register_recv_cb(NULL, prvb, 2, scan_pkt, scan);
+
+		scan->to_secs = pkt[1];
+
+		if (pkt[0])
+			scan->scanned_limit = pkt[0];
+		else
+			scan->scanned_limit = PB_REMOTE_MAX_SCAN_QUEUE_SIZE;
+
+		scan->timeout = l_timeout_create(pkt[1],
+					remprv_scan_cancel, scan, NULL);
+
+		/* Fallthrough */
+
+	case OP_REM_PROV_SCAN_GET:
+		/* Compose Scan Status */
+		n = mesh_model_opcode_set(OP_REM_PROV_SCAN_STATUS, msg);
+		msg[n++] = PB_REM_ERR_SUCCESS;
+		msg[n++] = scan ? scan->state : 0;
+		msg[n++] = scan ? scan->scanned_limit :
+						PB_REMOTE_MAX_SCAN_QUEUE_SIZE;
+		msg[n++] = scan ? scan->to_secs : 0;
+		break;
+
+	case OP_REM_PROV_SCAN_STOP:
+		if (size != 0 || !scan)
+			return true;
+
+		remprv_scan_cancel(NULL, scan);
+		return true;
+
+	case OP_REM_PROV_LINK_GET:
+		if (size != 0 || !prov)
+			return true;
+
+		send_prov_status(prov, PB_REM_ERR_SUCCESS);
+		return true;
+
+	case OP_REM_PROV_LINK_OPEN:
+		/* Sanity check args */
+		if (size != 16 && size != 17 && size != 1)
+			return true;
+
+		if (size == 17 && (pkt[16] == 0 || pkt[16] > 0x3c))
+			return true;
+
+		if (size == 1 && pkt[0] > 0x02)
+			return true;
+
+		if (prov) {
+			if (prov->client != src || prov->node != node ||
+				(size == 1 && prov->nppi_proc != pkt[0]) ||
+				(size >= 16 && (prov->nppi_proc != RPR_ADV ||
+					memcmp(prov->u.adv.uuid, pkt, 16)))) {
+
+				/* Send Reject (in progress) */
+				send_prov_status(prov, PB_REM_ERR_CANNOT_OPEN);
+				n = mesh_model_opcode_set(
+						OP_REM_PROV_LINK_STATUS, msg);
+				msg[n++] = PB_REM_ERR_CANNOT_OPEN;
+				msg[n++] = PB_REMOTE_STATE_LINK_ACTIVE;
+				break;
+			}
+
+			/* Send redundant  Success */
+			send_prov_status(prov, PB_REM_ERR_SUCCESS);
+			return true;
+		}
+
+		if (scan && scan->client != src && scan->node != node) {
+			n = mesh_model_opcode_set(OP_REM_PROV_LINK_STATUS, msg);
+			msg[n++] = PB_REM_ERR_CANNOT_OPEN;
+			msg[n++] = PB_REMOTE_STATE_LINK_ACTIVE;
+			break;
+		}
+
+		print_packet("Remote Prov Link Open", pkt, size);
+
+		remprv_scan_cancel(NULL, scan);
+
+		rpb_prov = prov = l_new(struct rem_prov_data, 1);
+		prov->client = src;
+		prov->net_idx = net_idx;
+		prov->node = node;
+		prov->state = PB_REMOTE_STATE_LINK_OPENING;
+
+		if (size == 1) {
+			status = start_dev_key_refresh(node, pkt[0], prov);
+
+		} else {
+			if (size == 17)
+				prov->timeout = l_timeout_create(pkt[16],
+						remprv_prov_cancel, prov, NULL);
+
+
+			prov->nppi_proc = RPR_ADV;
+			memcpy(prov->u.adv.uuid, pkt, 16);
+			status = pb_adv_reg(true, srv_open, srv_close, srv_rx,
+							srv_ack, pkt, prov);
+		}
+
+		if (status)
+			send_prov_status(prov, PB_REM_ERR_SUCCESS);
+		else {
+			n = mesh_model_opcode_set(OP_REM_PROV_LINK_STATUS, msg);
+			msg[n++] = PB_REM_ERR_CANNOT_OPEN;
+			msg[n++] = PB_REMOTE_STATE_IDLE;
+			remprv_prov_cancel(NULL, prov);
+		}
+
+		return true;
+
+	case OP_REM_PROV_LINK_CLOSE:
+		if (size != 1)
+			return true;
+
+		if (!prov || prov->node != node || prov->client != src)
+			return true;
+
+		prov->state = PB_REMOTE_STATE_LINK_CLOSING;
+		mesh_io_send_cancel(NULL, &pkt_filter, sizeof(pkt_filter));
+		send_prov_status(prov, PB_REM_ERR_SUCCESS);
+		if (pkt[0] == 0x02) {
+			msg[0] = PROV_FAILED;
+			msg[1] = PROV_ERR_CANT_ASSIGN_ADDR;
+			if (prov->nppi_proc == RPR_ADV)
+				prov->u.adv.tx(prov->trans_data, msg, 2);
+			else
+				prov->u.nppi.rx_cb(prov->trans_data, msg, 2);
+		}
+
+		if (prov->nppi_proc == RPR_ADV)
+			pb_adv_unreg(prov);
+
+		else if (prov->nppi_proc <= RPR_COMP) {
+			/* Hard or Soft refresh of local node, based on NPPI */
+			node_refresh(prov->node, (prov->nppi_proc == RPR_ADDR),
+							&prov->u.nppi.info);
+		}
+
+		remprv_prov_cancel(NULL, prov);
+
+		return true;
+
+	case OP_REM_PROV_PDU_SEND:
+		if (!prov || prov->node != node || prov->client != src)
+			return true;
+
+		if (size < 2)
+			return true;
+
+
+		prov->cli_pdu_num = *pkt++;
+		size--;
+		prov->state = PB_REMOTE_STATE_OB_PKT_TX;
+
+		if (prov->nppi_proc == RPR_ADV)
+			prov->u.adv.tx(prov->trans_data, pkt, size);
+		else {
+			srv_ack(prov, prov->cli_pdu_num);
+			prov->u.nppi.rx_cb(prov->trans_data, pkt, size);
+		}
+
+		return true;
+	}
+
+send_pkt:
+	l_info("PB-SVR: src %4.4x dst %4.4x", unicast, src);
+	print_packet("App Tx", msg, n);
+	mesh_model_send(node, 0, src, APP_IDX_DEV_LOCAL,
+				net_idx, DEFAULT_TTL, segmented, n, msg);
+
+	return true;
+}
+
+static void remprv_srv_unregister(void *user_data)
+{
+}
+
+static const struct mesh_model_ops ops = {
+	.unregister = remprv_srv_unregister,
+	.recv = remprv_srv_pkt,
+	.bind = NULL,
+	.sub = NULL,
+	.pub = NULL
+};
+
+void remote_prov_server_init(struct mesh_node *node, uint8_t ele_idx)
+{
+	mesh_model_register(node, ele_idx, REM_PROV_SRV_MODEL, &ops, node);
+}
diff --git a/mesh/remprv.h b/mesh/remprv.h
new file mode 100644
index 000000000..49b4e2c7c
--- /dev/null
+++ b/mesh/remprv.h
@@ -0,0 +1,78 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#define REM_PROV_SRV_MODEL	SET_ID(SIG_VENDOR, 0x0004)
+#define REM_PROV_CLI_MODEL	SET_ID(SIG_VENDOR, 0x0005)
+
+#define PB_REMOTE_MAX_SCAN_QUEUE_SIZE	5
+
+#define PB_REMOTE_STATE_IDLE		0x00
+#define PB_REMOTE_STATE_LINK_OPENING	0x01
+#define PB_REMOTE_STATE_LINK_ACTIVE	0x02
+#define PB_REMOTE_STATE_OB_PKT_TX	0x03
+#define PB_REMOTE_STATE_LINK_CLOSING	0x04
+
+#define PB_REMOTE_TYPE_LOCAL	0x01
+#define PB_REMOTE_TYPE_ADV	0x02
+#define PB_REMOTE_TYPE_GATT	0x04
+
+#define PB_REMOTE_SCAN_TYPE_NONE	0x00
+#define PB_REMOTE_SCAN_TYPE_UNLIMITED	0x01
+#define PB_REMOTE_SCAN_TYPE_LIMITED	0x02
+#define PB_REMOTE_SCAN_TYPE_DETAILED	0x03
+
+/* Remote Provisioning Opcode List */
+#define OP_REM_PROV_SCAN_CAP_GET	0x804F
+#define OP_REM_PROV_SCAN_CAP_STATUS	0x8050
+#define OP_REM_PROV_SCAN_GET		0x8051
+#define OP_REM_PROV_SCAN_START		0x8052
+#define OP_REM_PROV_SCAN_STOP		0x8053
+#define OP_REM_PROV_SCAN_STATUS		0x8054
+#define OP_REM_PROV_SCAN_REPORT		0x8055
+#define OP_REM_PROV_EXT_SCAN_START	0x8056
+#define OP_REM_PROV_EXT_SCAN_REPORT	0x8057
+#define OP_REM_PROV_LINK_GET		0x8058
+#define OP_REM_PROV_LINK_OPEN		0x8059
+#define OP_REM_PROV_LINK_CLOSE		0x805A
+#define OP_REM_PROV_LINK_STATUS		0x805B
+#define OP_REM_PROV_LINK_REPORT		0x805C
+#define OP_REM_PROV_PDU_SEND		0x805D
+#define OP_REM_PROV_PDU_OB_REPORT	0x805E
+#define OP_REM_PROV_PDU_REPORT		0x805F
+
+/* Remote Provisioning Errors */
+#define PB_REM_ERR_SUCCESS			0x00
+#define PB_REM_ERR_SCANNING_CANNOT_START	0x01
+#define PB_REM_ERR_INVALID_STATE		0x02
+#define PB_REM_ERR_LIMITED_RESOURCES		0x03
+#define PB_REM_ERR_CANNOT_OPEN			0x04
+#define PB_REM_ERR_OPEN_FAILED			0x05
+#define PB_REM_ERR_CLOSED_BY_DEVICE		0x06
+#define PB_REM_ERR_CLOSED_BY_SERVER		0x07
+#define PB_REM_ERR_CLOSED_BY_CLIENT		0x08
+#define PB_REM_ERR_CLOSED_CANNOT_RX_PDU		0x09
+#define PB_REM_ERR_CLOSED_CANNOT_TX_PDU		0x0A
+
+void remote_prov_server_init(struct mesh_node *node, uint8_t ele_idx);
+void remote_prov_client_init(struct mesh_node *node, uint8_t ele_idx);
+bool register_nppi_acceptor(mesh_prov_open_func_t open_cb,
+					mesh_prov_close_func_t close_cb,
+					mesh_prov_receive_func_t rx_cb,
+					mesh_prov_ack_func_t ack_cb,
+					void *user_data);
-- 
2.39.0

