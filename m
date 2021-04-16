Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC44C43600
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029A4613C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbhDPVWL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbhDPVVw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B99EC06138F
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 31so4566684pgn.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ISIKlhBa1+bclaaArV7bVTuJkKj4Zvup3tZjvZTx3u8=;
        b=c/qzf/iBjG/ZbcJboyp93LC31Gtko4U7oxZr1GNhgNUJQdm5Lzr7Zki8/EEDy3+pNA
         ut9FPn0L3Z82e3bMsUR2Vy+Q9fINDvP6HqTU6ak01Evo6xlR+QhfbjhF9A9SNgXC7KrV
         5beKmZJ+CC0+TkvsKrULymPYFsyEj2MhTXRGHqm2xH3xjPA2Ik8RDVMY35XkG9hs9C2S
         2oRar5Xoss64Xoq7obGz5IoO44z2rAfmLF4FbqSj+eBei7Xnsm3vhOJkbnT5d4kWfmMr
         t7X5dgR0PW0e6ibRav2d+7LpP1xLlr6bcUyogYjqLdwaD0y0KvQWj8GRd7HqI3QK1x4i
         NCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISIKlhBa1+bclaaArV7bVTuJkKj4Zvup3tZjvZTx3u8=;
        b=BfMRH1nipxGnT4LV6M9vPN/xcupnyl3QkEWQ4eQSCBuIyaRS+CeCOO2uMU27QCyveZ
         0yAvBxbGQRraCznV0nNnZg8VV2sHFr9BaYH6tAE2dvY+KwR0pBDA2qyBIYicPiVF4ykP
         IaqOiC1Pq82IY8Mf735tidssGSQppsR43dYPs8DveNjxXB0BwE1fuSmgpZj06NPyi1GH
         OQzD6cJE86QBIHWqth8fmwmG4wUkbFitk17GEoZwGBbOnVEn5nn1RPd0RCImpmWzMuA0
         2/3PmjCb4uv8ldo69/V6DZ28JJicp9ITaz9U4TgEl/mVado2QTIeQyxUpTqxGZjRW7Oi
         XEkg==
X-Gm-Message-State: AOAM533+6K/nd81VKNToO5StFGFcuQdcXf6i/5bn16iJuqHIFD3+arx9
        /bMfCm59zyhx4/8IEhuYiwiZVMlfANLXJA==
X-Google-Smtp-Source: ABdhPJyagY5sdSP4J2PDre4RQZdCtqAKWRxmqXSR8LdUR7otf5MmaZA+givUzbAbSuGMErSsif9Iow==
X-Received: by 2002:a63:fb15:: with SMTP id o21mr851255pgh.337.1618607913977;
        Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: HCI: Use skb_pull to parse LE Direct Advertising Report event
Date:   Fri, 16 Apr 2021 14:18:23 -0700
Message-Id: <20210416211823.3776677-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the LE Direct Advertising Report events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  7 ++++++-
 net/bluetooth/hci_event.c   | 26 +++++++++++++++++++-------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9600cc6ad952..13b7c7747bd1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2382,7 +2382,7 @@ struct hci_ev_le_data_len_change {
 
 #define HCI_EV_LE_DIRECT_ADV_REPORT	0x0B
 struct hci_ev_le_direct_adv_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 direct_addr_type;
@@ -2390,6 +2390,11 @@ struct hci_ev_le_direct_adv_info {
 	__s8	 rssi;
 } __packed;
 
+struct hci_ev_le_direct_adv_report {
+	__u8	 num;
+	struct hci_ev_le_direct_adv_info info[];
+} __packed;
+
 #define HCI_EV_LE_PHY_UPDATE_COMPLETE	0x0c
 struct hci_ev_le_phy_update_complete {
 	__u8  status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3fdab3fe427d..f56520eececa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6592,19 +6592,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	struct hci_ev_le_direct_adv_info *ev = (void *)&skb->data[1];
+	struct hci_ev_le_direct_adv_report *ev;
+	int i;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
 
-	if (!num_reports || skb->len < num_reports * sizeof(*ev) + 1)
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
+				flex_array_size(ev, info, ev->num)))
+		return;
+
+	if (!ev->num)
 		return;
 
 	hci_dev_lock(hdev);
 
-	for (; num_reports; num_reports--, ev++)
-		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-				   ev->bdaddr_type, &ev->direct_addr,
-				   ev->direct_addr_type, ev->rssi, NULL, 0,
+	for (i = 0; i < ev->num; i++) {
+		struct hci_ev_le_direct_adv_info *info = &ev->info[i];
+
+		process_adv_report(hdev, info->type, &info->bdaddr,
+				   info->bdaddr_type, &info->direct_addr,
+				   info->direct_addr_type, info->rssi, NULL, 0,
 				   false);
+	}
 
 	hci_dev_unlock(hdev);
 }
-- 
2.30.2

