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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4C5C43611
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F09613CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbhDPVWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbhDPVVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3DC061761
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so17070560pji.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LJxJj4g2cQonoYriNeP4jJ7Im1TfRJe/uwPqH9yqnAc=;
        b=FmXOf/L3wJ4Xy63ALYeh+N2KAVwzqKBHWph0FffM/4d93mRJ7JI3nMYmg5TXYUArl4
         7kz7/cP3asN50tyYTR1RwKCq+X2201bP+XWyS8KnBzR6jc0IWMsZj6oxGpa53RQImTt7
         DGe7PC0C5HCUaQLc7IJJY1ojiFPib4FaTMD5oHQcErqVcFkk9w8clPvAsSzxWLgV/ZDK
         /zzUK8wZ3EAeYrXaYhkT1W2CY7GHlL9UrD6TxOOojoQK+j1BnwlX/7K98xrcDpTHzaaq
         TaDa5TONIlLmpL8ST5DJeDHYxa4Cfkdk66p4v3Y+KILC65ydg9Jcg5sKNJnbD0LgVPE8
         /9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJxJj4g2cQonoYriNeP4jJ7Im1TfRJe/uwPqH9yqnAc=;
        b=D3fYTasltegNPYYJEVa+JqKH+i9P8ogsFUSIy5PjgowhDdQ62y2E45tl//9yHd4wog
         1nDXdBA/9Zsd1ehrVBU0X5WwIX683GJ2a4JoHj6nWpTJpMqO/8fMyYdnJkn3g7coBJ8c
         XBRruds9xSRTc9RhQf13N81KbKQKGmBf1kZDvs4p+L+hiRRo0Zm4vYO4vOJsjgs3GLPC
         DXUPs22Z7JYqaeOnwAKP3rwlEb/y9hzoytzQCsd18m3WGaBCzTi3cSRvPcgDMHUbmqpU
         xWTJKoStZ/BXEmEENrcER5692ZG9+Pm5589SAdxfJU4410BYDGIWu8gNpJxUkzgEe6TY
         4+XA==
X-Gm-Message-State: AOAM533hTF//IM43NPiHZ6TGG2lhW2Z51uCMsmAOUeJTStAMgpMCnqtf
        vvZK8yUE/r7+gzABH0hJHQbkI1VTeEl92A==
X-Google-Smtp-Source: ABdhPJywyXm5eo+87TT6dDs6jxFVdxgHVsdXvllJHfC5JEZ+LHvmaltrHWPkPV44gqgrW/Aj0eWJcQ==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr11726966pjx.196.1618607909679;
        Fri, 16 Apr 2021 14:18:29 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: HCI: Use skb_pull to parse Inquiry Result event
Date:   Fri, 16 Apr 2021 14:18:17 -0700
Message-Id: <20210416211823.3776677-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Inquiry Result events received have
the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_event.c   | 19 ++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9251ae3a2ce0..b65205b4d830 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1910,6 +1910,11 @@ struct inquiry_info {
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
index 65b7194ae1ba..8fa11e99b1cb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2991,13 +2991,21 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3005,7 +3013,8 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct inquiry_info *info = &ev->info[i];
 		u32 flags;
 
 		bacpy(&data.bdaddr, &info->bdaddr);
-- 
2.30.2

