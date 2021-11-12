Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 00:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0C761260
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhKLAvi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbhKLAvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 19:51:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99272C061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 16:48:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so5953853pja.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 16:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1ch7uxtAPvSRezMriYalbovzAfr1LSDKDNXRShCn67A=;
        b=Kn8tQNgOkD0zygeHQSiVnjWbfPNXZxDP41Kl8BjLB8f3qjxA4lkUJn+BivXz8q2hmT
         XaHORVyxYsRjz/1lVU07NAdHlE4ci/b/AFwAgnkJc7c4OhNDbKFIosh6TOES2Nslgd9u
         ISlZLAze/p/nckwfFVP+0bYfTZeCGR8wSDINP+LpJ3UgVmRTRJ3YDmJdRWr3GHM8EEy6
         9d4KB2GE/wNfhIcvUstXaxo0V4DEw3e32h4bxrg8hFN4rr0S3tDXBLFsxJdcESmAXqxs
         plaT6nGt24ziM50fU/aQg6RhCMEUpqWB/aoHaCbIY0ZyZCAZ5pzpHkvxc25/64mVhJ27
         L/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ch7uxtAPvSRezMriYalbovzAfr1LSDKDNXRShCn67A=;
        b=8AUVdwpwQ8GwUei/r7Q6P+944wY5f349PCXefh7QdN13pa8Mgghn1mi6NBwVsRUGZp
         CKii/tmEI8HiIIzZuTmJFTAKGjY8Z4V6dvZ60gqtnjt4UG6H8cMIUOLP2eh+F9Tf4Nai
         SbSl8TZhFS6LEytDi6prEWFB2pvi2odURPwBGJGFlbYvfSyaFX2TCoenmqAFDieuNDoC
         pTdem9jMA1KeKAqmCHSGb7kjEZ5ULIzZRRMRT40es8uUoBCjMFFjyvyxvenA25ylnYtA
         zPN6czgwDYsFN80vpT3PEnLxTY98PDaFIhqlQmKhsTAKrb120aOtLMvUl9PLEgRk7I++
         KCyA==
X-Gm-Message-State: AOAM5317eMD5JiHFy+s3uDTFTnlkgOI7nmn/ZlzSRl9D9idTm9EKCJ0s
        TPuGXRTDxxTj2li7PL/tzhh08tkUrQY=
X-Google-Smtp-Source: ABdhPJxdoWao/AG+0rFjoVxQVMtrYH/bnqLcioY7dddxHLzEGs/2dVeC3Fj/By7kJ0WmcTaRzbiWIQ==
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr31016855pjb.238.1636678126749;
        Thu, 11 Nov 2021 16:48:46 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 7sm3206442pgk.55.2021.11.11.16.48.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:48:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: hci_sync: Convert MGMT_OP_SET_CONNECTABLE to use cmd_sync
Date:   Thu, 11 Nov 2021 16:48:43 -0800
Message-Id: <20211112004844.176271-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112004844.176271-1-luiz.dentz@gmail.com>
References: <20211112004844.176271-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes MGMT_OP_SET_CONNEABLE use hci_cmd_sync_queue instead of
use a dedicated connetable_update work.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 --
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_request.c      | 43 --------------------------------
 net/bluetooth/hci_sync.c         | 31 +++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 36 +++++++++++++-------------
 5 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9a56957c5967..70f2e16de18b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -496,7 +496,6 @@ struct hci_dev {
 	struct work_struct	discov_update;
 	struct work_struct	bg_scan_update;
 	struct work_struct	scan_update;
-	struct work_struct	connectable_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
 
@@ -1831,7 +1830,6 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u16 max_interval, u16 latency, u16 timeout);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 bool mgmt_get_connectable(struct hci_dev *hdev);
-void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status);
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev);
 void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index d335c0ce8c5d..0336c1bc5d25 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -93,6 +93,8 @@ int hci_set_powered_sync(struct hci_dev *hdev, u8 val);
 int hci_update_discoverable_sync(struct hci_dev *hdev);
 int hci_update_discoverable(struct hci_dev *hdev);
 
+int hci_update_connectable_sync(struct hci_dev *hdev);
+
 int hci_start_discovery_sync(struct hci_dev *hdev);
 int hci_stop_discovery_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9f355d8c34f2..98bf425eaf1b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1987,47 +1987,6 @@ static void scan_update_work(struct work_struct *work)
 	hci_req_sync(hdev, update_scan, 0, HCI_CMD_TIMEOUT, NULL);
 }
 
