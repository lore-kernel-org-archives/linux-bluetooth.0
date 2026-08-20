Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698B38AC8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250662; cv=none; b=NTtJFBTxjB3pT8BWUmdsFV674T5V7ygHuk105ndUZLhzoyRmeOQqRNSpNIZF4md+t3yR/JYcCdTcUdKl7aRqfnzKU8MD4JJx6QQMX5AoKudvVbyEW3fJN63Nc0+sXt43qrBorHdn/b6lehobNO7goqlE06uaFp6y/GMN4mj7oBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250662; c=relaxed/simple;
	bh=knmNPlAl1Dc+y+/KkrMAsD5JQG04vD037uOMKVhl0Cw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7838XBYUG+9UVpMIMvFxMJOQxTCewV2sHO9SyQFHhXGFJtIG/5Bi2zOzU8DyUO9hf2LNTFEzfPKmaSIAI/afmbkP2HsC07Tr//nmVufiVUPvRj+QkqMgoSYtpgLfPGP6xYsYxcxpwCex656z3uIw/3Nfouvjk0gOnHC58WQa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJqnZ/Ja; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJqnZ/Ja"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c276bd3692so214712e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250660; x=1787855460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTUayeYkRbypIxKbOd0z6glYy59VdUYKmdlMll8eeJg=;
        b=TJqnZ/JaUCjf4CZJDq5gkZvrtvy5GxMERL0yd3LDm0e+W0r2ErN2as9MeRiFnrFIKw
         5gp8vsvhR+N1z9sRWR7OQV1hswnK1Sl1bu9N3A4PmrQy2CVAydZFQLN1/dGO82SK2jnz
         1h5YBMC79c9PeX/WB4FO4LQc0nUKDDswSefTPsbql7IcTPngUbAjCz6EK/jPw4E/lboZ
         Ppv9UwGQTLVsZOeKNvOpFJ7/NhTbyjm/g43DoI+xA2y8IJFj1T/ca6sXAkinmXvbU3V5
         uuereyyxQ01QNZsInBtUm86U2cPTf3x5UVmjf4LlDzB0QjLVLgRLXlu+J2IhvqL2uhFe
         jo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250660; x=1787855460;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NTUayeYkRbypIxKbOd0z6glYy59VdUYKmdlMll8eeJg=;
        b=pJnC/hS4D6PrUj/vkIbneFlSTao8oCpauGd0v+S57nHw9aNj/ZBzvZoL17HEa/xPAW
         DwzVZ3EwGJedssLE8Dd/voG2SOMdWN0K6UedMIc8qHvuKx9ByaKePOWwCA+Lih+f00a1
         ImbBRcf+3AjERtYHvXnEVznDZWIZXi44OS6S7Bs4ujaMKnA/GQh9ELQTZFShbCMMocuw
         JxCz/1q/nN38lUxbZ4r7o71mte6Yrd5qmxj1vBUwcKKMpPkQZWYuMkQEjTDa8cJx4IYx
         aliaQHM4HOJBlXKR9IdgtKTU+O/BWlCllU4RyLfY9wAKHKJK1hk2z59jhmI5rXuD0DZ9
         3dSA==
X-Gm-Message-State: AFuF++nCyl9sHMMRF+ivcYkYvxqcD/f8JxhvTM+qHeVwio1k/5qKX+xI
	lqCXxDCs3hS4dgWG7TDhvKYPt8shawaCOuCJVVrVi47UGf1QGHjQ30rvJLCKgey9
X-Gm-Gg: AR+sD10T6KhxsrmCEOnX39JxQ1L/GaWjnEvWQldr5UGyyBaFGD7WDxwDZ9piE8u5AFE
	N58qxoWHL/alOpd3k5PkTy4WZBAXbEM4QvmmMLEoFz84VBHG8+jMl3EcLzqFccce24sqS4e2Gm6
	n+ue7eHlZI4//khmVc6HKfQn+PxU4/4ZiODl7bnTaTWepmSmXCBXUpOc427HQpEcTDoQvKn4hZT
	ZMzSQ5dDfDWBQSiAZ2chamcF3QZxh78RAbwXqkl8MkADLAeJydANkuq90UXz9U8NCSb+NjF11Ge
	ZCNMd8rM0HpkAVeOf6j/izMNWF+tJrC7OhP9jhsaCnvVcWbzYDyksqUHjfybjBrF+fkXCQdFCiH
	ttiNXFbgjfxqcc4wl9RSHeVabXilohQA6mzMKzCBTH4VJSQBuw54SZsw2GzM1jfQui4jJRb9xm2
	/bH5qIyy1EnjvbgKtf5gah3hqk6qIqJyksLOmaAABrSa/+okRK/zBI61f3eD8rR/sg67+jd21yl
	vzX6kpj0Dz5yU5MSORdz/Q/MbIQzSBAWaX/Bmt7qjg627K74pu7Qeo=
