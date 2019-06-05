Return-Path: <SRS0=U5tA=UE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25272C28CC5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADD9206DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ekULB26g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfFENB0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:01:26 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41780 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfFENB0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jun 2019 09:01:26 -0400
Received: by mail-lj1-f171.google.com with SMTP id s21so12408408lji.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2019 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGH/V2qKX7+z/SRtwIZ5CFz4AW6MbY2uS1x9oAejEMY=;
        b=ekULB26gcAT/p6S4bEEm8FNYUplm9Hyy23RBjhZKe6pI83DNVuqANmqQ1ibTo6Zdwc
         rmCS9lCFZQDy4oLiZ2ha0sNS44TnCYsQaNtDGVEf7ImDSr45PuKdve+HCPABEnbgdYui
         0qTObuPGn0461M/rFicDSzbi4PJzBBYGNX5jJeOpokmdvA+PFtZ6pxK0pmYULlKXCHFm
         PPrTc7bIQKQrgZVVEtDSr7nC7gOReZR7TfQ9xaSXIf2C4b+N/pxvjyP2L4cG8xX+uem/
         xcPg6gVyDT1eRFaQGCdADxAhsb9saF+Q/p9ocjoe9JUix87g05s07X+yGdsNX8u/hVYG
         YSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGH/V2qKX7+z/SRtwIZ5CFz4AW6MbY2uS1x9oAejEMY=;
        b=YspfatCB6k1n7V8ajHkExpwMa36Iu6PK4PNisH0m6c0BuT1kFZ0u4WXZSngm4dsS08
         0TAV3jC4ZMvUv71Or9P/zEnt9Bdby+hqJLevLJ8/gIr0yPd2nQhhST42TA1/2Ku40J2q
         26i3qCgNWfkAfpB4y5RAcqnY57sqvp48Zigv5ZNA8AINSm5tFE+mfpVXNlgctPtJl/a5
         APKGGOfkaqUktKIiFDQp3s2Kv+BVQjsJT8ShI2kfR73KqjGpwiFlFtHIdAq+6liOUcHN
         wG0E4ZozShk/NdUNoGzwxGk23jE8mSt2yE0PU7FPPME5NhSzrkUD82yjIWeeu7l5ZJ6W
         Z19w==
X-Gm-Message-State: APjAAAWdtNMlVjMxG32qsb9Hf4itp5KZhwu4jDxW5XVK1dljMuXHcBom
        kYlkrmZcpOnPFMNIHdRGQ2mAIghw0GQrBA==
X-Google-Smtp-Source: APXvYqwh4NSR9eYJuY9dDKN5rTrOO69kU02Srgh1DNN+XWm04vUoNUpMjlq/yqFC1b9lMdmEbg/LzQ==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr11137240ljw.76.1559739682188;
        Wed, 05 Jun 2019 06:01:22 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y9sm4335699ljc.2.2019.06.05.06.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:01:21 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3] mesh: Refactor app key related object in json file
Date:   Wed,  5 Jun 2019 15:01:06 +0200
Message-Id: <20190605130106.32372-4-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605130106.32372-1-jakub.witowski@silvair.com>
References: <20190605130106.32372-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Application keys have been simplified in json storage file.
The array object is no longer used.
---
 mesh/mesh-db.c | 222 +++++++++++++++++++++++++------------------------
 1 file changed, 114 insertions(+), 108 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index e8a9a1227..30e8f7738 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -205,25 +205,17 @@ static json_object *jarray_string_del(json_object *jarray, char *str,
 	return jarray_new;
 }
 
-static json_object *get_key_object(json_object *jarray, uint16_t idx)
+static json_object *get_key_object(json_object *jobject, uint16_t idx)
 {
-	int i, sz = json_object_array_length(jarray);
-
-	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jvalue;
-		uint32_t jidx;
-
-		jentry = json_object_array_get_idx(jarray, i);
-		if (!json_object_object_get_ex(jentry, "index", &jvalue))
-			return NULL;
+	char int_as_str[6];
 
-		jidx = json_object_get_int(jvalue);
+	/* Convert index to string */
+	sprintf(int_as_str, "%u", idx);
 
-		if (jidx == idx)
-			return jentry;
-	}
+	if (!json_object_object_get_ex(jobject, int_as_str, &jobject))
+		return NULL;
 
-	return NULL;
+	return jobject;
 }
 
 static json_object *jarray_key_del(json_object *jarray, int16_t idx)
