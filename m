Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhLMVjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbhLMVjA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 16:39:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F9AC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 13:38:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v23so12790485pjr.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 13:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEXaedUJRVwWvaV5+UNIhAI2QJKsPXAblefkp9KOo/s=;
        b=bXSaKkGabwnG6ZkQsAtPpV7WR30ucuNPw7bYd81LRssfTgkpxp1ozdqYncHDlvqSoI
         bLHYRyp+Nm73Kc7Ytxj6Bk+xts2oReeedFuGEpwObJXFCuTUwFP5eG+s2H+T7LE7Dtac
         F3nbIornhu7C8w/xImH2Jvi6tl61KNIk+/PwmEdnJWZFGYDf3/6qpWkJrCVcwgOFPrpn
         qtdZBoTRhzeNMO/dsFr4fkqu5jLCKgkjxC6IZu/FOn2Gddi8FAfudYzqSSu4jHzsUPVx
         MKTs7gCD33dfAjFjaJ3KEKnZXQGfoQxyxbysBP9yJTn5exEz98f4+c8AFQt1y1B9Do04
         ecUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEXaedUJRVwWvaV5+UNIhAI2QJKsPXAblefkp9KOo/s=;
        b=FzZPHymFg6lFwzLG87tV9gEBKJSkl9/Xly9wSBdhGuUAmnwNwXUP3hu9+/BNfqjrd+
         vmvuk2Ila1gjXpeLt5Nq4R4ovRAvRJ9NwScDISL25Y5lUO1wAqRnyR2OTEMWLCs3TOfQ
         6tTv2QplAnb0oW6j4TKM9ThnnHoMmfqzvAOzzCkIJZfYqIlkTiOVVC5pzATHOsO8g+h2
         gIrJNLee1fAaijwMHYemRLGzYheCTYwdO9m5I8Yk/nvWG/JV8Bu6kjqg4BauPLHjds0L
         K5mSiP8IBz3n6oxzeoWFiHv5LlIHxz4GGGTZKeFay0eRh2B3WCCelieMfdmY6NnbA1dc
         k2gA==
X-Gm-Message-State: AOAM531Oam7H5CU8LHXsZZ4nnbD7kWeaTlfpwtzhWfKZqSaTaDwveuYb
        AEY0HJSda+dAk+Wz8y7ungnqgDUXa8A=
X-Google-Smtp-Source: ABdhPJy4HyxNvPj1NwP1VFWs4gKZ0QvwDqTZYOZA5Fueyr67OpTd3qQIVzJ4el08uD+qWt04nPGWbQ==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr1013260pjf.104.1639431539126;
        Mon, 13 Dec 2021 13:38:59 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z2sm13321247pff.107.2021.12.13.13.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:38:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Use skb_pull_data when processing inquiry results
Date:   Mon, 13 Dec 2021 13:38:57 -0800
Message-Id: <20211213213857.2069824-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes each result entry to be checked using skb_pull_data instead
of acessing them by index.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9151d70b36b0..f1082b7c0218 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4530,7 +4530,15 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 		for (i = 0; i < ev->res2->num; i++) {
 			u32 flags;
 
-			info = &ev->res2->info[i];
+			info = hci_ev_skb_pull(hdev, skb,
+					       HCI_EV_INQUIRY_RESULT_WITH_RSSI,
+					       sizeof(*info));
+			if (!info) {
+				bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+					   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
+				return;
+			}
+
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -4552,7 +4560,15 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 		for (i = 0; i < ev->res1->num; i++) {
 			u32 flags;
 
-			info = &ev->res1->info[i];
+			info = hci_ev_skb_pull(hdev, skb,
+					       HCI_EV_INQUIRY_RESULT_WITH_RSSI,
+					       sizeof(*info));
+			if (!info) {
+				bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+					   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
+				return;
+			}
+
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
-- 
2.33.1

