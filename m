Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0985C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCC7610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhJZXGB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbhJZXF6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:05:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02BCC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 127so909078pfu.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5fZUUYn0CDq4Ixi2ZdkmxbjZr6JQ99eo0l1qBBHrqcI=;
        b=nSqGcAJkjRGgOC7+hAV7sfxF/oxqkjbQ0kxC0tQkzcQyapRNOavNvnn/BaSS1yCkyT
         rjTyhfeAHVLJiL4mYnGjVxef7Q/Xs9Vucq3MqRY6lxRvFQY1/mGjR8G5iro7hTnrrLVf
         +edD9Og3Co9KV8801UrOtlvECdxErxXhkbCoppv8q9Jir8alpJnu7JlqaVF1VuVSZwCz
         2m6VavfJ2o9xUsYZ1YwRdO2k0VMKNCLz22l1WamqvdbgEZlRFwAxkhvaPiE5A3JODoje
         LAoDvxTkQ2iNUJuvixMbd/+r50DusR2WZohJf8D13s41CwgNaF3WNk2QzW7vXvf1maM0
         qf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fZUUYn0CDq4Ixi2ZdkmxbjZr6JQ99eo0l1qBBHrqcI=;
        b=BlJ3iV7mhH4NyHJu8rAWrGdNHlQUsLOugiZ1Nz53qymyxh7Gzoy23ODXNVcfMZ6JYZ
         eDY49dMrjlgUZnoPJzePg1DMWehu9kNlhSZ5Ko7iGW8bHyvvAyq1W0H+UTiFzao6dEfg
         7k8Ci/oLTtkiDmeSDK6kU61HSaTfniI0+n/60WVcgtZd0mrm8imvlodO4Q1k4hByPbfo
         L5jYknWN9dLDY/reNI2hlhKd29ajYGHFqfQo72p94bJaOyaR/2689MKJoE8/J1TobWuO
         rgz9I6cx7ua5VZyQ5hBTAWr0icZBb0Hadpr9DS0ND5cC7VlUkFUx4COU7ETdxAGHUXgE
         Vj4Q==
X-Gm-Message-State: AOAM5309Zty1Uy5/vxkLQEG+jmwOGjhONWLjKVVcGq/oQ3yKrQP22EI0
        C0e77UJn4b8QRRJArTX6jIGTxyuyyfI=
X-Google-Smtp-Source: ABdhPJxNUuJrKycgzL+A945dfEqA01tZEGmJ2e16tXXn5OScNZgV1laX3nCkQCSYctUsmBRRqR/vzw==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr16819281pge.361.1635289413094;
        Tue, 26 Oct 2021 16:03:33 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 09/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_FAST_CONNECTABLE
Date:   Tue, 26 Oct 2021 16:03:10 -0700
Message-Id: <20211026230324.1533907-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This creates a synchronized Write Fast Connectable call and attaches it
to the MGMT_OP_SET_FAST_CONNECTABLE managment opcode.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/mgmt.c             | 70 ++++++++++++++------------------
 3 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index c4fa77321b31..1fb66b6f8a34 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -68,6 +68,8 @@ int hci_disable_advertising_sync(struct hci_dev *hdev);
 int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
 
+int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
+
 int hci_dev_open_sync(struct hci_dev *hdev);
 int hci_dev_close_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 471ee5bc5665..476feca1dd88 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2193,7 +2193,7 @@ static int hci_write_auth_enable_sync(struct hci_dev *hdev)
 				     HCI_CMD_TIMEOUT);
 }
 
-static int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable)
+int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable)
 {
 	struct hci_cp_write_page_scan_activity cp;
 	u8 type;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 663049821bed..10e18ab9e61b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5864,22 +5864,15 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
-				      u16 opcode)
+static void fast_connectable_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_pending_cmd *cmd;
-
-	bt_dev_dbg(hdev, "status 0x%02x", status);
-
-	hci_dev_lock(hdev);
+	struct mgmt_pending_cmd *cmd = data;
 
-	cmd = pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev);
-	if (!cmd)
-		goto unlock;
+	bt_dev_dbg(hdev, "err %d", err);
 
-	if (status) {
+	if (err) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-			        mgmt_status(status));
+				mgmt_status(err));
 	} else {
 		struct mgmt_mode *cp = cmd->param;
 
@@ -5892,10 +5885,15 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 		new_settings(hdev, cmd->sk);
 	}
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
+}
 
-unlock:
-	hci_dev_unlock(hdev);
+static int write_fast_connectable_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_mode *cp = cmd->param;
+
+	return hci_write_fast_connectable_sync(hdev, cp->val);
 }
 
 static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
@@ -5903,58 +5901,50 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) ||
 	    hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_FAST_CONNECTABLE,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_FAST_CONNECTABLE,
 				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
-	if (pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				      MGMT_STATUS_BUSY);
-		goto unlock;
-	}
-
 	if (!!cp->val == hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE)) {
-		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
-					hdev);
+		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev);
 		goto unlock;
 	}
 
 	if (!hdev_is_powered(hdev)) {
 		hci_dev_change_flag(hdev, HCI_FAST_CONNECTABLE);
-		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
-					hdev);
+		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev);
 		new_settings(hdev, sk);
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev,
-			       data, len);
-	if (!cmd) {
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev, data,
+			       len);
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
+	else
+		err = hci_cmd_sync_queue(hdev, write_fast_connectable_sync, cmd,
+					 fast_connectable_complete);
 
-	hci_req_init(&req, hdev);
+	if (err < 0) {
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				MGMT_STATUS_FAILED);
 
-	__hci_req_write_fast_connectable(&req, cp->val);
 
-	err = hci_req_run(&req, fast_connectable_complete);
-	if (err < 0) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				      MGMT_STATUS_FAILED);
-		mgmt_pending_remove(cmd);
+		if (cmd)
+			mgmt_pending_free(cmd);
 	}
 
 unlock:
-- 
2.31.1