@@ -311,62 +303,77 @@ bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
 bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 							void *user_data)
 {
-	json_object *jarray;
-	int len;
-	int i;
+	struct json_object_iterator current;
+	struct json_object_iterator end;
+	struct json_object *jvalue, *jnet_k_idx, *jnet_key, *jold_key;
+
+	char *key_val;
+	const char *idx;
+	uint8_t key[16];
+	uint8_t new_key[16];
+	int app_idx, net_idx;
+	bool key_refresh = false;
+
+	l_info("");
 
 	if (!cb)
 		return true;
 
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
-		return false;
+	if (!json_object_object_get_ex(jobj, "appKeys", &jvalue))
+		return true;
 
-	if (json_object_get_type(jarray) != json_type_array)
-		return false;
+	current = json_object_iter_begin(jvalue);
+	end = json_object_iter_end(jvalue);
 
-	len = json_object_array_length(jarray);
+	while (!json_object_iter_equal(&current, &end)) {
 
-	for (i = 0; i < len; ++i) {
-		json_object *jtemp, *jvalue;
-		int app_idx, net_idx;
-		bool key_refresh = false;
-		char *str;
-		uint8_t key[16];
-		uint8_t new_key[16];
+		idx = json_object_iter_peek_name(&current);
 
-		jtemp = json_object_array_get_idx(jarray, i);
+		/* Get app key index */
+		app_idx = atoi(idx);
 
-		if (!get_int(jtemp, "index", &app_idx))
+		if (!CHECK_KEY_IDX_RANGE(app_idx))
 			return false;
 
-		if (!CHECK_KEY_IDX_RANGE(app_idx))
+		/* Enter to the 'idx' values */
+		if (!json_object_object_get_ex(jvalue, idx, &jnet_k_idx))
 			return false;
 
-		if (!get_int(jtemp, "boundNetKey", &net_idx))
+		/* Get net key index */
+		if (!get_int(jnet_k_idx, "boundNetKey", &net_idx))
 			return false;
 
 		if (!CHECK_KEY_IDX_RANGE(net_idx))
 			return false;
 
-		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
-			str = (char *)json_object_get_string(jvalue);
-			if (!str2hex(str, strlen(str), key, 16))
-				return false;
-			key_refresh = true;
-		}
-
-		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
+		/* Get app key */
+		if (!json_object_object_get_ex(jnet_k_idx, "key", &jnet_key))
 			return false;
 
-		str = (char *)json_object_get_string(jvalue);
-		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
+		key_val = (char *)json_object_get_string(jnet_key);
+
+		if (!str2hex(key_val, strlen(key_val),
+					 key_refresh ? new_key : key, 16))
 			return false;
 
+		/* Get old key if exists */
+		json_object_object_get_ex(jnet_key, "oldKey", &jold_key);
+
+		if (jold_key) {
+			key_val = (char *)json_object_get_string(jvalue);
+
+			if (!str2hex(key_val, strlen(key_val), key, 16))
+				return false;
+
+			key_refresh = true;
+		}
+
 		if (!cb((uint16_t)net_idx, (uint16_t) app_idx, key,
 				key_refresh ? new_key : NULL, user_data))
 			return false;
-	}
 
+		json_object_iter_next(&current);
+	}
 	return true;
 }
 
@@ -377,6 +384,7 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 	struct json_object_iterator iter, end;
 	const char *jidx;
 	json_object *jtemp, *jvalue;
+	l_info("");
 
 	if (!cb)
 		return true;
