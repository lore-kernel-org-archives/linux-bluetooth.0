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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905CC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D323461350
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 18:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbhDLSk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhDLSk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 14:40:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF9C061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 11:40:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d10so10069679pgf.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wd0tfggQ08SUpx+o+6R3UQB3g/8qARO1yWsK0dbYD4w=;
        b=XLuHCz2EozY9Imk/gO+cBqQcQz8vve8WShR2e6GsAGf6RoP+57xfsOB+GT5xPVGWtQ
         PP90SCo1kSOpPdYz8BOCt55pAIx6O/I2ovbKwU0yb3HSxXpktB94MkvLjdFtAj0T8iVj
         PEGUoN6F0TaSlSLkhCZNUugVlaxnYq/eJrICQ/nk2+QtnNXSH9i7kcNVDTCzXGB2QPoE
         jhc+rv291QXb7lbXouXTU2K/KAdSaI5qssITo/6ufZNzYl7/e/B1n0Vi/dZqwe8yBpga
         MWeblPpJA/u7Z3vyimdMfoRiEQXR+BoGcV2xT8gIDBMebwUCKhEqI8s6HeAoUTswRbjL
         +gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wd0tfggQ08SUpx+o+6R3UQB3g/8qARO1yWsK0dbYD4w=;
        b=k9BoIJ2Bw3eNdPc9RUSC0thtD7Jxs5LQVzYNGOFkcKV0lQoBa5WgS/JXARxARn29Ns
         EkECuZGb1FYyGxMyNjMLWl2LGxoNBDU1+Sc6PxuWDRJ/ntAGMQxNVgCapHo9AoQccbgY
         QGkBKuD6wDGelOp8yRl1IauXflc6HMRTR+4hPJijMu2muzTITFzITV9K5/jY47f9E0Jw
         gU/srRjBZb3jKb+EXcizGQXvwbORImYPRC9sefnfaEqW1iMArzHkYy20BEhQA/R4C91C
         JkMeFX7sEbR++wHj1sBWBsfDFl1tFZw9UGDvvj89YW9DEjP2sbT3y+eq8cySaKOvHRX3
         IyaA==
X-Gm-Message-State: AOAM530rxBhDNRILc9LkjDCC4+RkzJ/WXWi9DTw32/n6xRtg0OiBwhhH
        0Wh1QRCe+zrNoBYRK3p93i3xk8mOUltr5w==
X-Google-Smtp-Source: ABdhPJyNMyP1ovSYYU8X17WlxdZHVQn5C9vY5UStKI+hVvIGMOpSq8tBEjsVlcoUW4A6ydh9jlgcQw==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr27946578pgo.365.1618252837369;
        Mon, 12 Apr 2021 11:40:37 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v13sm9773551pfu.54.2021.04.12.11.40.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 11:40:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: HCI: Use bt_skb_pull to parse events
Date:   Mon, 12 Apr 2021 11:40:33 -0700
Message-Id: <20210412184033.2504931-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412184033.2504931-1-luiz.dentz@gmail.com>
References: <20210412184033.2504931-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_skb_pull to check the events received have the minimum
required length, while at it also rework checks for flexible arrays to
use flex_array_size.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  59 ++-
 net/bluetooth/hci_event.c   | 848 ++++++++++++++++++++++++++++--------
 2 files changed, 722 insertions(+), 185 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ea4ae551c426..13b7c7747bd1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1894,6 +1894,10 @@ struct hci_cp_le_reject_cis {
 } __packed;
 
 /* ---- HCI Events ---- */
+struct hci_ev_status {
+	__u8    status;
+} __packed;
+
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
 #define HCI_EV_INQUIRY_RESULT		0x02
