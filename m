Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D2C18E7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF382075B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 09:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="JfHmPnve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfEVJYK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 05:24:10 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:46948 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVJYJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 05:24:09 -0400
Received: by mail-lf1-f51.google.com with SMTP id l26so1113353lfh.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2019 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5vaMCRD66zXjPwS9Pl1WkEL084FmolfM5aqHql9McM=;
        b=JfHmPnvea5GzAKpC6sRNQxsuC6zVO/FZXoE2hk1C8nOr6T9OS3jrI4xbA3yN40Bg8g
         XexHI6a6zDOKxsvbYDJza7co5EJRLpj0Njp4LcnnXyjkicPQaj30HqE2AC2CgDIvOoha
         S43h0gNQceonTbCa2d4h+5usF4GqvmCVQKI2taLaG9g7KNJuKUbcwvFbIlrDyF4B9ies
         l0JY3bcQrfYaxby5lW8MYvuzwPBQ43o/iXh6bIoJE9Yi9AXHonU/BrKnQ+vIiv1A8yZD
         ESv86N+6I0FezZYMzhi+VeRdAbg1CYp47ymu0j2nsb0kwcUuL0jC3kwvn0w85idfBycz
         1xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5vaMCRD66zXjPwS9Pl1WkEL084FmolfM5aqHql9McM=;
        b=egxSjPPj2obVNHyZ2KIgNNV1AFj6JKKwy79/BQ8AV/ke3IW1Ra3XDcqHFEaWXZ4VS0
         2KU4Uuss8EKlVmM7tBTrrPcNDX+wmRyl9c+Q/NB4dc8thp13XAkTTMTukf6ypiHWEeL2
         Nw0B/ozJi8y9LbW3MYR/wFYzfyLR2EKSUF7Bwkp4TCI4LTjqWFLhAqNqu9+hW7q7elea
         yyOekoMhIhdNvXNdGJgRNZR/j0ueZV2rAtGohVpiemXQiFapjStltOpftaNhZYWMXRGo
         h2YWrEpCtUMoTU1k2v8tfWgxEHTUtUqu9c2i38F4VCFLiV8Zsh2Hqpqdq3DyFXeBInhQ
         bZug==
X-Gm-Message-State: APjAAAWsmBsmlcapbvfmSZnAHy3Hih2apoCxt7Qi0FzeI5g96zMEPkkA
        +wcm6QjEzjhYFnMUXcZ/9JMYrq3Dhcw=
X-Google-Smtp-Source: APXvYqx5ZVZ0S6Vq0kzM4P6UzhcDFB7T5qVNJjgXSZ0lg1XgNJrc7zHnEvscb3lluY3G8kXBGDpJzg==
X-Received: by 2002:ac2:42c8:: with SMTP id n8mr44592581lfl.28.1558517047469;
        Wed, 22 May 2019 02:24:07 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e12sm5168235lfb.70.2019.05.22.02.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 02:24:06 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/3] monitor: Decode LE Periodic Advertising Sync Established Event
Date:   Wed, 22 May 2019 11:24:01 +0200
Message-Id: <20190522092403.20927-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> HCI Event: LE Meta Event (0x3e) plen 16                                                                                                                                                             #976 [hci1] 607.133703
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x06
        Advertiser address type: Random (0x01)
        Advertiser address: FF:00:00:00:00:AA (Static)
        Advertiser PHY: LE 1M (0x01)
        Periodic advertising invteral: 50.00 msec (0x0028)
        Advertiser clock accuracy: 0x04
---
 monitor/bt.h     | 12 ++++++++++++
 monitor/packet.c | 21 ++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index d32d3a153..6494c928f 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3091,6 +3091,18 @@ struct bt_hci_le_ext_adv_report {
 	uint8_t  data[0];
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED	0x0e
+struct bt_hci_evt_le_per_sync_established {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  phy;
+	uint16_t interval;
+	uint8_t  clock_accuracy;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
 struct bt_hci_evt_le_adv_set_term {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 30d432316..3235ad004 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9613,6 +9613,24 @@ static void le_ext_adv_report_evt(const void *data, uint8_t size)
 	}
 }
 
+static void le_per_adv_sync(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_per_sync_established *evt = data;
+
+	print_status(evt->status);
+	print_field("Sync handle: %d", evt->handle);
+	if (evt->sid > 0x0f)
+		print_field("Advertising SID: Reserved (0x%2.2x)", evt->sid);
+	else
+		print_field("Advertising SID: 0x%2.2x", evt->sid);
+
+	print_peer_addr_type("Advertiser address type", evt->addr_type);
+	print_addr("Advertiser address", evt->addr, evt->addr_type);
+	print_le_phy("Advertiser PHY", evt->phy);
+	print_slot_125("Periodic advertising invteral", evt->interval);
+	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
+}
+
 static void le_adv_set_term_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_set_term *evt = data;
@@ -9726,7 +9744,8 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_phy_update_complete_evt, 5, true},
 	{ 0x0d, "LE Extended Advertising Report",
 				le_ext_adv_report_evt, 1, false},
-	{ 0x0e, "LE Periodic Advertising Sync Established" },
+	{ 0x0e, "LE Periodic Advertising Sync Established",
+				le_per_adv_sync, 15, true },
 	{ 0x0f, "LE Periodic Advertising Report" },
 	{ 0x10, "LE Periodic Advertising Sync Lost" },
 	{ 0x11, "LE Scan Timeout" },
-- 
2.20.1

