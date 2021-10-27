Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CD1C43219
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5B3610E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJ0WUk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhJ0WUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F8C061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f5so4326387pgc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HqHFJl12MSyJRBvx/PzSfDFNt4ah0IxqiChBCiKEXR8=;
        b=OZo91eQbjw4Y36wPbhbBgE/MPVa7l0ZzVpFlUCbTo9pjO+yaPQSv8Z5kCou3vg9Q5R
         jlVja63MEYZqEZYME4wiLyTslSSChecZHo6kijLwt+BxzpYQvKPKgqDae/sfMHdo6N/4
         sNb3GVABqEgCX8gOuJ60Dn4RkaUeQE6z0y4r0jQTmgzbffxmYnfxCzmZaxqpSI5blvfR
         EXZcEn3ZJxgRn6pedpavoEOfa/q76lFlfyk/fvvezgbGZPFtjFkL0lEye8r803b8r4du
         Rjrxem8qpn1HOHXjmi3lRW35gdllvxt5CyiaPt1bAM3pQPYJcbxcNPUmSKDdUULqyOX5
         skJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqHFJl12MSyJRBvx/PzSfDFNt4ah0IxqiChBCiKEXR8=;
        b=fRg8SAdKifrWwNzq9dW2MgBBIBysho/UH/K3WsPImVmis5hletfcNcIqDuiSxLWlah
         Vj8QOZgiI63OLTRk+rqf8w1HBnJSOXoco5BlH9GuE0r8EzVANFgkOVT2OoDg6Ru7LEcV
         8XCajR2rc+C3KSbc8GdMOZt9OvwXdcGbVc/g2XvXtqvOR+7UIjCNF4a0+Wk6UCYgvAbV
         Ct4A6+Vfv9RCQFqpsOnDBKJqnK1wTvnGwlkkVKiKfHcY0jdiWJcXNaEwS+5Hs4fs40lS
         WwmGhZfd1GyoFGLCTzztimoE1WEHecSS23TXAoq6ei6CZP1Sol/CUoV23n3Uhm9AYO6C
         EQ4g==
X-Gm-Message-State: AOAM530k0YIZdGF8Du383Vg1wdnRR607r5YpX6A9DZBk5zj4MjSac0q4
        rN7vf6z0c+y4/Oo+KOxGoYn9/il2pD0=
X-Google-Smtp-Source: ABdhPJwAd8QzomIv5v9ZPOUPzhZe4rpAt7LU/zx/PTG1ugMBs/jEUGjK/59mGKM/rP7CX2ziJWSKEQ==
X-Received: by 2002:a63:af09:: with SMTP id w9mr320713pge.323.1635373092408;
        Wed, 27 Oct 2021 15:18:12 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 09/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_FAST_CONNECTABLE
Date:   Wed, 27 Oct 2021 15:17:48 -0700
Message-Id: <20211027221802.1851851-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This creates a synchronized Write Fast Connectable call and attaches it
to the MGMT_OP_SET_FAST_CONNECTABLE management opcode.

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
index 2f988d7f0008..f7c30b4e9aca 100644
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

