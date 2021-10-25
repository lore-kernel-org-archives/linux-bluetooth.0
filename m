Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4DFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D60860F46
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhJYXno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhJYXnj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39380C061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v1-20020a17090a088100b001a21156830bso700285pjc.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=efSR18COQvffKXYIKFAcIOnWOztB9vwqJ3sBPPg5O9M=;
        b=e9EwCUc9VtbhGsJm0FjwnD0BTtxVa5fY/WJVFscl55Aj+puAMFdy8tun5eKfbTZK6R
         l1e7V3+hXFxp4oihGGAX57HPlLuemszMX+OCL/L6XdXyfQRt4MOT/jCq+ziNXn9QJuLy
         gk7mU1Y7umMKF15EuyFEOHwt2fG6lp9i4rSbuUpHhuBVmcSU22sGJ8zp0ASno6I2Wk53
         9zGqzFIolVTui0rwr23kuViIWccFVwpmd5UqdUYz03Kg7YMNvsFl9xu973l+LQZQUeSw
         boEQEG+StgSDHFlHs3UdR6ESy09LCDoIt+9B6MgCIRXBvY2imL9B7+Kw0jpOwje3uOMP
         /enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efSR18COQvffKXYIKFAcIOnWOztB9vwqJ3sBPPg5O9M=;
        b=lV/uwaggMZKyz+aRHKbt1r4g6FunOOeEKxCGmcwDR3wgJKi1PX6mTQE8/5pY75NlHS
         ko1OspjVc1qVcZvPdx8yqXIsZqjeWKRK5hk9MyfO8Me5SLo6kzQCCqokc8Rs+JAuyGVq
         d3sab6aLkJm53FNPOz7C9EdnxZwjMdNb1G+aFIP9WmCV8IJX1Wqj058jOBxHb7jhQJlM
         8BulLmWzyjLM/eRm/iSdLhNvmRejUyagIo2YAsEy/YijUJyE0e3v2wGu4zJG80leJifl
         bBJcMkrnObq7PV8fnKafRVMyJu6zE17tM4CTbojhhodQQe37JS1z+DEaWS0EJGeGhK4x
         zaTg==
X-Gm-Message-State: AOAM532JMN35zCYrp7QUyPHhNCCp24DVJmM25KBgV6qtKBoONdZQWmyS
        0VamZv8ODeIMbg9h+3eGoABEGXY91NU=
X-Google-Smtp-Source: ABdhPJzAvUHuxc2KCbALWwt/MA/uVRgQyJ5P5xxIhnll7PrlKZfk8STCB5QJYZvCxT7RnM1CclDgpQ==
X-Received: by 2002:a17:90a:2904:: with SMTP id g4mr18653717pjd.122.1635205276420;
        Mon, 25 Oct 2021 16:41:16 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 17/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME
Date:   Mon, 25 Oct 2021 16:40:56 -0700
Message-Id: <20211025234102.1140719-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c             | 69 ++++++++++++++++----------------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e191e63e44c7..df5b8f18a7ac 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -46,6 +46,7 @@ int hci_update_class_sync(struct hci_dev *hdev);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
+int hci_update_name_sync(struct hci_dev *hdev);
 
 int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 				   bool rpa, u8 *own_addr_type);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 515c68a499f8..afb7a015ee34 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2342,7 +2342,7 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	return hci_write_scan_enable_sync(hdev, scan);
 }
 
-static int hci_update_name_sync(struct hci_dev *hdev)
+int hci_update_name_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_local_name cp;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2cfcb526eded..0b668ef46e23 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3246,25 +3246,18 @@ static void adv_expire(struct hci_dev *hdev, u32 flags)
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
 
-	if (status) {
+	if (status)
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-			        mgmt_status(status));
-	} else {
+								status);
+	else {
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
+							set_name_complete);
 
-	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+							MGMT_STATUS_FAILED);
 
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

