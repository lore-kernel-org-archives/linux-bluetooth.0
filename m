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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB197C43462
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B995061245
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhDSRNd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRNc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D04C061761
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14so13471480pjl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hUhuSDNsd2dZgIF76JgZW/fltPvhJsCIuTZ5GfycqHk=;
        b=au1Q7NaND4qKsl7F1AfMHc5X7S4YU1UTG8vkWllStx4MLwIjl+veUs0kIyByrOinLy
         VWfpiMk2lKi8eP6YaxWKAqK06cC8k8UdAiMUW2388fgG6oYZbIzH2y0iiDFBoAhn+S76
         5Ak6L096xYLW3D90wJzzoRlu8tA9HWHPqKzxcRRkKR9I5bb2ec6MvvRfKNlJ7u3KZND9
         rQDC8ylsjiQPnU/J677emlu//OKLByug6WiXNMW0ONSD9JZmqvWpapmH+9ByT3X+9vUE
         qHMKdtGVy7J2u4oHaqC+vT0U8LkU6on+ycaxDWOefZTVtpcAsujpIXQ1BsNqvtRy86FS
         Da2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUhuSDNsd2dZgIF76JgZW/fltPvhJsCIuTZ5GfycqHk=;
        b=XTA6uAgd55KUzSIGQ3wFYQmtuHcmohz79YVVqpz05MjQfzysUIJXoVjzxHcGSa+NaE
         JmqiGC++j2bb5oEP/p+pEpZv+/UjkzPcdpM1uEsH6dCqIlYPxaQPWjURnY6al2II81FY
         Cqsa8Py8aLGCkxqRFmm3kva6GwAVPpuiYFTUGy5Z5YK/LMqIfZ8qMuv71CLDRQT7Jgw3
         f4gVoyaj55pT7eZYuE9lVPKFL2yHDNP0/H9n+H89DPhEfAOPuqVxsxCq40ERZqR+Jv/u
         +WW6TDoBvGJ48koWvU+OPc4Q09Z74EkBRaqx53rvYX5nzUzchucemrtZGf4zGBn8DANu
         ZMpg==
X-Gm-Message-State: AOAM530ohuUjfccnoXAuH+YAJbggxmcAIu8ujHk93tPiwQVjlxOP1xQI
        2wFScG+4PB0WhuFKoguW7xE8SwrtMV3PTg==
X-Google-Smtp-Source: ABdhPJyi5+RAqr5Iw1dafSChm+fJdcjf3cVllYAnEJaC5WboYFztznP34ZNkeB6Svr8slGQMNGE6Ug==
X-Received: by 2002:a17:90a:4f41:: with SMTP id w1mr74826pjl.231.1618852380058;
        Mon, 19 Apr 2021 10:13:00 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.12.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:12:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/10] Bluetooth: HCI: Use skb_pull to parse Command Complete event
Date:   Mon, 19 Apr 2021 10:12:49 -0700
Message-Id: <20210419171257.3865181-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Command Complete events received have
the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 766 +++++++++++++++++++++++++++++---------
 1 file changed, 581 insertions(+), 185 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 077541fcba41..cc2d68389edc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -66,12 +66,28 @@ static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
 	return data;
 }
 
