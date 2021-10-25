Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154F760F70
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhJYXnf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhJYXnd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745BC061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so156480pjd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WmWOKaitIlDH/mWuEgWnFFNHTgI6mJzKGeWIfxX79Vk=;
        b=iJ3DM2qiLC69Zl/IKtYMwhSBi8ynYZo4XyiAkjJsxODdH/y/2zjUQNREuIl1pVn/4b
         7SXJD8hT7Ur7LJOhnMqeLJpRCy/x/vfpwT15EAf05SixT9zM38nhFgHOt5O8xtjy22sk
         xWcjNcS9pWTA473qnI6zlmpqYe459rCBOJd8sn/cFyI9bow1qfB61lbQEC+8a8INnftN
         yW8ey6keKKCIvwC5ZhD245s5DGxjzDzD1LpexmEvUilE/pxC+6yFghQ5ldPoWmN0AMLB
         G+Z4qGfCnGddR3Dt5AklAzRDA4fwRQG2VfSKYhZleIHCPY4tAcgeOmL5D02r+buytYmv
         CWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmWOKaitIlDH/mWuEgWnFFNHTgI6mJzKGeWIfxX79Vk=;
        b=pLIyEo7QdGRonzV8YiBDLyzQWD1MbVMBJ3lynY9+jWGFUK70VZdcDRukObqbNxzr5q
         Wyt4uk1s6a/ZEBugX6Tbu3QgEiGEPyhGICJB5L03Spx0aPlXFWTT/s2IteEfD546HfJL
         mPpfUViIVaj0ovdplFhDUNXED6HPlSspzen9nAgGp8P35gfL09TWabcqAuzTTgG2Tvw6
         6H7ez6CSZHXKJ1zZQaEA4CzMzceftGRodXb3Bep2+xe/lUuwilv/uST37UAfQMVCPydT
         j2767psbzHiIZVPX5+dUDb45F/6FqBfPPirAd9nZf34VseIl8h2GVQKvEW2Q+YT4n+UP
         UkxQ==
X-Gm-Message-State: AOAM533JSUtfghkMFhY8CA6IcEwDy+zC26HqMRXf07P8p+1WtU8vLE80
        lRbBvrbAsPx270hPFEl0HdDbdfsu1Zo=
X-Google-Smtp-Source: ABdhPJyyF6eSoYcpqIHzhb6iY9uBpL2GaLx4JHjsrKMNmlh52PYlWi21rIiSeI/PtQ+dlgzCxg0UZw==
X-Received: by 2002:a17:90b:3b86:: with SMTP id pc6mr21796067pjb.143.1635205270002;
        Mon, 25 Oct 2021 16:41:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 09/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_FAST_CONNECTABLE
Date:   Mon, 25 Oct 2021 16:40:48 -0700
Message-Id: <20211025234102.1140719-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c             | 72 ++++++++++++++------------------
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 546d3b3f9f89..1a0fd4530575 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -68,6 +68,8 @@ int hci_disable_advertising_sync(struct hci_dev *hdev);
 int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
 
+int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
+
 int hci_dev_open_sync(struct hci_dev *dev);
 int hci_dev_close_sync(struct hci_dev *dev);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 54181dc5267b..78397200e167 100644
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
index 663049821bed..e83592e120b9 100644
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
+							mgmt_status(err));
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
@@ -5903,58 +5901,52 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) ||
 	    hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				       MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id,
+						MGMT_OP_SET_FAST_CONNECTABLE,
+						MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				       MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id,
+						MGMT_OP_SET_FAST_CONNECTABLE,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
-	if (pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				      MGMT_STATUS_BUSY);
-		goto unlock;
-	}
-
 	if (!!cp->val == hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
-					hdev);
+									hdev);
 		goto unlock;
 	}
 
 	if (!hdev_is_powered(hdev)) {
 		hci_dev_change_flag(hdev, HCI_FAST_CONNECTABLE);
 		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
-					hdev);
+									hdev);
 		new_settings(hdev, sk);
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev,
-			       data, len);
-	if (!cmd) {
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev,
+								data, len);
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
+	else
+		err = hci_cmd_sync_queue(hdev, write_fast_connectable_sync, cmd,
+						fast_connectable_complete);
 
-	hci_req_init(&req, hdev);
+	if (err < 0) {
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+							MGMT_STATUS_FAILED);
 
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

