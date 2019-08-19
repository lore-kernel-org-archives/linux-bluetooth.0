Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8156C3A59D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F352087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="uvwPVk8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfHSJdi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:33:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50767 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSJdh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 05:33:37 -0400
Received: by mail-wm1-f48.google.com with SMTP id v15so974627wml.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aCHLjiveyLTbwRNbZTdoWvE6oa0lyk5XmJJFmLWRFtQ=;
        b=uvwPVk8eMum44eLumuy7p+9wPqRaUhgpQafUlJwsKpsUtRKSADEv3xbqotTNFFu8Vo
         kqHZmJSyy8BwXWrixRwtg1JFFUksGjSKuOSfcJl1kaMvV919MgeBPqPwQ6Dbv36eFauW
         +u4AgR2f4mOwUAid+sWm9uw+n+LAT1Zur7m3AvD2/+jAzB9SO0cIky2WVT1dzCzvMx3+
         xd3TtBLaf3LDcgQu/dwA/1gqd5ztQri1MgsXKyL+CogxMiT051QfCCnQJLQkFbqOQHRm
         FqYQqk7m0x2h1ZTYXhppaP25L6Xob/7FHVIvwHcvxcRTt4Atp+aJIRD+bk7G/rM3uekv
         YHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCHLjiveyLTbwRNbZTdoWvE6oa0lyk5XmJJFmLWRFtQ=;
        b=U80SqwVZNH12BzMsC0O/fWN6HHPk0fRIOLeARBJR79iAfnubKbmnSpxBGeXotEao+n
         LEQQryGTQRAmgEaZuO5tUKBLw0aT88dwRpnvzf1599wt11HIKtHK8kCTA5foTQJ3NQuE
         cxaPwg0ccOiKwRH1svmzCgeNtIZNr8wyl9PaIOK1fgoYc2dNaGTzd46kn/TlWs1DO3Zb
         Evypz54kNPO33WATQsgcv2SfXlCj1XS9BraCiAH+k0sm6T0Gvqz/8LQOsjABZjSY9qoy
         TV+43qmDcp52gi6nScLXLk8yXeaK9kOyJkJVKQgGUSJzF0htVO1tJwoZgmQ7InH8mYXx
         f0/g==
X-Gm-Message-State: APjAAAVVs235gNjZpxzB/+Rq4GD6Qj5VIq3p/4nTvFbxtIXa/mWeMCpz
        NanGa9B9R7+J+wKUOCZCRMKXRalUdFM=
X-Google-Smtp-Source: APXvYqzOsyJ37XRqmyNsqUg0mn7MfMfZU/VrgXdarTz0drX1xvmfzgvffED9yEazSE55CXTGSTVRVw==
X-Received: by 2002:a05:600c:1087:: with SMTP id e7mr19506447wmd.19.1566207214703;
        Mon, 19 Aug 2019 02:33:34 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o9sm21675360wrm.88.2019.08.19.02.33.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:33:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] mesh: Align appkey_packet_decrypt with dev and virt variants.
Date:   Mon, 19 Aug 2019 11:33:23 +0200
Message-Id: <20190819093324.10566-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move appkey_packet_decrypt to mesh/model, rename it to
app_packet_decrypt, make it private and change arguments to be aligned
with other decryption functions.

Also, simplify the implementation using an inline loop, removing the
need of mod_decrypt struct.
---
 mesh/appkey.c | 111 +++++++++-----------------------------------------
 mesh/appkey.h |  10 ++---
 mesh/model.c  |  73 +++++++++++++++++++++++++++++----
 3 files changed, 89 insertions(+), 105 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 6c65454c1..e96d5228a 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -50,23 +50,6 @@ struct mesh_msg {
 	uint16_t src;
 };
 
-struct mod_decrypt {
-	const uint8_t *data;
-	uint8_t *out;
-	struct mesh_app_key *key;
-	uint8_t *virt;
-	uint32_t seq;
-	uint32_t iv_idx;
-	uint16_t src;
-	uint16_t dst;
-	uint16_t idx;
-	uint16_t size;
-	uint16_t virt_size;
-	uint8_t key_aid;
-	bool szmict;
-	bool decrypted;
-};
-
 static bool match_key_index(const void *a, const void *b)
 {
 	const struct mesh_app_key *key = a;
@@ -99,80 +82,6 @@ static bool clean_old_iv_index(void *a, void *b)
 	return false;
 }
 