X-Received: by 2002:a05:6122:489a:b0:5c3:2f5c:55b3 with SMTP id 71dfb90a1353d-5c5ff7a68a2mr439094e0c.3.1787250659836;
        Thu, 20 Aug 2026 11:30:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/10] Replace the name2utf8 copies with str2utf8
Date: Thu, 20 Aug 2026 14:30:34 -0400
Message-ID: <20260820183037.2713973-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

monitor/att.c, profiles/audio/mcp.c, profiles/gap/gas.c and src/eir.c
each carried their own name2utf8(), and src/shared/ad.c open coded the
same thing in ad_replace_name(), with none of them agreeing.

Use the shared helper instead, which drops around 120 lines and gives
every caller the same behaviour.

Two things change as a result. The monitor used to replace every
non-ASCII byte with a space as soon as one bad byte appeared, mangling
the valid part of the name, and now only the ill-formed sequences are
replaced. Everything else used to truncate at the first ill-formed
sequence, throwing away the rest of the name, and now keeps it.

The unit/test-eir expectations are updated accordingly, and they show
the improvement: the name that used to be reported as "test परी" is now
reported as "test परी<U+FFFD>्षा invalid".

str2utf8() returns memory from malloc(), so the callers that used
g_free() now use free().

Assisted-by: Claude:claude-opus-5
---
 monitor/att.c        | 66 ++++++++++++++------------------------------
 profiles/audio/mcp.c | 24 ++--------------
 profiles/gap/gas.c   | 20 ++------------
 src/eir.c            | 22 ++-------------
 src/shared/ad.c      | 20 ++++++--------
 unit/test-eir.c      | 11 +++++---
 6 files changed, 42 insertions(+), 121 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 7506dc528e85..44965a2aaf3b 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -15,7 +15,6 @@
 #endif
 
 #define _GNU_SOURCE
-#include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -2325,40 +2324,15 @@ static void vol_flag_notify(const struct l2cap_frame *frame)
 	print_vcs_flag(frame);
 }
 
-static char *name2utf8(const uint8_t *name, uint16_t len)
-{
-	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-	int i;
-
-	if (g_utf8_validate((const char *) name, len, NULL))
-		return g_strndup((char *) name, len);
-
-	len = MIN(len, sizeof(utf8_name) - 1);
-
-	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (char *) name, len);
-
-	/* Assume ASCII, and replace all non-ASCII with spaces */
-	for (i = 0; utf8_name[i] != '\0'; i++) {
-		if (!isascii(utf8_name[i]))
-			utf8_name[i] = ' ';
-	}
-
-	/* Remove leading and trailing whitespace characters */
-	g_strstrip(utf8_name);
-
-	return g_strdup(utf8_name);
-}
-
 static void print_mp_name(const struct l2cap_frame *frame)
 {
 	char *name;
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Media Player Name: %s", name);
 
-	g_free(name);
+	free(name);
 }
 
 static void mp_name_read(const struct l2cap_frame *frame)
@@ -2385,11 +2359,11 @@ static void print_track_title(const struct l2cap_frame *frame)
 {
 	char *name;
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Track Title: %s", name);
 
-	g_free(name);
+	free(name);
 }
 
 static void track_title_read(const struct l2cap_frame *frame)
@@ -2520,11 +2494,11 @@ static void print_bearer_name(const struct l2cap_frame *frame)
 {
 	char *name;
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Bearer Name: %s", name);
 
-	g_free(name);
+	free(name);
 }
 
 static void bearer_name_read(const struct l2cap_frame *frame)
@@ -2541,11 +2515,11 @@ static void bearer_uci_read(const struct l2cap_frame *frame)
 {
 	char *name;
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Bearer Uci Name: %s", name);
 
-	g_free(name);
+	free(name);
 }
 
 static void print_technology_name(const struct l2cap_frame *frame)
