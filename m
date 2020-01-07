Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79993C33C9B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A32087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="HjCx31Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgAGJS7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:18:59 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44866 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 04:18:58 -0500
Received: by mail-lj1-f169.google.com with SMTP id u71so53908284lje.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 01:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=As14hH5XTd91cqludgJ3ZyIIxEQXQtCoXFONbDuSuOY=;
        b=HjCx31UnS6dgpILh/wtsLpyp2x2jYTFmMyqj6v+9YJ3Vye88N7FVsI3mFmPOtZT8wM
         dvL6p8IggFfcos7JDo4XjwAQVXRQyGvf+99qHZyv9MYg+aQs/kg7974eT/srAYjMkdHI
         pPsmOLxBG9t3fi8INAc8qqAaHgqfD0/ClTVkfcezksTl4+hReQz+8lkChuhqJRKnYazK
         Q0ZczXa30A//Kahq0W0QJWExua94M3GbJTc8MNekJYsDCSPH3nl8JRm+V059onok6BYC
         YkP1pR3z2fuZVOMEHnpgk/8qV3bZJ6tQdh08vpFTEbolZ5yCODIrqQGO4QtvVM78ZFTD
         TCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=As14hH5XTd91cqludgJ3ZyIIxEQXQtCoXFONbDuSuOY=;
        b=fVa4fRlu8lQd9hCFMggBpoOUo+TvCiQPIb0iQfTYfwYHK2RsosWB1bNxEBde9S39ik
         hJTHYgvHm+bjTBs1LyEXvoH30EAFDHxazmDOvo2vE1uFg5x+v86JUxHn7g0WGlXWmf1o
         5EOJSfHxZJqNmONzzDOubAvT6DR8nwC3KH7huKviLJOTKrGnu3U0/ZYC+Pe96U87D6zM
         TLXI6wauc1JKtoGKRPQYwMCCahmtiS7Fgz0WnHxGiClFAiTOi5i/OV1gXtkTlPqdzBIR
         5rWDXbTPmn/geT82CaS50lWjQI84Mva6d3WmStKZtfXLjmUKWjgO6X7RsZN51CaTb5x/
         ccVg==
X-Gm-Message-State: APjAAAXHOM7aQvYWsqAB5khRFAd+jjoyq88uWoPquCFS5haLM8if8+g9
        esQozVuYox4VpJEqiFsE67kyQUpMi+8=
X-Google-Smtp-Source: APXvYqzFrdIJ7ZqvdLg0idamrZNMBwgf2+QCIeeEFGsAWMtgLmWSEDUz0tq4aIdMYi76fGK5MvJY0A==
X-Received: by 2002:a2e:8595:: with SMTP id b21mr43034503lji.219.1578388736729;
        Tue, 07 Jan 2020 01:18:56 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d24sm30345292lfb.94.2020.01.07.01.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:18:56 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH 3/8] monitor: Decode LE Set Periodic Advertising Receive Enable command
Date:   Tue,  7 Jan 2020 10:18:28 +0100
Message-Id: <20200107091833.14921-3-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
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

Change-Id: I19d3bfb7034992a14273b742b38f2c6cc6bd6deb
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
index 76bb9f239..c1e449a68 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7590,6 +7590,14 @@ static void le_tx_test_cmd_v3(const void *data, uint8_t size)
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
@@ -8383,6 +8391,9 @@ static const struct opcode_data opcode_table[] = {
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

