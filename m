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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26FC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B3611F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhDSRNa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRNa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9CC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h11so5980876pfn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S/W73MKp9Ogf7kVYw+2CIt2zrTtfwKquuAYmI6zNilQ=;
        b=F26UpDFSF8NQBixaEgCMhsMzU1GFPMy9YzAp6XlB8tKjtFJXZb43TXg6n91k74tRmp
         1BIftJE08z8sBy1nR3f7fmpC/wfTWlaKysYh0T66UBw+LFJCJMj6uS5GV5uGIk5fPvOp
         +sld2d7DPuI0iJz5AZKIPofCPL949iqOFeNyd3gHPsItKVWPMPhkT0jB6Isa4B0WhxjL
         pn3hkcHS4IHmJrNPWRXa3RzMsBC7jXEKrv0ZEZot39F7t9/zw3AHTQYZnRD2hodnQdSd
         +E991aZZsbouDWUNApnAPZ4cxbT3d6ToCNLSf3likuBcy4n/8ClGcq3QogwL+qgIK0vC
         uACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/W73MKp9Ogf7kVYw+2CIt2zrTtfwKquuAYmI6zNilQ=;
        b=mxSiyx9Px24+Fkl38V/UsBVw2er2QODKFlxh260xlpc7BJALIJGaQOHi2OAj4tbyG9
         xi5DPS+BxMTpxuYFuWEy0TdiughZrmiFxg3VBPbDJHSjhE2gDDRWnnm0ps71kVIQjQCi
         iJYLPFxbIKEgKYC6bzyYlO33wVOhbfB+ADEKKrZU7S/bFj8TS3Jg/JrM9NxFCEPiuU1j
         yGk8G3hehbNil8dN7VO/ntCasc8+jX6nWZIW5hbfSKvhoiO/7aOe+H/J/lyq5f0/yaZQ
         czqeHJNl0fzVjYFvdbHEaXGHRo/IFXGNMwRHNBbD7VM7l1dp2LpMyinsWhCb1eVyts5j
         oRuw==
X-Gm-Message-State: AOAM5308z7Zdu64y2go+KhuC9P57w8IzqXitv43T5PtR6qvGYB8fcVpX
        cphInswcCgRKkC6RtMs1aa7HpHTqasJqlA==
X-Google-Smtp-Source: ABdhPJwuQNAroITEakAOwlje1+MJ5oucaJAjNJf4Qo2FSN8XU+8dPH2RjLiaSIYzzW1hdK5cLio/Pw==
X-Received: by 2002:a63:4513:: with SMTP id s19mr12504104pga.34.1618852379331;
        Mon, 19 Apr 2021 10:12:59 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.12.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:12:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] Bluetooth: HCI: Use skb_pull to parse BR/EDR events
Date:   Mon, 19 Apr 2021 10:12:48 -0700
Message-Id: <20210419171257.3865181-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the BR/EDR events received have the minimum
required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |   4 +
 net/bluetooth/hci_event.c   | 272 +++++++++++++++++++++++++++++-------
 2 files changed, 229 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ea4ae551c426..f1f505355e81 100644
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
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..077541fcba41 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,6 +42,30 @@
 
 /* Handle HCI Event packets */
 
