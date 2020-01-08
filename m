Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4DDC33CA2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8380B2077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="kH9WlUMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgAHLsK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:10 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39451 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgAHLsJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:48:09 -0500
Received: by mail-lj1-f178.google.com with SMTP id l2so2991393lja.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUG4NUiKisBmNULT+8vMhSDE5VM67LNm/WmLM8NesA0=;
        b=kH9WlUMF+uHoILn6c6AAJuL0Y9GhqyJPXPnAMSB2ljRqt2ru2Z80u2QVt3LfQ0wnV2
         LzJpuTmtGctzW+o89U622PlkSWFcATiOlZGIscljLHj4zquHKbhGnAM+oSXgQnCjiCyx
         C5gwZ4YsPaid5zzeefYNc7T+B06VpPGiyVTse0EMPkCEafum9T6jWpEcl/Z46kTKypuH
         E4+snptiSbEdT9YvLdmYSD5uyX422W+1+SaLX+gbKXLy+NBDt1n5WcgT6abJU25Z1+KY
         hpVEXLJe6iI5Mx384OHHtUVqE1nYEJCuusvCrkJPRGzObNt39fD7G9vO3YJTxZ3a0ICu
         HJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUG4NUiKisBmNULT+8vMhSDE5VM67LNm/WmLM8NesA0=;
        b=bUxgSU8PA2/d6qSDcEYTdb+yxwB1uSWYAMPPwCYzSGfT7pojH5Obh8grKBCRp31pUF
         nNgig1Am6t8LKgTPg5N7dzmeecZe43oxae0p3fhNhz+2C525djidzgsCoHgq9mlBw1r5
         oTXsaRf6ZEcBX9/B5TFJlzDjid5ImQ2dvmEj4uQqw9q4HU5Uic9Bs/gGle0E6fAMyHpV
         jPNh1/3Iy6R/B4Sfgd6RoMVhKpdXY6xqew+jmUisrMzFt25/9AaysOHhdDVDkhT62w7c
         njFuati22DQidZnqF4xcR6OjIatIs3kz6ltsIJb45Z52eQJ18y2304QT6FU60HvVL8rO
         caTQ==
X-Gm-Message-State: APjAAAXf0qyZuV+fk1zL/vubb9g+UQXC8y3EVhmVfW5YcOzbAG0Lfv2K
        +lzhkt+1jMjqULRFhmr44R846xeWpF4=
X-Google-Smtp-Source: APXvYqz/QxmVanFVqjLyUm8B3mEV4/jceXi1xLfUZ25saLm+Q5tpZcdwJNfz05vlwV9iFPSGHVtq3A==
X-Received: by 2002:a2e:580c:: with SMTP id m12mr2702311ljb.252.1578484085781;
        Wed, 08 Jan 2020 03:48:05 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:48:05 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 8/8] monitor: Decode LE CTE Request Failed event
Date:   Wed,  8 Jan 2020 12:47:52 +0100
Message-Id: <20200108114752.133076-8-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
References: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
index 9d22dfc15..415a6abfa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9886,6 +9886,14 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
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
@@ -9987,6 +9995,8 @@ static const struct subevent_data le_meta_event_table[] = {
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

