Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19FCC282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1702075B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 09:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="kQIv0lAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfEVJYL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 05:24:11 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:39358 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfEVJYL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 05:24:11 -0400
Received: by mail-lj1-f177.google.com with SMTP id a10so1399292ljf.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2019 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pYSQSzrg0eS0MT3xl1t/z2KZd1GwjU8+NkC/JFmUpU=;
        b=kQIv0lAOiTgBFAp4POHhzbaY/ncwZnlGNX9ATubTi5/T6a86dbRTMF1UfCGxvdcv9h
         gPSUiC17wXfe7IOluD4CGz/ulRPnohfZ9++TADamrcSTg5spZWlJECsT3RatUTg1iDy8
         7te2XeJCwy4eJtxaOII/HL9RVvpd6CgX047zj4dGXpvhyqtYMwgV7y0VaJrG6eLF3eeR
         iYoQZ7JzFsPLg8lOh4axmET9LJUoU+EkpmweQdKnC8Sy+dzBN4jAZzC3kMKl6b50fHQq
         9/sjf/esBbe41GFEZ7JCTxU5ohE25xrZjbbN6quWXrN5+EsxXwhL2MGoeLa77A9Ci6no
         wxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pYSQSzrg0eS0MT3xl1t/z2KZd1GwjU8+NkC/JFmUpU=;
        b=VF4Y3qalO7ASB/6k5q5KtwMAYs8gWp2KdQ/ksImKo6lwuuJDBMymEGEhdfgj61zfDx
         xmKfcZXYxMHd1ramiJBHUVOB43CEqwdFSnCpsDt/tXrU1f25Zi5exjkq2+rT6iA8MbH/
         E3VmgTq55J8Z0R/GnfVVEZUp3fFuEPjWD+wC9wvJ1Ylv1sCTIoiSbomrLmIAi2INlaZ7
         zK+vbeksK+zYywHJm8xzUOyqkKIFwRvpuF2EYucgehbdTe++O7CXOVwsWyoFugIPca4z
         rHK6D478MbnqNdRRR3Veez9ncHnXEQBBi3cjGizLKviLlqfPiNIhXRSghxjihk6UN1kv
         0ABw==
X-Gm-Message-State: APjAAAUiNhvS5GDUSrAMSnyfhgwNyqXEF5vTKcQLIpfFeUukwLquyieN
        kv/GgVPBlyFXpVlayVUWQtw3Ve7bkE8=
X-Google-Smtp-Source: APXvYqwyVUO+gYs/Pp4E+ApNyM4ONEf4oC83K+TQ9QBf+cAsb3XsEnqB77HvOp+zeki60aic0Q+JWQ==
X-Received: by 2002:a2e:99c3:: with SMTP id l3mr1936628ljj.73.1558517048535;
        Wed, 22 May 2019 02:24:08 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e12sm5168235lfb.70.2019.05.22.02.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 02:24:07 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/3] monitor: Decode LE Periodic Advertising Report Event
Date:   Wed, 22 May 2019 11:24:02 +0200
Message-Id: <20190522092403.20927-2-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522092403.20927-1-szymon.janc@codecoup.pl>
References: <20190522092403.20927-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> HCI Event: LE Meta Event (0x3e) plen 18                                                                                                                                                               #19 [hci2] 16.562639
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: -4 dbm (0xfc)
        RSSI: -55 dBm (0xc9)
        Unused: (0xff)
        Data status: Complete
        Data length: 0x0a
        b0 b1 b2 b3 b4 b5 b6 b7 b8 b9
---
 monitor/bt.h     | 11 +++++++++++
 monitor/packet.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 6494c928f..8622ea4d4 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3103,6 +3103,17 @@ struct bt_hci_evt_le_per_sync_established {
 	uint8_t  clock_accuracy;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_PER_ADV_REPORT	0x0f
+struct bt_hci_le_per_adv_report {
+	uint16_t handle;
+	uint8_t  tx_power;
+	int8_t   rssi;
+	uint8_t  unused;
+	uint8_t  data_status;
+	uint8_t  data_len;
+	uint8_t  data[0];
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
 struct bt_hci_evt_le_adv_set_term {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 3235ad004..8b2671edb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9631,6 +9631,49 @@ static void le_per_adv_sync(const void *data, uint8_t size)
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
+static void le_per_adv_report_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_le_per_adv_report *evt = data;
+	const char *color_on;
+	const char *str;
+
+	print_field("Sync handle: %d", evt->handle);
+	print_power_level(evt->tx_power, NULL);
+	if (evt->rssi == 127)
+		print_field("RSSI: not available (0x%2.2x)",
+						(uint8_t) evt->rssi);
+	else if (evt->rssi >= -127 && evt->rssi <= 20)
+		print_field("RSSI: %d dBm (0x%2.2x)",
+				evt->rssi, (uint8_t) evt->rssi);
+	else
+		print_field("RSSI: reserved (0x%2.2x)",
+						(uint8_t) evt->rssi);
+	print_field("Unused: (0x%2.2x)", evt->unused);
+
+	switch (evt->data_status) {
+	case 0x00:
+		str = "Complete";
+		color_on = COLOR_GREEN;
+		break;
+	case 0x01:
+		str = "Incomplete, more data to come";
+		color_on = COLOR_YELLOW;
+		break;
+	case 0x02:
+		str = "Incomplete, data truncated, no more to come";
+		color_on = COLOR_RED;
+		break;
+	default:
+		str = "Reserved";
+		color_on = COLOR_RED;
+		break;
+	}
+
+	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
+	print_field("Data length: 0x%2.2x", evt->data_len);
+	packet_hexdump(evt->data, evt->data_len);
+}
+
 static void le_adv_set_term_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_set_term *evt = data;
@@ -9746,7 +9789,8 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_ext_adv_report_evt, 1, false},
 	{ 0x0e, "LE Periodic Advertising Sync Established",
 				le_per_adv_sync, 15, true },
-	{ 0x0f, "LE Periodic Advertising Report" },
+	{ 0x0f, "LE Periodic Advertising Report",
+				le_per_adv_report_evt, 7, false},
 	{ 0x10, "LE Periodic Advertising Sync Lost" },
 	{ 0x11, "LE Scan Timeout" },
 	{ 0x12, "LE Advertising Set Terminated",
-- 
2.20.1

