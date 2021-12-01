Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352045AbhLAS6s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351880AbhLAS6g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:36 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E13C061759
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:13 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s37so14889089pga.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ab89kELLOw7PFgiC45BjFwbpcUH6t8PHkBmKKzmYafY=;
        b=Zi7VU5T5oNR2v4+MXhUUm3JuD3PhpdmY/uG3ZIDDPpTItjI5pGCxy6dn3ldWPWiYys
         5nbK485lov+S7ffknTqAKlgAc7apIbOmSrbORXIA23IR2eAihSBfkatVncpH1qlUOtct
         vp0zZCzDVSLEajr4AKc7/T4gMw4wuDdcyaQsviutvaNJdWxB0hqHdFgfTUohPNbIk08N
         w8Lv0+OlUHj2Dorlvuo2b9r3rT2tgPMhLL5MqUbo8WXoZcaIGWsgLO0URlEoQxa5Ood5
         cnLM3G23r7MIOoJX7MU17oKkmqFDczwBoKRcPr4Bottr4iFd/8hi6oPrDIeF/YGpKrPD
         41BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ab89kELLOw7PFgiC45BjFwbpcUH6t8PHkBmKKzmYafY=;
        b=rUEWB2wnrV57cLCvK6s9oyLUlnKg+jwGCOk7lZKZ//oNNTN7QM6SXvs0gGjqp/rUES
         xUxIiC8FkOO0+ZOILJ+IgEBE58HdRuiimiK06bYIAHQrbFTusCb+ENn8uvPs+XObk40L
         WbDxc6H8UQ7uu7nD190U/7zimtpzSVbU+Bhq1HQCnx6RwybacG4FVLoUZ2gvTLHifQBc
         6CWSA+aYXvO2iGMchSwCIQBIuEBnUQ0DEQTebYCVXTEFAiSTbsufdViZ0nX3FJYMbH0/
         WH4kXPPleTmYSDvEqbQOw9aKU7GZbrw9a9Dlhgebvjkk8fEgNZo0V+DrcqlYKS2J2Y14
         Z0aQ==
X-Gm-Message-State: AOAM5326Ujssow3kq3z0LAaT7vmWi6FHrU4Hctcd4MB35HZYksxvWnKW
        DW1lglltHRXnbtjxXAmE1ZiSba/Gq8U=
X-Google-Smtp-Source: ABdhPJxEIL8VXgpV85R4T6xdY8yGP5ZCQp7UIcb5VtQlNXFm+ekzBZF7FheAZCbuiY0dx3tXNwRYYA==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr6181562pgd.143.1638384912467;
        Wed, 01 Dec 2021 10:55:12 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/15] Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result with RSSI event
Date:   Wed,  1 Dec 2021 10:54:57 -0800
Message-Id: <20211201185506.1421186-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the Inquiry Result with RSSI events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 12 +++++++++--
 net/bluetooth/hci_event.c   | 40 +++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 55466bfb972a..d25afd92a46e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2194,7 +2194,7 @@ struct hci_ev_pscan_rep_mode {
 } __packed;
 
 #define HCI_EV_INQUIRY_RESULT_WITH_RSSI	0x22
-struct inquiry_info_with_rssi {
+struct inquiry_info_rssi {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2202,7 +2202,7 @@ struct inquiry_info_with_rssi {
 	__le16   clock_offset;
 	__s8     rssi;
 } __packed;
-struct inquiry_info_with_rssi_and_pscan_mode {
+struct inquiry_info_rssi_pscan {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2211,6 +2211,14 @@ struct inquiry_info_with_rssi_and_pscan_mode {
 	__le16   clock_offset;
 	__s8     rssi;
 } __packed;
+struct hci_ev_inquiry_result_rssi {
+	__u8     num;
+	struct inquiry_info_rssi info[];
+} __packed;
+struct hci_ev_inquiry_result_rssi_pscan {
+	__u8     num;
+	struct inquiry_info_rssi_pscan info[];
+} __packed;
 
 #define HCI_EV_REMOTE_EXT_FEATURES	0x23
 struct hci_ev_remote_ext_features {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bf062f6f262..6560dca8c5ce 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4921,12 +4921,21 @@ static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
+	union {
+		struct hci_ev_inquiry_result_rssi *res1;
+		struct hci_ev_inquiry_result_rssi_pscan *res2;
+	} *ev;
 	struct inquiry_data data;
-	int num_rsp = *((__u8 *) skb->data);
+	int i;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_RESULT_WITH_RSSI,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
+	BT_DBG("%s num_rsp %d", hdev->name, ev->res1->num);
 
-	if (!num_rsp)
+	if (!ev->res1->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4934,16 +4943,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
-		struct inquiry_info_with_rssi_and_pscan_mode *info;
-		info = (void *) (skb->data + 1);
+	if (skb->len == flex_array_size(ev, res2->info, ev->res2->num)) {
+		struct inquiry_info_rssi_pscan *info;
 
-		if (skb->len < num_rsp * sizeof(*info) + 1)
-			goto unlock;
-
-		for (; num_rsp; num_rsp--, info++) {
+		for (i = 0; i < ev->res2->num; i++) {
 			u32 flags;
 
+			info = &ev->res2->info[i];
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -4959,15 +4965,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					  info->dev_class, info->rssi,
 					  flags, NULL, 0, NULL, 0);
 		}
-	} else {
-		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
+	} else if (skb->len == flex_array_size(ev, res1->info, ev->res1->num)) {
+		struct inquiry_info_rssi *info;
 
-		if (skb->len < num_rsp * sizeof(*info) + 1)
-			goto unlock;
-
-		for (; num_rsp; num_rsp--, info++) {
+		for (i = 0; i < ev->res1->num; i++) {
 			u32 flags;
 
+			info = &ev->res1->info[i];
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -4983,9 +4987,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					  info->dev_class, info->rssi,
 					  flags, NULL, 0, NULL, 0);
 		}
+	} else {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
 	}
 
-unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.33.1

