Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6C4A3871
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264807; cv=none; b=pHbIjCJMZypZNJYrGQTCZy1ddp4G4m12HXEYG5VQoeBhmZorkozgJ5I3Es4sb9jbg7vPeEDflYxkZzCAOMgzQ95Z2MB+MDUCSDv68hojbroLZseVF5aKNsLz1UFk/WBAtNJ/HgsoenbdkeumYoJoQ1aHaEUixYsfcebomFma1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264807; c=relaxed/simple;
	bh=YS3Y2l2KXMdM2IXM9Lwwbp92pdPz0FQ+xldkWEeibAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJNvSt53gJ3gVhhEmS3B+P1qjVixtA4OJGFs+UuILPOVitiXJ6jWXIsX7ph+UusbgsjtmpTC25jlEnkAHbrcbVgfq90zHOBgu7oks0rZGvaCIpBQ0FoiF0GrZmMJIR/+BYKuSJd1yOLkyl+lE7pNi9BtPBBAxJj6n7GzmTTaJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw8uaiDu; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw8uaiDu"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-791a9878aa9so725576137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264804; x=1790869604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CqR6uO/uwEHHmwwTXTUR7ELHj1rxE5jBOPGEY6m5cr4=;
        b=kw8uaiDuI3h+gc7Qb5uyBzJG2w4BUruaO1ePL7ud7VfdTNiLiJUTYd7LK+6i8hKIk8
         JdMHhOMw+MxQNR40p6FYdUpnCD1TPu+1mxQSazuiY2/FItK037LHnoCNTzGh29CAI3+s
         xyuY4sLvpz8nHYjsLzSJJMnk57lFux4SuvF0hR7cVflkjo5DmS6qxZEjoTFLZY9FLn5X
         MoefkT9iyVLf+nYnX4YxWo02mqL44hO6X/51sHpLd/nzSqcSNsranMxTUXOlpzVum7Ef
         X6BfsYqyDg8AWIgaoA9paVdSDbDZCn8xwokg6fr2LFTsMCqJorkaZao1AxcWMGbSDfQw
         vrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264804; x=1790869604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CqR6uO/uwEHHmwwTXTUR7ELHj1rxE5jBOPGEY6m5cr4=;
        b=fkY6MJylVyuw59Lk3OQu7yP8UiIvpNiL8jiTQZI1XhU5hAi8lU/rC2nWGmvK4JhDxd
         IHeL46LuP8q9ez7kPTSdXKzFQ0eXYIOOK/pUPoUeKdZvF0mubpopr2jkB6x0YFHwmp1G
         hNzh/wuc/ZDAVC35oTk4m1Q7UypGBsTXJNNMtl9Wglt+OZbSNx2e7zLkp+Fq6xigttbu
         R6Jl3gxf/MyiizKpUkLi9rZ4mPBs/zWVkEdrpv/Dl2PbG2uCa7t5jXbfYh9b6jhbkNcc
         8jl37TlBeMw0icVsHmaM6oBd6Js42RKe5KPFOLEuF2AuIZDwd6tXwr3skStWgabZ9d53
         cuIg==
X-Gm-Message-State: AFuF++nVn9XcRwtK5D6FZ2XbVBE2T1rf8k+hXMPoOEuOKzpF0tDfEEot
	iQA1fRr7RDEx9+Bck1EXsFwvN7tnQar9jWOEqiHeTaOFSr4t9Es2Jck8iGhChkX5gkcPaA==
X-Gm-Gg: AYBFou0ssG1mKFCbwc1iI+HmdaOjTDRdXFh5JwWfgx8+INFTskqfB0/oHgwku3TQQmR
	w9SPtM1bDesvfB/jsnS8vlcVrye3nAvZ7hdrRcsxGSkAQidWkuBmxlaWLp3Z8xlmDSYRJG5q165
	8SAHPkiO7ZZYKQbbsQfj+nfsxOroXgHIH23Leb4rgVa3ZJtHRs/uCEeGiG8odSAt+am6eKKqjvq
	Y6GXuC1BivlVlw4kjZoK+Zw1ZbbHNwOIQwGtua9ruFaGzDmrapcWhWyYoQ8EaDfIbgJmQjEl5uv
	hwKUw3weIP1Fs7iEX9F2FSPQmoPbKDiOrf6BFyLornEhtuYgUCgPQ5WLCK88mLeVzqHNj+gQ98J
	8c61ab5XL3Db22WWZlnsxykEjFu/jRvhE1bd7aqJJyTRrmwWrFE6cPngJHV9M0O5+8w5btP28t9
	BOrnFb3XcBPH4vAnQG2onPVz3NxWgdy8egCU52bhEB9cKY6/LPPPEXpEc97rjirIBRNAg7zgE7t
	2NhHrG0NMTPpWLIYDMaKXAtzuISNNNwh3+2a4OitoGJLCALgTWYtkBxEgbDwEE4
X-Received: by 2002:a05:6102:b07:b0:7a6:e302:e24f with SMTP id ada2fe7eead31-7af1d4b7b6amr1262961137.24.1790264804117;
        Thu, 24 Sep 2026 08:46:44 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/9] client/gatt: Fix setting descriptor value from scripts
Date: Thu, 24 Sep 2026 11:46:25 -0400
Message-ID: <20260924154631.369299-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
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

