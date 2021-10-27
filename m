Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FEC4167B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF19610CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1ABf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJ1ABe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D8C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so4543138pgl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ErfpEAGdAV6BUHXdX62d/I0u6g1ukiWTa+wLB+nhdRw=;
        b=iDO2NsMpT6eTBbp/kGZtWLaO9gKd24dRXNk2F4lMjq80d6DFmJvS6dsTN4vyGeXico
         xhDGudNKF4vAbaZ6rwObae3orXCzJBL3YXCRSb7pIXaeyYYMLORCIr3BT+NNpWsZIVFJ
         Dr6IIPNJLQceAU22ajuUN4iFdHrbsPMJy92dtHHhHLWIqA/GwHwLbpr2UUXKTg0OnM+r
         ealwEEtRufLFbJsMAy/5/RdyCe0wOJyhwDrfQQoTCaUFW0glr1AXm4ZH4QkpV2oMLMLq
         uDaEN+JCpLsyq8DbMaZtuZ6GqJVJcnpm2Cg6j+Pa/Y/L/HZ3HOxWOGGgxsq41DRW5zDy
         a9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErfpEAGdAV6BUHXdX62d/I0u6g1ukiWTa+wLB+nhdRw=;
        b=21kwEI9sXDnFwXLZ7oq3x5DcyjioGcWaYiNeGyAzHmP5UC0QPu25YtGHfmCdvwkE73
         Kvpdf7/MJeyll0LbjiFZ0J84/OCxCSNl5r6EgTIPPca/JtQZE2rudWyqPS9I4iVHu4CE
         G7fascLHb4I2IJjDKQwCefS9UDIkM6thIjzTPPv4pjwV/nLisj5CtYjRRywqyO1FKooq
         OqHQlN0Ubgp1XAtQdBYvIek9oQQhuJz4/xc2kiO4EevZbDA8HROpxPGezgMWE56kD9Xr
         e7uj9fIXHGX1k9mhgvTuBR/CIHO+71CQIb866ZLuROniDhlIKdBDFJVGsyOn20nlNitu
         qIbA==
X-Gm-Message-State: AOAM5329wUB0rO1Fm285xHFB9Co4fNQ9UUa5WYE4sVM9jXBUydWbAYxd
        C6F0mNLOWRUk3sbb7gby49tN7CFpq4g=
X-Google-Smtp-Source: ABdhPJwryQc/iLXAweUctj4SsSkdaY5g/qe1SuudBZpSqBmJt3NSaOwHw36CU8JkMghf7aCHHFBRWQ==
X-Received: by 2002:a05:6a00:1504:b0:47c:28f5:7b8f with SMTP id q4-20020a056a00150400b0047c28f57b8fmr896231pfu.45.1635379148077;
        Wed, 27 Oct 2021 16:59:08 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 09/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_FAST_CONNECTABLE
Date:   Wed, 27 Oct 2021 16:58:46 -0700
Message-Id: <20211027235900.1882863-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
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
index db2e5a2f4e03..098ce324f20f 100644
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

