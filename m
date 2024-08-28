Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD12196C9C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859604; cv=none; b=D7w2DC7d+5383nfxZey0kDvc9LLIpzmUVC6Howl11YRWPBjX8TLhNa53u/Zgix03nu/Z3MriYZuipv+ONXLCzvm5EFdBq6GSzxhqGUCUiIpF4OmRRQbTfXCeAoiIR3aapCUZ9h/bXeAnfxlqihxOD7b2liFm0lN7RuR3YP7xw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859604; c=relaxed/simple;
	bh=6ojnsEBK+/SEKUACXyX4W/bQYyRzW/T8zT3nTb+Syik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzRhW7vUnuDILtVMvPEE2R8oF0edDhbDARwbvVJ2khPzO77lhprzQZym/5EvUEj3+u6xp+bDA430GBnu2yYxQxEFnVB0jZm2kx05PNfW51k6MeJtv6A9d0M5B9o6HXKqduvECWDUKvKCvJc294GZasp2mbVv6IpAlX212UYVK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZBn/ITe; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZBn/ITe"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498db1fe5ccso2558394137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724859601; x=1725464401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZR9G02JC/0zRpBtxDgvNdkd0yj2WoNlJUnS3nQ8jBOc=;
        b=CZBn/ITeQ4aFartoiGKRq3aIrryx5M60k+ABNPQ6a5A06FtzNKwY61y4jA3APOwwny
         Uqocsd4R5g1DhXnP6dnL381XwxFfcfaBN741RtF5DC/AhqsYnLYJX0xgZY918YXaIuCw
         1GSA8besO1Qtx/DBVivEgDQdmM1ReEy7lg6T4j0Ezi332B71BFtfg7i8oQBQmwZqKne4
         uMMPNGmIylcwxgYjQ4SuxFtOdAvuLfIvuuGe3+TT6Q1G15MP6Gj+cES5ulAWLM38jUWS
         RecP1YvVaiNTR6GU4Pq8EETVIybMgUC56/X7AIJo+GmrawpRkt524Vne/9SE2IYJjSR2
         Vd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859601; x=1725464401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR9G02JC/0zRpBtxDgvNdkd0yj2WoNlJUnS3nQ8jBOc=;
        b=kCFOeM+06HvpkgSDyWcN3QOgqWJqg4HaDD0abZvBCT228hM0DDGpI68FRSCxn+mP2P
         EWcK+u9hdrbInPZ6BKVDb0CeiadtTZxHzWFiVo39BqhEgV2ozGWscQSyW/Sb0sLWelPM
         gexz5vouTysIbUdAssWQzRI/e7EoVAmEV65lgvkiq0A43uWWVNQKlrp1APdAaBsX6q9W
         6FDfB3m433ytvxQ9raAFTtKdgfEkRT4eDm8Xxp4y019TEIqIY4VVUQl/voefNynLXSKq
         18yFElH17wmRAUbsSjAjmDAsiXl6gEn3wUpmBEYKTpHn3692LzTGQr46g4E+OBuywC4T
         nu7g==
X-Gm-Message-State: AOJu0YxVmYd+AkNKU869ZgHzubRR56JSrZ5J0+c7ByLKgCamabWCHyeO
	kuLRwv1DswdUFiBdWkS479NByeH6ymGvoy4djDCSbz8ZQ6EzUB/a8jvowA==
X-Google-Smtp-Source: AGHT+IGj/dd2vqtGIcn4DfoKLcisyKU4mFHHOq/CMpeqGjkfsTLIP2nfWbjZDB6OYvwYlbb/Rg7Kow==
X-Received: by 2002:a05:6102:f13:b0:498:efe0:f91d with SMTP id ada2fe7eead31-49a5af35ce0mr168629137.19.1724859601088;
        Wed, 28 Aug 2024 08:40:01 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e48c9d63sm1855709137.26.2024.08.28.08.39.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:39:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] Revert "adapter: Fix link key address type for old kernels"
Date: Wed, 28 Aug 2024 11:39:56 -0400
Message-ID: <20240828153956.861220-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828153956.861220-1-luiz.dentz@gmail.com>
References: <20240828153956.861220-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts commit 7ad5669402c9acff8e4cc808edc12a41df36654e since it no
longer possible to have the wrong address type being loaded as they fix
up in place when that happens.
---
 src/adapter.c | 59 +++++++++++++--------------------------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9f44bdefa5f4..d6c05819627a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -311,7 +311,6 @@ struct btd_adapter {
 	bool pincode_requested;		/* PIN requested during last bonding */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
-	GSList *load_keys;		/* Devices keys to be loaded */
 	GSList *connect_list;		/* Devices to connect when found */
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
@@ -4289,9 +4288,6 @@ static int set_privacy(struct btd_adapter *adapter, uint8_t privacy)
 	return -1;
 }
 
