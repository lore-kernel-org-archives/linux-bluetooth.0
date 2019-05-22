Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B8DC18E7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CC020851
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 09:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="D6YeB7Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfEVJYM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 05:24:12 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:38137 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVJYM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 05:24:12 -0400
Received: by mail-lf1-f53.google.com with SMTP id y19so1141366lfy.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2019 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJgnniT8zaNE6l2MshVGgyCvYU+/Y6P9MKzbgXg4IQM=;
        b=D6YeB7Ocvoaa5+Q8Rg5Xv4os+4oX1yj62kc+7wnDQ3J97qYWGWHOWKZM04fwYfL7j3
         H2QJ5oyO9jOYykrvGMeQMYi7oVMuV8/V2vjzuck3NSPCro+22qr9A1S0+6c+GviVqaS+
         j3G1rpYizjIEVmUpuSOymNWxvUs5dBadifG4vgUeqd3/Fwx9hXvE4HK8bTTBGNYCdC3X
         hGWlOPCrhR9Fy9NLrC3N1BLlUXPVTRJzzknxTgjImBCPaWWTlmN0QM+FAHwwErUJ16+U
         aCRhh70StpFUNPT0DiVBzRk+k1Sni4rTB3vQE5WFuhf3m98JoySpTL0GmydfPvRjhwea
         ahwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJgnniT8zaNE6l2MshVGgyCvYU+/Y6P9MKzbgXg4IQM=;
        b=Xf3cCMYh9pqp5YWJkXmK1/mV7bIMPHkcn45awndtzhWqj+VAl4goBgtuCRRX50xvEe
         dpw8D+fT8XzcW9W8gZ8BnI049Rgel4/lR1Ia8inn0i/SRgC9+wbKQ7YBkhj9as2A0p54
         uzbBhQ2NnHno9EEmBvyEUISo/aJz+4SVNKeBvKLmVb+OzY+zhyg4yIndpbCcXc5kVJrO
         IC3A5QF7bDNPdX3GdvgSw5lRsldM0+MRbh3jYoRYSHzonL8FComZ3lblnuN2RVXV70Mp
         3G2VzQ7SSyhZySpIwB+9yacEa3CZv46QY6ZoujW4Lv++8pSdK6/f9hw6Ij78GOf1i0Qy
         WM0g==
X-Gm-Message-State: APjAAAVoc8vgl4bSE046L8ob7+hSjCNewvgv1Vrd9l4CuGezrqceQmvy
        0ogxHkG5kUhzXA1f05EPoO1smd8t0C4=
X-Google-Smtp-Source: APXvYqzJ5KDtyicu1MOLWABidVmjHzHddlKBuERzPqewY/y1iuF1vDcwt18Z6iORR1RUVTxfpFesVg==
X-Received: by 2002:ac2:46cc:: with SMTP id p12mr5622239lfo.110.1558517049409;
        Wed, 22 May 2019 02:24:09 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e12sm5168235lfb.70.2019.05.22.02.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 02:24:08 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 3/3] monitor: Decode LE Periodic Advertising Sync Lost Event
Date:   Wed, 22 May 2019 11:24:03 +0200
Message-Id: <20190522092403.20927-3-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522092403.20927-1-szymon.janc@codecoup.pl>
References: <20190522092403.20927-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> HCI Event: LE Meta Event (0x3e) plen 3
      LE Periodic Advertising Sync Lost (0x10)
        Sync handle: 0
---
 monitor/bt.h     |  5 +++++
 monitor/packet.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 8622ea4d4..8edc895e8 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3114,6 +3114,11 @@ struct bt_hci_le_per_adv_report {
 	uint8_t  data[0];
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_PER_SYNC_LOST	0x10
+struct bt_hci_evt_le_per_sync_lost {
+	uint16_t handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
 struct bt_hci_evt_le_adv_set_term {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 8b2671edb..ab8bbdee5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9674,6 +9674,13 @@ static void le_per_adv_report_evt(const void *data, uint8_t size)
 	packet_hexdump(evt->data, evt->data_len);
 }
 
+static void le_per_adv_sync_lost(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_per_sync_lost *evt = data;
+
+	print_field("Sync handle: %d", evt->handle);
+}
+
 static void le_adv_set_term_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_set_term *evt = data;
@@ -9791,7 +9798,8 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_per_adv_sync, 15, true },
 	{ 0x0f, "LE Periodic Advertising Report",
 				le_per_adv_report_evt, 7, false},
-	{ 0x10, "LE Periodic Advertising Sync Lost" },
+	{ 0x10, "LE Periodic Advertising Sync Lost",
+				le_per_adv_sync_lost, 2, true},
 	{ 0x11, "LE Scan Timeout" },
 	{ 0x12, "LE Advertising Set Terminated",
 				le_adv_set_term_evt, 5, true},
-- 
2.20.1

