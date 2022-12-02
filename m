Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D248C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLBAvC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiLBAu6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:50:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C168C727A
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:50:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h33so3098618pgm.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUAQSZERFxp8IYQerum7wOJO5thO+VoEy0ZSZltlmNk=;
        b=RNSTqUSOkPYfLL1AuJGsz9/yHcID9U/weCYYBBBwZlseAot72GU1uSHTlO2eqWXHR/
         zXaqJozyWqqJp4EPfF+AvC22ycVAHkpfPus8LfpHPyrot2Qk0i4ohABJljwuGH6qPIdI
         MIISCYGJsypE9GJJpsBEL05lYvOKVPpbZplwxKnbjnWWy6fLQOFfZ7N6axQDnWIy6Pmv
         NKOUJg7IDifgoF8SWHSLjvrX1idyeeArzLBXgD09yEIqMC0LxrP7T1WGyQfSsjXqs1iu
         34oBca4HOZbW1daSZsX59cqN1KapGWC5+Q96XahyAFC9cZnq3dKsDXvL/H8IHNGrD2b+
         2KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUAQSZERFxp8IYQerum7wOJO5thO+VoEy0ZSZltlmNk=;
        b=w6Ga6cb603isViNpQLP9FIUnPLDAhj26N139jumrlVds59vsERRGjOF61MV7f5wLKX
         hPUifonxBKKQB1zjNDxsuRRvmaUkXYOm8TNJ3lCf7rQtO5oPjt2Je5YUPX1EcEjFEs4z
         XHcVhi8imlREm0BAJPsCL9ZBGblK5CNdoByEvJaAuQrf7ijCP82jIXNpnTgEGKHcmsZG
         zP++hKvr+k5/g3nV2XgKu0/awgUotfeFqjGZrorhN+JKj3BfpdL4lI4GPxRCRu8L3psC
         ygX3xyU2s5oa68MHQwI2yw+8E4+VB8yS4HCFld8vi9bh1TU+DtrmK+xSGtEzOYLViV4n
         R/ZA==
X-Gm-Message-State: ANoB5plj4cWY1BD0IzORGtV5p5EgtlatG3chwYfaRt5PCAEiKLyMw4tS
        8Lxtrtq4A3SMt6HqShQ57BNbnhW1vFGDig==
X-Google-Smtp-Source: AA0mqf4UXbUpNAnULWJV515q6J4YoAPUCdIFSSyEd5p05VkbW4tqe9tD0if0MsBAmA3vvg3IfHSD0A==
X-Received: by 2002:a63:4449:0:b0:477:a5e2:7b78 with SMTP id t9-20020a634449000000b00477a5e27b78mr41283836pgk.322.1669942255733;
        Thu, 01 Dec 2022 16:50:55 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:50:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/8] client/player: Add support for custom preset
Date:   Thu,  1 Dec 2022 16:50:46 -0800
Message-Id: <20221202005051.2401504-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for a custom preset which asks the user to enter its
configuration:

[bluetooth]# endpoint.presets 00002bc9-0000-1000-8000-00805f9b34fb custom
[Codec] Enter frequency (Khz): 48
[Codec] Enter frame duration (ms): 10
[Codec] Enter channel allocation: 0x000000003
[Codec] Enter frame length: 100
[QoS] Enter Target Latency (Low, Balance, High): Low
[QoS] Enter SDU Interval (us): 10000
[QoS] Enter Framing (Unframed, Framed): Unframed
[QoS] Enter PHY (1M, 2M): 2M
[QoS] Enter Max SDU: 200
[QoS] Enter RTN: 3
[QoS] Enter Max Transport Latency (ms): 20
[QoS] Enter Presentation Delay (us): 10000
---
 client/player.c | 414 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 366 insertions(+), 48 deletions(-)

diff --git a/client/player.c b/client/player.c
index 51c10f8e0a23..92b2b7a47eaf 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1231,8 +1231,7 @@ struct codec_preset {
 	const char *name;
 	const struct iovec data;
 	const struct codec_qos qos;
-	bool is_default;
-	uint8_t latency;
+	uint8_t target_latency;
 };
 
 #define SBC_PRESET(_name, _data) \
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
@@ -1368,7 +1360,7 @@ static struct codec_preset sbc_presets[] = {
 		.name = _name, \
 		.data = _data, \
 		.qos = _qos, \
-		.latency = 0x02, \
+		.target_latency = 0x02, \
 	}
 
 #define LC3_PRESET_HR(_name, _data, _qos) \
