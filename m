Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4871C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A00460FE8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhJYXng (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhJYXne (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE4C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso676564pjm.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yUESZWoDsvXjvaoRR6W4u3e+JFJMpY0B6vxR/x1RkKU=;
        b=coxNz5hcrihJ42UDhFHSalhXqfCXh86YmJn3jyTeTZsiFEnlXdQWmAQCIVCuLcGyFd
         a0Av9eqHyTRcvWFA2d2gpg1EwWkImWdslejSomyQfQbgIoa5ua7TNhbax/GwBkExE47j
         kGMdBc3crSWNMAYhCyWAr7Yh6H23gobPkufrELWbtniMMUnF03VBPqEF2lhZ5Vq5iTYs
         OorAnnk272D3c/g5a00sozphKT5MSluEaEaHGw6Ur1OztdGRPb9c1jWkyMg8P6RRHSFY
         kFIpojm94YT1CuBAjw1yoCycyv88/3rufn6gbLUl0ACHbJuDM91tf68AZss5dqivtd6e
         Ho9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUESZWoDsvXjvaoRR6W4u3e+JFJMpY0B6vxR/x1RkKU=;
        b=nmyTRKkHnOmrUcMFHRiM/mh5lIyy0TSIHjCqW6hel39Tfd7xwVSnUOEyHZ5D0ySPx7
         bE7SOLmwZxI+lD9ND2aZYXYxhVXu21J8y344/pre2PL6XlKy33xwhFScai9n98GEQAGO
         rdaZTHJSpDmUlIleG2pPbmPdMQrU1+WFcATdpUO2tk5Jgu6v6TcqODQRmeBj/ZK5zUGT
         dOU8HU9X6jOebBLTbRFo42H6a/OEjuyOvDa78RdJ5PebxMEvASAJA/WxMeVJ0cYzJOKn
         fjlRsG3+u2wlf4ByfttrGKHoprAOS64THrsTCzZHQsugQFJ+vKHzKq0pHPp3llEi2w26
         e5kQ==
X-Gm-Message-State: AOAM533tjo/evTw64Br8QpXz1T8iHeqjBr3bx1vHhrAbvr92QvCLlr6+
        NNy7ByY5pcZecIergAQTsxRwueO6rnc=
X-Google-Smtp-Source: ABdhPJzZwlQORydSqIwyorD1Ec9PQnOlIU2h4YEWmVuSh7ejgzRA7CPxmNshzlkYwmdmVItsbq0pIw==
X-Received: by 2002:a17:90a:4fc5:: with SMTP id q63mr39492972pjh.148.1635205270773;
        Mon, 25 Oct 2021 16:41:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 10/23] Bluetooth: hci_sync: Enable synch'd set_bredr
Date:   Mon, 25 Oct 2021 16:40:49 -0700
Message-Id: <20211025234102.1140719-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c             | 74 ++++++++++++++++----------------
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 1a0fd4530575..7123122d14ba 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -69,6 +69,7 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
 
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
+int hci_update_scan_sync(struct hci_dev *hdev);
 
 int hci_dev_open_sync(struct hci_dev *dev);
 int hci_dev_close_sync(struct hci_dev *dev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 78397200e167..49e31863e077 100644
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
index e83592e120b9..73ae38cea799 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5955,20 +5955,14 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
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
@@ -5981,17 +5975,31 @@ static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
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
@@ -6058,20 +6066,24 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		    (bacmp(&hdev->static_addr, BDADDR_ANY) ||
 		     hci_dev_test_flag(hdev, HCI_SC_ENABLED))) {
 			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-					      MGMT_STATUS_REJECTED);
+						MGMT_STATUS_REJECTED);
 			goto unlock;
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
+							set_bredr_complete);
+
+	if (err < 0) {
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+							MGMT_STATUS_FAILED);
+		if (cmd)
+			mgmt_pending_free(cmd);
+
 		goto unlock;
 	}
 
@@ -6080,20 +6092,6 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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

