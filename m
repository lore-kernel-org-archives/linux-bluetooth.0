Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220CCC43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2C218FD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEvIbyfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLWKBI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:01:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34606 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeLWKBH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:01:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so17320946wmd.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z0ZTAJ+IFD9X0YbcZmyph8c25BomlAoKHmATfc3Ep3Q=;
        b=eEvIbyfIjHD5fHum1hGLVenQr4xvOxrsEpHayjpKOB8cq0XnNpez/9ZOufuq621gNA
         lIQaMO4kcfe0uiVRzR1saI/VsdsfDxY3cJFWmw+lSQKiIcn0ZVFf4hA0BnirAo98K7Fz
         Hi97LzEnIemj1LnUP35S/OUumyjnOkHOkTF1IjDVCbgjAHZCcO1ecGtos9ZPGkmVAwBy
         8MobD03X+vJbQecNZRx2gKAMZjimMjhoqIgwMn5HF1b9RW1EhyqW+74fEmBYVWaYxh/2
         U3/E0n3ir8L1wHg8wIFeCMYDZOG8TK4zO1oWR4R9b68UB3Fu0llnCIDTlMVyAyhS5gSd
         ab4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0ZTAJ+IFD9X0YbcZmyph8c25BomlAoKHmATfc3Ep3Q=;
        b=b8vbc79IDeXPGDHsQYjn6Cjpt54iVS1CdHFBuVLQTdZ4lFivjoVE0No4ZcBjgQZKyG
         3WMiaJVRcYqFPLvdKKLnLmPtythgqF5fGLt/r3oAc/4QFUQBqhANz38wCJPSrEF+Vu86
         gJ649dYTRUtcijwQ22uPY3/8G7ipI6l/wblDFxXNaSPWeRQF8XHEgNGsjM47GqcHNQkO
         tA76iqofJiRnlRjvpOztyupyZbdA3bVpDFi91Rxl0uKQWPqlxK7TXHFe+QfE2M+1eUuE
         m0TdMkPVdwJyJ9jNq4fKA3Pk/iFBV/xpAtAQwi1pK8TYiFRKWwffH097J+rnS635UVkZ
         u+Pw==
X-Gm-Message-State: AJcUukdW4y/kt3X0Z4ROyY69TVzCt9fz5qBu9hECOhL7E4j6r6kyQbVm
        MokWERDgcBJ8GKXMjptbQw148mYN
X-Google-Smtp-Source: AFSGD/VZcxXIpz7XMsiX5EStgg5TbF2DqwfhXcKpRJbODMijv6X2KZxWb3f04u2WQZA6MP5bFTs+Nw==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr8326991wme.94.1545559264007;
        Sun, 23 Dec 2018 02:01:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id c10sm16670615wrw.49.2018.12.23.02.01.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:01:02 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] btmon: Parse new A2DP codecs
Date:   Sun, 23 Dec 2018 11:00:43 +0100
Message-Id: <20181223100043.11505-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CABBYNZ+ntTPASbv4434zJf7q_KRtiGbduSORbhNoC__ihZW-cA@mail.gmail.com>
References: <CABBYNZ+ntTPASbv4434zJf7q_KRtiGbduSORbhNoC__ihZW-cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Parse information about additional A2DP codecs: FastStream, aptX Low
Latency and aptX HD.
---
Changes since v1:
* Fix style issues
* Define struct vndcodec
---
 monitor/a2dp.c | 296 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 284 insertions(+), 12 deletions(-)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index 6a271217b..ffdcbb962 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -3,6 +3,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2015  Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
+ *  Copyright (C) 2018  Pali Rohár <pali.rohar@gmail.com>
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -51,6 +52,12 @@
 /* Vendor Specific A2DP Codecs */
 #define APTX_VENDOR_ID		0x0000004f
 #define APTX_CODEC_ID		0x0001
+#define FASTSTREAM_VENDOR_ID	0x0000000a
+#define FASTSTREAM_CODEC_ID	0x0001
+#define APTX_LL_VENDOR_ID	0x0000000a
+#define APTX_LL_CODEC_ID	0x0002
+#define APTX_HD_VENDOR_ID	0x000000D7
+#define APTX_HD_CODEC_ID	0x0024
 #define LDAC_VENDOR_ID		0x0000012d
 #define LDAC_CODEC_ID		0x00aa
 
@@ -187,6 +194,23 @@ static const struct bit_desc aptx_channel_mode_table[] = {
 	{ }
 };
 
