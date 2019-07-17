Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09AC76192
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2396920818
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="jssnYUHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfGQIhM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:37:12 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44462 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIhM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 04:37:12 -0400
Received: by mail-lf1-f44.google.com with SMTP id r15so10913177lfm.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9/TnBhjqofSLZTuk4X2e91/4T2StXPyjA/joZ3UiOEU=;
        b=jssnYUHSX0W/BDI3tzTvnBPx3ojFGsz3BRv6b4xFniMtcPZQH8Lt+h8jvUtNoztII5
         IIJsGvWMRhTZ1i5VgrFV2UR/Hf/vq0N1rgQQIm2xW0svX5Bol5nFgy39xnhBmWoOI1K5
         +jFEN4tLn8ifJ1EpKTqSZX9DN3Of8u6aVp6UTYlWBJzdRmEveqMvCS3HWXskYRsBoG/4
         z0tnEpINg1f6Vi/rbwEd5tD0Drjxd3vKxM7N15smurQNILHN1CeeUuYHelCgG7kJ6kdY
         z201pJ9eoE9iwBSJVVP+bwJqYCcvIXNfF17i2NlLToX4deU5DNmoBmSCHMP72slc3ntM
         9Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/TnBhjqofSLZTuk4X2e91/4T2StXPyjA/joZ3UiOEU=;
        b=pFHVpfWFhtfdQv2PJjOnYnFbAfV2gneNOOjKrSyIp390KsIN/aoprFvLXvOfJ4M2sB
         mPoN/bPRKQJuv7pXjaZW9isjh8md40vxd4RWhyRTeNIt+Q2pIXyj6wmM330B1h4QN9MD
         cpvX1baA3N8M12065/byDD641qO/ibWe1rxjoNU82Gi8vZteMJJE3qvzCtoDi94ORapY
         G27qIWRwaTvc1lnc00/iE2F2DL0SVTwjXYlc5BnjTkyblKAhfifZrTRiQ8jug29W8RI/
         HnZNoycUS2/f66awWHPOTBQb/3BwnaT7MobgHh0xNa+8v2DuTq0AYuGb5ZMVDKsaNydr
         OmpA==
X-Gm-Message-State: APjAAAXK3CYrbT0bZftcsZvH5tZAmr9XzzDTGUmLb5s51M+TojO9vrGC
        HndSKuyrXQUUna677RzzVeXvFBulPCs=
X-Google-Smtp-Source: APXvYqzV6anmdROxJv75hJ39CGN8zEuGV3frWyupsu3E5pC8APYcZ0CphlRtWDrOxGWy5BwV+ST6MA==
X-Received: by 2002:a19:7f17:: with SMTP id a23mr18567449lfd.49.1563352629996;
        Wed, 17 Jul 2019 01:37:09 -0700 (PDT)
Received: from localhost.localdomain ([31.0.84.191])
        by smtp.gmail.com with ESMTPSA id v202sm3338708lfa.28.2019.07.17.01.37.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:37:09 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 4/4] mesh: Convert void pointers to anonymous unions in managed_obj_request:wq
