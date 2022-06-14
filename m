Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 21:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbiFNV4T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiFNV4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 17:56:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D929816
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 14:56:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id fu17so7128392qtb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nd2zC6tm4AB2yUxZ/uQTLb5ZDOchkbdczvhlQygV8uc=;
        b=FcL22HY3cpuQzcE1o7mrXEYjmAt2xZoYnlG3HvlLASR9oLxaEUt3Z6ESpUuVGIUU1Z
         xioERiMJH7EgzKTAF/ykaJ1pq0lWHa+vM99o1CekAy/eaxlPPGu7YEHcnNij1HDttd+O
         fcdTxFRZuMWsFL08p+0FjiDdjsO8hI8HPquJYnZ0j8ebQiAzCJ1LivYB86LueJNK84IG
         80uSvIaUQgUG+Ea9NY6C7CLU3jpUQVFmZFybCY1a1k45wLRsz8oY3a0He2ANUDYc18XA
         r+CWWdC58Wf+ZAOVb7AV2JT60ENSA1eu1ebD89z3fiXbGINqLSwYR9zjzI540vVkqa/U
         sxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nd2zC6tm4AB2yUxZ/uQTLb5ZDOchkbdczvhlQygV8uc=;
        b=Bcc7SmF9ynwWVMSXc+VrzceFtTGjYBCRT0+wqZ0EJTchmm+K5syjOCH+9eo48PKipJ
         emUGDNEDl76GtBekphkmtuHYUoYSmase3Pc9NTUiJpjj85myxHrcTbq2srxukkCxZy0F
         1koqpfI757Gx/x7XVfp/pAZzafbNuJNdG/sPfmmLC+Q9yDIbB4617mh9jwA+w13sSKww
         ApldkYmZgsoOWX9XTOcP7LFwlyCJoKX8tH4RuKoPUiqhcQ7w949AfqmGUYAngCHk2vEO
         hwisuC7IKcizOvxonLkMeWVdATVaEx2QmVNdGy7ztr2OlZWhr78oC7MVxY1H3MtFFNyV
         p2TA==
X-Gm-Message-State: AOAM533hsNKZxbF4y1pwRoRZ0sXjQkRPd6JGbqmCIUX7oWpvKzB6QwUJ
        jhWgQ+5rB6/APBZ3f31rUbkH1/N9UP8=
X-Google-Smtp-Source: ABdhPJw21LGfHatDLOiD/YIZVkyymEuGpxomh6B/p4ZY2lfa3kStI9MWngTIjdtRSAW2cVnwKMOQoQ==
X-Received: by 2002:a05:622a:30e:b0:305:a792:dfc8 with SMTP id q14-20020a05622a030e00b00305a792dfc8mr5714060qtw.140.1655243772247;
        Tue, 14 Jun 2022 14:56:12 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006a780aa9fc4sm8446126qkp.96.2022.06.14.14.56.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:56:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] main.conf: Split Kernel Experimental UUIDs from Experimental
