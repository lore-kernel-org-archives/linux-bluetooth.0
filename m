Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF7BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352569AbhLAS6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351888AbhLAS6g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5BC06175A
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b13so18449549plg.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TR5msw3HgDvkV0NY0xMd3R5/Y+9WHFDKSZCOK0wsevM=;
        b=JerLeTZXuxv/7+E80P3VR46eq+LvwHUM9C+Q47tofHRe/Efp800v0j4qdoLIkP6M0p
         MvGilz+0MSreGpEIZdMe49i7lsOv5pOzI8kKkZzSNyPfQVURIBDNyARjlrPT4/jWdBMR
         /kwpXOUpzx2R7TCRKbYJmcCunHUWkbsZpwT7uClRsDzKcKpC011C5EJDnCm6Q1sY1gYA
         Lmz9izTJUDYwTl6jqklSpN8sl+9zTubAenqrIafM9Fr79b/FnVgKdZP7nZCQXqyujAWw
         5n1vfvJBg4lwN/RbeDAZ0sV5/bH0wGihvkudZ7J7zXkZaLsaVmrhk7K/1SzlLhGrZ4Br
         Tw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TR5msw3HgDvkV0NY0xMd3R5/Y+9WHFDKSZCOK0wsevM=;
        b=LOZqMcklm8rmhyO0JunOumk+8ZXOhM0gRZjxSjbFedQeQpV7hpYtuCxXHJp6yzIvCo
         aTwhcQV+LgzzFDkiadz4Qvb25yfPoS+zz8s6hYZph8m/zclzDboSNhJ3DqKGAjC9eQGN
         vj7eupLJeE6K02IiN0EMetGaf1Tc6vKHu1Ts57tW8APUJiHUI/JUifeuk78p/B4MGBSQ
         ZnDs3UZTNtS1LMwoEFPtu0idk7rAJt1gjtgpXxHnjeyONTn5EwAmw2cDSkhabqCwpaUu
         /ttZtBSi9rFfqBOkuhNSPPHlC7avm/j8on/R/owuM6mjZOfmABn+42wv92+k1+h3ThbV
         LbfA==
X-Gm-Message-State: AOAM533btTwu4XQbzxgTIkIsNXyWuxFf4ufPEceYGJWMG6NWNLbXbJIc
        mU5K5g3V7zSyJ1g2OoVWQnK1co2mJq8=
X-Google-Smtp-Source: ABdhPJwRNXvmwGF7PoA2qzLOvcDZPbWsgoi17+8Oy2NvoY+/w1nq3FC5XNem3pBl/FGjIYiCZ5vWCw==
X-Received: by 2002:a17:90b:4f86:: with SMTP id qe6mr43900pjb.224.1638384913064;
        Wed, 01 Dec 2021 10:55:13 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/15] Bluetooth: HCI: Use skb_pull_data to parse Extended Inquiry Result event
Date:   Wed,  1 Dec 2021 10:54:58 -0800
Message-Id: <20211201185506.1421186-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the Extended Inquiry Result events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_event.c   | 20 +++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d25afd92a46e..9e721e6efef3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2273,6 +2273,11 @@ struct extended_inquiry_info {
 	__u8     data[240];
 } __packed;
 
+struct hci_ev_ext_inquiry_result {
+	__u8     num;
+	struct extended_inquiry_info info[];
+} __packed;
+
 #define HCI_EV_KEY_REFRESH_COMPLETE	0x30
 struct hci_ev_key_refresh_complete {
 	__u8	status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6560dca8c5ce..89c263c1883f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5186,14 +5186,23 @@ static inline size_t eir_get_length(u8 *eir, size_t eir_len)
 static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
+	struct hci_ev_ext_inquiry_result *ev;
 	struct inquiry_data data;
-	struct extended_inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
 	size_t eir_len;
+	int i;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_EXTENDED_INQUIRY_RESULT,
+			     sizeof(*ev));
+	if (!ev)
+		return;
 
-	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_EXTENDED_INQUIRY_RESULT,
+			     flex_array_size(ev, info, ev->num)))
+		return;
+
+	BT_DBG("%s num %d", hdev->name, ev->num);
+
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -5201,7 +5210,8 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct extended_inquiry_info *info = &ev->info[i];
 		u32 flags;
 		bool name_known;
 
-- 
2.33.1

