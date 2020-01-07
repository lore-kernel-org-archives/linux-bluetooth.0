Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B526EC33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8934E2087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="fjJV4N/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgAGJTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:19:05 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35902 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgAGJTE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 04:19:04 -0500
Received: by mail-lf1-f50.google.com with SMTP id n12so38356843lfe.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 01:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r73C6ne2NnSVANSGEmSR1oc9/o9IyEoqU1rQR1TV3SI=;
        b=fjJV4N/pUhF8Q7RhAYglGtx16WYOe/ddPZ1MDxK1TJPtmAFomCo5MDH8kzmDQD6FxL
         Bc4jUkNqaN0yK/RXM1A9pFY4oZq7ZE5Zmz0/HDTPvZIC8eEfhPo1HfWZIwsUXtM2RDXS
         8GPjqoEbk70tsxjfiQojo3rjXZsHJzcIgr0T0Ji8I4hT9TOWV39noYybwEKkeALL0nwv
         K5YmrqkLfkx0sNYyhnB+Jj/hOUqftVT9Co0ZdyVfXQ6viRIRV+6a4X4TuNqiHpkPPSIY
         2YTnnTBkPnqfCcYTEU9nMJrAJBw2CW6yM4mLbc8CsTanZmpqWw7RWmCnKWvsE+LVeWA4
         d2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r73C6ne2NnSVANSGEmSR1oc9/o9IyEoqU1rQR1TV3SI=;
        b=RSi3C7Khc6ai1XE4u+aTeucZKJc3p+bCacgb8OmIz8sof+OsNzUAf+4Lf3bO5e8HBQ
         Kl6lmSTsu0m2pReesLTV/HzelfBsyntpTy8OezfRFHyx0HNgOtro3f4u5kS+UKvmGjJl
         UApFMoE7n1vA0p5AaMSxOvf0FOh7u0djfox+TeuVQrHx+joWwYH1tOLPdjFfFTznhwkO
         EKYIaAp3aziLNCWwjAxxFGZjHz6ncZhmrikj50JYTO5wdxU5rCAJDmQW+KYSPTWQMRMV
         k0WzrHzvYL5CgFKCAesGUCu0sINT7GscjOl3FPY87OV/UumhSk56DfX5AkYzk/BTkyqu
         NmUw==
X-Gm-Message-State: APjAAAXccWE7qch4oyE8AHpX2w9a9vH67JJaTKn0vTWU011UCGQfjcga
        dC8XDT5cLMQiXKsF6dAboCfA1P2PKVc=
X-Google-Smtp-Source: APXvYqyahnpEZOzIv7306AjBaegi+413+njKVkeDVOIoEw6Vw+iMLktosS7/xqgbEprdsTDs8CRIxg==
X-Received: by 2002:a19:86d7:: with SMTP id i206mr57270716lfd.119.1578388742591;
        Tue, 07 Jan 2020 01:19:02 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d24sm30345292lfb.94.2020.01.07.01.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:19:02 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH 7/8] monitor: Decode LE Set Default Periodic Adv Sync Transfer Params. command
Date:   Tue,  7 Jan 2020 10:18:32 +0100
Message-Id: <20200107091833.14921-7-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

< HCI Command: LE Set Default Periodic Advertisng Sync Transfer Parameters (0x08|0x005d) plen 6
        Mode: Enabled with report events disabled (0x01)
        Skip: 0x00
        Sync timeout: 0 msec (0x0000)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Set Default Periodic Advertisng Sync Transfer Parameters (0x08|0x005d) ncmd 1
        Status: Unknown HCI Command (0x01)

Change-Id: Ia88ddc33a59724f5e32624942759b3ef4d6b70aa
---
 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 2ec2ea0a7..1859dfb21 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2490,6 +2490,14 @@ struct bt_hci_cmd_periodic_adv_sync_trans_params {
 	uint8_t   cte_type;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_DEFAULT_PERIODIC_ADV_SYNC_TRANS_PARAMS	0x205d
+struct bt_hci_cmd_default_periodic_adv_sync_trans_params {
+	uint8_t  mode;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  cte_type;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 4a8404a02..d34533966 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7658,6 +7658,19 @@ static void le_periodic_adv_sync_trans_params(const void *data, uint8_t size)
 	print_create_sync_cte_type(cmd->cte_type);
 }
 
+static void le_set_default_periodic_adv_sync_trans_params(const void *data,
+								uint8_t size)
+{
+	const struct bt_hci_cmd_default_periodic_adv_sync_trans_params *cmd = data;
+
+	print_sync_mode(cmd->mode);
+	print_field("Skip: 0x%2.2x", cmd->skip);
+	print_field("Sync timeout: %d msec (0x%4.4x)",
+					le16_to_cpu(cmd->sync_timeout) * 10,
+					le16_to_cpu(cmd->sync_timeout));
+	print_create_sync_cte_type(cmd->cte_type);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8463,6 +8476,10 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x205c, 328, "LE Periodic Advertising Sync Transfer Parameters",
 				le_periodic_adv_sync_trans_params, 8, true,
 				status_handle_rsp, 3, true},
+	{ 0x205d, 329, "LE Set Default Periodic Advertisng Sync Transfer "
+				"Parameters",
+				le_set_default_periodic_adv_sync_trans_params,
+				6, true, status_rsp, 1, true},
 	{ }
 };
 
-- 
2.24.1

