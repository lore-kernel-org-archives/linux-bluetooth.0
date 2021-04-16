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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29305C43460
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01894613B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbhDPVWJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbhDPVVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F36C061760
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z22so9524947plo.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A/fypbvBAgtzbUr7VfZkg2pvk5kyw6mdYlFW/9VYRF0=;
        b=RVJtRyWLhGclhMqiDJU7qmmrrXV6JlG8CRn3so/q07CYpumXXD3eeSrm6wUyfi50jg
         +1q9O2n+mMyGbA1gEZl0O/50mpk0EVnY5CA256ws5W5qKfLixV88aLHCRvxBdYWin0Iu
         Ka5xq6uPmOCkqc8aRtQAuRUf3EgyoSfTgkHnCu5a8kGHg1o8RWkISArFX0F3P761/1s9
         zGKhohxloMFx7SKSJDrJ8/fBML/3+sQB5AvdS7YbS/QqrV9YlmRTO8qdZWFUh6xpug2C
         uZAwFUc6lqE6jwAgM7rkLwi2o4eh6p+8fMSU9W4bUcm+wGbUUhFB4TmnMT7dRamS/ZRY
         2eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/fypbvBAgtzbUr7VfZkg2pvk5kyw6mdYlFW/9VYRF0=;
        b=Y4bDKXClKIZh50W2d8kHFiEF/5SCTaBWTEeWRLjVN6wTdq7QWL0ESU+r+188B+3YUA
         s/a1tnhHQ+eB42jT64vr7+nUEFlPUNP4dwVwRYhe5/g5HG3QqQa0Iv8XfgQZNsiYh/H3
         vuwjRPDlBe19IE5MzM49QCggrE+VEhFhRhehDcM5F/tzHYN6BRq/CsKmWRmWv5JMyib/
         oIxz19rDhJJmLVXbZjEc62MKpZDEQB8BMu9cKZKFW4fjSP+uupLbrpsZGZnlAp6IFnMo
         zZJBUZ1+IcSOx6WCsGvAwJewEOVzNGTeg4yAWiGlhj2nJ6wuqBeuSE70LJkmFZ/ZAERk
         qOuQ==
X-Gm-Message-State: AOAM533nwkIrv4KlTgiew/U4qnWB4Brekk0kIfyFGu2gCOjWyBkRWL5q
        T7y6D1OtZIw920JEaF0B50ZiW0KXbF5tfg==
X-Google-Smtp-Source: ABdhPJwfVtMQUzHdF3DNpn9xV2j1N4WSNNrdNwWOd3iGyW2wkyd3YdWEOcHkYsG7eFE9XcpJbmxygg==
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr11330842pjb.26.1618607908089;
        Fri, 16 Apr 2021 14:18:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] Bluetooth: HCI: Use skb_pull to parse Command Complete event
Date:   Fri, 16 Apr 2021 14:18:15 -0700
Message-Id: <20210416211823.3776677-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h |   4 +
 net/bluetooth/hci_event.c   | 791 +++++++++++++++++++++++++++---------
 2 files changed, 610 insertions(+), 185 deletions(-)

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
index f360b3da4399..64f5931bfbbd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,12 +42,52 @@
 
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
+			     uint8_t ev, size_t len)
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
+static void *hci_cc_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
+			     uint16_t op, size_t len)
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
@@ -56,14 +96,14 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
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
@@ -84,11 +124,15 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
 
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
@@ -96,11 +140,15 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -116,9 +164,13 @@ static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
 
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
@@ -135,9 +187,13 @@ static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -154,10 +210,14 @@ static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -179,7 +239,12 @@ static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -192,12 +257,17 @@ static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
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
@@ -209,13 +279,17 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 
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
@@ -243,9 +317,14 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -261,7 +340,12 @@ static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
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
 
@@ -276,10 +360,14 @@ static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 
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
@@ -288,8 +376,8 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_set_local_name_complete(hdev, sent, status);
-	else if (!status)
+		mgmt_set_local_name_complete(hdev, sent, rp->status);
+	else if (!rp->status)
 		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 
 	hci_dev_unlock(hdev);
@@ -297,7 +385,11 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_name *rp = (void *) skb->data;
+	struct hci_rp_read_local_name *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_NAME, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -311,10 +403,14 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -322,7 +418,7 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
+	if (!rp->status) {
 		__u8 param = *((__u8 *) sent);
 
 		if (param == AUTH_ENABLED)
@@ -332,20 +428,25 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
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
+	if (!rp) {
+		return;
+	}
 
-	if (status)
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
 		return;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_ENCRYPT_MODE);