-static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
-							bool retry);
-
 static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -4301,31 +4297,18 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 		btd_error(adapter->dev_id,
 			"Failed to load link keys for hci%u: %s (0x%02x)",
 				adapter->dev_id, mgmt_errstr(status), status);
-
-		if (status == MGMT_STATUS_INVALID_PARAMS) {
-			load_link_keys(adapter, btd_opts.debug_keys, true);
-			/* Release keys after retry since we shall only retry
-			 * once.
-			 */
-			goto done;
-		}
-
 		return;
 	}
 
 	DBG("link keys loaded for hci%u", adapter->dev_id);
-
-done:
-	g_slist_free_full(adapter->load_keys, g_free);
-	adapter->load_keys = NULL;
 }
 
-static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
-							bool retry)
+static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
+							bool debug_keys)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	struct mgmt_link_key_info *key;
-	size_t count, cp_size;
+	size_t key_count, cp_size;
 	unsigned int id;
 	GSList *l;
 
@@ -4339,14 +4322,12 @@ static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
 	if (!(adapter->supported_settings & MGMT_SETTING_BREDR))
 		return;
 
-	count = g_slist_length(adapter->load_keys);
-	if (!count)
-		return;
+	key_count = g_slist_length(keys);
 
-	DBG("hci%u keys %zu debug_keys %d retry %s", adapter->dev_id, count,
-				debug_keys, retry ? "true" : "false");
+	DBG("hci%u keys %zu debug_keys %d", adapter->dev_id, key_count,
+								debug_keys);
 
-	cp_size = sizeof(*cp) + (count * sizeof(*key));
+	cp_size = sizeof(*cp) + (key_count * sizeof(*key));
 
 	cp = g_try_malloc0(cp_size);
 	if (cp == NULL) {
@@ -4364,18 +4345,13 @@ static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
 	 * behavior for debug keys.
 	 */
 	cp->debug_keys = debug_keys;
-	cp->key_count = htobs(count);
+	cp->key_count = htobs(key_count);
 
-	for (l = adapter->load_keys, key = cp->keys; l != NULL;
-					l = g_slist_next(l), key++) {
+	for (l = keys, key = cp->keys; l != NULL; l = g_slist_next(l), key++) {
 		struct link_key_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		/* Old kernels might only support loading with type set to
-		 * BDADDR_BREDR so on retry set that instead of using the stored
-		 * info.
-		 */
-		key->addr.type = retry ? BDADDR_BREDR : info->bdaddr_type;
+		key->addr.type = info->bdaddr_type;
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
@@ -4387,12 +4363,9 @@ static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
 
 	g_free(cp);
 
-	if (id == 0) {
+	if (id == 0)
 		btd_error(adapter->dev_id, "Failed to load link keys for hci%u",
 							adapter->dev_id);
-		g_slist_free_full(adapter->load_keys, g_free);
-		adapter->load_keys = NULL;
-	}
 }
 
 static void load_ltks_complete(uint8_t status, uint16_t length,
@@ -4928,6 +4901,7 @@ done:
 static void load_devices(struct btd_adapter *adapter)
 {
 	char dirname[PATH_MAX];
+	GSList *keys = NULL;
 	GSList *ltks = NULL;
 	GSList *irks = NULL;
 	GSList *params = NULL;
@@ -5025,8 +4999,7 @@ static void load_devices(struct btd_adapter *adapter)
 			if (key_info->bdaddr_type != BDADDR_BREDR)
 				key_info->bdaddr_type = BDADDR_BREDR;
 
-			adapter->load_keys = g_slist_append(adapter->load_keys,
-								key_info);
+			keys = g_slist_append(keys, key_info);
 		}
 
 		if (ltk_info) {
@@ -5084,7 +5057,8 @@ free:
 
 	closedir(dir);
 
-	load_link_keys(adapter, btd_opts.debug_keys, false);
+	load_link_keys(adapter, keys, btd_opts.debug_keys);
+	g_slist_free_full(keys, g_free);
 
 	load_ltks(adapter, ltks);
 	g_slist_free_full(ltks, g_free);
@@ -7014,9 +6988,6 @@ static void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 	adapter->devices = NULL;
 
-	g_slist_free(adapter->load_keys);
-	adapter->load_keys = NULL;
-
 	discovery_cleanup(adapter, 0);
 
 	unload_drivers(adapter);
-- 
2.46.0

