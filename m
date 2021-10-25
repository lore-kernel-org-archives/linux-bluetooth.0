Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C1AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D61B60F46
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhJYXnq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbhJYXnl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA85C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so156703pjd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yMnDBew/H1HGz/+P1enThTFkfH0vFvkkKeMI2KIICXU=;
        b=DWBmjjLIEARqVOpIoSZZ1MoB18q7PCTLpS3spI2a3idRIv1bmb5GJ/Z8V/HNfbr/Vy
         FJIVEasDC/iuEK1dExkmtt4wu6sARYB1zNVRTjUDge68Ay81kavBnmNK+73XsRQrJUD3
         URVgDGefJe6b5617DrLL59ckwdEJD95/BCeHZ5xooEkzdj6La7ZbMCF7xtVEdiyKsqUM
         nskbwQ76vwix/crT22S4O5pqOTX15Qpivqi/BTGFfLPoqRmbmMrsdCcw4VlASd0v42Qo
         WArWINicoTrh2HQ7utSLmYbPWBaPfO1T5hdayIw6PHrskUOOXsdd/6U9Z3BI+C5BtQz2
         Uy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMnDBew/H1HGz/+P1enThTFkfH0vFvkkKeMI2KIICXU=;
        b=b5M/herOvzN2iswGrpspRXegMAZ9V/E7etNzH7JbVtru06y2PBNMMEeFch2i7ddsGC
         UNDn0iaoJVJqS5M+u3LfovALvLATrUyjWAcOEDscqIlZQsmgFhh61zWCUoO8iAowg8aJ
         KafwEoXmccHJ5qlwW2bZvZ6ltGUFramQ6nv7Nt9BslWtbD1hDkGvpmHaiS7rzW4Q8DCW
         G1MmxEFnLZagGPIN15zClYJ4bM3Oc/KnjnsIvOM2/s824pHhWNMsY20LFlgF30XhuW4V
         eeO//g4Ox2pQ3rnHmcm0/3ScIGYk5RaTCqjCilEXR1CZwZkL34xVDjaRgXkvrfK5yj3+
         1UAA==
X-Gm-Message-State: AOAM532olT02jXZncUvoYUadBiT1PEMjfwJmlW0ZIkDPUenDm5tkpIUx
        /C0g03Rh5KEbD2TUd/oMlw06xzx2Ohk=
X-Google-Smtp-Source: ABdhPJw9bzVTHC8QkAxXHJU88Vc6rxWN0fASzdYOOp8vefHeBLzb2bye0kI8PKFy9wQ6lzllhr6h8g==
X-Received: by 2002:a17:90b:3594:: with SMTP id mm20mr2232059pjb.86.1635205278080;
        Mon, 25 Oct 2021 16:41:18 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 19/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_ADVERTISING
Date:   Mon, 25 Oct 2021 16:40:58 -0700
Message-Id: <20211025234102.1140719-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
index b36c5af5bf46..23f98bdcd022 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5607,29 +5607,25 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -5661,30 +5657,55 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
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
@@ -5692,7 +5713,6 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 val, status;
 	int err;
 
@@ -5758,40 +5778,13 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
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
+						set_advertising_complete);
 
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

