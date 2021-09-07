Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75AB6056C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbhIGWbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346560AbhIGWbT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 18:31:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9231C061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 15:30:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 18so315940pfh.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5TLpHh7AV47SXf2E1p7hnAJxna0z8dGBhd+Zc3p5H40=;
        b=jXXRvcXs8nh4IboFJ0VA1uymGiyzcx0MzwAnZCLgVwqFrBtpTmtNIqwtClKd5yEDmU
         0V2XvdYbCk7+WX3bKUki28Ddoxdlc8JFb/8tGC/SV8PHIwPxC8rdupnmqT//cSuBzEXx
         DKooG/Jr2qKNonuxeXX6X9dhfQj36AQHb7laMjuTP0z2/MhwB4RJks0Uk1+Qjn2/6dCq
         DCerQmPn0Yd3498/QIXB1kMYd2o1YUmwKInJBOrh+LFHQANXL+pk21OsNDt+TrFH3gWO
         QfV2+sVTU4dTf2yDhPipnbeXqeFRDVVLlKdouEcyALAMYZb6y/suQ6ThOfmnaXMbRh49
         hcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TLpHh7AV47SXf2E1p7hnAJxna0z8dGBhd+Zc3p5H40=;
        b=LgAdmphMg3JwJnPzOkNd6WmfBw1TAXGzy299Pmrp22tW+GKTplvXQBe7HQzRo9kjsn
         tBH7VUSGmCFMT9ek82CdHh20ZZcifYtbytDXXWCynvrBYRkx9k4EWpfeGn3GXRS40OPW
         6VEdxG7wQSVCtrvCxsl1uFWy1AO275VXHiiUWVZluPPsfmZLCDSk12Zsf3FCJanAmhb5
         geZ19k5kPxeC4btdd8LZnypGJc6UOzYeSQWvPUVS8jCFfroIz23QTW29LNnT4HN9OPQe
         neWl1t8svRE/DbJ2+FWRBgolkEdcHP4+s73jzHoo7ysBJf1oqXpaWgxsA7hxm42bGJMd
         U6Jg==
X-Gm-Message-State: AOAM532LIPiRTog610HkStBqSe6Ta/VcjsJPkoIpgO0z23Jazu3icgQB
        iaBFSPPQINb8khJLb9+TSY3mNT5wQBQ=
X-Google-Smtp-Source: ABdhPJz2YC4e9FQ9lpKFBppf3zV7kuVOp0rOoZLDl783rxcVfkKJ71ajcV9gt7P2iuOPeOFzgRDQtg==
X-Received: by 2002:a63:3753:: with SMTP id g19mr567252pgn.328.1631053811922;
        Tue, 07 Sep 2021 15:30:11 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x19sm153811pgk.37.2021.09.07.15.30.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:30:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] main.conf: Allow passing a list of UUIDs to Experimental
Date:   Tue,  7 Sep 2021 15:30:07 -0700
Message-Id: <20210907223008.2322035-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907223008.2322035-1-luiz.dentz@gmail.com>
References: <20210907223008.2322035-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allows the user to enable a subset of the experimental features to
be enabled instead of all of them and also change -E to work in the same
way so a list of UUIDs can also be given at the command line.
---
 src/adapter.c | 106 ++++++++++++++++++++++++++-----------------------
 src/btd.h     |   5 ++-
 src/main.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++----
 src/main.conf |  10 ++++-
 4 files changed, 169 insertions(+), 60 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dd187f847..bc6469e0a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -102,28 +102,37 @@ static const struct mgmt_blocked_key_info blocked_keys[] = {
 		 0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
 };
 
+struct mgmt_exp_uuid {
+	uint8_t val[16];
+	const char *str;
+};
+
 /* d4992530-b9ec-469f-ab01-6c481c47da1c */
