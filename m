Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26102C76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598022BF5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hrMJ3XcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbfGYIOf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:14:35 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:43882 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389116AbfGYIOf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:35 -0400
Received: by mail-lf1-f42.google.com with SMTP id c19so33847471lfm.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KqLn8+bE/vEKaDQwLsUmWvs20QwlNFeyMYxnmAqou2s=;
        b=hrMJ3XcCsQids4Fp7guMmMlxDmYKx3PJlPoj/oU78fco4/SilgTXoJZUMK0DmmlOQf
         Mnw/ZcHNcOXaQ9mv287Dkg35FRy/9JQKP1HB+fQRJZcpQCoezIBsXluMepy5wYtAQf6o
         JDhdhH9s9wuQfdKTnwJK5v4mOuR9+1X4zndtMyM2OuOuVE+ImCWlI3JOWgCIcQ6ytJ7Z
         wZN1u5pqFFpQf7Wh55iSXorPFEZDkEajkgR+Ax4ykXs/SBw1e2aPCOaC0fkHK8jhmckO
         NeQwH+WjOpSB/bxa4j2L5cLCJMQDi9EpN4NmbnTSlxc48bJXYhi8lcTblBZoJlvNJJmW
         /SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqLn8+bE/vEKaDQwLsUmWvs20QwlNFeyMYxnmAqou2s=;
        b=WcUcPRhWtctN50YW/fTMlt79bZHrvpc2ah5kyU/fxXS9N8eApBMsdljQNJMx5KQLN9
         Lr2PbXG1mM38U176qKcUodnhFWdDUqvxJZ0UqabPDa1gpgSU/k50OYqRI2BSVV6nKysY
         D3+zPRbH5HXIf5xYgwgJS3EZTduAqevf7cBu3LiKUk4GS4AcXahapvDowX0IzZYn82Tj
         e0ljfOcs0D4tLyHIgydHe3FSpUHQW7ZKXxZmwWQG58ZeGKxJOieOPb7HzgFR4elS0LFd
         4L9TgSKropo83Dkkb4Bk3l4DMf6qPu6x8VY3Dkzm4Jdp8mcMs9qadzRZnUGabtVQ7iVG
         AOfw==
X-Gm-Message-State: APjAAAVNhKpoKghCsOgevlzF2eefXOAFAoyFzebUA6F7AvsZnAzjkaUr
        5MKwGfvleaxdXsJjG/iTAXm34S9pBdk=
X-Google-Smtp-Source: APXvYqwvakYLz82E3im5O1OHVi3g096XAb0At3IEEu1lB/qhIHslFwwT4qDkbjSg7B3XeKTKb4Fwfw==
X-Received: by 2002:a05:6512:48f:: with SMTP id v15mr9629310lfq.37.1564042472293;
        Thu, 25 Jul 2019 01:14:32 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm9015251ljf.44.2019.07.25.01.14.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:14:31 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] mesh: Convert void pointers to anonymous unions in managed_obj_request
Date:   Thu, 25 Jul 2019 10:14:20 +0200
Message-Id: <20190725081424.22621-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
References: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 75 +++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index ceb46e4df..e51913edf 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -58,9 +58,11 @@
 #define DEFAULT_CRPL 10
 #define DEFAULT_SEQUENCE_NUMBER 0
 
-#define REQUEST_TYPE_JOIN 0
-#define REQUEST_TYPE_ATTACH 1
-#define REQUEST_TYPE_CREATE 2
+enum request_type {
+	REQUEST_TYPE_JOIN,
+	REQUEST_TYPE_ATTACH,
+	REQUEST_TYPE_CREATE,
+};
 
 struct node_element {
 	char *path;
@@ -110,10 +112,16 @@ struct mesh_node {
 };
 
 struct managed_obj_request {
-	void *data;
-	void *cb;
-	void *user_data;
-	uint8_t type;
+	union {
+		const uint8_t *uuid;
+		struct mesh_node *node;
+	};
+	union {
+		node_ready_func_t ready_cb;
+		node_join_ready_func_t join_ready_cb;
+	};
+	struct l_dbus_message *pending_msg;
+	enum request_type type;
 };
 
 static struct l_queue *nodes;
@@ -1571,7 +1579,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		node = l_new(struct mesh_node, 1);
 		node->elements = l_queue_new();
 	} else {
-		node = req->data;
+		node = req->node;
 	}
 
 	num_ele = 0;
