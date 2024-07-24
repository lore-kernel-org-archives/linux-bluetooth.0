Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF115B0F9
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837175; cv=none; b=CW0g5KgxuQl4lWZqrdINx3JrD7zbqpTIUSOc5VyieSzEnYzaAz1SB4OfrVOEgRfkw+1kBeGS/LBi1jP4LSv1Pl8GUz2Oi0HrKTz9vjC9MhALk11djRJQ9cNOn2x76RqS3ZoaCb3xqNNozxGl48cDuTfUjxHnr+FaRa+g/iedYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837175; c=relaxed/simple;
	bh=v96mJj0ZaXkjngKwda1qWXSpgNHMnX5i4qplTEQQFfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORV2pjOvcqShGenXG89wCclW3wyGeQKeIeYvXWF3QzjT67SY/eLHjTeZneH1tlTDVRBQf5602ADcA+okkTZm/1eBF/kmGBEtF0LUT122yc9GU0kpWi55YXCslrjt2/KI7PtdAz3qjQk5Qk5B50KEXWoEO6XMfIeMHWlt/VAH3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLDx+7VF; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLDx+7VF"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9da46ca13so3792050b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721837172; x=1722441972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHIB6o9hz1FZQncnMgybUm0LYETx+cfTDdu9/UCopG4=;
        b=ZLDx+7VFFKgdgKQt1gpclAfpLoBXd8GA49iUFOBT3NoGJXxRLxROwEZ2qhBiONrKkz
         CuStCqPZuMLjzJF6ybCXdzVnS5HzP6VWIo4salTG5G/RceSlpES0UKB0NCPHoW++t1Nx
         5kQ6mEpKr/EiX28T3hNUGmQjX+Emect7qBnnmUi+g0cW5vjayEaFKeRFHu/caw+TQ6l1
         qXGYWHdWfdxkB0UcczbRO/iswgPiKQuzNGgQqo3pgtFsDrdqO8F5PVcaVRo0HXsPgzXe
         RtWUyH6g7c3SmzNF91s3STPkC8UmIzHS+BRe2G1Ngumw02cQNYEXagvx20o4bB8hL7sz
         H2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837172; x=1722441972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHIB6o9hz1FZQncnMgybUm0LYETx+cfTDdu9/UCopG4=;
        b=s73HkUcl2k8VE9z9KiamjryysYbW+p2CIPDEyxb3wLy5Ww90HSaysl/KO6XcNCEpku
         KQbFOdbpzFupi8G5ep4kyPmi+jzCxQCGfmROVYFQOCnCypQt8tRkKxVZ3bvKvVSGhUjZ
         vqTCBwitei7WdFiG1BE9a4dws2wckpc//yuqjKThkXwJM1t69iV9sdQeUbB/UkMhxgx9
         oR0R/PtBYPJi9FbLdaDUHE8wG25ACpmbZwWjNmUk+vmRBFG6OlgQorz0M5Y+gVCYlLNg
         NBUfqy5H31n82zNPT1YQV9lEoFjnve+dpRtjE+PuF7yV0H111C0gdTgyohS0UQVXRyty
         faZg==
X-Gm-Message-State: AOJu0Yyrnd1+DGFe//yzXrjsHL61KGDaXANxdnx+AlOSPaZYawAFXmKO
	R2hnTaOqDeJHcad9stL24hvGkSaLhWKQ6Ml8g9FpQ0cYH/GUjrHxK59Rvw==
X-Google-Smtp-Source: AGHT+IGUbEQkLw2fF5k87dCBO6gsLErbF6pVC3bhWxZ1EO7NjI/n4EKuB20IhYIbdJlJzv9dAIQyFA==
X-Received: by 2002:a05:6830:621b:b0:703:651b:382f with SMTP id 46e09a7af769-7092e695165mr270554a34.3.1721837172456;
        Wed, 24 Jul 2024 09:06:12 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-826dcefcc28sm2445485241.10.2024.07.24.09.06.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:06:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] client/player: Add support to enter alternative preset
Date: Wed, 24 Jul 2024 12:06:07 -0400
Message-ID: <20240724160608.2779282-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724160608.2779282-1-luiz.dentz@gmail.com>
References: <20240724160608.2779282-1-luiz.dentz@gmail.com>
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
 client/player.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++----
 src/shared/bap.c |  2 +-
 2 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 9334a053d34d..b9a4f1bf484d 100644
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
@@ -1969,12 +1972,23 @@ static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location,
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
 }
 
 static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
@@ -1985,7 +1999,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	DBusMessageIter iter, props;
 	struct endpoint_config *cfg;
 	struct bt_bap_io_qos *qos;
-	uint32_t location = 0;
+	uint32_t location = ep->locations;
 	uint8_t channels = 1;
 
 	if (!preset)
@@ -2010,6 +2024,24 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 			0x05, LC3_CONFIG_CHAN_ALLOC, location & 0xff,
 			location >> 8, location >> 16, location >> 24
 		};
+		uint32_t chan_alloc = 0;
+
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
+		}
+
+		if (chan_alloc)
+			put_le32(chan_alloc, &chan_alloc_ltv[2]);
 
 		util_iov_append(cfg->caps, &chan_alloc_ltv,
 						sizeof(chan_alloc_ltv));
@@ -2035,6 +2067,8 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 
 	dbus_message_iter_init_append(reply, &iter);
 
+	bt_shell_printf("selecting %s...\n", preset->name);
+
 	append_properties(&iter, cfg);
 
 	free(cfg);
@@ -2098,8 +2132,6 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	bt_shell_printf("Auto Accepting using %s...\n", p->name);
-
 	return reply;
 }
 
@@ -4106,13 +4138,38 @@ static void print_presets(struct preset *preset)
 
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
@@ -4133,8 +4190,20 @@ static void cmd_presets_endpoint(int argc, char *argv[])
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
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0aa89c2781ba..4bec51011469 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5420,7 +5420,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			selected++;
 
 			/* Check if there are any channels left to select */
-			map.count &= ~(map.count & rc->count);
+				map.count &= ~(map.count & rc->count);
 			/* Check if there are any locations left to select */
 			map.location &= ~(map.location & rc->location);
 
-- 
2.45.2