+static void *hci_skb_pull(struct sk_buff *skb, size_t len)
+{
+	void *data = skb->data;
+
+	if (skb->len < len)
+		return NULL;
+
+	skb_pull(skb, len);
+
+	return data;
+}
+
+static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
+			     u8 ev, size_t len)
+{
+	void *data;
+
+	data = hci_skb_pull(skb, len);
+	if (!data)
+		bt_dev_err(hdev, "Malformed Event: 0x%2.2x", ev);
+
+	return data;
+}
+
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 				  u8 *new_status)
 {
@@ -2507,11 +2531,15 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *ev;
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_conn_check_pending(hdev);
 
@@ -2604,9 +2632,13 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_conn_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CONN_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -2728,12 +2760,16 @@ static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_conn_request *ev = (void *) skb->data;
+	struct hci_ev_conn_request *ev;
 	int mask = hdev->link_mode;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 	__u8 flags = 0;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CONN_REQUEST, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
@@ -2839,13 +2875,17 @@ static u8 hci_to_mgmt_reason(u8 err)
 
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_disconn_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_complete *ev;
 	u8 reason;
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	bool mgmt_connected;
 	u8 type;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_DISCONN_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -2931,9 +2971,13 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_auth_complete *ev = (void *) skb->data;
+	struct hci_ev_auth_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_AUTH_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3001,9 +3045,13 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_remote_name *ev = (void *) skb->data;
+	struct hci_ev_remote_name *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_REMOTE_NAME, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_conn_check_pending(hdev);
@@ -3084,9 +3132,13 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 
 static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_encrypt_change *ev = (void *) skb->data;
+	struct hci_ev_encrypt_change *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_ENCRYPT_CHANGE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3199,9 +3251,14 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_change_link_key_complete *ev = (void *) skb->data;
+	struct hci_ev_change_link_key_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CHANGE_LINK_KEY_COMPLETE,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3222,9 +3279,13 @@ static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 static void hci_remote_features_evt(struct hci_dev *hdev,
 				    struct sk_buff *skb)
 {
-	struct hci_ev_remote_features *ev = (void *) skb->data;
+	struct hci_ev_remote_features *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_REMOTE_FEATURES, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3654,9 +3715,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 			       hci_req_complete_t *req_complete,
 			       hci_req_complete_skb_t *req_complete_skb)
 {
-	struct hci_ev_cmd_status *ev = (void *) skb->data;
+	struct hci_ev_cmd_status *ev;
 
-	skb_pull(skb, sizeof(*ev));
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CMD_STATUS, sizeof(*ev));
+	if (!ev)
+		return;
 
 	*opcode = __le16_to_cpu(ev->opcode);
 	*status = ev->status;
@@ -3764,7 +3827,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_hardware_error *ev = (void *) skb->data;
+	struct hci_ev_hardware_error *ev;
+
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_HARDWARE_ERROR, sizeof(*ev));
+	if (!ev)
+		return;
 
 	hdev->hw_error_code = ev->code;
 
@@ -3773,9 +3840,13 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_role_change *ev = (void *) skb->data;
+	struct hci_ev_role_change *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_ROLE_CHANGE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3883,17 +3954,19 @@ static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
 
 static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
+	struct hci_ev_num_comp_blocks *ev;
 	int i;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_BLOCK_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_BLOCKS, sizeof(*ev));
+	if (!ev)
 		return;
-	}
 
-	if (skb->len < sizeof(*ev) ||
-	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
-		BT_DBG("%s bad parameters", hdev->name);
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_BLOCKS,
+			     flex_array_size(ev, handles, ev->num_hndl)))
+		return;
+
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_BLOCK_BASED) {
+		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
@@ -3934,9 +4007,13 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_mode_change *ev = (void *) skb->data;
+	struct hci_ev_mode_change *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_MODE_CHANGE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3962,9 +4039,13 @@ static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pin_code_req *ev = (void *) skb->data;
+	struct hci_ev_pin_code_req *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_PIN_CODE_REQ, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4032,11 +4113,15 @@ static void conn_set_key(struct hci_conn *conn, u8 key_type, u8 pin_len)
 
 static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_link_key_req *ev = (void *) skb->data;
+	struct hci_ev_link_key_req *ev;
 	struct hci_cp_link_key_reply cp;
 	struct hci_conn *conn;
 	struct link_key *key;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_LINK_KEY_REQ, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -4092,12 +4177,16 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_link_key_notify *ev = (void *) skb->data;
+	struct hci_ev_link_key_notify *ev;
 	struct hci_conn *conn;
 	struct link_key *key;
 	bool persistent;
 	u8 pin_len = 0;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_LINK_KEY_NOTIFY, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4152,9 +4241,13 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_clock_offset *ev = (void *) skb->data;
+	struct hci_ev_clock_offset *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CLOCK_OFFSET, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4175,9 +4268,13 @@ static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pkt_type_change *ev = (void *) skb->data;
+	struct hci_ev_pkt_type_change *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_PKT_TYPE_CHANGE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4191,9 +4288,13 @@ static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pscan_rep_mode *ev = (void *) skb->data;
+	struct hci_ev_pscan_rep_mode *ev;
 	struct inquiry_entry *ie;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_PSCAN_REP_MODE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4281,9 +4382,14 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
+	struct hci_ev_remote_ext_features *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_REMOTE_EXT_FEATURES,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4345,9 +4451,13 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_sync_conn_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_SYNC_CONN_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4493,9 +4603,14 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
+	struct hci_ev_key_refresh_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_KEY_REFRESH_COMPLETE,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x handle 0x%4.4x", hdev->name, ev->status,
 	       __le16_to_cpu(ev->handle));
 
