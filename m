Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 20:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiK2UqF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2UqD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E42657A
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d6so14612780pll.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k8zd+KfEy7WTuqeSNRLiiy/z9BkiSBTCI8VPd94acI=;
        b=mtDG19cDGChLI2yW/yiOXg9FFrAB/k1Yw6oq+As18sMgEvOoRMoPgaIrmoXVbVg7TR
         5TMDiz+l/wllDrf57dxac3pvmvvfgxdU6XOGmGA4TNIkFs5ERtP5WKI+SnQzYle+v1et
         ZeQyeoOjD2R+RkB4Vu+1iJy8jTy5EXbSBzZy9T/jMt74zEKWjw6Wzm1VdxdZW6iyqOW3
         TeDeAhZVL2fOQxaJlPGtjsfTFXpUVZJueG6EPdwVq9Nfjh7OPWwf8gyA5+u4BL2hkFo5
         3Kg01cpyXhvw6vmKjSJ/LiCG6TafpaedODSc4nE5fJnS5kuJaLlOxDvK55Sll3EGRjkx
         4bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k8zd+KfEy7WTuqeSNRLiiy/z9BkiSBTCI8VPd94acI=;
        b=Fl6H+aaVFh4SzBYjeSvxPE/MeVMC4tb7X67BI67c94BJ9unQ58luJuIsQucYvpBAUH
         tm4GtAPJqLfQC3bX85ST+mq3posxFVwU+0XHkPTojFXDuxVXFgTBpC9ZQ5GBUkvWyxNg
         +YHoHzOxmT8Yi31TKUtvKqaPPa7EQQaEmvtC/LzFXPoqT5flnQDqftVDZDO2NOwkzHRt
         rT9YyliUMXV2yrhua9ZvNPYevAdHc/szTe6hCSnpCj/+8WE17GSzWDhmT4IdckGcgWYp
         KGakj8uxCF6ihJTAfNPrBBZgGUWhCoTh7LovkZ1zsmgiaflr6F81R9cTyBN8LT1k7Jzp
         UX7A==
X-Gm-Message-State: ANoB5pnotMrCZ8MeSLXsJNwo29+ECPBUMp9eWGkLdeHL4MIleSQaj+Pk
        ERwCNGkzNzmGbuRgjz26xlAhYwDKiQrEHg==
X-Google-Smtp-Source: AA0mqf4RnlZ/KtwJ3rHE7Dx7aAGiEuFbWA0GNH2Y/z3WoAtzaCmZH3/TxcxGcrdxUVDVaMDLbAbDwg==
X-Received: by 2002:a17:903:240b:b0:186:9fc5:6c2c with SMTP id e11-20020a170903240b00b001869fc56c2cmr38789710plo.174.1669754760921;
        Tue, 29 Nov 2022 12:46:00 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001887e30b9ddsm11216214plr.257.2022.11.29.12.45.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] client/player: Add support for custom preset
Date:   Tue, 29 Nov 2022 12:45:54 -0800
Message-Id: <20221129204556.1535821-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129204556.1535821-1-luiz.dentz@gmail.com>
References: <20221129204556.1535821-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for a custom preset which asks the user to enter its
configuration:

[bluetooth]# endpoint.presets 00002bc9-0000-1000-8000-00805f9b34fb custom
[Codec] Enter frequency: 0x08
[Codec] Enter frame duration: 0x01
[Codec] Enter channel allocation: 0x00000003
[Codec] Enter frame length: 100
[QoS] Enter SDU Interval: 10000
[QoS] Enter Framing: 0x00
[QoS] Enter PHY: 2M
[QoS] Enter Max SDU: 100
[QoS] Enter RTN: 2
[QoS] Enter Max Transport Latency: 20
[QoS] Enter Presentation Delay: 10000
---
 client/player.c | 305 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 261 insertions(+), 44 deletions(-)

diff --git a/client/player.c b/client/player.c
index 51c10f8e0a23..952b01e8236b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1231,7 +1231,6 @@ struct codec_preset {
 	const char *name;
 	const struct iovec data;
 	const struct codec_qos qos;
-	bool is_default;
 	uint8_t latency;
 };
 
@@ -1241,13 +1240,6 @@ struct codec_preset {
 		.data = _data, \
 	}
 