Date:   Tue, 14 Jun 2022 14:56:08 -0700
Message-Id: <20220614215609.596687-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This splits kernel experimental UUIDs from D-Bus Experimental interface
so they can be controlled indenpendetly.
---
 src/adapter.c | 28 ++++++++++++++++---------
 src/btd.h     |  5 +++--
 src/main.c    | 57 ++++++++++++++++++++++++++++++---------------------
 src/main.conf |  8 ++++++--
 4 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3e0b3049a..afefa1d5d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9583,7 +9583,7 @@ static void set_exp_debug_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+	uint8_t action;
 
 	if (status != 0) {
 		error("Set Experimental Debug failed with status 0x%02x (%s)",
@@ -9591,7 +9591,9 @@ static void set_exp_debug_complete(uint8_t status, uint16_t len,
 		return;
 	}
 
-	DBG("Experimental Debug successfully set");
+	action = btd_kernel_experimental_enabled(debug_uuid.str);
+
+	DBG("Experimental Debug successfully %s", action ? "set" : "reset");
 
 	if (action)
 		queue_push_tail(adapter->exps, (void *)debug_uuid.val);
@@ -9631,7 +9633,7 @@ static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+	uint8_t action;
 
 	if (status != 0) {
 		error("Set RPA Resolution failed with status 0x%02x (%s)",
@@ -9639,7 +9641,9 @@ static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 		return;
 	}
 
-	DBG("RPA Resolution successfully set");
+	action = btd_kernel_experimental_enabled(rpa_resolution_uuid.str);
+
+	DBG("RPA Resolution successfully %s", action ? "set" : "reset");
 
 	if (action)
 		queue_push_tail(adapter->exps, (void *)rpa_resolution_uuid.val);
@@ -9665,7 +9669,7 @@ static void codec_offload_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+	uint8_t action;
 
 	if (status != 0) {
 		error("Set Codec Offload failed with status 0x%02x (%s)",
@@ -9673,7 +9677,9 @@ static void codec_offload_complete(uint8_t status, uint16_t len,
 		return;
 	}
 
-	DBG("Codec Offload successfully set");
+	action = btd_kernel_experimental_enabled(codec_offload_uuid.str);
+
+	DBG("Codec Offload successfully %s", action ? "set" : "reset");
 
 	if (action)
 		queue_push_tail(adapter->exps, (void *)codec_offload_uuid.val);
@@ -9744,20 +9750,22 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 
 		for (j = 0; j < ARRAY_SIZE(exp_table); j++) {
 			const struct exp_feat *feat = &exp_table[j];
+			const char *str;
 			uint8_t action;
 
 			if (memcmp(rp->features[i].uuid, feat->uuid->val,
 					sizeof(rp->features[i].uuid)))
 				continue;
 
-			action = btd_experimental_enabled(feat->uuid->str);
+			str = feat->uuid->str;
+			action = btd_kernel_experimental_enabled(str);
 
-			DBG("%s flags %u action %u", feat->uuid->str,
-				rp->features[i].flags, action);
+			DBG("%s flags %u action %u", str,
+					rp->features[i].flags, action);
 
 			/* If already set don't attempt to set it again */
 			if (action == (rp->features[i].flags & BIT(0))) {
-				if (action)
+				if (action & BIT(0))
 					queue_push_tail(adapter->exps,
 						(void *)feat->uuid->val);
 				continue;
diff --git a/src/btd.h b/src/btd.h
index d13646889..c02b2691e 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -113,7 +113,8 @@ struct btd_opts {
 	gboolean	debug_keys;
 	gboolean	fast_conn;
 	gboolean	refresh_discovery;
-	struct queue	*experimental;
+	gboolean	experimental;
+	struct queue	*kernel;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
@@ -145,6 +146,6 @@ void rfkill_init(void);
 void rfkill_exit(void);
 
 GKeyFile *btd_get_main_conf(void);
-bool btd_experimental_enabled(const char *uuid);
+bool btd_kernel_experimental_enabled(const char *uuid);
 
 void btd_exit(void);
diff --git a/src/main.c b/src/main.c
index 12cc21372..34a54d43f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -84,6 +84,7 @@ static const char *supported_options[] = {
 	"JustWorksRepairing",
 	"TemporaryTimeout",
 	"Experimental",
+	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
 	NULL
 };
@@ -592,12 +593,12 @@ static bool match_experimental(const void *data, const void *match_data)
 	return !strcasecmp(value, uuid);
 }
 
-bool btd_experimental_enabled(const char *uuid)
+bool btd_kernel_experimental_enabled(const char *uuid)
 {
-	if (!btd_opts.experimental)
+	if (!btd_opts.kernel)
 		false;
 
-	return queue_find(btd_opts.experimental, match_experimental, uuid);
+	return queue_find(btd_opts.kernel, match_experimental, uuid);
 }
 
 static const char *valid_uuids[] = {
@@ -609,24 +610,24 @@ static const char *valid_uuids[] = {
 	"*"
 };
 
-static void btd_parse_experimental(char **list)
+static void btd_parse_kernel_experimental(char **list)
 {
 	int i;
 
-	if (btd_opts.experimental) {
-		warn("Unable to parse Experimental: list already set");
+	if (btd_opts.kernel) {
+		warn("Unable to parse KernelExperimental: list already set");
 		return;
 	}
 
-	btd_opts.experimental = queue_new();
+	btd_opts.kernel = queue_new();
 
 	for (i = 0; list[i]; i++) {
 		size_t j;
 		const char *uuid = list[i];
 
 		if (!strcasecmp("false", uuid) || !strcasecmp("off", uuid)) {
-			queue_destroy(btd_opts.experimental, free);
-			btd_opts.experimental = NULL;
+			queue_destroy(btd_opts.kernel, free);
+			btd_opts.kernel = NULL;
 		}
 
 		if (!strcasecmp("true", uuid) || !strcasecmp("on", uuid))
@@ -639,13 +640,13 @@ static void btd_parse_experimental(char **list)
 
 		/* Ignored if UUID is considered invalid */
 		if (j == ARRAY_SIZE(valid_uuids)) {
-			warn("Invalid Experimental UUID: %s", uuid);
+			warn("Invalid KernelExperimental UUID: %s", uuid);
 			continue;
 		}
 
 		DBG("%s", uuid);
 
-		queue_push_tail(btd_opts.experimental, strdup(uuid));
+		queue_push_tail(btd_opts.kernel, strdup(uuid));
 	}
 }
 
@@ -850,12 +851,20 @@ static void parse_config(GKeyFile *config)
 	else
 		btd_opts.refresh_discovery = boolean;
 
-	strlist = g_key_file_get_string_list(config, "General", "Experimental",
+	boolean = g_key_file_get_boolean(config, "General", "Experimental",
+						&err);
+	if (err)
+		g_clear_error(&err);
+	else
+		btd_opts.experimental = boolean;
+
+	strlist = g_key_file_get_string_list(config, "General",
+						"KernelExperimental",
 						NULL, &err);
 	if (err)
 		g_clear_error(&err);
 	else {
-		btd_parse_experimental(strlist);
+		btd_parse_kernel_experimental(strlist);
 		g_strfreev(strlist);
 	}
 
@@ -1133,19 +1142,19 @@ static gboolean parse_debug(const char *key, const char *value,
 	return TRUE;
 }
 
-static gboolean parse_experimental(const char *key, const char *value,
+static gboolean parse_kernel_experimental(const char *key, const char *value,
 					gpointer user_data, GError **error)
 {
 	char **strlist;
 
 	if (value) {
 		strlist = g_strsplit(value, ",", -1);
-		btd_parse_experimental(strlist);
+		btd_parse_kernel_experimental(strlist);
 		g_strfreev(strlist);
 	} else {
-		if (!btd_opts.experimental)
-			btd_opts.experimental = queue_new();
-		queue_push_head(btd_opts.experimental, strdup("*"));
+		if (!btd_opts.kernel)
+			btd_opts.kernel = queue_new();
+		queue_push_head(btd_opts.kernel, strdup("*"));
 	}
 
 	return TRUE;
@@ -1163,9 +1172,11 @@ static GOptionEntry options[] = {
 			"Specify an explicit path to the config file", "FILE"},
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
-	{ "experimental", 'E', G_OPTION_FLAG_OPTIONAL_ARG,
-				G_OPTION_ARG_CALLBACK, parse_experimental,
-				"Enable experimental features/interfaces" },
+	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &btd_opts.experimental,
+				"Enable experimental D-Bus interfaces" },
+	{ "kernel", 'K', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
+				parse_kernel_experimental,
+				"Enable kernel experimental features" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Run with logging in foreground" },
@@ -1289,8 +1300,8 @@ int main(int argc, char *argv[])
 	if (btd_opts.mode != BT_MODE_LE)
 		stop_sdp_server();
 
-	if (btd_opts.experimental)
-		queue_destroy(btd_opts.experimental, free);
+	if (btd_opts.kernel)
+		queue_destroy(btd_opts.kernel, free);
 
 	if (main_conf)
 		g_key_file_free(main_conf);
diff --git a/src/main.conf b/src/main.conf
index 91b98b8c4..3816cf362 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -111,7 +111,11 @@
 # profile is connected. Defaults to true.
 #RefreshDiscovery = true
 
-# Enables experimental features and interfaces, alternatively a list of UUIDs
+# Enables D-Bus experimental interfaces
+# Possible values: true or false
+#Experimental = false
+
+# Enables kernel experimental features, alternatively a list of UUIDs
 # can be given.
 # Possible values: true,false,<UUID List>
 # Possible UUIDS:
@@ -121,7 +125,7 @@
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # Defaults to false.
-#Experimental = false
+#KernelExperimental = false
 
 # The duration to avoid retrying to resolve a peer's name, if the previous
 # try failed.
-- 
2.35.3

