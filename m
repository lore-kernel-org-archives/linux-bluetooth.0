Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D0BC33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03C42087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="oV93hU/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgAGJTC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:19:02 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34214 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgAGJTC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 04:19:02 -0500
Received: by mail-lf1-f45.google.com with SMTP id l18so30191327lfc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzmDCgSzwDe/oBRTdtouSyE3ygFLPIKVa0QL4AISUOE=;
        b=oV93hU/pDF9ONwmDR2CpPUvx60dJfyeFmAyRe6AFIIgI+QvdZluY0Gc+kN50/OzqBI
         +Jtgw/76reX6qSL0FndlaDC6DNiE6z2ylyAurJg/+SIaZdeqtBUyHmV1tUGx38mDaW6h
         3Q6Ff4n/PUWEzDsygJU7KyaVJxkMiFEHhYmFe8XYNl75lbIP2jgCIbJ41pvy26eyfCms
         3HaItKwGs2HNQy0Iv04IlpjegPmyJBUuULLj/Z13jxA5oiD5MfvtTdvJj7tV6N+rGxB6
         ROjM2Hy8OUQoxCXtxc48GfmWi8Jz9l6cPk4Z+XXM1G5jvAZaaIt2/lDJfUUrovQNP1av
         DAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzmDCgSzwDe/oBRTdtouSyE3ygFLPIKVa0QL4AISUOE=;
        b=ujCvdzi4HpFIaWlPZ4N8LDDMLyrVEvV+hXMzNoMd/d81jI5OmmkmugYsuCejzSRVtf
         nWrNrVQ7OU31O071EPnQosQldzDj7viiV1netDOts/IN2iiWBh/R0TCDcGPNfwjh6mTt
         wy6wF7hBaIUrzk0OUocxic0LC2RFpRKPU7VEiD6WpQ4Di4WWwXyfE+0oj54gJBkxq5G6
         V8AjoTwj2rJSf1RjZ+AOqhCZXHCqkd1EVT+v0Bl85Oo2kNvQ9VmV1eCuVN5FyKqGppWi
         j86tkOpjut9JaONcjYy/J36NMUcafwyZOI7k96rRM8m5YXnZYU7t+z2lWeEdvbk/Fp7r
         C5mw==
X-Gm-Message-State: APjAAAWw/u8QvRsVz2XBhuteQIqNg0FSYfG+2TCe4DxL5ZuhWYuQkGyZ
        fjiosXTUDwtIgwf7oRAqu+zIH/KxO38=
X-Google-Smtp-Source: APXvYqxPb4YkONhtRXJTfqtDj8wFC0PfOGTgY6wyxqZORm+awaqFHOOkW01UZATf6YwTBgiAracvfg==
X-Received: by 2002:ac2:485c:: with SMTP id 28mr58608144lfy.118.1578388739725;
        Tue, 07 Jan 2020 01:18:59 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d24sm30345292lfb.94.2020.01.07.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:18:59 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH 5/8] monitor: Decode LE Periodic Advertising Set Info Transfer command
Date:   Tue,  7 Jan 2020 10:18:30 +0100
Message-Id: <20200107091833.14921-5-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
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

Change-Id: I4167e85f29e20304d1b72ec537ece70a68e8407e
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
index 06fd72537..3c3399c0c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7614,6 +7614,15 @@ static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
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
@@ -8413,6 +8422,9 @@ static const struct opcode_data opcode_table[] = {
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

