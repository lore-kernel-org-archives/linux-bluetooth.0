Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB52C606B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8262B20861
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="M0wC5Y6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGIKPh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:15:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44563 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfGIKPh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 06:15:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so18979471ljc.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jrYeV0MeGR9odjudsmfQAnxs7OXyiwO1B5K7eQg9G0=;
        b=M0wC5Y6K61pf8FrhXuaxfQZp+w7CClGZUSt42L3ZmaM6CSwYxgE3i47r8wurGiA4U2
         2mPtOzsHhV7iB+qSI3rpR/BZ/64iozzbY4LkJqhDs3O1qseWU8ODUzp/S+r6kvzxiNPn
         igQVycM+sVkz9SSqThnHFJ1M2TZn1ZSMvVnPz0CpOzryC47bE3N/ryFvamSiDGHYlGcw
         5qS1ZM66jJJd3jBAhqURn3L9FdE4+Fun/Y6voRVYtVPBG2+8iekasvDb/9zPFYZ+LkAc
         FqlatJT4mf09ycq7ugA2OshveGgSDCnb2xCLZ0utKTD5WsgZeODlEwME0GAVyBcsfOrj
         inyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jrYeV0MeGR9odjudsmfQAnxs7OXyiwO1B5K7eQg9G0=;
        b=XVLr6RQOPCscDeDCY/mgNN8qsOqYA5bn3ocqgrd/VX/XdroLBBouoeppSV4aqb2YDF
         ryRMfOv2vQL3CwKZfb/q5ZUcppcYhJuJtE5nXicdM0EVv3NzVK8QBGvgVznQfu35ex1S
         5ziOGgDeMaDorY9ytIXaDXEv2gPtC6kB8SjCZrSTTrJCG8goZIOGrLqGRxwfTuEHj1uA
         XUkNIWI9tShzFRtu7h65h2lAabqEtVZmf/34kA7jCdfeDMXyGWdIAkOjW6wZPQ0sB3W3
         hWFzXXMRzTyCwEa5iNEE0yiPq59sJwagCcYYp6eXXpwvVAv+KvCz+txVGTLrLdL5fj5G
         lYyg==
X-Gm-Message-State: APjAAAVVBoMm+yxuJQIDH+2kOTgiQddAEGCb+YgZbsQIOiPJEtnRZ7QO
        UFmbPSOUUOq+h02QiKpPPwe8IM60eCBhMg==
X-Google-Smtp-Source: APXvYqzzS99qMb0UEkquCfHZboEdgnHi6XHqZ1C3T+cgpqYnYTtP/AcAVTaP/rbxZu9O/98voMDLkQ==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr12641874ljj.205.1562667333631;
        Tue, 09 Jul 2019 03:15:33 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm3168364lfq.76.2019.07.09.03.15.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 03:15:33 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 3/4] mesh: Replace 'json_object' typedef with 'struct json_object'
Date:   Tue,  9 Jul 2019 12:15:21 +0200
Message-Id: <20190709101522.10623-3-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709101522.10623-1-jakub.witowski@silvair.com>
References: <20190709101522.10623-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>

Also, add a forward declaration for struct json_object in mesh-db, so
that we no longer need to include json-c headers in modules that don't
deal with JSON.
---
 mesh/cfgmod-server.c |   2 -
 mesh/mesh-db.c       | 222 +++++++++++++++++++++----------------------
 mesh/mesh-db.h       |  74 ++++++++-------
 mesh/model.c         |   1 -
 mesh/node.c          |   1 -
 mesh/storage.c       |  34 +++----
 6 files changed, 166 insertions(+), 168 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index a19ddc72e..baf707222 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -24,8 +24,6 @@
 #include <sys/time.h>
 #include <ell/ell.h>
 
-#include "json-c/json.h"
-
 #include "mesh/mesh-defs.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 543b8f0e7..f50c68120 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -36,9 +36,9 @@
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
-static bool get_int(json_object *jobj, const char *keyword, int *value)
+static bool get_int(struct json_object *jobj, const char *keyword, int *value)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 
 	if (!json_object_object_get_ex(jobj, keyword, &jvalue))
 		return false;
@@ -50,10 +50,10 @@ static bool get_int(json_object *jobj, const char *keyword, int *value)
 	return true;
 }
 