+static void *hci_cc_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
+			     u16 op, size_t len)
+{
+	void *data;
+
+	data = hci_skb_pull(skb, len);
+	if (!data)
+		bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x", op);
+
+	return data;
+}
+
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 				  u8 *new_status)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_INQUIRY_CANCEL, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	/* It is possible that we receive Inquiry Complete event right
 	 * before we receive Inquiry Cancel Command Complete event, in
@@ -80,14 +96,14 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
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
@@ -108,11 +124,15 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 
 static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_PERIODIC_INQ, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	hci_dev_set_flag(hdev, HCI_PERIODIC_INQ);
@@ -120,11 +140,15 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_EXIT_PERIODIC_INQ, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
@@ -140,9 +164,13 @@ static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
 
 static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_role_discovery *rp = (void *) skb->data;
+	struct hci_rp_role_discovery *rp;
 	struct hci_conn *conn;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_ROLE_DISCOVERY, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -159,9 +187,13 @@ static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_link_policy *rp = (void *) skb->data;
+	struct hci_rp_read_link_policy *rp;
 	struct hci_conn *conn;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LINK_POLICY, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -178,10 +210,14 @@ static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_write_link_policy *rp = (void *) skb->data;
+	struct hci_rp_write_link_policy *rp;
 	struct hci_conn *conn;
 	void *sent;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_LINK_POLICY, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -203,7 +239,12 @@ static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_def_link_policy *rp = (void *) skb->data;
+	struct hci_rp_read_def_link_policy *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_DEF_LINK_POLICY,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -216,12 +257,17 @@ static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
 static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_DEF_LINK_POLICY,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_LINK_POLICY);
@@ -233,13 +279,17 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 
 static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_RESET, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	clear_bit(HCI_RESET, &hdev->flags);
 
-	if (status)
+	if (rp->status)
 		return;
 
 	/* Reset all non-persistent flags */
@@ -267,9 +317,14 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_stored_link_key *rp = (void *)skb->data;
+	struct hci_rp_read_stored_link_key *rp;
 	struct hci_cp_read_stored_link_key *sent;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_STORED_LINK_KEY,
+			     sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_STORED_LINK_KEY);
@@ -285,7 +340,12 @@ static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_delete_stored_link_key *rp = (void *)skb->data;
+	struct hci_rp_delete_stored_link_key *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_DELETE_STORED_LINK_KEY,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -300,10 +360,14 @@ static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_LOCAL_NAME, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LOCAL_NAME);
 	if (!sent)
@@ -312,8 +376,8 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_set_local_name_complete(hdev, sent, status);
-	else if (!status)
+		mgmt_set_local_name_complete(hdev, sent, rp->status);
+	else if (!rp->status)
 		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 
 	hci_dev_unlock(hdev);
@@ -321,7 +385,11 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_name *rp = (void *) skb->data;
+	struct hci_rp_read_local_name *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_NAME, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -335,10 +403,14 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_AUTH_ENABLE, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_AUTH_ENABLE);
 	if (!sent)
@@ -346,7 +418,7 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
+	if (!rp->status) {
 		__u8 param = *((__u8 *) sent);
 
 		if (param == AUTH_ENABLED)
@@ -356,20 +428,24 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
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
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_ENCRYPT_MODE, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_ENCRYPT_MODE);
@@ -386,11 +462,15 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	__u8 param;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_SCAN_ENABLE, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SCAN_ENABLE);
 	if (!sent)
@@ -400,7 +480,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (status) {
+	if (rp->status) {
 		hdev->discov_timeout = 0;
 		goto done;
 	}
@@ -421,13 +501,17 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_set_event_filter(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *)skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_set_event_filter *cp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_SCAN_ENABLE, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_SET_EVENT_FLT);
@@ -444,7 +528,11 @@ static void hci_cc_set_event_filter(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_class_of_dev *rp = (void *) skb->data;
+	struct hci_rp_read_class_of_dev *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_CLASS_OF_DEV, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -459,10 +547,14 @@ static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_CLASS_OF_DEV, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_CLASS_OF_DEV);
 	if (!sent)
@@ -470,20 +562,24 @@ static void hci_cc_write_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (status == 0)
+	if (!rp->status)
 		memcpy(hdev->dev_class, sent, 3);
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_set_class_of_dev_complete(hdev, sent, status);
+		mgmt_set_class_of_dev_complete(hdev, sent, rp->status);
 
 	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_voice_setting *rp = (void *) skb->data;
+	struct hci_rp_read_voice_setting *rp;
 	__u16 setting;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_VOICE_SETTING, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -505,13 +601,18 @@ static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_write_voice_setting(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	__u16 setting;
 	void *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_VOICE_SETTING,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_VOICE_SETTING);
