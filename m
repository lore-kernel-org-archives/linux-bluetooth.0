Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C489C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87018610CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1ABk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhJ1ABj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB7C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v193so4243497pfc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K09IA6byef0uDQHP05b6C9ckgEI1PZHX2HefetB120Q=;
        b=LAd+UGsbncvvFwLnlxF5cakoIq5M+ezKemKAGTk9uhEXExjw01wuRqw5noVXAjbvNT
         DAkZ+YL7tQpCSV1d2yAoGHtIcfzQeY+F8wah5WUk3nIRfQbJHzM8kWLl2NVYe5xCsIc1
         Gnlp3TSmGbWezJ/jrD5pUKW5OJoNBdeZGEfDfkLClboe25UtKcS60NOgLoN+GoLwLck5
         q9KB26QMHWKCKGeGTmggh1e1dswtfsGYBsKP/NnM3SYSvUBd+9rD5OU5D//sK/1tZ1jd
         LFHZU2fAENP0Lv1/WyqMzQeavfy9Qf0GKoByttcne8joAuezWSL+uOi6w4E0/2efWYl9
         epCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K09IA6byef0uDQHP05b6C9ckgEI1PZHX2HefetB120Q=;
        b=AbFtplQ0oOedyFwWrrplB+0ktzCvxuX62fobKtFA0oS8Z98McqJPX4u69qMO9+Xk81
         P+V1RmlPVDqflbyCsKDd7ete7M1K1KKjOvqQ58MOlRiCg5MAFjdZnrkyOMlLuXMP8b9t
         GQSg49p7RE0X1W8nYKoeTkB2Y+9UaWdejvaFd9z6NXW2CM+OMxG/3N1oRcOCxUcxw/tM
         TSMUyiaZVguPki0Xrx+EF/ng035fkNE06DiwhQKuiYt9BvbtnarD9Kl60oQojeQJXpnI
         9HOuI7/swKibkZshsxgK81cOxCviV0gj8V4s7KmivkMj6g3Cjoau2dUMUTVf+ZPL24ts
         iZBA==
X-Gm-Message-State: AOAM530QPVTMdzqs0oZAKd81bbjP1ZxI6rEmRKRL8HjHwb9mVGMVRVE9
        aZC2f0E0MbArXJRpkn7fwEggwijSryU=
X-Google-Smtp-Source: ABdhPJyxKG6j29SvgJry9jGP15nHWe6x7U4AcnJyIhKwZDY/393rc2HMTKmRlNhP4tPk3nfE60vaKA==
X-Received: by 2002:a63:295:: with SMTP id 143mr682875pgc.334.1635379152896;
        Wed, 27 Oct 2021 16:59:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 15/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_DATA
Date:   Wed, 27 Oct 2021 16:58:52 -0700
Message-Id: <20211027235900.1882863-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

New functions:
  hci_read_local_oob_data_sync

This function requires all of the data from the cmd cmplt event
to be passed up to the caller via the skb.

mgmt-tester paths:
Read Local OOB Data - Not powered
Read Local OOB Data - Legacy pairing
Read Local OOB Data - Success SSP
Read Local OOB Data - Success SC

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_sync.c         |  9 ++++
 net/bluetooth/mgmt.c             | 72 ++++++++++++++++++++------------
 net/bluetooth/mgmt_util.h        |  1 +
 4 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index d969693c33b5..a381621a56a1 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -78,6 +78,8 @@ int hci_update_scan_sync(struct hci_dev *hdev);
 int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul);
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				     struct sock *sk);
+struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev, bool ext,
+					     struct sock *sk);
 
 int hci_dev_open_sync(struct hci_dev *hdev);
 int hci_dev_close_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 877f5b97a0f2..a0a5c27d111c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1703,6 +1703,15 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 	return err;
 }
 
+struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
+					     bool extended, struct sock *sk)
+{
+	u16 opcode = extended ? HCI_OP_READ_LOCAL_OOB_EXT_DATA :
+					HCI_OP_READ_LOCAL_OOB_DATA;
+
+	return __hci_cmd_sync_sk(hdev, opcode, 0, NULL, 0, HCI_CMD_TIMEOUT, sk);
+}
+
 /* Device must not be scanning when updating the accept list.
  *
  * Update is done using the following sequence:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 82369db92bb8..6bd75ec7f45e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4793,28 +4793,33 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 			       status);
 }
 
-static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
-				         u16 opcode, struct sk_buff *skb)
+static void read_local_oob_data_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_rp_read_local_oob_data mgmt_rp;
 	size_t rp_size = sizeof(mgmt_rp);
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd = data;
+	struct sk_buff *skb = cmd->skb;
+	u8 status = mgmt_status(err);
 
-	bt_dev_dbg(hdev, "status %u", status);
+	if (!status) {
+		if (!skb)
+			status = MGMT_STATUS_FAILED;
+		else if (IS_ERR(skb))
+			status = mgmt_status(PTR_ERR(skb));
+		else
+			status = mgmt_status(skb->data[0]);
+	}
 
-	cmd = pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
-	if (!cmd)
-		return;
+	bt_dev_dbg(hdev, "status %d", status);
 
-	if (status || !skb) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-				status ? mgmt_status(status) : MGMT_STATUS_FAILED);
+	if (status) {
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA, status);
 		goto remove;
 	}
 
 	memset(&mgmt_rp, 0, sizeof(mgmt_rp));
 
-	if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
+	if (!bredr_sc_enabled(hdev)) {
 		struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
 
 		if (skb->len < sizeof(*rp)) {
@@ -4849,14 +4854,31 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 			  MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
 
 remove:
-	mgmt_pending_remove(cmd);
+	if (skb && !IS_ERR(skb))
+		kfree_skb(skb);
+
+	mgmt_pending_free(cmd);
+}
+
+static int read_local_oob_data_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	if (bredr_sc_enabled(hdev))
+		cmd->skb = hci_read_local_oob_data_sync(hdev, true, cmd->sk);
+	else
+		cmd->skb = hci_read_local_oob_data_sync(hdev, false, cmd->sk);
+
+	if (IS_ERR(cmd->skb))
+		return PTR_ERR(cmd->skb);
+	else
+		return 0;
 }
 
 static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 data_len)
 {
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -4881,22 +4903,20 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_DATA, hdev, NULL, 0);
-	if (!cmd) {
+	cmd = mgmt_pending_new(sk, MGMT_OP_READ_LOCAL_OOB_DATA, hdev, NULL, 0);
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
-
-	hci_req_init(&req, hdev);
-
-	if (bredr_sc_enabled(hdev))
-		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_EXT_DATA, 0, NULL);
 	else
-		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+		err = hci_cmd_sync_queue(hdev, read_local_oob_data_sync, cmd,
+					 read_local_oob_data_complete);
 
-	err = hci_req_run_skb(&req, read_local_oob_data_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				      MGMT_STATUS_FAILED);
+
+		if (cmd)
+			mgmt_pending_free(cmd);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 9dc24ba0d51a..63b965eaaaac 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -27,6 +27,7 @@ struct mgmt_pending_cmd {
 	void *param;
 	size_t param_len;
 	struct sock *sk;
+	struct sk_buff *skb;
 	void *user_data;
 	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
 };
-- 
2.31.1

