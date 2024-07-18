Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA878C8B
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325665; cv=none; b=FT4TyfMSTtLkaCDWQ4NgkUx/yxwXL8sfPxVX8S0iuTmJlnv4P/oMGf7qZNzyPPN589LEzCW9H300146y9dWzm9ke3LjYaAfsmVpPxPhkx+xRV9VGg0nS23JcxTB7Fc5nV7cSdBpL2ALdOcnwak+IyiS4i1hlwZi+QWtAimdfftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325665; c=relaxed/simple;
	bh=Xaj2h5vSsXAlckxr4tnORB6mRNoh7AGBmMfabIiy5Tc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ujnWy/u0HQZNHocFm7S1nXAiO0DJvqXkiZTsUppLQxS9kndu/TF0vPzxbkzPX3cjoeVbeMiBMCDRVN7h2RmE0O2sSxGvaPReAP8ORZsf6xRxMHDhuIQSBVTbEGrDdID0ot/dVgT1PS5vQLYzbAkHhz3tll/b+anAcz0JKqGKjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB5+vjqt; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB5+vjqt"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f2ee3be492so359513e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721325662; x=1721930462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=arSuS9vYUMxKaMrTPrWUI/3aZoAO0/8wj3G7eT+6IuM=;
        b=RB5+vjqtKscFv3ZhclEkdLveyf++IBgO2K+OsF2frCTEZyRSuSvLP5CYx9JWoORGF2
         TnD/YjpdxDdBhG0rkS92jM1n/ymMKF+RnUm4ccdv7FAFHbBcZoxZrn93SdGVOXgYIjrw
         q9/A0h2i81nCe30s9yiJqceSDlky9DSdqDNyL652WIuTyej1zWJZpDUJ70hsfUiSEs0e
         Zb2iimIHahcw0dGJf3EgzFOR3svbmwFCr0CsOfoC5O/KPhtv/d177nqHcWw0VxhqId9r
         WwGJZGfu9k7nPFD3R0FG7xu+D5LLcr3Ax9/JBuNr7miSp2GKVOf4CIiqFLgXjCTYCgUy
         Kfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721325662; x=1721930462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arSuS9vYUMxKaMrTPrWUI/3aZoAO0/8wj3G7eT+6IuM=;
        b=clj3YKir3HLHF6YsMPswKuZJ/86xlEjFSi/uCg5kTAHX7dOtmwYiJ99lCFrk0+yLD/
         dv4zPcjsz92NsIyUCx937uPMu/X6eB14IsAlSsjUIPAgCpuNUmeF5RFgvXjx3A5Ynib1
         eHG1Sa8IYNIxzCkX+H4t3PzI/dokG17HL+Ack/sh2M35I2OvF5Ye3bxheAB37piKlATZ
         Le1H/78w4trseKHWfA+VU3iOjBfgfy7rJ9pmA8y89g+GN/bYjibD3F+OhAbkhq9qFmPh
         tPyEaljYwjJhb7+pYwqff5XDPsfBnzi6XwQduvdZdNzkA6euU6o/BhidlnOCrN51gzwx
         5RpQ==
X-Gm-Message-State: AOJu0YxEIxIPHXh4UXuC/yHcz4HckWU6BKVS+10zEHHpI8QdDozYTiIM
	mONX7ZdtZw27xr38RUUwzwZqTzB9BRHkagIO7f/oJ5hETHnCjmx357Uwjw==
X-Google-Smtp-Source: AGHT+IEx/8egnT3+PKHDNiOz0TskGY4XHPh9+JWQ8O54oLEIzEo2xRm9/rYOIKSqnWUmoISYMWkYQw==
X-Received: by 2002:a05:6122:2a10:b0:4f2:ed80:2a3d with SMTP id 71dfb90a1353d-4f4df89fa6amr7355611e0c.10.1721325661690;
        Thu, 18 Jul 2024 11:01:01 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4eea4d406sm249230e0c.47.2024.07.18.11.01.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:01:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Add support for name custom presets
