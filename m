Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4114FC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B272077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="xjK8LfAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgAHLsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:05 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44090 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgAHLsE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:48:04 -0500
Received: by mail-lf1-f51.google.com with SMTP id v201so2186023lfa.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdqyouaOjE7Zju3IK+QZuvXswBq3t65LtLPxvilN7ak=;
        b=xjK8LfApqn0XIO1BFce0pumgu7QAzp4m9W5clxMrGM9SsBXUhdpJ/cqeiO7GTt80S2
         7qHUZvWuRYug4tlbySogs2Pftr/ZYqVV95Zm5SK1HtKp08UVc8ImGEWtHPsHU6vW4Ced
         RWBkUQ5kB0Cx1QIyX7CdSEfkjzEc3/VWl+7tX8vOu1xUtSqIficlW7aEVgKQN7XPbE/+
         TDZVLMb4uOOlTMevp33Vfg8QHHv8uFiIXdZrmCxIJA6VbF54nQoOERWOoLnk4UbFQFxA
         4quCIgrhPDh84WsJohvzJVq9JbXMTap1XFf/CO7Rfssyw/s814te0Y/envYLa2eAOKlK
         PhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdqyouaOjE7Zju3IK+QZuvXswBq3t65LtLPxvilN7ak=;
        b=AIyxRPpEnLja1yjzZ1IYcoVpuu8CVGLjkkrNUU/0ojKBeMkLS5LzpM0P+WYtXl7FsF
         OSCU09Hbeu6PPBN9KHBtRHH6We9Wfwkz/nt9GHA3e4KJqaHphBbUG2cnDLjth8pWsxJQ
         5xyDYKqrssYfAXEeXDQP4cm+bFJSG184Ed1AZJHqoRgPxf3IWLINhoU2EXyiV4kV+J5k
         7s34YMiZpHhMs7F0OtQrszHwJAXXIZkXXVujkWx9vVunlw3pXVUMYJSkWr7juC/608Y6
         LilgxCFpX99kwWuoLIe3qGnn5aqATIHcuZFKsrVFpQUa4HpLxo8BePr7iim4VSXJ6kOJ
         wF2w==
X-Gm-Message-State: APjAAAWtvnrlFOYHowcpRaUNfeRUk0IntbmuUOXuhTyDN5SQsc/DUD33
        cZlP8/LC6gKwbYCRpgNsL7bIAAenHZw=
X-Google-Smtp-Source: APXvYqwaUe6xJjvk1xC2mRtA0AAzOVRW3YQO7x2eHFhaBU5zCsnrRppPoFVcd3dqA1jqcrLP8C73Bw==
X-Received: by 2002:a19:ae18:: with SMTP id f24mr2660095lfc.155.1578484081602;
        Wed, 08 Jan 2020 03:48:01 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:48:01 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 5/8] monitor: Decode LE Periodic Advertising Set Info Transfer command
Date:   Wed,  8 Jan 2020 12:47:49 +0100
Message-Id: <20200108114752.133076-5-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
References: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

< HCI Command: LE Periodic Advertising Set Info Transfer (0x08|0x005b) plen 5
       Connection handle: 1
       Service data: 0x0000
       Advertising handle: 0
> HCI Event: Command Status (0x0f) plen 4
     LE Periodic Advertising Set Info Transfer (0x08|0x005b) ncmd 1
       Status: Unknown HCI Command (0x01)
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index efaf80f55..f8422ccc9 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2474,6 +2474,13 @@ struct bt_hci_cmd_periodic_sync_trans {
 	uint16_t sync_handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_PERIODIC_ADV_SET_INFO_TRANS	0x205b
+struct bt_hci_cmd_periodic_adv_set_info_trans {
+	uint16_t handle;
+	uint16_t service_data;
+	uint16_t adv_handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 23eb48374..34b3d1895 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7609,6 +7609,15 @@ static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
 	print_field("Sync handle: %d", cmd->sync_handle);
 }
 
+static void le_periodic_adv_set_info_trans(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_periodic_adv_set_info_trans *cmd = data;
+
+	print_field("Connection handle: %d", cmd->handle);
+	print_field("Service data: 0x%4.4x", cmd->service_data);
+	print_field("Advertising handle: %d", cmd->adv_handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8408,6 +8417,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x205a, 326, "LE Periodic Advertising Sync Transfer",
 				le_periodic_adv_sync_trans, 6, true,
 				status_handle_rsp, 3, true },
+	{ 0x205b, 327, "LE Periodic Advertising Set Info Transfer",
+				le_periodic_adv_set_info_trans, 5, true,
+				status_handle_rsp, 3, true },
 	{ }
 };
 
-- 
2.24.1

