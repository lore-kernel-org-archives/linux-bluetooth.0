Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B418C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E455220880
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="NT3lVwH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgAGJTD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:19:03 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:46188 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 04:19:03 -0500
Received: by mail-lj1-f170.google.com with SMTP id m26so51468269ljc.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 01:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrOEqRYyPk1wwD6E/tX/caRPJoLfeAjB1acCSvQ2mOc=;
        b=NT3lVwH1dwY9sh3Rw9VPT9n/lpYxf/PtLQBsVT3C6lrat+lzZiLebaI6XOtPH5c4CH
         5rcxXzrmZCF8QqVfmgZBPFr3rk+teFQKjUEolZOoIclX27jo+MGxW0hGldogZgTaXiAQ
         pVefrp8+x6w+0b9ctzirqyBx3W9uGctlZnhqYhDgyOb7RsPtq8W/6aVgsGs73lmz+Agf
         Ep0B4fJAGdJCR8KQ8LW7oL8JTv1oFxhoMQgsAt/qOawJB2NV4d40XDDFt+ubPnQixsIg
         dwCmWXqQVVmQIH/+Q7DWYU8NUGPpvH59+JvWLItvbOs7oBKCk34iAaMbKptxMrAFcFZo
         C/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrOEqRYyPk1wwD6E/tX/caRPJoLfeAjB1acCSvQ2mOc=;
        b=ZN3sRrACrnlj4pxiiFIb4Wejn3JyQQDLWQdPn36kjDLUJcn3ywF9QBfhx/R+rAkL6I
         U0WzB8GGNwwAw4Ajb6wY8DSes3gVGhY+XHdtzsMfgXCEucZ3SfgxOtCscCI//KD2pwJ9
         ImSUbPSedZSqBGhF4Ogizuxj/5ztCnhhCX6LSZ024CYkVNOSHyCdNo5dDW/UgAar2aE4
         AzHFvUD8yAyhjXdUYULq/FbhDx5L4x89kG7fZJ6nNg1Spy+uVmrQXy9UGySv4PiyLYLE
         uSsOiKgdJSbKe18adujr+U6IimxvGC1Uu64jaEXH83fE4agJWQgRjN5Y6xMInaSvBCb8
         CcDg==
X-Gm-Message-State: APjAAAVyizo3+Hh4DlBjRC3awS+d2D536WVz4u4uVHOwZM/Pj4knLDrX
        mBHXtUnC/4C7X2AQvoXquKYfFbeLVjI=
X-Google-Smtp-Source: APXvYqxRT4A+83M8XV98W/UFhJPrqRlKU3pNyviDhsnTYuLHzBAjATZlKiIBcbIlCJmMuE8KXzgPqQ==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr54960665ljg.57.1578388741146;
        Tue, 07 Jan 2020 01:19:01 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d24sm30345292lfb.94.2020.01.07.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:19:00 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH 6/8] monitor: Decode LE Set Periodic Adv Sync Transfer Parameterers command
Date:   Tue,  7 Jan 2020 10:18:31 +0100
Message-Id: <20200107091833.14921-6-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
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

Change-Id: I5cd115eaa4bf411f5f4cd3899ac516b71fcfdd10
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
index 3c3399c0c..4a8404a02 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7623,6 +7623,41 @@ static void le_periodic_adv_set_info_trans(const void *data, uint8_t size)
 	print_field("Advertising handle: %d", cmd->adv_handle);
 }
 
+static void print_sync_mode(uint8_t mode) {
+
+	const char *str;
+
+	switch(mode) {
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
@@ -8425,6 +8460,9 @@ static const struct opcode_data opcode_table[] = {
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

