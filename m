Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62152C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F60060F9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhJZXGI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhJZXGF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E531C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so630205pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jy5V3j9rKv6dilRdQQnoozhHsc8LCB/Mawx5jZGGANY=;
        b=jdJIjPqz5ccnWCMeDu5h6w+xBeUkYKxomzu4VSinhQbEXVPJyGhKGOF2NO8oXz8bEP
         vwTHlrYFIJqqO0gCX+BtJio2JsHaCzM3d2dLra1gCuT3zcFctv42saKcukJuwbN7iZme
         qrmhYaDq3kul5xS9UfAWNR1M0S53poJR2eihNTw0bfeC5Zt0OgOIvT2hPoNDl6opZX+3
         Zw//jHeaL1ru044WNHGFLRRx89iMGN2YzRyiiYpWuqURlyn3BgVaXxx3ACrpP6spFBbK
         AwlmmNC9uf1kp2uVjx5jF0aHgxSYSdUSNgoF3O+EjqLlXTBXwBrrkhKk/edvgn5vbfwm
         xWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jy5V3j9rKv6dilRdQQnoozhHsc8LCB/Mawx5jZGGANY=;
        b=OgQOT3W7zmxf3xXaU0JIsNIcabDXcYTrj9XvYhNihpG+WTt89jcqov767qXRYoI8Om
         fRo34b/GGEb9yxyGFRJl/z0s+2Xo/yIjuHERDUdO0vRATO1+FKPmD8qJK/Hsx7KaOP55
         q7r+J/hJLrHN5hglmxQOPfzop1WJVI7lG2RyQBQlDKZqLBsh8bPuUfdeo0Ky7WLYIrhe
         PHmWPeyquBgjFXPG4rRaNdCHDFm8Xm7kahzQGkeNAB7bh0h+1gEAu5I9HkrGRMwhRkvD
         7kowl/mXeF3NO+gNMd6h/k7xCbD6FJz/2AwunT6Z0dFqFNgcaZr2YuUqGgz4mxmcpCq0
         7koQ==
X-Gm-Message-State: AOAM533VrNWYn0WJ4oDDQhnOJHjvcCaGI96mW1MwwEkdVJaskJtw8HYe
        f0xRUYe/HVEkJj+CQPIrzEN2ECv0WPw=
X-Google-Smtp-Source: ABdhPJy6tWWTunVcl5ue/wHhJ/jPqSuSNTT4tv6ZYIlIUWCDQAn3Hg8pQyiwFbpolf3FhTDXX8XGXA==
X-Received: by 2002:a17:902:8f90:b0:13e:a44e:2d3c with SMTP id z16-20020a1709028f9000b0013ea44e2d3cmr25196024plo.85.1635289420513;
        Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 19/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_ADVERTISING
Date:   Tue, 26 Oct 2021 16:03:20 -0700
Message-Id: <20211026230324.1533907-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
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
index 5b1aaf74b93b..22c6e4aab926 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5609,29 +5609,25 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -5663,30 +5659,55 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
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
@@ -5694,7 +5715,6 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 val, status;
 	int err;
 
@@ -5760,40 +5780,13 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
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

