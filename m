Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67C1C6BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943394; cv=none; b=DwJ+rvBzemDobSsqjDtxOEX0CX3uW3laz+ThLX66M/uIDUWzCNJV6ES5PkLqPy8FYgaZdEAiV+++4qzYwqlZ806UoRlIiFyF7EaYwrxivnrapAFbsUCw9msQyicqnS9dI0cbx2x/anDGZsQOT61u2odnJZlKxe1V8ENETz3BtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943394; c=relaxed/simple;
	bh=78DRbvvElNg50EZGo7EhjzmqreVGeOhp4E/+ZBX3Pag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITGCryq8U+MB3SJqX6hjH0afsmNJVC0p9oYELMdyfB6T2T6l+Fhiy3lg45/80hkpTHwws4b86lGGU+0IcsV/v4wrNWu1WrCGUz8hTuDgAbyv0BAoDa+GXpq4oGobNT3hdpETzYmccPaQWAOHGDVpcdIODWCP3zQzKsmZbACblh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGnon+f7; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGnon+f7"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-826fee202d3so8055241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721943391; x=1722548191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDy8S5K89VmDk2Pa45J8DVWlCCyH4oTbtgprjf3wtio=;
        b=kGnon+f7tEXBZ+NHpWkhLJhgEU7KyS04cHJubuheSv3b7AKrrxu2tbxOCrzxvvce8n
         VP7ob1d9I2XtHGnSfc1Qtq7PfMvEtI+jnBeBNLGrP/U/8zYoyN1RbYnJP5X7KfgziGSf
         zelAP0b9cTr+HSeqFNnnz8JmoPnW4alHF53vo/+pE5WryHsejWvdloMEpP6kOjbuOpBV
         L+Ck+5pF0r+ZWb0+vL0SUHv+k1WUHBmousJNvY4hrjMHcpfBVUX41DoE7+YSN/CteHsv
         kygUtPZNKy6bMrXDoBO/Zk0dppsfp0+knUdYbah0SMePuU+EjztC9BJR9FfBWhDwIdYk
         Zv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943391; x=1722548191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDy8S5K89VmDk2Pa45J8DVWlCCyH4oTbtgprjf3wtio=;
        b=DgHB/dBukEYeYIReYgPiGkju+4LYy9Y1Av5Q+MZG2xRMSQ55Gr/RaIaLm0uz+LcNyh
         JtTz0CwhaR4FwBrvkyoVJSVod2h1QLbNgn7o0mnk6CV+k+QvgNtsN/PPvgYuHRURD89w
         h4ve5RicIjyQwkMPZ6Jse91HtXd3ZPDgJyV3Qxbpnppl3X+OTHLbLWE/bWo4jv4D0BW7
         wOrStxYbD2ZWp1duzAwqufdCUyqEkkSwfxXvU/xJkdZG6DX4K/uqPIoLsbgrCT4Vpn+b
         BuHhUHV8nVejLfvtFMf+L9ATQg9bMI3pIW8nRUhKnugEFW0hmjTZjWuCGIiY2D98Zz19
         Gi6w==
X-Gm-Message-State: AOJu0YyGMeD/yKvmDPZB+Hb1MWT5RGPnkMWGr6lzKzCoFGzDfPtRVdIB
	2A7Xv0rNWYCsRO4ZNV8lhxFl76wtVW1G2IbFWFM6b19xTQ6rlXk9oNrU0w==
X-Google-Smtp-Source: AGHT+IGD5Bd/bJO09pJIm7FYf+zb6kcXBz9fMU4ITKpcKMFTUQCg9cePn+wyglDHIueiZZRxQsUx3A==
X-Received: by 2002:a05:6102:5111:b0:493:b1b2:4da9 with SMTP id ada2fe7eead31-493d9afad5amr3845125137.25.1721943390564;
        Thu, 25 Jul 2024 14:36:30 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-493d95f313csm377007137.7.2024.07.25.14.36.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:36:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/3] client/player: Add support to enter alternative preset
Date: Thu, 25 Jul 2024 17:36:25 -0400
Message-ID: <20240725213626.3183962-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725213626.3183962-1-luiz.dentz@gmail.com>
References: <20240725213626.3183962-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for alternative preset to be entered so when auto
accepting configuration a different preset can be selected following the
order given to endpoint.presets.
---
 client/player.c | 120 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 19 deletions(-)

diff --git a/client/player.c b/client/player.c
index 9334a053d34d..3c3587f2ca3a 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1230,7 +1230,10 @@ struct codec_preset {
 	const struct iovec data;
 	struct bt_bap_qos qos;
 	uint8_t target_latency;
+	uint32_t chan_alloc;
 	bool custom;
+	bool alt;
+	struct codec_preset *alt_preset;
 };
 
 #define SBC_PRESET(_name, _data) \
@@ -1969,12 +1972,31 @@ static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location,
 			if (*channels)
 				*channels = __builtin_popcount(*location);
 			return 0;
+		} else if (!strcasecmp(key, "Locations")) {
+			uint32_t tmp;
+
+			if (var != DBUS_TYPE_UINT32)
+				return -EINVAL;
+
+			dbus_message_iter_get_basic(&value, &tmp);
+			*location &= tmp;
+
+			if (*channels)
+				*channels = __builtin_popcount(*location);
 		}
 
 		dbus_message_iter_next(iter);
 	}
 
