Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880364E2F38
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616781; cv=none; b=kmXCqf3GkJHJCvhFZ9TCaIz9vqDTucAv3hww01loSC5wuXAMCWzsIawe3Lm0a2t4R5Fx5/s00HbIpEfyJoDRteud8wUS+lrTCj4tUnVdZl2tOAa0iiOUGo7DC8jIvSpN1JSv5GbuzaKfje/ma2len/2vibxaimlsXn4jLnQ+qps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616781; c=relaxed/simple;
	bh=dup7L8R7FxiZ74gmsejuHt12RirHhbJEC2J2UDvlofM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqsj3GSKGV8eiWy/vUiYKLZ+UAo7g5qiex5GDCJQV2LOnku4dVSIeCKCTsoeQbVZD4CnK9miKelvtGj6knJIFw7oRUww6qFRtVHonHBUOWOnAolqcng997P6lCLtsm+EXaIrz/5tmi1YvQ3oR5T3mSqd1RaDECcQrDZ/jcOKxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwjBxT+K; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwjBxT+K"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-988b3761477so201297241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616778; x=1791221578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mEffHrWrxnpzptqwCy+9/9nISlwvU3rsWNVbUFda6I0=;
        b=EwjBxT+KTP8BmJS+wlxkz5UdqLAF6hJSw+lnsmoGq6OVyq+sGbU0AN3Fnz2dItN6Np
         lMHMREPAqeI2aWJ9qHKnO07okYJ0XPc/wLlLVgoRjzlP3UDAXAOv1gi7n/jv2f22EATE
         hwenNYyQQUtZHqbxbXtGjA34oFK8qM0blqWqcZwMhnDDr1XeJgQeWV6Ooj7aEAAswu2D
         nUmropZLMnmGRLPvj32uFwDbQJ5xaecQ0UWOWAyGsRu8xebSXdWEqbbE8G9kD2zvb5c5
         dI2l0ceFgr9dPK7UvyPMIye4wN1okuAw02hyM6t0uhkExeExyZ5EqpZHKcUqKA8SFiyO
         gMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616778; x=1791221578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mEffHrWrxnpzptqwCy+9/9nISlwvU3rsWNVbUFda6I0=;
        b=AS1II2zazPpZssMq806ci7UghXAXRORhLYwwK5y9v2MlPS+IQF40/wEd4jMr78qjoK
         PhJGS/TaBNEg5gQCBtFqFK1fGzn51/AuA2FlruiMNTO1njG5cUKEkpIVPen4zMVgSXtx
         Pwe87kndgk92Hlb6D05aeL0ff7DtJ4CXHB4N4Vj/v+nRodfMoAvIY2ueE9A8bTAEr637
         O1wBhZD/0bxrrVg3ZwAt33hibO3JmdhPrNVT2MWObOTK86EiwTFoPGc8YzApL+9ljMJF
         +fxJzW/3zz4j1vILnAo4IVGoXD84pzOR//JtQVwsnQdCWpu7SUSWpzgXmhXzWPBfIa+A
         mBpQ==
X-Gm-Message-State: AFq9FYKMsuwgDgt3l6QYo7Im3OSDKTX7qxshijbkZuhX/Qt8aliFKGAF
	PkKOFwJK/DPAvIioP8SPttxXrQVs4We2njE4enmrqwQKTjWsexQmf4G1jES0elG0FhE=
X-Gm-Gg: AYBFou0Q012K8OsVT1e7h7ObyzpAdFkXNNn1iZ6nua/RrcAQC0uRRsOe2CGWT7I6Nrg
	ab/TlZgKPp0+t7HXee54CVeWwehnwhC8NWxrFoRRY2dsvdRFUCFe3KZPMGRSioTFhyvb4jLWnbz
	DnSWxx7WRerIj72GxcIPToUjn6NfHPGUDspqJZI33l9E6PpnvPlkGpI3qrjRuJFQ4lpHx0sF1Px
	nYrJ38T7yZAJzgI2gkdrOgezPY7GIpUrFI/Qaddokt1kRe7jgR4QrEK9r05flRw6oJ+8HIsWhVL
	uoIKnnV8TUwR72B+AbW4MIb9f7Lp/MWjNZ66rDqNjLurnLS1iV2ZM2+EkYoQCdJhpYrrnXE0Nbs
	gLnpIzcczknJdTAdNhkYsYE0BrS9j9ZiC0vpx3bRyZykpuqB22C/RBCUu46o+MJe/11rXLMBu8u
	sffPCAnqb4BUvWJJ7rJiEoNZgbUjvKRUJNKBfeCSEfxj1DkaowbBrDWMEItZU0zAsr5xePCByAD
	/K/7nP6AVCuuDVP4AsYUuwavjN8O0Xa8o/fdMcPHsBBOfHy2g9byXP6Q9jI9n7dYHAdxtDXz3CA
X-Received: by 2002:a05:6102:a1ce:20b0:7b5:1ca4:9df1 with SMTP id ada2fe7eead31-7b51ca4ab87mr731555137.5.1790616775201;
        Mon, 28 Sep 2026 10:32:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.32.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:32:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 02/21] client/gatt: Fix setting descriptor value from scripts
Date: Mon, 28 Sep 2026 13:32:21 -0400
Message-ID: <20260928173243.1073509-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
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

