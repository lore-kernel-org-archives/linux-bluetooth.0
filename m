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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB598C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86455613B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbhDPVWH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbhDPVVp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D833C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso15302849pje.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3SjG5Xa3fbd69BUfJhfI+rCQN0Y5uALuRRqG6NJo4VM=;
        b=El5lLJFOZSsw0AMkxWIESd5jMjvqzL5GhiI0iNmPPl7KnmqjZIRFa8NfOMPwQ8+eeT
         9nw7+dOtQoSqUTZsnFHCld6fokdNQkmoSwiSF8r2H74UYAorApxK322qtMnT/qIPmRSk
         foJnxsMs5uhzuz/aecEk9yEe2BKeh9P5Tecbz3Dx+UzcXLLyZ5sy/b9QhOT2UQyIKDNy
         vXNmoVbpL+maTXCgSt9gX/RdtGqgeNbw964QC3heF8YaWP6QfpvHwmi0c8tln706982/
         gehM4ArpOIkED4lsLr0QP1bVtslFQ6WTwR9CjjaGEHt3WmtfJbnThQwRRzMTpBY+fyXN
         TPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SjG5Xa3fbd69BUfJhfI+rCQN0Y5uALuRRqG6NJo4VM=;
        b=JpQfnnD7XaJqJckBN8XObhXutbPbwRQTdEPBfaT4GF/qupYXBypFXgTaWeTaKt/X5K
         Xb1fpro4yF2SqxfeW1E4ttRbn/KZdqoCys+qqrgfY8P3tpolkRDhbzKXlyiPeGWeMVDX
         wMmawJwc87YC3WPi4G3N9NISU5YT3pG96Liw1pdHG14TVGT2wmxoVrnbLKrLGCl6iTdo
         LPFl3jalyNDOMX26gc94Dsfbssi0jYk6i61KKfzvgApxIAo2oGAwp8BnqvhHpZOsC5MH
         QMFoTQ9HEpPPF1Aat8I4x8RP6iqEULiIex0VYPw4fYca/fvSNjWtrYXtXhe0DXKiFOAi
         /0LA==
X-Gm-Message-State: AOAM530XWEYaFo/boFNwb2CUrJ7s+fzvLXYHlR6e724/uCtcyTNRI+uf
        uvEn+pYzz106Ell9p60F/sKZ83Uglv1gmg==
X-Google-Smtp-Source: ABdhPJwQKxN6KQCq2HjlIOwcMbgPTMf2yU3dC/5QQ68s58BUeV0rUftcknhOcSEU0LpBE/ZZZOsyaw==
X-Received: by 2002:a17:902:8486:b029:ec:8b6c:f998 with SMTP id c6-20020a1709028486b02900ec8b6cf998mr996329plo.33.1618607907202;
        Fri, 16 Apr 2021 14:18:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Bluetooth: HCI: Use skb_pull to parse BR/EDR events
Date:   Fri, 16 Apr 2021 14:18:14 -0700
Message-Id: <20210416211823.3776677-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c | 248 ++++++++++++++++++++++++++++++--------
 1 file changed, 201 insertions(+), 47 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..f360b3da4399 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2507,11 +2507,15 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 
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
 
@@ -2604,9 +2608,13 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -2728,12 +2736,16 @@ static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
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
 
@@ -2839,13 +2851,17 @@ static u8 hci_to_mgmt_reason(u8 err)
 
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
@@ -2931,9 +2947,13 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3001,9 +3021,13 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3084,9 +3108,13 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 
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
@@ -3199,9 +3227,14 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3222,9 +3255,13 @@ static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
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
@@ -3654,9 +3691,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
@@ -3764,7 +3803,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_hardware_error *ev = (void *) skb->data;
+	struct hci_ev_hardware_error *ev;
+
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_HARDWARE_ERROR, sizeof(*ev));
+	if (!ev)
+		return;
 
 	hdev->hw_error_code = ev->code;
 
@@ -3773,9 +3816,13 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3883,17 +3930,19 @@ static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
 
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
 
@@ -3934,9 +3983,13 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3962,9 +4015,13 @@ static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -4032,11 +4089,15 @@ static void conn_set_key(struct hci_conn *conn, u8 key_type, u8 pin_len)
 
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
@@ -4092,12 +4153,16 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -4152,9 +4217,13 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -4175,9 +4244,13 @@ static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -4191,9 +4264,13 @@ static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -4281,9 +4358,14 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
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
@@ -4345,9 +4427,13 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
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
@@ -4493,9 +4579,14 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
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
 
@@ -4602,9 +4693,13 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 
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
@@ -4671,9 +4766,13 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -4692,10 +4791,15 @@ static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -4777,7 +4881,12 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
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
 
@@ -4788,9 +4897,14 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
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
@@ -4808,9 +4922,13 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 
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
@@ -4847,9 +4965,14 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -4878,10 +5001,15 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
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
@@ -4900,9 +5028,14 @@ static void hci_remote_host_features_evt(struct hci_dev *hdev,
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
@@ -4954,12 +5087,14 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
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
@@ -4971,9 +5106,13 @@ static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -5011,11 +5150,16 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
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
@@ -5051,9 +5195,14 @@ static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -5075,9 +5224,14 @@ static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
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