-static void packet_decrypt(void *a, void *b)
-{
-	struct mesh_app_key *key = a;
-	struct mod_decrypt *dec = b;
-
-	l_debug("model.c - app_packet_decrypt");
-	if (dec->decrypted)
-		return;
-
-	if (key->key_aid != dec->key_aid &&
-			key->new_key_aid != dec->key_aid)
-		return;
-
-	dec->key = key;
-
-	if (key->key_aid == dec->key_aid) {
-		dec->decrypted = mesh_crypto_payload_decrypt(dec->virt,
-				dec->virt_size, dec->data, dec->size,
-				dec->szmict, dec->src, dec->dst, dec->key_aid,
-				dec->seq, dec->iv_idx, dec->out, key->key);
-		if (dec->decrypted)
-			print_packet("Used App Key", dec->key->key, 16);
-		else
-			print_packet("Failed with App Key", dec->key->key, 16);
-	}
-
-	if (!dec->decrypted && key->new_key_aid == dec->key_aid) {
-		dec->decrypted = mesh_crypto_payload_decrypt(dec->virt,
-				dec->virt_size, dec->data, dec->size,
-				dec->szmict, dec->src, dec->dst, dec->key_aid,
-				dec->seq, dec->iv_idx, dec->out, key->new_key);
-		if (dec->decrypted)
-			print_packet("Used App Key", dec->key->new_key, 16);
-		else
-			print_packet("Failed with App Key",
-							dec->key->new_key, 16);
-	}
-
-	if (dec->decrypted)
-		dec->idx = key->app_idx;
-}
-
-int appkey_packet_decrypt(struct mesh_net *net, bool szmict, uint32_t seq,
-				uint32_t iv_index, uint16_t src,
-				uint16_t dst, uint8_t *virt, uint16_t virt_size,
-				uint8_t key_aid, const uint8_t *data,
-				uint16_t data_size, uint8_t *out)
-{
-	struct l_queue *app_keys;
-
-	struct mod_decrypt decrypt = {
-		.src = src,
-		.dst = dst,
-		.seq = seq,
-		.data = data,
-		.out = out,
-		.size = data_size,
-		.key_aid = key_aid,
-		.iv_idx = iv_index,
-		.virt = virt,
-		.virt_size = virt_size,
-		.szmict = szmict,
-		.decrypted = false,
-	};
-
-	app_keys = mesh_net_get_app_keys(net);
-	if (!app_keys)
-		return -1;
-
-	l_queue_foreach(app_keys, packet_decrypt, &decrypt);
-
-	return decrypt.decrypted ? decrypt.idx : -1;
-}
-
 bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
 				uint16_t src, uint16_t crpl, uint32_t seq,
 				uint32_t iv_index)
@@ -345,6 +254,26 @@ const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 	return app_key->new_key;
 }
 
+int appkey_get_key_idx(struct mesh_app_key *app_key,
+				const uint8_t **key, uint8_t *key_aid,
+				const uint8_t **new_key, uint8_t *new_key_aid)
+{
+	if (!app_key)
+		return -1;
+
+	if (key && key_aid) {
+		*key = app_key->key;
+		*key_aid = app_key->key_aid;
+	}
+
+	if (new_key && new_key_aid) {
+		*new_key = app_key->new_key;
+		*new_key_aid = app_key->new_key_aid;
+	}
+
+	return app_key->app_idx;
+}
+
 bool appkey_have_key(struct mesh_net *net, uint16_t app_idx)
 {
 	struct mesh_app_key *key;
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 4c135580a..b3e548071 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -20,19 +20,19 @@
 /* TODO: get this number from configuration */
 #define MAX_APP_KEYS	32
 
+struct mesh_app_key;
+
 bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 				uint8_t *key_value, uint8_t *new_key_value);
 void appkey_key_free(void *data);