@@ -1906,6 +1910,11 @@ struct inquiry_info {
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
@@ -2017,7 +2026,7 @@ struct hci_comp_pkts_info {
 } __packed;
 
 struct hci_ev_num_comp_pkts {
-	__u8     num_hndl;
+	__u8     num;
 	struct hci_comp_pkts_info handles[];
 } __packed;
 
@@ -2067,7 +2076,7 @@ struct hci_ev_pscan_rep_mode {
 } __packed;
 
 #define HCI_EV_INQUIRY_RESULT_WITH_RSSI	0x22
-struct inquiry_info_with_rssi {
+struct inquiry_info_rssi {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2075,7 +2084,7 @@ struct inquiry_info_with_rssi {
 	__le16   clock_offset;
 	__s8     rssi;
 } __packed;
-struct inquiry_info_with_rssi_and_pscan_mode {
+struct inquiry_info_rssi_pscan {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2084,6 +2093,14 @@ struct inquiry_info_with_rssi_and_pscan_mode {
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
@@ -2138,6 +2155,11 @@ struct extended_inquiry_info {
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
@@ -2305,13 +2327,18 @@ struct hci_ev_le_conn_complete {
 
 #define HCI_EV_LE_ADVERTISING_REPORT	0x02
 struct hci_ev_le_advertising_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 length;
 	__u8	 data[];
 } __packed;
 
+struct hci_ev_le_advertising_report {
+	__u8    num;
+	struct hci_ev_le_advertising_info info[];
+} __packed;
+
 #define HCI_EV_LE_CONN_UPDATE_COMPLETE	0x03
 struct hci_ev_le_conn_update_complete {
 	__u8     status;
@@ -2355,7 +2382,7 @@ struct hci_ev_le_data_len_change {
 
 #define HCI_EV_LE_DIRECT_ADV_REPORT	0x0B
 struct hci_ev_le_direct_adv_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 direct_addr_type;
@@ -2363,6 +2390,11 @@ struct hci_ev_le_direct_adv_info {
 	__s8	 rssi;
 } __packed;
 
+struct hci_ev_le_direct_adv_report {
+	__u8	 num;
+	struct hci_ev_le_direct_adv_info info[];
+} __packed;
+
 #define HCI_EV_LE_PHY_UPDATE_COMPLETE	0x0c
 struct hci_ev_le_phy_update_complete {
 	__u8  status;
@@ -2372,8 +2404,8 @@ struct hci_ev_le_phy_update_complete {
 } __packed;
 
 #define HCI_EV_LE_EXT_ADV_REPORT    0x0d
-struct hci_ev_le_ext_adv_report {
-	__le16 	 evt_type;
+struct hci_ev_le_ext_adv_info {
+	__le16   type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 primary_phy;
@@ -2381,11 +2413,16 @@ struct hci_ev_le_ext_adv_report {
 	__u8	 sid;
 	__u8	 tx_power;
 	__s8	 rssi;
-	__le16 	 interval;
-	__u8  	 direct_addr_type;
+	__le16   interval;
+	__u8     direct_addr_type;
 	bdaddr_t direct_addr;
-	__u8  	 length;
-	__u8	 data[];
+	__u8     length;
+	__u8     data[];
+} __packed;
+
+struct hci_ev_le_ext_adv_report {
+	__u8     num;
+	struct hci_ev_le_ext_adv_info info[];
 } __packed;
 
 #define HCI_EV_LE_ENHANCED_CONN_COMPLETE    0x0a
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..db40358521fa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -45,9 +45,16 @@
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 				  u8 *new_status)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_INQUIRY_CANCEL);
+		return;
+	}
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	/* It is possible that we receive Inquiry Complete event right
 	 * before we receive Inquiry Cancel Command Complete event, in
@@ -56,14 +63,14 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 	 * we actually achieve what Inquiry Cancel wants to achieve,
 	 * which is to end the last Inquiry session.
 	 */
-	if (status == 0x0c && !test_bit(HCI_INQUIRY, &hdev->flags)) {
+	if (rp->status == 0x0c && !test_bit(HCI_INQUIRY, &hdev->flags)) {
 		bt_dev_warn(hdev, "Ignoring error of Inquiry Cancel command");
-		status = 0x00;
+		rp->status = 0x00;
 	}
 
-	*new_status = status;
+	*new_status = rp->status;
 
-	if (status)
+	if (rp->status)
 		return;
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
@@ -84,11 +91,18 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 
 static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp->status) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_PERIODIC_INQ);
+		return;
+	}
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	hci_dev_set_flag(hdev, HCI_PERIODIC_INQ);
@@ -96,11 +110,18 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_EXIT_PERIODIC_INQ);
+		return;
+	}
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
@@ -116,9 +137,16 @@ static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
 
 static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_role_discovery *rp = (void *) skb->data;
+	struct hci_rp_role_discovery *rp;
 	struct hci_conn *conn;
 
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_ROLE_DISCOVERY);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -135,9 +163,16 @@ static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_link_policy *rp = (void *) skb->data;
+	struct hci_rp_read_link_policy *rp;
 	struct hci_conn *conn;
 
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_READ_LINK_POLICY);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -154,10 +189,17 @@ static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_write_link_policy *rp = (void *) skb->data;
+	struct hci_rp_write_link_policy *rp;
 	struct hci_conn *conn;
 	void *sent;
 
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_LINK_POLICY);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -179,7 +221,14 @@ static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_def_link_policy *rp = (void *) skb->data;
+	struct hci_rp_read_def_link_policy *rp;
+
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_READ_DEF_LINK_POLICY);
+		return;
+	}
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -192,12 +241,19 @@ static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
 static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_DEF_LINK_POLICY);
