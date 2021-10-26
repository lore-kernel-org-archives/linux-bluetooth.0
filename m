Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866E560F9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhJZXGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbhJZXGE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362B6C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3561962pjl.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F7cJHGAcgxJlTUlA/SN+6Ig6kX9KPutn7QRZg/oU0JA=;
        b=HJZsKmTK4kwJH56sz8+mzzDJdCOqUSTVvfUTzNpTuwQ6phXFaI1OaMaRuuzTg4jakv
         zvMRk3BQSPJkKCzfeCcXOSfaGJgipUfEUtKdCPTeTTMalsTc7Zf/a9a4nzEohcNlmXkP
         0FI7ro9AzHh5fXKeUKq2kl/vZaIUM5Rvbl5N7BrXVBegISBMEhUnRpeVAX+Glnj9O3QK
         H4d86SF18cjUDGPyGiio+WmO6NN2v7AhGCajVjk7G70isRkYK5qZWP/NMN1VCD2OyuKS
         8xrMEXg7QYlkRdHmVsinhcXoKKr3Pruzi9uMDEM8fwjWBxGJt6beeymEj+zF+kD8pz6c
         g/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7cJHGAcgxJlTUlA/SN+6Ig6kX9KPutn7QRZg/oU0JA=;
        b=Rc4+HW1PElrVMlOii1rWuP5ALFT28k6zXNYNtSukA9cx5qe7QZNg46GGhgZBQp0OWv
         gDK8A/qOAU5S1UIB2soJAWNgwvACvZCedO1M4iJTmRXAmIlDkRbZ9YhVfpWmZmoIiOyX
         VTsantMLiPhgwxILHiNLGIMN0w/CcWby8cj2FUPatmRiOKYdLVNI2yQ6IoUhwNz0Oz/S
         cGv+RGW2yHGaJBldQyTSIl6oSuGJz2dQJuESYUFXyLD9HQM2r9l8v5Lc3FuMc0x6flWe
         YLIq0usO9RllaTtrPj7f6Hb0rq9iN9pA+r0B6bNMw5K0mLZzBn4WSohu/3Op8xDG2axH
         iapw==
X-Gm-Message-State: AOAM530gEkUFXv15rwn4rxMt07zjbBIGdYZU5Y3a0+4erOcCs0ENJv4z
        WQ4uNIr1O5ODwVw+G5VX0lA2LYkkieA=
X-Google-Smtp-Source: ABdhPJyFwQCdGgdePabt3U7Y/XBP5+1rdEmHIUaFkBu0QjppLbuytHbYCnMDM9Ka3hs8xxmO0w78BQ==
X-Received: by 2002:a17:902:9887:b0:13f:7704:425f with SMTP id s7-20020a170902988700b0013f7704425fmr24943813plp.20.1635289419321;
        Tue, 26 Oct 2021 16:03:39 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 17/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME
Date:   Tue, 26 Oct 2021 16:03:18 -0700
Message-Id: <20211026230324.1533907-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
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
index 7e56294de790..a86cbe4a6315 100644
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
index 20cefd3e2295..dcdd3f4dab34 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3247,24 +3247,17 @@ static void adv_expire(struct hci_dev *hdev, u32 flags)
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
@@ -3274,9 +3267,22 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
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
@@ -3284,7 +3290,6 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_local_name *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -3320,29 +3325,23 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
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

