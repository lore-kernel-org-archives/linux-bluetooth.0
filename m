Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83708C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFCA60F70
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhJYXni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhJYXng (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51842C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id np13so9481374pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=x75cqSWalSKpGumFkeisybvIq+8kAFtpzAQDlMi+H94=;
        b=LxFWVVmHSvFZkUptZagAQxuY9WV8dseK5SAEemD1vpzFj+9SBr6Q3HQANoWSTlKkaT
         8Hr2ZEyFJ0fVxF39pQPPjBM8KVEdE88cuf60VHNoQjSpSzoqYn/H6RfjKA25Y2+1ZMsA
         +n4foMs9OG0XqIczKLO/vNhUnb23OZF4mZdDGCnKkIgt3FUlIEr+Yh7Xu8PYv6CNvnph
         V4vIXLOQpj14UzE9Cg5V1dpVi0HDRt7pAUuUcILuCQICEg0dzMZsRMtdKcNYi7P35B0l
         1ItulKLKhwa6C+NKwvzdKxClrkfDhC5YnZtwSJopWQTLFijWN51suLAV2YxLzEFG+UZI
         Hxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x75cqSWalSKpGumFkeisybvIq+8kAFtpzAQDlMi+H94=;
        b=Jr/vTs95oqESKL2tIg8O8KYMBJ/+fMCIzoem9m3UkUu4O7WQkj/rktv6/0XraRb0fI
         OGG5u0tYkJGvaZx7jtssPcxvUXm/xuEcg11jzcaZN0bhcjQSxnjTlejuDTXDa/SuZpfP
         14afx7j71a93u4MghGx7yjRcvHSljGlmIsrDNlCdfrRwcfTOV/ybXiFNLRct+XjXKL48
         Fx4RhMAxsCYsOs+GiaeT5RkgBF2llD4EP16Uz8m47lL9+Pxs+bxkHR7hDZU+4P4Ucy9K
         JsofTTuN8WkxzEIrqXmA53XbtcYpqSthurvRWBtp5ungnCdMvpiZv/Bdi7tppWm9c+Rt
         zbEw==
X-Gm-Message-State: AOAM531YhqlU0Df/P9iCaNV5YjgeQBzCejVpc3AVqg+f+aGcThYplekz
        MI3MwO8WpPEmMwhFRzpgRHTkgdEQdyE=
X-Google-Smtp-Source: ABdhPJzZ6pakeSH4mL/SwGemG/Z8fhwMtDzpUbDBYeIiJy69f9SvOkU/F5znJts8xzcWqUMgy1vdzQ==
X-Received: by 2002:a17:90a:6885:: with SMTP id a5mr9229666pjd.233.1635205272591;
        Mon, 25 Oct 2021 16:41:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 12/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_SECURE_CONN
Date:   Mon, 25 Oct 2021 16:40:51 -0700
Message-Id: <20211025234102.1140719-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

to support MGMT opcode:
	MGMT_OP_SET_SECURE_CONN

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         | 18 ++++++++-
 net/bluetooth/mgmt.c             | 64 ++++++++++++++++----------------
 3 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 729b4edc8284..ab97a001d460 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -69,6 +69,7 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
 int hci_read_rssi_sync(struct hci_dev *hdev, __le16 handle);
 int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type);
+int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val);
 
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index af0ef0d1d652..aaf20601c227 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2104,13 +2104,27 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	return hci_cmd_sync_queue(hdev, update_passive_scan_sync, NULL, NULL);
 }
 
-static int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
+int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
 {
+	int err;
+
 	if (!bredr_sc_enabled(hdev) || lmp_host_sc_capable(hdev))
 		return 0;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SC_SUPPORT,
+	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SC_SUPPORT,
 				    sizeof(val), &val, HCI_CMD_TIMEOUT);
+
+	if (!err) {
+		if (val) {
+			hdev->features[1][0] |= LMP_HOST_SC;
+			hci_dev_set_flag(hdev, HCI_SC_ENABLED);
+		} else {
+			hdev->features[1][0] &= ~LMP_HOST_SC;
+			hci_dev_clear_flag(hdev, HCI_SC_ENABLED);
+		}
+	}
+
+	return err;
 }
 
 static int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 623a0aed22cb..1acdb5fd3bb5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6096,23 +6096,18 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	return err;
 }
 
-static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static void set_secure_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_mode *cp;
 
-	bt_dev_dbg(hdev, "status %u", status);
-
-	hci_dev_lock(hdev);
+	bt_dev_dbg(hdev, "err %d", err);
 
-	cmd = pending_find(MGMT_OP_SET_SECURE_CONN, hdev);
-	if (!cmd)
-		goto unlock;
+	if (err) {
+		u8 mgmt_err = mgmt_status(err);
 
-	if (status) {
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
-			        mgmt_status(status));
-		goto remove;
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		goto done;
 	}
 
 	cp = cmd->param;
@@ -6132,13 +6127,23 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		break;
 	}
 
-	send_settings_rsp(cmd->sk, MGMT_OP_SET_SECURE_CONN, hdev);
+	send_settings_rsp(cmd->sk, cmd->opcode, hdev);
 	new_settings(hdev, cmd->sk);
 
-remove:
-	mgmt_pending_remove(cmd);
-unlock:
-	hci_dev_unlock(hdev);
+done:
+	mgmt_pending_free(cmd);
+}
+
+static int set_secure_conn_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_mode *cp = cmd->param;
+	u8 val = !!cp->val;
+
+	/* Force write of val */
+	hci_dev_set_flag(hdev, HCI_SC_ENABLED);
+
+	return hci_write_sc_support_sync(hdev, val);
 }
 
 static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
@@ -6146,7 +6151,6 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 val;
 	int err;
 
@@ -6196,12 +6200,6 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	if (pending_find(MGMT_OP_SET_SECURE_CONN, hdev)) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
-				      MGMT_STATUS_BUSY);
-		goto failed;
-	}
-
 	val = !!cp->val;
 
 	if (val == hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
@@ -6210,18 +6208,18 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_SECURE_CONN, hdev, data, len);
-	if (!cmd) {
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_SECURE_CONN, hdev, data, len);
+	if (!cmd)
 		err = -ENOMEM;
-		goto failed;
-	}
+	else
+		err = hci_cmd_sync_queue(hdev, set_secure_conn_sync, cmd,
+						set_secure_conn_complete);
 
-	hci_req_init(&req, hdev);
-	hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT, 1, &val);
-	err = hci_req_run(&req, sc_enable_complete);
 	if (err < 0) {
-		mgmt_pending_remove(cmd);
-		goto failed;
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+							MGMT_STATUS_FAILED);
+		if (cmd)
+			mgmt_pending_free(cmd);
 	}
 
 failed:
-- 
2.31.1