+		return;
+	}
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_LINK_POLICY);
@@ -209,13 +265,20 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 
 static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_RESET);
+		return;
+	}
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	clear_bit(HCI_RESET, &hdev->flags);
 
-	if (status)
+	if (rp->status)
 		return;
 
 	/* Reset all non-persistent flags */
@@ -243,9 +306,16 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_stored_link_key *rp = (void *)skb->data;
+	struct hci_rp_read_stored_link_key *rp;
 	struct hci_cp_read_stored_link_key *sent;
 
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_READ_STORED_LINK_KEY);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_STORED_LINK_KEY);
@@ -261,7 +331,14 @@ static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_delete_stored_link_key *rp = (void *)skb->data;
+	struct hci_rp_delete_stored_link_key *rp;
+
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_DELETE_STORED_LINK_KEY);
+		return;
+	}
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -276,10 +353,17 @@ static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_LOCAL_NAME);
+		return;
+	}
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LOCAL_NAME);
 	if (!sent)
@@ -288,8 +372,8 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_set_local_name_complete(hdev, sent, status);
-	else if (!status)
+		mgmt_set_local_name_complete(hdev, sent, rp->status);
+	else if (!rp->status)
 		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 
 	hci_dev_unlock(hdev);
@@ -297,7 +381,14 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_name *rp = (void *) skb->data;
+	struct hci_rp_read_local_name *rp;
+
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_READ_LOCAL_NAME);
+		return;
+	}
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -311,10 +402,17 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_AUTH_ENABLE);
+		return;
+	}
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_AUTH_ENABLE);
 	if (!sent)
@@ -322,7 +420,7 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
+	if (!rp->status) {
 		__u8 param = *((__u8 *) sent);
 
 		if (param == AUTH_ENABLED)
@@ -332,20 +430,27 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_auth_enable_complete(hdev, status);
+		mgmt_auth_enable_complete(hdev, rp->status);
 
 	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	__u8 param;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_ENCRYPT_MODE);
+		return;
+	}
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_ENCRYPT_MODE);
@@ -362,11 +467,18 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	__u8 param;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_SCAN_ENABLE);
+		return;
+	}
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SCAN_ENABLE);
 	if (!sent)
@@ -376,7 +488,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (status) {
+	if (rp->status) {
 		hdev->discov_timeout = 0;
 		goto done;
 	}
@@ -397,13 +509,20 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_set_event_filter(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *)skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_set_event_filter *cp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = bt_skb_pull(skb, sizeof(*rp));
+	if (!rp) {
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
+			   HCI_OP_WRITE_SCAN_ENABLE);
+		return;
+	}
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_SET_EVENT_FLT);
@@ -2507,11 +2626,18 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *ev;
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_INQUIRY_COMPLETE);
+		return;
+	}
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_conn_check_pending(hdev);
 
