Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00105C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0642080D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="OdkPtxHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPM1b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFPM1a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 08:27:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD963C08C5C4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 05:27:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l27so21324681ejc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1Fk2KUpjyPx0eHBpoTc4iCJf8QQyZRiOS7QAD8Gyibk=;
        b=OdkPtxHe24KdU62Lx08M7Y1Ej2aaw600Ln3WUvJHjIhAQYNyAPBwc9LOAE7o0q9Jaw
         3NVkmG6/5PVzphgIgAE1PNhZG8EKRTnlBFHkMPtGBs4oy36NS3MjPOX5tTg8mPqNsrJH
         npdsPIGKkxkOK89GB753Uuk5/XAClXmKTcL9Y7V7hxqF5XGG2nIX4/WZsZNb4FxwirJN
         WtxGvpYTybe6vq0qNdDct/D+lgXxUeqVhGQ3/lYBLLDFLEsTzKZ+mZSX+Yvs03d0Ig35
         FJUv1JdLEbYYe335gfryaH8Vnm23HXJbLX+NXxo4Lmxi6493zQAdj7fOLA7vSShVOSjV
         AsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Fk2KUpjyPx0eHBpoTc4iCJf8QQyZRiOS7QAD8Gyibk=;
        b=Yc7HOOCDt8c5Ujcq84m31F9OjeqCGYkCfM071y/It6dlvBtBxhDSFjqSkQy4PkAYfu
         5e6k+X2ouKAp1CWYUN54cVDjUZbMowhmh5qN5358v3oZJgIjSr5AzMmgkidd9hpJJ9kV
         2/jtbI963JD2ARE3r72+rrgvRgJ+OqfFGGErnHc213YYUMwcyowUKyE/RtC27j+U+h9W
         +J26qWEXHmXfqYStaiD7sk5fz3QYgcZGmjSw74wc9rZGAumZKoZzZ0LXFALVqD0oZ9Sd
         ijkBU9Yd85/wtzoKCD8EBZYcXkhnPE6Bme6TzTiHtyygEXe7WvHkkpSrMtMSRZctI7Y9
         KKuQ==
X-Gm-Message-State: AOAM5317jlF2BZauXt+kT+IlUcqJQ95eHC36ZNfwjWTotCCazQVAxEQ4
        g5uN2gCYVpKOdN12jfJUQfB+oKvKSoLeHQ==
X-Google-Smtp-Source: ABdhPJwtqh5HJ7ecLjHkRoxypvw4OaVQKpk4alk0k4PG6nmaoBKUSZoSX3NPRX7FHkbhevqkpdwAEg==
X-Received: by 2002:a17:907:20ee:: with SMTP id rh14mr2520821ejb.395.1592310447621;
        Tue, 16 Jun 2020 05:27:27 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id bt11sm3246334edb.48.2020.06.16.05.27.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:27:27 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] mesh: Implement AttachFD method
Date:   Tue, 16 Jun 2020 14:27:45 +0200
Message-Id: <20200616122745.25056-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
References: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh.c  |  12 ++++-
 mesh/model.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 mesh/node.c  |  83 ++++++++++++++++++++++++++++++++-
 mesh/node.h  |   4 +-
 4 files changed, 219 insertions(+), 6 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 4abae4d92..f43d00b7c 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -612,14 +612,18 @@ static void attach_ready_cb(void *user_data, int status, struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
 	struct l_dbus_message *pending_msg;
+	const char *method;
 
 	pending_msg = l_queue_remove_if(pending_queue, simple_match, user_data);
 	if (!pending_msg)
 		return;
 
+	method = l_dbus_message_get_member(pending_msg);
+
 	if (status == MESH_ERROR_NONE) {
 		reply = l_dbus_message_new_method_return(pending_msg);
-		node_build_attach_reply(node, reply);
+		node_build_attach_reply(node, reply,
+						!strcmp(method, "AttachFD"));
 	} else
 		reply = dbus_error(pending_msg, status, "Attach failed");
 
@@ -635,7 +639,7 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	const char *app_path, *sender;
 	struct l_dbus_message *pending_msg;
 
-	l_debug("Attach");
+	l_debug("%s", l_dbus_message_get_member(msg));
 
 	if (!l_dbus_message_get_arguments(msg, "ot", &app_path, &token))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
@@ -846,6 +850,10 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 					"oa(ya(qa{sv}))", "ot", "node",
 					"configuration", "app", "token");
 
+	l_dbus_interface_method(iface, "AttachFD", 0, attach_call,
+					"oa(ya(qa{sv}))h", "ot", "node",
+					"configuration", "fd", "app", "token");
+
 	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
 								"token");
 
diff --git a/mesh/model.c b/mesh/model.c
index 5ed95afac..0bef11e36 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -21,6 +21,8 @@
 #include <config.h>
 #endif
 
+#include <sys/types.h>
+#include <sys/socket.h>
 #include <sys/time.h>
 #include <ell/ell.h>
 
@@ -44,6 +46,33 @@
 
 #define VIRTUAL_BASE			0x10000
 
