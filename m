Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E060EBD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJ0WUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhJ0WUn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01448C061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v16so2997448ple.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VgVIdkQ3y73MiYN0r7noiAA/fZ9ZAbz94eidsLm9fic=;
        b=m+iCA8lSB91Un0x+WCEFLg9/hwhc2Rjodpg7dVwmHP9r49Dz1pqZDkDzFw9aD5Stih
         O6H5E121wV1JYeLLWIVPSIsIsAkMGyumGRFO+3j4EZHtVcSx/vGZT2tkkgbK/12SIi2t
         XMTVR5Cj4xcl3aoKAozX2FUvqHfL8/v14KfYNIj+pII9BgutT/R09J+3bXqG+aGtoIr8
         aFKv0n+Vs/LU8ZVTYVKS2UlMGPV9P6ejuSyREXYhp19AgtrrYMg5mTD16T2T7PUZ7LTv
         IPYjNHfCsmwm1KqD5cXr+AhuMHN5qBaX0z5EOPObDqr3aLXSsC4rcEL3JcEq5unth79d
         U7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgVIdkQ3y73MiYN0r7noiAA/fZ9ZAbz94eidsLm9fic=;
        b=cu6pKwyIMD6nsLelyJOXUdbr3MEHGg4n79Mo7Mrfqf6sHXkXtAmy2TH+lRYCxz1Y54
         l5gs3vwlch4AwVw5tbuTbMaEfxIe56a3A0Ho8foYC/uFreiYfB4/KJvtlovAgDMXzrhc
         guILvtKtcqHO8PEAt5jMY8vRsU+cbuCUBSfzsF2hI9KcXemf5mrBRMFPchRc93jOtHJX
         Ap+mjRvlCZl+8eDyxp/0pj6r5Tual3Dup+C7cCnvl3DTI+NKYE/B6HHYAQo8HC5zYJ+L
         T3o4J9DNXy1WhpTne8EJUk3KEftskctOnt67TnL8LOVEaEZNdMX+g3JHcpZVAmgqo2PV
         E3wQ==
X-Gm-Message-State: AOAM530zPt66tr6JB9r41g+aaomvDW7G0OfMN5cSlyodlhjk1fuVinI5
        sLFpZcXPSLP1FrnRYUUuRJHDaeOzp6c=
X-Google-Smtp-Source: ABdhPJxIORUEsQO8y7KbE0QpnrkC8CfWSf8V4yo5NavPWQ7Rh+UXmltm4QqmWmB3xoExRelf0tL2iQ==
X-Received: by 2002:a17:902:9348:b0:141:5862:28b4 with SMTP id g8-20020a170902934800b00141586228b4mr426787plp.17.1635373097247;
        Wed, 27 Oct 2021 15:18:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 15/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_DATA
Date:   Wed, 27 Oct 2021 15:17:54 -0700
Message-Id: <20211027221802.1851851-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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
index 8091a0739d90..1adee59a43d4 100644
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