@@ -534,7 +635,12 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev,
 static void hci_cc_read_num_supported_iac(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_read_num_supported_iac *rp = (void *) skb->data;
+	struct hci_rp_read_num_supported_iac *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_NUM_SUPPORTED_IAC,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -548,10 +654,14 @@ static void hci_cc_read_num_supported_iac(struct hci_dev *hdev,
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_write_ssp_mode *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_SSP_MODE, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_MODE);
 	if (!sent)
@@ -559,7 +669,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
+	if (!rp->status) {
 		if (sent->mode)
 			hdev->features[1][0] |= LMP_HOST_SSP;
 		else
@@ -567,8 +677,8 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_ssp_enable_complete(hdev, sent->mode, status);
-	else if (!status) {
+		mgmt_ssp_enable_complete(hdev, sent->mode, rp->status);
+	else if (!rp->status) {
 		if (sent->mode)
 			hci_dev_set_flag(hdev, HCI_SSP_ENABLED);
 		else
@@ -580,10 +690,14 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 status = *((u8 *) skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_write_sc_support *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_SC_SUPPORT, sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SC_SUPPORT);
 	if (!sent)
@@ -591,14 +705,14 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
+	if (!rp->status) {
 		if (sent->support)
 			hdev->features[1][0] |= LMP_HOST_SC;
 		else
 			hdev->features[1][0] &= ~LMP_HOST_SC;
 	}
 
-	if (!hci_dev_test_flag(hdev, HCI_MGMT) && !status) {
+	if (!hci_dev_test_flag(hdev, HCI_MGMT) && !rp->status) {
 		if (sent->support)
 			hci_dev_set_flag(hdev, HCI_SC_ENABLED);
 		else
@@ -610,7 +724,11 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_version *rp = (void *) skb->data;
+	struct hci_rp_read_local_version *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_VERSION, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -630,7 +748,12 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_local_commands(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_commands *rp = (void *) skb->data;
+	struct hci_rp_read_local_commands *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_COMMANDS,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -645,9 +768,14 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 static void hci_cc_read_auth_payload_timeout(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_rp_read_auth_payload_to *rp = (void *)skb->data;
+	struct hci_rp_read_auth_payload_to *rp;
 	struct hci_conn *conn;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_AUTH_PAYLOAD_TO,
+			     sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -665,10 +793,14 @@ static void hci_cc_read_auth_payload_timeout(struct hci_dev *hdev,
 static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
 					      struct sk_buff *skb)
 {
-	struct hci_rp_write_auth_payload_to *rp = (void *)skb->data;
+	struct hci_rp_write_auth_payload_to *rp;
 	struct hci_conn *conn;
 	void *sent;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_AUTH_PAYLOAD_TO, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -690,7 +822,12 @@ static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
 static void hci_cc_read_local_features(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_features *rp = (void *) skb->data;
+	struct hci_rp_read_local_features *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_FEATURES,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -740,7 +877,12 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_local_ext_features *rp = (void *) skb->data;
+	struct hci_rp_read_local_ext_features *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_EXT_FEATURES,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -757,7 +899,12 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_read_flow_control_mode *rp = (void *) skb->data;
+	struct hci_rp_read_flow_control_mode *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_FLOW_CONTROL_MODE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -769,7 +916,11 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
+	struct hci_rp_read_buffer_size *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_BUFFER_SIZE, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -795,7 +946,11 @@ static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_bd_addr *rp = (void *) skb->data;
+	struct hci_rp_read_bd_addr *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_BD_ADDR, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -812,7 +967,12 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_local_pairing_opts(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_local_pairing_opts *rp = (void *) skb->data;
+	struct hci_rp_read_local_pairing_opts *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_PAIRING_OPTS,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -829,7 +989,12 @@ static void hci_cc_read_local_pairing_opts(struct hci_dev *hdev,
 static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_page_scan_activity *rp = (void *) skb->data;
+	struct hci_rp_read_page_scan_activity *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_PAGE_SCAN_ACTIVITY,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -845,12 +1010,17 @@ static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 static void hci_cc_write_page_scan_activity(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	u8 status = *((u8 *) skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_write_page_scan_activity *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_PAGE_SCAN_ACTIVITY,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY);
@@ -864,7 +1034,12 @@ static void hci_cc_write_page_scan_activity(struct hci_dev *hdev,
 static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_page_scan_type *rp = (void *) skb->data;
+	struct hci_rp_read_page_scan_type *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_PAGE_SCAN_TYPE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -878,12 +1053,17 @@ static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 static void hci_cc_write_page_scan_type(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	u8 status = *((u8 *) skb->data);
+	struct hci_ev_status *rp;
 	u8 *type;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_PAGE_SCAN_TYPE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	type = hci_sent_cmd_data(hdev, HCI_OP_WRITE_PAGE_SCAN_TYPE);
@@ -894,7 +1074,11 @@ static void hci_cc_write_page_scan_type(struct hci_dev *hdev,
 static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_data_block_size *rp = (void *) skb->data;
+	struct hci_rp_read_data_block_size *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_DATA_BLOCK_SIZE, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -913,15 +1097,18 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 
 static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_clock *rp = (void *) skb->data;
+	struct hci_rp_read_clock *rp;
 	struct hci_cp_read_clock *cp;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
-	if (skb->len < sizeof(*rp))
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_CLOCK, sizeof(*rp));
+	if (!rp)
 		return;
 
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
 	if (rp->status)
 		return;
 
@@ -949,7 +1136,11 @@ static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
+	struct hci_rp_read_local_amp_info *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_AMP_INFO, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -971,7 +1162,11 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_rp_read_inq_rsp_tx_power *rp = (void *) skb->data;
+	struct hci_rp_read_inq_rsp_tx_power *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_INQ_RSP_TX_POWER, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -984,7 +1179,12 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
 					       struct sk_buff *skb)
 {
-	struct hci_rp_read_def_err_data_reporting *rp = (void *)skb->data;
+	struct hci_rp_read_def_err_data_reporting *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_DEF_ERR_DATA_REPORTING,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -997,12 +1197,17 @@ static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
 static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
 						struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *)skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_write_def_err_data_reporting *cp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING);
@@ -1014,10 +1219,14 @@ static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
 
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_pin_code_reply *rp = (void *) skb->data;
+	struct hci_rp_pin_code_reply *rp;
 	struct hci_cp_pin_code_reply *cp;
 	struct hci_conn *conn;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_PIN_CODE_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	hci_dev_lock(hdev);
@@ -1042,7 +1251,11 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_pin_code_neg_reply *rp = (void *) skb->data;
+	struct hci_rp_pin_code_neg_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1058,7 +1271,11 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_le_read_buffer_size *rp = (void *) skb->data;
+	struct hci_rp_le_read_buffer_size *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_BUFFER_SIZE, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1076,7 +1293,11 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_le_read_local_features *rp = (void *) skb->data;
+	struct hci_rp_le_read_local_features *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_LOCAL_FEATURES, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1089,7 +1310,11 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_le_read_adv_tx_power *rp = (void *) skb->data;
+	struct hci_rp_le_read_adv_tx_power *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_ADV_TX_POWER, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1101,7 +1326,11 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_USER_CONFIRM_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1117,7 +1346,11 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_USER_CONFIRM_NEG_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1132,7 +1365,11 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_USER_PASSKEY_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1148,7 +1385,11 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_USER_PASSKEY_NEG_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1164,7 +1405,11 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
+	struct hci_rp_read_local_oob_data *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_OOB_DATA, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 }
@@ -1172,19 +1417,27 @@ static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
 static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
+	struct hci_rp_read_local_oob_ext_data *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_OOB_EXT_DATA, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 }
 
 static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	bdaddr_t *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_RANDOM_ADDR, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_RANDOM_ADDR);
@@ -1200,12 +1453,16 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_le_set_default_phy *cp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_DEFAULT_PHY, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_DEFAULT_PHY);
@@ -1223,11 +1480,18 @@ static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
                                               struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_le_set_adv_set_rand_addr *cp;
 	struct adv_info *adv_instance;
 
-	if (status)
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
+			     sizeof(*rp));
+	if (!rp)
+		return;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR);
@@ -1251,7 +1515,12 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
 static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_le_read_transmit_power *rp = (void *)skb->data;
+	struct hci_rp_le_read_transmit_power *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_TRANSMIT_POWER,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1264,11 +1533,16 @@ static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
 
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 *sent, status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
+	__u8 *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_ADV_ENABLE, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
@@ -1301,11 +1575,16 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE);
@@ -1334,11 +1613,15 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_cp_le_set_scan_param *cp;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_SCAN_PARAM, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_PARAM);
@@ -1356,12 +1639,17 @@ static void hci_cc_le_set_ext_scan_param(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_set_ext_scan_params *cp;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 	struct hci_cp_le_scan_phy_params *phy_param;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_EXT_SCAN_PARAMS,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_SCAN_PARAMS);
@@ -1470,11 +1758,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
 	struct hci_cp_le_set_scan_enable *cp;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_SCAN_ENABLE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
@@ -1488,11 +1781,16 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
 	struct hci_cp_le_set_ext_scan_enable *cp;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE);
@@ -1505,7 +1803,12 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
 static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
-	struct hci_rp_le_read_num_supported_adv_sets *rp = (void *) skb->data;
+	struct hci_rp_le_read_num_supported_adv_sets *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x No of Adv sets %u", hdev->name, rp->status,
 	       rp->num_of_sets);
@@ -1519,7 +1822,12 @@ static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_le_read_white_list_size *rp = (void *) skb->data;
+	struct hci_rp_le_read_white_list_size *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_WHITE_LIST_SIZE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
 
@@ -1532,11 +1840,16 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 static void hci_cc_le_clear_white_list(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_CLEAR_WHITE_LIST,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	hci_bdaddr_list_clear(&hdev->le_white_list);
@@ -1546,11 +1859,16 @@ static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
 	struct hci_cp_le_add_to_white_list *sent;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_ADD_TO_WHITE_LIST,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_WHITE_LIST);
@@ -1565,11 +1883,16 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
 	struct hci_cp_le_del_from_white_list *sent;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_DEL_FROM_WHITE_LIST,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_WHITE_LIST);
@@ -1583,7 +1906,12 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_rp_le_read_supported_states *rp = (void *) skb->data;
+	struct hci_rp_le_read_supported_states *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_SUPPORTED_STATES,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1596,7 +1924,12 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 static void hci_cc_le_read_def_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_le_read_def_data_len *rp = (void *) skb->data;
+	struct hci_rp_le_read_def_data_len *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_DEF_DATA_LEN,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1611,11 +1944,16 @@ static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_write_def_data_len *sent;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_WRITE_DEF_DATA_LEN,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_WRITE_DEF_DATA_LEN);
@@ -1630,11 +1968,16 @@ static void hci_cc_le_add_to_resolv_list(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	struct hci_cp_le_add_to_resolv_list *sent;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_ADD_TO_RESOLV_LIST,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST);
@@ -1650,11 +1993,16 @@ static void hci_cc_le_del_from_resolv_list(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
 	struct hci_cp_le_del_from_resolv_list *sent;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_RESOLV_LIST);
@@ -1668,11 +2016,16 @@ static void hci_cc_le_del_from_resolv_list(struct hci_dev *hdev,
 static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_CLEAR_RESOLV_LIST,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
@@ -1681,7 +2034,12 @@ static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
 static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_le_read_resolv_list_size *rp = (void *) skb->data;
+	struct hci_rp_le_read_resolv_list_size *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_RESOLV_LIST_SIZE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
 
@@ -1694,11 +2052,17 @@ static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
 static void hci_cc_le_set_addr_resolution_enable(struct hci_dev *hdev,
 						struct sk_buff *skb)
 {
-	__u8 *sent, status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
+	__u8 *sent;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE);
@@ -1718,7 +2082,12 @@ static void hci_cc_le_set_addr_resolution_enable(struct hci_dev *hdev,
 static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_le_read_max_data_len *rp = (void *) skb->data;
+	struct hci_rp_le_read_max_data_len *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_READ_MAX_DATA_LEN,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1735,11 +2104,16 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
 	struct hci_cp_write_le_host_supported *sent;
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED);
@@ -1768,11 +2142,15 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_cp_le_set_adv_param *cp;
-	u8 status = *((u8 *) skb->data);
+	struct hci_ev_status *rp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_ADV_PARAM, sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_PARAM);
@@ -1786,10 +2164,15 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_le_set_ext_adv_params *rp = (void *) skb->data;
+	struct hci_rp_le_set_ext_adv_params *rp;
 	struct hci_cp_le_set_ext_adv_params *cp;
 	struct adv_info *adv_instance;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_LE_SET_EXT_ADV_PARAMS,
+			     sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -1817,9 +2200,13 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_rssi *rp = (void *) skb->data;
+	struct hci_rp_read_rssi *rp;
 	struct hci_conn *conn;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_RSSI, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -1837,9 +2224,13 @@ static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_cp_read_tx_power *sent;
-	struct hci_rp_read_tx_power *rp = (void *) skb->data;
+	struct hci_rp_read_tx_power *rp;
 	struct hci_conn *conn;
 
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_TX_POWER, sizeof(*rp));
+	if (!rp)
+		return;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -1870,12 +2261,17 @@ static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_ssp_debug_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 status = *((u8 *) skb->data);
+	struct hci_ev_status *rp;
 	u8 *mode;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_WRITE_SSP_DEBUG_MODE,
