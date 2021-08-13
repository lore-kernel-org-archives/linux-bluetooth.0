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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CBEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8DB60F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbhHMMXU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhHMMXU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1BC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u6-20020a170902bf46b029012c971d6226so4806643pls.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rv41obzAgTRqQM2YeoOxMb/UwfyE173vunxD85s7Jc8=;
        b=rZRzFJE8VrZVmjGVjJl5q5oWUA6c1FX4cYwSzKHuxJBytZaSg9JrpByxSmaS9pzegC
         Kb+AFJXxAKnVj0uZ9V1ixEtlc2/HNeHaNsc+CJ9fZLP6Tawb5xT6l+bZaSHaodhwv4ZL
         kZoMmADWrfPLf0LI7sOpwg3FfA2RjOMbHRiIKjekwkyHbBAqts07tRWxBqlewokgL4mW
         me0ID9beFbM8F9qVSMvf7S9eumofzPIZ6KrLT4M7kCRJVLqicDxCnQssP/btSpyBwY5R
         lwrGBReHfa0xDiNOwHSlO/OJQD4TzCEVnPQcprBmXyPsqHZs4NWbbCDHoyEvYbmhXKWo
         n4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rv41obzAgTRqQM2YeoOxMb/UwfyE173vunxD85s7Jc8=;
        b=TUzyowJkPQLM1gK2qqthQe/g/nqnBRWo2UI/clzgFGP6zuq5KLLm1V3Z3S/YyWYykr
         zVZyyOHxlHNPjkJjH38fWW4GaR8o9xhQ4ImOM1K99JePERpVPdM/Vvhs7cZTXD0irhqO
         nxipOFgH8OyLRZPsCgJ8Xgeso2jnN39O949nbYyc17xioIGUe0ny/MWxxxpQwgZHDan3
         TMHYUjRREHYFkMRaxJWA2MTpxJ3z1JuU2D9zpU2FpAXADxMigk+M5q5TjSf0eMd/ucjO
         CGUmpqshwFi7CYT36b0UA1dTlWXwG5uJGZ/dUt5/1BOosq6wsog+ogC4bjTCRLMlfhtm
         G4pw==
X-Gm-Message-State: AOAM530348DG/cWuS5rcv2ElLsK7aSUMQ6i2oZ8pjs9bvx0r5nA4jNP5
        td+joMxm0xAuAek3mPQGUCfAvVRxFskYHh77pX1z08nIKIyu1LOdC40F284Ra8khHPNoZ569Bn5
        u8U2BGNzBshyLSPanC1CevuLqPnhJ2djfNV36vm/OW8N8q73x2s9CAD6v9uW609CFAk7hdu56hW
        KS
X-Google-Smtp-Source: ABdhPJzKGZ9nO0vxoFBxTYOPUt/Vw5kOg0vnloyUmkGkNieKB4qvJ5z+J1mxT0+z6qJYvN7u0dqm7FA/HxVu
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:90a:c981:: with SMTP id
 w1mr205403pjt.1.1628857372451; Fri, 13 Aug 2021 05:22:52 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:39 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.54.I9802817b065e02b0060e91cf8ce11a8f5fec973a@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 54/62] mesh: Inclusive language changes
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

"flooding", "accept list", and "reject list" are the preferred terms,
as reflected in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

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
2.33.0.rc1.237.g0d66db33f3-goog

