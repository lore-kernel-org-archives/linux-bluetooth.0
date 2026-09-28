Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050474EE840
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625651; cv=none; b=bjXhO/cCP6XkbTcU/3zY1m66U3uuZ0PNIsMOEPl2ZJXGFFGewsheog2/0C6jJ84oR3r98Dan66ySlRpvrT9bGgeJbyPQrHm2RgVuGFKDU+L25GjzeJq6JAAXa/3mBm+SKOksyKyjZfRYNXzTI57qkLJBWzH4mj+fXHyZ/VyTM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625651; c=relaxed/simple;
	bh=dup7L8R7FxiZ74gmsejuHt12RirHhbJEC2J2UDvlofM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogkcBy2LpG02uywl/MPuBn7tEhlKMxbQ4AQICO+eBu6oGmK5bYCfA+jmMLUOQodMVZEwlZ3PhaUlnPNjFpfYtZhIeboNnUqEcf8voI/EIlYKICPtqYakW9iSJ3wHidhpJaaOgPTrj3x4fY6GBa1EHPoVfTPViMD/KpCsk9eFHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX2fmGJj; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX2fmGJj"
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5cfe8de4f54so1112311e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625649; x=1791230449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mEffHrWrxnpzptqwCy+9/9nISlwvU3rsWNVbUFda6I0=;
        b=BX2fmGJj+Hu2n/2TIKUnOhe4eFqhq/F23eWOTXBgQppJG+JrZ375HCkyek9ot5LpuQ
         MgTwDwwYU0Z6NOY3xB5/9Xlvc6hrn1LN2Rcl/UR1Vo8WLjP0Oj2vWR6/zLo3rlbmX5fa
         y/Qe+lTM1bLPAFVd/pz/6cF4K84/tMgaNu19K+nK/h+jq8N5KvhXZSll1zko0h2E1nYU
         4mBFCSWNl/Y5CwlAIxb0Wby+GZQvxjWxv84xCzTTRMeijsAVahvxwfGzODUFG/aDktsF
         V/6j+L3Aa0jm7RyyapaXdtcwfh9S/EXmsjp/O+5xDo+sD+2ip/R/fvrkMpeUsfcxtGLX
         s/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625649; x=1791230449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mEffHrWrxnpzptqwCy+9/9nISlwvU3rsWNVbUFda6I0=;
        b=aORhBc4NOVrlYCWJ+h0yf2CV88b+Ow722Zu/kY6J0rsqoXokVO7fCOoEEVR3r+b0S/
         YbSv4jd6wWbNLXyFe7qgZnHjKIW9bN93O00IxXCuV36EdC7nQ6oV8EmF6TWeLWhOZFIc
         kYYlTcP29UPfyN5w0ARQqUrvDc0Jxgrb/Oxqf3934tZhVFDQq7F62oPBF89pA50P7Bqh
         a6DJzW4SXspCT40cU2e0eYn6i1k1u8aksO0hRXBaef4IR/JRF/HpdU0s8ql2CvG4EQzb
         6BG0CN2EmVsLU2UqL71bcCIWfif2pRwvrLIULb2t2xc1l6wcV+gFiwS9AspypElJDnHt
         5opw==
X-Gm-Message-State: AFq9FYK+IFKdtvLieZucK0hmgYlxG1h/IC9AoQoSdIcu09pxjH7GOqmj
	Rdow7nHXHYzQja8fg8rC4T0bTHiZiimqz7LypeNpWkjI0o4mTNcop7OQZMj2zSnUo6k=
X-Gm-Gg: AYBFou1Dq/iJzXo4m1cBSPQmM6LbPLBuUQVBV7LhJs05JFl9TH0YmVis6R55+puLNXO
	NbvQ0V4EXUtuBf+xUJIHV3x43Akdyqln/fNJgO1Jt0YQzGHTrjcCCYrRNE+FTgEc5zqk8OBi20/
	V57DcwJ7UD0nPWlocvCUPp0iz2TqT78wXBh/iT745RMu0WsbglZLQ5m1cdpCyvsav652oZ1SJfh
	evUuglMfkyysEntSaKoSY1nhNR5uHCJezXcSEUfEXA8CZPdQeiGvUuNsiIsHJiS2A8utDHHjAZS
	qsYsZ2p4TyNRSB4nuoj5dfqbVmIerPOSzKnJhP5CdWL7ESSgYiGPVoNbPEkfguOShX6HxiP7sSa
	nH80LYunurNFVqbc64YuQKSeobPx6zenB6MKfVPaIq6uoW/paSIbJAOdCt5IqMwnSRyMh+g8+Ka
	EXX3g4Z0huRaHwrAD30Ea252hnSjZnyeVTWuvz8nZO6WMcNJrzMSNr1oPOHw3u9jKDFk1535qMe
	/imgV5NyX1X57qmPYwsWtjhSwv8F6SHIhFSUBjUt0zcq1v3N+gPJ685g0WIUR+1
X-Received: by 2002:a05:6123:420b:10b0:5ce:5895:c94e with SMTP id 71dfb90a1353d-5ce5895ce72mr1593193e0c.6.1790625648716;
        Mon, 28 Sep 2026 13:00:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 02/23] client/gatt: Fix setting descriptor value from scripts
Date: Mon, 28 Sep 2026 16:00:08 -0400
Message-ID: <20260928200031.1209311-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
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

