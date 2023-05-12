Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23FEC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 20:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbjELUfW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbjELUfS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 16:35:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EFC9E
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 13:35:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643990c5319so7546301b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923710; x=1686515710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HYa7Jr9/ehBTwM6+NoTMx5Mvt6gSU2q6zpz7QxkoY1I=;
        b=HTa3aNTnvjXMVckPLuxlQB29s0xYk70IJYGbyrGGcyfnjh46c7BRZ4TUaYivJps90e
         yXx2EVwVPxoaj25wOFiab/7Sx5WW5rnPWx8JpjNz+3ks+utbiM4aIpzWUayuJIn05msE
         nxpMls484OsMAC1kGEMY08bZQ4pGZDR+4sRRkE1oT3W5W3RLURVFzo6DwzX2vcJzrtda
         GWDvj4IhxmImRZvfyAqW4RzbeS6pwTucPymjcBi3xo9UxBLJC4GtmcPICofrTZPhBYVs
         Lq7WE9/XjMsKQh+9ZqZm2nl1bN16sz40YbTJE+3bBGRUHjUYVFMtAyPDmxy4vqZrjXb1
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923710; x=1686515710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYa7Jr9/ehBTwM6+NoTMx5Mvt6gSU2q6zpz7QxkoY1I=;
        b=MQOjvLlO7UMwBdaM4oLB7vAFmHFggy9j+iZ/baSqDGHXhN6flEQW0HpnePw6cL6Ih1
         pv9SjDJURsFKu/1jqZ4pBi45Sb6d6DFmUn2Q0V4gBb0lHipqn4M1RAi6YNOm7VAWJR5e
         qossWSspy+irCp0z6IbSLrMkOH0B5/4p1OQe5K+YshFMGZHEl5VEFWVZZR8V9ubtNR0r
         uq/pCHK5ulgTQZ02OwGFayJE1KXGGVI7xJT5QcBA9YI1sE3EccHEABhsiA19Kr0UL01y
         UpKug/roFF8XC375jUnLXq/BZbGorNGtp4Scy8Nhr0R/vCzQiJwA2gu/Sz4fMjfmLUXt
         waBA==
X-Gm-Message-State: AC+VfDw2b0sK+6X86TAPzVAk6tQqFzTylgZkTau2ahNU/IrSnbYddBXr
        AT94K+hZB5V09d2GURJbYwz2mQLAfOs=
X-Google-Smtp-Source: ACHHUZ7pIZ3E5iBZkmc7cBfF0jxzuIs54xDQQBYj9XEY8QgUKTeldH76XXzMmd3haSmRlLzpZPBKjg==
X-Received: by 2002:a05:6a20:3d84:b0:103:f8bf:36f6 with SMTP id s4-20020a056a203d8400b00103f8bf36f6mr8681461pzi.33.1683923710099;
        Fri, 12 May 2023 13:35:10 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b0063b7f3250e9sm7499270pfa.7.2023.05.12.13.35.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:35:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Add codec as parameter to endpoint.presets
Date:   Fri, 12 May 2023 13:35:07 -0700
Message-Id: <20230512203507.4146233-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes endpoint.presets command to take codec as parameter.
---
 client/player.c | 240 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 175 insertions(+), 65 deletions(-)

diff --git a/client/player.c b/client/player.c
index 58e14654ffb0..a9f56fb94b9b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -78,6 +78,7 @@ struct endpoint {
 	uint8_t cis;
 	char *transport;
 	DBusMessage *msg;
+	struct preset *preset;
 };
 
 static DBusConnection *dbus_conn;
