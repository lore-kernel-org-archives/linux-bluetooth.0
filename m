Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D245FC33C9B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B4C2087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="IckjRr3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGJTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:19:06 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38287 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 04:19:06 -0500
Received: by mail-lj1-f172.google.com with SMTP id w1so31973705ljh.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+vz4hj1Grh2R+H7b4jsYt6K5yUPYJall+NdLNYuRto=;
        b=IckjRr3TABF/XJoHDKT8VFAjo/xpJfYOPGkwXiL+bo7PEgxSE8m1lWiT3FlLJgt+F5
         JxsrjQmLtO7s+wvza9oQIOXlW4R2RqXTTZZXj5w8SH5dNsYwQE9gY98dMdpm791TS9tb
         NYxqgHk9DqCedYuKyRAMpVARMWRiCuf2pHFMwgMazmkejatkzUi46+9kwA8+i8Qg7TPN
         v9CBaLq7M8zqV9vOL7brAINYWarB4yoMix4BNajwLzsS8EYiXl29LYFcupU6A/I0oZt+
         1z+DTbD4cyDcwIM3n8hHRWdD9BcSUaifqKbhzVwwZy+V5OdMXi1e8Hi+aq9f0+5yjT5M
         qbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+vz4hj1Grh2R+H7b4jsYt6K5yUPYJall+NdLNYuRto=;
        b=Ox1ivaYZo/M3M3kFZmFa3MbI5NihXd28BTyjsdqH84xNm/zNXky2j5su5CCC65zXS4
         sfHokFyPd/oJIt1V5JFFtXxNrw0EfSJZ0yDIBc575XpEl6vWAMhT1dqW1Dwrl65Fd0lX
         FuF+3WiDHfNoGooWFTO8nuqujvt8V+rnhgwsf+kaT/+VFdq1wLVw0tDD3B/VLwpyj8jD
         VeWsKfkE/ynSHitgPr8ezgZaRNKcT8qvhu8Cc+uISIqM0xNq1d1h5Vn4NYSJilDIUmsk
         y1wG3wrgNwsoxPAf0TpETuwzdIQ/64qcM8fvWpAn6H6Zw96g9Cdk0yDvUKc554I2g6MS
         2rQA==
X-Gm-Message-State: APjAAAUbNuz2J7sIlWJlouUQrHps+MhSCd8nFPjqv7LSvLUl1JhuBk+f
        XYnRn4gKOnLr5GEg09dzxgx6r4Kxfh4=
X-Google-Smtp-Source: APXvYqw68STuTvL6sRF94S630KtSxaOrBqR50oYk37FRJ7B73jxzVlYx9lG452IgBL8eK+6IAn+E5g==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr63681226ljj.208.1578388743959;
        Tue, 07 Jan 2020 01:19:03 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d24sm30345292lfb.94.2020.01.07.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:19:03 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH 8/8] monitor: Decode LE CTE Request Failed event
Date:   Tue,  7 Jan 2020 10:18:33 +0100
Message-Id: <20200107091833.14921-8-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change-Id: I71f84663461e5d0a3403ab43d33d276bc302acbc
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 1859dfb21..b31e6c5c5 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3177,6 +3177,12 @@ struct bt_hci_evt_le_chan_select_alg {
 	uint8_t  algorithm;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_CTE_REQUEST_FAILED	0x17
+struct bt_hci_evt_le_cte_request_failed {
+	uint8_t  status;
+	uint16_t handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_PER_ADV_SYNC_TRANS_REC		0x18
 struct bt_hci_evt_le_per_adv_sync_trans_rec {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index d34533966..3450373b0 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9891,6 +9891,14 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
 	print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
 }
 
+static void le_cte_request_failed_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_cte_request_failed *evt = data;
+
+	print_status(evt->status);
+	print_field("Connection handle: %d", evt->handle);
+}
+
 static void le_per_adv_sync_trans_rec_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_adv_sync_trans_rec *evt = data;
@@ -9992,6 +10000,8 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_scan_req_received_evt, 8, true},
 	{ 0x14, "LE Channel Selection Algorithm",
 				le_chan_select_alg_evt, 3, true},
+	{ 0x17, "LE CTE Request Failed",
+				le_cte_request_failed_evt, 3, true},
 	{ 0x18, "LE Periodic Advertising Sync Transfer Received",
 					le_per_adv_sync_trans_rec_evt, 19,
 					true},
-- 
2.24.1

