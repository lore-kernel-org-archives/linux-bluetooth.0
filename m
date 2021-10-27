Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AE4610C7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJ0WUr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJ0WUp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED60C061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y7so4050829pfg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gpvkemKGAfZ9Colfv4NibaJOqEJ5UWaLHFQBnIS+5QE=;
        b=UzI7n0qZ6C3b/xEHtdYJSX+v8ut8qPvlQJEXY4hTFv07ATMIEe4kiF/wD2WlE7nf71
         +gk679hHU8nQha230wKbRnnWPgqOyAABA3J0bODaZH9N/xRX8YSu/3fz5qNrahQwvKGE
         NVK/1hIScV4MWN+Tpa8Ydy1QnJdDQEDgz308F5IB4jVPbCTQclzmc68LXMsK2/GO/Qyi
         9lhHI1yp+xZ0Dq1uKGHr2Z5wl+sMDgSP8YWZ03MsXFAAn/qHUMi6s57B8eieNTt39V+g
         04AKy5gRENg61duCm7JFR3fv7boFyotTHooV+YqaYtbazzk3XJAVv44Qle2WROxnaQmN
         zoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpvkemKGAfZ9Colfv4NibaJOqEJ5UWaLHFQBnIS+5QE=;
        b=OEehO8JkFYpVU3oSj5W8bQ4HkNq6a+c4p5ZGgcsmhIDLnBVdeO0Nvr2GDuKv3UFhWz
         CPZbSNdTfWrL0t018N6CTfl+iz01X4PymMFKIuQr3J7YFRfEG6JJpBKIazOY3Aozm+DB
         W7uScIL22wlSkh/ugvJFnaG7sk3p6JMW+Lj6WyFC00ih4dMyrMTmbc7NEjJKy72KirgV
         zCEfQ+5Bz9+pBWotznG6zmu4r5gIm7Oc0+QFSwF5ZLmukrAIE15vBccPjMkeW1Vx506f
         dWNt+6ae+YYKsWuBpJHczRYPd9X/QxxoCqxgftC1aoBLBofFnpL9KIRtArV33IbKD2vD
         t4/g==
X-Gm-Message-State: AOAM530ez65fWJV/I1pTBjNhmYBS3nTxI5nNy2ZhZSWaV2s7tETnvebh
        BkrdmoG1r/lt8iYMeZKi75hqd9Z8Rmg=
X-Google-Smtp-Source: ABdhPJxzs2Vu2B91jd/3cwZKXqQ2BISs5NKpdn+by3Lm3QYPfbaQA+vYb679UtIWBGrR5J9e7DMl/Q==
X-Received: by 2002:a63:c101:: with SMTP id w1mr336334pgf.53.1635373098730;
        Wed, 27 Oct 2021 15:18:18 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 17/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME
Date:   Wed, 27 Oct 2021 15:17:56 -0700
Message-Id: <20211027221802.1851851-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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
index 9893bd283139..f6f3235402bd 100644
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