Date:   Wed, 17 Jul 2019 10:36:50 +0200
Message-Id: <20190717083650.26346-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 69 +++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index d1b37a5da..d631b9324 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -112,8 +112,14 @@ struct mesh_node {
 };
 
 struct managed_obj_request {
-	void *data;
-	void *cb;
+	union {
+		const uint8_t *uuid;
+		struct mesh_node *node;
+	};
+	union {
+		node_ready_func_t ready_cb;
+		node_join_ready_func_t join_ready_cb;
+	};
 	struct l_dbus_message *pending_msg;
 	enum request_type type;
 	struct mesh_config_import *import;
@@ -1571,10 +1577,10 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 	if (is_new) {
-		node = node_new(req->data);
+		node = node_new(req->uuid);
 		node->elements = l_queue_new();
 	} else {
-		node = req->data;
+		node = req->node;
 	}
 
 	num_ele = 0;
@@ -1644,8 +1650,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 	if (req->type == REQUEST_TYPE_ATTACH) {
-		node_ready_func_t cb = req->cb;
-
 		if (num_ele != node->num_ele)
 			goto fail;
 
@@ -1654,13 +1658,11 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 			node->disc_watch = l_dbus_add_disconnect_watch(bus,
 					node->owner, app_disc_cb, node, NULL);
-			cb(req->pending_msg, MESH_ERROR_NONE, node);
+			req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 		} else
 			goto fail;
 
 	} else if (req->type == REQUEST_TYPE_JOIN) {
-		node_join_ready_func_t cb = req->cb;
-
 		if (!agent) {
 			l_error("Interface %s not found",
 						MESH_PROVISION_AGENT_INTERFACE);
@@ -1669,16 +1671,14 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 		node->num_ele = num_ele;
 		set_defaults(node);
-		memcpy(node->uuid, req->data, 16);
+		memcpy(node->uuid, req->uuid, 16);
 
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
-		cb(node, agent);
+		req->join_ready_cb(node, agent);
 
 	} else if (req->type == REQUEST_TYPE_IMPORT) {
-
-		node_ready_func_t cb = req->cb;
 		struct mesh_config_import *import = req->import;
 		struct keyring_net_key net_key;
 
@@ -1694,7 +1694,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (node->seq_number != import->node->seq_number)
 			node->seq_number = import->node->seq_number;
 
-		memcpy(node->uuid, req->data, 16);
+		memcpy(node->uuid, req->uuid, 16);
 
 		if (!create_node_config(node, node->uuid))
 			goto fail;
@@ -1719,17 +1719,16 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!keyring_put_net_key(node, import->net_key.idx, &net_key))
 			goto fail;
 
-		cb(req->pending_msg, MESH_ERROR_NONE, node);
+		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 
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
@@ -1756,7 +1755,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-		cb(req->pending_msg, MESH_ERROR_NONE, node);
+		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
 	}
 
 	return;
@@ -1765,26 +1764,18 @@ fail:
 		mesh_agent_remove(agent);
 
 	if (!is_new) {
-		/* Handle failed Attach request */
-		node_ready_func_t cb = req->cb;
-
 		free_node_dbus_resources(node);
 
-		cb(req->pending_msg, MESH_ERROR_FAILED, node);
+		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, node);
 	} else {
 		/* Handle failed Join, Create and Import requests */
 		if (node)
 			node_remove(node);
 
-		if (req->type == REQUEST_TYPE_JOIN) {
-			node_join_ready_func_t cb = req->cb;
-
-			cb(NULL, NULL);
-		} else {
-			node_ready_func_t cb = req->cb;
-
-			cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
-		}
+		if (req->type == REQUEST_TYPE_JOIN)
+			req->join_ready_cb(NULL, NULL);
+		else
+			req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
 	}
 }
 
@@ -1809,8 +1800,8 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	node->owner = l_strdup(sender);
 
 	req = l_new(struct managed_obj_request, 1);
-	req->data = node;
-	req->cb = cb;
+	req->node = node;
+	req->ready_cb = cb;
 	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_ATTACH;
 
@@ -1833,8 +1824,8 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 	l_debug("");
 
 	req = l_new(struct managed_obj_request, 1);
-	req->data = (void *) uuid;
-	req->cb = cb;
+	req->uuid = uuid;
+	req->join_ready_cb = cb;
 	req->type = REQUEST_TYPE_JOIN;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
@@ -1859,8 +1850,8 @@ bool node_import(const char *app_path, const char *sender,
 
 	req = l_new(struct managed_obj_request, 1);
 
-	req->data = (void *) uuid;
-	req->cb = cb;
+	req->uuid = uuid;
+	req->ready_cb = cb;
 	req->pending_msg = user_data;
 	req->import = import;
 	req->type = REQUEST_TYPE_IMPORT;
@@ -1881,8 +1872,8 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 	l_debug("");
 
 	req = l_new(struct managed_obj_request, 1);
-	req->data = (void *) uuid;
-	req->cb = cb;
+	req->uuid = uuid;
+	req->ready_cb = cb;
 	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
 
-- 
2.19.1

