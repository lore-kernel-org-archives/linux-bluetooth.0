Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA461611F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhDSRNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbhDSRNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1BC061761
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s14so13471550pjl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hPBbeM2p8z9E0RMZc6wQiRxZks7l0zaxa99Rl7Dhn78=;
        b=M2qjChvS7/KMtDZQulwpv0bUGwBax/TiGt4Zo9mET+9Kx/nl5XWrVFf6D7wMOUclhW
         PBX74lwhPj3EdfszMCaXF6F2UYbjFt2C5DNyAUfsf4YvbJfxIhwPWzAj7eRsVSR951Vz
         oz81wJRWy2w4S09tsjsVyxr2WC2RSw2fmBrS7e+bOhTQCLoTSG/FChtgGnF/DUNBfmbN
         qajndLw/xQ/Eg2NVVSdQcjKsnEkxIFTFmXAbZAewymOlWheCpkbmunVGQpm5+HQJ3zlu
         YG2ZBPV8mGMDcu8v1TRhxl/9fq6oVYZquWtAj/M9VezRRRiOYYIGfapr9Uw+QfC1QXuB
         ftmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPBbeM2p8z9E0RMZc6wQiRxZks7l0zaxa99Rl7Dhn78=;
        b=EmHglVw9aU1BWixmED3hSmjzaaoU+WBL1rehiCPjwbo8oKaWhDwasr743cjnTMbCIN
         r6hzPal77Kc7+nywE53Zu9Sdt96Ub8f2l6XMGnxOCy1chLCqinKESFh+qEfRf0/OSnsW
         uVUVYJhdZsedP+U8peoZS5pZtvmDpUwUEk2LXO8EvOjjoElKCYuizKeldytqw0f6pM4s
         alTfAW4RnOYCfX4BFjYlMpCU6wSkQc9W6E8sg3fj0d+iHCSJgOVmiuKO483jbjJI+CW1
         pDoESJUkT3YX/JWmDqMrcOoktfrpnC38Tngl5F9uyHg/IFIZ9lFK6vuPUVBg8vLrYHeQ
         asIA==
X-Gm-Message-State: AOAM531wKal+DxE4Nd60hnomN3ogLvDAK+/WY3edqZBMEm71acvU914Y
        Iv8yA303x2mkunWRgF3VMl4v90IigJ8W9Q==
X-Google-Smtp-Source: ABdhPJy1Zi3fh98KWXJuzXKFHpYy1Lt6shOYdvxnQCyYCFVNXppu5R1L2N9Xn2BJxHczxlcwpaUl8Q==
X-Received: by 2002:a17:90a:bb02:: with SMTP id u2mr79072pjr.175.1618852382837;
        Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] Bluetooth: HCI: Use skb_pull to parse Extended Inquiry Result event
Date:   Mon, 19 Apr 2021 10:12:53 -0700
Message-Id: <20210419171257.3865181-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
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
index 05d680a5f9c3..9776c395412c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4968,14 +4968,23 @@ static inline size_t eir_get_length(u8 *eir, size_t eir_len)
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
@@ -4983,7 +4992,8 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct extended_inquiry_info *info = &ev->info[i];
 		u32 flags;
 		bool name_known;
 
-- 
2.30.2