@@ -2566,13 +2692,20 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct hci_ev_inquiry_result *ev;
 	struct inquiry_data data;
-	struct inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
+	int i;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev || skb->len < flex_array_size(ev, info, ev->num)) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_INQUIRY_RESULT);
+		return;
+	}
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	BT_DBG("%s num %d", hdev->name, ev->num);
 
-	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -2580,7 +2713,8 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct inquiry_info *info = &ev->info[i];
 		u32 flags;
 
 		bacpy(&data.bdaddr, &info->bdaddr);
@@ -2604,9 +2738,16 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_conn_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CONN_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -2728,12 +2869,19 @@ static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_conn_request *ev = (void *) skb->data;
+	struct hci_ev_conn_request *ev;
 	int mask = hdev->link_mode;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 	__u8 flags = 0;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CONN_REQUEST);
+		return;
+	}
+
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
@@ -2839,13 +2987,20 @@ static u8 hci_to_mgmt_reason(u8 err)
 
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_disconn_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_complete *ev;
 	u8 reason;
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	bool mgmt_connected;
 	u8 type;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_DISCONN_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -2931,9 +3086,16 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_auth_complete *ev = (void *) skb->data;
+	struct hci_ev_auth_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_AUTH_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3001,9 +3163,16 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_remote_name *ev = (void *) skb->data;
+	struct hci_ev_remote_name *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_REMOTE_NAME);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_conn_check_pending(hdev);
@@ -3084,9 +3253,16 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 
 static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_encrypt_change *ev = (void *) skb->data;
+	struct hci_ev_encrypt_change *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_ENCRYPT_CHANGE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3199,9 +3375,16 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_change_link_key_complete *ev = (void *) skb->data;
+	struct hci_ev_change_link_key_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CHANGE_LINK_KEY_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3222,9 +3405,16 @@ static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 static void hci_remote_features_evt(struct hci_dev *hdev,
 				    struct sk_buff *skb)
 {
-	struct hci_ev_remote_features *ev = (void *) skb->data;
+	struct hci_ev_remote_features *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_REMOTE_FEATURES);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3273,12 +3463,17 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 				 hci_req_complete_t *req_complete,
 				 hci_req_complete_skb_t *req_complete_skb)
 {
-	struct hci_ev_cmd_complete *ev = (void *) skb->data;
+	struct hci_ev_cmd_complete *ev;
 
-	*opcode = __le16_to_cpu(ev->opcode);
-	*status = skb->data[sizeof(*ev)];
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CMD_COMPLETE);
+		return;
+	}
 
-	skb_pull(skb, sizeof(*ev));
+	*opcode = __le16_to_cpu(ev->opcode);
+	*status = skb->data[0];
 
 	switch (*opcode) {
 	case HCI_OP_INQUIRY_CANCEL:
@@ -3654,9 +3849,14 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 			       hci_req_complete_t *req_complete,
 			       hci_req_complete_skb_t *req_complete_skb)
 {
-	struct hci_ev_cmd_status *ev = (void *) skb->data;
+	struct hci_ev_cmd_status *ev;
 
-	skb_pull(skb, sizeof(*ev));
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CMD_STATUS);
+		return;
+	}
 
 	*opcode = __le16_to_cpu(ev->opcode);
 	*status = ev->status;
@@ -3764,7 +3964,14 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_hardware_error *ev = (void *) skb->data;
+	struct hci_ev_hardware_error *ev;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_HARDWARE_ERROR);
+		return;
+	}
 
 	hdev->hw_error_code = ev->code;
 
@@ -3773,9 +3980,16 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_role_change *ev = (void *) skb->data;
+	struct hci_ev_role_change *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_ROLE_CHANGE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3795,23 +4009,24 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
+	struct hci_ev_num_comp_pkts *ev;
 	int i;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev || skb->len < flex_array_size(ev, handles, ev->num)) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_NUM_COMP_PKTS);
 		return;
 	}
 
