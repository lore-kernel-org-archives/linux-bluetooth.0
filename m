Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0F5C43219
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352606AbhLAS6v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352021AbhLAS6k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B4C061748
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2452443pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Qm9uxlPq0TJwSg0jQX4vsgvqJsp5f/3ttbAXcPUU0w=;
        b=Su+4WNDLpxlH2oP8ve12jsRsUXHrX8Vu9cNPNkxcIsEIgXd3HYCZyDh1i3j5RY4CXh
         JktFCoA6YQ3rLt6iIwFhh17iQDoFOX1BwgcGzL+TMHekovgrYFHR5Xb2cYYE61avkmxp
         IajCyeG7OgBKAnETN/QYISKYHA0vBdHwRTP32rL2f+/IJ4UyqjL7WksCCU9pVlfkp1gU
         04qF1CnydZg7kJ6dqbmMWsgIPeDktKUNJxxHGHTyUQwgjZaYzZPMALL3YSXj/xavqYIJ
         8x5L5KtBNYjUldcPUWgJMX2/Rf2nVuJlOv8Xs8sxFjOqk/VCM3dQQ76lwed8+3THYfPH
         2XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Qm9uxlPq0TJwSg0jQX4vsgvqJsp5f/3ttbAXcPUU0w=;
        b=VuOw+pflDSnhekvRmyE4cNU6pCw3G+dxcc0GrvG0nIF//0LbvSsVeNNtx8IIfSp2w1
         hb3MkNklDtsiRncu/ZQl6olRqd0E+rqKjTiNDoC5+lFjLs7yY0SPyKjkkVst+8beRTFY
         W3DcIL7qHsNZD1ln0Gs0bRbv3NeKSonW0VR46kMsbVXfODvPAdFFdcfLtex1HKbROu0u
         khNH/ohqTMUOOOEZeEdHlzDPLgJL9MVDqOUp19DU27H4bdUbns57wV8kFb2nSB822azu
         9RnBKSOq2WPjiKPOC3CQACFy4Lbhvdd3XrWLEJnXMrctpE/i4brv7K4wGrNbDyB8EQLU
         jWYw==
X-Gm-Message-State: AOAM530sd+ovj2GS5gtdNFQgnO18QjGMAn5UYUHzvsXqFpa/IreAW2nT
        RkAKQjXNfWZiZVmSMMhfAdQZU0+hHLg=
X-Google-Smtp-Source: ABdhPJwDKe1jfCqykgkFVCZilYNReZju7+MyY2u8DsD8RUG4kN64XTEzI75pl2RJsXmkfFuCe+wOgQ==
X-Received: by 2002:a17:902:c105:b0:142:2441:aa24 with SMTP id 5-20020a170902c10500b001422441aa24mr9508267pli.44.1638384918158;
        Wed, 01 Dec 2021 10:55:18 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/15] Bluetooth: hci_event: Use of a function table to handle LE subevents
Date:   Wed,  1 Dec 2021 10:55:04 -0800
Message-Id: <20211201185506.1421186-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This change the use of switch statement to a function table which is
easier to extend and can include min/max length of each subevent.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 247 +++++++++++++++++++-------------------
 1 file changed, 122 insertions(+), 125 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3953ec188ff6..cecd81e0504c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5969,16 +5969,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_conn_complete_evt(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_complete *ev;
-
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_CONN_COMPLETE,
-				sizeof(*ev));
-	if (!ev)
-		return;
+	struct hci_ev_le_conn_complete *ev = data;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	le_conn_complete_evt(hdev, ev->status, &ev->bdaddr, ev->bdaddr_type,
 			     NULL, ev->role, le16_to_cpu(ev->handle),
@@ -5987,17 +5983,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			     le16_to_cpu(ev->supervision_timeout));
 }
 
-static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
+static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev, void *data,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_le_enh_conn_complete *ev;
+	struct hci_ev_le_enh_conn_complete *ev = data;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ENHANCED_CONN_COMPLETE,
-				sizeof(*ev));
-	if (!ev)
-		return;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	le_conn_complete_evt(hdev, ev->status, &ev->bdaddr, ev->bdaddr_type,
 			     &ev->local_rpa, ev->role, le16_to_cpu(ev->handle),
@@ -6006,18 +5997,14 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->supervision_timeout));
 }
 
-static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
+				    struct sk_buff *skb)
 {
-	struct hci_evt_le_ext_adv_set_term *ev;
+	struct hci_evt_le_ext_adv_set_term *ev = data;
 	struct hci_conn *conn;
 	struct adv_info *adv, *n;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_SET_TERM,
-				sizeof(*ev));
-	if (!ev)
-		return;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	adv = hci_find_adv_instance(hdev, ev->handle);
 
@@ -6075,18 +6062,13 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
+static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_update_complete *ev;
+	struct hci_ev_le_conn_update_complete *ev = data;
 	struct hci_conn *conn;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_CONN_UPDATE_COMPLETE,
-				sizeof(*ev));
-	if (!ev)
-		return;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	if (ev->status)
 		return;
@@ -6402,14 +6384,10 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	clear_pending_adv_report(hdev);
 }
 