+static const struct bit_desc faststream_direction_table[] = {
+	{  0, "Sink" },
+	{  1, "Source" },
+	{ }
+};
+
+static const struct bit_desc faststream_sink_frequency_table[] = {
+	{  1, "44100" },
+	{  0, "48000" },
+	{ }
+};
+
+static const struct bit_desc faststream_source_frequency_table[] = {
+	{  5, "16000" },
+	{ }
+};
+
 static void print_value_bits(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -211,12 +235,49 @@ static const char *find_value_bit(uint32_t value,
 	return "Unknown";
 }
 
+struct vndcodec {
+	uint32_t vendor_id;
+	uint16_t codec_id;
+	char *codec_name;
+	bool (*codec_vendor_cap)(uint8_t losc, struct l2cap_frame *frame);
+	bool (*codec_vendor_cfg)(uint8_t losc, struct l2cap_frame *frame);
+};
+
+static bool codec_vendor_aptx_cap(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_aptx_cfg(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_faststream_cap(uint8_t losc,
+					struct l2cap_frame *frame);
+static bool codec_vendor_faststream_cfg(uint8_t losc,
+					struct l2cap_frame *frame);
+static bool codec_vendor_aptx_ll_cap(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_aptx_ll_cfg(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_aptx_hd_cap(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_aptx_hd_cfg(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame);
+
+static const struct vndcodec vndcodecs[] = {
+	{ APTX_VENDOR_ID, APTX_CODEC_ID, "aptX",
+	  codec_vendor_aptx_cap, codec_vendor_aptx_cfg },
+	{ FASTSTREAM_VENDOR_ID, FASTSTREAM_CODEC_ID, "FastStream",
+	  codec_vendor_faststream_cap, codec_vendor_faststream_cfg },
+	{ APTX_LL_VENDOR_ID, APTX_LL_CODEC_ID, "aptX Low Latency",
+	  codec_vendor_aptx_ll_cap, codec_vendor_aptx_ll_cfg },
+	{ APTX_HD_VENDOR_ID, APTX_HD_CODEC_ID, "aptX HD",
+	  codec_vendor_aptx_hd_cap, codec_vendor_aptx_hd_cfg },
+	{ LDAC_VENDOR_ID, LDAC_CODEC_ID, "LDAC",
+	  codec_vendor_ldac, codec_vendor_ldac },
+	{ }
+};
+
 static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
 {
-	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
-		return "aptX";
-	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
-		return "LDAC";
+	size_t i;
+
+	for (i = 0; i < sizeof(vndcodecs)/sizeof(*vndcodecs); i++) {
+		if (vndcodecs[i].vendor_id == vendor_id &&
+		    vndcodecs[i].codec_id == codec_id)
+			return vndcodecs[i].codec_name;
+	}
 
 	return "Unknown";
 }
@@ -508,6 +569,108 @@ static bool codec_vendor_aptx_cap(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_vendor_faststream_cap(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 2)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cDirection: 0x%02x", BASE_INDENT + 2, ' ', cap);
+	print_value_bits(BASE_INDENT + 2, cap, faststream_direction_table);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cSink Frequency: 0x%02x", BASE_INDENT + 2, ' ',
+			cap & 0x0f);
+	print_value_bits(BASE_INDENT + 2, cap & 0x0f,
+			faststream_sink_frequency_table);
+
+	print_field("%*cSource Frequency: 0x%02x", BASE_INDENT + 2, ' ',
+			cap & 0xf0);
+	print_value_bits(BASE_INDENT + 2, cap & 0xf0,
+			faststream_source_frequency_table);
+
+	return true;
+}
+
+static bool codec_vendor_aptx_ll_cap(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+	uint16_t level = 0;
+
+	if (losc != 2 && losc != 11)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0xf0);
+	print_value_bits(BASE_INDENT + 2, cap & 0xf0, aptx_frequency_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
+								cap & 0x0f);
+	print_value_bits(BASE_INDENT + 2, cap & 0x0f, aptx_channel_mode_table);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cBidirectional link: %s", BASE_INDENT, ' ',
+			(cap & 1) ? "Yes" : "No");
+
+	if ((cap & 2) && losc == 11) {
+		/* reserved */
+		l2cap_frame_get_u8(frame, &cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cTarget codec buffer level: %u (0x%02x)",
+				BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cInitial codec buffer level: %u (0x%02x)",
+				BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA max rate: %g (0x%02x)",
+				BASE_INDENT + 2, ' ', cap / 10000.0, cap);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA averaging time: %us (0x%02x)",
+				BASE_INDENT + 2, ' ', cap, cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cGood working codec buffer level: %u (0x%02x)",
+				BASE_INDENT + 2, ' ', level, level);
+	}
+
+	return true;
+}
+
+static bool codec_vendor_aptx_hd_cap(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 5)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0xf0);
+	print_value_bits(BASE_INDENT + 2, cap & 0xf0, aptx_frequency_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
+								cap & 0x0f);
+	print_value_bits(BASE_INDENT + 2, cap & 0x0f, aptx_channel_mode_table);
+
+	/* reserved */
+	l2cap_frame_get_u8(frame, &cap);
+	l2cap_frame_get_u8(frame, &cap);
+	l2cap_frame_get_u8(frame, &cap);
+	l2cap_frame_get_u8(frame, &cap);
+
+	return true;
+}
+
 static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint16_t cap = 0;