-static int connectable_update(struct hci_request *req, unsigned long opt)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	hci_dev_lock(hdev);
-
-	__hci_req_update_scan(req);
-
-	/* If BR/EDR is not enabled and we disable advertising as a
-	 * by-product of disabling connectable, we need to update the
-	 * advertising flags.
-	 */
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		__hci_req_update_adv_data(req, hdev->cur_adv_instance);
-
-	/* Update the advertising parameters if necessary */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !list_empty(&hdev->adv_instances)) {
-		if (ext_adv_capable(hdev))
-			__hci_req_start_ext_adv(req, hdev->cur_adv_instance);
-		else
-			__hci_req_enable_advertising(req);
-	}
-
-	__hci_update_background_scan(req);
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static void connectable_update_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    connectable_update);
-	u8 status;
-
-	hci_req_sync(hdev, connectable_update, 0, HCI_CMD_TIMEOUT, &status);
-	mgmt_set_connectable_complete(hdev, status);
-}
-
 static u8 get_service_classes(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid;
@@ -2841,7 +2800,6 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_WORK(&hdev->discov_update, discov_update);
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
 	INIT_WORK(&hdev->scan_update, scan_update_work);
-	INIT_WORK(&hdev->connectable_update, connectable_update_work);
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
@@ -2856,7 +2814,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_work_sync(&hdev->scan_update);
-	cancel_work_sync(&hdev->connectable_update);
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 205823f21fff..517c5bb92004 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4517,6 +4517,37 @@ int hci_update_discoverable(struct hci_dev *hdev)
 	return 0;
 }
 
+int hci_update_connectable_sync(struct hci_dev *hdev)
+{
+	int err;
+
+	err = hci_update_scan_sync(hdev);
+	if (err)
+		return err;
+
+	/* If BR/EDR is not enabled and we disable advertising as a
+	 * by-product of disabling connectable, we need to update the
+	 * advertising flags.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		err = hci_update_adv_data_sync(hdev, hdev->cur_adv_instance);
+
+	/* Update the advertising parameters if necessary */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    !list_empty(&hdev->adv_instances)) {
+		if (ext_adv_capable(hdev))
+			err = hci_start_ext_adv_sync(hdev,
+						     hdev->cur_adv_instance);
+		else
+			err = hci_enable_advertising_sync(hdev);
+
+		if (err)
+			return err;
+	}
+
+	return hci_update_passive_scan_sync(hdev);
+}
+
 static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
 {
 	const u8 giac[3] = { 0x33, 0x8b, 0x9e };
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1cb5d9113863..fe52b7eefb56 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1537,31 +1537,26 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status)
+static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
+					  int err)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd = data;
 
-	bt_dev_dbg(hdev, "status 0x%02x", status);
+	bt_dev_dbg(hdev, "err %d", err);
 
 	hci_dev_lock(hdev);
 
-	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
-	if (!cmd)
-		goto unlock;
-
-	if (status) {
-		u8 mgmt_err = mgmt_status(status);
+	if (err) {
+		u8 mgmt_err = mgmt_status(err);
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
-		goto remove_cmd;
+		goto done;
 	}
 
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
 	new_settings(hdev, cmd->sk);
 
-remove_cmd:
-	mgmt_pending_remove(cmd);
-
-unlock:
+done:
+	mgmt_pending_free(cmd);
 	hci_dev_unlock(hdev);
 }
 
@@ -1594,6 +1589,13 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 	return 0;
 }
 
+static int set_connectable_sync(struct hci_dev *hdev, void *data)
+{
+	BT_DBG("%s", hdev->name);
+
+	return hci_update_connectable_sync(hdev);
+}
+
 static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
@@ -1626,7 +1628,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1643,8 +1645,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_dev_clear_flag(hdev, HCI_CONNECTABLE);
 	}
 
-	queue_work(hdev->req_workqueue, &hdev->connectable_update);
-	err = 0;
+	err = hci_cmd_sync_queue(hdev, set_connectable_sync, cmd,
+				 mgmt_set_connectable_complete);
 
 failed:
 	hci_dev_unlock(hdev);
-- 
2.33.1