+enum fd_msg_type {
+	DEV_KEY_MSG = 0,
+	APP_KEY_MSG = 1,
+};
+
+struct fd_msg {
+
+	uint8_t element;
+	uint16_t src;
+
+	enum fd_msg_type type :8;
+	union {
+		struct {
+			uint16_t net_idx;
+			uint8_t remote;
+		} dev;
+
+		struct {
+			uint16_t app_idx;
+			uint16_t dst;
+			uint8_t label[16];
+		} app;
+	};
+
+	uint8_t data[];
+} __attribute__((packed));
+
 struct mesh_model {
 	const struct mesh_model_ops *cbs;
 	void *user_data;
@@ -782,7 +811,50 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 	return MESH_STATUS_SUCCESS;
 }
 
-static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
+static struct fd_msg *fd_msg_new(uint8_t ele_idx, uint16_t src, uint16_t size, const uint8_t *data, enum fd_msg_type type)
+{
+	size_t msg_len = sizeof(struct fd_msg) + size;
+	struct fd_msg *msg = l_malloc(msg_len);
+
+	msg->element = ele_idx;
+	msg->src = src;
+	msg->type = type;
+
+	memcpy(msg->data, data, size);
+
+	return msg;
+}
+
+static void fd_msg_send(struct l_io *io, struct fd_msg *msg, size_t size)
+{
+	struct iovec iov = {
+		.iov_base = msg,
+		.iov_len = sizeof(struct fd_msg) + size,
+	};
+	struct msghdr hdr = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+
+	(void)sendmsg(l_io_get_fd(io), &hdr, MSG_NOSIGNAL);
+
+	l_free(msg);
+}
+
+static void send_fd_dev_key_msg_rcvd(struct l_io *io, uint8_t ele_idx,
+				     uint16_t src, uint16_t app_idx,
+				     uint16_t net_idx, uint16_t size,
+				     const uint8_t *data)
+{
+	struct fd_msg *msg = fd_msg_new(ele_idx, src, size, data, DEV_KEY_MSG);
+
+	msg->dev.net_idx = net_idx;
+	msg->dev.remote = (app_idx != APP_IDX_DEV_LOCAL);
+
+	fd_msg_send(io, msg, size);
+}
+
+static void send_dbus_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 					uint16_t src, uint16_t app_idx,
 					uint16_t net_idx, uint16_t size,
 					const uint8_t *data)
@@ -818,7 +890,40 @@ static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 	l_dbus_send(dbus, msg);
 }
 
-static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
+static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
+				       uint16_t src, uint16_t app_idx,
+				       uint16_t net_idx, uint16_t size,
+				       const uint8_t *data)
+{
+	struct l_io *io = node_get_fd_io(node);
+
+	if (io)
+		send_fd_dev_key_msg_rcvd(io, ele_idx, src, app_idx, net_idx,
+					 size, data);
+	else
+		send_dbus_dev_key_msg_rcvd(node, ele_idx, src, app_idx, net_idx,
+					   size, data);
+}
+
+static void send_fd_msg_rcvd(struct l_io *io, uint8_t ele_idx,
+			     uint16_t src, uint16_t dst,
+			     const struct mesh_virtual *virt,
+			     uint16_t app_idx,
+			     uint16_t size, const uint8_t *data)
+{
+	struct fd_msg *msg = fd_msg_new(ele_idx, src, size, data, APP_KEY_MSG);
+
+	msg->app.app_idx = app_idx;
+	msg->app.dst = dst;
+
+	if (virt)
+		memcpy(msg->app.label, virt, sizeof(msg->app.label));
+
+	fd_msg_send(io, msg, size);
+}
+
+
+static void send_dbus_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 					uint16_t src, uint16_t dst,
 					const struct mesh_virtual *virt,
 					uint16_t app_idx,
@@ -863,6 +968,22 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 	l_dbus_send(dbus, msg);
 }
 
+static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
+			  uint16_t src, uint16_t dst,
+			  const struct mesh_virtual *virt,
+			  uint16_t app_idx,
+			  uint16_t size, const uint8_t *data)
+{
+	struct l_io *io = node_get_fd_io(node);
+
+	if (io)
+		send_fd_msg_rcvd(io, ele_idx, src, dst, virt, app_idx,
+				 size, data);
+	else
+		send_dbus_msg_rcvd(node, ele_idx, src, dst, virt, app_idx,
+				   size, data);
+}
+
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index,
 			uint16_t net_idx, uint16_t src, uint16_t dst,
@@ -986,6 +1107,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 				send_msg_rcvd(node, i, src, dst, decrypt_virt,
 						forward.app_idx, forward.size,
 						forward.data);