@@ -2612,11 +2586,11 @@ static void print_uri_scheme_list(const struct l2cap_frame *frame)
 {
 	char *name;
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Uri scheme Name: %s", name);
 
-	g_free(name);
+	free(name);
 }
 
 static void bearer_uri_schemes_list_read(const struct l2cap_frame *frame)
@@ -2726,11 +2700,11 @@ static void print_call_list(const struct l2cap_frame *frame)
 
 	print_field("  call_flag: 0x%x", call_flag);
 
-	call_uri = name2utf8((uint8_t *)frame->data, frame->size);
+	call_uri = str2utf8(frame->data, frame->size);
 
 	print_field("  call_uri: %s", call_uri);
 
-	g_free(call_uri);
+	free(call_uri);
 
 done:
 	if (frame->size)
@@ -2816,11 +2790,11 @@ static void print_target_uri(const struct l2cap_frame *frame)
 
 	print_field("  call_idx: %x", call_idx);
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Uri: %s", name);
 
-	g_free(name);
+	free(name);
 
 done:
 	if (frame->size)
@@ -2928,9 +2902,9 @@ static void print_call_cp(const struct l2cap_frame *frame)
 		break;
 	case 0x04:
 		str = "Originate";
-		name = name2utf8((uint8_t *)frame->data, frame->size);
+		name = str2utf8(frame->data, frame->size);
 		print_field("  Operation: %s  Uri: %s", str, name);
-		g_free(name);
+		free(name);
 		break;
 	case 0x05:
 		str = "Join";
@@ -3124,11 +3098,11 @@ static void print_incom_call(const struct l2cap_frame *frame)
 
 	print_field("  Call Index: %u", call_id);
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  call_string: %s", name);
 
-	g_free(name);
+	free(name);
 
 done:
 	if (frame->size)
@@ -3157,11 +3131,11 @@ static void print_call_friendly_name(const struct l2cap_frame *frame)
 
 	print_field("  Call Index: %u", call_id);
 
-	name = name2utf8((uint8_t *)frame->data, frame->size);
+	name = str2utf8(frame->data, frame->size);
 
 	print_field("  Friendly Name: %s", name);
 
-	g_free(name);
+	free(name);
 
 done:
 	if (frame->size)
diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 0c2e0de0b156..8adf814e8d73 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -73,26 +73,6 @@ struct remote_player {
 	uint8_t playing_order;
 };
 
