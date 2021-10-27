Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDD3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34846109F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1ABn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhJ1ABl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F20C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l186so4561742pge.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lixJtLzQVOas8ii2kREL0Q042TP68x2vGdHZ7QFkuos=;
        b=Y+G8mxf5JBift+mYxc/SpuSzHlhKeRMd1UPAlv5RYBbzjaY0HYMMbbRAod/Jy3ZcK/
         Z7khyeNJGVycr0HXEXsjaQpqjhpaS/DrE21JhoTQIh5ueDUKL9gCLN2IvlWfX+MKkOrU
         zY4O+A5l5ZJZXeoqHU9kJI6JiBHlp6k0vtC3/CHNLU1i5AiTA3QS0QxmEu3ie67yvfvs
         3fdGt2tmGVh2t5DCMO4XMWPD3GloAuar/itDLnmted3/LztNPk72k0lTSHV2N7PGyiV2
         Qi4aksCo97pqVECkVYcH0IEsN3qWqICgubf1EJClGr3XPuEA2sNmRAHsQvX+PRxW8VUV
         oRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lixJtLzQVOas8ii2kREL0Q042TP68x2vGdHZ7QFkuos=;
        b=FleqFPkPm1Zg9qDMDrleYZo9KfGpb/u62ken3aCP+owK4u1SOf1R7XHk8FyTVk//UH
         Vtz1aziQntTY5EHXyinhqNqrvtQFiKvIWNDTTkyXXJLKiQd1HGU9ySgktL+vMTliTATD
         5+8bf9IjfkLzaeEjHpSWxbishtNSobRnlkaU/MRRIwxwWnZBNmd9Ef45qxbM5RPj0bRn
         3j1CZSaXZhA+y2l1Pto9zbX6cACWyLNVXLpr0slY/8wAQ6xLkJBv0J10O6lSy5Y/Olw7
         muHqoO3piWjJEdVkTlsu0OUHKu8+kyexb8Fu/391nRbDdiere0Cbr8dpsLMdpCkfnm/O
         FLqg==
X-Gm-Message-State: AOAM533vxLHJp+d2dF6uaSAiHa43VL+BjxR9T+eB6YT3/B7EH1rvtkLa
        nywqj8OJJ3x7LJyo7PU8GBYeH144aus=
X-Google-Smtp-Source: ABdhPJwrB9GL414m5lWVBjclWrDo19LqWx/YTPiqTSdJcgbR/fn8TtGOHup2UXkCpftVb2+jgv1Biw==
X-Received: by 2002:a63:d654:: with SMTP id d20mr693692pgj.122.1635379154520;
        Wed, 27 Oct 2021 16:59:14 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 17/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME
Date:   Wed, 27 Oct 2021 16:58:54 -0700
Message-Id: <20211027235900.1882863-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Uses existing *_sync functions, but made hci_update_name_sync
non-static.

mgmt-test paths:
Set Advertising on - Local name 1
Set Advertising on - Name + Appear 1
Set Local Name - Success 1
Set Local Name - Success 2
Set Local Name - Success 3
Add Advertising - Success (Empty ScRsp)
Add Advertising - Success (Complete name)
Add Advertising - Success (Shortened name)
Add Advertising - Success (Short name)
Add Advertising - Success (Name + data)
Add Advertising - Invalid Params (Name + data)
Add Advertising - Success (Name+data+appear)
Read Ext Controller Info 3
Read Ext Controller Info 4
Read Ext Controller Info 5
Add Ext Advertising - Success (Empty ScRsp)
Add Ext Advertising - Success (Complete name)
Add Ext Advertising - Success (Shortened name)
Add Ext Advertising - Success (Short name)
Add Ext Advertising - Success (Name + data)
Add Ext Advertising - Invalid Params (Name + data)
Add Ext Advertising - Success (Name+data+appear)

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/mgmt.c             | 65 ++++++++++++++++----------------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a381621a56a1..d9f2e3182ed8 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -46,6 +46,7 @@ int hci_update_class_sync(struct hci_dev *hdev);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
+int hci_update_name_sync(struct hci_dev *hdev);
 
 int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 				   bool rpa, u8 *own_addr_type);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a0a5c27d111c..47beabe48257 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2341,7 +2341,7 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	return hci_write_scan_enable_sync(hdev, scan);
 }
 
-static int hci_update_name_sync(struct hci_dev *hdev)
+int hci_update_name_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_local_name cp;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4ac63e402ef6..2585eab1fe21 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3246,24 +3246,17 @@ static void adv_expire(struct hci_dev *hdev, u32 flags)
 	hci_req_run(&req, NULL);
 }
 
-static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_cp_set_local_name *cp;
-	struct mgmt_pending_cmd *cmd;
-
-	bt_dev_dbg(hdev, "status 0x%02x", status);
-
-	hci_dev_lock(hdev);
-
-	cmd = pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
-	if (!cmd)
-		goto unlock;
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_local_name *cp = cmd->param;
+	u8 status = mgmt_status(err);
 
-	cp = cmd->param;
+	bt_dev_dbg(hdev, "err %d", err);
 
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-			        mgmt_status(status));
+				status);
 	} else {
 		mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
 				  cp, sizeof(*cp));
@@ -3273,9 +3266,22 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	}
 
 	mgmt_pending_remove(cmd);
+}
 
-unlock:
-	hci_dev_unlock(hdev);
+static int set_name_sync(struct hci_dev *hdev, void *data)
+{
+	if (lmp_bredr_capable(hdev)) {
+		hci_update_name_sync(hdev);
+		hci_update_eir_sync(hdev);
+	}
+
+	/* The name is stored in the scan response data and so
+	 * no need to update the advertising data here.
+	 */
+	if (lmp_le_capable(hdev) && hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		hci_update_scan_rsp_data_sync(hdev, hdev->cur_adv_instance);
+
+	return 0;
 }
 
 static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3283,7 +3289,6 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_local_name *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -3319,29 +3324,23 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto failed;
-	}
+	else
+		err = hci_cmd_sync_queue(hdev, set_name_sync, cmd,
+					 set_name_complete);
 
-	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+				      MGMT_STATUS_FAILED);
 
-	hci_req_init(&req, hdev);
+		if (cmd)
+			mgmt_pending_remove(cmd);
 
-	if (lmp_bredr_capable(hdev)) {
-		__hci_req_update_name(&req);
-		__hci_req_update_eir(&req);
+		goto failed;
 	}
 
-	/* The name is stored in the scan response data and so
-	 * no need to update the advertising data here.
-	 */
-	if (lmp_le_capable(hdev) && hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		__hci_req_update_scan_rsp_data(&req, hdev->cur_adv_instance);
-
-	err = hci_req_run(&req, set_name_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
+	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
 
 failed:
 	hci_dev_unlock(hdev);
-- 
2.31.1

