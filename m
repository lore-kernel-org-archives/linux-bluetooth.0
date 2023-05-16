Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03728C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEPU74 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjEPU7z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA8283F5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8629223b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270783; x=1686862783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SYUSjBeIm8ljNch+xLUXm/BkCypHZhQ+iPy+Cp1zz0=;
        b=n08lN/uPNpfYjO8bPeMEWqry6ktEspGS+SI0vdc9XsVXvWAQqe6vW5owhJVkrBhpf2
         hW3B6apFHZM3F4eD6R3y/GV8iKIS6DHeguozlKeDcrvZlLMj44WxMe2Dp7FApwiotDxr
         al5+7B3BiG/O3vCgiACWgtfzO8i08yD3AXwHVFXujcHjIk6Jvfsj8NIz1FrGpowPh5iW
         SqMmCcJqd3KJx7YYn1InR6zrjPJel1vTYwZokjrXtc9nH4/1O88wgw919qF8guvNU+l2
         8EQk7hdCF96aDKCjgJ2ZUoEPxB/qZGIhRyhJen/RieGfStL3JlW8KdP6OEDbcIerQJgA
         BSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270783; x=1686862783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SYUSjBeIm8ljNch+xLUXm/BkCypHZhQ+iPy+Cp1zz0=;
        b=T6PyDjbkLvbCBX27RVSQPSPiwoQJWegUurOnZiVluoIGeP0XttHKO8KUG4iq0N02Id
         nvelsnf4b3dKJ6quWEKww/oDIL+psfx1BfcvNdesTSvFaezhHKspbLjXdjT4xsj8eIth
         bfme2vy4pG4nAHmwpGkxv8OdWm5Cof7ecCouLWLGrst38Dn7cpkguFNoptOeehAo3hji
         RSQGsyU4RyQ2WY8ya7rFxmwBWVAu9tQNsIpvzGASVafNf1IGaO18vJKgMVqAaogiLmoa
         f8eWH2F0oIwtLbui4ZhazLnRkudSR3LH0yIsBoDvwzJL01oNRIP4+4TTg2Np0SwNtv9+
         FOpw==
X-Gm-Message-State: AC+VfDyUHg0izZPn6W5JGKbwDVuM4o5wtxXu6wol84gy/BXAcmMY4THD
        7bUtRxReqcb3pQ9DwjPWOZUdCTWnNds=
X-Google-Smtp-Source: ACHHUZ5+ShPNbdLJHnACg3RhDoUIKIonPS36cZ8tsy+D6p7uSW59OFn1E+HU3kY36baukuUzflbOwA==
X-Received: by 2002:a17:903:110e:b0:1ac:7245:ba55 with SMTP id n14-20020a170903110e00b001ac7245ba55mr89264plh.6.1684270782721;
        Tue, 16 May 2023 13:59:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] main: Rework config option parsing
