Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30760C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058552077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="zQjc+9PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgAHLsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:01 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:35779 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgAHLsB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:48:01 -0500
Received: by mail-lf1-f47.google.com with SMTP id 15so2227488lfr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHTrZ0QELKPawLm9od83NxjHR6BBZ+SXNdRLMQ7KZHQ=;
        b=zQjc+9PXWza/zCEThwk9gbouYpY3BKI7+XgUs0aUWb7/TgHqar/wTkNoPHLVeb+DiO
         pXc+GvpT4l8Wq2unstzm+p5+LKoBSJzDWMnTbypCWkFpngmJb23T1GgPWeY4gmq7qVSI
         Ly8ubPnoVbB04PjHc+6636fre3pWbz117M3Z21BDA462vz8iMXOo5BXFcY4TaUEYYgnK
         YKEOzbUYq4St9O7w8DwDnxU0ik/yDXluptPa/P6bQB0LmDWDEHiiOZSFPg6w0YO92lfs
         xy/bCyllK8IwhgdkE5bFb4BG0luW3Wj03p5mZKQplhYiqSgqQkansw5EJqXQnC3HRntP
         cNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHTrZ0QELKPawLm9od83NxjHR6BBZ+SXNdRLMQ7KZHQ=;
        b=bcjmJXe48KP0U9hUdLZAQsyLiVDxqWsLmf0fpzyhzPwlgB4HDFSyzIjhMR3wGhNX10
         Ny6OA1mMUNqV1uUNL3tkYL+XaIdaQsh9pXfNZiZj5ClsXDNoEDm1FGOJ3eYKJrF1ZFCq
         hI/7wOI1RBXZHdEtxlsSOiPJXXav7wR2S9pqxockO/EbOuLdrfMFEo44t1IeA58EON8/
         Y7xotaKkxxgDlohkXIwmmJYAJtlQKh1vgFWT9cNVcRg3Quy1mJB2OHMVlIIQ/QX4MOo5
         G9X2ZvY3tQXq+V+ENcUZzu4zCo93aO2xJNWmor80d180hdqo4HZ2zBC6pL7QCZUznLL7
         MyYQ==
X-Gm-Message-State: APjAAAU8nL8h3A0kAYZHHhav7o+hZDGd62hTfQPVJFL86eaECs4HeYlP
        BURPzVIa9apb59p06ULE86jQWrwwEFc=
X-Google-Smtp-Source: APXvYqyb7Zgrcwd3ncpYUmrPD5sp5ETd3iZK6iATCy2vRQw7Kx2W9u4COY7aUqp8xC6LWHGXNcxzfw==
X-Received: by 2002:a19:2213:: with SMTP id i19mr2573656lfi.83.1578484078857;
        Wed, 08 Jan 2020 03:47:58 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:47:58 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 3/8] monitor: Decode LE Set Periodic Advertising Receive Enable command
Date:   Wed,  8 Jan 2020 12:47:47 +0100
Message-Id: <20200108114752.133076-3-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
References: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

< HCI Command: LE Periodic Advertising Receive Enable (0x08|0x0059) plen 3
        Sync handle: 0
        Reporting: Enabled (0x01)
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Receive Enable (0x08|0x0059) ncmd 1
        Status: Unknown HCI Command (0x01)
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index e14c1771f..bb373b528 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2461,6 +2461,12 @@ struct bt_hci_cmd_le_tx_test_v3 {
 	uint8_t  antenna_ids[0];
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_SET_PERIODIC_ADV_REC_ENABLE	0x2059
+struct bt_hci_cmd_set_periodic_adv_rec_enable {
+	uint16_t sync_handle;
+	uint8_t  enable;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 8e5219bef..e5681b5ff 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7584,6 +7584,14 @@ static void le_tx_test_cmd_v3(const void *data, uint8_t size)
 		print_field("  Antenna ID: %u", cmd->antenna_ids[i]);
 }
 
+static void le_periodic_adv_rec_enable(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+
+	print_field("Sync handle: %d", cmd->handle);
+	print_enable("Reporting", cmd->enable);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8377,6 +8385,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2050, 316, "LE Transmitter Test command [v3]",
 				le_tx_test_cmd_v3, 9, false,
 				status_rsp, 1, true },
+	{ 0x2059, 325, "LE Periodic Advertising Receive Enable",
+				le_periodic_adv_rec_enable, 3, true,
+				status_rsp, 1, true },
 	{ }
 };
 
-- 
2.24.1