-static char *name2utf8(const uint8_t *name, uint16_t len)
-{
-	char *utf8_name;
-
-	utf8_name = malloc(len + 1);
-	if (!utf8_name)
-		return NULL;
-
-	if (len)
-		memcpy(utf8_name, name, len);
-
-	utf8_name[len] = 0;
-	strtoutf8(utf8_name, len);
-
-	/* Remove leading and trailing whitespace characters */
-	g_strstrip(utf8_name);
-
-	return utf8_name;
-}
-
 static const char *mcp_status_val_to_string(uint8_t status)
 {
 	switch (status) {
@@ -118,7 +98,7 @@ static void remote_media_player_name(void *data, const uint8_t *value,
 	struct remote_player *remote = data;
 	char *name;
 
-	name = name2utf8(value, length);
+	name = str2utf8(value, length);
 	if (!name)
 		return;
 
@@ -145,7 +125,7 @@ static void remote_track_title(void *data, const uint8_t *value,
 	char *name;
 	uint16_t len;
 
-	name = name2utf8(value, length);
+	name = str2utf8(value, length);
 	if (!name)
 		return;
 
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 0f41c9e6c2a5..5184d74e8f07 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -66,22 +66,6 @@ static void gas_free(struct gas *gas)
 	g_free(gas);
 }
 
-static char *name2utf8(const uint8_t *name, uint16_t len)
-{
-	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-
-	len = MIN(len, sizeof(utf8_name) - 1);
-
-	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (char *) name, len);
-	strtoutf8(utf8_name, len);
-
-	/* Remove leading and trailing whitespace characters */
-	g_strstrip(utf8_name);
-
-	return g_strdup(utf8_name);
-}
-
 static void read_device_name_cb(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
@@ -98,13 +82,13 @@ static void read_device_name_cb(bool success, uint8_t att_ecode,
 	if (!length)
 		return;
 
-	name = name2utf8(value, length);
+	name = str2utf8(value, length);
 
 	DBG("GAP Device Name: %s", name);
 
 	btd_device_device_set_name(gas->device, name);
 
-	g_free(name);
+	free(name);
 }
 
 static void handle_device_name(struct gas *gas, uint16_t value_handle)
diff --git a/src/eir.c b/src/eir.c
index 4421b1662d65..5c9ebe2af3a3 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -60,7 +60,7 @@ void eir_data_free(struct eir_data *eir)
 {
 	queue_destroy(eir->services, g_free);
 	eir->services = NULL;
-	g_free(eir->name);
+	free(eir->name);
 	eir->name = NULL;
 	free(eir->hash);
 	eir->hash = NULL;
@@ -133,22 +133,6 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 	}
 }
 
-static char *name2utf8(const uint8_t *name, uint8_t len)
-{
-	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-
-	len = MIN(len, HCI_MAX_NAME_LENGTH);
-
-	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (char *) name, len);
-	strtoutf8(utf8_name, len);
-
-	/* Remove leading and trailing whitespace characters */
-	g_strstrip(utf8_name);
-
-	return g_strdup(utf8_name);
-}
-
 static void eir_parse_msd(struct eir_data *eir, const uint8_t *data,
 								uint8_t len)
 {
@@ -301,9 +285,9 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			while (data_len > 0 && data[data_len - 1] == '\0')
 				data_len--;
 
-			g_free(eir->name);
+			free(eir->name);
 
-			eir->name = name2utf8(data, data_len);
+			eir->name = str2utf8(data, data_len);
 			eir->name_complete = eir_data[1] != EIR_NAME_SHORT;
 			break;
 
diff --git a/src/shared/ad.c b/src/shared/ad.c
index ebee078500c6..236e719507e4 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -275,22 +275,18 @@ static bool ad_replace_uuid128(struct bt_ad *ad, struct iovec *iov)
 
 static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
 {
-	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-	size_t len = MIN(iov->iov_len, (size_t) HCI_MAX_NAME_LENGTH);
+	char *utf8_name;
+	bool ret;
 
-	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (const char *)iov->iov_base, len);
+	utf8_name = str2utf8(iov->iov_base, iov->iov_len);
+	if (!utf8_name)
+		return false;
 
-	if (strisutf8(utf8_name, len))
-		goto done;
+	ret = bt_ad_add_name(ad, utf8_name);
 
-	strtoutf8(utf8_name, len);
+	free(utf8_name);
 
-	/* Remove leading and trailing whitespace characters */
-	strstrip(utf8_name);
-
-done:
-	return bt_ad_add_name(ad, utf8_name);
+	return ret;
 }
 
 static bool ad_replace_uuid16_data(struct bt_ad *ad, struct iovec *iov)
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 326bc899e251..380fcba2f38e 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -407,7 +407,8 @@ static const unsigned char invalid_utf8_name_data[] = {
 static const struct test_data invalid_utf8_name_test = {
 	.eir_data = invalid_utf8_name_data,
 	.eir_size = sizeof(invalid_utf8_name_data),
-	.name = "test परी",
+	/* The truncated sequence is replaced by U+FFFD, the rest is kept */
+	.name = "test परी" "\xef\xbf\xbd" "्षा invalid",
 	.name_complete = true,
 	.tx_power = 127,
 };
@@ -435,7 +436,9 @@ static const unsigned char iso_2022_jp_name_data[] = {
 static const struct test_data iso_2022_jp_name_test = {
 	.eir_data = iso_2022_jp_name_data,
 	.eir_size = sizeof(iso_2022_jp_name_data),
-	.name = "test \033$B",
+	/* The 4 JIS bytes are replaced by U+FFFD, the escapes are ASCII */
+	.name = "test \033$B" "\xef\xbf\xbd\xef\xbf\xbd\xef\xbf\xbd\xef\xbf\xbd"
+								"\033(B OK",
 	.name_complete = true,
 	.tx_power = 127,
 };
@@ -475,8 +478,8 @@ static void max_name_setup(const void *data)
 static unsigned char long_name_data[255];
 static char long_name[sizeof(long_name_data) - 2 + 1];
 
-/* The name does not fit, so it comes back clamped to HCI_MAX_NAME_LENGTH */
-#define LONG_NAME_LEN	HCI_MAX_NAME_LENGTH
+/* str2utf8() does not clamp, so the whole name is kept */
+#define LONG_NAME_LEN	(sizeof(long_name_data) - 2)
 
 static const struct test_data long_name_test = {
 	.eir_data = long_name_data,
-- 
2.54.0