-	if (skb->len < sizeof(*ev) ||
-	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
-		BT_DBG("%s bad parameters", hdev->name);
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
+		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
-	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
+	BT_DBG("%s num %d", hdev->name, ev->num);
 
-	for (i = 0; i < ev->num_hndl; i++) {
+	for (i = 0; i < ev->num; i++) {
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
@@ -3883,17 +4098,18 @@ static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
 
 static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
+	struct hci_ev_num_comp_blocks *ev;
 	int i;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_BLOCK_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev || skb->len < flex_array_size(ev, handles, ev->num_hndl)) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_NUM_COMP_BLOCKS);
 		return;
 	}
 
-	if (skb->len < sizeof(*ev) ||
-	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
-		BT_DBG("%s bad parameters", hdev->name);
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_BLOCK_BASED) {
+		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
@@ -3934,9 +4150,16 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_mode_change *ev = (void *) skb->data;
+	struct hci_ev_mode_change *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_MODE_CHANGE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3962,9 +4185,16 @@ static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pin_code_req *ev = (void *) skb->data;
+	struct hci_ev_pin_code_req *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_PIN_CODE_REQ);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4032,11 +4262,18 @@ static void conn_set_key(struct hci_conn *conn, u8 key_type, u8 pin_len)
 
 static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_link_key_req *ev = (void *) skb->data;
+	struct hci_ev_link_key_req *ev;
 	struct hci_cp_link_key_reply cp;
 	struct hci_conn *conn;
 	struct link_key *key;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_LINK_KEY_REQ);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -4092,12 +4329,19 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_link_key_notify *ev = (void *) skb->data;
+	struct hci_ev_link_key_notify *ev;
 	struct hci_conn *conn;
 	struct link_key *key;
 	bool persistent;
 	u8 pin_len = 0;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_LINK_KEY_NOTIFY);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4152,9 +4396,16 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_clock_offset *ev = (void *) skb->data;
+	struct hci_ev_clock_offset *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CLOCK_OFFSET);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4175,9 +4426,16 @@ static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pkt_type_change *ev = (void *) skb->data;
+	struct hci_ev_pkt_type_change *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_PKT_TYPE_CHANGE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4191,9 +4449,16 @@ static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pscan_rep_mode *ev = (void *) skb->data;
+	struct hci_ev_pscan_rep_mode *ev;
 	struct inquiry_entry *ie;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_PSCAN_REP_MODE);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4210,12 +4475,22 @@ static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
+	union {
+		struct hci_ev_inquiry_result_rssi *res1;
+		struct hci_ev_inquiry_result_rssi_pscan *res2;
+	} *ev = bt_skb_pull(skb, sizeof(*ev));
 	struct inquiry_data data;
-	int num_rsp = *((__u8 *) skb->data);
+	int i;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
+		return;
+	}
 
-	if (!num_rsp)
+	BT_DBG("%s num_rsp %d", hdev->name, ev->res1->num);
+
+	if (!ev->res1->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4223,16 +4498,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
-		struct inquiry_info_with_rssi_and_pscan_mode *info;
-		info = (void *) (skb->data + 1);
-
-		if (skb->len < num_rsp * sizeof(*info) + 1)
-			goto unlock;
+	if (skb->len == flex_array_size(ev, res2->info, ev->res2->num)) {
+		struct inquiry_info_rssi_pscan *info;
 
-		for (; num_rsp; num_rsp--, info++) {
+		for (i = 0; i < ev->res2->num; i++) {
 			u32 flags;
 
+			info = &ev->res2->info[i];
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -4248,15 +4520,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
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
@@ -4272,18 +4542,27 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
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
 
 static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
+	struct hci_ev_remote_ext_features *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_REMOTE_EXT_FEATURES);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4345,9 +4624,16 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_sync_conn_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_SYNC_CONN_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4443,14 +4729,21 @@ static inline size_t eir_get_length(u8 *eir, size_t eir_len)
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
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev || skb->len < flex_array_size(ev, info, ev->num)) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_EXTENDED_INQUIRY_RESULT);
+		return;
+	}
 
-	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
+	BT_DBG("%s num %d", hdev->name, ev->num);
+
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4458,7 +4751,8 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct extended_inquiry_info *info = &ev->info[i];
 		u32 flags;
 		bool name_known;
 
