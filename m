Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4841610CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJ0WUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhJ0WUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8352C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v10so2567028pjr.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pvhUbTFHQb4PZ7p8EgFholuoM2JzAfBc6Wqwle1JV/o=;
        b=fNLjBHjL9v9n2l2g+yOPhhEUqCCCGVjBjQ1RuDpPY9wQPRfBNd9dJ6xa1AKk/UUQFx
         GTO0wgGCQFrPEJmdSuS5+nJc9NqRz2h+MSR5pBcWxoBCdTWQAFb3pQgrv32xtpjqaaC+
         F01AsjI6CMVSTvpFqK5Mr/bl7hh+qsF+r0ZgTCTWDkkKzAhmCeHyAeI9l/Iea9F3PD2m
         LWHgZFLNDajYwx/Vm28ysWbBE5JLzAN0Et0Jgbd806GPMYHIdd6Jaxu34hYWTjT9DTXE
         STfTxGiA2jfg6511yaAvm1Ui6rxGePvEyiRbAMUggr6ShEfecHAGnt59c6up7jrpJkPk
         P8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvhUbTFHQb4PZ7p8EgFholuoM2JzAfBc6Wqwle1JV/o=;
        b=5p+FX/GrYJQqBLe5GQx7hD7pHlNfhU/CZAHalHtgPpmNeCEHPtHnej9KILT0vhiyec
         Wg3adtGscQNnd1YChpTzeHbPYXlakEN5KHlKFm4G5TzuH+kj5QMvn+P35i3HvaRNlAke
         8YKmuv4uOTFyxcDFABzyPKWr3ZxGceqvy41GCB2b879P32Rn8xe1jxJkxaJVlx1FY31D
         93ainDT2ThY6Lb+uRSrpANwlkWymyND7e/EWC2h/hUeZ1nzD66eaJ+aKQzieP6GXm+HW
         ezv4lw67QaDUqrxoJRLTU434LRHA46eTURyLKaJQBDvgIay8XVFdtGnSLk2Hu24sfRPz
         7vQw==
X-Gm-Message-State: AOAM530qPmQUL14nt9knvWvWhiRbhsb7gdRxu7qSKeN87xzLbO3wmUt3
        /XMhu+sJsRQkSlijJTz7UXXVwJ/Snww=
X-Google-Smtp-Source: ABdhPJwNGizVqv3aXqv/9NttiACx8ZJW6P41q9rUIICxUf8850nO3oxabB7hGRyuB2waypMtssz2WA==
X-Received: by 2002:a17:90a:2904:: with SMTP id g4mr427498pjd.122.1635373093153;
        Wed, 27 Oct 2021 15:18:13 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 10/23] Bluetooth: hci_sync: Enable synch'd set_bredr
Date:   Wed, 27 Oct 2021 15:17:49 -0700
Message-Id: <20211027221802.1851851-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Uses previously written:
	hci_write_fast_connectable_sync
	hci_update_scan_sync
	hci_update_adv_data_sync

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/mgmt.c             | 72 ++++++++++++++++----------------
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 1fb66b6f8a34..03ffe95415fc 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -69,6 +69,7 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
 
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
+int hci_update_scan_sync(struct hci_dev *hdev);
 
 int hci_dev_open_sync(struct hci_dev *hdev);
 int hci_dev_close_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f7c30b4e9aca..39fdb51c9698 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2262,7 +2262,7 @@ static int hci_write_scan_enable_sync(struct hci_dev *hdev, u8 val)
 					    HCI_CMD_TIMEOUT);
 }
 
-static int hci_update_scan_sync(struct hci_dev *hdev)
+int hci_update_scan_sync(struct hci_dev *hdev)
 {
 	u8 scan;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 10e18ab9e61b..f49efa1a428e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5953,20 +5953,14 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static void set_bredr_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_pending_cmd *cmd;
-
-	bt_dev_dbg(hdev, "status 0x%02x", status);
-
-	hci_dev_lock(hdev);
+	struct mgmt_pending_cmd *cmd = data;
 
-	cmd = pending_find(MGMT_OP_SET_BREDR, hdev);
-	if (!cmd)
-		goto unlock;
+	bt_dev_dbg(hdev, "err %d", err);
 
-	if (status) {
-		u8 mgmt_err = mgmt_status(status);
+	if (err) {
+		u8 mgmt_err = mgmt_status(err);
 
 		/* We need to restore the flag if related HCI commands
 		 * failed.
@@ -5979,17 +5973,31 @@ static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		new_settings(hdev, cmd->sk);
 	}
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
+}
 
-unlock:
-	hci_dev_unlock(hdev);
+static int set_bredr_sync(struct hci_dev *hdev, void *data)
+{
+	int status;
+
+	status = hci_write_fast_connectable_sync(hdev, false);
+
+	if (!status)
+		status = hci_update_scan_sync(hdev);
+
+	/* Since only the advertising data flags will change, there
+	 * is no need to update the scan response data.
+	 */
+	if (!status)
+		status = hci_update_adv_data_sync(hdev, hdev->cur_adv_instance);
+
+	return status;
 }
 
 static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -6061,15 +6069,19 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		}
 	}
 
-	if (pending_find(MGMT_OP_SET_BREDR, hdev)) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-				      MGMT_STATUS_BUSY);
-		goto unlock;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_BREDR, hdev, data, len);
-	if (!cmd) {
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_BREDR, hdev, data, len);
+	if (!cmd)
 		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, set_bredr_sync, cmd,
+					 set_bredr_complete);
+
+	if (err < 0) {
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				MGMT_STATUS_FAILED);
+		if (cmd)
+			mgmt_pending_free(cmd);
+
 		goto unlock;
 	}
 
@@ -6078,20 +6090,6 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	 */
 	hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
-	hci_req_init(&req, hdev);
-
-	__hci_req_write_fast_connectable(&req, false);
-	__hci_req_update_scan(&req);
-
-	/* Since only the advertising data flags will change, there
-	 * is no need to update the scan response data.
-	 */
-	__hci_req_update_adv_data(&req, hdev->cur_adv_instance);
-
-	err = hci_req_run(&req, set_bredr_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
-
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.31.1

