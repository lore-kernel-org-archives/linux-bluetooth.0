Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 21:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhLMVfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhLMVfv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 16:35:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BFAC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 13:35:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id k4so15684329pgb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 13:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEXaedUJRVwWvaV5+UNIhAI2QJKsPXAblefkp9KOo/s=;
        b=MG8SlaM7i7DeXe5qv5MErkSlfUp6rPJL+a5/jsLOp6wiuam00EbpoP0niUfcPcLFsm
         FntLhV8Wz7JDsOEl+QynC5dncKURzm7+SLV1wSVag4gB0tzs2pipWWjd8qZ89O0Qkqz5
         CPfzzLtBBj7/KACZDISAirvxporpd873hYnyXm+pHJc/BXzyxD5OBv7t+XnLDTDf6Gui
         gnIyQ7/Ll69LSUUACDjWTQyf0BgqLJUVxqi2y4D+IbmfaITxpQdeN9F4FNKZSbN0tmU8
         4nQecn8F2bEnflo/Mw0nRL978S6YsmsnwlzUDQ08mqeLCFS8cUjM3EcOxG8CnfOKRI/y
         EhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEXaedUJRVwWvaV5+UNIhAI2QJKsPXAblefkp9KOo/s=;
        b=uoKpOcbQoDWh5MpgCF7tLC7aG/Nn8O/wS3fbreCRSGmhsrrUbAaGT+tAgUbEuFOhaG
         DPcRWPo/wuDTPQ6BURIW+iZ4YvJJVjFR1V7Obehz+i8ryO+evKP3H3HiuYwPI/zBFhpQ
         BrYUtvfXb5NvrxN2tlEgz1rtOvHzHpXxWfg+yTogMX4gAlW7o4kFGV95H9ycBgvex+iR
         tCqYw5UoC/2neetLmwI69+V9sIxiMFS6etksa2vpNYBCKXpJEqoFJB6oZAma9yEogdjK
         ZFwvURATfAooBPdE4VQbo7VwaEQt6dEIl8WdaWOmcb3TjY8V3TuEPdDAKqoS+qp9POfR
         ZItQ==
X-Gm-Message-State: AOAM531vXDVGuwfe0NSp+4KBXyojdEYk65/Pmyk9IXWevNciWUJbqVEq
        W7vUD3e8kaDxguVul2t8k18cpUeHoFQ=
X-Google-Smtp-Source: ABdhPJwAeJCpO1eQzYwICtbeJXINg9hmdMwYsjXteY7HKAslt/qPIJG47D2Xq7hZpIMnWIUQrMx1MA==
X-Received: by 2002:a63:1166:: with SMTP id 38mr884897pgr.368.1639431350540;
        Mon, 13 Dec 2021 13:35:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u17sm11899285pfk.179.2021.12.13.13.35.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:35:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Use skb_pull_data when processing inquiry results
Date:   Mon, 13 Dec 2021 13:35:48 -0800
Message-Id: <20211213213548.2069212-1-luiz.dentz@gmail.com>
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