@@ -4493,9 +4787,16 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
+	struct hci_ev_key_refresh_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_KEY_REFRESH_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x handle 0x%4.4x", hdev->name, ev->status,
 	       __le16_to_cpu(ev->handle));
 
@@ -4602,9 +4903,16 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_io_capa_request *ev = (void *) skb->data;
+	struct hci_ev_io_capa_request *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_IO_CAPA_REQUEST);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4671,9 +4979,16 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_io_capa_reply *ev = (void *) skb->data;
+	struct hci_ev_io_capa_reply *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_IO_CAPA_REPLY);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4692,10 +5007,17 @@ static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
+	struct hci_ev_user_confirm_req *ev;
 	int loc_mitm, rem_mitm, confirm_hint = 0;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_USER_CONFIRM_REQUEST);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4777,7 +5099,14 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_user_passkey_req *ev = (void *) skb->data;
+	struct hci_ev_user_passkey_req *ev;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_USER_PASSKEY_REQUEST);
+		return;
+	}
 
 	BT_DBG("%s", hdev->name);
 
@@ -4788,9 +5117,16 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_ev_user_passkey_notify *ev = (void *) skb->data;
+	struct hci_ev_user_passkey_notify *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_USER_PASSKEY_NOTIFY);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4808,9 +5144,16 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 
 static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_keypress_notify *ev = (void *) skb->data;
+	struct hci_ev_keypress_notify *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_KEYPRESS_NOTIFY);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4847,9 +5190,16 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
+	struct hci_ev_simple_pair_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_SIMPLE_PAIR_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4878,10 +5228,17 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 static void hci_remote_host_features_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_remote_host_features *ev = (void *) skb->data;
+	struct hci_ev_remote_host_features *ev;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_REMOTE_HOST_FEATURES);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4900,9 +5257,16 @@ static void hci_remote_host_features_evt(struct hci_dev *hdev,
 static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_remote_oob_data_request *ev = (void *) skb->data;
+	struct hci_ev_remote_oob_data_request *ev;
 	struct oob_data *data;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_REMOTE_OOB_DATA_REQUEST);
+		return;
+	}
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4954,12 +5318,17 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 #if IS_ENABLED(CONFIG_BT_HS)
 static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_channel_selected *ev = (void *)skb->data;
+	struct hci_ev_channel_selected *ev;
 	struct hci_conn *hcon;
 
-	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_CHANNEL_SELECTED);
+		return;
+	}
 
-	skb_pull(skb, sizeof(*ev));
+	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
 
 	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
 	if (!hcon)
@@ -4971,9 +5340,16 @@ static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
-	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
+	struct hci_ev_phy_link_complete *ev;
 	struct hci_conn *hcon, *bredr_hcon;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_PHY_LINK_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
 	       ev->status);
 
@@ -5011,11 +5387,18 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
 static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+	struct hci_ev_logical_link_complete *ev;
 	struct hci_conn *hcon;
 	struct hci_chan *hchan;
 	struct amp_mgr *mgr;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_LOGICAL_LINK_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
 	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
 	       ev->status);
@@ -5051,9 +5434,16 @@ static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_disconn_logical_link_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_logical_link_complete *ev;
 	struct hci_chan *hchan;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s log handle 0x%4.4x status 0x%2.2x", hdev->name,
 	       le16_to_cpu(ev->handle), ev->status);
 
@@ -5075,9 +5465,15 @@ static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
 static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_disconn_phy_link_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_phy_link_complete *ev = bt_skb_pull(skb, sizeof(*ev));
 	struct hci_conn *hcon;
 
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_DISCONN_PHY_LINK_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5259,7 +5655,14 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_le_conn_complete *ev;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_CONN_COMPLETE);
+		return;
+	}
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5273,7 +5676,14 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_le_enh_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_le_enh_conn_complete *ev;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_ENHANCED_CONN_COMPLETE);
+		return;
+	}
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5291,9 +5701,16 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
+	struct hci_evt_le_ext_adv_set_term *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_EXT_ADV_SET_TERM);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5320,9 +5737,16 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_update_complete *ev = (void *) skb->data;
+	struct hci_ev_le_conn_update_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_CONN_UPDATE_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5639,25 +6063,41 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	struct hci_ev_le_advertising_report *ev;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_ADVERTISING_REPORT);
+		return;
+	}
+
+	if (!ev->num)
+		return;
 
 	hci_dev_lock(hdev);
 
