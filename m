Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282EECDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377935AbjJTSIn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 14:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJTSIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 14:08:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7328D51
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 11:08:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso790341a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697825318; x=1698430118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWx5/DcIXZe+PMT+T7cEJe+SPzRjZhlFlFktx0kNpXY=;
        b=hJkQxbEX93hkynU97SBh+Cf5suWHBSu6qex9x82OCFvxQ4SVzTLIASixtnr++biR7u
         /RYEE+yzGfXciR+YYr94oiDlZnO9F/fBZrdZAFKqg0oIVBp78k4CFPZIG30ZMhEqEspv
         5k1KOppcflMUHI50d6dhQ2XxLmQG2HSox/M5cSyZj9dwygb+aQK/5LMP5KQhVnV/WOjN
         H+AHNuIUQiFUFByUA12G4XvxcyTeLg/x3Y9azM5iKlM1lRkL0igmYWSU5vMkiiVDpT0d
         RVt329UQxcvFWIlqdGGx1dlEh0fgJecpRLVe7/DM97yI9qj3NRo0hEii56yJ++T2ngAU
         +q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825318; x=1698430118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWx5/DcIXZe+PMT+T7cEJe+SPzRjZhlFlFktx0kNpXY=;
        b=vVOCXBoSzbALP9k46cNWWvt/TBhw5AP4SlriOEKBpV/oaFsXYjboHAPhkMIHeDEB/3
         KirFJzLO/If2MMrsQm6Qb/u2Lf42+Ro4qLkjr2Q3D+Y4HAZUHce8acAmFHwH6dUXGzma
         Or3Udm3PFi+lvQK5ndEOJD8rh6Bb5qvKq8G+HXn880rLkDm0yQGD/54e43zTa0vKL5Ie
         GoEFjz6rczti2S9j1VjewNx7S1V4wwKmXlrVeOlmrTLgy/uCnuQLhBuxt7bxJu4pV2DZ
         Er7spRB//9Q/EdNr05eaK2OVk8mZXE6CLkC4DYBGDDEL+tjFxJXI8JKFMpkTpq9siAE+
         9Vbw==
X-Gm-Message-State: AOJu0YzS+gu1UA6SUvPchrc3chUnGr8aWdai9mhmoKfcNvf4pxzo5smK
        ewD4MtI30Vx0qulj2l02LlEpt2JRbb+AwnR1HDI=
X-Google-Smtp-Source: AGHT+IGUzRO7S7WwPtVsdDVgjTPxDDn7UQ1fPl57XgtQTiJdHtBdkExkXdwAUf2WZSlXVKOnzF0kqw==
X-Received: by 2002:a17:90a:1947:b0:27c:f80a:2c8a with SMTP id 7-20020a17090a194700b0027cf80a2c8amr2852353pjh.0.1697825318488;
        Fri, 20 Oct 2023 11:08:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090ad34400b00263b9e75aecsm1729800pjx.41.2023.10.20.11.08.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:08:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] monitor: Make use of util_debug_tlv to decode TLV entries
Date:   Fri, 20 Oct 2023 11:08:32 -0700
Message-ID: <20231020180834.3010421-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020180834.3010421-1-luiz.dentz@gmail.com>
References: <20231020180834.3010421-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses util_debug_tlv to decode TLV entries.
---
 monitor/att.c    | 101 +++++++++++++++++++++++++++++------------------
 monitor/packet.c |  81 ++++++-------------------------------
 monitor/packet.h |  14 -------
 3 files changed, 75 insertions(+), 121 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 0e12ee352078..39ea5d6dac5a 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -675,8 +675,15 @@ static bool print_ase_codec(const struct l2cap_frame *frame)
 	return true;
 }
 