-static const uint8_t debug_uuid[16] = {
-	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
-	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
+static const struct mgmt_exp_uuid debug_uuid = {
+	.val = { 0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
+		0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4 },
+	.str = "d4992530-b9ec-469f-ab01-6c481c47da1c"
 };
 
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
-static const uint8_t le_simult_central_peripheral_uuid[16] = {
-	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
-	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
+	.val = { 0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+		0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67 },
+	.str = "671b10b5-42c0-4696-9227-eb28d1b049d6"
 };
 
 /* 330859bc-7506-492d-9370-9a6f0614037f */
-static const uint8_t quality_report_uuid[16] = {
-	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
-	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
+static const struct mgmt_exp_uuid quality_report_uuid = {
+	.val = { 0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
+		0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33 },
+	.str = "330859bc-7506-492d-9370-9a6f0614037f"
 };
 
 /* 15c0a148-c273-11ea-b3de-0242ac130004 */
-static const uint8_t rpa_resolution_uuid[16] = {
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
-	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+static const struct mgmt_exp_uuid rpa_resolution_uuid = {
+	.val = { 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+		0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15 },
+	.str = "15c0a148-c273-11ea-b3de-0242ac130004"
 };
 
 static DBusConnection *dbus_conn = NULL;
@@ -3274,7 +3283,7 @@ static gboolean property_get_roles(const GDBusPropertyTable *property,
 	}
 
 	if (queue_find(adapter->exps, NULL,
-				le_simult_central_peripheral_uuid)) {
+				le_simult_central_peripheral_uuid.val)) {
 		const char *str = "central-peripheral";
 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
 	}
@@ -9479,23 +9488,15 @@ static void set_exp_debug_complete(uint8_t status, uint16_t len,
 	DBG("Experimental Debug successfully set");
 
 	if (action)
-		queue_push_tail(adapter->exps, (void *)debug_uuid);
+		queue_push_tail(adapter->exps, (void *)debug_uuid.val);
 }
 
-static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
+static void exp_debug_func(struct btd_adapter *adapter, uint8_t action)
 {
 	struct mgmt_cp_set_exp_feature cp;
-	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
-
-	/* If already set don't attempt to set it again */
-	if (action == (flags & BIT(0))) {
-		if (action)
-			queue_push_tail(adapter->exps, (void *)debug_uuid);
-		return;
-	}
 
 	memset(&cp, 0, sizeof(cp));
-	memcpy(cp.uuid, debug_uuid, 16);
+	memcpy(cp.uuid, debug_uuid.val, 16);
 	cp.action = action;
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
@@ -9507,17 +9508,17 @@ static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
 }
 
 static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
-							uint32_t flags)
+							uint8_t action)
 {
-	if (flags & 0x01)
+	if (action)
 		queue_push_tail(adapter->exps,
-				(void *)le_simult_central_peripheral_uuid);
+				(void *)le_simult_central_peripheral_uuid.val);
 }
 
-static void quality_report_func(struct btd_adapter *adapter, uint32_t flags)
+static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
 {
-	if (flags & 0x01)
-		queue_push_tail(adapter->exps, (void *)quality_report_uuid);
+	if (action)
+		queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
 }
 
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
@@ -9535,24 +9536,15 @@ static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 	DBG("RPA Resolution successfully set");
 
 	if (action)
-		queue_push_tail(adapter->exps, (void *)rpa_resolution_uuid);
+		queue_push_tail(adapter->exps, (void *)rpa_resolution_uuid.val);
 }
 