-	while (num_reports--) {
-		struct hci_ev_le_advertising_info *ev = ptr;
+	while (ev->num--) {
+		struct hci_ev_le_advertising_info *info;
 		s8 rssi;
 
-		if (ev->length <= HCI_MAX_AD_LENGTH) {
-			rssi = ev->data[ev->length];
-			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-					   ev->bdaddr_type, NULL, 0, rssi,
-					   ev->data, ev->length, false);
+		info = bt_skb_pull(skb, sizeof(*info));
+		if (!info || skb->len < info->length + 1) {
+			bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+				   HCI_EV_LE_ADVERTISING_REPORT);
+			break;
+		}
+
+		if (info->length <= HCI_MAX_AD_LENGTH) {
+			rssi = info->data[info->length];
+			process_adv_report(hdev, info->type, &info->bdaddr,
+					   info->bdaddr_type, NULL, 0, rssi,
+					   info->data, info->length, false);
 		} else {
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
 
-		ptr += sizeof(*ev) + ev->length + 1;
+		skb_pull(skb, info->length + 1);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5709,26 +6149,42 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 
 static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	struct hci_ev_le_ext_adv_report *ev;
+
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_EXT_ADV_REPORT);
+		return;
+	}
+
+	if (!ev->num)
+		return;
 
 	hci_dev_lock(hdev);
 
-	while (num_reports--) {
-		struct hci_ev_le_ext_adv_report *ev = ptr;
+	while (ev->num--) {
+		struct hci_ev_le_ext_adv_info *info;
 		u8 legacy_evt_type;
 		u16 evt_type;
 
-		evt_type = __le16_to_cpu(ev->evt_type);
+		info = bt_skb_pull(skb, sizeof(*info));
+		if (!info || skb->len < info->length) {
+			bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+				   HCI_EV_LE_EXT_ADV_REPORT);
+			break;
+		}
+
+		evt_type = __le16_to_cpu(info->type);
 		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
 		if (legacy_evt_type != LE_ADV_INVALID) {
-			process_adv_report(hdev, legacy_evt_type, &ev->bdaddr,
-					   ev->bdaddr_type, NULL, 0, ev->rssi,
-					   ev->data, ev->length,
+			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
+					   info->bdaddr_type, NULL, 0,
+					   info->rssi, info->data, info->length,
 					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
 		}
 
-		ptr += sizeof(*ev) + ev->length;
+		skb_pull(skb, info->length);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5737,9 +6193,16 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_feat_complete *ev = (void *)skb->data;
+	struct hci_ev_le_remote_feat_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_EXT_ADV_REPORT);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -5778,12 +6241,19 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
+	struct hci_ev_le_ltk_req *ev;
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
 	struct smp_ltk *ltk;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_LTK_REQ);
+		return;
+	}
+
 	BT_DBG("%s handle 0x%4.4x", hdev->name, __le16_to_cpu(ev->handle));
 
 	hci_dev_lock(hdev);
@@ -5855,11 +6325,18 @@ static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
 static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_conn_param_req *ev = (void *) skb->data;
+	struct hci_ev_le_remote_conn_param_req *ev;
 	struct hci_cp_le_conn_param_req_reply cp;
 	struct hci_conn *hcon;
 	u16 handle, min, max, latency, timeout;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_REMOTE_CONN_PARAM_REQ);
+		return;
+	}
+
 	handle = le16_to_cpu(ev->handle);
 	min = le16_to_cpu(ev->interval_min);
 	max = le16_to_cpu(ev->interval_max);
@@ -5913,28 +6390,45 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	struct hci_ev_le_direct_adv_info *ev = (void *)&skb->data[1];
+	struct hci_ev_le_direct_adv_report *ev;
+	int i;
 
