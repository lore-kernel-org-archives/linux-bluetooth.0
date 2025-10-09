Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098C282E1
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026885; cv=none; b=VFzHE1tLcHSkmVKN8CQhtB/CLR6LMDDwCD4Kl4d90TQMEgyd0S/DtPoHh+Eywwdo8m9SRdRkU9WJGQmMXi0NdieGTRYG1wyhvfUZZzgjaHROaTCrQCCfBIwEIpH6PAirPaSeJEOaol4Xkw9gcSIgSntYkiCUkreK5lccFR5YAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026885; c=relaxed/simple;
	bh=kpI4uePGGsRPPPlbC3Os7FArphawmojZZji5Y+lkhL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HExerMdFgp72feDyq0u2G0Hq3C9fQKP+pQsjvmsEyiIv27CUMsLxM8pL1bcDXLTJ+QOOcjw/VECMtgcz2Lfy2SxqzF4pJz2DUcJKSb6G5MdJ5PKOZ71rdsuzjzf6Y5+RXaLeHfaN4uXi7ec9W3TGnCCEhnmSjVmoofSWejol0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g31Veu7B; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g31Veu7B"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so1058810241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760026882; x=1760631682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaKgWuuQV2WsUI0GOo80qpF6lMNrr9hcUGhocPsgyj0=;
        b=g31Veu7BLCnbPrfwDYoAnBeStd3b5wqitASRSjrLQLwL8/Lo99PLgENe8PMzj6exSA
         yF/ZtWAJZMafc1zjCnq9jSjDXsx/cAN31GK8bBIsD31Tc7xmsUfNEwBKa+a8fkSCNl4e
         ZUWw4NneUX/rkvLfSXg+orRtX5Rtr6PhKHoDt84TzFZXb0O5YOhHiZPlXf9DZn55rrlE
         sTnc9/0BTRy1IsXpT+LLe9T4BdpV9bryOohgVWJNIetMc2pECH9d3PSP9rnaT2QRn0GB
         3bFoZsEqklPLiNV3jNwHrWb225MnwiKs6e5YGU2uGmsZhpXC+3QJ28PrV3nShnN1dWml
         RoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026882; x=1760631682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaKgWuuQV2WsUI0GOo80qpF6lMNrr9hcUGhocPsgyj0=;
        b=LyFHeXirmfTrFEDjqEfd/2f/CYW4AgnwULrqY7DjgTAa8lj6uG9RqbRCXtj4prdYBN
         wLWIsMXyvaBp8QwEY2LQcToqQULnHIQhor7xfohaxeVqm+hrUKHqiNkvx/U3tLqdp/VJ
         Syu/aOq6BQTOT3gs1vVGM3WYYH3/hgqxinzrSGRsZIWc1+zzzLQV5B3Qw54ByRLng3fM
         jOsCloXRALLQmwAG3NmjOyPqluNDlQc53oo0WNc/wCuB+Dse5DMg3hFkj36j7U4I2b4q
         4sqQ7cyiO1PC8Cdo8HHjKoxtP2IXb74FPhyoAO4VhEeJcXvluxkvLGrekavT/98VnS78
         +vIQ==
X-Gm-Message-State: AOJu0YxQ9i+brbQRbwk6ga7p9sHB6cBZAc/iCOpTEKRPWHCjGbLMie/a
	RhwuuIagilGpy0gK4NTw+ESUwsYWVVevW3eKpknMDmMO8Yo8sAQdX4Z+Tl4UWiSF
X-Gm-Gg: ASbGncti0LcyIKk27i6XacpFMDabGBvDk5C8Bp9f4YLDWgDiQMaELo3vP5NHFihG9rD
	5dVtUZVi+Os5jEu1ZU+KjHWg8GGlRgEpmRwxYk95xlWsAfBzcsaQEBdrpomzcFP43L/RER11U6V
	PQe4KxKykCqpiP6Njo/9hlR8XvzwcdmwPYuuoJPsvaSv7gjL1d45qM8oiPyDHeJeWf2+BvxEaWD
	6PluHpZN/5/uQdwjnzrSwuA5p1FWg8p2pQLbGiXtf/jNigcabq3BesDRQOKpWuqYhVH1WENVqc9
	hvTm/+e+e5VGpApiuB7uDeehWZ7a1E730B/wHVoZebsMrMYpAjNE0YMpnYHGwVWjwL3Qsm3SZf5
	fCg9bVxFmCsgrSk1ZKr9SqOiWHT6CVpw8TyAlzL5ydDYrtWrZLVnkTHyMEdtqYHo4wz6m+8aqf6
	Rb23KgGyHpXES/dA==
