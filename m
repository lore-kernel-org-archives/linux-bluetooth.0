Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6DBC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 21:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3CB20869
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 21:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C05B+mEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeLSVT7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:19:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52996 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeLSVT7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 16:19:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so7479609wml.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 13:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQoZBbKkhNGYYWDC552+TZbl9MTn6mmAgWv+epqT/F0=;
        b=C05B+mEARbNjlgMa0Fys421skYQKBgC+JjOtx2EpEbH3Da3Kr5zOyPvwP2/VxXITvL
         SmnHmaCt0bFrwQ1d5n5vXnikGQ0OT9wBumxG3OQnX1ApzQei7Qt69c9qbQroVbMdJxCs
         J3lZ2QyTtihbB0lRSol7B58aMXXscj3Pbn52j/qCyFwisYdB7Zum8Y0wVMoKK45o8SRJ
         orAB71R430t0z9qUxkWiy2xy/tZuxWrhf7Ba+kuCLCsr9TVf36Zxb3DAaxskNPtziNLw
         lM6erqGLr5cM/jYZF6ibQ0jasxK4MOiUx1fz/0vfcKgDdXIiG2+c0Fomn8Lat2frQHj3
         Uv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQoZBbKkhNGYYWDC552+TZbl9MTn6mmAgWv+epqT/F0=;
        b=g1uVWqWS+wHKt4xRA7I3uyvOkDxxxEYjWrtOyjpygORtXwKnrj3lZtDY3XGtdAFBYt
         6e5hR6Mn+ZFHio6kTslU09I0drTkwMV7M+UYtTg0sEA6gCFCwfhO3Od6daptQGoOSGHh
         VsH30ZTGC6HJi9eU6rx7Hwear+pFuWYW+TMYZ54fhxz4azyMZ3RUIgB/jXJlA812t/HE
         HLdvQbXR27C6BaT39tZBTK53RzwGw2o689JCjMF/ejnppDLlffdJw3BmJam9yxC0Tqvv
         QOgustlb92xyEFuO/oQMn5llR4ZZU9QWq4PFs02cwkwCfhOp706zC9ZGz6GdQTqZMoak
         eoZg==
X-Gm-Message-State: AA+aEWZiq4vQzb2ZEl2Yob8CifTn0dIpxePhhQkBdx4u20l3Dk2C+5T4
        e15y+WM7u2ANCgDQ+cAHv8aJLy7QKBk=
X-Google-Smtp-Source: AFSGD/VwtWzEwG9AfGyGxhdijRxGc4sYCyDH1dwrOXRCi9CZ8ZyFkwMQdX5VZBnZkWlvd7bAKMZaqg==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr8894014wmz.8.1545254396502;
        Wed, 19 Dec 2018 13:19:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id 60sm9703320wrb.81.2018.12.19.13.19.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:19:55 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] btmon: Parse information about A2DP codecs: FastStream, aptX Low Latency and aptX HD
Date:   Wed, 19 Dec 2018 22:17:35 +0100
Message-Id: <20181219211735.17563-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/a2dp.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index 6a271217b..6e82500d4 100644
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
@@ -215,6 +239,12 @@ static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
 {
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return "aptX";
+	else if (vendor_id == FASTSTREAM_VENDOR_ID && codec_id == FASTSTREAM_CODEC_ID)
+		return "FastStream";
+	else if (vendor_id == APTX_LL_VENDOR_ID && codec_id == APTX_LL_CODEC_ID)
+		return "aptX Low Latency";
+	else if (vendor_id == APTX_HD_VENDOR_ID && codec_id == APTX_HD_CODEC_ID)
+		return "aptX HD";
 	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
 		return "LDAC";
 
@@ -508,6 +538,98 @@ static bool codec_vendor_aptx_cap(uint8_t losc, struct l2cap_frame *frame)
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
+	print_field("%*cSink Frequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0x0f);
+	print_value_bits(BASE_INDENT + 2, cap & 0x0f, faststream_sink_frequency_table);
+
+	print_field("%*cSource Frequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0xf0);
+	print_value_bits(BASE_INDENT + 2, cap & 0xf0, faststream_source_frequency_table);
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
+	print_field("%*cBidirectional link: %s", BASE_INDENT, ' ', (cap & 1) ? "Yes" : "No");
+
+	if ((cap & 2) && losc == 11) {
+		/* reserved */
+		l2cap_frame_get_u8(frame, &cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cTarget codec buffer level: %u (0x%02x)", BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cInitial codec buffer level: %u (0x%02x)", BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA max rate: %g (0x%02x)", BASE_INDENT + 2, ' ', cap / 10000.0, cap);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA averaging time: %us (0x%02x)", BASE_INDENT + 2, ' ', cap, cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cGood working codec buffer level: %u (0x%02x)", BASE_INDENT + 2, ' ', level, level);
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
@@ -543,6 +665,12 @@ static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return codec_vendor_aptx_cap(losc, frame);
+	else if (vendor_id == FASTSTREAM_VENDOR_ID && codec_id == FASTSTREAM_CODEC_ID)
+		return codec_vendor_faststream_cap(losc, frame);
+	else if (vendor_id == APTX_LL_VENDOR_ID && codec_id == APTX_LL_CODEC_ID)
+		return codec_vendor_aptx_ll_cap(losc, frame);
+	else if (vendor_id == APTX_HD_VENDOR_ID && codec_id == APTX_HD_CODEC_ID)
+		return codec_vendor_aptx_hd_cap(losc, frame);
 	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
 		return codec_vendor_ldac(losc, frame);
 
@@ -572,6 +700,102 @@ static bool codec_vendor_aptx_cfg(uint8_t losc, struct l2cap_frame *frame)
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
+			find_value_bit(cap & 0x0f, faststream_sink_frequency_table),
+			cap & 0x0f);
+
+	print_field("%*cSource Frequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0xf0, faststream_source_frequency_table),
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
+	print_field("%*cBidirectional link: %s", BASE_INDENT, ' ', (cap & 1) ? "Yes" : "No");
+
+	if ((cap & 2) && losc == 11) {
+		l2cap_frame_get_u8(frame, &cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cTarget codec buffer level: %u (0x%02x)", BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cInitial codec buffer level: %u (0x%02x)", BASE_INDENT + 2, ' ', level, level);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA max rate: %g (0x%02x)", BASE_INDENT + 2, ' ', cap / 10000.0, cap);
+
+		l2cap_frame_get_u8(frame, &cap);
+		print_field("%*cSRA averaging time: %us (0x%02x)", BASE_INDENT + 2, ' ', cap, cap);
+
+		l2cap_frame_get_le16(frame, &level);
+		print_field("%*cGood working codec buffer level: %u (0x%02x)", BASE_INDENT + 2, ' ', level, level);
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
@@ -593,6 +817,12 @@ static bool codec_vendor_cfg(uint8_t losc, struct l2cap_frame *frame)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return codec_vendor_aptx_cfg(losc, frame);
+	else if (vendor_id == FASTSTREAM_VENDOR_ID && codec_id == FASTSTREAM_CODEC_ID)
+		return codec_vendor_faststream_cfg(losc, frame);
+	else if (vendor_id == APTX_LL_VENDOR_ID && codec_id == APTX_LL_CODEC_ID)
+		return codec_vendor_aptx_ll_cfg(losc, frame);
+	else if (vendor_id == APTX_HD_VENDOR_ID && codec_id == APTX_HD_CODEC_ID)
+		return codec_vendor_aptx_hd_cfg(losc, frame);
 	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
 		return codec_vendor_ldac(losc, frame);
 
-- 
2.11.0