-	if (!num_reports || skb->len < num_reports * sizeof(*ev) + 1)
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev || skb->len < flex_array_size(ev, info, ev->num)) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_REMOTE_CONN_PARAM_REQ);
+		return;
+	}
+
+	if (!ev->num)
 		return;
 
 	hci_dev_lock(hdev);
 
-	for (; num_reports; num_reports--, ev++)
-		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-				   ev->bdaddr_type, &ev->direct_addr,
-				   ev->direct_addr_type, ev->rssi, NULL, 0,
+	for (i = 0; i < ev->num; i++) {
+		struct hci_ev_le_direct_adv_info *info = &ev->info[i];
+
+		process_adv_report(hdev, info->type, &info->bdaddr,
+				   info->bdaddr_type, &info->direct_addr,
+				   info->direct_addr_type, info->rssi, NULL, 0,
 				   false);
+	}
 
 	hci_dev_unlock(hdev);
 }
 
 static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_phy_update_complete *ev = (void *) skb->data;
+	struct hci_ev_le_phy_update_complete *ev;
 	struct hci_conn *conn;
 
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent: 0x%2.2x",
+			   HCI_EV_LE_PHY_UPDATE_COMPLETE);
+		return;
+	}
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5955,11 +6449,15 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_meta *le_ev = (void *) skb->data;
+	struct hci_ev_le_meta *ev;
 
-	skb_pull(skb, sizeof(*le_ev));
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
+		bt_dev_err(hdev, "Malformed HCI LE metaevent");
+		return;
+	}
 
-	switch (le_ev->subevent) {
+	switch (ev->subevent) {
 	case HCI_EV_LE_CONN_COMPLETE:
 		hci_le_conn_complete_evt(hdev, skb);
 		break;
@@ -6018,14 +6516,12 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 	if (!skb)
 		return false;
 
-	if (skb->len < sizeof(*hdr)) {
+	hdr = bt_skb_pull(skb, sizeof(*hdr));
+	if (!hdr) {
 		bt_dev_err(hdev, "too short HCI event");
 		return false;
 	}
 
-	hdr = (void *) skb->data;
-	skb_pull(skb, HCI_EVENT_HDR_SIZE);
-
 	if (event) {
 		if (hdr->evt != event)
 			return false;
@@ -6044,14 +6540,12 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return false;
 	}
 
-	if (skb->len < sizeof(*ev)) {
+	ev = bt_skb_pull(skb, sizeof(*ev));
+	if (!ev) {
 		bt_dev_err(hdev, "too short cmd_complete event");
 		return false;
 	}
 
-	ev = (void *) skb->data;
-	skb_pull(skb, sizeof(*ev));
-
 	if (opcode != __le16_to_cpu(ev->opcode)) {
 		BT_DBG("opcode doesn't match (0x%2.2x != 0x%2.2x)", opcode,
 		       __le16_to_cpu(ev->opcode));
@@ -6066,7 +6560,7 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 {
 	struct hci_ev_le_advertising_info *adv;
 	struct hci_ev_le_direct_adv_info *direct_adv;
-	struct hci_ev_le_ext_adv_report *ext_adv;
+	struct hci_ev_le_ext_adv_info *ext_adv;
 	const struct hci_ev_conn_complete *conn_complete = (void *)skb->data;
 	const struct hci_ev_conn_request *conn_request = (void *)skb->data;
 
@@ -6136,9 +6630,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete_t req_complete = NULL;
 	hci_req_complete_skb_t req_complete_skb = NULL;
 	struct sk_buff *orig_skb = NULL;
-	u8 status = 0, event = hdr->evt, req_evt = 0;
+	u8 status = 0, event, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
+	if (skb->len < sizeof(*hdr)) {
+		bt_dev_err(hdev, "Malformed HCI Event");
+		goto done;
+	}
+
+	event = hdr->evt;
 	if (!event) {
 		bt_dev_warn(hdev, "Received unexpected HCI Event 00000000");
 		goto done;
-- 
2.30.2

