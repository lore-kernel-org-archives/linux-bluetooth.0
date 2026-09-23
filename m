Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72A424D76
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191927; cv=none; b=YhSG8YV0XVtlJeDX63XiwSy2XCBthh6FAlNaqFAU5ClNp2SWifgnS+MKy9QC8zz+2ezPnVvU026jF2JHyWmzOSzEAVmLLqRwgSDrWYtmsWQXF/FkbkcfbHpajxEr3K+1UMqBZ3ZlYVpAoNoXDd3NgKB3ZTNJqmr8MwlCvarnESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191927; c=relaxed/simple;
	bh=YS3Y2l2KXMdM2IXM9Lwwbp92pdPz0FQ+xldkWEeibAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8NXKxpiYUk2g2duubeqKDTX3guWnZWNNKsMFZBBFQHr5UEs+fliR+7PQU6tpQkFPoY4u7doXpPvngKSnYvjSg+Ya0SMZLQekcYn0EmZfcI36XjekX9uQEgxNZk+E+GFgLzFhKkD8BLDlXIP/yq8UHkMo9Nu7agNWfxrkEMq5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9ePYvGY; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9ePYvGY"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-7856441f7d9so535844137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191925; x=1790796725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CqR6uO/uwEHHmwwTXTUR7ELHj1rxE5jBOPGEY6m5cr4=;
        b=R9ePYvGYLLW1R+5kWhR3azFkJSo3XUwMAdbaC8TY4m4BBusejVkfStiw+eHc7Yh2r0
         Yov3HHE9rcs1aQDeRKyepc121K/vEnLrtg32vDpXGVjULJ4iX2fZdxzJuzcufI3TrbdK
         npJLayc8Nzyb0G7cDFeKehlSp9PZiXAKq1wlLa/hACnyX82iqnBSd7fRShG3r32KHnh/
         A7f/5C4t7yuy58Ib7bkb2127PCpcrRzbGbB0QaLMvlBjpCCHXr2eIEzFmGiOq83QFScV
         YuixzkRTBDcuOli08G7z8iGqTAXMxq8zwJ2QAYcOcq8mxp+gPVEoFYgoNHnKcTKrK7+r
         YU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191925; x=1790796725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CqR6uO/uwEHHmwwTXTUR7ELHj1rxE5jBOPGEY6m5cr4=;
        b=ZfW8BmFUItj1/n3E1zJZaF9TcS1ge/rwe7CqEQodUSH57PQzzgGyqO74oZs/kngBZc
         UE962dB3MGJov6vlW1Foir5UHadK7hLq+XETlwe7lmzC0GZrMPmbgOBMMUFh4n9ML5P3
         1a7B1roqgdxnKLrettn2FSBI/P8CsmU9k/rc93RiGy7Pdq6qgMGXEQkP4iamvi4NXm1y
         qkAPtMG+1veI0FsYK9UNFUz87L9GCURNepeWYTuaOEzwxlU6WYaOfzPaAXWmg8P1MSSB
         zKOikhRjCZLWW8SgTUndcdsfHRFgyIDjHvpJMWG0JlmXKljL5B4uqIb4sgd6uMl6NBqT
         MizA==
X-Gm-Message-State: AFuF++mPXHGJqSBi0xJU+4IDz33UpFdNgC1zStty96TJfpafhBe7nLgT
	PVC6bDi2rzyP7eFw5CNF/Jl5vUJXPgFzIl1f3a6DmrDANMu6A1ulf9haOHgjia4q09OOOw==
