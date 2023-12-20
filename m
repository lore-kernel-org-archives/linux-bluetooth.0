Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BB4779B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz4oqCcs"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-20308664c13so3986329fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092945; x=1703697745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUE5JXhNlUdgsxLzu60ERwCx3F8tYCxFrHjJnROl240=;
        b=Sz4oqCcsiUXMivZ4iPTUs+BdtLiGHsy4oi1SuxfyY8cTeccCShyvY/lORIYzkTzYTp
         25JXecwqbdQ+qWxlBLH+OcTG/CED5qaEHgjKcHgX2S3hYZsBFiIMl982Q/GaYLDxX+GY
         6XL36wWYH2mV+uJJJmHFO11+w9o1AG43q0Aw/9+8WI+nYbfZ1aEPznzbAQ1x1Mqkz3I4
         GckMkdIwxsw3LFrKkySrmr8iu87ItdaVcHHdDXS26H+LHR3p/hw6Y4ynxYfjjOfw6Vgd
         NYZmiEhL+blaKmq4pdvkYyWy1UDe4KSBX4YzyierL+cNsxgac5uwnhcLwrjfT/SEmqgA
         CLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092945; x=1703697745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUE5JXhNlUdgsxLzu60ERwCx3F8tYCxFrHjJnROl240=;
        b=IrNnbw6iNmB5z7DevqiZG6Zz5v/h/mXDABCs5RG7uITxqD55dS94B0mbTzz6tLvZ1l
         tHiTYLMMXTrWeP3ZLXawatlJjhnUUJOaxol1oAAPXvEtLF/w3BsExTVVfJmEN7KR8yin
         aX+Zr4Sp7ChBXxFwHZDG4fkDTFMfp6gBwfGh29i5mmXUdrO4z5oge3YMyh+X0oxpATlp
         KzaZbRvAOsRNXWjppfNja0wr/KntspGC0/c8O9rsdtqqFs+cK1FHtBHS8YWRi0LviUSZ
         Z8npeFy6U/zcxxkiww3t+Br5LpLiJJmhonw+Zi+726at0YT90pRskh6YhDPmQJJEgSjE
         Fqag==
X-Gm-Message-State: AOJu0YyZ15mnxjeouja0J+CVFx8y/8HnRg1dQh4GuT2CIbz64nMnAwVA
	9ecYCe02V83BZxrPfKKcAnzPt0sEiLQ=
X-Google-Smtp-Source: AGHT+IFKBOxna/NTaJBquyov0ubE+8vGjIN0GeaC/Dk2XWUSqq4JK6UUA3qOCdExYATxqz8aTOs+tw==
X-Received: by 2002:a05:6871:887:b0:203:b171:c385 with SMTP id r7-20020a056871088700b00203b171c385mr52725oaq.105.1703092944758;
        Wed, 20 Dec 2023 09:22:24 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id lb11-20020a056871414b00b001fb42001fa7sm24968oab.36.2023.12.20.09.22.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:22:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: Fix link key address type for old kernels
Date: Wed, 20 Dec 2023 12:22:22 -0500
Message-ID: <20231220172222.2333064-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On old kernels only BDADDR_BREDR is supported so this attempts to detect
that and retry.

Fixes: https://github.com/bluez/bluez/issues/686
---
 src/adapter.c | 55 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ee70b00d249e..b8ded4c0e649 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -311,6 +311,7 @@ struct btd_adapter {
 	bool pincode_requested;		/* PIN requested during last bonding */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
+	GSList *keys;			/* Devices keys to be loaded */
 	GSList *connect_list;		/* Devices to connect when found */
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
@@ -4284,6 +4285,9 @@ static int set_privacy(struct btd_adapter *adapter, uint8_t privacy)
 	return -1;
 }
 
+static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
+							bool retry);
+
 static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -4293,18 +4297,31 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 		btd_error(adapter->dev_id,
 			"Failed to load link keys for hci%u: %s (0x%02x)",
 				adapter->dev_id, mgmt_errstr(status), status);
