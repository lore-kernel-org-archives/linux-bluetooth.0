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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E7AC43460
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59812611F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhDSRNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbhDSRNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54CC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g16so1234381plq.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zgYLxf/Ho1TSxyYn6HYkiyN21PYURRsCeNYnILubUTQ=;
        b=O5EVa7Fa8IVusVRM/Q59XG9tcyeevBJLArPX2gViQP97GwTL2Iz6o1ztB0RQYfbNID
         t+qReM6/nOu5HAFwGkvEUx+Qsjzss4zy0Mt4BVLvSvSKEfxYwKxDVLNiGzqEoevaYC9f
         plL0956NSLrRnRmMFYJlMEQHFr0USIeIgwHW+kHW9upezSlH75CTiz5xm0DdOQP3VXDU
         OTrGkI0ie4bEHsK3wS5t+z/HK7ac7IArW9N/wVtIY1S2rN5dLENgP4ykKmVJxUI/QBR4
         RHZHNi9R4/Pw24tQE5EgT0NyYDBGTEtDjgmqdasJTlO+pk26pZScDxD55RrM1QRnboJZ
         UqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgYLxf/Ho1TSxyYn6HYkiyN21PYURRsCeNYnILubUTQ=;
        b=JCRJ/YFA5EJe1mRQ4P3HMsplnBK4QGAH8ZdmEsk8kt3BwIWziP8IbOBJHRkEbknjCs
         EnisPTah2F6GVtbHw+kiX+uilwASUJzWq3MZZjQd647+gDCSTZy1Hhgvi7rfHMiBZAda
         yaN6ekkwQDKR/5TCfWe9eZpsydDW8HonWlHoDYXOS8/IVsdX0yGtZX+M4odZ1MkoIwrZ
         gxcdPxhkci+/KPdUnlplaFb4LL41J1t8SFembMpDtqrFDlz8tM6zuMXyFxQTp2seoybn
         S7tyq+mvuth4xVMs03ugVPmQnVZ1orRRhHsuvwiIN33wfOY/snQ9gq/umu2VGlVMJC8R
         bd2g==
X-Gm-Message-State: AOAM530Ev6MjWB1/3t8RhiTs9Y79ywxKlS8kqEWOkNz57bPGfXFeBnx6
        1UxAhxk7deqAXgWk3UkM9a/dzsn70KnSLQ==
X-Google-Smtp-Source: ABdhPJwvuO1TpEP/q7R2kT6uhD0gCCl1+xjWOdz2+eaU7wRo2hAUiICsSdBrhcnd1/ts0LWLGLhKcg==
X-Received: by 2002:a17:90a:ec03:: with SMTP id l3mr94223pjy.61.1618852382120;
        Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] Bluetooth: HCI: Use skb_pull to parse Inquiry Result with RSSI event
Date:   Mon, 19 Apr 2021 10:12:52 -0700
Message-Id: <20210419171257.3865181-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Inquiry Result with RSSI events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 12 +++++++++--
 net/bluetooth/hci_event.c   | 40 +++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b65205b4d830..53e16ad79698 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2076,7 +2076,7 @@ struct hci_ev_pscan_rep_mode {
 } __packed;
 
 #define HCI_EV_INQUIRY_RESULT_WITH_RSSI	0x22
-struct inquiry_info_with_rssi {
+struct inquiry_info_rssi {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2084,7 +2084,7 @@ struct inquiry_info_with_rssi {
 	__le16   clock_offset;
 	__s8     rssi;
 } __packed;
-struct inquiry_info_with_rssi_and_pscan_mode {
+struct inquiry_info_rssi_pscan {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2093,6 +2093,14 @@ struct inquiry_info_with_rssi_and_pscan_mode {
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
index 6516538fe238..05d680a5f9c3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4720,12 +4720,21 @@ static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -4733,16 +4742,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
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
@@ -4758,15 +4764,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
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
@@ -4782,9 +4786,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
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
2.30.2

