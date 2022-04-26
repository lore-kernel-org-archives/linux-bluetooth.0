Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 23:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355992AbiDZXHB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355985AbiDZXG7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 19:06:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDFE8BF42
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:50 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so516541iom.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mSAUZ+oaGBwM/63LP16uwbTzIdQvEG2+1IRQIpGQ9jw=;
        b=LnbGJmQjFxLD5B5afUnE3c93T2PUaFk1ugqjXHBd8LLst2VMgD7Q3q5Ritl9x9TlMc
         9ciRZBw5oZ48fxXZceJOePh8ghsC/toIzz/zo/ZTQql9wWnKyry9DDe7GE8DOxMnrGmh
         ASq24tC10hi4ApojEQn7wymqxmclVttdUh8N6ruImg9JIsewdZhZimWR4k5Ni2OBIS3T
         VzM2V1+uto2ZLv/xyNbDYC5PvClGQXYg+gPQIDteHsR4hnC0EBiVTNLE6AT5+tvffKrR
         1MbGhK/5tqCQJP0wzim68T9kK/rPHwPmackwpUZIyIPRIIDQxDk4bkiH8psyWbBAqYk6
         x4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSAUZ+oaGBwM/63LP16uwbTzIdQvEG2+1IRQIpGQ9jw=;
        b=74+rBHbuND+rlA5KngKJ07JuVaQ0GHo9PefD2G0vcJAGpjYTR+25nJS+bTSo07Onem
         8p3xqMQWLMIOv5jbYYV3qoktKFy6HQ7INJgxvfazA7hqXoKhttygykaPeauKyimMKBhg
         bVgOZioUqOxKmdR54kKZ1hRag56dVkU2xtH0QgVESidaYbNBvWn+JPzjrmvXrI/G5021
         9VYHPlD3NmjLRjRtCKZ3q1AyPY4+RH7M7YauDk8ZDYhn7xxUK/hIUSYnBeZdkqM6NO3S
         c5zXSCxV58w9tS4gVzcs9GAULHRxef0Uuemnd5EwKlfcq+V/5rR7hsGAlNj/LKSVtE34
         NWlw==
X-Gm-Message-State: AOAM531fFKrDR4Dvo4EcGcWznjbG8mY+0LD28BQQn1M6an3oMizDkTm+
        omfh+4LELo2JXWwuT1fbDE1mrChbmbo=
X-Google-Smtp-Source: ABdhPJy5953fDPwuMdVExW224e/eypfvKhoMVKp5Cv5mgD+mv0ckTqzE3uLDhWnCu5k2nmqktTa1sQ==
X-Received: by 2002:a05:6602:398b:b0:657:ab5a:ce2a with SMTP id bw11-20020a056602398b00b00657ab5ace2amr1830772iob.78.1651014229790;
        Tue, 26 Apr 2022 16:03:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a056e020df000b002ccc1d58ca5sm8437194ilj.54.2022.04.26.16.03.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:03:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] btmon: Add support for decoding Broadcast Audio Annoucements
Date:   Tue, 26 Apr 2022 16:03:45 -0700
Message-Id: <20220426230347.857783-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426230347.857783-1-luiz.dentz@gmail.com>
References: <20220426230347.857783-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding Broadcast Audio Announcements as shown
on:

Basic Audio Profile / Profile Specification
Page 34 of 146

Table 3.14: Broadcast Source AD format when transmitting Broadcast
Audio Announcements

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 36
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x20
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 904177 (0x0dcbf1)
        Name (complete): Broadcast Audio Source
---
 monitor/packet.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 471b0dd4d..b376d5a8b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3301,11 +3301,44 @@ static void print_uuid128_list(const char *label, const void *data,
 	}
 }
 
+static void print_broadcast_annoucement(const uint8_t *data, uint8_t data_len)
+{
+	uint32_t bid;
+
+	if (data_len < 3) {
+		print_hex_field("  Data", data, data_len);
+		return;
+	}
+
+	bid = get_le24(data);
+	print_field("Broadcast ID: %u (0x%06x)", bid, bid);
+}
+
+static const struct service_data_decoder {
+	uint16_t uuid;
+	void (*func)(const uint8_t *data, uint8_t data_len);
+} service_data_decoders[] = {
+	{ 0x1852, print_broadcast_annoucement }
+};
+
 static void print_service_data(const uint8_t *data, uint8_t data_len)
 {
 	uint16_t uuid = get_le16(&data[0]);
+	size_t i;
 
 	print_field("Service Data: %s (0x%4.4x)", bt_uuid16_to_str(uuid), uuid);
+
+	for (i = 0; i < ARRAY_SIZE(service_data_decoders); i++) {
+		const struct service_data_decoder *decoder;
+
+		decoder = &service_data_decoders[i];
+
+		if (decoder->uuid == uuid) {
+			decoder->func(&data[2], data_len - 2);
+			return;
+		}
+	}
+
 	print_hex_field("  Data", &data[2], data_len - 2);
 }
 
-- 
2.35.1

