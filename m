Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E1AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDEE60F70
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhJYXnl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhJYXni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B2C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv3so3485733pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+igU97I0KOu1vXr/6lzQcycqJg3NZCPmgmt0N7DG+bc=;
        b=GiYQ1iJUUNsbmiMT3l3XK4z+16y3v1K5EyZC4kyGKdGrv2M+uR399/7DZwb/SRSyLR
         +H3JnRengj8P1CjVEYVTL/mYdG0SftkalQjsukrXDl4HHzRKglJ7yJUZTKlP37WCjJcJ
         c1CoU6rWk8G+JAzDOOrwFnPsQcoNgtdC1+leYEwfbXmYF9YWZSh3uJAPblYtmQVwzNza
         0mz3fF0t1NcvDOg2KsbtOFRcyRAaNdO/h+USrFxtzSqOYdUsJKjWNfYQoSmWzV0UMLQS
         sZ7efKQkXvjqHTNDdgat/I+KTmWO6FZ/JdIW58XGbR1eL7reUa6dcgouujYz13mOb7bM
         2bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+igU97I0KOu1vXr/6lzQcycqJg3NZCPmgmt0N7DG+bc=;
        b=0lGNiN49C54uCK2bnQPQ7X8TW7Yw+nvwxxA9dcAgRKaBW2+0AiHWi6g9gUg7J3j4Cj
         bf+ObFFpEoAyqGGNYs5D3IEpY3XHg6fzcsv77HgV6+tNsxD4YAFnuX1wLNtW8jzPMKyL
         7bAjosSM/N33AH4mwlydV5nKH3w+71pv1KUtDwx4r2zjoaLa6YCJrVrbHM6MmPFyx6th
         wPrQ1DhoIflRi7t0Mr+MrDTFWf4quq65mIpTcuVjEFnmneM2843c5r7IznzyUBB4mQNF
         EKH7JnfFeWLEtML2Cviwbq6bRMqw0Kfkx8qTp+4uOJHAsWh52pZjxGU//hsd7FGrOw4f
         VFLQ==
X-Gm-Message-State: AOAM533fsp0GWMePrFhSNZu8sVnMOpwSGjDmtlpBX8U08iaZPK+7MnYP
        A8m8rHQfjK9A54JypW5W61lVw87yiFs=
X-Google-Smtp-Source: ABdhPJxQpLDEjvA2CI5ISoVVneX+GKOojCzz63d3lhjAOd/pTBKn+THuR3X5k8DjrDYE0ZeOL9GEhg==
X-Received: by 2002:a17:90a:fe16:: with SMTP id ck22mr15024849pjb.186.1635205274872;
        Mon, 25 Oct 2021 16:41:14 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 15/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_DATA
Date:   Mon, 25 Oct 2021 16:40:54 -0700
Message-Id: <20211025234102.1140719-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
index 605f49554dc3..e191e63e44c7 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -79,6 +79,8 @@ int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le,
 					    u8 simul);
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					    struct sock *sk);
+struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev, bool ext,
+							struct sock *sk);
 
 int hci_dev_open_sync(struct hci_dev *dev);
 int hci_dev_close_sync(struct hci_dev *dev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e117f3a053af..515c68a499f8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1703,6 +1703,15 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 	return err;
 }
 
+struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev, bool extended,
+								struct sock *sk)
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
index c2037256cc1e..fb35a860096c 100644
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
+				 read_local_oob_data_complete);
 
-	err = hci_req_run_skb(&req, read_local_oob_data_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+						MGMT_STATUS_FAILED);
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

