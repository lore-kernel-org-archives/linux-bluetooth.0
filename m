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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AFBC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0566A611F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbhDSRNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbhDSRNe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E943C061761
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso3088176pjs.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bIdFVvDhp+PiLwtGi4PpDJlfNzDWAowKv1jxnd5BpRY=;
        b=sOWL0Ymf/PCz/JJF/wqFbI05hQ0aRzPpHxB/R3ZiZJeWHWe9/fRSTw0bI2IsXQ6QL/
         AlkfPZitir8D7Fk7uO00+cX5nSbDUJS6ja0SMj2Qraz5RJjUSHHGLwq9KxR/B+MtvdTz
         kGgomVou5Gs3/WGy5YaOqfgFMR/a06XiMq7IhsuxJu+tCITqUu8PwCbBvr82aeWV+wZj
         yG3fnyETsiwMRMlsolX2FI3Gpy3bS/yX3Sa4f/XArDp+nlK/QPNpIWWKarq3wAB49bXl
         u+9wgh/XXG0dVWytuPOTBj/R/roNJLsxwG2nsnD4hvkynYdORvgIqCKDZgL2zvHedMeR
         6vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIdFVvDhp+PiLwtGi4PpDJlfNzDWAowKv1jxnd5BpRY=;
        b=KwujBwV8+qv3GcFLCstz1EjMbKacRUgQDs+lCLx60CHNfYTENGzhITjqidJiBomeSJ
         TSXZnBtvBUYsW71rq175Uu9zKVf+9vjsJkbvGo5T4UkHkUl3EqfpOI80ELyAY0Xwbzh1
         Tq8H54vrOjrxzRlg0zj+BogaPzFgEzJqxgaYCpE6kao/h6WNRHHrV6Iw42Gtdgkv0w99
         S4hmaKEcmV5+WwlVXguWb4Xo5MzbXxtWhrfeJvCVv8gQz48oPh3Aljkq3KbIjPWousnU
         3TBAhlM5WaojcbsD2RuafOZlAglcERso+xaCflWgoNYNpCEvytgvr5uHbdo/sXSwW4VB
         vIkQ==
X-Gm-Message-State: AOAM531GGE+NaBp72U6fPOu5fPS+0gIApU1/B2derNvweu5t5AldAtAw
        nNDoVr2aus7G3gZJDROW1GTeFkBYPc06kQ==
X-Google-Smtp-Source: ABdhPJyNo8D4WwFIpJQjgkmwqMHmO+DItxPvu+5T02pGYC3OBFE2dGODiZ7qDvtNiR6vLprz5gwcNQ==
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr117576pjb.112.1618852383550;
        Mon, 19 Apr 2021 10:13:03 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] Bluetooth: HCI: Use skb_pull to parse LE Metaevents
Date:   Mon, 19 Apr 2021 10:12:54 -0700
Message-Id: <20210419171257.3865181-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
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
index 9776c395412c..dc39861f4da6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -78,6 +78,18 @@ static void *hci_cc_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
 	return data;
 }
 
+static void *hci_le_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
+				u8 ev, size_t len)
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
@@ -5862,7 +5874,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
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
 
@@ -5876,7 +5893,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -5894,9 +5916,14 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 
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
@@ -5923,9 +5950,14 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -6340,9 +6372,14 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -6381,12 +6418,16 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 
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
@@ -6458,11 +6499,16 @@ static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
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
@@ -6535,9 +6581,14 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 
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
@@ -6558,11 +6609,13 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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

