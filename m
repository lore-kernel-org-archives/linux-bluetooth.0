Received: from mail-vs2-f16.google.com (mail-vs2-f16.google.com [74.125.227.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6A43F4B7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289062; cv=none; b=VhWgWV9dgAgm5q5a6rGRMX0AIhA2zBW84sMDMUtD7wvma10p5eN1agylGiRVmeWcPqeDiH7c8jG4P81A8xCliz8VCKucyAUGDmdDQ4r8qzlVYjdBimnDDtM93Ea9dDRRkOTSRsS2BOcJT5ZBNePyHg3mbMq35H12o/uSI7e66SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289062; c=relaxed/simple;
	bh=dup7L8R7FxiZ74gmsejuHt12RirHhbJEC2J2UDvlofM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B823dh9ASb0e5XMSwgQmW+GKopSX/XK+x2OO7m/F+GQxBqTMBmmOoznhh4ybUxRNTWyk6YwiE7c2E7PJLDdFXqdJhCIb3F6XmsSdC9vhNUdnrUrZ+t8ioD2dq/Dqw2ReJcDp1P8SbGOMpp1KnoO/lUW0eHFCWWGAZqXcBBrYwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0tNxmpi; arc=none smtp.client-ip=74.125.227.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0tNxmpi"
Received: by mail-vs2-f16.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso88622e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289059; x=1790893859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mEffHrWrxnpzptqwCy+9/9nISlwvU3rsWNVbUFda6I0=;
        b=Y0tNxmpiWEkDSAC16V5DjXSxdPHxqun4YALobdgCaDwtOq+1RUVISTi1gWqkQuY9qu
         kljNuw6pXIfMW21DoP4OTgcij0rnZsB4uKsZzkbgS2GcLFExHpRE9wdAkNyY+YaRVdeV
         rNq74pGPe3rodTlclZVFz35y7ruAvzihvJgmgPWG2TZZr+hQgojMR1cFi/uO+KfZbn09
         Wv28qU6AF7iVsjI/Z+Gwg7+vm7EBx1uk28Qi+uPPZR1Fmd4JoxpScQwGZDCsxeC9izNu
         FHUOc6+BJyq8/XJoZTMdOf9iHIi9KbgIsbGuDQ6BzuvPFHucB7v6S0h5934DE8JLigBT
         xh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289059; x=1790893859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mEffHrWrxnpzptqwCy+9/9nISlwvU3rsWNVbUFda6I0=;
        b=CpcF3AGeXXUeu+PC64hn5AjW6F8b92D5oWyoR2YSh2P0lvrx8mn8TZ6MkS1WoM2doX
         NlB2quJk8IUdjs7sYef7gOFEkt9j37BMGt75QHiQEU5wpJKtYH3dkA2RIXMRP1sJReNp
         EHwRRYY22zny6mwKmbE4Ntc69Yo9z3A4pC1+vpQcsbusx5mNhxG0YNGsUFkWKbMTmyXk
         dCxYCD7BsYiPwOjpT5mRLJSS/OttTHSRil2uE5kLp8T3/Jr+NgEIqsApaorgUGKkeij1
         ndgAYSdTX++mracOT2MnsIYoxapIYPlOu67GQgLdN2npvtNSdtsznimkCsmUHGlpkUNy
         uLUQ==
X-Gm-Message-State: AFuF++l0d07m5I6KLlKvQPQavx7AjZayYfRXwmCHpXh+IMeb82twbxC9
	adSON4wYtit/ZRMvquJcgTbVk0SiNmN2Mhe8NuCVRyCS9rsKlXp5OFGuBkbFosDx1zYE0Q==
X-Gm-Gg: AYBFou0DsBR6Pl9zf6m9EcViKFInyDSMGgXyEYcNRILDawnVzvArw5SKp0LH9BQcLeJ
	UiA9kmXjzYGi+qezr68pkaTiFsHhQ7//LxmF9/8N2fgVX3F86FOlA1LFsf9Zhj3VJ/m8RKXECdg
	FzWJkitLogW9oyaxQf81CBfOImGxIavnYWmEHS9G3JdypFNaW7pKL8ipHonFaxcyYirHcWP/vRU
	TurOauDS5Q6KfuGxY9ooeBbWVbwjilc5tXY7WSUWVbgwOqcHWTyYcKN7jLN7JIXjL6dlU57bBNG
	i7jliu3hNfcv/IPd/Ry9YfK06MJZd4epQyoNzDqxmG7RpxvcWWeSYo6efri6Rl8jOsrucB7gx/0
	lNj+4LNSrAcJdxUAzt1ZDTKKErGCk+ud1Ghx886VH4/i2Ctoa44vZOdq3VqW8KEvSvPBdzH8QkY
	T2t0mAzFJ6EA/myCpU4Oepb/kuyy95ZGEpGb0+2F7GyrJoQ3K739i97pFuGmhtn7qvYXr2soK90
	jM44GF6utsBDaULVIlZ29/PrRoGFYn7FvQg4UlDnfGnxJ8X6Nj9YF59Fflk1oeE
X-Received: by 2002:a05:6122:2490:b0:5c9:a60b:e5d4 with SMTP id 71dfb90a1353d-5cb0b67d543mr2269929e0c.14.1790289058784;
        Thu, 24 Sep 2026 15:30:58 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.30.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:30:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 02/20] client/gatt: Fix setting descriptor value from scripts
Date: Thu, 24 Sep 2026 18:30:27 -0400
Message-ID: <20260924223046.605543-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

As invalid values can now come from scripts, fix handling them: the
attribute is no longer used once unregistered, which frees it, nor kept
in the list of its parent, and the command fails. Also stop counting
the empty entries between the values, which left bytes uninitialized,
and reject negative values.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/gatt.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 6dc80e2a31cd..a85f6003d9b8 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -700,13 +700,21 @@ void gatt_read_local_attribute(char *data, int argc, char *argv[])
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
+	/* Only count the values, not the empty entries in between */
+	for (i = 0; (entry = strsep(&next, " \t")) != NULL;) {
 		long val;
 		char *endptr = NULL;
 
@@ -715,18 +723,22 @@ static uint8_t *str2bytearray(char *arg, size_t *val_len)
 
 		if (i >= G_N_ELEMENTS(value)) {
 			bt_shell_printf("Too much data\n");
+			free(str);
 			return NULL;
 		}
 
 		val = strtol(entry, &endptr, 0);
-		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+		if (!endptr || *endptr != '\0' || val < 0 || val > UINT8_MAX) {
 			bt_shell_printf("Invalid value at index %d\n", i);
+			free(str);
 			return NULL;
 		}
 
-		value[i] = val;
+		value[i++] = val;
 	}
 
+	free(str);
+
 	*val_len = i;
 
 	return util_memdup(value, i);
@@ -2788,11 +2800,14 @@ static void chrc_set_value(const char *input, void *user_data)
 
 	g_free(chrc->value);
 
-	chrc->value = str2bytearray((char *) input, &chrc->value_len);
+	chrc->value = str2bytearray(input, &chrc->value_len);
 
 	if (!chrc->value) {
-		print_chrc(chrc, COLORED_DEL);
+		/* Unregistering frees chrc, so it is removed first */
+		chrc->service->chrcs = g_list_remove(chrc->service->chrcs,
+									chrc);
 		chrc_unregister(chrc);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	chrc->max_val_len = chrc->value_len;
@@ -3078,14 +3093,18 @@ static void desc_set_value(const char *input, void *user_data)
 
 	g_free(desc->value);
 
-	desc->value = str2bytearray((char *) input, &desc->value_len);
+	desc->value = str2bytearray(input, &desc->value_len);
 
 	if (!desc->value) {
-		print_desc(desc, COLORED_DEL);
+		/* Unregistering frees desc, so it is removed first */
+		desc->chrc->descs = g_list_remove(desc->chrc->descs, desc);
 		desc_unregister(desc);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	desc->max_val_len = desc->value_len;
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
@@ -3134,8 +3153,6 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 	print_desc(desc, COLORED_NEW);
 
 	bt_shell_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct desc *desc_find(const char *pattern)
-- 
2.55.0

