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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D71C43470
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546F5613CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbhDPVWG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDPVVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAFBC06138A
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w10so20036520pgh.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d0ZonNTHp8mR8G7j6/vhz+gEG9b37LmUnpHTcSX6kY0=;
        b=dulTM5M3iwDDYX64bfHFQn2QvJtLKnlQwrD8QuzAFZfsXb155jn+S1P4Y7gGzmfkKB
         P1uYPLvlFGI2ddUEM6lAPYtUdQBUbrWWm1dVkm7/vXZSxdwVIHZb8cwhvmYqwkRt9dOT
         J+D8RuJUrVP9louNsd/AtywfJZMG9B1zWc77d4rxhvA7WVjLar/emKto6yfQKkg2aTEk
         PqyEcPniO63eCfv+pWMqWqZMP2DIIMcFcybhwWYrVZUYk8PkOHsw3DyoCC0HxfagxAgB
         RJ0W8eZRf/Wnburw9fV3pRsYZC6s3Cbbh/7GobgYRTaJw3pQdbexd0eMGAEJVgsFXQFv
         hskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0ZonNTHp8mR8G7j6/vhz+gEG9b37LmUnpHTcSX6kY0=;
        b=FQW3Xu5YVdHPYWRu0s5XifZZ3NRKqa9d4D4816vvUymAO/LZG2VcYEuJhc/TRTTM7W
         J10KjiBFZcNOeUpeP6hjPzHlVLj1nEFcnHTr/HD/heniZmaSpHnV4LgPPB0VZnY1vSZr
         qi9+kFPfqT9FL3ed/Opt+6I+QCHsNefOZqf6Ed14N78//PmE0ahYpWNQMiEM/zD3Rhp2
         /i3j318uGPDxYvVqjQWn7kFq3jYpu7GmIERI/5NpMmBT1mVTGe4UibU5yOlk0PdvqDZq
         M5EtcLImrDhh8oQSpMreoo1i+/IxcvGAqXjAav6KpSvwCZmEWYNg9TJcGlU5l8e1CWgf
         kj6A==
X-Gm-Message-State: AOAM533IidXw9zMX3bqjHvDu7vSjrSWB/2ioeoRDcMrrqX5j5qKVC3WC
        ks7l5M/IECZIBe3TnDgGO5mFbApBRpIZCg==
X-Google-Smtp-Source: ABdhPJy7vG40+zdAxYCs0xWIHO2BX+Hz6MccqIMKqFpAuKfz5Ysh2ENnUenfl9CvlLSzbM/eMdgcag==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr884156pgc.50.1618607911116;
        Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: HCI: Use skb_pull to parse Extended Inquiry Result event
Date:   Fri, 16 Apr 2021 14:18:19 -0700
Message-Id: <20210416211823.3776677-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Extended Inquiry Result events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_event.c   | 20 +++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 53e16ad79698..f416ad71fd2d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2155,6 +2155,11 @@ struct extended_inquiry_info {
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
index d0e7744e9e7e..efa18a65ab80 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4969,14 +4969,23 @@ static inline size_t eir_get_length(u8 *eir, size_t eir_len)
 static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
+	struct hci_ev_ext_inquiry_result *ev;
 	struct inquiry_data data;
-	struct extended_inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
 	size_t eir_len;
+	int i;
+
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_EXTENDED_INQUIRY_RESULT,
+			     sizeof(*ev));
+	if (!ev)
+		return;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_EXTENDED_INQUIRY_RESULT,
+			     flex_array_size(ev, info, ev->num)))
+	    return;
+
+	BT_DBG("%s num %d", hdev->name, ev->num);
 
-	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4984,7 +4993,8 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct extended_inquiry_info *info = &ev->info[i];
 		u32 flags;
 		bool name_known;
 
-- 
2.30.2

