Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B035C6A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258177; cv=none; b=LM0DKWoTGQY2pQ0tDV3qdVUg/bXzmZ6At5xje1KI8hFwpShcRQvwr/0Jv3w0ZDdhpZvdRaLTJoTzwGGPDn0EOPdW6lWutWrxQbQM/dyU9mrlFIXpxMTQmx0CeGsp001YlFdr44uiMAqFV2JmSwKSKm6eXNVsO+zaY/UN/zXVrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258177; c=relaxed/simple;
	bh=YS3Y2l2KXMdM2IXM9Lwwbp92pdPz0FQ+xldkWEeibAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TD2X5gyNY0bdsEvMsj22IbQrizHUy1NAkpb0Jo1g8Ed9fsaj4n9u5ZR6+nLGkoBfhUxgYcRlKYP7iVC17KKS0rcSc64zfaJQWIMC/jLvA9eMVDEkTBgLwXYNEnBDC0IvP7pCLR8hIlKhn5E4nxGzsDs5TeUJnv7/z7Rrl6h1s8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVx/cx9O; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVx/cx9O"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c8602so1051434241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258174; x=1790862974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CqR6uO/uwEHHmwwTXTUR7ELHj1rxE5jBOPGEY6m5cr4=;
        b=SVx/cx9ODGX/Ipf5PQxw1YYmlX6dFg3fZJFu3hrXKUdKmUnp0KndkIM6S6AZThCslF
         xxDtP2JJzq4tJRFj55oT6Hy7yasmP9znvVSxw2+kCsuxlaIetDhEdpZ2nf3nDb1XV6kQ
         W0l6eJpwsJ7Ip9uaKMkmXcf3e9foue5qERNPEWiAaah9lkL0QBJbo6HtxqZfOfGKMoFn
         eebP3VqTIsSEjNYi3Yop3QWsMFvy3Gf53Ayz8uedlEwK9ybVvOb0uN3JQr6gE5lPEITB
         ui0JgTuL6x9PS+gki6h67vdW4zsmWAlaxhNsNM+dq02wM5iodVAEfKpU1KxWsZX3ehyU
         VLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258174; x=1790862974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CqR6uO/uwEHHmwwTXTUR7ELHj1rxE5jBOPGEY6m5cr4=;
        b=kHuT4tyjxXH05XQisp7fQJqKGA3rn6GwP1jFBRlwM6wYUFU5FrHjiOBHxMNLUSA74H
         k4wXjS8vqyqqVI1H+kHwDoFN8lH9egHUp2Qnwz28j2ybo3w+Wltchu8woWgm3S/aRsLL
         LJoitbdyP2MPmCTX7HXMDHipYTG5vj1ebFOiZKoSe6+oTjUGbjaW0S6scUtnEbDeChyW
         Vym0MsdiqjKWxCnglOYBS2wXM+2N/RtAT9Qsv6hD3d3K/HCt0z+FEhIfMrhY81s4C4Jp
         tsv0may4uFLgiV5R+nZfqKYicoIinmixDtxvR9OUsZPuEajbWARyNbeiaEXxVxk7B6tW
         ZNIw==
X-Gm-Message-State: AFuF++mUWcGnj+R1y2MFOf6mxVBlnU+JZTbRv8loPLU8tDJ4tp7SfYYe
	HuUXHsO1H3ijmXXCHTc6kGN26j/vSllU0dxlvPDIumCqH011eGF45c5rrTahCNmf1CQOMg==
X-Gm-Gg: AYBFou17Z8CLX+Acu3h8Dh7nZ6odeZOwgs2vh8/9VjioJPf4qNc1uNKjn7ypV44Ixm/
	QXdwn/G+qkC/IMhOLfw7zbvV3mSzLokc5DO7lOblgwSRyX+2joH2JXE5TQGkmO2dNZ2e6cZ7EM1
	ZF0LFe37aXOVrlum9hjbEA/cP7xnlFYj6PywCvhCW0613/Qdo5h9/0lL2ZYqdwObt93HEUG+EEi
	ngKF0hNoUlKstegwkCVsZpI0gH3hzXSx9YV4PQ5rQZnjk6sQoMy09WrnxkeeRHt1Xhy0L4zZE12
	mP6GfcnaoSSBUHwn7FLOxCEcKl4ysJ6X/u/lahQtzIX6c8zUJgtIHCj/XoActB979zUJScHnMBB
	rDgizJjcBaEE6p5uG9xi7vG3uBnf7XVrniYiYmnFrTiTSi3yk4uUe7Zt+8rAjRfh/RKkLfYqEwH
	Ja/z183hQ6BImjr7TDxx/SpxKpYNd038EB+MGD5nF/Oa8PvjkVJl4S5mz+jA9gEsCoSShdBYpTa
	cz4LzA+sXA+h/ZuxzuKI944r7xrZ8n3AAbsmXMPowUBMeMQo/8Llk45gufIfmyH
X-Received: by 2002:a05:6102:e12:b0:7a1:f7d2:e81f with SMTP id ada2fe7eead31-7af1e6eddf8mr1272860137.24.1790258174074;
        Thu, 24 Sep 2026 06:56:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/8] client/gatt: Fix setting descriptor value from scripts
Date: Thu, 24 Sep 2026 09:55:55 -0400
Message-ID: <20260924135601.330277-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924135601.330277-1-luiz.dentz@gmail.com>
References: <20260924135601.330277-1-luiz.dentz@gmail.com>
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