-static void rpa_resolution_func(struct btd_adapter *adapter, uint32_t flags)
+static void rpa_resolution_func(struct btd_adapter *adapter, uint8_t action)
 {
 	struct mgmt_cp_set_exp_feature cp;
-	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
-
-	/* If already set don't attempt to set it again */
-	if (action == (flags & BIT(0))) {
-		if (action)
-			queue_push_tail(adapter->exps,
-						(void *)rpa_resolution_uuid);
-		return;
-	}
 
 	memset(&cp, 0, sizeof(cp));
-	memcpy(cp.uuid, rpa_resolution_uuid, 16);
+	memcpy(cp.uuid, rpa_resolution_uuid.val, 16);
 	cp.action = action;
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
@@ -9564,14 +9556,14 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint32_t flags)
 }
 
 static const struct exp_feat {
-	const uint8_t *uuid;
-	void (*func)(struct btd_adapter *adapter, uint32_t flags);
+	const struct mgmt_exp_uuid *uuid;
+	void (*func)(struct btd_adapter *adapter, uint8_t action);
 } exp_table[] = {
-	EXP_FEAT(debug_uuid, exp_debug_func),
-	EXP_FEAT(le_simult_central_peripheral_uuid,
+	EXP_FEAT(&debug_uuid, exp_debug_func),
+	EXP_FEAT(&le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
-	EXP_FEAT(quality_report_uuid, quality_report_func),
-	EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
+	EXP_FEAT(&quality_report_uuid, quality_report_func),
+	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
@@ -9608,13 +9600,27 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 
 		for (j = 0; j < ARRAY_SIZE(exp_table); j++) {
 			const struct exp_feat *feat = &exp_table[j];
+			uint8_t action;
 
-			if (memcmp(rp->features[i].uuid, feat->uuid,
+			if (memcmp(rp->features[i].uuid, feat->uuid->val,
 					sizeof(rp->features[i].uuid)))
 				continue;
 
+			action = btd_experimental_enabled(feat->uuid->str);
+
+			DBG("%s flags %u action %u", feat->uuid->str,
+				rp->features[i].flags, action);
+
+			/* If already set don't attempt to set it again */
+			if (action == (rp->features[i].flags & BIT(0))) {
+				if (action)
+					queue_push_tail(adapter->exps,
+						(void *)feat->uuid->val);
+				continue;
+			}
+
 			if (feat->func)
-				feat->func(adapter, rp->features[i].flags);
+				feat->func(adapter, action);
 		}
 	}
 }
diff --git a/src/btd.h b/src/btd.h
index d72883546..f83591f8f 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -10,6 +10,8 @@
  *
  */
 
+#include <stdbool.h>
+
 typedef enum {
 	BT_MODE_DUAL,
 	BT_MODE_BREDR,
@@ -109,7 +111,7 @@ struct btd_opts {
 	gboolean	debug_keys;
 	gboolean	fast_conn;
 	gboolean	refresh_discovery;
-	gboolean	experimental;
+	struct queue	*experimental;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
@@ -140,5 +142,6 @@ void rfkill_init(void);
 void rfkill_exit(void);
 
 GKeyFile *btd_get_main_conf(void);
+bool btd_experimental_enabled(const char *uuid);
 
 void btd_exit(void);
diff --git a/src/main.c b/src/main.c
index bf8b8dca7..5ca8d5644 100644
--- a/src/main.c
+++ b/src/main.c
@@ -42,6 +42,7 @@
 #include "shared/att-types.h"
 #include "shared/mainloop.h"
 #include "shared/timeout.h"
+#include "shared/queue.h"
 #include "lib/uuid.h"
 #include "shared/util.h"
 #include "btd.h"
@@ -545,10 +546,78 @@ static void parse_le_config(GKeyFile *config)
 	parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
 }
 
+static bool match_experimental(const void *data, const void *match_data)
+{
+	const char *value = data;
+	const char *uuid = match_data;
+
+	if (!strcmp(value, "*"))
+		return true;
+
+	return !strcasecmp(value, uuid);
+}
+
+bool btd_experimental_enabled(const char *uuid)
+{
+	if (!btd_opts.experimental)
+		false;
+
+	return queue_find(btd_opts.experimental, match_experimental, uuid);
+}
+
+static const char *valid_uuids[] = {
+	"d4992530-b9ec-469f-ab01-6c481c47da1c",
+	"671b10b5-42c0-4696-9227-eb28d1b049d6",
+	"15c0a148-c273-11ea-b3de-0242ac130004",
+	"330859bc-7506-492d-9370-9a6f0614037f",
+	"a6695ace-ee7f-4fb9-881a-5fac66c629af",
+	"*"
+};
+
+static void btd_parse_experimental(char **list)
+{
+	int i;
+
+	if (btd_opts.experimental) {
+		warn("Unable to parse Experimental: list already set");
+		return;
+	}
+
+	btd_opts.experimental = queue_new();
+
+	for (i = 0; list[i]; i++) {
+		size_t j;
+		const char *uuid = list[i];
+
+		if (!strcasecmp("false", uuid) || !strcasecmp("off", uuid)) {
+			queue_destroy(btd_opts.experimental, free);
+			btd_opts.experimental = NULL;
+		}
+
+		if (!strcasecmp("true", uuid) || !strcasecmp("on", uuid))
+			uuid = "*";
+
+		for (j = 0; j < ARRAY_SIZE(valid_uuids); j++) {
+			if (!strcasecmp(valid_uuids[j], uuid))
+				break;
+		}
+
+		/* Ignored if UUID is considered invalid */
+		if (j == ARRAY_SIZE(valid_uuids)) {
+			warn("Invalid Experimental UUID: %s", uuid);
+			continue;
+		}
+
+		DBG("%s", uuid);
+
+		queue_push_tail(btd_opts.experimental, strdup(uuid));
+	}
+}
+
 static void parse_config(GKeyFile *config)
 {
 	GError *err = NULL;
-	char *str;
+	char *str, **strlist;
 	int val;
 	gboolean boolean;
 
@@ -722,12 +791,14 @@ static void parse_config(GKeyFile *config)
 	else
 		btd_opts.refresh_discovery = boolean;
 
-	boolean = g_key_file_get_boolean(config, "General",
-						"Experimental", &err);
+	strlist = g_key_file_get_string_list(config, "General", "Experimental",
+						NULL, &err);
 	if (err)
 		g_clear_error(&err);
-	else
-		btd_opts.experimental = boolean;
+	else {
+		btd_parse_experimental(strlist);
+		g_strfreev(strlist);
+	}
 
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
@@ -840,7 +911,6 @@ static void init_defaults(void)
 	btd_opts.name_resolv = TRUE;
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
-	btd_opts.experimental = false;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
@@ -993,6 +1063,24 @@ static gboolean parse_debug(const char *key, const char *value,
 	return TRUE;
 }
 
+static gboolean parse_experimental(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	char **strlist;
+
+	if (value) {
+		strlist = g_strsplit(value, ",", -1);
+		btd_parse_experimental(strlist);
+		g_strfreev(strlist);
+	} else {
+		if (!btd_opts.experimental)
+			btd_opts.experimental = queue_new();
+		queue_push_head(btd_opts.experimental, strdup("*"));
+	}
+
+	return TRUE;
+}
+
 static GOptionEntry options[] = {
 	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_debug,
@@ -1005,8 +1093,9 @@ static GOptionEntry options[] = {
 			"Specify an explicit path to the config file", "FILE"},
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
-	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &btd_opts.experimental,
-				"Enable experimental interfaces" },
+	{ "experimental", 'E', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_experimental,
+				"Enable experimental features/interfaces" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Run with logging in foreground" },
@@ -1135,6 +1224,9 @@ int main(int argc, char *argv[])
 	if (btd_opts.mode != BT_MODE_LE)
 		stop_sdp_server();
 
+	if (btd_opts.experimental)
+		queue_destroy(btd_opts.experimental, free);
+
 	if (main_conf)
 		g_key_file_free(main_conf);
 
diff --git a/src/main.conf b/src/main.conf
index 71924cb17..e05291d8e 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -86,7 +86,15 @@
 # profile is connected. Defaults to true.
 #RefreshDiscovery = true
 
-# Enables experimental features and interfaces.
+# Enables experimental features and interfaces, alternatively a list of UUIDs
+# can be given.
+# Possible values: true,false,<UUID List>
+# Possible UUIDS:
+# d4992530-b9ec-469f-ab01-6c481c47da1c (BlueZ Experimental Debug)
+# 671b10b5-42c0-4696-9227-eb28d1b049d6 (BlueZ Experimental Simultaneous Central and Peripheral)
+# 15c0a148-c273-11ea-b3de-0242ac130004 (BlueZ Experimental LL privacy)
+# 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
+# a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # Defaults to false.
 #Experimental = false
 
-- 
2.31.1