-int appkey_packet_decrypt(struct mesh_net *net, bool szmict, uint32_t seq,
-				uint32_t iv_index, uint16_t src, uint16_t dst,
-				uint8_t *virt, uint16_t virt_size,
-				uint8_t key_id, const uint8_t *data,
-				uint16_t data_size, uint8_t *out);
 bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
 				uint16_t src, uint16_t crpl, uint32_t seq,
 				uint32_t iv_index);
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 							uint8_t *key_id);
+int appkey_get_key_idx(struct mesh_app_key *app_key,
+				const uint8_t **key, uint8_t *key_aid,
+				const uint8_t **new_key, uint8_t *new_key_aid);
 bool appkey_have_key(struct mesh_net *net, uint16_t app_idx);
 uint16_t appkey_net_idx(struct mesh_net *net, uint16_t app_idx);
 int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
diff --git a/mesh/model.c b/mesh/model.c
index 2ecaf00e9..52cb57429 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -353,6 +353,62 @@ static void forward_model(void *a, void *b)
 		fwd->done = true;
 }
 
+static int app_packet_decrypt(struct mesh_net *net, const uint8_t *data,
+				uint16_t size, bool szmict, uint16_t src,
+				uint16_t dst, uint8_t *virt, uint16_t virt_size,
+				uint8_t key_aid, uint32_t seq,
+				uint32_t iv_idx, uint8_t *out)
+{
+	struct l_queue *app_keys = mesh_net_get_app_keys(net);
+	const struct l_queue_entry *entry;
+
+	if (!app_keys)
+		return -1;
+
+	for (entry = l_queue_get_entries(app_keys); entry;
+							entry = entry->next) {
+		const uint8_t *old_key = NULL, *new_key = NULL;
+		uint8_t old_key_aid, new_key_aid;
+		int app_idx;
+		bool decrypted;
+
+		app_idx = appkey_get_key_idx(entry->data,
+							&old_key, &old_key_aid,
+							&new_key, &new_key_aid);
+
+		if (app_idx < 0)
+			continue;
+
+		if (old_key && old_key_aid == key_aid) {
+			decrypted = mesh_crypto_payload_decrypt(NULL, 0, data,
+						size, szmict, src, dst, key_aid,
+						seq, iv_idx, out, old_key);
+
+			if (decrypted) {
+				print_packet("Used App Key", old_key, 16);
+				return app_idx;
+			}
+
+			print_packet("Failed App Key", old_key, 16);
+		}
+
+		if (new_key && new_key_aid == key_aid) {
+			decrypted = mesh_crypto_payload_decrypt(NULL, 0, data,
+						size, szmict, src, dst, key_aid,
+						seq, iv_idx, out, new_key);
+
+			if (decrypted) {
+				print_packet("Used App Key", new_key, 16);
+				return app_idx;
+			}
+
+			print_packet("Failed App Key", new_key, 16);
+		}
+	}
+
+	return -1;
+}
+
 static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t size, bool szmict, uint16_t src,
 				uint16_t dst, uint8_t key_aid, uint32_t seq,
@@ -395,11 +451,10 @@ static int virt_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 		if (virt->addr != dst)
 			continue;
 
-		decrypt_idx = appkey_packet_decrypt(net, szmict, seq,
-							iv_idx, src, dst,
-							virt->label, 16,
-							key_aid,
-							data, size, out);
+		decrypt_idx = app_packet_decrypt(net, data, size, szmict, src,
+							dst, virt->label, 16,
+							key_aid, seq, iv_idx,
+							out);
 
 		if (decrypt_idx >= 0) {
 			*decrypt_virt = virt;
@@ -853,10 +908,10 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 							iv_index, clear_text,
 							&decrypt_virt);
 	else
-		decrypt_idx = appkey_packet_decrypt(net, szmict, seq0,
-							iv_index, src, dst,
-							NULL, 0, key_aid, data,
-							size, clear_text);
+		decrypt_idx = app_packet_decrypt(net, data, size, szmict, src,
+						dst, NULL, 0,
+						key_aid, seq0, iv_index,
+						clear_text);
 
 	if (decrypt_idx < 0) {
 		l_error("model.c - Failed to decrypt application payload");
-- 
2.19.1