X-Gm-Gg: AYBFou1NaTwX7pMa6Oef2ABB1qgCKCpI3Deln/dMlgwQoXhdS8NHljeW0wOwxaqNuLk
	Aq2FIA8Pu8Doc/xRC5xNcUF52mn0uZSnXC9rVHsdI3fAiZpN95LKSHY1QxLibdMGaWsHt/cJXFt
	mp2oq3/bOh1duhQ2DVSuLmt9HlMvcc0CSc3F08r6ZTENbi5SeSeHSBrsj4S7lo5B5D/saUiLtLv
	hJWuJIc9JKnYebD7opnnaMSa8cok/pFc+0rrTUPHI3DoJtle2WyWkSwqTisvw2akcOCBiQR3xkS
	vH4Au+QGodtevg9M4RD65H9ZB2HoIzmQCsxN0S602HSMq79ZOaft8ho/Z13mFIH2v1s3T59JmJN
	uRj14K3kwrCJf61ljGbWZc7WxB8dr2zQtcgKOP08nSVC9qk/wpo0y5GM/hrBqFyZ8Sisj6Lw1H0
	quyNgQrTRIfdRpE+nnqMjTawTefJlLvdd2RZ6GKTQOvO7ljw7Pvi7n+ujU9nzSX9ko8pVLEJCfY
	dgkuQjLmJI8YAjyUI8UQgCKXl2y6QiITqpXMGJARxs8OVIbLJhHW0Sp1uoEPVrm6VcLg38X8n8=
X-Received: by 2002:a05:6102:3c8e:b0:7a7:c789:888 with SMTP id ada2fe7eead31-7af1c799ab1mr227502137.5.1790191925327;
        Wed, 23 Sep 2026 12:32:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm4666266241.2.2026.09.23.12.32.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:32:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/7] client/gatt: Fix setting descriptor value from scripts
Date: Wed, 23 Sep 2026 15:31:51 -0400
Message-ID: <20260923193157.249636-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193157.249636-1-luiz.dentz@gmail.com>
References: <20260923193157.249636-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt.register-descriptor completed the command right after prompting
for the value, so when run from a script the line with the value was
executed as a command instead of being passed to the prompt, causing
the descriptor to be unregistered.

Complete the command once the value is set, as done for
characteristics, and parse a copy of the value so the input line is
not truncated by strsep while still in use by the shell.
---
 client/gatt.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 6dc80e2a31cd..ebbe4e3c7a32 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -700,13 +700,20 @@ void gatt_read_local_attribute(char *data, int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-static uint8_t *str2bytearray(char *arg, size_t *val_len)
+static uint8_t *str2bytearray(const char *arg, size_t *val_len)
 {
 	uint8_t value[MAX_ATTR_VAL_LEN];
-	char *entry;
+	char *str, *next, *entry;
 	unsigned int i;
 
-	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+	/* Parse a copy as strsep modifies the string, which may still be
+	 * in use by the caller, e.g. the shell printing the input line.
+	 */
+	str = next = strdup(arg);
+	if (!str)
+		return NULL;
+
+	for (i = 0; (entry = strsep(&next, " \t")) != NULL; i++) {
 		long val;
 		char *endptr = NULL;
 
@@ -715,18 +722,22 @@ static uint8_t *str2bytearray(char *arg, size_t *val_len)
 
 		if (i >= G_N_ELEMENTS(value)) {
 			bt_shell_printf("Too much data\n");
+			free(str);
 			return NULL;
 		}
 
 		val = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
 			bt_shell_printf("Invalid value at index %d\n", i);
+			free(str);
 			return NULL;
 		}
 
 		value[i] = val;
 	}
 
+	free(str);
+
 	*val_len = i;
 
 	return util_memdup(value, i);
@@ -2788,7 +2799,7 @@ static void chrc_set_value(const char *input, void *user_data)
 
 	g_free(chrc->value);
 
-	chrc->value = str2bytearray((char *) input, &chrc->value_len);
+	chrc->value = str2bytearray(input, &chrc->value_len);
 
 	if (!chrc->value) {
 		print_chrc(chrc, COLORED_DEL);
@@ -3078,7 +3089,7 @@ static void desc_set_value(const char *input, void *user_data)
 
 	g_free(desc->value);
 
-	desc->value = str2bytearray((char *) input, &desc->value_len);
+	desc->value = str2bytearray(input, &desc->value_len);
 
 	if (!desc->value) {
 		print_desc(desc, COLORED_DEL);
@@ -3086,6 +3097,8 @@ static void desc_set_value(const char *input, void *user_data)
 	}
 
 	desc->max_val_len = desc->value_len;
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
@@ -3134,8 +3147,6 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 	print_desc(desc, COLORED_NEW);
 
 	bt_shell_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct desc *desc_find(const char *pattern)
-- 
2.55.0

