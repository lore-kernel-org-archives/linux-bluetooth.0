Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF63AC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86F760EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhIBEJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhIBEJO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:09:14 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A3C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so616827qko.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wQ1N5+Ddr0eaO2n9hWRKFI9YgaqOGcTS9ekCFeYvano=;
        b=J61UiCDtUZskNffjupj40VFxPLc5Z+g2n0bXh9gi9+VPOE+Jd9kdimLmK77siBPAZA
         PZZrE2pPvsSlJMnJAkpCG45/2lIDNK1G1Vr1alXz6pEwPztzEWTEn48ls3Ucql77ImBt
         C2b5yTez62tsIiuzDNHCt07a1jpmiF8/jeFePW0efKVvTYio5iUOW3AVOwsj9Yf7cRt/
         q3RtmWuvK9bJa70HlAIoWT1+RY87D4b8Ll5J1U/nhJdad8FyYPbAnFlknT6aoaKvgNC4
         KRZ7mH/yZVA+hR50kbq8Unstq7D/wes1LqH9ELBRe5qVXEyllYWsniGl184TQHgge2MG
         RAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wQ1N5+Ddr0eaO2n9hWRKFI9YgaqOGcTS9ekCFeYvano=;
        b=MayB8gBZ0p/V3+8F1POqoAUjkZlYTKRFlBoArxu5QmqpAwWO8MPRi095njCm4TD+2e
         5bOlS5HeSp4kIeUaaf6c4qmJgPbtgDllNmrq76S7Qp6aP/0U2p66sMFtBSrr3d6/gnXA
         lMAh8v5u1fSkhfLWildJnoBhdwl/z7NwbhfwzeMLMgiAf2x2ojrguHCaIWrnnCGKk41a
         m12pDYOmivuxrN7gidE/SQXk5VJGUvnm/jWCwHu+11ZKdg3t8d8ozFkUZNHi1DFTl54+
         20Pza0TlqqE9ky8Ka+uCquo2PM3WlQC6bDwEgRxvPcwr3z9VKNT36t9i/sBygfsXWU2X
         p1Dg==
X-Gm-Message-State: AOAM530VIwCSnJ5nrUeZ3JBTKo7+p1DrV7FruR+OW5UqDjFm5dsl097R
        joePB1QElv4+qdjQ1ryQAQieKykIqZl9onBffXwHpfwdA/CgUY8/lbKGYrvwys5Q5TvrVmIQzan
        wUidZ8M3u0mk1PDHasw+s44kpj8jY+S8oSecmKKQNoyi3e+iSyxUBon6IIvjEVG8Da/Zq/N4m/u
        2f
X-Google-Smtp-Source: ABdhPJwlyxYc5J93EjMG6Ao9z9mchLg6vh4UBqdcKHZIPtKMmEwLgKzVUKndLE8ey2tUZVHgVGltB1j7muVS
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr965198qvs.58.1630555695303; Wed, 01 Sep 2021 21:08:15 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:08 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.10.I9802817b065e02b0060e91cf8ce11a8f5fec973a@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 10/13] mesh: Inclusive language changes
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

According to
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
"flooding", "accept list", and "reject list" are the preferred terms.
---

(no changes since v1)

 mesh/net-keys.c | 38 +++++++++++++++++++-------------------
 mesh/net-keys.h |  8 ++++----
 mesh/net.h      |  4 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index e0060df746..ee7bbf0c05 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -45,7 +45,7 @@ struct net_key {
 	uint16_t beacon_enables;
 	uint8_t friend_key;
 	uint8_t nid;
-	uint8_t master[16];
+	uint8_t flooding[16];
 	uint8_t encrypt[16];
 	uint8_t privacy[16];
 	uint8_t beacon[16];
@@ -53,7 +53,7 @@ struct net_key {
 };
 
 static struct l_queue *keys = NULL;
-static uint32_t last_master_id = 0;
+static uint32_t last_flooding_id = 0;
 
 /* To avoid re-decrypting same packet for multiple nodes, cache and check */
 static uint8_t cache_pkt[29];
@@ -63,11 +63,11 @@ static size_t cache_plainlen;
 static uint32_t cache_id;
 static uint32_t cache_iv_index;
 
-static bool match_master(const void *a, const void *b)
+static bool match_flooding(const void *a, const void *b)
 {
 	const struct net_key *key = a;
 
-	return (memcmp(key->master, b, sizeof(key->master)) == 0);
+	return (memcmp(key->flooding, b, sizeof(key->flooding)) == 0);
 }
 
 static bool match_id(const void *a, const void *b)
@@ -87,9 +87,9 @@ static bool match_network(const void *a, const void *b)
 }
 
 /* Key added from Provisioning, NetKey Add or NetKey update */
