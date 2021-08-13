Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB73AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9456260F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhHMMXZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbhHMMXY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:24 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E9C0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j3-20020ac85f830000b029029113b02ff5so6260991qta.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PPzkKS0EL0yyonRYeNCRTdNgef64Rqk/cq4dSl3Jly0=;
        b=EZvl3SgXCDCQ3saMxWm/7z/uOEV+rgholQ4SVWKdmImQ2vCbtNZ77jfnh+jKxaiEOV
         CEdUx2LmGLSxwwmWJtsQh9BC/uxulTSYNwTDLZ2US6TQYt71C9wMwp3NgOkO6XesC8xK
         eE8HAsP7McfGvk7oP1U//4Q1TtVrWgJYNuGHsmKHYq/7mkUs1xqfwR/ds7ST8efbnmbf
         /FCImNl4yCCwDoi1OAU85YXMKK9MVhuwh36kYcBLUuiMStE7+hoBgtsMiPPAr4/zWe4r
         RlJV/+4WQztQyhhiA1hQLCTUCkEMHBBd2gw/ozz/GFpgN7jIrQatinWRkZAj2D7mnubw
         /VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PPzkKS0EL0yyonRYeNCRTdNgef64Rqk/cq4dSl3Jly0=;
        b=MFS1luj2gw8goyLaPHlIwlglx8wWMbFeppq6NNaK98IrlSUPspIvdSUkAzXVNtiPyk
         z9wfQb8CmB+TOegXCYMpb79VkGldLbapOKUcVnmraiPe/qVHPD/LjjGKpuFk9SariM/j
         0J0vDd/rnS6R4ImBX3wTM81YMKrqbW4vKKHMwjFsNPe1lL9ZiqmFjFhW4CN/Yo2hhROK
         aHul61QasoFf1xGTZOBkQi5UIZXrCY0/6ZRggJGBvQ00NCu8r+8J8gByy0HloFQ5sMXB
         KOo6R30bzoF5EZPonMXw+hb2QZxKl2OgvjtJJmcwwnOhawisXQDmVnu8wSPZ8JWq2ANT
         h9Ng==
X-Gm-Message-State: AOAM533jLZhY4w5GYiUnkBsHpQF8Fhf0uMISQ2ydckJg/94KGtGr1yf/
        3a+++AgfQ7Si30j57kOLr/Aosr338+s9ZKAwjOrj3UoVJIWMKnUr82rgcBGaDGV/NsT6LhNFuTj
        iQimGIUGpGs47W/tPOugrm7YjO3z/z/oIzEGV3mnqnFTvgUZEBv6Tytk0bTXRArHfhVFWrG0jn3
        E3
X-Google-Smtp-Source: ABdhPJw1iJxcFDO238i1XvtW+Sbnw/XqD4qves7fu6/Zt7MMacDrbGzslt1TKVg9ZxnfYiiiQVOi6shChSoB
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:f0c:: with SMTP id
 gw12mr2363169qvb.33.1628857376521; Fri, 13 Aug 2021 05:22:56 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:40 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.55.Iede911f7b1a507e2f37bbd0926b2fa0fdde9cdfa@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 55/62] tools/mesh: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"reject list" is preferred, as reflected in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 tools/mesh-cfgclient.c |  4 ++--
 tools/mesh/mesh-db.c   | 28 +++++++++++-----------
 tools/mesh/mesh-db.h   |  4 ++--
 tools/mesh/remote.c    | 53 +++++++++++++++++++++---------------------
 tools/mesh/remote.h    |  5 ++--
 5 files changed, 45 insertions(+), 49 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index a4a6f21ab8..70553c95c8 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -720,7 +720,7 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 							ivi != iv_index) {
 		iv_index = ivi;
 		mesh_db_set_iv_index(ivi);
-		remote_clear_blacklisted_addresses(ivi);
+		remote_clear_rejected_addresses(ivi);
 	}
 
 	return;
@@ -1858,7 +1858,7 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 
 			iv_index = ivi;
 			mesh_db_set_iv_index(ivi);
