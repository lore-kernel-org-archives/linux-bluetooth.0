Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558EA610CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJ1ABp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhJ1ABm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290FC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so4267125pjh.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SnpMS++cCYXfwph5XGo9bbK6dqtEMa0JZnYAsH4roZw=;
        b=OTeBNEeORR1Zr5krTVqeTTdJjClrbuRd8kP+rM5b3hq+96KgT6GoQiPilT7BHUjLcx
         2AQ1l2k847M+ytvs/Km/rQtYR/pFGiPnO1Aj0npN5yOFCiOPdAJTYJKh52Zvgl/h3ONm
         HcbpEzbDhyx43zr8idYBNeQVwigoLlFIVvuDaSk+7n28uasO/XFWXrJSgAPgGpOphOh0
         SyuhiZUOkWFyfk8n5wp59nWKUWlXTjVnBqAkQU708eqt9zvQjpuEVsXh1rPAWBlyTArh
         b21/t12TlwpAmIvD+yA8wI47AKUwHJnPfFf9etpflBGnQw+3ySpGW9lmeHJdErR2f1jS
         ECNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnpMS++cCYXfwph5XGo9bbK6dqtEMa0JZnYAsH4roZw=;
        b=BxvWWIxWuQuy4ELcb/evPA/lUy5xsWu7bb1BM03NQodOmlQ7jbJNcjbt8HuyUKpO9C
         sYfpmk8hNhuE4tZaunKEqZw0Di8+/v59gPVW+BBK233vGlDhrCMmq9VkgkPVI2hV1ZTJ
         e3tcEK4crBTahdtgQfySzyv4deu9a57vHKwNYrHLgFu6XBCjxZn4lI9OsBQ7mRNLpWkA
         BoL2lanjTMSy7zLOp6nWoSCdjKEaGkOOKkQOuIQ38v1F7PfynK09JNrkWfDyxkAAcDd3
         gbVnY9/5peY/MpPrqYg/K0KXVp4oIUiiauAMck+Ivgxgrw2jMTNmB6DH7TIkMDSsG+PY
         YAqw==
X-Gm-Message-State: AOAM530j49siQ4GR908cR/VIsgEBOVHILfNODTdl+zZD4welVf8zm4Yq
        71YHNP5wkckvYa00PJcji+gXyvv7pxw=
X-Google-Smtp-Source: ABdhPJznh72X4C7neSx4yNdZVXyW5zIVPNBN7Y7aiYl8radfSZreJ8iQ2oOCRYpx375U529rg3TyqQ==
X-Received: by 2002:a17:902:da88:b0:141:636e:46fb with SMTP id j8-20020a170902da8800b00141636e46fbmr852737plx.26.1635379155987;
        Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 19/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_ADVERTISING
Date:   Wed, 27 Oct 2021 16:58:56 -0700
Message-Id: <20211027235900.1882863-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

mgmt-test paths:
Set powered on - Privacy and Advertising
Set Advertising on - Success 2
Set Advertising on - Appearance 1
Set Advertising on - Local name 1
Set Advertising on - Name + Appear 1
Add Advertising - Success 4
Add Advertising - Success 5
Add Ext Advertising - Success 4
Add Ext Advertising - Success 5

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt.c | 103 ++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 55 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8b3176e05b6..48a901c93141 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5608,29 +5608,25 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static void enable_advertising_instance(struct hci_dev *hdev, u8 status,
-					u16 opcode)
+static void enable_advertising_instance(struct hci_dev *hdev, int err)
 {
-	bt_dev_dbg(hdev, "status %u", status);
+	if (err)
+		bt_dev_err(hdev, "failed to re-configure advertising %d", err);
+	else
+		bt_dev_dbg(hdev, "status %d", err);
 }
 
-static void set_advertising_complete(struct hci_dev *hdev, u8 status,
-				     u16 opcode)
+static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	struct hci_request req;
 	u8 instance;
 	struct adv_info *adv_instance;
-	int err;
-
-	hci_dev_lock(hdev);
+	u8 status = mgmt_status(err);
 
 	if (status) {
-		u8 mgmt_err = mgmt_status(status);
-
 		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev,
-				     cmd_status_rsp, &mgmt_err);
-		goto unlock;
+				     cmd_status_rsp, &status);
+		return;
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
@@ -5662,30 +5658,55 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
 	    list_empty(&hdev->adv_instances))
-		goto unlock;
+		return;
 
 	instance = hdev->cur_adv_instance;
 	if (!instance) {
 		adv_instance = list_first_entry_or_null(&hdev->adv_instances,
 							struct adv_info, list);
 		if (!adv_instance)
-			goto unlock;
+			return;
 
 		instance = adv_instance->instance;
 	}
 
-	hci_req_init(&req, hdev);
+	err = hci_schedule_adv_instance_sync(hdev, instance, true);
+
+	enable_advertising_instance(hdev, err);
+}
 
-	err = __hci_req_schedule_adv_instance(&req, instance, true);
+static int set_adv_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_mode *cp = cmd->param;
+	u8 val = !!cp->val;
 
-	if (!err)
-		err = hci_req_run(&req, enable_advertising_instance);
+	if (cp->val == 0x02)
+		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
+	else
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 
-	if (err)
-		bt_dev_err(hdev, "failed to re-configure advertising");
+	cancel_adv_timeout(hdev);
 
-unlock:
-	hci_dev_unlock(hdev);
+	if (val) {
+		/* Switch to instance "0" for the Set Advertising setting.
+		 * We cannot use update_[adv|scan_rsp]_data() here as the
+		 * HCI_ADVERTISING flag is not yet set.
+		 */
+		hdev->cur_adv_instance = 0x00;
+
+		if (ext_adv_capable(hdev)) {
+			hci_start_ext_adv_sync(hdev, 0x00);
+		} else {
+			hci_update_adv_data_sync(hdev, 0x00);
+			hci_update_scan_rsp_data_sync(hdev, 0x00);
+			hci_enable_advertising_sync(hdev);
+		}
+	} else {
+		hci_disable_advertising_sync(hdev);
+	}
+
+	return 0;
 }
 
 static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -5693,7 +5714,6 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 val, status;
 	int err;
 
@@ -5759,40 +5779,13 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_ADVERTISING, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
-
-	hci_req_init(&req, hdev);
-
-	if (cp->val == 0x02)
-		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 	else
-		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
-
-	cancel_adv_timeout(hdev);
+		err = hci_cmd_sync_queue(hdev, set_adv_sync, cmd,
+					 set_advertising_complete);
 
-	if (val) {
-		/* Switch to instance "0" for the Set Advertising setting.
-		 * We cannot use update_[adv|scan_rsp]_data() here as the
-		 * HCI_ADVERTISING flag is not yet set.
-		 */
-		hdev->cur_adv_instance = 0x00;
-
-		if (ext_adv_capable(hdev)) {
-			__hci_req_start_ext_adv(&req, 0x00);
-		} else {
-			__hci_req_update_adv_data(&req, 0x00);
-			__hci_req_update_scan_rsp_data(&req, 0x00);
-			__hci_req_enable_advertising(&req);
-		}
-	} else {
-		__hci_req_disable_advertising(&req);
-	}
-
-	err = hci_req_run(&req, set_advertising_complete);
-	if (err < 0)
+	if (err < 0 && cmd)
 		mgmt_pending_remove(cmd);
 
 unlock:
-- 
2.31.1

