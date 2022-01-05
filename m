Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463F6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jan 2022 22:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbiAEW74 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jan 2022 17:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiAEW74 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jan 2022 17:59:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13485C061245
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jan 2022 14:59:56 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id o7so942174ioo.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jan 2022 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MA6pGn8u6dGa04KcRjabpO7JUNe7Zhcm5vacHXBOu/Y=;
        b=WKtOAXw4SI2/tWAcx+9r5kUW+gyS10y19qIhctzJx3fop+9z9cIPMX4W4+KGHaNtG1
         TnOkg5rmHFx0Ds0KEA8fk5NunhHR93pTWagwX7NTzlGKnD+STtftSHw8I/f1j0oXEnyM
         Kkooizgzskg9lAanrGlB9AUAzr0jq4grxYWM3Sh5G1wf34tsFpqBaqmnD1FsxiTEGEbJ
         XFdSEgJkB3idASARk4Ac7XeCCPB0EoszhmCGUkwvA5nCeOeEeEQTfAvskwhST8nIm9TE
         01K0gVIQqa4ceWRMQFQDYm0aq8kYSt+DSCPilG71H74nZpXkCOTm3wjszvLPXKcZVh3y
         004g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MA6pGn8u6dGa04KcRjabpO7JUNe7Zhcm5vacHXBOu/Y=;
        b=VIjhi7MWA4yYG+veBjrXLu6n8y8YvNB7K+yavretbPIuYsMV4CZux99hv4X4Bvd6b+
         A5aLp+DHDQzM3T3unHJxwYaECrTrJp0WoEpUEiXmecOnsZzVuAV0E86R7Z3GDnScnTts
         NnBu8OyMtBP1fO/HzhrsAUPw26sZdzfdSpgEL1VQhG8yzaSIP654ab4LDwftRzg1Hwfq
         tb1ZA3r6WlkBnM/axtTylmzXkB+IbYw+EKNVcHsTEqbRhTZfO0iqgtRXJsORtavrKFj0
         R5x3dEMpDaaX8uS0cW6obnvKs6ThrsoufDnvt2H/Qf1T1soDqw9zYFYscjsVBr2gTxp9
         JZ4w==
X-Gm-Message-State: AOAM5325klo9hSPh/lBFmymLK5OgQ8jlEuJUw3c5xP7Je4EHfRy374R3
        sYmmsrKuwdDTC39LYyhnViWWruE2Pjk=
X-Google-Smtp-Source: ABdhPJxfpBsTfo2th5T5fLLQ9k/U4dpC/mlSzA97pSBPvXklPKHzZ/mvVDcXV8NTUD3XHybeKdNSLA==
X-Received: by 2002:a05:6638:35a3:: with SMTP id v35mr9285287jal.137.1641423595178;
        Wed, 05 Jan 2022 14:59:55 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g20sm190348iov.35.2022.01.05.14.59.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:59:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Rework hci_inquiry_result_with_rssi_evt
Date:   Wed,  5 Jan 2022 14:59:53 -0800
Message-Id: <20220105225953.3240356-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework the handling of hci_inquiry_result_with_rssi_evt to not use
a union to represent the different inquiry responses.

Tested-by: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  6 +-----
 net/bluetooth/hci_event.c   | 19 +++++++++----------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e2b06bb79e2e..35c073d44ec5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2233,11 +2233,7 @@ struct inquiry_info_rssi_pscan {
 } __packed;
 struct hci_ev_inquiry_result_rssi {
 	__u8     num;
-	struct inquiry_info_rssi info[];
-} __packed;
-struct hci_ev_inquiry_result_rssi_pscan {
-	__u8     num;
-	struct inquiry_info_rssi_pscan info[];
+	__u8     data[];
 } __packed;
 
 #define HCI_EV_REMOTE_EXT_FEATURES	0x23
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1082b7c0218..fc30f4c03d29 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4507,16 +4507,13 @@ static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, void *data,
 static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 					     struct sk_buff *skb)
 {
-	union {
-		struct hci_ev_inquiry_result_rssi *res1;
-		struct hci_ev_inquiry_result_rssi_pscan *res2;
-	} *ev = edata;
+	struct hci_ev_inquiry_result_rssi *ev = edata;
 	struct inquiry_data data;
 	int i;
 
-	bt_dev_dbg(hdev, "num_rsp %d", ev->res1->num);
+	bt_dev_dbg(hdev, "num_rsp %d", ev->num);
 
-	if (!ev->res1->num)
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4524,10 +4521,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 
 	hci_dev_lock(hdev);
 
-	if (skb->len == flex_array_size(ev, res2->info, ev->res2->num)) {
+	if (skb->len == array_size(ev->num,
+				   sizeof(struct inquiry_info_rssi_pscan))) {
 		struct inquiry_info_rssi_pscan *info;
 
-		for (i = 0; i < ev->res2->num; i++) {
+		for (i = 0; i < ev->num; i++) {
 			u32 flags;
 
 			info = hci_ev_skb_pull(hdev, skb,
@@ -4554,10 +4552,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 					  info->dev_class, info->rssi,
 					  flags, NULL, 0, NULL, 0);
 		}
-	} else if (skb->len == flex_array_size(ev, res1->info, ev->res1->num)) {
+	} else if (skb->len == array_size(ev->num,
+					  sizeof(struct inquiry_info_rssi))) {
 		struct inquiry_info_rssi *info;
 
-		for (i = 0; i < ev->res1->num; i++) {
+		for (i = 0; i < ev->num; i++) {
 			u32 flags;
 
 			info = hci_ev_skb_pull(hdev, skb,
-- 
2.33.1

