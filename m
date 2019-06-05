Return-Path: <SRS0=U5tA=UE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CFC28CC6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047CD20684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="eBew5dp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfFENBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:01:23 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:34003 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfFENBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jun 2019 09:01:23 -0400
Received: by mail-lj1-f172.google.com with SMTP id j24so23076171ljg.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2019 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhimxKjnmn29sbuuJEwOkqkCy2lxKNghg+2v5PiAnFA=;
        b=eBew5dp9MGVilq6/riYlpm91yDQpzPO70T9HSTvgW2OpTIsPIIESiXU6YkUexrKcJQ
         zeWmy66MBhBWgSkR+lpsi91yMS3CpNswK6JHNMds3E5bXBCD9K9j6trKk7eq4tiX7uvg
         /SgQUYlrVjNw5VDN4zf8x7nlISM0gy108Ly+Q8bB09CvYWEuvmE/VQpOvb8ArCjTtn06
         sTXXelC/uc49mOPEocojMzv4NRomZlX1i552RhAHEVn7UbIdBqNo4npcWVLU24/Vk1l7
         svtVYcl8HC8wokemPGte/ypi22Jvs4xaUV/8al3AKIxWOe7J9l0kpKGFbtdABUQ86LaY
         vPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhimxKjnmn29sbuuJEwOkqkCy2lxKNghg+2v5PiAnFA=;
        b=ofPy+yWLfI1ARSGEdlcClEyJIBRb+aHM8nX7KK8NB0Cfi8+qGbmXq3uxMZyPmR7G3+
         VkxwKqxw3t26pxFK7KnzMVZvRiQQ9DLBQowMk5MsH/dNr/IuzAMVO01OHLcorfqYCpiM
         NwxRIFAlScGmyvfCKcVoacRMRJOakfGWbV55yzMiOjmKiglCuTD8s3u1AyF+CoqssP2y
         iGTQK6eAmNYKXrQYgu35xGAG9tHTcHtbZaPIhjmkd3nhxeexg87S7xroi1pwHC97Eol7
         4loFkb8vwugW8sV5WejPXjabZDH9j9RJZR9bTj1v9SR/L1i8vnlVg6dL8ebOvS6pesYV
         +azQ==
X-Gm-Message-State: APjAAAUkJkw/ueDTlPVh/ZHTyNdxVJuXXRCHLJ5eaBwDpxUd7lPJGmjH
        QerA2HYiU1afyODPIisg8VdKeKZmLfnWhg==
X-Google-Smtp-Source: APXvYqx714SqUEXTQbpsjQHWIWFlQmYZHfmWVysoJ6xMI0jvoe3eQmOtC7RnIz4kNNn9ngOegsiNug==
X-Received: by 2002:a2e:934e:: with SMTP id m14mr20919431ljh.116.1559739680507;
        Wed, 05 Jun 2019 06:01:20 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y9sm4335699ljc.2.2019.06.05.06.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:01:19 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Refactor net keys related object in json file