-static bool add_u64_value(json_object *jobject, const char *desc,
+static bool add_u64_value(struct json_object *jobject, const char *desc,
 					const uint8_t u64[8])
 {
-	json_object *jstring;
+	struct json_object *jstring;
 	char hexstr[17];
 
 	hex2str((uint8_t *) u64, 8, hexstr, 17);
@@ -65,10 +65,10 @@ static bool add_u64_value(json_object *jobject, const char *desc,
 	return true;
 }
 
-static bool add_key_value(json_object *jobject, const char *desc,
+static bool add_key_value(struct json_object *jobject, const char *desc,
 					const uint8_t key[16])
 {
-	json_object *jstring;
+	struct json_object *jstring;
 	char hexstr[33];
 
 	hex2str((uint8_t *) key, 16, hexstr, 33);
@@ -80,9 +80,9 @@ static bool add_key_value(json_object *jobject, const char *desc,
 	return true;
 }
 
-static int get_element_index(json_object *jnode, uint16_t ele_addr)
+static int get_element_index(struct json_object *jnode, uint16_t ele_addr)
 {
-	json_object *jvalue, *jelements;
+	struct json_object *jvalue, *jelements;
 	uint16_t addr, num_ele;
 	char *str;
 
@@ -104,10 +104,10 @@ static int get_element_index(json_object *jnode, uint16_t ele_addr)
 	return ele_addr - addr;
 }
 
-static json_object *get_element_model(json_object *jnode, int ele_idx,
+static struct json_object *get_element_model(struct json_object *jnode, int ele_idx,
 						uint32_t mod_id, bool vendor)
 {
-	json_object *jelements, *jelement, *jmodels;
+	struct json_object *jelements, *jelement, *jmodels;
 	int i, num_mods;
 	size_t len;
 	char buf[9];
@@ -140,7 +140,7 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	}
 
 	for (i = 0; i < num_mods; ++i) {
-		json_object *jmodel, *jvalue;
+		struct json_object *jmodel, *jvalue;
 		char *str;
 
 		jmodel = json_object_array_get_idx(jmodels, i);
@@ -158,12 +158,12 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	return NULL;
 }
 
-static bool jarray_has_string(json_object *jarray, char *str, size_t len)
+static bool jarray_has_string(struct json_object *jarray, char *str, size_t len)
 {
 	int i, sz = json_object_array_length(jarray);
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry;
+		struct json_object *jentry;
 		char *str_entry;
 
 		jentry = json_object_array_get_idx(jarray, i);
@@ -178,18 +178,18 @@ static bool jarray_has_string(json_object *jarray, char *str, size_t len)
 	return false;
 }
 
-static json_object *jarray_string_del(json_object *jarray, char *str,
+static struct json_object *jarray_string_del(struct json_object *jarray, char *str,
 								size_t len)
 {
 	int i, sz = json_object_array_length(jarray);
-	json_object *jarray_new;
+	struct json_object *jarray_new;
 
 	jarray_new = json_object_new_array();
 	if (!jarray_new)
 		return NULL;
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry;
+		struct json_object *jentry;
 		char *str_entry;
 
 		jentry = json_object_array_get_idx(jarray, i);
@@ -204,12 +204,12 @@ static json_object *jarray_string_del(json_object *jarray, char *str,
 	return jarray_new;
 }
 
-static json_object *get_key_object(json_object *jarray, uint16_t idx)
+static struct json_object *get_key_object(struct json_object *jarray, uint16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jvalue;
+		struct json_object *jentry, *jvalue;
 		uint32_t jidx;
 
 		jentry = json_object_array_get_idx(jarray, i);
@@ -225,9 +225,9 @@ static json_object *get_key_object(json_object *jarray, uint16_t idx)
 	return NULL;
 }
 
-static json_object *jarray_key_del(json_object *jarray, int16_t idx)
+static struct json_object *jarray_key_del(struct json_object *jarray, int16_t idx)
 {
-	json_object *jarray_new;
+	struct json_object *jarray_new;
 	int i, sz = json_object_array_length(jarray);
 
 	jarray_new = json_object_new_array();
@@ -235,7 +235,7 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 		return NULL;
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jvalue;
+		struct json_object *jentry, *jvalue;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
@@ -253,10 +253,10 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
-static bool mesh_db_read_unicast_address(json_object *jobj,
+static bool mesh_db_read_unicast_address(struct json_object *jobj,
 							uint16_t *unicast)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 	char *str;
 
 	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue))
@@ -270,9 +270,9 @@ static bool mesh_db_read_unicast_address(json_object *jobj,
 }
 
 
-static bool mesh_db_read_seq_number(json_object *jobj, uint32_t *seq_number)
+static bool mesh_db_read_seq_number(struct json_object *jobj, uint32_t *seq_number)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 
 	if (!json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
 		return false;
@@ -281,7 +281,7 @@ static bool mesh_db_read_seq_number(json_object *jobj, uint32_t *seq_number)
 	return true;
 }
 
-bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
+bool mesh_db_read_iv_index(struct json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
 
@@ -299,9 +299,9 @@ bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 	return true;
 }
 
-bool mesh_db_read_token(json_object *jobj, uint8_t token[8])
+bool mesh_db_read_token(struct json_object *jobj, uint8_t token[8])
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 	char *str;
 
 	if (!token)
@@ -317,9 +317,9 @@ bool mesh_db_read_token(json_object *jobj, uint8_t token[8])
 	return true;
 }
 
-bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
+bool mesh_db_read_device_key(struct json_object *jobj, uint8_t key_buf[16])
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 	char *str;
 
 	if (!key_buf)
@@ -335,10 +335,10 @@ bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
 	return true;
 }
 
-bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
+bool mesh_db_read_app_keys(struct json_object *jobj, mesh_db_app_key_cb cb,
 							void *user_data)
 {
-	json_object *jarray;
+	struct json_object *jarray;
 	int len;
 	int i;
 
@@ -354,7 +354,7 @@ bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 	len = json_object_array_length(jarray);
 
 	for (i = 0; i < len; ++i) {
-		json_object *jtemp, *jvalue;
+		struct json_object *jtemp, *jvalue;
 		int app_idx, net_idx;
 		bool key_refresh = false;
 		char *str;
@@ -397,10 +397,10 @@ bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 	return true;
 }
 
-bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
+bool mesh_db_read_net_keys(struct json_object *jobj, mesh_db_net_key_cb cb,
 								void *user_data)
 {
-	json_object *jarray;
+	struct json_object *jarray;
 	int len;
 	int i;
 
@@ -416,7 +416,7 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 	len = json_object_array_length(jarray);
 
 	for (i = 0; i < len; ++i) {
-		json_object *jtemp, *jvalue;
+		struct json_object *jtemp, *jvalue;
 		int idx;
 		char *str;
 		bool key_refresh = false;
@@ -460,10 +460,10 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 	return true;
 }
 
-bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
+bool mesh_db_net_key_add(struct json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring;
+	struct json_object *jarray = NULL, *jentry = NULL, *jstring;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
@@ -508,10 +508,10 @@ fail:
 	return false;
 }
 
-bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_db_net_key_update(struct json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry, *jstring;
+	struct json_object *jarray, *jentry, *jstring;
 	const char *str;
 
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
@@ -539,9 +539,9 @@ bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
 	return true;
 }
 
-bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
+bool mesh_db_net_key_del(struct json_object *jobj, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	struct json_object *jarray, *jarray_new;
 
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return true;
@@ -570,20 +570,20 @@ bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
 	return true;
 }
 
-bool mesh_db_write_device_key(json_object *jnode, uint8_t *key)
+bool mesh_db_write_device_key(struct json_object *jnode, uint8_t *key)
 {
 	return add_key_value(jnode, "deviceKey", key);
 }
 
-bool mesh_db_write_token(json_object *jnode, uint8_t *token)
+bool mesh_db_write_token(struct json_object *jnode, uint8_t *token)
 {
 	return add_u64_value(jnode, "token", token);
 }
 
-bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
+bool mesh_db_app_key_add(struct json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
+	struct json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
@@ -633,10 +633,10 @@ fail:
 	return false;
 }
 
-bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_db_app_key_update(struct json_object *jobj, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring = NULL;
+	struct json_object *jarray, *jentry = NULL, *jstring = NULL;
 	const char *str;
 
 	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
@@ -658,9 +658,9 @@ bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
 	return add_key_value(jentry, "key", key);
 }
 
-bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
+bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	struct json_object *jarray, *jarray_new;
 
 	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return true;
@@ -689,10 +689,10 @@ bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 	return true;
 }
 
-bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
+bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx, bool vendor,
 				uint32_t mod_id, uint16_t app_idx)
 {
-	json_object *jmodel, *jstring, *jarray = NULL;
+	struct json_object *jmodel, *jstring, *jarray = NULL;
 	char buf[5];
 
 	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
@@ -723,10 +723,10 @@ bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
 	return true;
 }
 
-bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
+bool mesh_db_model_binding_del(struct json_object *jnode, uint8_t ele_idx, bool vendor,
 				uint32_t mod_id, uint16_t app_idx)
 {
-	json_object *jmodel, *jarray, *jarray_new;
+	struct json_object *jmodel, *jarray, *jarray_new;
 	char buf[5];
 
 	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
@@ -779,7 +779,7 @@ static void free_element(void *data)
 	l_free(ele);
 }
 
-static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
+static bool parse_bindings(struct json_object *jbindings, struct mesh_db_model *mod)
 {
 	int cnt;
 	int i;
@@ -798,7 +798,7 @@ static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
 
 	for (i = 0; i < cnt; ++i) {
 		int idx;
-		json_object *jvalue;
+		struct json_object *jvalue;
 
 		jvalue = json_object_array_get_idx(jbindings, i);
 		if (!jvalue)
@@ -814,7 +814,7 @@ static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
 	return true;
 }
 
-static bool get_key_index(json_object *jobj, const char *keyword,
+static bool get_key_index(struct json_object *jobj, const char *keyword,
 								uint16_t *index)
 {
 	int idx;
@@ -829,9 +829,9 @@ static bool get_key_index(json_object *jobj, const char *keyword,
 	return true;
 }
 
-static struct mesh_db_pub *parse_model_publication(json_object *jpub)
+static struct mesh_db_pub *parse_model_publication(struct json_object *jpub)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 	struct mesh_db_pub *pub;
 	int len, value;
 	char *str;
@@ -890,7 +890,7 @@ fail:
 	return NULL;
 }
 
-static bool parse_model_subscriptions(json_object *jsubs,
+static bool parse_model_subscriptions(struct json_object *jsubs,
 						struct mesh_db_model *mod)
 {
 	struct mesh_db_sub *subs;
@@ -909,7 +909,7 @@ static bool parse_model_subscriptions(json_object *jsubs,
 	for (i = 0; i < cnt; ++i) {
 		char *str;
 		int len;
-		json_object *jvalue;
+		struct json_object *jvalue;
 
 		jvalue = json_object_array_get_idx(jsubs, i);
 		if (!jvalue)
@@ -942,7 +942,7 @@ fail:
 	return false;
 }
 
-static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
+static bool parse_models(struct json_object *jmodels, struct mesh_db_element *ele)
 {
 	int i, num_models;
 
@@ -951,7 +951,7 @@ static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 		return true;
 
 	for (i = 0; i < num_models; ++i) {
-		json_object *jmodel, *jarray, *jvalue;
+		struct json_object *jmodel, *jarray, *jvalue;
 		struct mesh_db_model *mod;
 		uint32_t id;
 		int len;
@@ -1016,7 +1016,7 @@ fail:
 	return false;
 }
 
-static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
+static bool parse_elements(struct json_object *jelements, struct mesh_db_node *node)
 {
 	int i, num_ele;
 
@@ -1031,9 +1031,9 @@ static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
 	node->elements = l_queue_new();
 
 	for (i = 0; i < num_ele; ++i) {
-		json_object *jelement;
-		json_object *jmodels;
-		json_object *jvalue;
+		struct json_object *jelement;
+		struct json_object *jmodels;
+		struct json_object *jvalue;
 		struct mesh_db_element *ele;
 		int index;
 		char *str;
@@ -1075,7 +1075,7 @@ fail:
 	return false;
 }
 
-static int get_mode(json_object *jvalue)
+static int get_mode(struct json_object *jvalue)
 {
 	const char *str;
 
@@ -1095,9 +1095,9 @@ static int get_mode(json_object *jvalue)
 	return 0xffffffff;
 }
 
-static void parse_features(json_object *jconfig, struct mesh_db_node *node)
+static void parse_features(struct json_object *jconfig, struct mesh_db_node *node)
 {
-	json_object *jvalue, *jrelay;
+	struct json_object *jvalue, *jrelay;
 	int mode, count;
 	uint16_t interval;
 
@@ -1152,9 +1152,9 @@ static void parse_features(json_object *jconfig, struct mesh_db_node *node)
 	node->modes.relay.interval = interval;
 }
 
-static bool parse_composition(json_object *jcomp, struct mesh_db_node *node)
+static bool parse_composition(struct json_object *jcomp, struct mesh_db_node *node)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 	char *str;
 
 	/* All the fields in node composition are mandatory */
@@ -1189,10 +1189,10 @@ static bool parse_composition(json_object *jcomp, struct mesh_db_node *node)
 	return true;
 }
 
-bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
+bool mesh_db_read_node(struct json_object *jnode, mesh_db_node_cb cb, void *user_data)
 {
 	struct mesh_db_node node;
-	json_object *jvalue;
+	struct json_object *jvalue;
 
 	if (!jnode)
 		return false;
@@ -1233,10 +1233,10 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 	return cb(&node, user_data);
 }
 
-bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
+bool mesh_db_write_uint16_hex(struct json_object *jobj, const char *desc,
 								uint16_t value)
 {
-	json_object *jstring;
+	struct json_object *jstring;
 	char buf[5];
 
 	if (!jobj)
@@ -1251,10 +1251,10 @@ bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
+bool mesh_db_write_uint32_hex(struct json_object *jobj, const char *desc,
 								uint32_t value)
 {
-	json_object *jstring;
+	struct json_object *jstring;
 	char buf[9];
 
 	if (!jobj)
@@ -1269,9 +1269,9 @@ bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_db_write_int(json_object *jobj, const char *keyword, int value)
+bool mesh_db_write_int(struct json_object *jobj, const char *keyword, int value)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 
 	if (!jobj)
 		return false;
@@ -1286,9 +1286,9 @@ bool mesh_db_write_int(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value)
+bool mesh_db_write_bool(struct json_object *jobj, const char *keyword, bool value)
 {
-	json_object *jvalue;
+	struct json_object *jvalue;
 
 	if (!jobj)
 		return false;
@@ -1315,9 +1315,9 @@ static const char *mode_to_string(int mode)
 	}
 }
 
-bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
+bool mesh_db_write_mode(struct json_object *jobj, const char *keyword, int value)
 {
-	json_object *jstring;
+	struct json_object *jstring;
 
 	if (!jobj)
 		return false;
@@ -1332,10 +1332,10 @@ bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
+bool mesh_db_write_relay_mode(struct json_object *jnode, uint8_t mode, uint8_t count,
 							uint16_t interval)
 {
-	json_object *jrelay;
+	struct json_object *jrelay;
 
 	if (!jnode)
 		return false;
@@ -1363,10 +1363,10 @@ fail:
 	return false;
 }
 
-bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
+bool mesh_db_read_net_transmit(struct json_object *jobj, uint8_t *cnt,
 							uint16_t *interval)
 {
-	json_object *jretransmit, *jvalue;
+	struct json_object *jretransmit, *jvalue;
 
 	if (!jobj)
 		return false;
@@ -1387,10 +1387,10 @@ bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
 	return true;
 }
 
-bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt,
+bool mesh_db_write_net_transmit(struct json_object *jobj, uint8_t cnt,
 							uint16_t interval)
 {
-	json_object *jretransmit;
+	struct json_object *jretransmit;
 
 	if (!jobj)
 		return false;
@@ -1416,7 +1416,7 @@ fail:
 
 }
 
-bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update)
+bool mesh_db_write_iv_index(struct json_object *jobj, uint32_t idx, bool update)
 {
 	int tmp = update ? 1 : 0;
 
@@ -1432,7 +1432,7 @@ bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update)
 	return true;
 }
 
-void mesh_db_remove_property(json_object *jobj, const char *desc)
+void mesh_db_remove_property(struct json_object *jobj, const char *desc)
 {
 	if (jobj)
 		json_object_object_del(jobj, desc);
@@ -1441,7 +1441,7 @@ void mesh_db_remove_property(json_object *jobj, const char *desc)
 static void add_model(void *a, void *b)
 {
 	struct mesh_db_model *mod = a;
-	json_object *jmodels = b, *jmodel;
+	struct json_object *jmodels = b, *jmodel;
 
 	jmodel = json_object_new_object();
 	if (!jmodel)
@@ -1457,12 +1457,12 @@ static void add_model(void *a, void *b)
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
+bool mesh_db_add_node(struct json_object *jnode, struct mesh_db_node *node)
 {
 
 	struct mesh_db_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
-	json_object *jelements;
+	struct json_object *jelements;
 
 	if (!jnode)
 		return false;
@@ -1516,7 +1516,7 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
 
 	for (; entry; entry = entry->next) {
 		struct mesh_db_element *ele = entry->data;
-		json_object *jelement, *jmodels;
+		struct json_object *jelement, *jmodels;
 
 		jelement = json_object_new_object();
 
@@ -1548,9 +1548,9 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
 	return true;
 }
 
-static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
+static void finish_key_refresh(struct json_object *jobj, uint16_t net_idx)
 {
-	json_object *jarray;
+	struct json_object *jarray;
 	int i, len;
 
 	/* Clean up all the bound appkeys */
@@ -1560,7 +1560,7 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 	len = json_object_array_length(jarray);
 
 	for (i = 0; i < len; ++i) {
-		json_object *jentry;
+		struct json_object *jentry;
 		uint16_t idx;
 
 		jentry = json_object_array_get_idx(jarray, i);
@@ -1579,9 +1579,9 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 
 }
 
-bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
+bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx, uint8_t phase)
 {
-	json_object *jarray, *jentry = NULL;
+	struct json_object *jarray, *jentry = NULL;
 
 	if (!jobj)
 		return false;
@@ -1604,10 +1604,10 @@ bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
 	return true;
 }
 
-bool mesh_db_model_pub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
+bool mesh_db_model_pub_add(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
 					bool vendor, struct mesh_db_pub *pub)
 {
-	json_object *jmodel, *jpub, *jretransmit;
+	struct json_object *jmodel, *jpub, *jretransmit;
 	bool res;
 	int ele_idx;
 
@@ -1667,10 +1667,10 @@ fail:
 	return false;
 }
 
-static bool delete_model_property(json_object *jnode, uint16_t addr,
+static bool delete_model_property(struct json_object *jnode, uint16_t addr,
 			uint32_t mod_id, bool vendor, const char *keyword)
 {
-	json_object *jmodel;
+	struct json_object *jmodel;
 	int ele_idx;
 
 	ele_idx = get_element_index(jnode, addr);
@@ -1686,7 +1686,7 @@ static bool delete_model_property(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_db_model_pub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
+bool mesh_db_model_pub_del(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
 								bool vendor)
 {
 	if (!jnode)
@@ -1695,10 +1695,10 @@ bool mesh_db_model_pub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
 	return delete_model_property(jnode, addr, mod_id, vendor, "publish");
 }
 
-bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
+bool mesh_db_model_sub_add(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
 					bool vendor, struct mesh_db_sub *sub)
 {
-	json_object *jmodel, *jstring, *jarray = NULL;
+	struct json_object *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
 	char buf[33];
 
@@ -1743,10 +1743,10 @@ bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
 	return true;
 }
 
-bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr,
+bool mesh_db_model_sub_del(struct json_object *jnode, uint16_t addr,
 			uint32_t mod_id, bool vendor, struct mesh_db_sub *sub)
 {
-	json_object *jmodel, *jarray, *jarray_new;
+	struct json_object *jmodel, *jarray, *jarray_new;
 	char buf[33];
 	int len, ele_idx;
 
@@ -1795,7 +1795,7 @@ bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
+bool mesh_db_model_sub_del_all(struct json_object *jnode, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
 	if (!jnode)
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index da5efa12a..0c09238ed 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -17,6 +17,8 @@
  *
  */
 
+struct json_object;
+
 struct mesh_db_sub {
 	bool virt;
 	union {
@@ -99,59 +101,59 @@ typedef bool (*mesh_db_app_key_cb)(uint16_t idx, uint16_t net_idx,
 			uint8_t key[16], uint8_t new_key[16], void *user_data);
 typedef bool (*mesh_db_node_cb)(struct mesh_db_node *node, void *user_data);
 
-bool mesh_db_read_node(json_object *jobj, mesh_db_node_cb cb, void *user_data);
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node);
-bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
-bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16]);
-bool mesh_db_read_token(json_object *jobj, uint8_t token[8]);
-bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
+bool mesh_db_read_node(struct json_object *jobj, mesh_db_node_cb cb, void *user_data);
+bool mesh_db_add_node(struct json_object *jnode, struct mesh_db_node *node);
+bool mesh_db_read_iv_index(struct json_object *jobj, uint32_t *idx, bool *update);
+bool mesh_db_read_device_key(struct json_object *jobj, uint8_t key_buf[16]);
+bool mesh_db_read_token(struct json_object *jobj, uint8_t token[8]);
+bool mesh_db_read_net_transmit(struct json_object *jobj, uint8_t *cnt,
 							uint16_t *interval);
-bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt,
+bool mesh_db_write_net_transmit(struct json_object *jobj, uint8_t cnt,
 							uint16_t interval);
-bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
+bool mesh_db_read_net_keys(struct json_object *jobj, mesh_db_net_key_cb cb,
 							void *user_data);
-bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
+bool mesh_db_read_app_keys(struct json_object *jobj, mesh_db_app_key_cb cb,
 							void *user_data);
-bool mesh_db_write_device_key(json_object *jobj, uint8_t *key);
-bool mesh_db_write_token(json_object *jobj, uint8_t *token);
-bool mesh_db_write_network_key(json_object *jobj, uint16_t idx, uint8_t *key,
+bool mesh_db_write_device_key(struct json_object *jobj, uint8_t *key);
+bool mesh_db_write_token(struct json_object *jobj, uint8_t *token);
+bool mesh_db_write_network_key(struct json_object *jobj, uint16_t idx, uint8_t *key,
 						uint8_t *new_key, int phase);
-bool mesh_db_write_app_key(json_object *jobj, uint16_t net_idx,
+bool mesh_db_write_app_key(struct json_object *jobj, uint16_t net_idx,
 			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_db_write_int(json_object *jobj, const char *keyword, int value);
-bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
+bool mesh_db_write_int(struct json_object *jobj, const char *keyword, int value);
+bool mesh_db_write_uint16_hex(struct json_object *jobj, const char *desc,
 								uint16_t value);
-bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
+bool mesh_db_write_uint32_hex(struct json_object *jobj, const char *desc,
 								uint32_t value);
-bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value);
-bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
+bool mesh_db_write_bool(struct json_object *jobj, const char *keyword, bool value);
+bool mesh_db_write_relay_mode(struct json_object *jnode, uint8_t mode, uint8_t count,
 							uint16_t interval);
-bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value);
-bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
+bool mesh_db_write_mode(struct json_object *jobj, const char *keyword, int value);
+bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
-bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
+bool mesh_db_model_binding_del(struct json_object *jnode, uint8_t ele_idx, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
-bool mesh_db_model_pub_add(json_object *jnode, uint16_t ele_addr,
+bool mesh_db_model_pub_add(struct json_object *jnode, uint16_t ele_addr,
 			uint32_t mod_id, bool vendor, struct mesh_db_pub *pub);
-bool mesh_db_model_pub_del(json_object *jnode, uint16_t ele_addr,
+bool mesh_db_model_pub_del(struct json_object *jnode, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
+bool mesh_db_model_sub_add(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
 					bool vendor, struct mesh_db_sub *sub);
-bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
+bool mesh_db_model_sub_del(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
 					bool vendor, struct mesh_db_sub *sub);
-bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
+bool mesh_db_model_sub_del_all(struct json_object *jnode, uint16_t addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_db_app_key_add(json_object *jnode, uint16_t net_idx, uint16_t app_idx,
+bool mesh_db_app_key_add(struct json_object *jnode, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t key[16]);
-bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_db_app_key_update(struct json_object *jobj, uint16_t app_idx,
 							const uint8_t key[16]);
-bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
-bool mesh_db_net_key_add(json_object *jobj, uint16_t net_idx,
+bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx, uint16_t idx);
+bool mesh_db_net_key_add(struct json_object *jobj, uint16_t net_idx,
 							const uint8_t key[16]);
-bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_db_net_key_update(struct json_object *jobj, uint16_t idx,
 							const uint8_t key[16]);
-bool mesh_db_net_key_del(json_object *jobj, uint16_t net_idx);
-bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase);
-bool mesh_db_write_address(json_object *jobj, uint16_t address);
-bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update);
-void mesh_db_remove_property(json_object *jobj, const char *desc);
+bool mesh_db_net_key_del(struct json_object *jobj, uint16_t net_idx);
+bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx, uint8_t phase);
+bool mesh_db_write_address(struct json_object *jobj, uint16_t address);
+bool mesh_db_write_iv_index(struct json_object *jobj, uint32_t idx, bool update);
+void mesh_db_remove_property(struct json_object *jobj, const char *desc);
diff --git a/mesh/model.c b/mesh/model.c
index e08f95b71..f59d709d5 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -23,7 +23,6 @@
 
 #include <sys/time.h>
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 
diff --git a/mesh/node.c b/mesh/node.c
index 1f781cfe9..8533aaa1e 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -26,7 +26,6 @@
 #include <sys/time.h>
 
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
diff --git a/mesh/storage.c b/mesh/storage.c
index 0f2b77fde..f910bd373 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -42,7 +42,7 @@
 #include "mesh/storage.h"
 
 struct write_info {
-	json_object *jnode;
+	struct json_object *jnode;
 	const char *node_path;
 	void *user_data;
 	mesh_status_func_t cb;
@@ -126,7 +126,7 @@ static bool read_app_keys_cb(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
 	return appkey_key_init(net, net_idx, app_idx, key, new_key);
 }
 
-static bool parse_node(struct mesh_node *node, json_object *jnode)
+static bool parse_node(struct mesh_node *node, struct json_object *jnode)
 {
 	bool bvalue;
 	uint32_t iv_index;
@@ -169,7 +169,7 @@ static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 	char *str;
 	struct stat st;
 	ssize_t sz;
-	json_object *jnode = NULL;
+	struct json_object *jnode = NULL;
 	bool result = false;
 	struct mesh_node *node;
 
@@ -222,7 +222,7 @@ done:
 
 bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 {
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_write_int(jnode, "defaultTTL", ttl))
 		return false;
@@ -234,7 +234,7 @@ bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 bool storage_set_relay(struct mesh_node *node, bool enable,
 				uint8_t count, uint8_t interval)
 {
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_write_relay_mode(jnode, enable, count, interval))
 		return false;
@@ -246,7 +246,7 @@ bool storage_set_relay(struct mesh_node *node, bool enable,
 bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 							uint8_t interval)
 {
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_write_net_transmit(jnode, count, interval))
 		return false;
@@ -258,7 +258,7 @@ bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 						const char *mode_name)
 {
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_write_mode(jnode, mode_name, mode))
 		return false;
@@ -270,7 +270,7 @@ bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 				uint16_t app_idx, bool unbind)
 {
-	json_object *jnode;
+	struct json_object *jnode;
 	int ele_idx;
 	bool stored, is_vendor = (mod_id > 0xffff);
 
@@ -296,7 +296,7 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 			uint16_t app_idx, const uint8_t key[16], bool update)
 {
-	json_object *jnode;
+	struct json_object *jnode;
 	struct mesh_node *node = mesh_net_node_get(net);
 	bool stored;
 
@@ -318,7 +318,7 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 					uint16_t app_idx)
 {
-	json_object *jnode;
+	struct json_object *jnode;
 	struct mesh_node *node = mesh_net_node_get(net);
 
 	jnode = node_jconfig_get(node);
@@ -336,7 +336,7 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 	bool stored;
 
 	if (!update)
@@ -353,7 +353,7 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_net_key_del(jnode, net_idx))
 		return false;
@@ -366,7 +366,7 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_write_iv_index(jnode, iv_index, update))
 		return false;
@@ -379,7 +379,7 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 								uint8_t phase)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_net_key_set_phase(jnode, net_idx, phase))
 		return false;
@@ -391,7 +391,7 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct json_object *jnode = node_jconfig_get(node);
 
 	if (!mesh_db_write_int(jnode, "sequenceNumber", seq))
 		return false;
@@ -400,7 +400,7 @@ bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 	return true;
 }
 
-static bool save_config(json_object *jnode, const char *config_name)
+static bool save_config(struct json_object *jnode, const char *config_name)
 {
 	FILE *outfile;
 	const char *str;
@@ -566,7 +566,7 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	struct mesh_db_node *db_node = data;
 	char uuid[33];
 	char name_buf[PATH_MAX];
-	json_object *jnode;
+	struct json_object *jnode;
 	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
 
 	if (!storage_dir)
-- 
2.20.1