@@ -4602,9 +4717,13 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_io_capa_request *ev = (void *) skb->data;
+	struct hci_ev_io_capa_request *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_IO_CAPA_REQUEST, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4671,9 +4790,13 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_io_capa_reply *ev = (void *) skb->data;
+	struct hci_ev_io_capa_reply *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_IO_CAPA_REPLY, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4692,10 +4815,15 @@ static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
+	struct hci_ev_user_confirm_req *ev;
 	int loc_mitm, rem_mitm, confirm_hint = 0;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_USER_CONFIRM_REQUEST,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4777,7 +4905,12 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_user_passkey_req *ev = (void *) skb->data;
+	struct hci_ev_user_passkey_req *ev;
+
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_USER_PASSKEY_REQUEST,
+			     sizeof(*ev));
+	if (!ev)
+		return;
 
 	BT_DBG("%s", hdev->name);
 
@@ -4788,9 +4921,14 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_ev_user_passkey_notify *ev = (void *) skb->data;
+	struct hci_ev_user_passkey_notify *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_USER_PASSKEY_NOTIFY,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4808,9 +4946,13 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 
 static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_keypress_notify *ev = (void *) skb->data;
+	struct hci_ev_keypress_notify *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_KEYPRESS_NOTIFY, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4847,9 +4989,14 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
+	struct hci_ev_simple_pair_complete *ev;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_SIMPLE_PAIR_COMPLETE,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4878,10 +5025,15 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 static void hci_remote_host_features_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_remote_host_features *ev = (void *) skb->data;
+	struct hci_ev_remote_host_features *ev;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_REMOTE_HOST_FEATURES,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4900,9 +5052,14 @@ static void hci_remote_host_features_evt(struct hci_dev *hdev,
 static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_remote_oob_data_request *ev = (void *) skb->data;
+	struct hci_ev_remote_oob_data_request *ev;
 	struct oob_data *data;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_REMOTE_OOB_DATA_REQUEST,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
@@ -4954,12 +5111,14 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 #if IS_ENABLED(CONFIG_BT_HS)
 static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_channel_selected *ev = (void *)skb->data;
+	struct hci_ev_channel_selected *ev;
 	struct hci_conn *hcon;
 
-	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CHANNEL_SELECTED, sizeof(*ev));
+	if (!ev)
+		return;
 
-	skb_pull(skb, sizeof(*ev));
+	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
 
 	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
 	if (!hcon)
@@ -4971,9 +5130,13 @@ static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
-	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
+	struct hci_ev_phy_link_complete *ev;
 	struct hci_conn *hcon, *bredr_hcon;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_PHY_LINK_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
 	       ev->status);
 
@@ -5011,11 +5174,16 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
 static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+	struct hci_ev_logical_link_complete *ev;
 	struct hci_conn *hcon;
 	struct hci_chan *hchan;
 	struct amp_mgr *mgr;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_LOGICAL_LINK_COMPLETE,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
 	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
 	       ev->status);
@@ -5051,9 +5219,14 @@ static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_disconn_logical_link_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_logical_link_complete *ev;
 	struct hci_chan *hchan;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s log handle 0x%4.4x status 0x%2.2x", hdev->name,
 	       le16_to_cpu(ev->handle), ev->status);
 
@@ -5075,9 +5248,14 @@ static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
 static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_disconn_phy_link_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_phy_link_complete *ev;
 	struct hci_conn *hcon;
 
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_DISCONN_PHY_LINK_COMPLETE,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
-- 
2.30.2