+
 			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
 				 decrypt_idx == APP_IDX_DEV_LOCAL)
 				send_dev_key_msg_rcvd(node, i, src, decrypt_idx,
diff --git a/mesh/node.c b/mesh/node.c
index 6140fdf9f..e00bed785 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -26,6 +26,8 @@
 #include <limits.h>
 #include <stdio.h>
 #include <sys/time.h>
+#include <sys/socket.h>
+#include <unistd.h>
 
 #include <ell/ell.h>
 
@@ -105,6 +107,7 @@ struct mesh_node {
 	uint8_t proxy;
 	uint8_t friend;
 	uint8_t beacon;
+	struct l_io *fd_io;
 };
 
 struct node_import {
@@ -260,6 +263,7 @@ static void set_defaults(struct mesh_node *node)
 							MESH_MODE_UNSUPPORTED;
 	node->ttl = TTL_MASK;
 	node->seq_number = DEFAULT_SEQUENCE_NUMBER;
+	node->fd_io = NULL;
 }
 
 static struct mesh_node *node_new(const uint8_t uuid[16])
@@ -341,6 +345,13 @@ static void free_node_resources(void *data)
 	mesh_agent_remove(node->agent);
 	mesh_config_release(node->cfg);
 	mesh_net_free(node->net);
+
+	if (node->fd_io)
+	{
+		l_io_destroy(node->fd_io);
+		node->fd_io = NULL;
+	}
+
 	l_free(node->storage_dir);
 	l_free(node);
 }
@@ -745,6 +756,11 @@ uint16_t node_get_crpl(struct mesh_node *node)
 	return node->comp.crpl;
 }
 
+struct l_io *node_get_fd_io(struct mesh_node *node)
+{
+	return node->fd_io;
+}
+
 uint8_t node_relay_mode_get(struct mesh_node *node, uint8_t *count,
 							uint16_t *interval)
 {
@@ -1650,6 +1666,53 @@ static void send_managed_objects_request(const char *destination,
 					req, l_free, DEFAULT_DBUS_TIMEOUT);
 }
 
+static void fd_io_hup(struct l_io *io, void *user_data)
+{
+	struct mesh_node *node = user_data;
+
+	node->fd_io = NULL;
+
+	l_io_destroy(io);
+}
+
+static struct l_io *fd_io_new(struct mesh_node *node, int *fd)
+{
+	struct l_io *io;
+	int fds[2];
+
+	if (socketpair(AF_LOCAL, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC,
+		       0, fds) < 0)
+	{
+		return NULL;
+	}
+
+	io = l_io_new(fds[0]);
+	if (!io)
+	{
+		goto fail;
+	}
+
+	l_io_set_close_on_destroy(io, true);
+
+	if (!l_io_set_disconnect_handler(io, fd_io_hup, node, NULL))
+	{
+		goto fail;
+	}
+
+	*fd = fds[1];
+
+	return io;
+
+fail:
+	if (io)
+		l_io_destroy(io);
+
+	close(fds[0]);
+	close(fds[1]);
+
+	return NULL;
+}
+
 /* Establish relationship between application and mesh node */
 void node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data)
@@ -1770,8 +1833,16 @@ static void build_element_config(void *a, void *b)
 	l_dbus_message_builder_leave_struct(builder);
 }
 
+static void append_fd(struct l_dbus_message_builder *builder, ...)
+{
+	va_list args;
+	va_start(args, builder);
+	l_dbus_message_builder_append_from_valist(builder, "h", args);
+	va_end(args);
+}
+
 void node_build_attach_reply(struct mesh_node *node,
-						struct l_dbus_message *reply)
+				struct l_dbus_message *reply, bool use_fd)
 {
 	struct l_dbus_message_builder *builder;
 
@@ -1784,6 +1855,16 @@ void node_build_attach_reply(struct mesh_node *node,
 	l_dbus_message_builder_enter_array(builder, "(ya(qa{sv}))");
 	l_queue_foreach(node->elements, build_element_config, builder);
 	l_dbus_message_builder_leave_array(builder);
+
+	if (use_fd)
+	{
+		int fd = -1;
+		node->fd_io = fd_io_new(node, &fd);
+		append_fd(builder, fd);
+
+		close(fd);
+	}
+
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 }
diff --git a/mesh/node.h b/mesh/node.h
index e26d410c8..6d0696824 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -23,6 +23,7 @@ struct mesh_io;
 struct mesh_agent;
 struct mesh_config;
 struct mesh_config_node;
+struct l_io;
 
 typedef void (*node_ready_func_t) (void *user_data, int status,
 							struct mesh_node *node);
@@ -77,13 +78,14 @@ uint8_t node_friend_mode_get(struct mesh_node *node);
 const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx);
 const char *node_get_owner(struct mesh_node *node);
 const char *node_get_app_path(struct mesh_node *node);
+struct l_io *node_get_fd_io(struct mesh_node *node);
 bool node_add_pending_local(struct mesh_node *node, void *info);
 void node_attach_io_all(struct mesh_io *io);
 void node_attach_io(struct mesh_node *node, struct mesh_io *io);
 void node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data);
 void node_build_attach_reply(struct mesh_node *node,
-						struct l_dbus_message *reply);
+				struct l_dbus_message *reply, bool use_fd);
 void node_create(const char *app_root, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
 void node_import(const char *app_root, const char *sender, const uint8_t *uuid,
-- 
2.20.1

