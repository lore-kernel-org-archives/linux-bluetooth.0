Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D9DCCA47A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 00:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378557AbiFQAuH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQAuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 20:50:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2762215
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso2899543pjk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CxF447mlSLUxV7Ha3XHfQCmc7Z5Nb0LFmJmey9zuRZ4=;
        b=WlG5hbeAVpKNNgGHaI6IGUqavNENot8TG9z03T4EQ9+3o7xUh81y+R/wPikz3RsKCG
         5fvrHyyCPNsx6bALqKq47WAEzAgPLfT80lnhYE8+XscHCEfoZJPzWj1hPJ7vDOvzsGZ5
         nhYvCA3bivOWYqtpEtd+Xz8iyDaageyAmshIhyDlP6SDkPg3ry/uxpPBYk9m+wR4yT5X
         BYOgDgLX0OZiJYqcfLiiwkkFeolsNrSriFKkoNzDmIpO42dmE4YPuVipDv8ZNVKwucFN
         d0XiQcXGKPjLsz3imMRgnIbfEw6HqVy5FULCbM+dis+FLEwhI20mWHw9dJGRz8XVRieJ
         5Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxF447mlSLUxV7Ha3XHfQCmc7Z5Nb0LFmJmey9zuRZ4=;
        b=WqTfjmZUZ0+KFYvhlnk/lUqTY3ESj+RmhchplZsO5SiBP0zV9AeSo9R+PsgvmQHCVV
         hTjFMxGQYH5O41jO/oHYqkx4tAPGwqcCELAGrSfhZyIKmDHfpOtLpwBSGBEMNbynhYpt
         WHLW2CPZsvG48l4nFmPRTdKD1xcFI0KBrM/5+R9U587oIVInUJdri1yCd09O8ZNH5QEN
         osyY3LJaQtn/yyE9wDXkG4jarIY1+0gi43x0Pe/O1aGu+JnAcadFNormLUUXVni16KeY
         kTJgu6zGVb3C5iNUc1XJ4zVk2bc7FWgIe4Y83GqU8NOBiB3IHw09N+bnq0nVtD7sL78o
         YJ1g==
X-Gm-Message-State: AJIora+SzKlXdyuEEWl0lYoCDaOFqnmFT1zDpCLnGVI3zfzw/z2ya5wJ
        U0F6dVe6z62MF3pUrglGva/+m1ZT0Cg=
X-Google-Smtp-Source: AGRyM1tzi890asZdPGTdFZvRH41Gb5tdICp9Is4QBS3FJqLWabl0LjoLUJ84EugkzSWc0WZcoBTnRQ==
X-Received: by 2002:a17:90b:4b49:b0:1e6:8827:aaf1 with SMTP id mi9-20020a17090b4b4900b001e68827aaf1mr7766957pjb.154.1655427002896;
        Thu, 16 Jun 2022 17:50:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u23-20020a170902a61700b0015e8d4eb25asm338996plq.164.2022.06.16.17.50.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:50:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] monitor/att: Add LTV deconding support for PAC/ASE
Date:   Thu, 16 Jun 2022 17:49:57 -0700
Message-Id: <20220617004957.1148939-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617004957.1148939-1-luiz.dentz@gmail.com>
References: <20220617004957.1148939-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for PAC/ASE attributes:

> ACL Data RX: Handle 42 flags 0x02 dlen 31
      Channel: 65 len 27 sdu 25 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 24
        Value: 010600000000100301ff0002020302030305041e00f00000
          Number of PAC(s): 1
          PAC #0:
            Codec: LC3 (0x06)
            Codec Specific Capabilities #0: len 0x03 type 0x01
              Sampling Frequencies: 0x00ff
                8 Khz (0x0001)
                11.25 Khz (0x0002)
                16 Khz (0x0004)
                22.05 Khz (0x0008)
                24 Khz (0x0010)
                32 Khz (0x0020)
                44.1 Khz (0x0040)
                48 Khz (0x0080)
            Codec Specific Capabilities #1: len 0x02 type 0x02
              Frame Duration: 0x0003
                7.5 ms (0x01)
                10 ms (0x02)
            Codec Specific Capabilities #2: len 0x02 type 0x03
              Audio Channel Count: 0x03
                1 channel (0x01)
                2 channels (0x02)
            Codec Specific Capabilities #3: len 0x05 type 0x04
              Frame Length: 30 (0x001e) - 240 (0x00f0)
