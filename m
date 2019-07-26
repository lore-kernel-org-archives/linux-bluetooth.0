Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63CC41517
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396F1218DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="G3MtroM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfGZGgQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:36:16 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:33677 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZGgQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 02:36:16 -0400
Received: by mail-lf1-f42.google.com with SMTP id x3so36380184lfc.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KqLn8+bE/vEKaDQwLsUmWvs20QwlNFeyMYxnmAqou2s=;
        b=G3MtroM5LejJOVC5CyMoLxuqvWEbTCUbqE7lbb/mUpxDALXq8sJSmJgeO1e9vmkj49
         G7LY9xszRULbPHgtJGCqKKNWBBV9wqPTDHNEHjDt8iKNG44VPdbFrBPoxy8comNYl3Kg
         q4A9Iu10PKkHB4XPC2ieT27vd/KGHMoUHqdmdsKNNQKH4ovnoObg+HZmedPCu2HQ3f7N
         xNAq/nxMKHooVUozVELEk5gw5K9AMCIzlgCy76N1j9zXVsaGXphStUi2T5/vuEwb4r8u
         oMnzUzUtyVwNOu/vIL3ts8pbWaLI5fQhBcUPu1vdbbCrT0t/5TEmoGW+73/cs2kWPJNq
         bLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqLn8+bE/vEKaDQwLsUmWvs20QwlNFeyMYxnmAqou2s=;
        b=t5o+H5J1KnNcI/vcREmzMPRCKlFw7qlkRGiBr/Y1PnC26yjoN1/DWmLlpUl9EFMhC1
         EriJEImtpV0Ml9AXvkmOUCcNp4ogEqiomMQf5E5dJ4SlImwEiR6G29RXk8jLDakjjkFH
         NeU7cRcHMmkS8X0lX5uzdNw7MfifstHSqbDxrUv5w3GYbn/+1G21lZDwoj+FZlqRD5eD
         IH1FuiRCVmNZzYT+nYfqAHun0fazehQM4jJ/D8u0Gt02ybBtjT5hvVb+TVXHI3SqaIcR
         PvjCVReIirGFiP37bOaRmrD+U1YBKeocet69hkgBfKmzwEM6drZ0Ul0QnZI2LwZPdEal
         769Q==
X-Gm-Message-State: APjAAAU4WBxTJmZpL7pHJYA/Y17d80bcqySlUgRgrAhvuodF314ThPsq
        iNNkpuTTRwJ0OaEkLupTlEFQydxQ8N0=
X-Google-Smtp-Source: APXvYqxo0cRCoqb5B//ZXijfCsty8/oo2HP0mChryrtpWlT96pAxx/IxpVxqLqcY4ZETeRo3JO6BGg==
X-Received: by 2002:ac2:5c1d:: with SMTP id r29mr39885894lfp.72.1564122974134;
        Thu, 25 Jul 2019 23:36:14 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm8039109lfq.76.2019.07.25.23.36.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 23:36:13 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 1/5] mesh: Convert void pointers to anonymous unions in managed_obj_request
Date:   Fri, 26 Jul 2019 08:36:02 +0200
Message-Id: <20190726063606.19359-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
References: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
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

