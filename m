Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EFD61054
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbhIBKwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbhIBKv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:51:58 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D03C0617AD
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:50:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e14-20020a056214162e00b00375ec21dd99so1178421qvw.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wQ1N5+Ddr0eaO2n9hWRKFI9YgaqOGcTS9ekCFeYvano=;
        b=UIxckb6UQy3YYglYRX4sz48ubjhpHfnLO1ugMcJzsrTO0uemWj9VOGonOh7C535mEH
         rgmZyRqi1Smyd2lAUi/1RFsBohtsnXjPPMjkxF7NOMXeQylO2kmxvLwyxMUF/vSobSWo
         3ZM+nvELT2jr+S6EMC4eWAdtCA9c7vIfs4lZHXeYqKjfaozG4VxPcwJI8Fw/MK0aj/ob
         sHTV9zafl83+63Misa8F/i47yDVkI6Eizw67JoInLeDaHLkoVo7HfXEVyKheAabAyD2k
         xN5qIQjsNv5LEdpn+IpPAxG2s1sf9Iy0CZOBZwR5xcI1PpFiGn1Tlgd2C9tCybyDqAW8
         12lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wQ1N5+Ddr0eaO2n9hWRKFI9YgaqOGcTS9ekCFeYvano=;
        b=IFOlcMDHPV76PyKbXarnIWOERa1eOUysSmOd6IsjP1snQphfGW7+qrVHouUh0HSYWN
         ekM+WYubhiEDSnvM6trFxPBeeP+OtXFPd+ayJahvT/wYjQwUFgWRVZ70B0qESrFnLlin
         GIYyCKrdFjQSm3Vq6cS6IhT+2l9uKwc9edyp7HydY0MoiTpLJPlqrVeaDs0gXLxF0B/+
         3Rsl4FoyGIm7ZOcA6ij/UVc33LRvNQEytVxXaIWGA4omeuvs5tP30AYJ4C62r0j4oVz3
         vZGfhhFU3uqzwQoQV0cpNGZuIKhUbpvqJPwDSy2hyxb8mGlIPmSgjvzZlMyrWcancQWY
         Z0LA==
X-Gm-Message-State: AOAM532IzaeKYcaIpPbpU7w0H/hzEo3WqNA3rJb0PkoOFKrbniV5p3jq
        uisezcFAqIBg6UXXuY8XEpGZIArg6zrNwgwGnVyel8RToVz+O166oLBpuzDFHT6qffl+W4nwvwp
        1pCafz+DstvGWEkQTZQ+lzZxYo7/eM/bxF0EihPCze5YogeHuzTbfu6eCSILBENjbXX1+iMrlHx
        jI
X-Google-Smtp-Source: ABdhPJy2Q5ocev7epFEx5rFb0C7xyb4hNvJ2G8tmwndXkss4bOfr2fNUByZAOtCL5peWdV7kUViEInOjh4Dt
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a0c:e3cb:: with SMTP id
 e11mr2541311qvl.16.1630579830368; Thu, 02 Sep 2021 03:50:30 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:36 +0800
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Message-Id: <20210902184744.Bluez.v3.10.I9802817b065e02b0060e91cf8ce11a8f5fec973a@changeid>
Mime-Version: 1.0
References: <20210902104938.824737-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 10/12] mesh: Inclusive language changes
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