+static void print_ltv(const char *str, void *user_data)
+{
+	const char *label = user_data;
+
+	print_field("%s: %s", label, str);
+}
+
 static bool print_ase_lv(const struct l2cap_frame *frame, const char *label,
-			struct packet_ltv_decoder *decoder, size_t decoder_len)
+			struct util_ltv_debugger *decoder, size_t decoder_len)
 {
 	struct bt_hci_lv_data *lv;
 
@@ -691,13 +698,14 @@ static bool print_ase_lv(const struct l2cap_frame *frame, const char *label,
 		return false;
 	}
 
-	packet_print_ltv(label, lv->data, lv->len, decoder, decoder_len);
+	util_debug_ltv(lv->data, lv->len, decoder, decoder_len, print_ltv,
+			(void *) label);
 
 	return true;
 }
 
 static bool print_ase_cc(const struct l2cap_frame *frame, const char *label,
-			struct packet_ltv_decoder *decoder, size_t decoder_len)
+			struct util_ltv_debugger *decoder, size_t decoder_len)
 {
 	return print_ase_lv(frame, label, decoder, decoder_len);
 }
@@ -744,7 +752,8 @@ done:
 		print_hex_field("    Data", frame->data, frame->size);
 }
 
-static void ase_decode_preferred_context(const uint8_t *data, uint8_t len)
+static void ase_debug_preferred_context(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 
@@ -753,7 +762,8 @@ static void ase_decode_preferred_context(const uint8_t *data, uint8_t len)
 	print_context(&frame, "      Preferred Context");
 }
 
-static void ase_decode_context(const uint8_t *data, uint8_t len)
+static void ase_debug_context(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 
@@ -762,7 +772,8 @@ static void ase_decode_context(const uint8_t *data, uint8_t len)
 	print_context(&frame, "      Context");
 }
 
