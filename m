Return-Path: <SRS0=U5tA=UE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D2C28CC5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014B520684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="2RvBgO1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFENBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:01:22 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35075 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfFENBW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jun 2019 09:01:22 -0400
Received: by mail-lf1-f51.google.com with SMTP id a25so19027705lfg.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2019 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFD6LqvnZZBVD9gShN9ObM5xD39VLeqxQPg0YXRuvRM=;
        b=2RvBgO1k+zB2yZ4AqDCay1YW+ul0jxI5jPafx4EoARuqGL3LW6RNxN+AhHiBplHNY9
         Pwl5ssNR89BbCVtd6UdQawcoc3WXkO66dGWG2Jwwtw6t+SNmpAdQ45ehj4dm+Os2VGnP
         RuJr3daA9vzyvyYK6Sbz7KtRjTLilviTtU5OduRtjJziVdSvJG4BNnI0u7obSWlnPTzY
         cnJZPN/yDlx1BfGHa83wv5peMJmr6MHHZKCQjx1tv/gRnlgxoKBincJmglQPjnC/z3eE
         DogObvPNtkCun4DovkAjLtKupktPHV8M/Tk0MIjfEeoE21eyyV9mj/heAnFgivvcWJlh
         VsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFD6LqvnZZBVD9gShN9ObM5xD39VLeqxQPg0YXRuvRM=;
        b=NVwimT1x8briB6bjAxwEUx9U5tleVgZ2/rtleimU0/9DfViwjQd8vML94Rnoaqnf2R
         U3B9iW5HejNAMHAQyfEX0MdtnhwKJFYxiMr2KMFyzODcw7hhlmNpCcK2gUgUFRbvOjrj
         orsB46XRGcP+PeOiOHyEZkuGEu5HVz5kbkD7eM+tuL4FP9PrJIo/UxSRtDr+qPk8QaFW
         JpSYydQj+hN9KmTjtliKd7gxLWpCcB5+DOgoe9JIcrkRLGBttvENRK2OIH+L05x2FpFI
         aCLLcf5zJgxGriQPvm9nQJvX3o/MR8wSv1eeGnD3MHBPfy8POWrbnR1TtBnjS7nbNu15
         gzXA==
X-Gm-Message-State: APjAAAW0ZFGWCeD5YyaPEvMmFDTrnZGQXUWyf325WZcanAO72DjG2ckI
        cZw8i5WNXsSLw5L6fRktdvZWmrkW94XgLg==
X-Google-Smtp-Source: APXvYqwYDj3bfYf7pepY1FgeQKbtQXo/4hccFfSWQK45qtOpY8xOpSLJOfJ7WrS8ujO3a3aJdrMkDQ==
X-Received: by 2002:a19:a20a:: with SMTP id l10mr15802299lfe.81.1559739678692;
        Wed, 05 Jun 2019 06:01:18 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y9sm4335699ljc.2.2019.06.05.06.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:01:18 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 1/3] mesh: Refactor elements related object in json file