-static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
+				  struct sk_buff *skb)
 {
-	struct hci_ev_le_advertising_report *ev;
-
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ADVERTISING_REPORT,
-				sizeof(*ev));
-	if (!ev)
-		return;
+	struct hci_ev_le_advertising_report *ev = data;
 
 	if (!ev->num)
 		return;
@@ -6487,14 +6465,10 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 	return LE_ADV_INVALID;
 }
 
-static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
+				      struct sk_buff *skb)
 {
-	struct hci_ev_le_ext_adv_report *ev;
-
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_REPORT,
-				sizeof(*ev));
-	if (!ev)
-		return;
+	struct hci_ev_le_ext_adv_report *ev = data;
 
 	if (!ev->num)
 		return;
@@ -6528,18 +6502,13 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
+static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_feat_complete *ev;
+	struct hci_ev_le_remote_feat_complete *ev = data;
 	struct hci_conn *conn;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_REPORT,
-				sizeof(*ev));
-	if (!ev)
-		return;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
 
@@ -6575,19 +6544,16 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_ltk_request_evt(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb)
 {
-	struct hci_ev_le_ltk_req *ev;
+	struct hci_ev_le_ltk_req *ev = data;
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
 	struct smp_ltk *ltk;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_LTK_REQ, sizeof(*ev));
-	if (!ev)
-		return;
-
-	BT_DBG("%s handle 0x%4.4x", hdev->name, __le16_to_cpu(ev->handle));
+	bt_dev_dbg(hdev, "handle 0x%4.4x", __le16_to_cpu(ev->handle));
 
 	hci_dev_lock(hdev);
 
@@ -6655,18 +6621,15 @@ static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
 		     &cp);
 }
 
-static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
+static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_conn_param_req *ev;
+	struct hci_ev_le_remote_conn_param_req *ev = data;
 	struct hci_cp_le_conn_param_req_reply cp;
 	struct hci_conn *hcon;
 	u16 handle, min, max, latency, timeout;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_REMOTE_CONN_PARAM_REQ,
-				sizeof(*ev));
-	if (!ev)
-		return;
+	bt_dev_dbg(hdev, "handle 0x%4.4x", __le16_to_cpu(ev->handle));
 
 	handle = le16_to_cpu(ev->handle);
 	min = le16_to_cpu(ev->interval_min);
@@ -6718,17 +6681,12 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
 }
 
-static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
+static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_le_direct_adv_report *ev;
+	struct hci_ev_le_direct_adv_report *ev = data;
 	int i;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
-				sizeof(*ev));
-	if (!ev)
-		return;
-
 	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
 				flex_array_size(ev, info, ev->num)))
 		return;
@@ -6750,17 +6708,13 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_phy_update_evt(struct hci_dev *hdev, void *data,
+				  struct sk_buff *skb)
 {
-	struct hci_ev_le_phy_update_complete *ev;
+	struct hci_ev_le_phy_update_complete *ev = data;
 	struct hci_conn *conn;
 
-	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_PHY_UPDATE_COMPLETE,
-				sizeof(*ev));
-	if (ev)
-		return;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	if (ev->status)
 		return;
