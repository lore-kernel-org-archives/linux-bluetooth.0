Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B7C76191
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C3C21951
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gn4xs5bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGZEav (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:30:51 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:47011 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGZEau (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 00:30:50 -0400
Received: by mail-lj1-f173.google.com with SMTP id v24so50222273ljg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QfY9KanHmOr/EyWPjScvuSb3L80EIJ0kfa8lrjkJYME=;
        b=gn4xs5bjz9htEQSV9aHeORuR60VkJpHYe2EOZbE77oDsnUVkph6sePY3Y4jutNZZrw
         +xZoMZiDq+fkcu3YFoxj1RDJ82BMfQVwCjkNF2Hi+a8/XJusxm3op5SZ+tY8dDpbQCfD
         rynu9C9l4jDp746k/XBJfb3bXKZAsACTSK9FSfrH6dPcClUBqKU5/mHwLXA8Dt2nsaxM
         76jre7Y3KESE88vm66z9dtxrNNJl3TKYGM0MBF3ECsWOmqJ1RJ36dCSoFKkyit6Lyw98
         geJz4u5luoWvHPdIes7M1o3QKuUJ5lj4aAn2GSggBE7klzmrz9LiUvI46W7X1K1tj7GE
         yPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfY9KanHmOr/EyWPjScvuSb3L80EIJ0kfa8lrjkJYME=;
        b=RfdOHuNeC8hP9G/qfYDtRyyGjLRbk7ObebWlTouvtAS8Wt2O5pwShE2sJKhkwdrhkD
         Cw/c4ptmldmBa+gGlT9ACnPbji7EKyMycOOFPuYdVI2JZxn/vv+ZE2TuotuyeUCQf/Jq
         e/3RClRHS2y7G3pTLUztpAl2dkmSrHdCTaX/dzu6beEdHEGkTkv0TOK2lvxRzbKmrUQQ
         pQm4l5YQE9ZiYV+Hcj7ELpPkMbBCM9t/Fhff1x+y/vQciBG/nJsobGunq7VozJ7DHD7n
         DONpAxe1N3DjO6aCWpSbC20/Ss71+eLzFUcPL6OxrxVZV71TI5XddNKubH+cCFZe/T7g
         DVvQ==
X-Gm-Message-State: APjAAAXNlxWR88VXDqDdOHSP6h3ZFKIuWN1si89FqZinTKYg7pbZHE8m
        NAWx26yk+ShXST0PlEwDGo4WWKsQ3xI=
X-Google-Smtp-Source: APXvYqyQL0tyebLAcGDgAlIq4V0RLVNLL3yKQLEjekJlxZgV4JP/mrCvDXArVP7ZEqHJvb2WzZFi8Q==
X-Received: by 2002:a2e:a311:: with SMTP id l17mr46670491lje.214.1564115447537;
        Thu, 25 Jul 2019 21:30:47 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id g5sm9792735ljj.69.2019.07.25.21.30.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 21:30:46 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/5] mesh: Keep element and model lists sorted and unique
Date:   Fri, 26 Jul 2019 06:30:33 +0200
Message-Id: <20190726043035.9417-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
References: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This keeps composition data unchanged even if elements or models are
registered in a different order.
---
 mesh/node.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 13 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 52ed74ab4..86676bf20 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -160,6 +160,20 @@ static bool match_element_idx(const void *a, const void *b)
 	return (element->idx == index);
 }
 
+static int compare_element_idx(const void *a, const void *b, void *user_data)
+{
+	uint32_t a_idx = ((const struct node_element *)a)->idx;
+	uint32_t b_idx = ((const struct node_element *)b)->idx;
+
+	if (a_idx < b_idx)
+		return -1;
+
+	if (a_idx > b_idx)
+		return 1;
+
+	return 0;
+}
+
 static bool match_element_path(const void *a, const void *b)
 {
 	const struct node_element *element = a;
@@ -171,6 +185,29 @@ static bool match_element_path(const void *a, const void *b)
 	return (!strcmp(element->path, path));
 }
 