-uint32_t net_key_add(const uint8_t master[16])
+uint32_t net_key_add(const uint8_t flooding[16])
 {
-	struct net_key *key = l_queue_find(keys, match_master, master);
+	struct net_key *key = l_queue_find(keys, match_flooding, flooding);
 	uint8_t p[] = {0};
 	bool result;
 
@@ -102,22 +102,22 @@ uint32_t net_key_add(const uint8_t master[16])
 		keys = l_queue_new();
 
 	key = l_new(struct net_key, 1);
-	memcpy(key->master, master, 16);
+	memcpy(key->flooding, flooding, 16);
 	key->ref_cnt++;
-	result = mesh_crypto_k2(master, p, sizeof(p), &key->nid, key->encrypt,
+	result = mesh_crypto_k2(flooding, p, sizeof(p), &key->nid, key->encrypt,
 								key->privacy);
 	if (!result)
 		goto fail;
 
-	result = mesh_crypto_k3(master, key->network);
+	result = mesh_crypto_k3(flooding, key->network);
 	if (!result)
 		goto fail;
 
-	result = mesh_crypto_nkbk(master, key->beacon);
+	result = mesh_crypto_nkbk(flooding, key->beacon);
 	if (!result)
 		goto fail;
 
-	key->id = ++last_master_id;
+	key->id = ++last_flooding_id;
 	l_queue_push_tail(keys, key);
 	return key->id;
 
@@ -126,11 +126,11 @@ fail:
 	return 0;
 }
 
-uint32_t net_key_frnd_add(uint32_t master_id, uint16_t lpn, uint16_t frnd,
+uint32_t net_key_frnd_add(uint32_t flooding_id, uint16_t lpn, uint16_t frnd,
 					uint16_t lp_cnt, uint16_t fn_cnt)
 {
 	const struct net_key *key = l_queue_find(keys, match_id,
-						L_UINT_TO_PTR(master_id));
+						L_UINT_TO_PTR(flooding_id));
 	struct net_key *frnd_key;
 	uint8_t p[9] = {0x01};
 	bool result;
@@ -145,7 +145,7 @@ uint32_t net_key_frnd_add(uint32_t master_id, uint16_t lpn, uint16_t frnd,
 	l_put_be16(lp_cnt, p + 5);
 	l_put_be16(fn_cnt, p + 7);
 
-	result = mesh_crypto_k2(key->master, p, sizeof(p), &frnd_key->nid,
+	result = mesh_crypto_k2(key->flooding, p, sizeof(p), &frnd_key->nid,
 				frnd_key->encrypt, frnd_key->privacy);
 
 	if (!result) {
@@ -155,7 +155,7 @@ uint32_t net_key_frnd_add(uint32_t master_id, uint16_t lpn, uint16_t frnd,
 
 	frnd_key->friend_key = true;
 	frnd_key->ref_cnt++;
-	frnd_key->id = ++last_master_id;
+	frnd_key->id = ++last_flooding_id;
 	l_queue_push_head(keys, frnd_key);
 
 	return frnd_key->id;
@@ -174,22 +174,22 @@ void net_key_unref(uint32_t id)
 	}
 }
 
-bool net_key_confirm(uint32_t id, const uint8_t master[16])
+bool net_key_confirm(uint32_t id, const uint8_t flooding[16])
 {
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
 
 	if (key)
-		return memcmp(key->master, master, sizeof(key->master)) == 0;
+		return !memcmp(key->flooding, flooding, sizeof(key->flooding));
 
 	return false;
 }
 
-bool net_key_retrieve(uint32_t id, uint8_t *master)
+bool net_key_retrieve(uint32_t id, uint8_t *flooding)
 {
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
 
 	if (key) {
-		memcpy(master, key->master, sizeof(key->master));
+		memcpy(flooding, key->flooding, sizeof(key->flooding));
 		return true;
 	}
 
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 70b3d22c3a..420618f710 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -13,10 +13,10 @@
 #define IV_INDEX_UPDATE		0x02
 
 void net_key_cleanup(void);
-bool net_key_confirm(uint32_t id, const uint8_t master[16]);
-bool net_key_retrieve(uint32_t id, uint8_t *master);
-uint32_t net_key_add(const uint8_t master[16]);
-uint32_t net_key_frnd_add(uint32_t master_id, uint16_t lpn, uint16_t frnd,
+bool net_key_confirm(uint32_t id, const uint8_t flooding[16]);
+bool net_key_retrieve(uint32_t id, uint8_t *flooding);
+uint32_t net_key_add(const uint8_t flooding[16]);
+uint32_t net_key_frnd_add(uint32_t flooding_id, uint16_t lpn, uint16_t frnd,
 					uint16_t lp_cnt, uint16_t fn_cnt);
 void net_key_unref(uint32_t id);
 uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
diff --git a/mesh/net.h b/mesh/net.h
index 4dbc94b8b3..465d889090 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -86,8 +86,8 @@ struct mesh_node;
 #define PROXY_OP_FILTER_STATUS		0x03
 
 /* Proxy Filter Defines */
-#define PROXY_FILTER_WHITELIST		0x00
-#define PROXY_FILTER_BLACKLIST		0x01
+#define PROXY_FILTER_ACCEPT_LIST	0x00
+#define PROXY_FILTER_REJECT_LIST	0x01
 
 /* Network Tranport Opcodes */
 #define NET_OP_SEG_ACKNOWLEDGE		0x00
-- 
2.33.0.259.gc128427fd7-goog