-			remote_clear_blacklisted_addresses(ivi);
+			remote_clear_rejected_addresses(ivi);
 		}
 	}
 }
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 46f0c60751..6779bb8403 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1246,7 +1246,7 @@ bool mesh_db_set_iv_index(uint32_t ivi)
 	return save_config();
 }
 
-static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
+static int get_rejected_by_iv_index(json_object *jarray, uint32_t iv_index)
 {
 	int i, cnt;
 
@@ -1268,12 +1268,12 @@ static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
 	return -1;
 }
 
-static bool load_blacklisted(json_object *jobj)
+static bool load_rejected_addresses(json_object *jobj)
 {
 	json_object *jarray;
 	int i, cnt;
 
-	json_object_object_get_ex(jobj, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(jobj, "rejectedAddresses", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return true;
 
@@ -1304,15 +1304,14 @@ static bool load_blacklisted(json_object *jobj)
 			if (sscanf(str, "%04hx", &unicast) != 1)
 				return false;
 
-			remote_add_blacklisted_address(unicast, iv_index,
-								false);
+			remote_add_rejected_address(unicast, iv_index, false);
 		}
 	}
 
 	return true;
 }
 
-bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index)
+bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index)
 {
 	json_object *jarray, *jobj, *jaddrs, *jstring;
 	int idx;
@@ -1321,14 +1320,13 @@ bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(cfg->jcfg, "rejectedAddresses", &jarray);
 	if (!jarray) {
 		jarray = json_object_new_array();
-		json_object_object_add(cfg->jcfg, "blacklistedAddresses",
-									jarray);
+		json_object_object_add(cfg->jcfg, "rejectedAddresses", jarray);
 	}
 
-	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	idx = get_rejected_by_iv_index(jarray, iv_index);
 
 	if (idx < 0) {
 		jobj = json_object_new_object();
@@ -1362,7 +1360,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_clear_blacklisted(uint32_t iv_index)
+bool mesh_db_clear_rejected(uint32_t iv_index)
 {
 	json_object *jarray;
 	int idx;
@@ -1370,11 +1368,11 @@ bool mesh_db_clear_blacklisted(uint32_t iv_index)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(cfg->jcfg, "rejectedAddresses", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return false;
 
-	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	idx = get_rejected_by_iv_index(jarray, iv_index);
 	if (idx < 0)
 		return true;
 
@@ -1437,7 +1435,7 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 	if (!jarray)
 		goto fail;
 
-	json_object_object_add(jcfg, "blacklistedAddresses", jarray);
+	json_object_object_add(jcfg, "rejectedAddresses", jarray);
 
 	write_int(jcfg, "ivIndex", 0);
 
@@ -1504,7 +1502,7 @@ bool mesh_db_load(const char *fname)
 
 	load_remotes(jcfg);
 
-	load_blacklisted(jcfg);
+	load_rejected_addresses(jcfg);
 
 	return true;
 fail:
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index d1d734bf3e..22518c6189 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -49,5 +49,5 @@ bool mesh_db_node_model_binding_del(uint16_t unicast, uint8_t ele, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
-bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index);
-bool mesh_db_clear_blacklisted(uint32_t iv_index);
+bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index);
+bool mesh_db_clear_rejected(uint32_t iv_index);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 9b265bee49..e60a3681d0 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -34,13 +34,13 @@ struct remote_node {
 	uint8_t num_ele;
 };
 
-struct blacklisted_addr {
+struct rejected_addr {
 	uint32_t iv_index;
 	uint16_t unicast;
 };
 
 static struct l_queue *nodes;
-static struct l_queue *blacklisted;
+static struct l_queue *reject_list;
 
 static bool key_present(struct l_queue *keys, uint16_t app_idx)
 {
@@ -124,7 +124,7 @@ uint8_t remote_del_node(uint16_t unicast)
 
 	for (i = 0; i < num_ele; ++i) {
 		l_queue_destroy(rmt->els[i], NULL);
-		remote_add_blacklisted_address(unicast + i, iv_index, true);
+		remote_add_rejected_address(unicast + i, iv_index, true);
 	}
 
 	l_free(rmt->els);
@@ -333,9 +333,9 @@ static void print_node(void *rmt, void *user_data)
 		print_element(node->els[i], i);
 }
 
-static bool match_black_addr(const void *a, const void *b)
+static bool match_rejected_addr(const void *a, const void *b)
 {
-	const struct blacklisted_addr *addr = a;
+	const struct rejected_addr *addr = a;
 	uint16_t unicast = L_PTR_TO_UINT(b);
 
 	return addr->unicast == unicast;
@@ -348,11 +348,11 @@ static uint16_t get_next_addr(uint16_t high, uint16_t addr,
 		int i = 0;
 
 		for (i = 0; i < ele_cnt; i++) {
-			struct blacklisted_addr *black;
+			struct rejected_addr *reject;
 
-			black = l_queue_find(blacklisted, match_black_addr,
+			reject = l_queue_find(reject_list, match_rejected_addr,
 						L_UINT_TO_PTR(addr + i));
-			if (!black)
+			if (!reject)
 				break;
 		}
 
@@ -367,10 +367,10 @@ static uint16_t get_next_addr(uint16_t high, uint16_t addr,
 
 static bool check_iv_index(const void *a, const void *b)
 {
-	const struct blacklisted_addr *black_addr = a;
+	const struct rejected_addr *reject = a;
 	uint32_t iv_index = L_PTR_TO_UINT(b);
 
-	return (abs_diff(iv_index, black_addr->iv_index) > 2);
+	return (abs_diff(iv_index, reject->iv_index) > 2);
 }
 
 void remote_print_node(uint16_t addr)
@@ -435,36 +435,35 @@ uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt)
 	return addr;
 }
 
-void remote_add_blacklisted_address(uint16_t addr, uint32_t iv_index,
-								bool save)
+void remote_add_rejected_address(uint16_t addr, uint32_t iv_index, bool save)
 {
-	struct blacklisted_addr *black_addr;
+	struct rejected_addr *reject;
 
-	if (!blacklisted)
-		blacklisted = l_queue_new();
+	if (!reject_list)
+		reject_list = l_queue_new();
 
-	black_addr = l_new(struct blacklisted_addr, 1);
-	black_addr->unicast = addr;
-	black_addr->iv_index = iv_index;
+	reject = l_new(struct rejected_addr, 1);
+	reject->unicast = addr;
+	reject->iv_index = iv_index;
 
-	l_queue_push_tail(blacklisted, black_addr);
+	l_queue_push_tail(reject_list, reject);
 
 	if (save)
-		mesh_db_add_blacklisted_addr(addr, iv_index);
+		mesh_db_add_rejected_addr(addr, iv_index);
 }
 
-void remote_clear_blacklisted_addresses(uint32_t iv_index)
+void remote_clear_rejected_addresses(uint32_t iv_index)
 {
-	struct blacklisted_addr *black_addr;
+	struct rejected_addr *reject;
 
-	black_addr = l_queue_remove_if(blacklisted, check_iv_index,
+	reject = l_queue_remove_if(reject_list, check_iv_index,
 						L_UINT_TO_PTR(iv_index));
 
-	while (black_addr) {
-		l_free(black_addr);
-		black_addr = l_queue_remove_if(blacklisted, check_iv_index,
+	while (reject) {
+		l_free(reject);
+		reject = l_queue_remove_if(reject_list, check_iv_index,
 						L_UINT_TO_PTR(iv_index));
 	}
 
-	mesh_db_clear_blacklisted(iv_index);
+	mesh_db_clear_rejected(iv_index);
 }
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index bb4fb11917..8ecb097ae4 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -13,9 +13,8 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 uint8_t remote_del_node(uint16_t unicast);
 bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 								bool vendor);
-void remote_add_blacklisted_address(uint16_t addr, uint32_t iv_index,
-								bool save);
-void remote_clear_blacklisted_addresses(uint32_t iv_index);
+void remote_add_rejected_address(uint16_t addr, uint32_t iv_index, bool save);
+void remote_clear_rejected_addresses(uint32_t iv_index);
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

