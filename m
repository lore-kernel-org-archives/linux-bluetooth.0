Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E12FC33CB3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E718B20678
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="qfsf2+iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgA3Oei (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:34:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34954 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgA3Oeh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 09:34:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so4511342wmb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+CcPEBgHGsNQE6ylPPKFriDFM9lo0brzFEEYjimckF4=;
        b=qfsf2+iZs9TnFVRJ3p52x7nh4i3haW9gjYcuBx0gPiV2r98f+NQjxOe/4BgLRBkzC2
         ngB4UVwT0Op/BUu6tnuviW2xAoFirWzyp+lE2WwvtSYn6JBDhEFHsNtezSmuw5jKVKch
         4SF9s+G7uBjBzPQkm5aSzqzpZDAsjMHQ1oteRmCuecOfis8twPx6O9Ulqh/YJY7Bd/p4
         YK/hFdcCd0edW+z3SpTiMTfItDIFAhSXBWFEMfQJu9wsDBdLXZ6+QyWyeJ180En73x9V
         i1j+dwqPrUN5rUt1J7ZxDK13WwHlMOQRlW12VmlGCsKdGZ7TkEpnsUBEL9fYN+YOY6A/
         3dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CcPEBgHGsNQE6ylPPKFriDFM9lo0brzFEEYjimckF4=;
        b=IdMFaPnyjO4rJx0785FQEuyO+ms8BjREScYwLi8QONNF5tFxE9mM0JW/qcHOfXuy4/
         8jZqqvPFl0jeF8ux2ev1Csjpq/MV5LodFS7fNe5kLfQcaaTtqENM/9gf2GDavWVOjmJm
         OKlbgIc8VSgqfLSAzapfbv9F3xAqs0MC9U7Tjh/GNSi+ioBehMlV7TdqeDq9ueGHQLEH
         lU2JysPFsNxwkJWYUrWPpl9lMNbPFNMDiUuSyFAavMB2DjZZq2OEZ5N1WQgE9GMOFE5Y
         CAt+zF0mPFlc5+EFApho5tAkmSLlVC/a4sQl0hblq0IYavmvFqnzREdwxiizo+jryzoY
         Amnw==
X-Gm-Message-State: APjAAAUZP8MkWmt0IDwx7kRbrxDh8FOwA+bAn4zfyieapqfQRpc9KCck
        n7KuDyl+dpwZZGjjbnc1Wj3+Qxtjvzom2Q==
X-Google-Smtp-Source: APXvYqwOHt0EToU3AFNIbZGEvQL+Aem3wn1mhhdrMTUvjDZwkNZVfVPtREeX0G7aTlYoQmWwT7GkRQ==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr6190618wmh.71.1580394872276;
        Thu, 30 Jan 2020 06:34:32 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x10sm7353310wrv.60.2020.01.30.06.34.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:34:31 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] mesh: use static node_comp instead of the pointer
Date:   Thu, 30 Jan 2020 15:34:22 +0100
Message-Id: <20200130143425.5844-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130143425.5844-1-jakub.witowski@silvair.com>
References: <20200130143425.5844-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is no need to use the pointer to the node_comp data.
This pach uses static node_comp instead.
---
 mesh/node.c | 56 +++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index de6e74c4f..6fe70742d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -90,7 +90,7 @@ struct mesh_node {
 	uint32_t seq_number;
 	bool provisioner;
 	uint16_t primary;
-	struct node_composition *comp;
+	struct node_composition comp;
 	struct {
 		uint16_t interval;
 		uint8_t cnt;
@@ -336,7 +336,6 @@ static void free_node_resources(void *data)
 	free_node_dbus_resources(node);
 
 	mesh_net_free(node->net);
-	l_free(node->comp);
 	l_free(node->storage_dir);
 	l_free(node);
 }
@@ -503,11 +502,10 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 
 	l_queue_push_tail(nodes, node);
 
-	node->comp = l_new(struct node_composition, 1);
-	node->comp->cid = db_node->cid;
-	node->comp->pid = db_node->pid;
-	node->comp->vid = db_node->vid;
-	node->comp->crpl = db_node->crpl;
+	node->comp.cid = db_node->cid;
+	node->comp.pid = db_node->pid;
+	node->comp.vid = db_node->vid;
+	node->comp.crpl = db_node->crpl;
 	node->lpn = db_node->modes.lpn;
 
 	node->proxy = db_node->modes.proxy;
@@ -753,7 +751,7 @@ uint16_t node_get_crpl(struct mesh_node *node)
 	if (!node)
 		return 0;
 
-	return node->comp->crpl;
+	return node->comp.crpl;
 }
 
 uint8_t node_relay_mode_get(struct mesh_node *node, uint8_t *count,
@@ -886,18 +884,18 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 	uint16_t num_ele = 0;
 	const struct l_queue_entry *ele_entry;
 
-	if (!node || !node->comp || sz < MIN_COMP_SIZE)
+	if (!node || sz < MIN_COMP_SIZE)
 		return 0;
 
 	n = 0;
 
-	l_put_le16(node->comp->cid, buf + n);
+	l_put_le16(node->comp.cid, buf + n);
 	n += 2;
-	l_put_le16(node->comp->pid, buf + n);
+	l_put_le16(node->comp.pid, buf + n);
 	n += 2;
-	l_put_le16(node->comp->vid, buf + n);
+	l_put_le16(node->comp.vid, buf + n);
 	n += 2;
-	l_put_le16(node->comp->crpl, buf + n);
+	l_put_le16(node->comp.crpl, buf + n);
 	n += 2;
 
 	features = 0;
@@ -1198,10 +1196,10 @@ static void convert_node_to_storage(struct mesh_node *node,
 {
 	const struct l_queue_entry *entry;
 
-	db_node->cid = node->comp->cid;
-	db_node->pid = node->comp->pid;
-	db_node->vid = node->comp->vid;
-	db_node->crpl = node->comp->crpl;
+	db_node->cid = node->comp.cid;
+	db_node->pid = node->comp.pid;
+	db_node->vid = node->comp.vid;
+	db_node->crpl = node->comp.crpl;
 	db_node->modes.lpn = node->lpn;
 	db_node->modes.proxy = node->proxy;
 
@@ -1285,29 +1283,28 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 
 	l_debug("path %s", path);
 
-	node->comp = l_new(struct node_composition, 1);
-	node->comp->crpl = mesh_get_crpl();
+	node->comp.crpl = mesh_get_crpl();
 
 	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
 		if (!cid && !strcmp(key, "CompanyID")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->cid))
-				goto fail;
+							&node->comp.cid))
+				return false;
 			cid = true;
 			continue;
 		}
 
 		if (!pid && !strcmp(key, "ProductID")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->pid))
-				goto fail;
+							&node->comp.pid))
+				return false;
 			pid = true;
 			continue;
 		}
 
 		if (!vid && !strcmp(key, "VersionID")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->vid))
+							&node->comp.vid))
 				return false;
 			vid = true;
 			continue;
@@ -1315,21 +1312,16 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 
 		if (!strcmp(key, "CRPL")) {
 			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->crpl))
-				goto fail;
+							&node->comp.crpl))
+				return false;
 			continue;
 		}
 	}
 
 	if (!cid || !pid || !vid)
-		goto fail;
+		return false;
 
 	return true;
-fail:
-	l_free(node->comp);
-	node->comp = NULL;
-
-	return false;
 }
 
 static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
-- 
2.20.1