X-Google-Smtp-Source: AGHT+IHJYmDa4oXcnODYRWIwcV1KKhFD1ij7xopJYTsWEw1yJkeLiSrmigyDE1JH+6sjgOjlzCqh9w==
X-Received: by 2002:a67:f154:0:b0:5d5:f6ae:3901 with SMTP id ada2fe7eead31-5d5f6ae3d90mr804571137.18.1760026882140;
        Thu, 09 Oct 2025 09:21:22 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce69b52sm5454703e0c.12.2025.10.09.09.21.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:21:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] client/player: Fix prompting for bcode when one is already set
Date: Thu,  9 Oct 2025 12:21:10 -0400
Message-ID: <20251009162111.221677-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009162111.221677-1-luiz.dentz@gmail.com>
References: <20251009162111.221677-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bcode is non-zeroed it means it already has been set so there is no
reason to ask the user to overwrite it, also fixes the assumption that
only strings could be entered as bcode rather than a byte array.
---
 client/player.c | 67 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/client/player.c b/client/player.c
index bb193dafeba0..a8d05cf175c9 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5263,17 +5263,26 @@ static void set_bcode_cb(const DBusError *error, void *user_data)
 static void set_bcode(const char *input, void *user_data)
 {
 	struct transport_select_args *args = user_data;
-	char *bcode;
+	uint8_t *bcode = NULL;
+	size_t len = 0;
 
 	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
-		bcode = g_new0(char, 16);
-	else
-		bcode = g_strdup(input);
+		bcode = g_new0(uint8_t, 16);
+	else {
+		bcode = str2bytearray((char *) input, &len);
+		/* If the input is not 16 bytes, perhaps it was entered as
+		 * string so just use it instead.
+		 */
+		if (len != 16) {
+			bcode = (uint8_t *)strdup(input);
+			len = strlen(input);
+		}
+	}
 
 	if (g_dbus_proxy_set_property_dict(args->proxy, "QoS",
 				set_bcode_cb, user_data,
 				NULL, "BCode", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
-				strlen(bcode), bcode, NULL) == FALSE) {
+				len, bcode, NULL) == FALSE) {
 		bt_shell_printf("Setting broadcast code failed\n");
 		g_free(bcode);
 		free_transport_select_args(args);
@@ -5295,9 +5304,11 @@ static void transport_select(struct transport_select_args *args)
 
 static void transport_set_bcode(struct transport_select_args *args)
 {
-	DBusMessageIter iter, array, entry, value;
-	unsigned char encryption;
+	DBusMessageIter iter, array;
+	unsigned char encryption = 0;
 	const char *key;
+	uint8_t *bcode, zeroed_bcode[16] = {};
+	int bcode_len = 0;
 
 	if (g_dbus_proxy_get_property(args->proxy, "QoS", &iter) == FALSE) {
 		free_transport_select_args(args);
@@ -5308,24 +5319,48 @@ static void transport_set_bcode(struct transport_select_args *args)
 
 	while (dbus_message_iter_get_arg_type(&array) !=
 						DBUS_TYPE_INVALID) {
+		DBusMessageIter entry, value, array_value;
+		int var;
+
 		dbus_message_iter_recurse(&array, &entry);
 		dbus_message_iter_get_basic(&entry, &key);
 
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
 		if (!strcasecmp(key, "Encryption")) {
-			dbus_message_iter_next(&entry);
-			dbus_message_iter_recurse(&entry, &value);
+			if (var != DBUS_TYPE_BYTE)
+				break;
+
 			dbus_message_iter_get_basic(&value, &encryption);
-			if (encryption == 1) {
-				bt_shell_prompt_input("",
-					"Enter brocast code[value/no]:",
-					set_bcode, args);
-				return;
-			}
-			break;
+		} else if (!strcasecmp(key, "BCode")) {
+			if (var != DBUS_TYPE_ARRAY)
+				break;
+
+			dbus_message_iter_recurse(&value, &array_value);
+			dbus_message_iter_get_fixed_array(&array_value, &bcode,
+								&bcode_len);
+
+			if (bcode_len != 16 || !memcmp(bcode, zeroed_bcode, 16))
+				bcode_len = 0;
 		}
+
 		dbus_message_iter_next(&array);
 	}
 
+	/* Only attempt to set bcode if encryption is enabled and
+	 * bcode is not already set.
+	 */
+	if (encryption == 1 && !bcode_len) {
+		const char *path = g_dbus_proxy_get_path(args->proxy);
+
+		bt_shell_prompt_input(path, "Enter bcode[value/no]:",
+					set_bcode, args);
+		return;
+	}
+
 	/* Go straight to selecting transport, if Broadcast Code
 	 * is not required.
 	 */
-- 
2.51.0