+
+		if (status == MGMT_STATUS_INVALID_PARAMS) {
+			load_link_keys(adapter, btd_opts.debug_keys, true);
+			/* Release keys after retry since we shall only retry
+			 * once.
+			 */
+			goto done;
+		}
+
 		return;
 	}
 
 	DBG("link keys loaded for hci%u", adapter->dev_id);
+
+done:
+	g_slist_free_full(adapter->keys, g_free);
+	adapter->keys = NULL;
 }
 
-static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
-							bool debug_keys)
+static void load_link_keys(struct btd_adapter *adapter, bool debug_keys,
+							bool retry)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	struct mgmt_link_key_info *key;
-	size_t key_count, cp_size;
+	size_t count, cp_size;
 	unsigned int id;
 	GSList *l;
 
@@ -4318,12 +4335,14 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 	if (!(adapter->supported_settings & MGMT_SETTING_BREDR))
 		return;
 
-	key_count = g_slist_length(keys);
+	count = g_slist_length(adapter->keys);
+	if (!count)
+		return;
 
-	DBG("hci%u keys %zu debug_keys %d", adapter->dev_id, key_count,
-								debug_keys);
+	DBG("hci%u keys %zu debug_keys %d retry %s", adapter->dev_id, count,
+				debug_keys, retry);
 
-	cp_size = sizeof(*cp) + (key_count * sizeof(*key));
+	cp_size = sizeof(*cp) + (count * sizeof(*key));
 
 	cp = g_try_malloc0(cp_size);
 	if (cp == NULL) {
@@ -4341,13 +4360,18 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 	 * behavior for debug keys.
 	 */
 	cp->debug_keys = debug_keys;
-	cp->key_count = htobs(key_count);
+	cp->key_count = htobs(count);
 
-	for (l = keys, key = cp->keys; l != NULL; l = g_slist_next(l), key++) {
+	for (l = adapter->keys, key = cp->keys; l != NULL; l = g_slist_next(l),
+							key++) {
 		struct link_key_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		key->addr.type = info->bdaddr_type;
+		/* Old kernels might only support loading with type set to
+		 * BDADDR_BREDR so on retry set that instead of using the stored
+		 * info.
+		 */
+		key->addr.type = retry ? BDADDR_BREDR : info->bdaddr_type;
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
@@ -4359,9 +4383,12 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 
 	g_free(cp);
 
-	if (id == 0)
+	if (id == 0) {
 		btd_error(adapter->dev_id, "Failed to load link keys for hci%u",
 							adapter->dev_id);
+		g_slist_free_full(adapter->keys, g_free);
+		adapter->keys = NULL;
+	}
 }
 
 static void load_ltks_complete(uint8_t status, uint16_t length,
@@ -4873,7 +4900,6 @@ done:
 static void load_devices(struct btd_adapter *adapter)
 {
 	char dirname[PATH_MAX];
-	GSList *keys = NULL;
 	GSList *ltks = NULL;
 	GSList *irks = NULL;
 	GSList *params = NULL;
@@ -4964,7 +4990,7 @@ static void load_devices(struct btd_adapter *adapter)
 		}
 
 		if (key_info)
-			keys = g_slist_append(keys, key_info);
+			adapter->keys = g_slist_append(adapter->keys, key_info);
 
 		if (ltk_info)
 			ltks = g_slist_append(ltks, ltk_info);
@@ -5013,8 +5039,7 @@ free:
 
 	closedir(dir);
 
-	load_link_keys(adapter, keys, btd_opts.debug_keys);
-	g_slist_free_full(keys, g_free);
+	load_link_keys(adapter, btd_opts.debug_keys);
 
 	load_ltks(adapter, ltks);
 	g_slist_free_full(ltks, g_free);
-- 
2.43.0