@@ -6778,59 +6732,102 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
-			    struct sk_buff *skb)
-{
-	struct hci_ev_le_meta *ev = data;
-
-	switch (ev->subevent) {
-	case HCI_EV_LE_CONN_COMPLETE:
-		hci_le_conn_complete_evt(hdev, skb);
-		break;
-
-	case HCI_EV_LE_CONN_UPDATE_COMPLETE:
-		hci_le_conn_update_complete_evt(hdev, skb);
-		break;
+#define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
+[_op] = { \
+	.func = _func, \
+	.min_len = _min_len, \
+	.max_len = _max_len, \
+}
 
-	case HCI_EV_LE_ADVERTISING_REPORT:
-		hci_le_adv_report_evt(hdev, skb);
-		break;
+#define HCI_LE_EV(_op, _func, _len) \
+	HCI_LE_EV_VL(_op, _func, _len, _len)
 
-	case HCI_EV_LE_REMOTE_FEAT_COMPLETE:
-		hci_le_remote_feat_complete_evt(hdev, skb);
-		break;
+#define HCI_LE_EV_STATUS(_op, _func) \
+	HCI_LE_EV(_op, _func, sizeof(struct hci_ev_status))
 
-	case HCI_EV_LE_LTK_REQ:
-		hci_le_ltk_request_evt(hdev, skb);
-		break;
+/* Entries in this table shall have their position according to the subevent
+ * opcode they handle so the use of the macros above is recommend since it does
+ * attempt to initialize at its proper index using Designated Initializers that
+ * way events without a callback function can be ommited.
+ */
+static const struct hci_le_ev {
+	void (*func)(struct hci_dev *hdev, void *data, struct sk_buff *skb);
+	u16  min_len;
+	u16  max_len;
+} hci_le_ev_table[U8_MAX + 1] = {
+	/* [0x01 = HCI_EV_LE_CONN_COMPLETE] */
+	HCI_LE_EV(HCI_EV_LE_CONN_COMPLETE, hci_le_conn_complete_evt,
+		  sizeof(struct hci_ev_le_conn_complete)),
+	/* [0x02 = HCI_EV_LE_ADVERTISING_REPORT] */
+	HCI_LE_EV_VL(HCI_EV_LE_ADVERTISING_REPORT, hci_le_adv_report_evt,
+		     sizeof(struct hci_ev_le_advertising_report),
+		     HCI_MAX_EVENT_SIZE),
+	/* [0x03 = HCI_EV_LE_CONN_UPDATE_COMPLETE] */
+	HCI_LE_EV(HCI_EV_LE_CONN_UPDATE_COMPLETE,
+		  hci_le_conn_update_complete_evt,
+		  sizeof(struct hci_ev_le_conn_update_complete)),
+	/* [0x04 = HCI_EV_LE_REMOTE_FEAT_COMPLETE] */
+	HCI_LE_EV(HCI_EV_LE_REMOTE_FEAT_COMPLETE,
+		  hci_le_remote_feat_complete_evt,
+		  sizeof(struct hci_ev_le_remote_feat_complete)),
+	/* [0x05 = HCI_EV_LE_LTK_REQ] */
+	HCI_LE_EV(HCI_EV_LE_LTK_REQ, hci_le_ltk_request_evt,
+		  sizeof(struct hci_ev_le_ltk_req)),
+	/* [0x06 = HCI_EV_LE_REMOTE_CONN_PARAM_REQ] */
+	HCI_LE_EV(HCI_EV_LE_REMOTE_CONN_PARAM_REQ,
+		  hci_le_remote_conn_param_req_evt,
+		  sizeof(struct hci_ev_le_remote_conn_param_req)),
+	/* [0x0a = HCI_EV_LE_ENHANCED_CONN_COMPLETE] */
+	HCI_LE_EV(HCI_EV_LE_ENHANCED_CONN_COMPLETE,
+		  hci_le_enh_conn_complete_evt,
+		  sizeof(struct hci_ev_le_enh_conn_complete)),
+	/* [0x0b = HCI_EV_LE_DIRECT_ADV_REPORT] */
+	HCI_LE_EV_VL(HCI_EV_LE_DIRECT_ADV_REPORT, hci_le_direct_adv_report_evt,
+		     sizeof(struct hci_ev_le_direct_adv_report),
+		     HCI_MAX_EVENT_SIZE),
+	/* [0x0c = HCI_EV_LE_PHY_UPDATE_COMPLETE] */
+	HCI_LE_EV(HCI_EV_LE_PHY_UPDATE_COMPLETE, hci_le_phy_update_evt,
+		  sizeof(struct hci_ev_le_phy_update_complete)),
+	/* [0x0d = HCI_EV_LE_EXT_ADV_REPORT] */
+	HCI_LE_EV_VL(HCI_EV_LE_EXT_ADV_REPORT, hci_le_ext_adv_report_evt,
+		     sizeof(struct hci_ev_le_ext_adv_report),
+		     HCI_MAX_EVENT_SIZE),
+	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
+	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
+		  sizeof(struct hci_evt_le_ext_adv_set_term)),
+};
 
-	case HCI_EV_LE_REMOTE_CONN_PARAM_REQ:
-		hci_le_remote_conn_param_req_evt(hdev, skb);
-		break;
+static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
+			    struct sk_buff *skb)
+{
+	struct hci_ev_le_meta *ev = data;
+	const struct hci_le_ev *subev;
 
-	case HCI_EV_LE_DIRECT_ADV_REPORT:
-		hci_le_direct_adv_report_evt(hdev, skb);
-		break;
+	bt_dev_dbg(hdev, "subevent 0x%2.2x", ev->subevent);
 
-	case HCI_EV_LE_PHY_UPDATE_COMPLETE:
-		hci_le_phy_update_evt(hdev, skb);
-		break;
+	subev = &hci_le_ev_table[ev->subevent];
+	if (!subev->func)
+		return;
 
-	case HCI_EV_LE_EXT_ADV_REPORT:
-		hci_le_ext_adv_report_evt(hdev, skb);
-		break;
+	if (skb->len < subev->min_len) {
+		bt_dev_err(hdev, "unexpected subevent 0x%2.2x length: %u < %u",
+			   ev->subevent, skb->len, subev->min_len);
+		return;
+	}
 
-	case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
-		hci_le_enh_conn_complete_evt(hdev, skb);
-		break;
+	/* Just warn if the length is over max_len size it still be
+	 * possible to partially parse the event so leave to callback to
+	 * decide if that is acceptable.
+	 */
+	if (skb->len > subev->max_len)
+		bt_dev_warn(hdev, "unexpected subevent 0x%2.2x length: %u > %u",
+			    ev->subevent, skb->len, subev->max_len);
 
-	case HCI_EV_LE_EXT_ADV_SET_TERM:
-		hci_le_ext_adv_term_evt(hdev, skb);
-		break;
+	data = hci_le_ev_skb_pull(hdev, skb, ev->subevent, subev->min_len);
+	if (!data)
+		return;
 
-	default:
-		break;
-	}
+	subev->func(hdev, data, skb);
 }
 
 static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
-- 
2.33.1

