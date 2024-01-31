Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B85813B
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689147; cv=none; b=SXrBRk7Js/YZF4iy5d/QkC9iC6NPgrRayWrYwVOU0kU8U8Gpe/vjcydU7bYLj455KmLFIxnGwxWgY7eDRjyyosi8XBykRntbWKS18LCMZ5/LSa2xwQ1tqqBbT5dU8pfZk+otgjmFb9rIAF9JR6uR9sXns+QFz/GW0SIOiI1EFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689147; c=relaxed/simple;
	bh=3ZULNmvMA/msyyWez1//JEaSsRi2RMywT9HulGS2xKI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlnIU1nyGhUkuDFT2zSqMrikHFwF++yqiDZkfFtSuJbE84GRYu9cSxkmKbHHJJz2nTF6VKBWeMaY4yhgrBphYAfsXGi0C2deTIoRxhE+bG/aPFjk3r7UaNVIfUFAsF++BYUeutqnvYvBOW2I4Fnc0DB/sXDQpF6DKPbXb8fx7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dOLn5EfW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dOLn5EfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706689144;
	bh=3ZULNmvMA/msyyWez1//JEaSsRi2RMywT9HulGS2xKI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dOLn5EfW9cozRAgAbarY/nTWld045bGOipg8vu0CbroI70TY+R7F2CQqlStv/9LNN
	 8qqLNU7nOf1oJSaZpQkK59U0+sIOecMTGlWBsw15KQMsaF4zgbBu6h8QyhiOVM/z9T
	 RrlbEN7/I5o94+GmAHna6WP/5Bp2Xama5nj3RtO8pTieLWion54V/6o74kN6rCcK3y
	 uYdysLNOSq2KGewv6kTrj0q5F7bnV/edCZAdRnoxziNRchoFxxT6sFxd54Jtoxfz/s
	 0p7s0YSQhhyPqzZtYvRiO4dUI0GKjkJssKx/HizCAd63c10/6nmqoxcjHu0+pzsMgf
	 I6/K1471J8zEQ==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D584F378203B
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 08:19:03 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] device: Update local and remote CSRK on management event
Date: Wed, 31 Jan 2024 09:18:56 +0100
Message-Id: <20240131081856.308071-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131081856.308071-1-frederic.danis@collabora.com>
References: <20240131081856.308071-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the local and remote CSRK keys are only loaded to device object
from storage during start.
Those keys are updated on MGMT_EV_NEW_CSRK event only in adapter object,
but saved both in adapter and device objects.

Those keys should be updated on management event to be able to perform
signed write for GAP/SEC/CSIGN/BV-01-C and GAP/SEC/CSIGN/BV-02-C.

This commits updates the keys on management event in the device object and
move their storage to device object only.
---
v1 -> v2: Move CSRK keys storage to device object only
---
 src/adapter.c | 77 +--------------------------------------------------
 src/device.c  | 48 ++++++++++++++++++++++++++++++++
 src/device.h  |  3 ++
 3 files changed, 52 insertions(+), 76 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 022390f0d..3c053c231 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8786,75 +8786,6 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
 }
 
