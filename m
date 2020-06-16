Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 09:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9932074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 09:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="nIgluVOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFPJjy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgFPJjw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 05:39:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE3C05BD43
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 02:39:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y11so22732958ljm.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JQkcHm++bX0myQTLbXvngBDfLDzHdcZ9amDvg7Mi9Y=;
        b=nIgluVOaRJD7p8HyI6py4EgAaiZP1BkOOqwH86BxvK7gWZ1t0a400c5OU0ecCTxshC
         BxjzJxCnYWeBWA2gR/tqJ6RG408eAGosZodZM5sYQbD6w1OS6hekF+jvb7Xb0BQF0WnQ
         HIce1f7GnV1Zq02LGlfGiAqMyn0juziSfli10j/ogmiVGkFXabTYDlhKhHZpT+ojeF0a
         a5rPxnpG6yjfNZaPlKdQiABB697GpxSTasZzD6F6YfScw0j3Ey2GydgdLsbt7hSIx01/
         V6idpWy+dhMUVhOmW1va4lBXpM9fYS3pdk2pAZ/uz8phV2Iz2zusQ8q5vJTC8Sr6ZM37
         sq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JQkcHm++bX0myQTLbXvngBDfLDzHdcZ9amDvg7Mi9Y=;
        b=FSDHqrBqyjyV/PPJOug9y4RmgKsi6Q703z0a+aos7wzDAS0cirHAoPgrmFNvABu5PR
         CC2tKBRZhBwoFIFDLaB02Unms9pXvvAws/EBL2UsbWmVJdjj16CdFDqRImCXRdrxINaC
         kIzHbtnFggKLTVacQvR+8NKCFW6g7beqPfRfedNy/Xy14Sb5Z32XOHjRrRH5M7zp2E2K
         5wx/ZZo4qsVOvtlf2QPl8mPPEwrbPRaNltIxDgJENZqJUnTQnC93NTLrqL6y9MFzc2Xl
         xhIpXSMjwO6cBUyNqN/JEjiP6Jes+PZdMwIL4jJaR6mj9I7W/5vzhddvy6gtyaVyMVR6
         XBLQ==
X-Gm-Message-State: AOAM533IEIJoUk3kY4Qiia1VJogzetxHAFMoDJqVjTBaIrslrUGySwc7
        FYdWIDEPrqGG4n6tJj0mKacLJRe8Y5knSQ==
X-Google-Smtp-Source: ABdhPJxpsTyjeihyP1uT6Uf/J5TATyEtp8y1blPEHiyaAjs/k6dQp4rpoE2nuRLqTfl/odjmX0Z/nQ==
X-Received: by 2002:a2e:998c:: with SMTP id w12mr1056477lji.143.1592300389818;
        Tue, 16 Jun 2020 02:39:49 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b25sm5140573lff.26.2020.06.16.02.39.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:39:48 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] mesh: Allow calls to Attach/Leave before replying to JoinComplete
Date:   Tue, 16 Jun 2020 11:40:09 +0200
Message-Id: <20200616094009.21753-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of failing with "busy", process the call after application
replies to JoinComplete.
---

Inga, Brian,

What do ayou think about this approach? It's a bit more complicated, but
it doesn't impose any restrictions on the application.

 doc/mesh-api.txt |  2 --
 mesh/mesh.c      | 73 +++++++++++++++++++++++++++++++++++++++++++-----
 mesh/node.c      | 38 ++++++++++++-------------
 mesh/node.h      |  8 +++---
 4 files changed, 88 insertions(+), 33 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index c4440d5fa..a3bf6bb39 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -116,7 +116,6 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound,
 			org.bluez.mesh.Error.AlreadyExists,
-			org.bluez.mesh.Error.Busy,
 			org.bluez.mesh.Error.Failed
 
 	void Leave(uint64 token)
@@ -128,7 +127,6 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound
-			org.bluez.mesh.Error.Busy
 
 	void CreateNetwork(object app_root, array{byte}[16] uuid)
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index f6f734725..4189e6435 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -70,7 +70,7 @@ struct bt_mesh {
 	bool initialized;
 };
 
