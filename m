Return-Path: <SRS0=bMpm=VU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B1C76190
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7146223BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="xGs8LyTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfGWKGi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:06:38 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38332 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbfGWKGh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jul 2019 06:06:37 -0400
Received: by mail-lf1-f49.google.com with SMTP id h28so28896331lfj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2019 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bgC3CuhpPYYdvW0uqMw/5+8LL6e0Y3eSBzgx7qVfmSI=;
        b=xGs8LyTrhvUFk276JZPXxT70GAfRiXXfcDvfEOsoGd1tCc1QCDpMe77SxxplKzmmSj
         N1O3Ha7ddp+H5Tzf3pCZl6YmF58wmbFXYUPyFrK7rBmzIxkoepYeTcVT7Hn5ItSECNuN
         EbUy16zuqR/2OtbqACcmyHhczfIFvJmFyhFlecy/wXvjyjahkK6ockMPK0xzBgTV34WT
         FzVXtuulw1MKgBNyc0hP9SoeXan4pcleyIqkfWJKd+7GRVzZg1LRrIkk3JnLMd/dmYVQ
         CXMkM0l+Pvhh1WdSUqe5DHgI9llhDloo1sTKjb1u2sRD58DmrhqP08FLLI5SMRdRayGY
         fc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgC3CuhpPYYdvW0uqMw/5+8LL6e0Y3eSBzgx7qVfmSI=;
        b=fM0F1ZatzQLAywcom9agD0uCUE8g8PW+4TirY7+0QT7L6CZsyLlqYfLMK8/SakyOWy
         UqN9fGPOnMcreWkU2xPLgll0B1cWQUbyX5z08kjDuDEu6Fz+ezzk76rG5mJynSrnRmpe
         s6KfUP4vSgXOLy/UrH7ebg2Bvh28ELeLoMyRvDl7wWtTdMr9hjAMRHYgfcd/Q+tv4Kkv
         hsW5QeoyR33RArlQZh0oyvPnUux5hoxAr05sq1sHSWijGs4+Q/C7p5A+XhFlTnaho4AK
         8JBPpj8vC51XudaWnY1noAA6ca8pKpzPDrS11WqCLkpDiB1JLdKejuqJSb79/zEmgWU0
         cXsQ==
X-Gm-Message-State: APjAAAU3exOE1liN2TjaS0DtO6ihUrRALBDWeND/Qv99C+38Hdx8WkJL
        jsxlYoNuab6HMdVofuNMmzNyqQIWayk=
X-Google-Smtp-Source: APXvYqwEVlrpsRarM4KOJDatxzsMZX0voVS2gTeCtjGjoG2oclIU1u3NZLQVYK/qL+zAk+q+b6VuKw==
X-Received: by 2002:a05:6512:1d2:: with SMTP id f18mr34030173lfp.173.1563876394639;
        Tue, 23 Jul 2019 03:06:34 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h129sm6395260lfd.74.2019.07.23.03.06.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:06:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] mesh: Keep element and model lists sorted and unique
Date:   Tue, 23 Jul 2019 12:06:21 +0200
Message-Id: <20190723100623.6957-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
References: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
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
index 3eb381f29..bfb0dc5b4 100644
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
 	if (!idx || !loc || !mods || !vendor_mods)
 		goto fail;
 
-	l_queue_push_tail(node->elements, ele);
+	if (l_queue_find(node->elements, match_element_idx,
+						L_UINT_TO_PTR(ele->idx)))
+		goto fail;
+
+	l_queue_insert(node->elements, ele, compare_element_idx, NULL);
 	return true;
 fail:
 	l_free(ele);
-- 
2.19.1