Date:   Wed,  5 Jun 2019 15:01:04 +0200
Message-Id: <20190605130106.32372-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605130106.32372-1-jakub.witowski@silvair.com>
References: <20190605130106.32372-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Elements and models have been simplified in json storage file.
The array object is no longer used.
---
 mesh/mesh-db.c | 134 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 53 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 5b2868fdb..7bc1ba272 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -35,6 +35,7 @@
 #include "mesh/mesh-db.h"
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
+#define NUMBER_BASE_DECIMAL    (10)
 
 static bool get_int(json_object *jobj, const char *keyword, int *value)
 {
@@ -994,53 +995,69 @@ fail:
 
 static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
 {
-	int i, num_ele;
-
-	num_ele = json_object_array_length(jelements);
-	if (!num_ele)
-		/* Allow "empty" nodes */
-		return true;
+	struct json_object_iterator iter, end;
+	json_object *jtemp;
+	const char *jidx;
 
 	node->elements = l_queue_new();
+
 	if (!node->elements)
 		return false;
 
-	for (i = 0; i < num_ele; ++i) {
-		json_object *jelement;
-		json_object *jmodels;
-		json_object *jvalue;
+	if (json_object_get_type(jelements) != json_type_object)
+		return false;
+
+	iter = json_object_iter_begin(jelements);
+	end = json_object_iter_end(jelements);
+
+	while (!json_object_iter_equal(&iter, &end)) {
+
+		json_object *jmodels, *jlocation;
 		struct mesh_db_element *ele;
-		int index;
-		char *str;
+		char *str_end, *str;
+		uint8_t idx;
 
-		jelement = json_object_array_get_idx(jelements, i);
-		if (!jelement)
-			goto fail;
+		jidx = json_object_iter_peek_name(&iter);
+		jtemp = json_object_iter_peek_value(&iter);
 
-		if (!get_int(jelement, "elementIndex", &index) ||
-								index > num_ele)
-			goto fail;
+		if (!*jidx)
+			return false;
+
+		idx = (uint8_t)strtol(jidx, &str_end, NUMBER_BASE_DECIMAL);
+
+		if (*str_end)
+			return false;
+
+		if (json_object_get_type(jtemp) != json_type_object)
+			return false;
 
 		ele = l_new(struct mesh_db_element, 1);
-		ele->index = index;
+		if (!ele)
+			goto fail;
+
+		ele->index = idx;
 		ele->models = l_queue_new();
 		if (!ele->models)
 			goto fail;
 
-		if (!json_object_object_get_ex(jelement, "location", &jvalue))
+		if (!json_object_object_get_ex(jtemp, "location", &jlocation))
 			goto fail;
 
-		str = (char *)json_object_get_string(jvalue);
+		str = (char *)json_object_get_string(jlocation);
 		if (sscanf(str, "%04hx", &(ele->location)) != 1)
 			goto fail;
 
-		if (json_object_object_get_ex(jelement, "models", &jmodels)) {
-			if (json_object_get_type(jmodels) != json_type_array ||
-						!parse_models(jmodels, ele))
+		if (json_object_object_get_ex(jtemp, "models", &jmodels)) {
+
+			if (json_object_get_type(jmodels) != json_type_object)
+				goto fail;
+
+			if (!parse_models(jmodels, ele))
 				goto fail;
 		}
 
 		l_queue_push_tail(node->elements, ele);
+		json_object_iter_next(&iter);
 	}
 
 	return true;
@@ -1209,12 +1226,16 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
 		node.seq_number = json_object_get_int(jvalue);
 
-	if (json_object_object_get_ex(jnode, "elements", &jvalue)) {
-		if (json_object_get_type(jvalue) == json_type_array) {
-			if (!parse_elements(jvalue, &node))
-				return false;
+	json_object_object_get_ex(jnode, "elements", &jvalue);
+
+	if (jvalue && json_object_get_type(jvalue) == json_type_object) {
+
+		if (!parse_elements(jvalue, &node)) {
+			l_info("Failed to parse elements");
+			return false;
 		}
-	}
+	} else
+		l_info("Failed to parse elements: wrong JSON object type");
 
 	return cb(&node, user_data);
 }
@@ -1427,24 +1448,28 @@ void mesh_db_remove_property(json_object *jobj, const char *desc)
 static void add_model(void *a, void *b)
 {
 	struct mesh_db_model *mod = a;
-	json_object *jmodels = b, *jmodel;
-
-	jmodel = json_object_new_object();
-	if (!jmodel)
-		return;
+	json_object *jmodels = b;
+	json_object *jmodel;
+	char buf[9];
 
 	if (!mod->vendor)
-		mesh_db_write_uint16_hex(jmodel, "modelId",
-						(uint16_t) mod->id);
+		snprintf(buf, 5, "%4.4x", (uint16_t)mod->id);
 	else
-		mesh_db_write_uint32_hex(jmodel, "modelId", mod->id);
+		snprintf(buf, 9, "%8.8x", mod->id);
 
-	json_object_array_add(jmodels, jmodel);
+	jmodel = json_object_new_object();
+
+	if (!jmodel) {
+		json_object_put(jmodels);
+		return;
+	}
+
+	json_object_object_add(jmodels, buf, jmodel);
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
-
+bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
+{
 	struct mesh_db_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
 	json_object *jelements;
@@ -1493,38 +1518,41 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 						json_object_new_int(node->ttl));
 
 	/* Elements */
-	jelements = json_object_new_array();
+	jelements = json_object_new_object();
 	if (!jelements)
 		return false;
 
 	entry = l_queue_get_entries(node->elements);
 
-	for (; entry; entry = entry->next) {
+	for (int idx = 0; entry; entry = entry->next, idx++) {
+
+		char int_as_str[11];
 		struct mesh_db_element *ele = entry->data;
-		json_object *jelement, *jmodels;
+		json_object *jmodels;
+		json_object *jsub_elements;
 
-		jelement = json_object_new_object();
+		/* Convert index to string value */
+		sprintf(int_as_str, "%d", ele->index);
+		jsub_elements = json_object_new_object();
 
-		if (!jelement) {
-			json_object_put(jelements);
-			return false;
-		}
+		mesh_db_write_uint16_hex(jsub_elements,
+				"location", ele->location);
 
-		mesh_db_write_int(jelement, "elementIndex", ele->index);
-		mesh_db_write_uint16_hex(jelement, "location", ele->location);
-		json_object_array_add(jelements, jelement);
+		json_object_object_add(jelements,
+				&int_as_str[0], jsub_elements);
 
 		/* Models */
 		if (l_queue_isempty(ele->models))
 			continue;
 
-		jmodels = json_object_new_array();
+		jmodels = json_object_new_object();
+
 		if (!jmodels) {
 			json_object_put(jelements);
 			return false;
 		}
 
-		json_object_object_add(jelement, "models", jmodels);
+		json_object_object_add(jsub_elements, "models", jmodels);
 		l_queue_foreach(ele->models, add_model, jmodels);
 	}
 
-- 
2.20.1