@@ -526,6 +689,7 @@ static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint32_t vendor_id = 0;
 	uint16_t codec_id = 0;
+	size_t i;
 
 	if (losc < 6)
 		return false;
@@ -541,10 +705,11 @@ static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 	print_field("%*cVendor Specific Codec ID: %s (0x%04x)", BASE_INDENT,
 			' ', vndcodec2str(vendor_id, codec_id), codec_id);
 
-	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
-		return codec_vendor_aptx_cap(losc, frame);
-	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
-		return codec_vendor_ldac(losc, frame);
+	for (i = 0; i < sizeof(vndcodecs)/sizeof(*vndcodecs); i++) {
+		if (vndcodecs[i].vendor_id == vendor_id &&
+		    vndcodecs[i].codec_id == codec_id)
+			return vndcodecs[i].codec_vendor_cap(losc, frame);
+	}
 
 	packet_hexdump(frame->data, losc);
 	l2cap_frame_pull(frame, frame, losc);
@@ -572,10 +737,116 @@ static bool codec_vendor_aptx_cfg(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_vendor_faststream_cfg(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 2)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cDirection: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap, faststream_direction_table),
+			cap);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cSink Frequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0x0f,
+				faststream_sink_frequency_table),
+			cap & 0x0f);
+
+	print_field("%*cSource Frequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0xf0,
+				faststream_source_frequency_table),
+			cap & 0xf0);
+
+	return true;
+}
+
+static bool codec_vendor_aptx_ll_cfg(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+	uint16_t level = 0;
+
+	if (losc != 2 && losc != 11)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0xf0, aptx_frequency_table),
+			cap & 0xf0);
+
+	print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0x0f, aptx_channel_mode_table),
+			cap & 0x0f);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cBidirectional link: %s", BASE_INDENT, ' ',
+			(cap & 1) ? "Yes" : "No");
+
+	if ((cap & 2) && losc == 11) {
+		/* reserved */
+		l2cap_frame_get_u8(frame, &cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cTarget codec buffer level: %u (0x%02x)",
+				BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cInitial codec buffer level: %u (0x%02x)",
+				BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA max rate: %g (0x%02x)",
+				BASE_INDENT + 2, ' ', cap / 10000.0, cap);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA averaging time: %us (0x%02x)",
+				BASE_INDENT + 2, ' ', cap, cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cGood working codec buffer level: %u (0x%02x)",
+				BASE_INDENT + 2, ' ', level, level);
+	}
+
+	return true;
+}
+
+static bool codec_vendor_aptx_hd_cfg(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 5)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0xf0, aptx_frequency_table),
+			cap & 0xf0);
+
+	print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0x0f, aptx_channel_mode_table),
+			cap & 0x0f);
+
+	/* reserved */
+	l2cap_frame_get_u8(frame, &cap);
+	l2cap_frame_get_u8(frame, &cap);
+	l2cap_frame_get_u8(frame, &cap);
+	l2cap_frame_get_u8(frame, &cap);
+
+	return true;
+}
+
 static bool codec_vendor_cfg(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint32_t vendor_id = 0;
 	uint16_t codec_id = 0;
+	size_t i;
 
 	if (losc < 6)
 		return false;
@@ -591,10 +862,11 @@ static bool codec_vendor_cfg(uint8_t losc, struct l2cap_frame *frame)
 	print_field("%*cVendor Specific Codec ID: %s (0x%04x)", BASE_INDENT,
 			' ', vndcodec2str(vendor_id, codec_id), codec_id);
 
-	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
-		return codec_vendor_aptx_cfg(losc, frame);
-	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
-		return codec_vendor_ldac(losc, frame);
+	for (i = 0; i < sizeof(vndcodecs)/sizeof(*vndcodecs); i++) {
+		if (vndcodecs[i].vendor_id == vendor_id &&
+		    vndcodecs[i].codec_id == codec_id)
+			return vndcodecs[i].codec_vendor_cfg(losc, frame);
+	}
 
 	packet_hexdump(frame->data, losc);
 	l2cap_frame_pull(frame, frame, losc);
-- 
2.11.0