-static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
-				uint8_t bdaddr_type, const unsigned char *key,
-				uint32_t counter, uint8_t type)
-{
-	const char *group;
-	char device_addr[18];
-	char filename[PATH_MAX];
-	GKeyFile *key_file;
-	GError *gerr = NULL;
-	char key_str[33];
-	gsize length = 0;
-	gboolean auth;
-	char *str;
-	int i;
-
-	switch (type) {
-	case 0x00:
-		group = "LocalSignatureKey";
-		auth = FALSE;
-		break;
-	case 0x01:
-		group = "RemoteSignatureKey";
-		auth = FALSE;
-		break;
-	case 0x02:
-		group = "LocalSignatureKey";
-		auth = TRUE;
-		break;
-	case 0x03:
-		group = "RemoteSignatureKey";
-		auth = TRUE;
-		break;
-	default:
-		warn("Unsupported CSRK type %u", type);
-		return;
-	}
-
-	ba2str(peer, device_addr);
-
-	create_filename(filename, PATH_MAX, "/%s/%s/info",
-			btd_adapter_get_storage_dir(adapter), device_addr);
-
-	key_file = g_key_file_new();
-	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
-		error("Unable to load key file from %s: (%s)", filename,
-								gerr->message);
-		g_clear_error(&gerr);
-	}
-
-	for (i = 0; i < 16; i++)
-		sprintf(key_str + (i * 2), "%2.2X", key[i]);
-
-	g_key_file_set_string(key_file, group, "Key", key_str);
-	g_key_file_set_integer(key_file, group, "Counter", counter);
-	g_key_file_set_boolean(key_file, group, "Authenticated", auth);
-
-	create_file(filename, 0600);
-
-	str = g_key_file_to_data(key_file, &length, NULL);
-	if (!g_file_set_contents(filename, str, length, &gerr)) {
-		error("Unable set contents for %s: (%s)", filename,
-								gerr->message);
-		g_error_free(gerr);
-	}
-	g_free(str);
-
-	g_key_file_free(key_file);
-}
-
 static void new_csrk_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8882,13 +8813,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	if (!ev->store_hint)
-		return;
-
-	store_csrk(adapter, &key->addr.bdaddr, key->addr.type, key->val, 0,
-								key->type);
-
-	btd_device_set_temporary(device, false);
+	device_set_csrk(device, key->val, 0, key->type, ev->store_hint);
 }
 
 static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
diff --git a/src/device.c b/src/device.c
index afd073c6c..9b3b24254 100644
--- a/src/device.c
+++ b/src/device.c
@@ -169,6 +169,7 @@ struct ltk_info {
 struct csrk_info {
 	uint8_t key[16];
 	uint32_t counter;
+	bool auth;
 };
 
 struct sirk_info {
@@ -400,6 +401,7 @@ static void store_csrk(struct csrk_info *csrk, GKeyFile *key_file,
 
 	g_key_file_set_string(key_file, group, "Key", key);
 	g_key_file_set_integer(key_file, group, "Counter", csrk->counter);
+	g_key_file_set_boolean(key_file, group, "Authenticated", csrk->auth);
 }
 
 static void store_sirk(struct sirk_info *sirk, GKeyFile *key_file,
@@ -1955,6 +1957,52 @@ bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
 	return true;
 }
 
+void device_set_csrk(struct btd_device *device, const uint8_t val[16],
+				uint32_t counter, uint8_t type,
+				bool store_hint)
+{
+	struct csrk_info **handle;
+	struct csrk_info *csrk;
+	bool auth;
+
+	switch (type) {
+	case 0x00:
+		handle = &device->local_csrk;
+		auth = FALSE;
+		break;
+	case 0x01:
+		handle = &device->remote_csrk;
+		auth = FALSE;
+		break;
+	case 0x02:
+		handle = &device->local_csrk;
+		auth = TRUE;
+		break;
+	case 0x03:
+		handle = &device->remote_csrk;
+		auth = TRUE;
+		break;
+	default:
+		warn("Unsupported CSRK type %u", type);
+		return;
+	}
+
+	if (!*handle)
+		*handle = g_new0(struct csrk_info, 1);
+
+	csrk = *handle;
+	memcpy(csrk->key, val, sizeof(csrk->key));
+	csrk->counter = counter;
+	csrk->auth = auth;
+
+	if (!store_hint)
+		return;
+
+	store_device_info(device);
+
+	btd_device_set_temporary(device, false);
+}
+
 static bool match_sirk(const void *data, const void *match_data)
 {
 	const struct sirk_info *sirk = data;
diff --git a/src/device.h b/src/device.h
index 96f41d479..d4e70b7ef 100644
--- a/src/device.h
+++ b/src/device.h
@@ -135,6 +135,9 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 				bool central, uint8_t enc_size);
 bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
 				bool *central, uint8_t *enc_size);
+void device_set_csrk(struct btd_device *device, const uint8_t val[16],
+				uint32_t counter, uint8_t type,
+				bool store_hint);
 bool btd_device_add_set(struct btd_device *device, bool encrypted,
 				uint8_t sirk[16], uint8_t size, uint8_t rank);
 void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.34.1