@@ -362,11 +463,15 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -376,7 +481,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (status) {
+	if (rp->status) {
 		hdev->discov_timeout = 0;
 		goto done;
 	}
@@ -397,13 +502,17 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -420,7 +529,11 @@ static void hci_cc_set_event_filter(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_class_of_dev *rp = (void *) skb->data;
+	struct hci_rp_read_class_of_dev *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_CLASS_OF_DEV, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -435,10 +548,14 @@ static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -446,20 +563,24 @@ static void hci_cc_write_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -481,13 +602,18 @@ static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -510,7 +636,12 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev,
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
 
@@ -524,10 +655,14 @@ static void hci_cc_read_num_supported_iac(struct hci_dev *hdev,
 
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
@@ -535,7 +670,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
+	if (!rp->status) {
 		if (sent->mode)
 			hdev->features[1][0] |= LMP_HOST_SSP;
 		else
@@ -543,8 +678,8 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_ssp_enable_complete(hdev, sent->mode, status);
-	else if (!status) {
+		mgmt_ssp_enable_complete(hdev, sent->mode, rp->status);
+	else if (!rp->status) {
 		if (sent->mode)
 			hci_dev_set_flag(hdev, HCI_SSP_ENABLED);
 		else
@@ -556,10 +691,14 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -567,14 +706,14 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -586,7 +725,11 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_version *rp = (void *) skb->data;
+	struct hci_rp_read_local_version *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_LOCAL_VERSION, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -606,7 +749,12 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -621,9 +769,14 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
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
@@ -641,10 +794,14 @@ static void hci_cc_read_auth_payload_timeout(struct hci_dev *hdev,
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
@@ -666,7 +823,12 @@ static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
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
 
@@ -716,7 +878,12 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
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
 
@@ -733,7 +900,12 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
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
 
@@ -745,7 +917,11 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
+	struct hci_rp_read_buffer_size *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_BUFFER_SIZE, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -771,7 +947,11 @@ static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_bd_addr *rp = (void *) skb->data;
+	struct hci_rp_read_bd_addr *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_READ_BD_ADDR, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -788,7 +968,12 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -805,7 +990,12 @@ static void hci_cc_read_local_pairing_opts(struct hci_dev *hdev,
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
 
@@ -821,12 +1011,17 @@ static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
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
@@ -840,7 +1035,12 @@ static void hci_cc_write_page_scan_activity(struct hci_dev *hdev,
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
 
@@ -854,12 +1054,17 @@ static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
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
@@ -870,7 +1075,11 @@ static void hci_cc_write_page_scan_type(struct hci_dev *hdev,
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
 
@@ -889,15 +1098,18 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 
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
 
@@ -925,7 +1137,11 @@ static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -947,7 +1163,11 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
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
 
@@ -960,7 +1180,12 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
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
 
@@ -973,12 +1198,17 @@ static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
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
@@ -990,10 +1220,14 @@ static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
 
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
@@ -1018,7 +1252,11 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_pin_code_neg_reply *rp = (void *) skb->data;
+	struct hci_rp_pin_code_neg_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1034,7 +1272,11 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -1052,7 +1294,11 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
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
 
@@ -1065,7 +1311,11 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
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
 
@@ -1077,7 +1327,11 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_USER_CONFIRM_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1093,7 +1347,11 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -1108,7 +1366,11 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	rp = hci_cc_skb_pull(hdev, skb, HCI_OP_USER_PASSKEY_REPLY, sizeof(*rp));
+	if (!rp)
+		return;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1124,7 +1386,11 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -1140,7 +1406,11 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
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
@@ -1148,19 +1418,27 @@ static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
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
@@ -1176,12 +1454,16 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -1199,11 +1481,18 @@ static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1227,7 +1516,12 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
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
 
@@ -1240,11 +1534,16 @@ static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
 
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
@@ -1277,11 +1576,16 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
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
@@ -1310,11 +1614,15 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
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
@@ -1332,12 +1640,17 @@ static void hci_cc_le_set_ext_scan_param(struct hci_dev *hdev,
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
@@ -1446,11 +1759,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
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
@@ -1464,11 +1782,16 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
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
@@ -1481,7 +1804,12 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
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
@@ -1495,7 +1823,12 @@ static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
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
 
@@ -1508,11 +1841,16 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
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
@@ -1522,11 +1860,16 @@ static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
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
@@ -1541,11 +1884,16 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
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
@@ -1559,7 +1907,12 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
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
 
@@ -1572,7 +1925,12 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
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
 
@@ -1587,11 +1945,16 @@ static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
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
@@ -1606,11 +1969,16 @@ static void hci_cc_le_add_to_resolv_list(struct hci_dev *hdev,
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
@@ -1626,11 +1994,16 @@ static void hci_cc_le_del_from_resolv_list(struct hci_dev *hdev,
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
@@ -1644,11 +2017,16 @@ static void hci_cc_le_del_from_resolv_list(struct hci_dev *hdev,
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
@@ -1657,7 +2035,12 @@ static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
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
 
@@ -1670,11 +2053,17 @@ static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
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
@@ -1694,7 +2083,12 @@ static void hci_cc_le_set_addr_resolution_enable(struct hci_dev *hdev,
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
 
@@ -1711,11 +2105,16 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
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
@@ -1744,11 +2143,15 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
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
@@ -1762,10 +2165,15 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -1793,9 +2201,13 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -1813,9 +2225,13 @@ static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1846,12 +2262,17 @@ static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3310,12 +3731,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
@@ -6172,13 +6595,9 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
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
@@ -6198,13 +6617,9 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
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
@@ -6290,9 +6705,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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

