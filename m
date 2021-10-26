Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC994C43217
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5959610FD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbhJZXGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbhJZXGC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0BC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l203so904108pfd.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vvu88eGcO3Y1R8j/qoD7AhIhYAEvp+5dQYDQHHkY7GE=;
        b=SRUrf3HLEhOHqfEantATjsB7QhKa5vpVcxFNrh9/ho7JYtFx41JbaxNxld/biYhMQd
         HoOg1WDrnYtZ//Mhyo5bkkJabnw84T7LKY1y2l9GJpbaG2nqXW5n2ImbeMA0qA8q8wnC
         qxhbKxRkAzH8apJyooCugqxxedOBI4/OdlFwdR7uj2KiLZrUOW2dKmCa4eyiT2GHEdC0
         Y+qQtE+aR1Uj76bvgjdD6gX6hAmLvXxtt2TZfQb1sowZpyZFULyiVN/hJRQ9U+TWEoX/
         om433CT7G65Cg1yW0luFqV9eIZmPlUV+IE1YiMULB+//NdBV/jJIsSwdZINdxEL5aIrX
         LiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvu88eGcO3Y1R8j/qoD7AhIhYAEvp+5dQYDQHHkY7GE=;
        b=6Y3b88bgQW5p1A8MneEmXA8RWTybWA6AdcB9IeKIkP7PQlCYbrN7x/L7f7Hvm1r5Ih
         760l4x9Ii6+WNiU+8aTfKRJle3hcWE4ynIJ7Ucf9ViCg6o7oFzZVxD9/3Rca+b7o1Nnn
         7Z6mlYZd3LiWDH8AGAvV+TpLHs+agLdf5MWLmWdquUS1Gc04/DzD+jFcGQPdwt1vTfYV
         x2AnYykw+Po2WDtLbk1tCkcsk3wRrkGnCBQT2DJ7xQrOigTbP2XS6dJnTEWnDL3uX6P/
         RERPCASMcU6+kaC5MijEWdMblZIRk26cXY/5vG6dFonqg9ROpzeytVGcknovcSBhzeLZ
         H0cQ==
X-Gm-Message-State: AOAM532qB2Xza1tI/wIAmxlfbPs/lr+dTCMbIxuI6NFwgni0k48Udj4A
        3ODkHom67v7/eYYH2hpUj8wnzIueLHQ=
X-Google-Smtp-Source: ABdhPJwqlVl8ZKTLvamCtURk4wPiiizlmRVWtf0kTQkeC6K2ZRQ0S0K/EZsbpIiBC2ba1ONfwcFxDA==
X-Received: by 2002:a63:82c7:: with SMTP id w190mr16973071pgd.210.1635289417652;
        Tue, 26 Oct 2021 16:03:37 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 15/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_DATA
Date:   Tue, 26 Oct 2021 16:03:16 -0700
Message-Id: <20211026230324.1533907-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
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
index acec95cb11b3..7e56294de790 100644
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
index f2a8e115aafb..a0997b0f3366 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4794,28 +4794,33 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
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
@@ -4850,14 +4855,31 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
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
@@ -4882,22 +4904,20 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
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