-#define SBC_DEFAULT_PRESET(_name, _data) \
-	{ \
-		.name = _name, \
-		.data = _data, \
-		.is_default = true, \
-	}
-
 static struct codec_preset sbc_presets[] = {
 	/* Table 4.7: Recommended sets of SBC parameters in the SRC device
 	 * Other settings: Block length = 16, Allocation method = Loudness,
@@ -1268,7 +1260,7 @@ static struct codec_preset sbc_presets[] = {
 		CODEC_DATA(0x28, 0x15, 2, SBC_BITPOOL_HQ_MONO_44100)),
 	SBC_PRESET("HQ_MONO_48",
 		CODEC_DATA(0x18, 0x15, 2, SBC_BITPOOL_HQ_MONO_48000)),
-	SBC_DEFAULT_PRESET("HQ_STEREO_44_1",
+	SBC_PRESET("HQ_STEREO_44_1",
 		CODEC_DATA(0x21, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_44100)),
 	SBC_PRESET("HQ_STEREO_48",
 		CODEC_DATA(0x11, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_48000)),
@@ -1379,15 +1371,6 @@ static struct codec_preset sbc_presets[] = {
 		.latency = 0x03, \
 	}
 
-#define LC3_DEFAULT_PRESET(_name, _data, _qos) \
-	{ \
-		.name = _name, \
-		.data = _data, \
-		.is_default = true, \
-		.qos = _qos, \
-		.latency = 0x02, \
-	}
-
 static struct codec_preset lc3_presets[] = {
 	/* Table 4.43: QoS configuration support setting requirements */
 	LC3_PRESET("8_1_1",
@@ -1399,7 +1382,7 @@ static struct codec_preset lc3_presets[] = {
 	LC3_PRESET("16_1_1",
 			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
 			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
-	LC3_DEFAULT_PRESET("16_2_1",
+	LC3_PRESET("16_2_1",
 			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
 			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
 	LC3_PRESET("24_1_1",
@@ -1465,22 +1448,26 @@ static struct codec_preset lc3_presets[] = {
 			LC3_10_UNFRAMED(155u, 23u, 60u, 40000u)),
 };
 
-#define PRESET(_uuid, _presets) \
+#define PRESET(_uuid, _presets, _default_index) \
 	{ \
 		.uuid = _uuid, \
+		.custom = { .name = "custom" }, \
+		.default_preset = &_presets[_default_index], \
 		.presets = _presets, \
 		.num_presets = ARRAY_SIZE(_presets), \
 	}
 
-static const struct preset {
+static struct preset {
 	const char *uuid;
+	struct codec_preset custom;
+	struct codec_preset *default_preset;
 	struct codec_preset *presets;
 	size_t num_presets;
 } presets[] = {
-	PRESET(A2DP_SOURCE_UUID, sbc_presets),
-	PRESET(A2DP_SINK_UUID, sbc_presets),
-	PRESET(PAC_SINK_UUID, lc3_presets),
-	PRESET(PAC_SOURCE_UUID, lc3_presets),
+	PRESET(A2DP_SOURCE_UUID, sbc_presets, 6),
+	PRESET(A2DP_SINK_UUID, sbc_presets, 6),
+	PRESET(PAC_SINK_UUID, lc3_presets, 3),
+	PRESET(PAC_SOURCE_UUID, lc3_presets, 3),
 };
 
 static struct codec_preset *find_preset(const char *uuid, const char *name)
@@ -1488,20 +1475,22 @@ static struct codec_preset *find_preset(const char *uuid, const char *name)
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(presets); i++) {
-		const struct preset *preset = &presets[i];
+		struct preset *preset = &presets[i];
 
 		if (!strcasecmp(preset->uuid, uuid)) {
 			size_t j;
 
+			if (!name)
+				return preset->default_preset;
+			else if (!strcmp(name, "custom"))
+				return &preset->custom;
+
 			for (j = 0; j < preset->num_presets; j++) {
 				struct codec_preset *p;
 
 				p = &preset->presets[j];
 
-				if (!name) {
-					if (p->is_default)
-						return p;
-				} else if (!strcmp(p->name, name))
+				if (!strcmp(p->name, name))
 					return p;
 			}
 		}
@@ -1724,10 +1713,11 @@ done:
 static struct iovec *iov_append(struct iovec **iov, const void *data,
 							size_t len)
 {
-	if (!*iov) {
+	if (!*iov)
 		*iov = new0(struct iovec, 1);
+
+	if (!((*iov)->iov_base))
 		(*iov)->iov_base = new0(uint8_t, UINT8_MAX);
-	}
 
 	if (data && len) {
 		memcpy((*iov)->iov_base + (*iov)->iov_len, data, len);
@@ -2348,6 +2338,224 @@ fail:
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void custom_delay(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+	char *endptr = NULL;
+
+	qos->delay = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void custom_latency(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+	char *endptr = NULL;
+
+	qos->latency = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_prompt_input("QoS", "Enter Presentation Delay:",
+					custom_delay, user_data);
+}
+
+static void custom_rtn(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+	char *endptr = NULL;
+
+	qos->rtn = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_prompt_input("QoS", "Enter Max Transport Latency:",
+					custom_latency, user_data);
+}
+
+static void custom_sdu(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+	char *endptr = NULL;
+
+	qos->sdu = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_prompt_input("QoS", "Enter RTN:", custom_rtn, user_data);
+}
+
+static void custom_phy(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+
+	if (!strcmp(input, "1M"))
+		qos->phy = "1M";
+	else if (!strcmp(input, "2M"))
+		qos->phy = "2M";
+	else {
+		char *endptr = NULL;
+		uint8_t phy = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0') {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		switch (phy) {
+		case 0x01:
+			qos->phy = "1M";
+			break;
+		case 0x02:
+			qos->phy = "2M";
+			break;
+		default:
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	bt_shell_prompt_input("QoS", "Enter Max SDU:", custom_sdu, user_data);
+}
+
+static void custom_framing(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+	char *endptr = NULL;
+
+	qos->framing = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_prompt_input("QoS", "Enter PHY:", custom_phy, user_data);
+}
+
+static void custom_interval(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct codec_qos *qos = (void *)&p->qos;
+	char *endptr = NULL;
+
+	qos->interval = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_prompt_input("QoS", "Enter Framing:",
+					custom_framing, user_data);
+}
+
+static void custom_length(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *iov = (void *)&p->data;
+	uint8_t ltv[4] = { 0x03, LC3_CONFIG_FRAME_LEN };
+	uint16_t len;
+	char *endptr = NULL;
+
+	len = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ltv[2] = len;
+	ltv[3] = len >> 8;
+
+	iov_append(&iov, ltv, sizeof(ltv));
+
+	bt_shell_prompt_input("QoS", "Enter SDU Interval:",
+					custom_interval, user_data);
+}
+
+static void custom_location(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *iov = (void *)&p->data;
+	uint32_t location;
+	char *endptr = NULL;
+
+	location = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Only add Channel Allocation if set */
+	if (location) {
+		uint8_t ltv[6] = { 0x05, LC3_CONFIG_CHAN_ALLOC };
+
+		location = cpu_to_le32(location);
+		memcpy(&ltv[2], &location, sizeof(location));
+		iov_append(&iov, ltv, sizeof(ltv));
+	}
+
+	bt_shell_prompt_input("Codec", "Enter frame length:",
+					custom_length, user_data);
+}
+
+static void custom_duration(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *iov = (void *)&p->data;
+	uint8_t ltv[3] = { 0x02, LC3_CONFIG_DURATION, 0x00 };
+	char *endptr = NULL;
+
+	ltv[2] = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	iov_append(&iov, ltv, sizeof(ltv));
+
+	bt_shell_prompt_input("Codec", "Enter channel allocation:",
+					custom_location, user_data);
+}
+
+static void custom_frequency(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *iov = (void *)&p->data;
+	uint8_t ltv[3] = { 0x02, LC3_CONFIG_FREQ, 0x00 };
+	char *endptr = NULL;
+
+	ltv[2] = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Reset iov to start over the codec configuration */
+	free(iov->iov_base);
+	iov->iov_base = NULL;
+	iov->iov_len = 0;
+	iov_append(&iov, ltv, sizeof(ltv));
+
+	bt_shell_prompt_input("Codec", "Enter frame duration:",
+					custom_duration, user_data);
+}
+
 static void cmd_presets_endpoint(int argc, char *argv[])
 {
 	size_t i;
@@ -2359,32 +2567,41 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 			bt_shell_printf("Preset %s not found\n", argv[2]);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
-
-		default_preset->is_default = true;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(presets); i++) {
-		const struct preset *preset = &presets[i];
+		struct preset *preset = &presets[i];
 
 		if (!strcasecmp(preset->uuid, argv[1])) {
 			size_t j;
+			struct codec_preset *p;
+
+			if (default_preset) {
+				preset->default_preset = default_preset;
+				break;
+			}
+
+			p = &preset->custom;
+
+			bt_shell_printf("%s%s\n", p == preset->default_preset ?
+						"*" : "", p->name);
 
 			for (j = 0; j < preset->num_presets; j++) {
-				struct codec_preset *p;
-
 				p = &preset->presets[j];
 
-				if (default_preset && p != default_preset)
-					p->is_default = false;
-
-				if (p->is_default)
-					bt_shell_printf("*%s\n", p->name);
-				else
-					bt_shell_printf("%s\n", p->name);
+				bt_shell_printf("%s%s\n",
+						p == preset->default_preset ?
+						"*" : "", p->name);
 			}
 		}
 	}
 
+	if (default_preset && !strcmp(default_preset->name, "custom")) {
+		bt_shell_prompt_input("Codec", "Enter frequency:",
+					custom_frequency, default_preset);
+		return;
+	}
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-- 
2.37.3