@@ -451,6 +459,7 @@ bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 {
 	json_object *jobject, *jentry = NULL, *jvalue = NULL;
 	char int_as_str[6];
+	l_info("");
 
 	json_object_object_get_ex(jobj, "netKeys", &jobject);
 
@@ -489,13 +498,14 @@ fail:
 bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry, *jstring;
+	json_object *jobject, *jentry, *jstring;
 	const char *str;
+	l_info("");
 
-	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
+	if (!json_object_object_get_ex(jobj, "netKeys", &jobject))
 		return false;
 
-	jentry = get_key_object(jarray, idx);
+	jentry = get_key_object(jobject, idx);
 	/* Net key must be already recorded */
 	if (!jentry)
 		return false;
@@ -521,6 +531,7 @@ bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
 {
 	json_object *jobject;
 	char int_as_str[6];
+	l_info("");
 
 	json_object_object_get_ex(jobj, "netKeys", &jobject);
 	if (!jobject)
@@ -549,50 +560,37 @@ bool mesh_db_write_token(json_object *jnode, uint8_t *token)
 bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
-	char buf[5];
+	json_object *jobject, *jentry = NULL;
+	char int_as_str[6];
 
-	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (jarray)
-		jentry = get_key_object(jarray, app_idx);
+	/* Create appKey object if doesn't exists */
+	if (!json_object_object_get_ex(jobj, "appKeys", &jobject)) {
+		jobject = json_object_new_object();
+		json_object_object_add(jobj, "appKeys", jobject);
+	}
 
-	/* Do not allow direct overrwrite */
-	if (jentry)
-		return false;
+	/* Check if entry (index) is known */
+	if (!jentry) {
+		jentry = json_object_new_object();
 
-	jentry = json_object_new_object();
-	if (!jentry)
-		return false;
-
-	snprintf(buf, 5, "%4.4x", app_idx);
-	jstring = json_object_new_string(buf);
-	if (!jstring)
-		goto fail;
+		if (!jentry)
+			goto fail;
+	}
 
-	json_object_object_add(jentry, "index", jstring);
+	/* Convert idx to string value */
+	sprintf(int_as_str, "%hd", app_idx);
 
-	snprintf(buf, 5, "%4.4x", net_idx);
-	jstring = json_object_new_string(buf);
-	if (!jstring)
+	/* Add net index value */
+	if (!mesh_db_write_int(jentry, "boundNetKey", net_idx))
 		goto fail;
 
-	json_object_object_add(jentry, "boundNetKey", jstring);
-
 	if (!add_key_value(jentry, "key", key))
 		goto fail;
 
-	if (!jarray) {
-		jarray = json_object_new_array();
-		if (!jarray)
-			goto fail;
-		json_object_object_add(jobj, "appKeys", jarray);
-	}
-
-	json_object_array_add(jarray, jentry);
-
+	json_object_object_add(jobject, &int_as_str[0], jentry);
 	return true;
-fail:
 
+fail:
 	if (jentry)
 		json_object_put(jentry);
 
@@ -602,55 +600,60 @@ fail:
 bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring = NULL;
+	json_object *jobject, *jentry = NULL, *jstring = NULL;
 	const char *str;
 
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
-		return false;
+	/* Check if update has been requested */
+	if (!json_object_object_get_ex(jobj, "appKeys", &jobject))
+		goto fail;
+
+	jentry = get_key_object(jobject, app_idx);
 
 	/* The key entry should exist if the key is updated */
-	jentry = get_key_object(jarray, app_idx);
 	if (!jentry)
-		return false;
+		goto fail;
 
 	if (!json_object_object_get_ex(jentry, "key", &jstring))
-		return false;
+		goto fail;
 
 	str = json_object_get_string(jstring);
 	jstring = json_object_new_string(str);
 	json_object_object_add(jentry, "oldKey", jstring);
 	json_object_object_del(jentry, "key");
 
-	return add_key_value(jentry, "key", key);
+	if (!add_key_value(jentry, "key", key))
+		goto fail;
+
+	return true;
+
+fail:
+	if (jentry)
+		json_object_put(jentry);
+
+	return false;
 }
 
 bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
-
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
-		return true;
+	char int_as_str[6];
+	json_object *jobject;
 
-	/* Check if matching entry exists */
-	if (!get_key_object(jarray, idx))
+	/* Check if appKeys object exists */
+	json_object_object_get_ex(jobj, "appKeys", &jobject);
+	if (!jobject)
 		return true;
 
-	if (json_object_array_length(jarray) == 1) {
+	if (json_object_get_object(jobject)->size == 1) {
+		/* Only one appKey is in Json file.
+		 * Remove the entire appKey field
+		 */
 		json_object_object_del(jobj, "appKeys");
 		return true;
 	}
 
-	/*
-	 * There is no easy way to delete a value from json array.
-	 * Create a new copy without specified element and
-	 * then remove old array.
-	 */
-	jarray_new = jarray_key_del(jarray, idx);
-	if (!jarray_new)
-		return false;
-
-	json_object_object_del(jobj, "appKeys");
-	json_object_object_add(jobj, "appKeys", jarray_new);
+	/* Convert index to string */
+	sprintf(int_as_str, "%u", idx);
+	json_object_object_del(jobject, int_as_str);
 
 	return true;
 }
@@ -991,6 +994,7 @@ static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
 	struct json_object_iterator iter, end;
 	json_object *jtemp;
 	const char *jidx;
+	l_info("");
 
 	node->elements = l_queue_new();
 
@@ -1444,6 +1448,7 @@ static void add_model(void *a, void *b)
 	json_object *jmodels = b;
 	json_object *jmodel;
 	char buf[9];
+	l_info("");
 
 	if (!mod->vendor)
 		snprintf(buf, 5, "%4.4x", (uint16_t)mod->id);
@@ -1466,6 +1471,7 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
 	struct mesh_db_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
 	json_object *jelements;
+	l_info("");
 
 	if (!jnode)
 		return false;
@@ -1587,13 +1593,13 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 
 bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
 {
-	json_object *jarray, *jentry = NULL;
+	json_object *jobject, *jentry = NULL;
 
 	if (!jobj)
 		return false;
 
-	if (json_object_object_get_ex(jobj, "netKeys", &jarray))
-		jentry = get_key_object(jarray, idx);
+	if (json_object_object_get_ex(jobj, "netKeys", &jobject))
+		jentry = get_key_object(jobject, idx);
 
 	if (!jentry)
 		return false;
-- 
2.20.1