-	return -EINVAL;
+	return *location ? 0 : -EINVAL;
+}
+
+static void ltv_find(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	bool *found = user_data;
+
+	*found = true;
 }
 
 static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
@@ -1985,7 +2007,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	DBusMessageIter iter, props;
 	struct endpoint_config *cfg;
 	struct bt_bap_io_qos *qos;
-	uint32_t location = 0;
+	uint32_t location = ep->locations;
 	uint8_t channels = 1;
 
 	if (!preset)
@@ -2006,13 +2028,44 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	dbus_message_iter_recurse(&iter, &props);
 
 	if (!parse_chan_alloc(&props, &location, &channels)) {
-		uint8_t chan_alloc_ltv[] = {
-			0x05, LC3_CONFIG_CHAN_ALLOC, location & 0xff,
-			location >> 8, location >> 16, location >> 24
-		};
+		uint32_t chan_alloc = 0;
+		uint8_t type = LC3_CONFIG_CHAN_ALLOC;
+		bool found = false;
 
-		util_iov_append(cfg->caps, &chan_alloc_ltv,
+		if (preset->chan_alloc & location)
+			chan_alloc = preset->chan_alloc & location;
+		else if (preset->alt_preset &&
+					preset->alt_preset->chan_alloc &
+					location) {
+			chan_alloc = preset->alt_preset->chan_alloc & location;
+			preset = preset->alt_preset;
+
+			/* Copy alternate capabilities */
+			util_iov_free(cfg->caps, 1);
+			cfg->caps = util_iov_dup(&preset->data, 1);
+			cfg->target_latency = preset->target_latency;
+		} else
+			chan_alloc = location;
+
+		/* Check if Channel Allocation is present in caps */
+		util_ltv_foreach(cfg->caps->iov_base, cfg->caps->iov_len,
+					&type, ltv_find, &found);
+
+		/* If Channel Allocation has not been set directly via
+		 * preset->data then attempt to set it if chan_alloc has been
+		 * set.
+		 */
+		if (!found && chan_alloc) {
+			uint8_t chan_alloc_ltv[] = {
+				0x05, LC3_CONFIG_CHAN_ALLOC, chan_alloc & 0xff,
+				chan_alloc >> 8, chan_alloc >> 16,
+				chan_alloc >> 24
+			};
+
+			put_le32(chan_alloc, &chan_alloc_ltv[2]);
+			util_iov_append(cfg->caps, &chan_alloc_ltv,
 						sizeof(chan_alloc_ltv));
+		}
 	}
 
 	/* Copy metadata */
@@ -2035,6 +2088,8 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 
 	dbus_message_iter_init_append(reply, &iter);
 
+	bt_shell_printf("selecting %s...\n", preset->name);
+
 	append_properties(&iter, cfg);
 
 	free(cfg);
@@ -2098,8 +2153,6 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	bt_shell_printf("Auto Accepting using %s...\n", p->name);
-
 	return reply;
 }
 
@@ -3621,14 +3674,6 @@ add_meta:
 			endpoint_set_metadata_cfg, cfg);
 }
 
-static void ltv_find(size_t i, uint8_t l, uint8_t t, uint8_t *v,
-					void *user_data)
-{
-	bool *found = user_data;
-
-	*found = true;
-}
-
 static void config_endpoint_iso_group(const char *input, void *user_data)
 {
 	struct endpoint_config *cfg = user_data;
@@ -4106,13 +4151,38 @@ static void print_presets(struct preset *preset)
 
 	for (i = 0; i < preset->num_presets; i++) {
 		p = &preset->presets[i];
-		bt_shell_printf("%s%s\n", p == preset->default_preset ?
-						"*" : "", p->name);
+
+		if (p == preset->default_preset)
+			bt_shell_printf("*%s\n", p->name);
+		else if (preset->default_preset &&
+					p == preset->default_preset->alt_preset)
+			bt_shell_printf("**%s\n", p->name);
+		else
+			bt_shell_printf("%s\n", p->name);
 	}
 
 	queue_foreach(preset->custom, foreach_custom_preset_print, preset);
 }
 
+static void custom_chan_alloc(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	char *endptr = NULL;
+
+	p->chan_alloc = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (p->alt_preset)
+		bt_shell_prompt_input(p->alt_preset->name,
+					"Enter Channel Allocation: ",
+					custom_chan_alloc, p->alt_preset);
+	else
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_presets_endpoint(int argc, char *argv[])
 {
 	struct preset *preset;
@@ -4133,8 +4203,20 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 		preset->default_preset = default_preset;
 
 		if (argc > 4) {
+			struct codec_preset *alt_preset;
 			struct iovec *iov = (void *)&default_preset->data;
 
+			/* Check if and alternative preset was given */
+			alt_preset = preset_find_name(preset, argv[4]);
+			if (alt_preset) {
+				default_preset->alt_preset = alt_preset;
+				bt_shell_prompt_input(default_preset->name,
+						"Enter Channel Allocation: ",
+						custom_chan_alloc,
+						default_preset);
+				return;
+			}
+
 			iov->iov_base = str2bytearray(argv[4], &iov->iov_len);
 			if (!iov->iov_base) {
 				bt_shell_printf("Invalid configuration %s\n",
-- 
2.45.2

