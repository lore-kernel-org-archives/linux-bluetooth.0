Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E9C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 00:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiFQAuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQAuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 20:50:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4761636
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1644292pjm.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ngvRkXqu/S3FB6n+X5RMXZi32SU2C1O7n4EzOBlNzLo=;
        b=ptALWP4VzR+cziSAJYBLWI2JgXI3DaOjRqxfvIw0+0u/H+BVWRMtsmNE3aDQc2I+3t
         UWoN3hBFb1RNbIW2Q9oksKAREky8E7ltxoX5upstKFqLgTCgLyysvoQ5SDNTIJVkmUZ8
         qGuGSWNlVTl77UPrBPaQTEC0IermFBBvcyycsUg6czNAYwcahVgDsrLfJesNmb4HlhU6
         hPU65/n5eDHYs5zWKDC49I1Ha/peVGA5XwypFoJM9zfm3sqTNDr2+M008wk4bxcHQAXv
         RSrWqfFIQDaHUDSZlZFnMxzpIO41oIZS9TP0beHJpGZLfFsqhvnWpXcV5a83DK86u80M
         13Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngvRkXqu/S3FB6n+X5RMXZi32SU2C1O7n4EzOBlNzLo=;
        b=fntzP3ODurIZEoJG9MjUV1ku0SjeyMZ2cqhT5r6q2l0VrvMxHA7DzbghKxPo4oR7pU
         Kdv4YD8XzLBrPs5Nj5i8TsZRhta9rbbXJ/+VpnP/4qGgeZ8dhRknrlkMhjb721+qL6zx
         FeJMh6aTjDqC13EXQa/f7POnJneU0pH+C5PXCtjrXtYZP4M0hKjYDxZfhQjn8XT4NKrp
         ZicRW+Ya3uXgkIcV3ylBGsD5oGYDLIVqvCjsY0i0g6TygRU7tyT+7qNXY0XHW3vBxgMI
         gOPQogVJpNOLhuCxx8OBfAUaiqgd/h+16Jl7J95msE2X+l6WHwHlVNR03TeIFVITCx8E
         uQog==
X-Gm-Message-State: AJIora9DC4XA60hRAbo11MLLddxFTGA0wgvBJamogSs9+AREo3Yd9or5
        e5vojEZ9hQ+YHE9lJ2zJl2a5qL5f0dU=
X-Google-Smtp-Source: AGRyM1tkJpdF4yt9n4M+Db8p6n8EgLU2aYJbLGTv+bV5xL5O2ejBoqOBh1BZ+5SftcqnsEplOTBQnQ==
X-Received: by 2002:a17:902:b218:b0:168:de55:dfba with SMTP id t24-20020a170902b21800b00168de55dfbamr6995636plr.134.1655427001685;
        Thu, 16 Jun 2022 17:50:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u23-20020a170902a61700b0015e8d4eb25asm338996plq.164.2022.06.16.17.50.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:50:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] monitor/att: Add decoding support for PAC Audio Context
Date:   Thu, 16 Jun 2022 17:49:56 -0700
Message-Id: <20220617004957.1148939-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617004957.1148939-1-luiz.dentz@gmail.com>
References: <20220617004957.1148939-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for PAC Audio Context attributes:

> ACL Data RX: Handle 42 flags 0x02 dlen 9
      Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Request (0x0a) len 2
        Handle: 0x0026 Type: Supported Audio Contexts (0x2bce)
< ACL Data TX: Handle 42 flags 0x00 dlen 11
      Channel: 64 len 7 sdu 5 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 4
        Value: ff0f0e00
        Handle: 0x0026 Type: Supported Audio Contexts (0x2bce)
            Sink Context: 0x0fff
              Unspecified (0x0001)
              Conversational (0x0002)
              Media (0x0004)
              Game (0x0008)
              Instructional (0x0010)
              Voice Assistants (0x0020)
              Live (0x0040)
              Sound Effects (0x0080)
              Notifications (0x0100)
              Ringtone (0x0200)
              Alerts (0x0400)
              Emergency alarm (0x0800)
            Source Context: 0x000e
              Conversational (0x0002)
              Media (0x0004)
              Game (0x0008)
---
 monitor/att.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index 8b47cbd9f..21fa5dde3 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1118,6 +1118,69 @@ static void pac_loc_notify(const struct l2cap_frame *frame)
 	print_loc_pac(frame);
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
+};
+
+static void print_pac_context(const struct l2cap_frame *frame)
+{
+	uint16_t snk, src;
+	uint16_t mask;
+
+	if (!l2cap_frame_get_le16((void *)frame, &snk)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("  Sink Context: 0x%4.4x", snk);
+
+	mask = print_bitfield(4, snk, pac_context_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+								mask);
+
+	if (!l2cap_frame_get_le16((void *)frame, &src)) {
+		print_text(COLOR_ERROR, "    sink: invalid size");
+		goto done;
+	}
+
+	print_field("  Source Context: 0x%4.4x", src);
+
+	mask = print_bitfield(4, src, pac_context_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void pac_context_read(const struct l2cap_frame *frame)
+{
+	print_pac_context(frame);
+}
+
+static void pac_context_notify(const struct l2cap_frame *frame)
+{
+	print_pac_context(frame);
+}
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -1143,6 +1206,8 @@ struct gatt_handler {
 	GATT_HANDLER(0x2bca, pac_loc_read, NULL, pac_loc_notify),
 	GATT_HANDLER(0x2bcb, pac_read, NULL, pac_notify),
 	GATT_HANDLER(0x2bcc, pac_loc_read, NULL, pac_loc_notify),
+	GATT_HANDLER(0x2bcd, pac_context_read, NULL, pac_context_notify),
+	GATT_HANDLER(0x2bce, pac_context_read, NULL, pac_context_notify),
 };
 
 static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
-- 
2.35.3