@@ -1166,7 +1167,7 @@ struct codec_qos {
 };
 
 struct codec_preset {
-	const char *name;
+	char *name;
 	const struct iovec data;
 	const struct codec_qos qos;
 	uint8_t target_latency;
@@ -1410,9 +1411,10 @@ static struct codec_preset lc3_presets[] = {
 			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
 };
 
-#define PRESET(_uuid, _presets, _default_index) \
+#define PRESET(_uuid, _codec, _presets, _default_index) \
 	{ \
 		.uuid = _uuid, \
+		.codec = _codec, \
 		.custom = { .name = "custom" }, \
 		.default_preset = &_presets[_default_index], \
 		.presets = _presets, \
@@ -1421,46 +1423,142 @@ static struct codec_preset lc3_presets[] = {
 
 static struct preset {
 	const char *uuid;
+	uint8_t codec;
+	uint16_t cid;
+	uint16_t vid;
 	struct codec_preset custom;
 	struct codec_preset *default_preset;
 	struct codec_preset *presets;
 	size_t num_presets;
 } presets[] = {
-	PRESET(A2DP_SOURCE_UUID, sbc_presets, 6),
-	PRESET(A2DP_SINK_UUID, sbc_presets, 6),
-	PRESET(PAC_SINK_UUID, lc3_presets, 3),
-	PRESET(PAC_SOURCE_UUID, lc3_presets, 3),
+	PRESET(A2DP_SOURCE_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
+	PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
+	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
+	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
 };
 
-static struct codec_preset *find_preset(const char *uuid, const char *name)
+static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
+{
+	char **list;
+	char *endptr = NULL;
+
+	if (!codec)
+		return;
+
+	list = g_strsplit(codec, ":", 2);
+
+	if (vid)
+		*vid = strtol(list[0], &endptr, 0);
+
+	if (cid)
+		*cid = strtol(list[1], &endptr, 0);
+
+	g_strfreev(list);
+}
+
+static struct preset *find_presets(const char *uuid, uint8_t codec,
+					uint16_t vid, uint16_t cid)
 {
 	size_t i;
 
+	if (codec == 0xff) {
+		GList *l;
+
+		for (l = local_endpoints; l; l = g_list_next(l)) {
+			struct endpoint *ep = l->data;
+
+			if (strcasecmp(ep->uuid, uuid) || ep->codec != codec)
+				continue;
+
+			if (ep->codec == 0xff && (ep->vid != vid ||
+							ep->cid != cid))
+				continue;
+
+			return ep->preset;
+		}
+
+		return NULL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(presets); i++) {
 		struct preset *preset = &presets[i];
 
-		if (!strcasecmp(preset->uuid, uuid)) {
-			size_t j;
+		if (preset->codec != codec)
+			continue;
 
-			if (!name)
-				return preset->default_preset;
-			else if (!strcmp(name, "custom"))
-				return &preset->custom;
-
-			for (j = 0; j < preset->num_presets; j++) {
-				struct codec_preset *p;
-
-				p = &preset->presets[j];
-
-				if (!strcmp(p->name, name))
-					return p;
-			}
-		}
+		if (!strcasecmp(preset->uuid, uuid))
+			return preset;
 	}
 
 	return NULL;
 }
 
+static struct preset *find_vendor_presets(const char *uuid, const char *codec)
+{
+	uint16_t cid;
+	uint16_t vid;
+
+	if (!uuid || !codec)
+		return NULL;
+
+	parse_vendor_codec(codec, &vid, &cid);
+
+	return find_presets(uuid, 0xff, vid, cid);
+}
+
+static struct preset *find_presets_name(const char *uuid, const char *codec)
+{
+	uint8_t id;
+	char *endptr = NULL;
+
+	if (!uuid || !codec)
+		return NULL;
+
+	if (strrchr(codec, ':'))
+		return find_vendor_presets(uuid, codec);
+
+	id = strtol(codec, &endptr, 0);
+
+	return find_presets(uuid, id, 0x0000, 0x0000);
+}
+
+static struct codec_preset *preset_find_name(struct preset *preset,
+						const char *name)
+{
+	size_t i;
+
+	if (!preset)
+		return NULL;
+
+	if (!name)
+		return preset->default_preset;
+	else if (!strcmp(name, "custom"))
+		return &preset->custom;
+
+	for (i = 0; i < preset->num_presets; i++) {
+		struct codec_preset *p;
+
+		p = &preset->presets[i];
+
+		if (!strcmp(p->name, name))
+			return p;
+	}
+
+	return NULL;
+}
+
+static struct codec_preset *find_preset(const char *uuid, const char *codec,
+					const char *name)
+{
+	struct preset *preset;
+
+	preset = find_presets_name(uuid, codec);
+	if (!preset)
+		return NULL;
+
+	return preset_find_name(preset, name);
+}
+
 static DBusMessage *endpoint_select_config_reply(DBusMessage *msg,
 						 uint8_t *data, size_t len)
 {
@@ -1525,7 +1623,7 @@ static void select_config_response(const char *input, void *user_data)
 	uint8_t *data;
 	size_t len;
 
-	p = find_preset(ep->uuid, input);
+	p = preset_find_name(ep->preset, input);
 	if (p) {
 		data = p->data.iov_base;
 		len = p->data.iov_len;
@@ -1580,7 +1678,7 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 		return NULL;
 	}
 
-	p = find_preset(ep->uuid, NULL);
+	p = preset_find_name(ep->preset, NULL);
 	if (!p) {
 		reply = g_dbus_create_error(msg, "org.bluez.Error.Rejected",
 								NULL);
@@ -1755,7 +1853,7 @@ static void select_properties_response(const char *input, void *user_data)
 	struct codec_preset *p;
 	DBusMessage *reply;
 
-	p = find_preset(ep->uuid, input);
+	p = preset_find_name(ep->preset, input);
 	if (p) {
 		reply = endpoint_select_properties_reply(ep, ep->msg, p);
 		goto done;
@@ -1797,9 +1895,9 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 		return NULL;
 	}
 
-	p = find_preset(ep->uuid, NULL);
+	p = preset_find_name(ep->preset, NULL);
 	if (!p)
-		NULL;
+		return NULL;
 
 	reply = endpoint_select_properties_reply(ep, msg, p);
 	if (!reply)
@@ -1903,6 +2001,11 @@ static void endpoint_free(void *data)
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
 
+	if (ep->codec == 0xff) {
+		free(ep->preset->custom.name);
+		free(ep->preset);
+	}
+
 	g_free(ep->path);
 	g_free(ep->uuid);
 	g_free(ep);
@@ -2312,7 +2415,6 @@ static void cmd_register_endpoint(int argc, char *argv[])
 {
 	struct endpoint *ep;
 	char *endptr = NULL;
-	char **list;
 
 	ep = g_new0(struct endpoint, 1);
 	ep->uuid = g_strdup(argv[1]);
@@ -2324,12 +2426,13 @@ static void cmd_register_endpoint(int argc, char *argv[])
 	local_endpoints = g_list_append(local_endpoints, ep);
 
 	if (strrchr(argv[2], ':')) {
-		list = g_strsplit(argv[2], ":", 2);
-
 		ep->codec = 0xff;
-		ep->vid = strtol(list[0], &endptr, 0);
-		endptr = NULL;
-		ep->cid = strtol(list[1], &endptr, 0);
+		parse_vendor_codec(argv[2], &ep->cid, &ep->vid);
+		ep->preset = new0(struct preset, 1);
+		ep->preset->custom.name = strdup("custom");
+		ep->preset->default_preset = &ep->preset->custom;
+	} else {
+		ep->preset = find_presets_name(ep->uuid, argv[2]);
 	}
 
 	if (argc > 3)
@@ -2489,7 +2592,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 	}
 
 	if (argc > 3) {
-		preset = find_preset(cfg->ep->uuid, argv[3]);
+		preset = preset_find_name(cfg->ep->preset, argv[3]);
 		if (!preset) {
 			bt_shell_printf("Preset %s not found\n", argv[3]);
 			goto fail;
@@ -2835,46 +2938,50 @@ static void custom_frequency(const char *input, void *user_data)
 				custom_duration, user_data);
 }
 
-static void cmd_presets_endpoint(int argc, char *argv[])
+static void print_presets(struct preset *preset)
 {
 	size_t i;
+	struct codec_preset *p;
+
+	p = &preset->custom;
+
+	bt_shell_printf("%s%s\n", p == preset->default_preset ? "*" : "",
+								p->name);
+
+	for (i = 0; i < preset->num_presets; i++) {
+		p = &preset->presets[i];
+		bt_shell_printf("%s%s\n", p == preset->default_preset ?
+						"*" : "", p->name);
+	}
+}
+
+static void cmd_presets_endpoint(int argc, char *argv[])
+{
+	struct preset *preset;
 	struct codec_preset *default_preset = NULL;
 
-	if (argc > 2) {
-		default_preset = find_preset(argv[1], argv[2]);
+	if (argc > 3) {
+		default_preset = find_preset(argv[1], argv[2], argv[3]);
 		if (!default_preset) {
-			bt_shell_printf("Preset %s not found\n", argv[2]);
+			bt_shell_printf("Preset %s not found\n", argv[3]);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(presets); i++) {
-		struct preset *preset = &presets[i];
-
-		if (!strcasecmp(preset->uuid, argv[1])) {
-			size_t j;
-			struct codec_preset *p;
-
-			if (default_preset) {
-				preset->default_preset = default_preset;
-				break;
-			}
-
-			p = &preset->custom;
-
-			bt_shell_printf("%s%s\n", p == preset->default_preset ?
-						"*" : "", p->name);
-
-			for (j = 0; j < preset->num_presets; j++) {
-				p = &preset->presets[j];
-
-				bt_shell_printf("%s%s\n",
-						p == preset->default_preset ?
-						"*" : "", p->name);
-			}
-		}
+	preset = find_presets_name(argv[1], argv[2]);
+	if (!preset) {
+		bt_shell_printf("No preset found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (default_preset) {
+		preset->default_preset = default_preset;
+		goto done;
+	}
+
+	print_presets(preset);
+
+done:
 	if (default_preset && !strcmp(default_preset->name, "custom")) {
 		bt_shell_prompt_input("Codec", "Enter frequency (Khz):",
 					custom_frequency, default_preset);
@@ -2904,7 +3011,8 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-	{ "presets",      "<UUID> [default]", cmd_presets_endpoint,
+	{ "presets",      "<UUID> <codec[:company]> [default]",
+						cmd_presets_endpoint,
 						"List available presets",
 						uuid_generator },
 	{} },
@@ -2938,6 +3046,8 @@ static void register_endpoints(GDBusProxy *proxy)
 			continue;
 
 		ep = endpoint_new(cap);
+		ep->preset = find_presets(ep->uuid, ep->codec, ep->vid,
+								ep->cid);
 		ep->max_transports = UINT8_MAX;
 		ep->auto_accept = true;
 		ep->cig = BT_ISO_QOS_CIG_UNSET;
-- 
2.40.0