@@ -1376,16 +1368,7 @@ static struct codec_preset sbc_presets[] = {
 		.name = _name, \
 		.data = _data, \
 		.qos = _qos, \
-		.latency = 0x03, \
-	}
-
-#define LC3_DEFAULT_PRESET(_name, _data, _qos) \
-	{ \
-		.name = _name, \
-		.data = _data, \
-		.is_default = true, \
-		.qos = _qos, \
-		.latency = 0x02, \
+		.target_latency = 0x03, \
 	}
 
 static struct codec_preset lc3_presets[] = {
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
@@ -1757,7 +1747,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 
 	/* Copy capabilities */
 	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
-	cfg->target_latency = preset->latency;
+	cfg->target_latency = preset->target_latency;
 
 	if (preset->qos.phy)
 		/* Set QoS parameters */
@@ -2348,6 +2338,325 @@ fail:
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
+	bt_shell_prompt_input("QoS", "Enter Presentation Delay (us):",
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
+	bt_shell_prompt_input("QoS", "Enter Max Transport Latency (ms):",
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
+
+	if (!strcasecmp(input, "Unframed"))
+		qos->framing = 0x00;
+	else if (!strcasecmp(input, "Framed"))
+		qos->framing = 0x01;
+	else {
+		char *endptr = NULL;
+
+		qos->framing = strtol(input, &endptr, 0);
+		if (!endptr || *endptr != '\0') {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	bt_shell_prompt_input("QoS", "Enter PHY (1M, 2M):", custom_phy,
+							user_data);
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
+	bt_shell_prompt_input("QoS", "Enter Framing (Unframed, Framed):",
+				custom_framing, user_data);
+}
+
+static void custom_target_latency(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+
+	if (!strcasecmp(input, "Low"))
+		p->target_latency = 0x01;
+	else if (!strcasecmp(input, "Balance"))
+		p->target_latency = 0x02;
+	else if (!strcasecmp(input, "High"))
+		p->target_latency = 0x02;
+	else {
+		char *endptr = NULL;
+
+		p->target_latency = strtol(input, &endptr, 0);
+		if (!endptr || *endptr != '\0') {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	bt_shell_prompt_input("QoS", "Enter SDU Interval (us):",
+					custom_interval, user_data);
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
+	bt_shell_prompt_input("QoS", "Enter Target Latency "
+				"(Low, Balance, High):",
+				custom_target_latency, user_data);
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
+static uint8_t val2duration(uint32_t val)
+{
+	switch (val) {
+	case 7:
+		return 0x00;
+	case 10:
+		return 0x01;
+	default:
+		return 0xff;
+	}
+}
+
+static void custom_duration(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *iov = (void *)&p->data;
+	uint8_t ltv[3] = { 0x02, LC3_CONFIG_DURATION, 0x00 };
+	char *endptr = NULL;
+	uint32_t val;
+
+	val = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (strncmp(input, "0x", 2))
+		ltv[2] = val2duration(val);
+	else
+		ltv[2] = val;
+
+	if (ltv[2] == 0xff) {
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
+static uint8_t val2freq(uint32_t val)
+{
+	switch (val) {
+	case 8:
+		return 0x01;
+	case 11:
+		return 0x02;
+	case 16:
+		return 0x03;
+	case 22:
+		return 0x04;
+	case 24:
+		return 0x05;
+	case 32:
+		return 0x06;
+	case 44:
+		return 0x07;
+	case 48:
+		return 0x08;
+	case 88:
+		return 0x09;
+	case 96:
+		return 0x0a;
+	case 174:
+		return 0x0b;
+	case 192:
+		return 0x0c;
+	case 384:
+		return 0x0d;
+	default:
+		return 0x00;
+	}
+}
+
+static void custom_frequency(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *iov = (void *)&p->data;
+	uint8_t ltv[3] = { 0x02, LC3_CONFIG_FREQ, 0x00 };
+	uint32_t val;
+	char *endptr = NULL;
+
+	val = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (strncmp(input, "0x", 2))
+		ltv[2] = val2freq(val);
+	else
+		ltv[2] = val;
+
+	if (!ltv[2]) {
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
+	bt_shell_prompt_input("Codec", "Enter frame duration (ms):",
+				custom_duration, user_data);
+}
+
 static void cmd_presets_endpoint(int argc, char *argv[])
 {
 	size_t i;
@@ -2359,32 +2668,41 @@ static void cmd_presets_endpoint(int argc, char *argv[])
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
+		bt_shell_prompt_input("Codec", "Enter frequency (Khz):",
+					custom_frequency, default_preset);
+		return;
+	}
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-- 
2.37.3