Date:   Tue, 16 May 2023 13:59:24 -0700
Message-Id: <20230516205924.1040506-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework config option parsing adding helper function to make it
simpler to parse new options.
---
 src/btd.h  |  14 +-
 src/main.c | 848 +++++++++++++++++++++++++++--------------------------
 2 files changed, 442 insertions(+), 420 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index 70051c71c7c1..b7e7ebd618cf 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -111,7 +111,7 @@ struct btd_advmon_opts {
 struct btd_opts {
 	char		*name;
 	uint32_t	class;
-	gboolean	pairable;
+	bool		pairable;
 	uint32_t	pairto;
 	uint32_t	discovto;
 	uint32_t	tmpto;
@@ -122,12 +122,12 @@ struct btd_opts {
 
 	struct btd_defaults defaults;
 
-	gboolean	reverse_discovery;
-	gboolean	name_resolv;
-	gboolean	debug_keys;
-	gboolean	fast_conn;
-	gboolean	refresh_discovery;
-	gboolean	experimental;
+	bool		reverse_discovery;
+	bool		name_resolv;
+	bool		debug_keys;
+	bool		fast_conn;
+	bool		refresh_discovery;
+	bool		experimental;
 	struct queue	*kernel;
 
 	uint16_t	did_source;
diff --git a/src/main.c b/src/main.c
index a64b833b58c1..8dfd2543ba1c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -313,7 +313,7 @@ done:
 	btd_opts.did_version = version;
 }
 
-static bt_gatt_cache_t parse_gatt_cache(const char *cache)
+static bt_gatt_cache_t parse_gatt_cache_str(const char *cache)
 {
 	if (!strcmp(cache, "always")) {
 		return BT_GATT_CACHE_ALWAYS;
@@ -415,6 +415,63 @@ static int get_mode(const char *str)
 	return BT_MODE_DUAL;
 }
 
+static bool parse_config_string(GKeyFile *config, const char *group,
+					const char *key, char **val)
+{
+	GError *err = NULL;
+	char *tmp;
+
+	tmp = g_key_file_get_string(config, group, key, &err);
+	if (err) {
+		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
+			DBG("%s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	DBG("%s.%s = %s", group, key, tmp);
+
+	if (val) {
+		g_free(*val);
+		*val = tmp;
+	}
+
+	return true;
+}
+
+static bool parse_config_int(GKeyFile *config, const char *group,
+					const char *key, int *val,
+					int min, int max)
+{
+	int tmp;
+	char *str = NULL;
+	char *endptr = NULL;
+
+	if (!parse_config_string(config, group, key, &str))
+		return false;
+
+	tmp = strtol(str, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		error("%s.%s = %s is not integer", group, key, str);
+		return false;
+	}
+
+	if (tmp < min) {
+		warn("%s.%s = %d is out of range (< %d)", group, key, tmp, min);
+		return false;
+	}
+
+	if (tmp < max) {
+		warn("%s.%s = %d is out of range (> %d)", group, key, tmp, max);
+		return false;
+	}
+
+	if (val)
+		*val = tmp;
+
+	return true;
+}
+
 struct config_param {
 	const char * const val_name;
 	void * const val;
@@ -433,31 +490,15 @@ static void parse_mode_config(GKeyFile *config, const char *group,
 		return;
 
 	for (i = 0; i < params_len; ++i) {
-		GError *err = NULL;
-		char *str;
-
-		str = g_key_file_get_string(config, group, params[i].val_name,
-									&err);
-		if (err) {
-			DBG("%s", err->message);
-			g_clear_error(&err);
-		} else {
-			char *endptr = NULL;
-			int val;
-
-			val = strtol(str, &endptr, 0);
-			if (!endptr || *endptr != '\0')
-				continue;
-
-			info("%s=%s(%d)", params[i].val_name, str, val);
-
-			val = MAX(val, params[i].min);
-			val = MIN(val, params[i].max);
+		int val;
 
+		if (parse_config_int(config, group, params[i].val_name,
+					&val, params[i].min, params[i].max)) {
 			val = htobl(val);
 			memcpy(params[i].val, &val, params[i].size);
-			++btd_opts.defaults.num_entries;
 		}
+
+		++btd_opts.defaults.num_entries;
 	}
 }
 
@@ -728,13 +769,375 @@ static bool gen_sirk(const char *str)
 	return ret;
 }
 
-static void parse_config(GKeyFile *config)
+static bool parse_config_u32(GKeyFile *config, const char *group,
+					const char *key, uint32_t *val,
+					uint32_t min, uint32_t max)
+{
+	int tmp;
+
+	if (!parse_config_int(config, group, key, &tmp, 0, UINT32_MAX))
+		return false;
+
+	if (val)
+		*val = tmp;
+
+	return true;
+}
+
+static bool parse_config_u16(GKeyFile *config, const char *group,
+					const char *key, uint16_t *val,
+					uint16_t min, uint16_t max)
+{
+	int tmp;
+
+	if (!parse_config_int(config, group, key, &tmp, min, max))
+		return false;
+
+	if (val)
+		*val = tmp;
+
+	return true;
+}
+
+static bool parse_config_u8(GKeyFile *config, const char *group,
+					const char *key, uint8_t *val,
+					uint8_t min, uint8_t max)
+{
+	int tmp;
+
+	if (!parse_config_int(config, group, key, &tmp, min, max))
+		return false;
+
+	if (val)
+		*val = tmp;
+
+	return true;
+}
+
+static bool parse_config_bool(GKeyFile *config, const char *group,
+					const char *key, bool *val)
 {
 	GError *err = NULL;
-	char *str, **strlist;
-	int val;
-	gboolean boolean;
+	gboolean tmp;
 
+	tmp = g_key_file_get_boolean(config, group, key, &err);
+	if (err) {
+		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
+			DBG("%s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	DBG("%s.%s = %s", group, key, tmp ? "true" : "false");
+
+	if (val)
+		*val = tmp;
+
+	return true;
+}
+
+static void parse_privacy(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "General", "Privacy", &str)) {
+		btd_opts.privacy = 0x00;
+		btd_opts.device_privacy = true;
+		return;
+	}
+
+	if (!strcmp(str, "network") || !strcmp(str, "on")) {
+		btd_opts.privacy = 0x01;
+	} else if (!strcmp(str, "device")) {
+		btd_opts.privacy = 0x01;
+		btd_opts.device_privacy = true;
+	} else if (!strcmp(str, "limited-network")) {
+		if (btd_opts.mode != BT_MODE_DUAL) {
+			DBG("Invalid privacy option: %s", str);
+			btd_opts.privacy = 0x00;
+		}
+		btd_opts.privacy = 0x01;
+	} else if (!strcmp(str, "limited-device")) {
+		if (btd_opts.mode != BT_MODE_DUAL) {
+			DBG("Invalid privacy option: %s", str);
+			btd_opts.privacy = 0x00;
+		}
+		btd_opts.privacy = 0x02;
+		btd_opts.device_privacy = true;
+	} else if (!strcmp(str, "off")) {
+		btd_opts.privacy = 0x00;
+		btd_opts.device_privacy = true;
+	} else {
+		DBG("Invalid privacy option: %s", str);
+		btd_opts.privacy = 0x00;
+	}
+
+	g_free(str);
+}
+
+static void parse_repairing(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "General", "JustWorksRepairing",
+						&str)) {
+		btd_opts.jw_repairing = JW_REPAIRING_NEVER;
+		return;
+	}
+
+	btd_opts.jw_repairing = parse_jw_repairing(str);
+	g_free(str);
+}
+
+static bool parse_config_hex(GKeyFile *config, char *group,
+					const char *key, uint32_t *val)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, group, key, &str))
+		return false;
+
+	if (val)
+		*val = strtol(str, NULL, 16);
+
+	g_free(str);
+	return true;
+}
+
+static void parse_device_id(GKeyFile *config)
+{
+	char *str = NULL;
+
+	parse_config_string(config, "General", "DeviceID", &str);
+	if (!str)
+		return;
+
+	parse_did(str);
+	g_free(str);
+}
+
+static void parse_ctrl_mode(GKeyFile *config)
+{
+	char *str = NULL;
+
+	parse_config_string(config, "General", "ControllerMode", &str);
+	if (!str)
+		return;
+
+	btd_opts.mode = get_mode(str);
+	g_free(str);
+}
+
+static void parse_multi_profile(GKeyFile *config)
+{
+	char *str = NULL;
+
+	parse_config_string(config, "General", "MultiProfile", &str);
+	if (!str)
+		return;
+
+	if (!strcmp(str, "single"))
+		btd_opts.mps = MPS_SINGLE;
+	else if (!strcmp(str, "multiple"))
+		btd_opts.mps = MPS_MULTIPLE;
+	else
+		btd_opts.mps = MPS_OFF;
+
+	g_free(str);
+}
+
+static gboolean parse_kernel_experimental(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	char **strlist;
+
+	if (value && value[0] != '*') {
+		strlist = g_strsplit(value, ",", -1);
+		btd_parse_kernel_experimental(strlist);
+		g_strfreev(strlist);
+	} else {
+		if (!btd_opts.kernel)
+			btd_opts.kernel = queue_new();
+		queue_push_head(btd_opts.kernel, strdup("*"));
+	}
+
+	return TRUE;
+}
+
+static void parse_kernel_exp(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "General", "KernelExperimental",
+						&str))
+		return;
+
+	parse_kernel_experimental(NULL, str, NULL, NULL);
+
+	g_free(str);
+}
+
+static void parse_secure_conns(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "General", "SecureConnections",
+								&str))
+		return;
+
+	if (!strcmp(str, "off"))
+		btd_opts.secure_conn = SC_OFF;
+	else if (!strcmp(str, "on"))
+		btd_opts.secure_conn = SC_ON;
+	else if (!strcmp(str, "only"))
+		btd_opts.secure_conn = SC_ONLY;
+
+	g_free(str);
+}
+
+static void parse_general(GKeyFile *config)
+{
+	parse_config_string(config, "General", "Name", &btd_opts.name);
+	parse_config_hex(config, "General", "Class", &btd_opts.class);
+	parse_config_u32(config, "General", "DiscoverableTimeout",
+						&btd_opts.discovto,
+						0, UINT32_MAX);
+	parse_config_bool(config, "General", "AlwaysPairable",
+						&btd_opts.pairable);
+	parse_config_u32(config, "General", "PairableTimeout",
+						&btd_opts.pairto,
+						0, UINT32_MAX);
+	parse_device_id(config);
+	parse_config_bool(config, "General", "ReverseServiceDiscovery",
+						&btd_opts.reverse_discovery);
+	parse_config_bool(config, "General", "NameResolving",
+						&btd_opts.name_resolv);
+	parse_config_bool(config, "General", "DebugKeys",
+						&btd_opts.debug_keys);
+	parse_ctrl_mode(config);
+	parse_config_u16(config, "General", "MaxControllers",
+						&btd_opts.max_adapters,
+						0, UINT16_MAX);
+	parse_multi_profile(config);
+	parse_config_bool(config, "General", "FastConnectable",
+						&btd_opts.fast_conn);
+	parse_privacy(config);
+	parse_repairing(config);
+	parse_config_u32(config, "General", "TemporaryTimeout",
+						&btd_opts.tmpto,
+						0, UINT32_MAX);
+	parse_config_bool(config, "General", "RefreshDiscovery",
+						&btd_opts.refresh_discovery);
+	parse_secure_conns(config);
+	parse_config_bool(config, "General", "Experimental",
+						&btd_opts.experimental);
+	parse_kernel_exp(config);
+	parse_config_u32(config, "General", "RemoteNameRequestRetryDelay",
+					&btd_opts.name_request_retry_delay,
+					0, UINT32_MAX);
+}
+
+static void parse_gatt_cache(GKeyFile *config)
+{
+	char *str = NULL;
+
+	parse_config_string(config, "GATT", "Cache", &str);
+	if (!str)
+		return;
+
+	btd_opts.gatt_cache = parse_gatt_cache_str(str);
+	g_free(str);
+}
+
+static void parse_gatt(GKeyFile *config)
+{
+	parse_gatt_cache(config);
+	parse_config_u8(config, "GATT", "KeySize", &btd_opts.key_size, 7, 16);
+	parse_config_u16(config, "GATT", "ExchangeMTU", &btd_opts.gatt_mtu,
+				BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU);
+	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
+				1, 5);
+}
+
+static void parse_csis_sirk(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "CSIS", "SIRK", &str))
+		return;
+
+	if (strlen(str) == 32 && check_sirk_alpha_numeric(str))
+		hex2bin(str, btd_opts.csis.sirk, sizeof(btd_opts.csis.sirk));
+	else if (!gen_sirk(str))
+		DBG("Unable to generate SIRK from string");
+
+	g_free(str);
+}
+
+static void parse_csis(GKeyFile *config)
+{
+	parse_csis_sirk(config);
+	parse_config_bool(config, "CSIS", "Encryption",
+					&btd_opts.csis.encrypt);
+	parse_config_u8(config, "CSIS", "Size", &btd_opts.csis.size,
+					0, UINT8_MAX);
+	parse_config_u8(config, "CSIS", "Rank", &btd_opts.csis.size,
+					0, UINT8_MAX);
+}
+
+static void parse_avdtp_session_mode(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "AVDTP", "SessionMode", &str))
+		return;
+
+	if (!strcmp(str, "basic"))
+		btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
+	else if (!strcmp(str, "ertm"))
+		btd_opts.avdtp.session_mode = BT_IO_MODE_ERTM;
+	else {
+		DBG("Invalid mode option: %s", str);
+		btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
+	}
+
+	g_free(str);
+}
+
+static void parse_avdtp_stream_mode(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!parse_config_string(config, "AVDTP", "StreamMode", &str))
+		return;
+
+	if (!strcmp(str, "basic"))
+		btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
+	else if (!strcmp(str, "streaming"))
+		btd_opts.avdtp.stream_mode = BT_IO_MODE_STREAMING;
+	else {
+		DBG("Invalid mode option: %s", str);
+		btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
+	}
+
+	g_free(str);
+}
+
+static void parse_avdtp(GKeyFile *config)
+{
+	parse_avdtp_session_mode(config);
+	parse_avdtp_stream_mode(config);
+}
+
+static void parse_advmon(GKeyFile *config)
+{
+	parse_config_u8(config, "AdvMon", "RSSISamplingPeriod",
+				&btd_opts.advmon.rssi_sampling_period,
+				0, UINT8_MAX);
+}
+
+static void parse_config(GKeyFile *config)
+{
 	if (!config)
 		return;
 
@@ -742,377 +1145,14 @@ static void parse_config(GKeyFile *config)
 
 	DBG("parsing %s", main_conf_file_path);
 
-	val = g_key_file_get_integer(config, "General",
-						"DiscoverableTimeout", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("discovto=%d", val);
-		btd_opts.discovto = val;
-	}
-
-	boolean = g_key_file_get_boolean(config, "General",
-						"AlwaysPairable", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("pairable=%s", boolean ? "true" : "false");
-		btd_opts.pairable = boolean;
-	}
-
-	val = g_key_file_get_integer(config, "General",
-						"PairableTimeout", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("pairto=%d", val);
-		btd_opts.pairto = val;
-	}
-
-	str = g_key_file_get_string(config, "General", "Privacy", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-		btd_opts.privacy = 0x00;
-		btd_opts.device_privacy = true;
-	} else {
-		DBG("privacy=%s", str);
-
-		if (!strcmp(str, "network") || !strcmp(str, "on")) {
-			btd_opts.privacy = 0x01;
-		} else if (!strcmp(str, "device")) {
-			btd_opts.privacy = 0x01;
-			btd_opts.device_privacy = true;
-		} else if (!strcmp(str, "limited-network")) {
-			if (btd_opts.mode != BT_MODE_DUAL) {
-				DBG("Invalid privacy option: %s", str);
-				btd_opts.privacy = 0x00;
-			}
-			btd_opts.privacy = 0x01;
-		} else if (!strcmp(str, "limited-device")) {
-			if (btd_opts.mode != BT_MODE_DUAL) {
-				DBG("Invalid privacy option: %s", str);
-				btd_opts.privacy = 0x00;
-			}
-			btd_opts.privacy = 0x02;
-			btd_opts.device_privacy = true;
-		} else if (!strcmp(str, "off")) {
-			btd_opts.privacy = 0x00;
-			btd_opts.device_privacy = true;
-		} else {
-			DBG("Invalid privacy option: %s", str);
-			btd_opts.privacy = 0x00;
-		}
-
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(config, "General",
-						"JustWorksRepairing", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-		btd_opts.jw_repairing = JW_REPAIRING_NEVER;
-	} else {
-		DBG("just_works_repairing=%s", str);
-		btd_opts.jw_repairing = parse_jw_repairing(str);
-		g_free(str);
-	}
-
-	val = g_key_file_get_integer(config, "General",
-						"TemporaryTimeout", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("tmpto=%d", val);
-		btd_opts.tmpto = val;
-	}
-
-	str = g_key_file_get_string(config, "General", "Name", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("name=%s", str);
-		g_free(btd_opts.name);
-		btd_opts.name = str;
-	}
-
-	str = g_key_file_get_string(config, "General", "Class", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("class=%s", str);
-		btd_opts.class = strtol(str, NULL, 16);
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(config, "General", "DeviceID", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("deviceid=%s", str);
-		parse_did(str);
-		g_free(str);
-	}
-
-	boolean = g_key_file_get_boolean(config, "General",
-						"ReverseServiceDiscovery", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else
-		btd_opts.reverse_discovery = boolean;
-
-	boolean = g_key_file_get_boolean(config, "General",
-						"NameResolving", &err);
-	if (err)
-		g_clear_error(&err);
-	else
-		btd_opts.name_resolv = boolean;
-
-	boolean = g_key_file_get_boolean(config, "General",
-						"DebugKeys", &err);
-	if (err)
-		g_clear_error(&err);
-	else
-		btd_opts.debug_keys = boolean;
-
-	str = g_key_file_get_string(config, "General", "ControllerMode", &err);
-	if (err) {
-		g_clear_error(&err);
-	} else {
-		DBG("ControllerMode=%s", str);
-		btd_opts.mode = get_mode(str);
-		g_free(str);
-	}
-
-	val = g_key_file_get_integer(config, "General", "MaxControllers", &err);
-	if (err) {
-		g_clear_error(&err);
-	} else {
-		DBG("MaxControllers=%d", val);
-		btd_opts.max_adapters = val;
-	}
-
-	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
-	if (err) {
-		g_clear_error(&err);
-	} else {
-		DBG("MultiProfile=%s", str);
-
-		if (!strcmp(str, "single"))
-			btd_opts.mps = MPS_SINGLE;
-		else if (!strcmp(str, "multiple"))
-			btd_opts.mps = MPS_MULTIPLE;
-		else
-			btd_opts.mps = MPS_OFF;
-
-		g_free(str);
-	}
-
-	boolean = g_key_file_get_boolean(config, "General",
-						"FastConnectable", &err);
-	if (err)
-		g_clear_error(&err);
-	else
-		btd_opts.fast_conn = boolean;
-
-	boolean = g_key_file_get_boolean(config, "General",
-						"RefreshDiscovery", &err);
-	if (err)
-		g_clear_error(&err);
-	else
-		btd_opts.refresh_discovery = boolean;
-
-	boolean = g_key_file_get_boolean(config, "General", "Experimental",
-						&err);
-	if (err)
-		g_clear_error(&err);
-	else
-		btd_opts.experimental = boolean;
-
-	strlist = g_key_file_get_string_list(config, "General",
-						"KernelExperimental",
-						NULL, &err);
-	if (err)
-		g_clear_error(&err);
-	else {
-		btd_parse_kernel_experimental(strlist);
-		g_strfreev(strlist);
-	}
-
-	val = g_key_file_get_integer(config, "General",
-					"RemoteNameRequestRetryDelay", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("RemoteNameRequestRetryDelay=%d", val);
-		btd_opts.name_request_retry_delay = val;
-	}
-
-	str = g_key_file_get_string(config, "General",
-						"SecureConnections", &err);
-	if (err)
-		g_clear_error(&err);
-	else {
-		if (!strcmp(str, "off"))
-			btd_opts.secure_conn = SC_OFF;
-		else if (!strcmp(str, "on"))
-			btd_opts.secure_conn = SC_ON;
-		else if (!strcmp(str, "only"))
-			btd_opts.secure_conn = SC_ONLY;
-	}
-
-	str = g_key_file_get_string(config, "GATT", "Cache", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		btd_opts.gatt_cache = parse_gatt_cache(str);
-		g_free(str);
-	}
-
-	val = g_key_file_get_integer(config, "GATT", "KeySize", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("KeySize=%d", val);
-
-		if (val >=7 && val <= 16)
-			btd_opts.key_size = val;
-	}
-
-	val = g_key_file_get_integer(config, "GATT", "ExchangeMTU", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		/* Ensure the mtu is within a valid range. */
-		val = MIN(val, BT_ATT_MAX_LE_MTU);
-		val = MAX(val, BT_ATT_DEFAULT_LE_MTU);
-		DBG("ExchangeMTU=%d", val);
-		btd_opts.gatt_mtu = val;
-	}
-
-	val = g_key_file_get_integer(config, "GATT", "Channels", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("Channels=%d", val);
-		/* Ensure the channels is within a valid range. */
-		val = MIN(val, 5);
-		val = MAX(val, 1);
-		btd_opts.gatt_channels = val;
-	}
-
-	str = g_key_file_get_string(config, "CSIS", "SIRK", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("CSIS SIRK: %s", str);
-
-		if (strlen(str) == 32 && check_sirk_alpha_numeric(str)) {
-			hex2bin(str, btd_opts.csis.sirk,
-					sizeof(btd_opts.csis.sirk));
-		} else if (!gen_sirk(str))
-			DBG("Unable to generate SIRK from string");
-
-		g_free(str);
-	}
-
-	boolean = g_key_file_get_boolean(config, "CSIS", "Encryption", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("CSIS Encryption: %s", boolean ? "true" : "false");
-
-		btd_opts.csis.encrypt = boolean;
-	}
-
-	val = g_key_file_get_integer(config, "CSIS", "Size", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		val = MIN(val, 0xFF);
-		val = MAX(val, 0);
-		DBG("CSIS Size: %u", val);
-		btd_opts.csis.size = val;
-	}
-
-	val = g_key_file_get_integer(config, "CSIS", "Rank", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		val = MIN(val, 0xFF);
-		val = MAX(val, 0);
-		DBG("CSIS Rank: %u", val);
-		btd_opts.csis.rank = val;
-	}
-
-	str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("SessionMode=%s", str);
-
-		if (!strcmp(str, "basic"))
-			btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
-		else if (!strcmp(str, "ertm"))
-			btd_opts.avdtp.session_mode = BT_IO_MODE_ERTM;
-		else {
-			DBG("Invalid mode option: %s", str);
-			btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
-		}
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(config, "AVDTP", "StreamMode", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("StreamMode=%s", str);
-
-		if (!strcmp(str, "basic"))
-			btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
-		else if (!strcmp(str, "streaming"))
-			btd_opts.avdtp.stream_mode = BT_IO_MODE_STREAMING;
-		else {
-			DBG("Invalid mode option: %s", str);
-			btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
-		}
-		g_free(str);
-	}
-
-	val = g_key_file_get_integer(config, "AdvMon", "RSSISamplingPeriod",
-									&err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		val = MIN(val, 0xFF);
-		val = MAX(val, 0);
-		DBG("RSSISamplingPeriod=%d", val);
-		btd_opts.advmon.rssi_sampling_period = val;
-	}
-
+	/* Parse Groups */
+	parse_general(config);
 	parse_br_config(config);
 	parse_le_config(config);
+	parse_gatt(config);
+	parse_csis(config);
+	parse_avdtp(config);
+	parse_advmon(config);
 }
 
 static void init_defaults(void)
@@ -1284,24 +1324,6 @@ static gboolean parse_debug(const char *key, const char *value,
 	return TRUE;
 }
 
-static gboolean parse_kernel_experimental(const char *key, const char *value,
-					gpointer user_data, GError **error)
-{
-	char **strlist;
-
-	if (value) {
-		strlist = g_strsplit(value, ",", -1);
-		btd_parse_kernel_experimental(strlist);
-		g_strfreev(strlist);
-	} else {
-		if (!btd_opts.kernel)
-			btd_opts.kernel = queue_new();
-		queue_push_head(btd_opts.kernel, strdup("*"));
-	}
-
-	return TRUE;
-}
-
 static GOptionEntry options[] = {
 	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_debug,
-- 
2.40.1

