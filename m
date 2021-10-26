Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC3BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF74610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhJZXGE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbhJZXGB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C85C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l186so1000566pge.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kv91lkGYm9YF3L1oa+/D8Cg6BYffr07v7PJvNCIFSZM=;
        b=RCiEGIFKxyNawvnJMObCR1C6BOQTmVIZ4781qSkHOQKT1xMcP5773EbQEK6UniKBwj
         WRggQlKyiyZfv9XbCuZn8UEpDMAHvXe/OT1SNr2laH9pxagvqXINtBsVsmcGSf9gjZeI
         Lr1apuPW60E4+Y+Ht5qUs1CwInJDY07DJ3S1os0W7/6XVRRfQD4nMXhDkQsXCY2RZjV4
         vaGbGGE8q/0TMx5HsHplavirMR4kcNX2yDgAlFys3M8f/a1z6BuJR4a6V1vDBVOB9JD7
         JlMiUOfa57UzobwFRBdg4KFPaD/2TfKXoF/P1bO5N9AejWPpwqj1uw6vNEZr6sHyeVbW
         Eerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kv91lkGYm9YF3L1oa+/D8Cg6BYffr07v7PJvNCIFSZM=;
        b=uwl2QUeoiyFqkcK9/hxjni9uawKYH3kOTPHPv70PQ7eC4HD9fuxTuXX0PL7Q6aMnQj
         TFHdNYbEl/WPPtST4AQPAoD2y43ymiMyB+XaADwO1p2S+pOCqx7ZvvkL7gffNBlNxPYf
         TOqGvv3qi6K/Sem2RDKXpZ89kwdv+Y8T2btXyYZhxW708akwm4k49MSpXM2P9S5CFQNM
         hFdGUfEDOk4eESemM1MsmcLOAcdZ1c4y1w2QGSd0GsdqZjWirPEa68V4AQkXFL79HZCQ
         GdvmcgUZsOuqnFydJs+ldKVSNEMeQKYeHLyrYNadt6WzbyGkBhKgc9qC+SrSWKr2IbpV
         K4aw==
X-Gm-Message-State: AOAM530zc7om+w3aUhPoBOIaQKkCn2dPby1nKCV/VI3EEUyiyknw00a0
        0Q9Gi8FdSagtUnq0MhKXUisbMibYYQw=
X-Google-Smtp-Source: ABdhPJy1NBl5RP49RxerG8zz2556+bDlAEvck7QN1PCUYeP7LS1hNmqnFi1ZrIhQrrwK3PRQeR2onw==
X-Received: by 2002:a63:70a:: with SMTP id 10mr7271069pgh.299.1635289416608;
        Tue, 26 Oct 2021 16:03:36 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 14/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_LE
Date:   Tue, 26 Oct 2021 16:03:15 -0700
Message-Id: <20211026230324.1533907-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Uses:
	hci_disable_advertising_sync
	hci_remove_ext_adv_instance_sync
	hci_write_le_host_supported_sync
	hci_setup_ext_adv_instance_sync
	hci_update_scan_rsp_data_sync

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  4 ++
 net/bluetooth/hci_sync.c         |  3 +-
 net/bluetooth/mgmt.c             | 86 ++++++++++++++++----------------
 3 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index cf54f8f14edb..d969693c33b5 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -75,6 +75,10 @@ int hci_read_clock_sync(struct hci_dev *hdev, struct hci_cp_read_clock *cp);
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
 
+int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul);
+int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
+				     struct sock *sk);
+
 int hci_dev_open_sync(struct hci_dev *hdev);
 int hci_dev_close_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dc23a8784367..acec95cb11b3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2149,8 +2149,7 @@ static int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode)
 	return hci_write_sc_support_sync(hdev, 0x01);
 }
 
-static int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le,
-					    u8 simul)
+int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul)
 {
 	struct hci_cp_write_le_host_supported cp;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac3e493c9e09..f2a8e115aafb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1902,18 +1902,17 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	return err;
 }
 
-static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static void set_le_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct cmd_lookup match = { NULL, hdev };
+	u8 status = mgmt_status(err);
 
-	hci_dev_lock(hdev);
+	bt_dev_dbg(hdev, "err %d", err);
 
 	if (status) {
-		u8 mgmt_err = mgmt_status(status);
-
 		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
-				     &mgmt_err);
-		goto unlock;
+							&status);
+		return;
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
@@ -1923,38 +1922,54 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	if (match.sk)
 		sock_put(match.sk);
 
+}
+
+static int set_le_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_mode *cp = cmd->param;
+	u8 val = !!cp->val;
+	int err;
+
+	if (!val) {
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+			hci_disable_advertising_sync(hdev);
+
+		if (ext_adv_capable(hdev))
+			hci_remove_ext_adv_instance_sync(hdev, 0, cmd->sk);
+	} else {
+		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
+	}
+
+	err = hci_write_le_host_supported_sync(hdev, val, 0);
+
 	/* Make sure the controller has a good default for
 	 * advertising data. Restrict the update to when LE
 	 * has actually been enabled. During power on, the
 	 * update in powered_update_hci will take care of it.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
-		struct hci_request req;
-		hci_req_init(&req, hdev);
+	if (!err && hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (ext_adv_capable(hdev)) {
-			int err;
+			int status;
 
-			err = __hci_req_setup_ext_adv_instance(&req, 0x00);
-			if (!err)
-				__hci_req_update_scan_rsp_data(&req, 0x00);
+			status = hci_setup_ext_adv_instance_sync(hdev, 0x00);
+			if (!status)
+				hci_update_scan_rsp_data_sync(hdev, 0x00);
 		} else {
-			__hci_req_update_adv_data(&req, 0x00);
-			__hci_req_update_scan_rsp_data(&req, 0x00);
+			hci_update_adv_data_sync(hdev, 0x00);
+			hci_update_scan_rsp_data_sync(hdev, 0x00);
 		}
-		hci_req_run(&req, NULL);
+
 		hci_update_passive_scan(hdev);
 	}
 
-unlock:
-	hci_dev_unlock(hdev);
+	return err;
 }
 
 static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct hci_cp_write_le_host_supported hci_cp;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 	u8 val, enabled;
 
@@ -2024,33 +2039,20 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LE, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
-
-	hci_req_init(&req, hdev);
-
-	memset(&hci_cp, 0, sizeof(hci_cp));
+	else
+		err = hci_cmd_sync_queue(hdev, set_le_sync, cmd,
+					 set_le_complete);
 
-	if (val) {
-		hci_cp.le = val;
-		hci_cp.simul = 0x00;
-	} else {
-		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			__hci_req_disable_advertising(&req);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				      MGMT_STATUS_FAILED);
 
-		if (ext_adv_capable(hdev))
-			__hci_req_clear_ext_adv_sets(&req);
+		if (cmd)
+			mgmt_pending_remove(cmd);
 	}
 
-	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
-		    &hci_cp);
-
-	err = hci_req_run(&req, le_enable_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
-
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.31.1