> ACL Data RX: Handle 42 flags 0x02 dlen 30
      Channel: 64 len 26 sdu 24 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}
      ATT: Write Command (0x52) len 23
        Handle: 0x0036 Type: ASE Control Point (0x2bc6)
          Data: 010101020206000000000a02010302020103042800
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x01
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration #0: len 0x02 type 0x01
            Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration #1: len 0x02 type 0x02
            Frame Duration: 10 ms (0x01)
            Codec Specific Configuration #2: len 0x03 type 0x04
            Frame Length: 40 (0x0028)
---
 monitor/att.c    | 591 +++++++++++++++++++++++++++++++++++++++--------
 monitor/packet.c |  39 +++-
 monitor/packet.h |  15 +-
 3 files changed, 547 insertions(+), 98 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 21fa5dde3..7ab97c286 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -279,7 +279,8 @@ static bool print_ase_codec(const struct l2cap_frame *frame)
 	return true;
 }
 
-static bool print_ase_lv(const struct l2cap_frame *frame, const char *label)
+static bool print_ase_lv(const struct l2cap_frame *frame, const char *label,
+			struct packet_ltv_decoder *decoder, size_t decoder_len)
 {
 	struct bt_hci_lv_data *lv;
 
@@ -294,21 +295,299 @@ static bool print_ase_lv(const struct l2cap_frame *frame, const char *label)
 		return false;
 	}
 
-	packet_print_ltv(label, lv->data, lv->len);
+	packet_print_ltv(label, lv->data, lv->len, decoder, decoder_len);
 
 	return true;
 }
 
-static bool print_ase_cc(const struct l2cap_frame *frame)
+static bool print_ase_cc(const struct l2cap_frame *frame, const char *label,
+			struct packet_ltv_decoder *decoder, size_t decoder_len)
 {
-	return print_ase_lv(frame, "    Codec Specific Configuration");
+	return print_ase_lv(frame, label, decoder, decoder_len);
 }
 
