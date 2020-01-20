Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44175C33CAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A22C217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="V+9WCsDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgATQLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:11:25 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35715 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgATQLZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 11:11:25 -0500
Received: by mail-wm1-f48.google.com with SMTP id p17so168910wmb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2020 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q+g/aSjL3uLfQBu1JYiGuPibTEA/dL+Z5V+giBpy5ss=;
        b=V+9WCsDSB7vcl/AAug4BXYoxdeVxG1NnfbvgufCYLzXnA1N2Dt0NOJliF5vPWtzYN5
         iei7iUEcth0KAdTvPfXnOxflgKlaPiqH9U5sDmFuV8u5g1LDOEO02H+05k5rMI7cazBB
         lG9qDmu0Z/+810FF77DvjoEnyupdf7RWlhgYdZ6jN9MRsJAuYArKTydux+s0XznThe5A
         PwokFRv6Fmi/dYb5V8JRK//GcrGzLP6/dqBsD7nn8If+TbgrrO6Bn1BcJ2t4JKhJkvjN
         ygTFDF4hVpo3oPNCGkwnP9mhz+6OSHnGKDr0A7zLw+Xfz4pS9eM+EALyZjmldqJby7Rz
         ALNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+g/aSjL3uLfQBu1JYiGuPibTEA/dL+Z5V+giBpy5ss=;
        b=s4GSbmZtEubaWtfvXpcbivlz5UzztmG4yaXufMXhayF3e5yj4GtB2MbHDzScrE6cfT
         tobCi4K3goWcCJXMedWU5TXG914ITX9fJtbCf34O+qv6bGQoHazabEH4R6p9D2Q/V75F
         ds6+h9O+W11991CeoVOSIqqAaTB3ve4t28DStdgj6CCK3FRDi+3F/19M7t7/0gUjwq0B
         6Tfzak42EamD13/grAzQtBqvVI0xO8lQe5e+lQN4oJu85SYrHQ8zvuQsyDlXyPViJF9J
         M41fmNA83EWglLBBVukIm5Xz06wgvQMuwsIuZ81acf/1c0oJznhrK5qk1U4AI5cg8Ie2
         EahQ==
X-Gm-Message-State: APjAAAWsMXOiZHrXTgk1jvimIL4GInFa/ouTY1S48eENtj86+a2yDUo2
        Z9QNlgliT8zqLMgALWcLkpy/MjFW6puxvA==
X-Google-Smtp-Source: APXvYqw8M2c9UmtDzWlLYC8M5VcduROFEBGm3yQhCDVOpcLSSVIX53mzVQhDbcrweAc6ZdbEuZGLJA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr121091wmk.68.1579536682866;
        Mon, 20 Jan 2020 08:11:22 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 16sm22564602wmi.0.2020.01.20.08.11.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:11:22 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] mesh: use static node_comp instead of the pointer
Date:   Mon, 20 Jan 2020 17:11:12 +0100
Message-Id: <20200120161114.6757-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120161114.6757-1-jakub.witowski@silvair.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

