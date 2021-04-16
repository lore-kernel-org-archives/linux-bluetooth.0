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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681FDC43462
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478556023F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbhDPVWK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344190AbhDPVVs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4AC06138C
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso10069986pjg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uTA6HslatCiX5hzgaE0xxQxjrjOL9qvfWAn9Nr0QJKE=;
        b=D9eBgUE1eKa7u5/NTHEPxVtsHRxt4efhBGi0BWC9VgfZLxZpS3q/L6g9C1orWmVvuI
         fea7H+lbo1imDyhlkowkRSpCQb9LWA+Tnf8nV8R0zoS/KaNLw6kELaOsE7WdtIOlTzO+
         DGmgmenwBOSmBA+KBFEnHk8XSr798gkd+QWPbo7BO4k5Upf0H2+Tzbf1xzxGfZutbaRS
         ZLGKrhaaDGNZ3rLHoXuv8RCNERd+b28BjJlTSrP6hWgxLtQyWeoastAWYcfdaqh9cREA
         fScaJafy8FWp8Ax+dCBc4RbRsuGBMvRoNvflSRTt8slrSNfao0a05qvjlHgylf+zhkCb
         5EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTA6HslatCiX5hzgaE0xxQxjrjOL9qvfWAn9Nr0QJKE=;
        b=dNFfmWRI4zoFzhRs155whTWX3/P+RydtlDyNloVCrNn38lbuz9F1xQezzg9jq19iR9
         rmaf9xk2mN3ibz2us7QA0C0lcg+U90BneewmzqcjLv2Rz2ogSsHA+MDeJOIqIGNNrMYS
         96/BBlivNTXUAYtQ0r0hpwTJhiPFAXYhYt1rCWovihPxqijZ9dRNiosTKDUTHm3RqUDl
         L1Bj6RA07GssfGb8fdiUUPV2vN4YATO59kExXDIbBf2Gmg+Dgx3w/IUi61Yd6eiZ4ybO
         kcUAQ4+HfQQWFre+N8lbutt3qqhYTbYPrMwXB6kLKuQD+debWCVURh8TDvNLCELbW1wb
         tdgA==
X-Gm-Message-State: AOAM532tAhlsKk/3a/7/c74lw3xdaUpedLifjNd6ths80sOVex1DMHwB
        HqZDChMS40GcWiCn2DgYancz0E8nSjqbVw==
X-Google-Smtp-Source: ABdhPJwLSOMuK87V8FmKhvAldh+vTPKCQXtUwAgJsZIVO1AEqSBYoDkE+TRtxRRwQW4spXfclWHR1w==
X-Received: by 2002:a17:90b:2306:: with SMTP id mt6mr11575604pjb.119.1618607911876;
        Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: HCI: Use skb_pull to parse LE Metaevents
Date:   Fri, 16 Apr 2021 14:18:20 -0700
Message-Id: <20210416211823.3776677-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the LE Metaevents received have the minimum
required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 75 +++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index efa18a65ab80..3b928d874f39 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -78,6 +78,18 @@ static void *hci_cc_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
 	return data;
 }
 
+static void *hci_le_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
+				uint8_t ev, size_t len)
+{
+	void *data;
+
+	data = hci_skb_pull(skb, len);
+	if (!data)
+		bt_dev_err(hdev, "Malformed LE Event: 0x%2.2x", ev);
+
+	return data;
+}
+
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 				  u8 *new_status)
 {
@@ -5863,7 +5875,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_le_conn_complete *ev;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_CONN_COMPLETE,
+				sizeof(*ev));
+	if (!ev)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5877,7 +5894,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_le_enh_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_le_enh_conn_complete *ev;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ENHANCED_CONN_COMPLETE,
+				sizeof(*ev));
+	if (!ev)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5895,9 +5917,14 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
+	struct hci_evt_le_ext_adv_set_term *ev;
 	struct hci_conn *conn;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_SET_TERM,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5924,9 +5951,14 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_update_complete *ev = (void *) skb->data;
+	struct hci_ev_le_conn_update_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_CONN_UPDATE_COMPLETE,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -6341,9 +6373,14 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_feat_complete *ev = (void *)skb->data;
+	struct hci_ev_le_remote_feat_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -6382,12 +6419,16 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
+	struct hci_ev_le_ltk_req *ev;
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
 	struct smp_ltk *ltk;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_LTK_REQ, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s handle 0x%4.4x", hdev->name, __le16_to_cpu(ev->handle));
 
 	hci_dev_lock(hdev);
@@ -6459,11 +6500,16 @@ static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
 static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_conn_param_req *ev = (void *) skb->data;
+	struct hci_ev_le_remote_conn_param_req *ev;
 	struct hci_cp_le_conn_param_req_reply cp;
 	struct hci_conn *hcon;
 	u16 handle, min, max, latency, timeout;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_REMOTE_CONN_PARAM_REQ,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
 	handle = le16_to_cpu(ev->handle);
 	min = le16_to_cpu(ev->interval_min);
 	max = le16_to_cpu(ev->interval_max);
@@ -6536,9 +6582,14 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 
 static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_phy_update_complete *ev = (void *) skb->data;
+	struct hci_ev_le_phy_update_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_PHY_UPDATE_COMPLETE,
+				sizeof(*ev));
+	if (ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -6559,11 +6610,13 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_meta *le_ev = (void *) skb->data;
+	struct hci_ev_le_meta *ev;
 
-	skb_pull(skb, sizeof(*le_ev));
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_LE_META, sizeof(*ev));
+	if (!ev)
+		return;
 
-	switch (le_ev->subevent) {
+	switch (ev->subevent) {
 	case HCI_EV_LE_CONN_COMPLETE:
 		hci_le_conn_complete_evt(hdev, skb);
 		break;
-- 
2.30.2