-static void ase_decode_program_info(const uint8_t *data, uint8_t len)
+static void ase_debug_program_info(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	const char *str;
@@ -782,7 +793,8 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-static void ase_decode_language(const uint8_t *data, uint8_t len)
+static void ase_debug_language(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint32_t value;
@@ -801,16 +813,17 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-struct packet_ltv_decoder ase_metadata_table[] = {
-	LTV_DEC(0x01, ase_decode_preferred_context),
-	LTV_DEC(0x02, ase_decode_context),
-	LTV_DEC(0x03, ase_decode_program_info),
-	LTV_DEC(0x04, ase_decode_language)
+struct util_ltv_debugger ase_metadata_table[] = {
+	UTIL_LTV_DEBUG(0x01, ase_debug_preferred_context),
+	UTIL_LTV_DEBUG(0x02, ase_debug_context),
+	UTIL_LTV_DEBUG(0x03, ase_debug_program_info),
+	UTIL_LTV_DEBUG(0x04, ase_debug_language)
 };
 
 static bool print_ase_metadata(const struct l2cap_frame *frame)
 {
-	return print_ase_lv(frame, "    Metadata", NULL, 0);
+	return print_ase_lv(frame, "    Metadata", ase_metadata_table,
+					ARRAY_SIZE(ase_metadata_table));
 }
 
 static const struct bitfield_data pac_freq_table[] = {
@@ -833,7 +846,8 @@ static const struct bitfield_data pac_freq_table[] = {
 	{ }
 };
 
-static void pac_decode_freq(const uint8_t *data, uint8_t len)
+static void pac_decode_freq(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint16_t value;
@@ -870,7 +884,8 @@ static const struct bitfield_data pac_duration_table[] = {
 	{ }
 };
 
-static void pac_decode_duration(const uint8_t *data, uint8_t len)
+static void pac_decode_duration(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint8_t value;
@@ -907,7 +922,8 @@ static const struct bitfield_data pac_channel_table[] = {
 	{ }
 };
 
-static void pac_decode_channels(const uint8_t *data, uint8_t len)
+static void pac_decode_channels(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint8_t value;
@@ -932,7 +948,8 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-static void pac_decode_frame_length(const uint8_t *data, uint8_t len)
+static void pac_decode_frame_length(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint16_t min, max;
@@ -957,7 +974,8 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-static void pac_decode_sdu(const uint8_t *data, uint8_t len)
+static void pac_decode_sdu(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint8_t value;
@@ -976,12 +994,12 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-struct packet_ltv_decoder pac_cap_table[] = {
-	LTV_DEC(0x01, pac_decode_freq),
-	LTV_DEC(0x02, pac_decode_duration),
-	LTV_DEC(0x03, pac_decode_channels),
-	LTV_DEC(0x04, pac_decode_frame_length),
-	LTV_DEC(0x05, pac_decode_sdu)
+struct util_ltv_debugger pac_cap_table[] = {
+	UTIL_LTV_DEBUG(0x01, pac_decode_freq),
+	UTIL_LTV_DEBUG(0x02, pac_decode_duration),
+	UTIL_LTV_DEBUG(0x03, pac_decode_channels),
+	UTIL_LTV_DEBUG(0x04, pac_decode_frame_length),
+	UTIL_LTV_DEBUG(0x05, pac_decode_sdu)
 };
 
 static void print_pac(const struct l2cap_frame *frame)
@@ -1117,7 +1135,8 @@ static bool print_ase_pd(const struct l2cap_frame *frame, const char *label)
 	return true;
 }
 
-static void ase_decode_freq(const uint8_t *data, uint8_t len)
+static void ase_debug_freq(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint8_t value;
@@ -1179,7 +1198,8 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-static void ase_decode_duration(const uint8_t *data, uint8_t len)
+static void ase_debug_duration(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint8_t value;
@@ -1266,7 +1286,8 @@ done:
 		print_hex_field("  Data", frame->data, frame->size);
 }
 
-static void ase_decode_location(const uint8_t *data, uint8_t len)
+static void ase_debug_location(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 
@@ -1275,7 +1296,8 @@ static void ase_decode_location(const uint8_t *data, uint8_t len)
 	print_location(&frame);
 }
 
-static void ase_decode_frame_length(const uint8_t *data, uint8_t len)
+static void ase_debug_frame_length(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint16_t value;
@@ -1294,7 +1316,8 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-static void ase_decode_blocks(const uint8_t *data, uint8_t len)
+static void ase_debug_blocks(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
 {
 	struct l2cap_frame frame;
 	uint8_t value;
@@ -1313,12 +1336,12 @@ done:
 		print_hex_field("    Data", frame.data, frame.size);
 }
 
-struct packet_ltv_decoder ase_cc_table[] = {
-	LTV_DEC(0x01, ase_decode_freq),
-	LTV_DEC(0x02, ase_decode_duration),
-	LTV_DEC(0x03, ase_decode_location),
-	LTV_DEC(0x04, ase_decode_frame_length),
-	LTV_DEC(0x05, ase_decode_blocks)
+struct util_ltv_debugger ase_cc_table[] = {
+	UTIL_LTV_DEBUG(0x01, ase_debug_freq),
+	UTIL_LTV_DEBUG(0x02, ase_debug_duration),
+	UTIL_LTV_DEBUG(0x03, ase_debug_location),
+	UTIL_LTV_DEBUG(0x04, ase_debug_frame_length),
+	UTIL_LTV_DEBUG(0x05, ase_debug_blocks)
 };
 
 static void print_ase_config(const struct l2cap_frame *frame)
@@ -2745,8 +2768,9 @@ static const struct big_enc_decoder {
 };
 
 static bool print_subgroup_lv(const struct l2cap_frame *frame,
-		const char *label, struct packet_ltv_decoder *decoder,
-		size_t decoder_len)
+				const char *label,
+				struct util_ltv_debugger *debugger,
+				size_t debugger_len)
 {
 	struct bt_hci_lv_data *lv;
 
@@ -2761,7 +2785,8 @@ static bool print_subgroup_lv(const struct l2cap_frame *frame,
 		return false;
 	}
 
-	packet_print_ltv(label, lv->data, lv->len, decoder, decoder_len);
+	util_debug_ltv(lv->data, lv->len, debugger, debugger_len,
+			       print_ltv, (void *)label);
 
 	return true;
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index 30ffe79c6c09..87805be0122a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3419,72 +3419,11 @@ static void *iov_pull(struct iovec *iov, size_t len)
 	return data;
 }
 
-static struct packet_ltv_decoder*
-get_ltv_decoder(struct packet_ltv_decoder *decoder, size_t num, uint8_t type)
+static void print_ltv(const char *str, void *user_data)
 {
-	size_t i;
+	const char *label = user_data;
 
-	if (!decoder || !num)
-		return NULL;
-
-	for (i = 0; i < num; i++) {
-		struct packet_ltv_decoder *dec = &decoder[i];
-
-		if (dec->type == type)
-			return dec;
-	}
-
-	return NULL;
-}
-
-static void print_ltv(const char *label, const uint8_t *data, uint8_t len,
-			struct packet_ltv_decoder *decoder, size_t num)
-{
-	struct iovec iov;
-	int i;
-
-	iov.iov_base = (void *) data;
-	iov.iov_len = len;
-
-	for (i = 0; iov.iov_len; i++) {
-		uint8_t l, t, *v;
-		struct packet_ltv_decoder *dec;
-
-		l = get_u8(iov_pull(&iov, sizeof(l)));
-		if (!l) {
-			print_field("%s #%d: len 0x%02x", label, i, l);
-			break;
-		}
-
-		v = iov_pull(&iov, sizeof(*v));
-		if (!v)
-			break;
-
-		t = get_u8(v);
-
-		print_field("%s #%d: len 0x%02x type 0x%02x", label, i, l, t);
-
-		l -= 1;
-
-		v = iov_pull(&iov, l);
-		if (!v)
-			break;
-
-		dec = get_ltv_decoder(decoder, num, t);
-		if (dec)
-			dec->func(v, l);
-		else
-			print_hex_field(label, v, l);
-	}
-
-	if (iov.iov_len)
-		print_hex_field(label, iov.iov_base, iov.iov_len);
-}
-
-void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len,
-			struct packet_ltv_decoder *decoder, size_t decoder_len)
-{
-	print_ltv(label, data, len, decoder, decoder_len);
+	print_field("%s: %s", label, str);
 }
 
 static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
@@ -3510,6 +3449,7 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		struct bt_hci_lv_data *codec_cfg;
 		struct bt_hci_lv_data *metadata;
 		uint8_t j;
+		const char *label;
 
 		print_field("    Subgroup #%u:", i);
 
@@ -3537,9 +3477,10 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		if (!iov_pull(&iov, codec_cfg->len))
 			goto done;
 
-		print_ltv("    Codec Specific Configuration",
-					codec_cfg->data, codec_cfg->len,
-					NULL, 0);
+		label = "    Codec Specific Configuration";
+
+		util_debug_ltv(codec_cfg->data, codec_cfg->len, NULL, 0,
+				print_ltv, (void *)label);
 
 		metadata = iov_pull(&iov, sizeof(*metadata));
 		if (!metadata)
@@ -3548,8 +3489,10 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		if (!iov_pull(&iov, metadata->len))
 			goto done;
 
-		print_ltv("    Metadata", metadata->data, metadata->len,
-					NULL, 0);
+		label = "    Metadata";
+
+		util_debug_ltv(metadata->data, metadata->len, NULL, 0,
+				print_ltv, (void *)label);
 
 		/* Level 3 - BIS(s)*/
 		for (j = 0; j < subgroup->num_bis; j++) {
diff --git a/monitor/packet.h b/monitor/packet.h
index 384f460d2f58..856f74f4db16 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -84,20 +84,6 @@ void packet_print_io_capability(uint8_t capability);
 void packet_print_io_authentication(uint8_t authentication);
 void packet_print_codec_id(const char *label, uint8_t codec);
 
-#define LTV_DEC(_type, _func) \
-{ \
-	.type = _type, \
-	.func = _func, \
-}
-
-struct packet_ltv_decoder {
-	uint8_t  type;
-	void (*func)(const uint8_t *data, uint8_t len);
-};
-
-void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len,
-			struct packet_ltv_decoder *decoder, size_t num);
-
 void packet_control(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size);
-- 
2.41.0

