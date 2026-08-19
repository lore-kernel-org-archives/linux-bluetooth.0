Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A137AA8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172032; cv=none; b=Ud5zDnScufu53nMTGyqbKJ6pymVYo2Ry9GSJI1gC4wE3sV0mIp0+0bjv/nAOwGAvNFiRQ1CzIsK6oyNbnWm5ly0DUqnfRWXUbtdW7cNrA4wA6jRuqp3HRPgkyVFkSnq0/smqxhRTG9s9EM+Igrun15ellJ6OHGSPedQUOiz/Ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172032; c=relaxed/simple;
	bh=W8xFMPiPVxBrhKt2Ku46+bcrIrcyCwe+EYHpxEB1UHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugXvlHBvGOg2aUvaa/rtX9Snv7L4DwnEHvWR9lXXUyQdFbq+j1LS7M7+Lnw2/V7xSeZJnYIMLGxHqiVocIdvoMKLSUTDksqwUa+J1vQM1zNgS4m3PO8NZGSrYe+BOnlZgvajPY75NLO9v7akdicpt73oVfrYEciYTVE+HSeUvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmpSBk7q; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmpSBk7q"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so338282e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172027; x=1787776827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbF8J/mzBcNLVF5/t0NXVjChQNp6kw9tt0inqFQk3MA=;
        b=cmpSBk7qXVTQFPv1TRiqPL+9UAcdvglcvH59h5Jv5LLqCmutlNVCyW3+wUMeLvB/R4
         PZ8Cr7ty7IDRTfIiHob4H06VkkTHovkSME8qnOGwfuhcvYQ/gHv6KCKKxb5OT7UAjObk
         16FGTLpYHicR1ee8TQGCH0nlqjYTeca/QShQtzdCqtw35vho2dMABXJ3KffO1PoU7d9m
         xsM20zK9HaYCdQZfj/oXM0c5LGPleFfm+BRBYlFdtPGwf81a3qEBCIjvBcavMbK/VcpA
         ED6SBW9N14ECW0yVG6p6j+JbyDa/33DsPZpYOY0zF8xFnRhV+FHx+k4xtb8TnQro3qaD
         2cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172027; x=1787776827;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbF8J/mzBcNLVF5/t0NXVjChQNp6kw9tt0inqFQk3MA=;
        b=VRkD8UqM/eHurIszuYpv89Ka23XvZA4bNWxglPdVtIc4Ccj/EOJ63Nn3TGXkr2Irjz
         tD6Kz2TkS8SLI5Fq1wLTLfAuYqiT4vJyoHA5FevPKmn3aJUo+DKbVmvHD8rLav3PPUdm
         71+R9YvT0vzLe4EF6dk4ePN8JW5EDFrYGxl9pKIhUMVhScerInMzc3lpWAdH0volBA7+
         hCGiwXleVXd0DOzF91qlyjfEcbjXXTRAggVCFtK5UC49IHuanNhHHK44TQHhN/9zqQqs
         ZFaicogAzucFjaTnEVq2Ystmi0zAsmam4mg96z5UGudDNXy1NsKQ3bLNcKt0SR2MkNrB
         qaZg==
X-Gm-Message-State: AOJu0Yx3aQyhtvrMW5E6QH6B13opFmwcYkuqPblZ/kC70+3kAA093dgH
	SSvYeJt4B+baHbERmBjGzK+m9q4q2pOvRhtKKniNkG4tX3B88oTUN2CuI16yYENvNsqMxA==
X-Gm-Gg: AR+sD12skaWHm5oknP9TD1052p3ob+ckgTIQkS8HJPky71lh0ZVNhysvoKbhCAesV4o
	9X6a5TBm3+GFlrgyddFQFNHwIPBHCmm8V+1v+1FIYvdaxABBXeyP4YT8Fzyh4ux4xuCjrdpvlTt
	FnmNrNHmrtrnpQxBUF7USCtLrMKFmQzwjkDsU30xSlm02OBbm5YJEhpUSE05C68Bs+Mz6LgFWM2
	EjIqvsUE0ic3AcJR5xtm8dCN83r4xw2ibOYnp76QKmUdhM3cwYmGmqU4+lFrbs9phGoYFgPCvnn
	WScUWmmagf1g/+xgKe85y8c6iZ4gMhGw90esEdgAxGMSg7DkFvCFqIiYCEBOj+j4SZA/LHiLJuA
	0voN6manBktZYUe7gi0i+47BCClMxlqc//HvQglOA5kn1uWRMDZu3RHWn8J93x5ee+I1QF1Px41
	9ydTsHdNmCLJ0Uc37oAIbzngNiBAQqzPHx0pyzrI1N4lQ4OaUp+1EsXFZgrdFeAm8csWaaAWybI
	dbPCNex6xzMMwo7lTuKGQNI8DyeTnDCJm1IQdnsoedYF6wBlPxBBYM=
X-Received: by 2002:a05:6122:f05:b0:5bd:8dd8:146e with SMTP id 71dfb90a1353d-5c5ef215e68mr681409e0c.4.1787172027483;
        Wed, 19 Aug 2026 13:40:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/8] Replace the name2utf8 copies with str2utf8
Date: Wed, 19 Aug 2026 16:40:05 -0400
Message-ID: <20260819204008.2292225-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204008.2292225-1-luiz.dentz@gmail.com>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
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
 unit/test-eir.c      |  7 +++--
 6 files changed, 40 insertions(+), 119 deletions(-)

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
index 95351d015323..5c9ebe2af3a3 100644
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
index b1d1b84611aa..236e719507e4 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -275,22 +275,18 @@ static bool ad_replace_uuid128(struct bt_ad *ad, struct iovec *iov)
 
 static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
 {
-	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
+	char *utf8_name;
+	bool ret;
 
-	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (const char *)iov->iov_base,
-			MIN(iov->iov_len, HCI_MAX_NAME_LENGTH));
+	utf8_name = str2utf8(iov->iov_base, iov->iov_len);
+	if (!utf8_name)
+		return false;
 
-	if (strisutf8(utf8_name, iov->iov_len))
-		goto done;
+	ret = bt_ad_add_name(ad, utf8_name);
 
-	strtoutf8(utf8_name, iov->iov_len);
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
index 62164ca993f6..a4b6743e48b7 100644
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
-- 
2.54.0

