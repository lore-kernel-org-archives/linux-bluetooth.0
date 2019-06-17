Return-Path: <SRS0=uXJ1=UQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E0C31E50
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jun 2019 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E039B20657
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jun 2019 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="G9uN+D4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfFQNlu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:41:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34313 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNlu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jun 2019 09:41:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so6552759lfa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2019 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtAXiR8N/UUw6knbRAieEdR+xTARoHPg8goEVix0+AE=;
        b=G9uN+D4SzCTvUTN+cSwVVxFxJa7fyuVMASlRTOyen6AuO+SVoJ6RLOLcdqj+XJs/IJ
         1bMdexWP4xH5lO57xlmhgzKbXF/qMDZeC4KmQU4VrvTlQ8oVkIAyLSbC3YKn50/Qu/9v
         TiDzmMCV6KjxmA7wQlv3sQkFKrqCuc/Kt9ibJCO0qNMUWGV0VZZKSTxwHkQaIMQ1Twbl
         IcgqhZCgu70T5+DnWmP5AqsukKNTEPBazgcgI/A+fUSnOLWlUJ6I4M8MaU7rCnAqeaG9
         z8L39gTbQffvCRvVilOUxyDhMaPAjKBXxAaUinwuCc3+EtMPDzBbMYKDg46/+cY6SHxH
         xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtAXiR8N/UUw6knbRAieEdR+xTARoHPg8goEVix0+AE=;
        b=Wxk3WjD/M+1y7ilhhwG2LFpZZSJkxfMItfp+fNZcGWurD5yrow3vDamD7TCLCQaV9v
         5pwJGXU9S2BsSplL/EIPzxars2ctooWtJCaLqkDOWFmEByCNvp6Y92Zb63Plzb50vv5h
         XDH13t+b50Z3kuIsEgRGXxoHUqHw7Ett2FsROPS7OittCv8oXRkx+Hj0UTw2p0synMAm
         c8gUrItxeRqDrvx333C6YtrNwsgwRT2TLC7cm6rD/rasHycJEsKH9Ny94sr0yip0MVje
         4EhmtR3qR5744flzpGpa74KeKKJiLLwNGCS3zLIQ2lWH8Be1hSCMHU6MIGp1N81of/Tq
         F8vw==
X-Gm-Message-State: APjAAAWZNx5+PCAuh1WHFRc+5ntDJ79tescYudRKzphYIBQmoUC1kMZz
        KwrqQY0zG+wHulNJonfloHauCroQcmmmZw==
X-Google-Smtp-Source: APXvYqw+T6eLweJxeUDjwIp8BA9oMc1UvZMQy9SZB1UiLe6lPBYbnHxK5Jp5Y0eX+walfGi2hvs1eA==
X-Received: by 2002:a19:671c:: with SMTP id b28mr3316598lfc.164.1560778907949;
        Mon, 17 Jun 2019 06:41:47 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n1sm1786555lfk.19.2019.06.17.06.41.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 06:41:47 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH] mesh: Return dbus error code on Leave() with invalit token given
Date:   Mon, 17 Jun 2019 15:41:41 +0200
Message-Id: <20190617134141.575-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements MESH_ERROR_NOT_FOUND error when we try to call Leave()
from dbus api with incorrect token value (ex. Leave(0))
---
 mesh/mesh.c    | 10 +++++-----
 mesh/node.c    |  7 +++++--
 mesh/node.h    |  2 +-
 mesh/storage.c |  4 ++--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 231a6bca4..f10b73331 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -65,7 +65,7 @@ struct bt_mesh {
 	uint8_t max_filters;
 };
 
-struct join_data{
+struct join_data {
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
 	const char *sender;
@@ -355,7 +355,7 @@ static void free_pending_join_call(bool failed)
 	mesh_agent_remove(join_pending->agent);
 
 	if (failed)
-		node_remove(join_pending->node);
+		(void)node_remove(join_pending->node);
 
 	l_free(join_pending);
 	join_pending = NULL;
@@ -530,8 +530,7 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 
 	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
 				mesh.prov_timeout, agent, prov_complete_cb,
-				&mesh))
-	{
+				&mesh)) {
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning acceptor");
 		goto fail;
@@ -696,7 +695,8 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	if (!l_dbus_message_get_arguments(msg, "t", &token))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	node_remove(node_find_by_token(token));
+	if (!node_remove(node_find_by_token(token)))
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
 }
diff --git a/mesh/node.c b/mesh/node.c
index e99858623..2b9978908 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -256,11 +256,12 @@ static void free_node_resources(void *data)
 /*
  * This function is called to free resources and remove the
  * configuration files for the specified node.
+ * The false is returned when there is no node to be removed
  */
-void node_remove(struct mesh_node *node)
+bool node_remove(struct mesh_node *node)
 {
 	if (!node)
-		return;
+		return false;
 
 	l_queue_remove(nodes, node);
 
@@ -268,6 +269,7 @@ void node_remove(struct mesh_node *node)
 		storage_remove_node_config(node);
 
 	free_node_resources(node);
+	return true;
 }
 
 static bool add_models(struct mesh_node *node, struct node_element *ele,
@@ -1078,6 +1080,7 @@ static bool validate_model_property(struct node_element *ele,
 		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
 								&mod_id)) {
 			struct mesh_model *mod;
+
 			mod = l_queue_find(ele->models, match_model_id,
 				L_UINT_TO_PTR((vendor_id << 16) | mod_id));
 			if (!mod)
diff --git a/mesh/node.h b/mesh/node.h
index 142527b30..5f045ee2d 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -34,7 +34,7 @@ typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
 struct mesh_node *node_new(const uint8_t uuid[16]);
-void node_remove(struct mesh_node *node);
+bool node_remove(struct mesh_node *node);
 void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
 uint8_t *node_uuid_get(struct mesh_node *node);
diff --git a/mesh/storage.c b/mesh/storage.c
index 1a9945aa8..7ae0ac5b1 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -77,7 +77,7 @@ static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 	uint8_t *uuid;
 
 	if (!node_init_from_storage(node, db_node)) {
-		node_remove(node);
+		(void)node_remove(node);
 		return false;
 	}
 
@@ -220,7 +220,7 @@ static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 
 	if (!result) {
 		json_object_put(jnode);
-		node_remove(node);
+		(void)node_remove(node);
 	}
 
 	node_jconfig_set(node, jnode);
-- 
2.20.1

