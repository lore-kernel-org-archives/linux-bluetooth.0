Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F9AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 22:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbhLUWeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbhLUWeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 17:34:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B0C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:34:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v19so351342plo.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BEXaedUJRVwWvaV5+UNIhAI2QJKsPXAblefkp9KOo/s=;
        b=j3sisNaEsKXNQiNTWvVRZhDLkXfaWM4ev+7FDw884kkvBNXUZPI30Yjyuk0wVio9fU
         eDmquV1YOyIQSidlG5JsAScWJ+sLuies1oSdBmkitGWdrbujeMySfX1EuJMNloVC/PMt
         u0yjtYYcXS1kU4FWn9FYuWNbpTo39W4zSYW6rydZiZ8vClr8qTk75R4zqoxyZ2L1F0Pg
         mZ9MbjdUdah4yWOwNm7Cn//WSqrSB5a2VwOhr/0KHgMPCB5lWUghnHvOJcLJa/In6+88
         pIBXrRDPpTrzyYd5H9yn9uZpJHpl96FT1CvGR8Nh9FxmqB3YTzOSOTa9KKxsIylQOEb7
         oXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEXaedUJRVwWvaV5+UNIhAI2QJKsPXAblefkp9KOo/s=;
        b=YP/jqI3B0DC0UTKHHLK7YuXp1TEJmGo05EyPPhUJxCI10f6DKRny/0uCFHrDY6IXIg
         JR1iKZk3k1HmAU+Ey1BHDl5R/GTGEOmqCYOh1Qr9lgjTMXoYHyKWqopO8QOLZ1eOmwU4
         sVqQ5bd9FHD20bIS6E2afwCanNzrjk7wikn3DYMlvrNGBy6Zz0TrOs27IIYgFFKjgGW2
         60Wn9bUrSiz1gtJ/bvaKhmscDyEb6qaOwo9pKVedf0PI96+0JDQSNasu3qwxMNA+yc6J
         Te0EeXMwSJXkL0G+bLIE4xBHkaPu4jWljd8E5vRwCgZyFJSGOFPJ60C7KtYJScMYEqhP
         D37w==
X-Gm-Message-State: AOAM532f+UEht/mqaPUz87ul1IodhPzQAMt+2KViGGjOFpYZvYXYpcXN
        HcqVRNMexM9eWKs2cp2vg4UQDsH4haE=
X-Google-Smtp-Source: ABdhPJySiWU/UIbHedpO8MEV0eOtq+SeZ5Iak05UqRjhJGWzgcq3+b7h2VNSma737bkq2Hu8sTH0aA==
X-Received: by 2002:a17:902:e749:b0:148:a4e1:4fb4 with SMTP id p9-20020a170902e74900b00148a4e14fb4mr388758plf.111.1640126040974;
        Tue, 21 Dec 2021 14:34:00 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id np1sm3872209pjb.22.2021.12.21.14.33.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:33:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: hci_event: Use skb_pull_data when processing inquiry results
Date:   Tue, 21 Dec 2021 14:33:56 -0800
Message-Id: <20211221223357.742863-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221223357.742863-1-luiz.dentz@gmail.com>
References: <20211221223357.742863-1-luiz.dentz@gmail.com>
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