-struct join_data{
+struct join_data {
 	struct l_dbus_message *msg;
 	char *sender;
 	struct mesh_node *node;
@@ -78,6 +78,13 @@ struct join_data{
 	uint8_t *uuid;
 };
 
+struct call_data {
+	struct mesh_node *node;
+	l_dbus_interface_method_cb_t cb;
+	struct l_dbus_message *msg;
+	void *user_data;
+};
+
 struct mesh_init_request {
 	mesh_ready_func_t cb;
 	void *user_data;
@@ -102,6 +109,8 @@ static struct join_data *join_pending;
 /* Pending method requests */
 static struct l_queue *pending_queue;
 
+static struct l_queue *pending_calls;
+
 static const char *storage_dir;
 
 static bool simple_match(const void *a, const void *b)
@@ -109,6 +118,14 @@ static bool simple_match(const void *a, const void *b)
 	return a == b;
 }
 
+static bool match_call_node(const void *a, const void *b)
+{
+	const struct call_data *call = a;
+	const struct mesh_node *node = b;
+
+	return call->node == node;
+}
+
 /* Used for any outbound traffic that doesn't have Friendship Constraints */
 /* This includes Beacons, Provisioning and unrestricted Network Traffic */
 bool mesh_send_pkt(uint8_t count, uint16_t interval,
@@ -298,6 +315,7 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh.max_filters = caps.max_num_filters;
 
 	pending_queue = l_queue_new();
+	pending_calls = l_queue_new();
 
 	return true;
 }
@@ -349,6 +367,7 @@ void mesh_cleanup(void)
 	}
 
 	l_queue_destroy(pending_queue, pending_request_exit);
+	l_queue_destroy(pending_calls, pending_request_exit);
 	mesh_agent_cleanup();
 	node_cleanup_all();
 	mesh_model_cleanup();
@@ -439,6 +458,37 @@ static void send_join_failed(const char *owner, const char *path,
 	free_pending_join_call(true);
 }
 
+static void queue_pending_call(struct mesh_node *node,
+				l_dbus_interface_method_cb_t cb,
+				struct l_dbus_message *msg, void *user_data)
+{
+	struct call_data *pending_call = l_new(struct call_data, 1);
+	pending_call->node = node;
+	pending_call->cb = cb;
+	pending_call->msg = l_dbus_message_ref(msg);
+	pending_call->user_data = user_data;
+
+	l_queue_push_tail(pending_calls, pending_call);
+}
+
+static void process_pending_call(struct mesh_node *node)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct call_data *pending_call;
+	struct l_dbus_message *reply;
+
+	pending_call = l_queue_remove_if(pending_calls, match_call_node);
+	if (!pending_call)
+		return;
+
+	reply = pending_call->cb(dbus, pending_call->msg,
+						pending_call->user_data);
+	if (reply)
+		l_dbus_send(dbus, reply);
+
+	l_dbus_message_unref(pending_call->msg);
+}
+
 static void prov_join_complete_reply_cb(struct l_dbus_message *msg,
 								void *user_data)
 {
@@ -447,8 +497,10 @@ static void prov_join_complete_reply_cb(struct l_dbus_message *msg,
 	if (!msg || l_dbus_message_is_error(msg))
 		failed = true;
 
-	if (!failed)
+	if (!failed) {
 		node_finalize_new_node(join_pending->node, mesh.io);
+		process_pending_call(join_pending->node);
+	}
 
 	free_pending_join_call(failed);
 }
@@ -645,7 +697,12 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	pending_msg = l_dbus_message_ref(msg);
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	node_attach(app_path, sender, token, attach_ready_cb, pending_msg);
+	if (!node_attach(app_path, sender, token, attach_ready_cb,
+								pending_msg)) {
+
+		struct mesh_node *node = node_find_by_token(token);
+		queue_pending_call(node, attach_call, msg, user_data);
+	}
 
 	return NULL;
 }
@@ -666,10 +723,11 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	if (!node)
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
-	if (node_is_busy(node))
-		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
-
-	node_remove(node);
+	if (!node_remove(node))
+	{
+		queue_pending_call(node, leave_call, msg, user_data);
+		return NULL;
+	}
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -685,6 +743,7 @@ static void create_join_complete_reply_cb(struct l_dbus_message *msg,
 	}
 
 	node_finalize_new_node(node, mesh.io);
