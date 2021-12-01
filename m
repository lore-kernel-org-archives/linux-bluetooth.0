Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB537C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352437AbhLAS6m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbhLAS6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75634C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so18436889plf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5vQn+Qe0kMnjkKX/1BwjLPY1a1irRV2Zdg3iTMrOkRw=;
        b=Uw0do0AEK3vwIK8hy/S7z6/I7RZaCfMut7GlLpZQlCuPRVy90PAxDf4XSYxvW84uXg
         BPwpJO6ccUyuDpE7/sed+EOVO/3PN8mVeSdUDAzJpN7siW/FmhShJ4ULPSsK+ETIOjYM
         KPmcHQpLJCWV0mbABWxV+E42xQcfaI81oKHW0NzKWyGP+B23toHNM0HKEfobe4dzKliv
         8Dp3n+Mcfd/wlONshldpiLPCddEp+XeUUlYB7pqZldg0iSESoY2WgDEuASb3so0OXS4C
         KNrSE9qMUSGdUSIKaUP7PjZdQX4mbH8ORG6aQJHaCO+Vd8Z1DLBD1v6hd8nz0kkwTLng
         yi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vQn+Qe0kMnjkKX/1BwjLPY1a1irRV2Zdg3iTMrOkRw=;
        b=whn3cTvt1F1GyUjcHaN2JKFtCOS6l4+pWmegWPTbpr00go2g8nDHulBgbWWorzg03+
         1LlDJ2gLzPBPYlO1w/0DCHxGfd7muRX3X5Xu1if6ZKJHbgEeoQxnnq8ENGjPe3ozDZF5
         hfV0FITqybm8vDQ5EqcXT3WhCVKJzl7Kr0aqE7nxwnOi3XItZRRiGpqHemQA+Bx+W0kW
         VkZqecpolZQSM/AClWU8oxZT5YHgycEZJ+3RG8bcXr7Q7FTcskXoUJ7qEVOzFzUWpzVE
         mZy0dD/PEF9MwiutwGAhAQapgDVTvfUn1dsSoPhfHGd/09PtLuy8lF4M0zL+85x+9z+V
         6N/Q==
X-Gm-Message-State: AOAM532kv2VL4qCl/12S5pV2s0q4Buqf1UqpxMVIin5iaOjEBGhIBCNe
        PI77xpmbznAJiyttae9MQDfm7Tgq8YY=
X-Google-Smtp-Source: ABdhPJyxOMguDL+6r4jwTDwxTdzTNNvgDsT0pbi+ZLgFWXsQu08EerkaRu1q1Osc/EY57wylZ+h0Tw==
X-Received: by 2002:a17:90b:1e0c:: with SMTP id pg12mr11304pjb.135.1638384911820;
        Wed, 01 Dec 2021 10:55:11 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:11 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/15] Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result event
Date:   Wed,  1 Dec 2021 10:54:56 -0800
Message-Id: <20211201185506.1421186-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the Inquiry Result events received
have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_event.c   | 19 ++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3f57fd677b67..55466bfb972a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2028,6 +2028,11 @@ struct inquiry_info {
 	__le16   clock_offset;
 } __packed;
 
+struct hci_ev_inquiry_result {
+	__u8    num;
+	struct inquiry_info info[];
+};
+
 #define HCI_EV_CONN_COMPLETE		0x03
 struct hci_ev_conn_complete {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b27a4ad647ca..0bf062f6f262 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3180,13 +3180,21 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct hci_ev_inquiry_result *ev;
 	struct inquiry_data data;
-	struct inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
+	int i;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_RESULT, sizeof(*ev));
+	if (!ev)
+		return;
 
-	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_RESULT,
+			     flex_array_size(ev, info, ev->num)))
+		return;
+
+	BT_DBG("%s num %d", hdev->name, ev->num);
+
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -3194,7 +3202,8 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct inquiry_info *info = &ev->info[i];
 		u32 flags;
 
 		bacpy(&data.bdaddr, &info->bdaddr);
-- 
2.33.1