+			     sizeof(*rp));
+	if (!rp)
+		return;
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	mode = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE);
@@ -3334,12 +3730,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 				 hci_req_complete_t *req_complete,
 				 hci_req_complete_skb_t *req_complete_skb)
 {
-	struct hci_ev_cmd_complete *ev = (void *) skb->data;
+	struct hci_ev_cmd_complete *ev;
 
-	*opcode = __le16_to_cpu(ev->opcode);
-	*status = skb->data[sizeof(*ev)];
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CMD_COMPLETE, sizeof(*ev));
+	if (!ev)
+		return;
 
-	skb_pull(skb, sizeof(*ev));
+	*opcode = __le16_to_cpu(ev->opcode);
+	*status = skb->data[0];
 
 	switch (*opcode) {
 	case HCI_OP_INQUIRY_CANCEL:
@@ -6196,13 +6594,9 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 	if (!skb)
 		return false;
 
-	if (skb->len < sizeof(*hdr)) {
-		bt_dev_err(hdev, "too short HCI event");
+	hdr = hci_ev_skb_pull(hdev, skb, event, sizeof(*hdr));
+	if (!hdr)
 		return false;
-	}
-
-	hdr = (void *) skb->data;
-	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
 	if (event) {
 		if (hdr->evt != event)
@@ -6222,13 +6616,9 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return false;
 	}
 
-	if (skb->len < sizeof(*ev)) {
-		bt_dev_err(hdev, "too short cmd_complete event");
+	ev = hci_cc_skb_pull(hdev, skb, opcode, sizeof(*ev));
+	if (!ev)
 		return false;
-	}
-
-	ev = (void *) skb->data;
-	skb_pull(skb, sizeof(*ev));
 
 	if (opcode != __le16_to_cpu(ev->opcode)) {
 		BT_DBG("opcode doesn't match (0x%2.2x != 0x%2.2x)", opcode,
@@ -6314,9 +6704,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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