Date: Thu, 18 Jul 2024 14:00:58 -0400
Message-ID: <20240718180059.1159551-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for naming custom presets instead of always having
just one "custom" codec preset which needs to be overwriten everytime
a new set of settings needs to be entered.
---
 client/player.c | 130 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 43 deletions(-)

diff --git a/client/player.c b/client/player.c
index 2480ed64b8e5..26190fef7bc1 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1232,6 +1232,7 @@ struct codec_preset {
 	const struct iovec data;
 	struct bt_bap_qos qos;
 	uint8_t target_latency;
+	bool custom;
 };
 
 #define SBC_PRESET(_name, _data) \
@@ -1448,7 +1449,6 @@ static void print_lc3_meta(void *data, int len)
 	{ \
 		.uuid = _uuid, \
 		.codec = _codec, \
-		.custom = { .name = "custom" }, \
 		.default_preset = &_presets[_default_index], \
 		.presets = _presets, \
 		.num_presets = ARRAY_SIZE(_presets), \
@@ -1459,7 +1459,7 @@ static struct preset {
 	uint8_t codec;
 	uint16_t cid;
 	uint16_t vid;
-	struct codec_preset custom;
+	struct queue *custom;
 	struct codec_preset *default_preset;
 	struct codec_preset *presets;
 	size_t num_presets;
@@ -1557,6 +1557,14 @@ static struct preset *find_presets_name(const char *uuid, const char *codec)
 	return find_presets(uuid, id, 0x0000, 0x0000);
 }
 
+static bool match_custom_name(const void *data, const void *match_data)
+{
+	const struct codec_preset *preset = data;
+	const char *name = match_data;
+
+	return !strcmp(preset->name, name);
+}
+
 static struct codec_preset *preset_find_name(struct preset *preset,
 						const char *name)
 {
@@ -1567,8 +1575,6 @@ static struct codec_preset *preset_find_name(struct preset *preset,
 
 	if (!name)
 		return preset->default_preset;
-	else if (!strcmp(name, "custom"))
-		return &preset->custom;
 
 	for (i = 0; i < preset->num_presets; i++) {
 		struct codec_preset *p;
@@ -1579,19 +1585,7 @@ static struct codec_preset *preset_find_name(struct preset *preset,
 			return p;
 	}
 
-	return NULL;
-}
-
-static struct codec_preset *find_preset(const char *uuid, const char *codec,
-					const char *name)
-{
-	struct preset *preset;
-
-	preset = find_presets_name(uuid, codec);
-	if (!preset)
-		return NULL;
-
-	return preset_find_name(preset, name);
+	return queue_find(preset->custom, match_custom_name, name);
 }
 
 static DBusMessage *endpoint_select_config_reply(DBusMessage *msg,
@@ -2816,10 +2810,11 @@ static void endpoint_free(void *data)
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
 
-	if (ep->codec == 0xff) {
-		free(ep->preset->custom.name);
+	queue_destroy(ep->preset->custom, free);
+	ep->preset->custom = NULL;
+
+	if (ep->codec == 0xff)
 		free(ep->preset);
-	}
 
 	queue_destroy(ep->acquiring, NULL);
 	queue_destroy(ep->transports, free);
@@ -3365,6 +3360,36 @@ static const struct capabilities *find_capabilities(const char *uuid,
 	return NULL;
 }
 
+static struct codec_preset *codec_preset_new(const char *name)
+{
+	struct codec_preset *codec;
+
+	codec = new0(struct codec_preset, 1);
+	codec->name = strdup(name);
+	codec->custom = true;
+
+	return codec;
+}
+
+static struct codec_preset *codec_preset_add(struct preset *preset,
+						const char *name)
+{
+	struct codec_preset *codec;
+
+	codec = preset_find_name(preset, name);
+	if (codec)
+		return codec;
+
+	codec = codec_preset_new(name);
+
+	if (!preset->custom)
+		preset->custom = queue_new();
+
+	queue_push_tail(preset->custom, codec);
+
+	return codec;
+}
+
 static void cmd_register_endpoint(int argc, char *argv[])
 {
 	struct endpoint *ep;
@@ -3390,8 +3415,8 @@ static void cmd_register_endpoint(int argc, char *argv[])
 		ep->codec = 0xff;
 		parse_vendor_codec(argv[2], &ep->vid, &ep->cid);
 		ep->preset = new0(struct preset, 1);
-		ep->preset->custom.name = strdup("custom");
-		ep->preset->default_preset = &ep->preset->custom;
+		ep->preset->default_preset = codec_preset_add(ep->preset,
+								"custom");
 	} else {
 		ep->preset = find_presets_name(ep->uuid, argv[2]);
 	}
@@ -4060,21 +4085,27 @@ static void custom_frequency(const char *input, void *user_data)
 				custom_duration, user_data);
 }
 
+static void foreach_custom_preset_print(void *data, void *user_data)
+{
+	struct codec_preset *p = data;
+	struct preset *preset = user_data;
+
+	bt_shell_printf("%s%s\n", p == preset->default_preset ? "*" : "",
+				p->name);
+}
+
 static void print_presets(struct preset *preset)
 {
 	size_t i;
 	struct codec_preset *p;
 
-	p = &preset->custom;
-
-	bt_shell_printf("%s%s\n", p == preset->default_preset ? "*" : "",
-								p->name);
-
 	for (i = 0; i < preset->num_presets; i++) {
 		p = &preset->presets[i];
 		bt_shell_printf("%s%s\n", p == preset->default_preset ?
 						"*" : "", p->name);
 	}
+
+	queue_foreach(preset->custom, foreach_custom_preset_print, preset);
 }
 
 static void cmd_presets_endpoint(int argc, char *argv[])
@@ -4082,29 +4113,42 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 	struct preset *preset;
 	struct codec_preset *default_preset = NULL;
 
-	if (argc > 3) {
-		default_preset = find_preset(argv[1], argv[2], argv[3]);
-		if (!default_preset) {
-			bt_shell_printf("Preset %s not found\n", argv[3]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
-	}
-
 	preset = find_presets_name(argv[1], argv[2]);
 	if (!preset) {
 		bt_shell_printf("No preset found\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (default_preset) {
+	if (argc > 3) {
+		default_preset = codec_preset_add(preset, argv[3]);
+		if (!default_preset) {
+			bt_shell_printf("Preset %s not found\n", argv[3]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 		preset->default_preset = default_preset;
-		goto done;
-	}
 
-	print_presets(preset);
+		if (argc > 4) {
+			struct iovec *iov = (void *)&default_preset->data;
 
-done:
-	if (default_preset && !strcmp(default_preset->name, "custom")) {
+			iov->iov_base = str2bytearray(argv[4], &iov->iov_len);
+			if (!iov->iov_base) {
+				bt_shell_printf("Invalid configuration %s\n",
+							argv[4]);
+				return bt_shell_noninteractive_quit(
+								EXIT_FAILURE);
+			}
+
+			bt_shell_prompt_input("QoS", "Enter Target Latency "
+						"(Low, Balance, High):",
+						custom_target_latency,
+						default_preset);
+
+			return;
+		}
+	} else
+		print_presets(preset);
+
+	if (default_preset && default_preset->custom) {
 		bt_shell_prompt_input("Codec", "Enter frequency (Khz):",
 					custom_frequency, default_preset);
 		return;
@@ -4133,9 +4177,9 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-	{ "presets",      "<UUID> <codec[:company]> [default]",
+	{ "presets",      "<UUID> <codec[:company]> [preset] [config]",
 						cmd_presets_endpoint,
-						"List available presets",
+						"List or add presets",
 						uuid_generator },
 	{} },
 };
-- 
2.45.2