+static bool match_model_id(const void *a, const void *b)
+{
+	const struct mesh_model *mod = a;
+	uint32_t mod_id = L_PTR_TO_UINT(b);
+
+	return mesh_model_get_model_id(mod) == mod_id;
+}
+
+static int compare_model_id(const void *a, const void *b, void *user_data)
+{
+	uint32_t a_id = mesh_model_get_model_id(a);
+	uint32_t b_id = mesh_model_get_model_id(b);
+
+	if (a_id < b_id)
+		return -1;
+
+	if (a_id > b_id)
+		return 1;
+
+	return 0;
+}
+
+
 struct mesh_node *node_find_by_addr(uint16_t addr)
 {
 	if (!IS_UNICAST(addr))
@@ -287,6 +324,17 @@ void node_remove(struct mesh_node *node)
 	free_node_resources(node);
 }
 
+static bool element_add_model(struct node_element *ele, struct mesh_model *mod)
+{
+	uint32_t mod_id = mesh_model_get_model_id(mod);
+
+	if (l_queue_find(ele->models, match_model_id, L_UINT_TO_PTR(mod_id)))
+		return false;
+
+	l_queue_insert(ele->models, mod, compare_model_id, NULL);
+	return true;
+}
+
 static bool add_models(struct mesh_node *node, struct node_element *ele,
 					struct mesh_config_element *db_ele)
 {
@@ -305,7 +353,10 @@ static bool add_models(struct mesh_node *node, struct node_element *ele,
 		if (!mod)
 			return false;
 
-		l_queue_push_tail(ele->models, mod);
+		if (!element_add_model(ele, mod)) {
+			mesh_model_free(mod);
+			return false;
+		}
 	}
 
 	return true;
@@ -334,7 +385,8 @@ static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
 	if (!ele->models)
 		ele->models = l_queue_new();
 
-	l_queue_push_tail(ele->models, mod);
+	if (!element_add_model(ele, mod))
+		mesh_model_free(mod);
 }
 
 static bool add_element(struct mesh_node *node,
@@ -1026,12 +1078,12 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data,
 		while (len >= 2 && m--) {
 			mod_id = l_get_le16(data);
 			mod = mesh_model_new(ele->idx, mod_id);
-			if (!mod) {
+			if (!mod || !element_add_model(ele, mod)) {
+				mesh_model_free(mod);
 				element_free(ele);
 				goto fail;
 			}
 
-			l_queue_push_tail(ele->models, mod);
 			data += 2;
 			len -= 2;
 		}
@@ -1048,12 +1100,12 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data,
 			mod_id |= (vendor_id << 16);
 			mod = mesh_model_vendor_new(ele->idx, vendor_id,
 									mod_id);
-			if (!mod) {
+			if (!mod || !element_add_model(ele, mod)) {
+				mesh_model_free(mod);
 				element_free(ele);
 				goto fail;
 			}
 
-			l_queue_push_tail(ele->models, mod);
 			data += 4;
 			len -= 4;
 		}
@@ -1151,12 +1203,9 @@ static void get_models_from_properties(struct node_element *ele,
 		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
 			struct mesh_model *mod;
 
-			/* Skip internally implemented models */
-			if ((VENDOR_ID_MASK | mod_id) == CONFIG_SRV_MODEL)
-				continue;
-
 			mod = mesh_model_new(ele->idx, mod_id);
-			l_queue_push_tail(ele->models, mod);
+			if (!element_add_model(ele, mod))
+				mesh_model_free(mod);
 		}
 		return;
 	}
@@ -1166,7 +1215,8 @@ static void get_models_from_properties(struct node_element *ele,
 		struct mesh_model *mod;
 
 		mod = mesh_model_vendor_new(ele->idx, vendor_id, mod_id);
-		l_queue_push_tail(ele->models, mod);
+		if (!element_add_model(ele, mod))
+			mesh_model_free(mod);
 	}
 }
 
@@ -1216,7 +1266,11 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	if (!idx || !mods || !vendor_mods)
 		goto fail;
 
-	l_queue_push_tail(node->elements, ele);
+	if (l_queue_find(node->elements, match_element_idx,
+						L_UINT_TO_PTR(ele->idx)))
+		goto fail;
+
+	l_queue_insert(node->elements, ele, compare_element_idx, NULL);
 
 	ele->path = l_strdup(path);
 
-- 
2.22.0