+	process_pending_call(node);
 }
 
 static void create_node_ready_cb(void *user_data, int status,
diff --git a/mesh/node.c b/mesh/node.c
index 39fb0dd02..dcc6bc58b 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -345,16 +345,20 @@ static void free_node_resources(void *data)
  * This function is called to free resources and remove the
  * configuration files for the specified node.
  */
-void node_remove(struct mesh_node *node)
+bool node_remove(struct mesh_node *node)
 {
 	if (!node)
-		return;
+		return true;
+
+	if (node->busy)
+		return false;
 
 	l_queue_remove(nodes, node);
 
 	mesh_config_destroy_nvm(node->cfg);
 
 	free_node_resources(node);
+	return true;
 }
 
 static bool add_models_from_storage(struct mesh_node *node,
@@ -599,11 +603,6 @@ bool node_is_provisioner(struct mesh_node *node)
 	return node->provisioner;
 }
 
-bool node_is_busy(struct mesh_node *node)
-{
-	return node->busy;
-}
-
 void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 							uint16_t app_idx)
 {
@@ -1657,31 +1656,29 @@ static void send_managed_objects_request(const char *destination,
 }
 
 /* Establish relationship between application and mesh node */
-void node_attach(const char *app_root, const char *sender, uint64_t token,
-					node_ready_func_t cb, void *user_data)
+bool node_attach(const char *app_root, const char *sender, uint64_t token,
+					node_ready_func_t cb,
+					struct l_dbus_message *pending_msg)
 {
 	struct managed_obj_request *req;
 	struct mesh_node *node;
 
 	node = l_queue_find(nodes, match_token, (void *) &token);
 	if (!node) {
-		cb(user_data, MESH_ERROR_NOT_FOUND, NULL);
-		return;
-	}
-
-	/* Check if there is a pending request associated with this node */
-	if (node->busy) {
-		cb(user_data, MESH_ERROR_BUSY, NULL);
-		return;
+		cb(pending_msg, MESH_ERROR_NOT_FOUND, NULL);
+		return true;
 	}
 
 	/* Check if the node is already in use */
 	if (node->owner) {
 		l_warn("The node is already in use");
-		cb(user_data, MESH_ERROR_ALREADY_EXISTS, NULL);
-		return;
+		cb(pending_msg, MESH_ERROR_ALREADY_EXISTS, NULL);
+		return true;
 	}
 
+	if (node->busy)
+		return false;
+
 	req = l_new(struct managed_obj_request, 1);
 
 	/*
@@ -1691,13 +1688,14 @@ void node_attach(const char *app_root, const char *sender, uint64_t token,
 	req->node = node_new(node->uuid);
 	req->node->owner = l_strdup(sender);
 	req->ready_cb = cb;
-	req->pending_msg = user_data;
+	req->pending_msg = pending_msg;
 	req->attach = node;
 	req->type = REQUEST_TYPE_ATTACH;
 
 	node->busy = true;
 
 	send_managed_objects_request(sender, app_root, req);
+	return true;
 }
 
 /* Create a temporary pre-provisioned node */
diff --git a/mesh/node.h b/mesh/node.h
index b8b2b1b49..34432bd5b 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -30,7 +30,7 @@ typedef void (*node_ready_func_t) (void *user_data, int status,
 typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
-void node_remove(struct mesh_node *node);
+bool node_remove(struct mesh_node *node);
 void node_join(const char *app_root, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
 uint8_t *node_uuid_get(struct mesh_node *node);
@@ -39,7 +39,6 @@ struct mesh_node *node_find_by_addr(uint16_t addr);
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
 struct mesh_node *node_find_by_token(uint64_t token);
 bool node_is_provisioner(struct mesh_node *node);
-bool node_is_busy(struct mesh_node *node);
 void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 							uint16_t app_idx);
 uint16_t node_get_primary(struct mesh_node *node);
@@ -81,8 +80,9 @@ const char *node_get_app_path(struct mesh_node *node);
 bool node_add_pending_local(struct mesh_node *node, void *info);
 void node_attach_io_all(struct mesh_io *io);
 void node_attach_io(struct mesh_node *node, struct mesh_io *io);
-void node_attach(const char *app_root, const char *sender, uint64_t token,
-					node_ready_func_t cb, void *user_data);
+bool node_attach(const char *app_root, const char *sender, uint64_t token,
+					node_ready_func_t cb,
+					struct l_dbus_message *pending_msg);
 void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
 void node_create(const char *app_root, const char *sender, const uint8_t *uuid,
-- 
2.20.1