@@ -1642,8 +1650,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 	if (req->type == REQUEST_TYPE_ATTACH) {
-		node_ready_func_t cb = req->cb;
-
 		if (num_ele != node->num_ele)
 			goto fail;
 
@@ -1652,7 +1658,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 			node->disc_watch = l_dbus_add_disconnect_watch(bus,
 					node->owner, app_disc_cb, node, NULL);
-			cb(req->user_data, MESH_ERROR_NONE, node);
+			req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 		} else
 			goto fail;
 
@@ -1665,8 +1671,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		init_storage_dir(node);
 
 	} else if (req->type == REQUEST_TYPE_JOIN) {
-		node_join_ready_func_t cb = req->cb;
-
 		if (!agent) {
 			l_error("Interface %s not found",
 						MESH_PROVISION_AGENT_INTERFACE);
@@ -1675,22 +1679,20 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 		node->num_ele = num_ele;
 		set_defaults(node);
-		memcpy(node->uuid, req->data, 16);
+		memcpy(node->uuid, req->uuid, 16);
 
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
-		cb(node, agent);
-
+		req->join_ready_cb(node, agent);
 	} else {
 		/* Callback for create node request */
-		node_ready_func_t cb = req->cb;
 		struct keyring_net_key net_key;
 		uint8_t dev_key[16];
 
 		node->num_ele = num_ele;
 		set_defaults(node);
-		memcpy(node->uuid, req->data, 16);
+		memcpy(node->uuid, req->uuid, 16);
 
 		if (!create_node_config(node, node->uuid))
 			goto fail;
@@ -1717,7 +1719,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-		cb(req->user_data, MESH_ERROR_NONE, node);
+		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 	}
 
 	return;
@@ -1726,26 +1728,19 @@ fail:
 		mesh_agent_remove(agent);
 
 	if (!is_new) {
-		/* Handle failed Attach request */
-		node_ready_func_t cb = req->cb;
-
 		free_node_dbus_resources(node);
 
-		cb(req->user_data, MESH_ERROR_FAILED, node);
+		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, node);
 	} else {
 		/* Handle failed Join and Create requests */
 		if (node)
 			node_remove(node);
 
-		if (req->type == REQUEST_TYPE_JOIN) {
-			node_join_ready_func_t cb = req->cb;
-
-			cb(NULL, NULL);
-		} else {
-			node_ready_func_t cb = req->cb;
-
-			cb(req->user_data, MESH_ERROR_FAILED, NULL);
-		}
+		if (req->type == REQUEST_TYPE_JOIN)
+			req->join_ready_cb(NULL, NULL);
+		else
+			req->ready_cb(req->pending_msg, MESH_ERROR_FAILED,
+									NULL);
 	}
 }
 
@@ -1770,9 +1765,9 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	node->owner = l_strdup(sender);
 
 	req = l_new(struct managed_obj_request, 1);
-	req->data = node;
-	req->cb = cb;
-	req->user_data = user_data;
+	req->node = node;
+	req->ready_cb = cb;
+	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_ATTACH;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
@@ -1794,8 +1789,8 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 	l_debug("");
 
 	req = l_new(struct managed_obj_request, 1);
-	req->data = (void *) uuid;
-	req->cb = cb;
+	req->uuid = uuid;
+	req->join_ready_cb = cb;
 	req->type = REQUEST_TYPE_JOIN;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
@@ -1813,9 +1808,9 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 	l_debug("");
 
 	req = l_new(struct managed_obj_request, 1);
-	req->data = (void *) uuid;
-	req->cb = cb;
-	req->user_data = user_data;
+	req->uuid = uuid;
+	req->ready_cb = cb;
+	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
-- 
2.19.1