+static const struct bitfield_data pac_context_table[] = {
+	{  0, "Unspecified (0x0001)"			},
+	{  1, "Conversational (0x0002)"			},
+	{  2, "Media (0x0004)"				},
+	{  3, "Game (0x0008)"				},
+	{  4, "Instructional (0x0010)"			},
+	{  5, "Voice Assistants (0x0020)"		},
+	{  6, "Live (0x0040)"				},
+	{  7, "Sound Effects (0x0080)"			},
+	{  8, "Notifications (0x0100)"			},
+	{  9, "Ringtone (0x0200)"			},
+	{  10, "Alerts (0x0400)"			},
+	{  11, "Emergency alarm (0x0800)"		},
+	{  12, "RFU (0x1000)"				},
+	{  13, "RFU (0x2000)"				},
+	{  14, "RFU (0x4000)"				},
+	{  15, "RFU (0x8000)"				},
+	{ }
+};
+
+static void print_context(const struct l2cap_frame *frame, const char *label)
+{
+	uint16_t value;
+	uint16_t mask;
+
+	if (!l2cap_frame_get_le16((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("%s: 0x%4.4x", label, value);
+
+	mask = print_bitfield(8, value, pac_context_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("    Data", frame->data, frame->size);
+}
+
+static void ase_decode_preferred_context(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	print_context(&frame, "      Preferred Context");
+}
+
+static void ase_decode_context(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	print_context(&frame, "      Context");
+}
+
+static void ase_decode_program_info(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	const char *str;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	str = l2cap_frame_pull(&frame, &frame, len);
+	if (!str) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Program Info: %s", str);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static void ase_decode_language(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint32_t value;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_le24(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Language: 0x%6.6x", value);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+struct packet_ltv_decoder ase_metadata_table[] = {
+	LTV_DEC(0x01, ase_decode_preferred_context),
+	LTV_DEC(0x02, ase_decode_context),
+	LTV_DEC(0x03, ase_decode_program_info),
+	LTV_DEC(0x04, ase_decode_language)
+};
+
 static bool print_ase_metadata(const struct l2cap_frame *frame)
 {
-	return print_ase_lv(frame, "    Metadata");
+	return print_ase_lv(frame, "    Metadata", NULL, 0);
 }
 
+static const struct bitfield_data pac_freq_table[] = {
+	{  0, "8 Khz (0x0001)"				},
+	{  1, "11.25 Khz (0x0002)"			},
+	{  2, "16 Khz (0x0004)"				},
+	{  3, "22.05 Khz (0x0008)"			},
+	{  4, "24 Khz (0x0010)"				},
+	{  5, "32 Khz (0x0020)"				},
+	{  6, "44.1 Khz (0x0040)"			},
+	{  7, "48 Khz (0x0080)"				},
+	{  8, "88.2 Khz (0x0100)"			},
+	{  9, "96 Khz (0x0200)"				},
+	{  10, "176.4 Khz (0x0400)"			},
+	{  11, "192 Khz (0x0800)"			},
+	{  12, "384 Khz (0x1000)"			},
+	{  13, "RFU (0x2000)"				},
+	{  14, "RFU (0x4000)"				},
+	{  15, "RFU (0x8000)"				},
+	{ }
+};
+
+static void pac_decode_freq(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint16_t value;
+	uint16_t mask;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_le16(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Sampling Frequencies: 0x%4.4x", value);
+
+	mask = print_bitfield(8, value, pac_freq_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+								mask);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static const struct bitfield_data pac_duration_table[] = {
+	{  0, "7.5 ms (0x01)"				},
+	{  1, "10 ms (0x02)"				},
+	{  2, "RFU (0x04)"				},
+	{  3, "RFU (0x08)"				},
+	{  4, "7.5 ms preferred (0x10)"			},
+	{  5, "10 ms preferred (0x20)"			},
+	{  6, "RFU (0x40)"				},
+	{  7, "RFU (0x80)"				},
+	{ }
+};
+
+static void pac_decode_duration(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint8_t value;
+	uint8_t mask;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_u8(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Frame Duration: 0x%4.4x", value);
+
+	mask = print_bitfield(8, value, pac_duration_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static const struct bitfield_data pac_channel_table[] = {
+	{  0, "1 channel (0x01)"			},
+	{  1, "2 channels (0x02)"			},
+	{  2, "3 channels (0x04)"			},
+	{  3, "4 chanenls (0x08)"			},
+	{  4, "5 channels (0x10)"			},
+	{  5, "6 channels (0x20)"			},
+	{  6, "7 channels (0x40)"			},
+	{  7, "8 channels (0x80)"			},
+	{ }
+};
+
+static void pac_decode_channels(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint8_t value;
+	uint8_t mask;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_u8(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Audio Channel Count: 0x%2.2x", value);
+
+	mask = print_bitfield(8, value, pac_channel_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static void pac_decode_frame_length(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint16_t min, max;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_le16(&frame, &min)) {
+		print_text(COLOR_ERROR, "    min: invalid size");
+		goto done;
+	}
+
+	if (!l2cap_frame_get_le16(&frame, &max)) {
+		print_text(COLOR_ERROR, "    min: invalid size");
+		goto done;
+	}
+
+	print_field("      Frame Length: %u (0x%4.4x) - %u (0x%4.4x)",
+							min, min, max, max);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static void pac_decode_sdu(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint8_t value;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_u8(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Max SDU: %u (0x%2.2x)", value, value);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+struct packet_ltv_decoder pac_cap_table[] = {
+	LTV_DEC(0x01, pac_decode_freq),
+	LTV_DEC(0x02, pac_decode_duration),
+	LTV_DEC(0x03, pac_decode_channels),
+	LTV_DEC(0x04, pac_decode_frame_length),
+	LTV_DEC(0x05, pac_decode_sdu)
+};
+
 static void print_pac(const struct l2cap_frame *frame)
 {
 	uint8_t num = 0, i;
@@ -326,7 +605,8 @@ static void print_pac(const struct l2cap_frame *frame)
 		if (!print_ase_codec(frame))
 			goto done;
 
-		if (!print_ase_cc(frame))
+		if (!print_ase_cc(frame, "    Codec Specific Capabilities",
+				pac_cap_table, ARRAY_SIZE(pac_cap_table)))
 			break;
 
 		if (!print_ase_metadata(frame))
@@ -441,6 +721,210 @@ static bool print_ase_pd(const struct l2cap_frame *frame, const char *label)
 	return true;
 }
 
+static void ase_decode_freq(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint8_t value;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_u8(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	switch (value) {
+	case 0x01:
+		print_field("      Sampling Frequency: 8 Khz (0x01)");
+		break;
+	case 0x02:
+		print_field("      Sampling Frequency: 11.25 Khz (0x02)");
+		break;
+	case 0x03:
+		print_field("      Sampling Frequency: 16 Khz (0x03)");
+		break;
+	case 0x04:
+		print_field("      Sampling Frequency: 22.05 Khz (0x04)");
+		break;
+	case 0x05:
+		print_field("      Sampling Frequency: 24 Khz (0x04)");
+		break;
+	case 0x06:
+		print_field("      Sampling Frequency: 32 Khz (0x04)");
+		break;
+	case 0x07:
+		print_field("      Sampling Frequency: 44.1 Khz (0x04)");
+		break;
+	case 0x08:
+		print_field("      Sampling Frequency: 48 Khz (0x04)");
+		break;
+	case 0x09:
+		print_field("      Sampling Frequency: 88.2 Khz (0x04)");
+		break;
+	case 0x0a:
+		print_field("      Sampling Frequency: 96 Khz (0x04)");
+		break;
+	case 0x0b:
+		print_field("      Sampling Frequency: 176.4 Khz (0x04)");
+		break;
+	case 0x0c:
+		print_field("      Sampling Frequency: 192 Khz (0x04)");
+		break;
+	case 0x0d:
+		print_field("      Sampling Frequency: 384 Khz (0x04)");
+		break;
+	default:
+		print_field("      Sampling Frequency: RFU (0x%2.2x)", value);
+		break;
+	}
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static void ase_decode_duration(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint8_t value;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_u8(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	switch (value) {
+	case 0x00:
+		print_field("      Frame Duration: 7.5 ms (0x00)");
+		break;
+	case 0x01:
+		print_field("      Frame Duration: 10 ms (0x01)");
+		break;
+	default:
+		print_field("      Frame Duration: RFU (0x%2.2x)", value);
+		break;
+	}
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static const struct bitfield_data channel_location_table[] = {
+	{  0, "Front Left (0x00000001)"			},
+	{  1, "Front Right (0x00000002)"		},
+	{  2, "Front Center (0x00000004)"		},
+	{  3, "Low Frequency Effects 1 (0x00000008)"	},
+	{  4, "Back Left (0x00000010)"			},
+	{  5, "Back Right (0x00000020)"			},
+	{  6, "Front Left of Center (0x00000040)"	},
+	{  7, "Front Right of Center (0x00000080)"	},
+	{  8, "Back Center (0x00000100)"		},
+	{  9, "Low Frequency Effects 2 (0x00000200)"	},
+	{  10, "Side Left (0x00000400)"			},
+	{  11, "Side Right (0x00000800)"		},
+	{  12, "Top Front Left (0x00001000)"		},
+	{  13, "Top Front Right (0x00002000)"		},
+	{  14, "Top Front Center (0x00004000)"		},
+	{  15, "Top Center (0x00008000)"		},
+	{  16, "Top Back Left (0x00010000)"		},
+	{  17, "Top Back Right (0x00020000)"		},
+	{  18, "Top Side Left (0x00040000)"		},
+	{  19, "Top Side Right (0x00080000)"		},
+	{  20, "Top Back Center (0x00100000)"		},
+	{  21, "Bottom Front Center (0x00200000)"	},
+	{  22, "Bottom Front Left (0x00400000)"		},
+	{  23, "Bottom Front Right (0x00800000)"	},
+	{  24, "Front Left Wide (0x01000000)"		},
+	{  25, "Front Right Wide (0x02000000)"		},
+	{  26, "Left Surround (0x04000000)"		},
+	{  27, "Right Surround (0x08000000)"		},
+	{  28, "RFU (0x10000000)"			},
+	{  29, "RFU (0x20000000)"			},
+	{  30, "RFU (0x40000000)"			},
+	{  31, "RFU (0x80000000)"			},
+	{ }
+};
+
+static void print_location(const struct l2cap_frame *frame)
+{
+	uint32_t value;
+	uint32_t mask;
+
+	if (!l2cap_frame_get_le32((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("   Location: 0x%8.8x", value);
+
+	mask = print_bitfield(6, value, channel_location_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%8.8x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void ase_decode_location(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	print_location(&frame);
+}
+
+static void ase_decode_frame_length(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint16_t value;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_le16(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Frame Length: %u (0x%4.4x)", value, value);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+static void ase_decode_blocks(const uint8_t *data, uint8_t len)
+{
+	struct l2cap_frame frame;
+	uint8_t value;
+
+	l2cap_frame_init(&frame, 0, 0, 0, 0, 0, 0, data, len);
+
+	if (!l2cap_frame_get_u8(&frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Frame Blocks per SDU: %u (0x%2.2x)", value, value);
+
+done:
+	if (frame.size)
+		print_hex_field("    Data", frame.data, frame.size);
+}
+
+struct packet_ltv_decoder ase_cc_table[] = {
+	LTV_DEC(0x01, ase_decode_freq),
+	LTV_DEC(0x02, ase_decode_duration),
+	LTV_DEC(0x03, ase_decode_location),
+	LTV_DEC(0x04, ase_decode_frame_length),
+	LTV_DEC(0x05, ase_decode_blocks)
+};
+
 static void print_ase_config(const struct l2cap_frame *frame)
 {
 	if (!print_prefer_framing(frame))
@@ -470,7 +954,8 @@ static void print_ase_config(const struct l2cap_frame *frame)
 	if (!print_ase_codec(frame))
 		return;
 
-	print_ase_cc(frame);
+	print_ase_cc(frame, "    Codec Specific Configuration",
+			ase_cc_table, ARRAY_SIZE(ase_cc_table));
 }
 
 static bool print_ase_framing(const struct l2cap_frame *frame,
@@ -704,7 +1189,8 @@ static bool ase_config_cmd(const struct l2cap_frame *frame)
 	if (!print_ase_codec(frame))
 		return false;
 
-	if (!print_ase_cc(frame))
+	if (!print_ase_cc(frame, "    Codec Specific Configuration",
+				ase_cc_table, ARRAY_SIZE(ase_cc_table)))
 		return false;
 
 	return true;
@@ -1050,100 +1536,23 @@ static void ase_cp_notify(const struct l2cap_frame *frame)
 	print_ase_cp_rsp(frame);
 }
 
-static const struct bitfield_data pac_loc_table[] = {
-	{  0, "Front Left (0x00000001)"			},
-	{  1, "Front Right (0x00000002)"		},
-	{  2, "Front Center (0x00000004)"		},
-	{  3, "Low Frequency Effects 1 (0x00000008)"	},
-	{  4, "Back Left (0x00000010)"			},
-	{  5, "Back Right (0x00000020)"			},
-	{  6, "Front Left of Center (0x00000040)"	},
-	{  7, "Front Right of Center (0x00000080)"	},
-	{  8, "Back Center (0x00000100)"		},
-	{  9, "Low Frequency Effects 2 (0x00000200)"	},
-	{  10, "Side Left (0x00000400)"			},
-	{  11, "Side Right (0x00000800)"		},
-	{  12, "Top Front Left (0x00001000)"		},
-	{  13, "Top Front Right (0x00002000)"		},
-	{  14, "Top Front Center (0x00004000)"		},
-	{  15, "Top Center (0x00008000)"		},
-	{  16, "Top Back Left (0x00010000)"		},
-	{  17, "Top Back Right (0x00020000)"		},
-	{  18, "Top Side Left (0x00040000)"		},
-	{  19, "Top Side Right (0x00080000)"		},
-	{  20, "Top Back Center (0x00100000)"		},
-	{  21, "Bottom Front Center (0x00200000)"	},
-	{  22, "Bottom Front Left (0x00400000)"		},
-	{  23, "Bottom Front Right (0x00800000)"	},
-	{  24, "Front Left Wide (0x01000000)"		},
-	{  25, "Front Right Wide (0x02000000)"		},
-	{  26, "Left Surround (0x04000000)"		},
-	{  27, "Right Surround (0x08000000)"		},
-	{  28, "RFU (0x10000000)"			},
-	{  29, "RFU (0x20000000)"			},
-	{  30, "RFU (0x40000000)"			},
-	{  31, "RFU (0x80000000)"			},
-	{ }
-};
-
-static void print_loc_pac(const struct l2cap_frame *frame)
-{
-	uint32_t value;
-	uint8_t mask;
-
-	if (!l2cap_frame_get_le32((void *)frame, &value)) {
-		print_text(COLOR_ERROR, "    value: invalid size");
-		goto done;
-	}
-
-	print_field("  Location: 0x%8.8x", value);
-
-	mask = print_bitfield(4, value, pac_loc_table);
-	if (mask)
-		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
-								mask);
-
-done:
-	if (frame->size)
-		print_hex_field("  Data", frame->data, frame->size);
-}
-
 static void pac_loc_read(const struct l2cap_frame *frame)
 {
-	print_loc_pac(frame);
+	print_location(frame);
 }
 
 static void pac_loc_notify(const struct l2cap_frame *frame)
 {
-	print_loc_pac(frame);
+	print_location(frame);
 }
 
-static const struct bitfield_data pac_context_table[] = {
-	{  0, "Unspecified (0x0001)"			},
-	{  1, "Conversational (0x0002)"			},
-	{  2, "Media (0x0004)"				},
-	{  3, "Game (0x0008)"				},
-	{  4, "Instructional (0x0010)"			},
-	{  5, "Voice Assistants (0x0020)"		},
-	{  6, "Live (0x0040)"				},
-	{  7, "Sound Effects (0x0080)"			},
-	{  8, "Notifications (0x0100)"			},
-	{  9, "Ringtone (0x0200)"			},
-	{  10, "Alerts (0x0400)"			},
-	{  11, "Emergency alarm (0x0800)"		},
-	{  12, "RFU (0x1000)"				},
-	{  13, "RFU (0x2000)"				},
-	{  14, "RFU (0x4000)"				},
-	{  15, "RFU (0x8000)"				},
-};
-
 static void print_pac_context(const struct l2cap_frame *frame)
 {
 	uint16_t snk, src;
 	uint16_t mask;
 
 	if (!l2cap_frame_get_le16((void *)frame, &snk)) {
-		print_text(COLOR_ERROR, "    value: invalid size");
+		print_text(COLOR_ERROR, "  sink: invalid size");
 		goto done;
 	}
 
@@ -1151,11 +1560,11 @@ static void print_pac_context(const struct l2cap_frame *frame)
 
 	mask = print_bitfield(4, snk, pac_context_table);
 	if (mask)
-		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+		print_text(COLOR_WHITE_BG, "  Unknown fields (0x%4.4x)",
 								mask);
 
 	if (!l2cap_frame_get_le16((void *)frame, &src)) {
-		print_text(COLOR_ERROR, "    sink: invalid size");
+		print_text(COLOR_ERROR, "  source: invalid size");
 		goto done;
 	}
 
@@ -1163,7 +1572,7 @@ static void print_pac_context(const struct l2cap_frame *frame)
 
 	mask = print_bitfield(4, src, pac_context_table);
 	if (mask)
-		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+		print_text(COLOR_WHITE_BG, "  Unknown fields (0x%4.4x)",
 								mask);
 
 done:
diff --git a/monitor/packet.c b/monitor/packet.c
index bd9efd2c7..3efa5a25d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3338,7 +3338,26 @@ static void *iov_pull(struct iovec *iov, size_t len)
 	return data;
 }
 
-static void print_ltv(const char *label, const uint8_t *data, uint8_t len)
+static struct packet_ltv_decoder*
+get_ltv_decoder(struct packet_ltv_decoder *decoder, size_t num, uint8_t type)
+{
+	size_t i;
+
+	if (!decoder || !num)
+		return NULL;
+
+	for (i = 0; i < num; i++) {
+		struct packet_ltv_decoder *dec = &decoder[i];
+
+		if (dec->type == type)
+			return dec;
+	}
+
+	return NULL;
+}
+
+static void print_ltv(const char *label, const uint8_t *data, uint8_t len,
+			struct packet_ltv_decoder *decoder, size_t num)
 {
 	struct iovec iov;
 	int i;
@@ -3348,6 +3367,7 @@ static void print_ltv(const char *label, const uint8_t *data, uint8_t len)
 
 	for (i = 0; iov.iov_len; i++) {
 		uint8_t l, t, *v;
+		struct packet_ltv_decoder *dec;
 
 		l = get_u8(iov_pull(&iov, sizeof(l)));
 		if (!l) {
@@ -3369,16 +3389,21 @@ static void print_ltv(const char *label, const uint8_t *data, uint8_t len)
 		if (!v)
 			break;
 
-		print_hex_field(label, v, l);
+		dec = get_ltv_decoder(decoder, num, t);
+		if (dec)
+			dec->func(v, l);
+		else
+			print_hex_field(label, v, l);
 	}
 
 	if (iov.iov_len)
 		print_hex_field(label, iov.iov_base, iov.iov_len);
 }
 
-void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len)
+void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len,
+			struct packet_ltv_decoder *decoder, size_t decoder_len)
 {
-	print_ltv(label, data, len);
+	print_ltv(label, data, len, decoder, decoder_len);
 }
 
 static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
@@ -3432,7 +3457,8 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 			goto done;
 
 		print_ltv("    Codec Specific Configuration",
-					codec_cfg->data, codec_cfg->len);
+					codec_cfg->data, codec_cfg->len,
+					NULL, 0);
 
 		metadata = iov_pull(&iov, sizeof(*metadata));
 		if (!metadata)
@@ -3441,7 +3467,8 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		if (!iov_pull(&iov, metadata->len))
 			goto done;
 
-		print_ltv("    Metadata", metadata->data, metadata->len);
+		print_ltv("    Metadata", metadata->data, metadata->len,
+					NULL, 0);
 
 		/* Level 3 - BIS(s)*/
 		for (j = 0; j < subgroup->num_bis; j++) {
diff --git a/monitor/packet.h b/monitor/packet.h
index 3a6b9f7a1..b07d5d18c 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -63,7 +63,20 @@ void packet_print_channel_map_ll(const uint8_t *map);
 void packet_print_io_capability(uint8_t capability);
 void packet_print_io_authentication(uint8_t authentication);
 void packet_print_codec_id(const char *label, uint8_t codec);
-void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len);
+
+#define LTV_DEC(_type, _func) \
+{ \
+	.type = _type, \
+	.func = _func, \
+}
+
+struct packet_ltv_decoder {
+	uint8_t  type;
+	void (*func)(const uint8_t *data, uint8_t len);
+};
+
+void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len,
+			struct packet_ltv_decoder *decoder, size_t num);
 
 void packet_control(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint16_t opcode,
-- 
2.35.3

