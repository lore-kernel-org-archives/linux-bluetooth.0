Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2A47A61
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPQG/Yqu"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbdb2433800so600361276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703094044; x=1703698844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAcv0cJEoeqOXt6CURKXaYpKKYBk0AkiyzCATDp7kRQ=;
        b=JPQG/Yquin0zt7UQi0j5tLWPki5mFSkndVISZjMCiWEwczWByn0UK93nLhlWgK8DIH
         mbSSp3WruNrvDXWFyAno+BO7ypLE4sXV2yIqeRK/sDZLo42a33M3gX3aiGZTJ8ttMdU/
         V8qHR1YqAO8iFOLMh0siYKDYLBIAxGT89DzOrZXC4DGR3gu/XUjVPhCoS0uaBIF9WYAz
         iTHxEpjRZHtlSfnT3s/XD7bLHGUq1Xfq0OevJ89ltt2/+YXkeYImOq356vPBSUhYtsE8
         cADGZqEp1CjMbkNv6E0kH31pIEFD/9mzZGb7ct5SHJ6kNu7nNrOYhnBHsNPl8c9GThEw
         EBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703094044; x=1703698844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAcv0cJEoeqOXt6CURKXaYpKKYBk0AkiyzCATDp7kRQ=;
        b=S+NpxqgRyRQadhKoaI07Nw05s/Pz1k8EeFU2yrJdXmUg9V7LZPvZw6Q/YKz5RuQs6D
         56BaY+01q6lXXHvdBLHLX6hC8LP2xP6efy/ssA+oNjhtI/s2PFYmEe0C04EF4a3Delln
         wN5GUXW9DAjk7mMiVJzMXKkqUvJ16pNYl/owhRzvLlngrGq9D78Z+pwoCACCiDndyg/O
         P6PsapH5oO/W6iSpSwTFdKcstAFCo5LD/46GYQPy20pK7MvpU1S7Kvt9BpL8fNM/iwkX
         2IdeyJPuR2cCy3mDbi23t7KRwHwbJfsYYrm0VhHrNQqd+Qczs2s+s+KnUg42AcYKwOCo
         3S1Q==
X-Gm-Message-State: AOJu0YyEGIN3X52fJDj1UFuwuhN4V+H4mTzjQ2pC7SHmkJtLUdIRjAoE
	qtCkbg2e0/lHNPm4fq11o/P1eNL1CNU=
X-Google-Smtp-Source: AGHT+IE3xNTsTEgM3ZpE5ZAl0ZYrYqR0uqtNVfKHNglYZQoa0DRom7Lzv2q0ZDQ1uu23Z9z949Uhrg==
X-Received: by 2002:a25:c789:0:b0:db7:dacf:622f with SMTP id w131-20020a25c789000000b00db7dacf622fmr44806ybe.129.1703094044230;
        Wed, 20 Dec 2023 09:40:44 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id t12-20020a25838c000000b00dbd15c3b753sm92583ybk.46.2023.12.20.09.40.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:40:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] adapter: Fix link key address type for old kernels
Date: Wed, 20 Dec 2023 12:40:42 -0500
Message-ID: <20231220174042.2335819-1-luiz.dentz@gmail.com>
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
 src/adapter.c | 59 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ee70b00d249e..022390f0d95d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -311,6 +311,7 @@ struct btd_adapter {
 	bool pincode_requested;		/* PIN requested during last bonding */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
+	GSList *load_keys;		/* Devices keys to be loaded */
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
+	g_slist_free_full(adapter->load_keys, g_free);
+	adapter->load_keys = NULL;
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
+	count = g_slist_length(adapter->load_keys);
+	if (!count)
+		return;
 
-	DBG("hci%u keys %zu debug_keys %d", adapter->dev_id, key_count,
-								debug_keys);
+	DBG("hci%u keys %zu debug_keys %d retry %s", adapter->dev_id, count,
+				debug_keys, retry ? "true" : "false");
 
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
+	for (l = adapter->load_keys, key = cp->keys; l != NULL;
+					l = g_slist_next(l), key++) {
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
+		g_slist_free_full(adapter->load_keys, g_free);
+		adapter->load_keys = NULL;
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
@@ -4964,7 +4990,8 @@ static void load_devices(struct btd_adapter *adapter)
 		}
 
 		if (key_info)
-			keys = g_slist_append(keys, key_info);
+			adapter->load_keys = g_slist_append(adapter->load_keys,
+								key_info);
 
 		if (ltk_info)
 			ltks = g_slist_append(ltks, ltk_info);
@@ -5013,8 +5040,7 @@ free:
 
 	closedir(dir);
 
-	load_link_keys(adapter, keys, btd_opts.debug_keys);
-	g_slist_free_full(keys, g_free);
+	load_link_keys(adapter, btd_opts.debug_keys, false);
 
 	load_ltks(adapter, ltks);
 	g_slist_free_full(ltks, g_free);
@@ -6930,6 +6956,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 	adapter->devices = NULL;
 
+	g_slist_free(adapter->load_keys);
+	adapter->load_keys = NULL;
+
 	discovery_cleanup(adapter, 0);
 
 	unload_drivers(adapter);
-- 
2.43.0

