Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B767C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352466AbhLAS6m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352034AbhLAS6g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:36 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0EBC06175B
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n85so25446045pfd.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8WbgfQy9Pg3s7B9vf/AWyt49WCqLJiGtD+eFrFA9TAc=;
        b=fdyGH01OdCfEk2JxmTMViVx+H6Xnnw4hOaBkyWq+MZ5DYMKTRDF2sf0cKCzU8YqGeq
         KFLCH2AT/9i7SPN6WOsCJmddYkjJzogwa94KkgIO0SNLB035v81MqZrHRUM1uYvuv2Uv
         d5x3DpjxS9U97Z404cvr2s6BOx0fIk0bdZ902cearl/306DxhRsvRmY3i4MOVVSGvkvt
         r1qSOTsWmVaJjT5WYCndd7zlDarL2HafhQRglyptBj9qKy89RgamjebBYFbjDSXB16Vl
         abSdqvwKVpwZvvWCJv78tgWBzD2OmCkmaLetrfAMMZHM02xEG4+KENgyiy7SWdvumkny
         syUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WbgfQy9Pg3s7B9vf/AWyt49WCqLJiGtD+eFrFA9TAc=;
        b=IjoMsqfruGjUelrvTzDMEQVLbBUIoBmR7NRbpQO3Zzl+2nVGczEfcHIQHV4nxxU/mQ
         6iHjxxhnQBa+TWjBiUpxct+zbkLaSCd0VPGCzNKYjRdIUcQAhTFTMpw9t455BNebzpMR
         VzelPz0SQ1ChP1D7sO9qAbkpn7Rj39B3aSCxgdl5nB2AVPZ/xWFAv6zwPVyEFAeIIq/E
         5P08ztyzcYB1g/bSIoca9WUAKGsjvm8aJ+/OmsXhlxN9zi/2QCZdkXxy42RWMsSMMcZr
         +BJE7cQ+4GVClKYuwzFU2AkfUXvvtc9wpva2CgQGiMjN9eEfxIACeg7cqB7ydAFORfXk
         wIQg==
X-Gm-Message-State: AOAM5320vAljfkLiKYLABdSi1T+lSEnjGItlIJHETdSKjgQn4YRWkrDm
        TiwYOUtLQ5QlCgifaXD27uM8RN+dJNM=
X-Google-Smtp-Source: ABdhPJweYFze1EOBKepvEby/CuhtuGEaJMa2dS80kO+0ydhFeAeyRz5B/evl3dtZ4Ff2A86ZKemRjQ==
X-Received: by 2002:a05:6a00:23cc:b0:49f:bfaa:e2f6 with SMTP id g12-20020a056a0023cc00b0049fbfaae2f6mr7915102pfc.35.1638384913811;
        Wed, 01 Dec 2021 10:55:13 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/15] Bluetooth: HCI: Use skb_pull_data to parse LE Metaevents
Date:   Wed,  1 Dec 2021 10:54:59 -0800
Message-Id: <20211201185506.1421186-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the LE Metaevents received have the
minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 75 +++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 89c263c1883f..d30e77f66376 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -69,6 +69,18 @@ static void *hci_cc_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
 	return data;
 }
 
+static void *hci_le_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
+				u8 ev, size_t len)
+{
+	void *data;
+
+	data = skb_pull_data(skb, len);
+	if (!data)
+		bt_dev_err(hdev, "Malformed LE Event: 0x%2.2x", ev);
+
+	return data;
+}
+
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 				  u8 *new_status)
 {
@@ -6119,7 +6131,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
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
 
@@ -6133,7 +6150,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -6146,10 +6168,15 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
+	struct hci_evt_le_ext_adv_set_term *ev;
 	struct hci_conn *conn;
 	struct adv_info *adv, *n;
 
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_SET_TERM,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	adv = hci_find_adv_instance(hdev, ev->handle);
@@ -6211,9 +6238,14 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -6636,9 +6668,14 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -6677,12 +6714,16 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 
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
@@ -6754,11 +6795,16 @@ static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
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
@@ -6831,9 +6877,14 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 
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
@@ -6854,11 +6905,13 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
2.33.1

