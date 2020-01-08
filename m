Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096D6C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F332077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="BHj9Nu9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAHLsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:05 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:46564 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgAHLsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:48:05 -0500
Received: by mail-lf1-f43.google.com with SMTP id f15so2186463lfl.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH2AkhQXMMBWcVM4lm9OL378wWwzbVXmIxi4gTdg00w=;
        b=BHj9Nu9gzTOqE4uKJc2Bs+6DmHtFJsv2edzI209IRT0i8R3kKHVl90w+0DoRZ79XY0
         ldwlnt/EmxNnq8fG1bCTvkNikVKt3zJoNHASeW0XrCfA/dGVQq0QPJ1GSrF3DiDK7rJt
         MuLNEuW9tmOUIJ3tPJgSVJ22ZbKg52YDJTN5MQ5nq564FcAhXD+cYk+BbtW6z+hRF+lq
         jms/hG6MRBiT9ndKOFLAHGbP3HQVwZttW65oGJofukwrN2+JqHyLEUY8EeRHu1Cbxlxu
         gvJw7mVFoAY22S9GVmKyNoeO1j/LKSlWYxMnrdS1vU8c2TqmlHdJuKlWmfUn1GoSNUKA
         2W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH2AkhQXMMBWcVM4lm9OL378wWwzbVXmIxi4gTdg00w=;
        b=ApqFKbmJfZaGw1ZBmWqYgRJyigFI894slGM9/yXLfDxGmf2aWUjxoxr6EyLuoCj7tD
         OLTDmJnmCixQ9FMy5PnY+RZ+NMq/kw/I83cli0mUKd8LOwGqQoCfKNnDK5vAiui9Ia31
         fEy4iM/K9rtxZTtzHJ2vJg2/7tWoxaafMam1Wmg2DjcPIWFA62qJftJPy4yv3SHtTvdT
         LUiyKQ/MutUYBPAfJVxa2RuTkyqkmv4UFkEZlmHB9+lqX4bUhy22YSkU0AZQoYpdcwGb
         PBbh8slI/I++YTY2D9F5glt81k1sL3Ae6T1XPWSKhajUV/BmyfFw6/7ccqjrDuu5sU9S
         qfBQ==
X-Gm-Message-State: APjAAAUw5yNoQjeBss4HbZxfMexXp+i29F2zVvt+vvrGqc+HdxAS1J/C
        9jDl62fYZcco+UEt0SjAZayM9jYAr+4=
X-Google-Smtp-Source: APXvYqwPZSmE75/Jg59VMCJq/tmyuWprK8LiKvH7XHuWCK8ai4GIgH/DCudZLYE/DQ9ZeilkCu9JYA==
X-Received: by 2002:ac2:5292:: with SMTP id q18mr2618151lfm.103.1578484083032;
        Wed, 08 Jan 2020 03:48:03 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:48:02 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 6/8] monitor: Decode LE Set Periodic Adv Sync Transfer Parameterers command
Date:   Wed,  8 Jan 2020 12:47:50 +0100
Message-Id: <20200108114752.133076-6-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
References: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

< HCI Command: LE Periodic Advertising Sync Transfer Parameters (0x08|0x005c) plen 8
        Connection handle: 1
        Mode: Disabled (0x00)
        Skip: 0x00
        Sync timeout: 0 msec (0x0000)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Sync Transfer Parameters (0x08|0x005c) ncmd 1
        Status: Unknown HCI Command (0x01)
---
 monitor/bt.h     |  9 +++++++++
 monitor/packet.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index f8422ccc9..2ec2ea0a7 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2481,6 +2481,15 @@ struct bt_hci_cmd_periodic_adv_set_info_trans {
 	uint16_t adv_handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_PERIODIC_ADV_SYNC_TRANS_PARAMS	0x205c
+struct bt_hci_cmd_periodic_adv_sync_trans_params {
+	uint16_t  handle;
+	uint8_t   mode;
+	uint16_t  skip;
+	uint16_t  sync_timeout;
+	uint8_t   cte_type;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 34b3d1895..74c73f145 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7618,6 +7618,41 @@ static void le_periodic_adv_set_info_trans(const void *data, uint8_t size)
 	print_field("Advertising handle: %d", cmd->adv_handle);
 }
 
+static void print_sync_mode(uint8_t mode)
+{
+	const char *str;
+
+	switch (mode) {
+	case 0x00:
+		str = "Disabled";
+		break;
+	case 0x01:
+		str = "Enabled with report events disabled";
+		break;
+	case 0x02:
+		str = "Enabled with report events enabled";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("Mode: %s (0x%2.2x)", str, mode);
+}
+
+static void le_periodic_adv_sync_trans_params(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_periodic_adv_sync_trans_params *cmd = data;
+
+	print_field("Connection handle: %d", cmd->handle);
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
@@ -8420,6 +8455,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x205b, 327, "LE Periodic Advertising Set Info Transfer",
 				le_periodic_adv_set_info_trans, 5, true,
 				status_handle_rsp, 3, true },
+	{ 0x205c, 328, "LE Periodic Advertising Sync Transfer Parameters",
+				le_periodic_adv_sync_trans_params, 8, true,
+				status_handle_rsp, 3, true},
 	{ }
 };
 
-- 
2.24.1