Date:   Wed,  5 Jun 2019 15:01:05 +0200
Message-Id: <20190605130106.32372-3-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605130106.32372-1-jakub.witowski@silvair.com>
References: <20190605130106.32372-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Network keys have been simplified in json storage file.
The array object is no longer used.
---
 mesh/mesh-db.c | 113 +++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 60 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 7bc1ba272..e8a9a1227 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -373,39 +373,48 @@ bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 								void *user_data)
 {
-	json_object *jarray;
-	int len;
-	int i;
+	json_object *jobject;
+	struct json_object_iterator iter, end;
+	const char *jidx;
+	json_object *jtemp, *jvalue;
 
 	if (!cb)
 		return true;
 
-	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
-		return false;
+	if (!json_object_object_get_ex(jobj, "netKeys", &jobject))
+		return true;
 
-	if (json_object_get_type(jarray) != json_type_array)
+	if (json_object_get_type(jobject) != json_type_object)
 		return false;
 
-	len = json_object_array_length(jarray);
+	iter = json_object_iter_begin(jobject);
+	end = json_object_iter_end(jobject);
+
+	while (!json_object_iter_equal(&iter, &end)) {
 
-	for (i = 0; i < len; ++i) {
-		json_object *jtemp, *jvalue;
 		int idx;
-		char *str;
+		char *str, *end;
 		bool key_refresh = false;
 		int phase;
 		uint8_t key[16];
 		uint8_t new_key[16];
 
-		jtemp = json_object_array_get_idx(jarray, i);
+		jidx = json_object_iter_peek_name(&iter);
+		jtemp = json_object_iter_peek_value(&iter);
 
-		if (!get_int(jtemp, "index", &idx))
+		if (!*jidx)
 			return false;
 
-		if (!CHECK_KEY_IDX_RANGE(idx))
+		idx = (int)strtol(jidx, &end, 10);
+		if (*end || !CHECK_KEY_IDX_RANGE(idx))
 			return false;
 
-		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
+		if (json_object_get_type(jtemp) != json_type_object)
+			return false;
+
+		json_object_object_get_ex(jtemp, "oldKey", &jvalue);
+
+		if (jvalue) {
 			str = (char *)json_object_get_string(jvalue);
 			if (!str2hex(str, strlen(str), key, 16))
 				return false;
@@ -419,7 +428,9 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
 			return false;
 
-		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
+		json_object_object_get_ex(jtemp, "keyRefresh", &jvalue);
+
+		if (!jvalue)
 			phase = KEY_REFRESH_PHASE_NONE;
 		else
 			phase = json_object_get_int(jvalue);
@@ -428,51 +439,45 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 		if (!cb((uint16_t)idx, key, key_refresh ? new_key : NULL, phase,
 								user_data))
 			return false;
+
+		json_object_iter_next(&iter);
 	}
 
 	return true;
 }
 
 bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
-							const uint8_t key[16])
+		const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring;
-	char buf[5];
+	json_object *jobject, *jentry = NULL, *jvalue = NULL;
+	char int_as_str[6];
 
-	json_object_object_get_ex(jobj, "netKeys", &jarray);
-	if (jarray)
-		jentry = get_key_object(jarray, idx);
+	json_object_object_get_ex(jobj, "netKeys", &jobject);
 
-	/* Do not allow direct overwrite */
-	if (jentry)
-		return false;
+	if (!jobject) {
+		jobject = json_object_new_object();
+
+		if (!jobject)
+			return false;
+
+		json_object_object_add(jobj, "netKeys", jobject);
+	}
 
 	jentry = json_object_new_object();
 	if (!jentry)
-		return false;
+		goto fail;
 
-	snprintf(buf, 5, "%4.4x", idx);
-	jstring = json_object_new_string(buf);
-	if (!jstring)
+	jvalue = json_object_new_int(KEY_REFRESH_PHASE_NONE);
+	if (!jvalue)
 		goto fail;
 
-	json_object_object_add(jentry, "index", jstring);
+	json_object_object_add(jentry, "keyRefresh", jvalue);
 
 	if (!add_key_value(jentry, "key", key))
 		goto fail;
 
-	json_object_object_add(jentry, "keyRefresh",
-				json_object_new_int(KEY_REFRESH_PHASE_NONE));
-
-	if (!jarray) {
-		jarray = json_object_new_array();
-		if (!jarray)
-			goto fail;
-		json_object_object_add(jobj, "netKeys", jarray);
-	}
-
-	json_object_array_add(jarray, jentry);
-
+	snprintf(int_as_str, sizeof(int_as_str), "%hd", idx);
+	json_object_object_add(jobject, int_as_str, jentry);
 	return true;
 fail:
 	if (jentry)
@@ -514,32 +519,20 @@ bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
 
 bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	json_object *jobject;
+	char int_as_str[6];
 
-	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
+	json_object_object_get_ex(jobj, "netKeys", &jobject);
+	if (!jobject)
 		return true;
 
-	/* Check if matching entry exists */
-	if (!get_key_object(jarray, idx))
-		return true;
-
-	if (json_object_array_length(jarray) == 1) {
+	if (json_object_get_object(jobject)->size == 1) {
 		json_object_object_del(jobj, "netKeys");
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
-	json_object_object_del(jobj, "netKeys");
-	json_object_object_add(jobj, "netKeys", jarray_new);
-
+	snprintf(int_as_str, sizeof(int_as_str), "%hd", idx);
+	json_object_object_del(jobject, int_as_str);
 	return true;
 }
 
-- 
2.20.1

