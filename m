Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D9CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D584760F9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhJZXGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbhJZXGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB84C061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l186so1000485pge.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1In2pdNLoZDez5ulgJAz/3V/FLwCKscNxd7vBuk721s=;
        b=Xk125nRJRKvoeszvyn8PyGV1LCqfKBNeJcCBFNsjO398MQ4EWdDSIJ+Qh1ENOnDH8B
         526d4weomGgnvZkhkz0q8DTs40IQB0oILCmGZB5tb+Jw1Quk3lmvgZ2FTa0Eqjrxg1Xa
         To5A5PCFeOIHP/QQgrLTaUUqbxHhqxwOQ7gW3Lsv5gizI5lcyV7+vsyxL6Kerw40Fmz8
         B/unbYz2S4ayoDQ3KDh1dIxt0fVFvGJ9JV6PjAgERQv9Yeo5Ib4oQdokJYNlvilaQKLf
         4XqoSYUNfS7zoxIJmfxpEUsMHaACo3QDEVyKgB0iWjMGB5KltCpdiimnxjJ0emnkclV4
         H/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1In2pdNLoZDez5ulgJAz/3V/FLwCKscNxd7vBuk721s=;
        b=OpVSRd0rGZ9YvEdjWy+PIgysTCS5XHi+To+0t0VCGVkjJ18h9JdbaDMVlpZEqDbBEB
         FnbRyrtlG7aYPW/uZS8swJFa0ACeWnlgZ1budbdmI0MqFACLA9GLeOOGfGylXBWYEqpK
         p3snNxa0MypeiMGVfXcVAaBle93QW/s9PgNbzYceO82C83dbRCtTgD8+8StMMbemNLfR
         3R12lQ9CHoUGyK1CAIMNpwG/xZRZuaioGztYRKrz7WG9RBS9QRNF8Gfy8LRnow6J1IST
         PUd6gm6iFDcCZFbmuDY2+01tnSBnN3487A7HpyKHqwzEnfMG1dcfzco514xt/xqK0i0C
         6pHQ==
X-Gm-Message-State: AOAM532XOWYZoRNluxkdBFYDVFUCbxBwv4Uwsp4lzT20TPN4k6yOPDen
        g88HYQqaqVBdZPZa9M4AxmWDjAcNXUU=
X-Google-Smtp-Source: ABdhPJyCfo9YS0rOuPr/4mUV4LZxWhhuS92badIo2ZXJ1j9oWtddFLDXIqd+mBzNBsP1+KiqQhEAkw==
X-Received: by 2002:a63:8c12:: with SMTP id m18mr13541677pgd.187.1635289414949;
        Tue, 26 Oct 2021 16:03:34 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 12/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_SECURE_CONN
Date:   Tue, 26 Oct 2021 16:03:13 -0700
Message-Id: <20211026230324.1533907-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c             | 66 ++++++++++++++++----------------
 3 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 156cb5faf64f..4b27a89cc57e 100644
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
index 4e4bb1b4c71c..aa93813a4f6a 100644
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
index 39bf1a7dd0a5..fe2ee1baca26 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6094,23 +6094,18 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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
@@ -6130,13 +6125,23 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
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
@@ -6144,7 +6149,6 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 val;
 	int err;
 
@@ -6163,7 +6167,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
-				  MGMT_STATUS_INVALID_PARAMS);
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -6194,12 +6198,6 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
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
@@ -6208,18 +6206,18 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
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
+					 set_secure_conn_complete);
 
-	hci_req_init(&req, hdev);
-	hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT, 1, &val);
-	err = hci_req_run(&req, sc_enable_complete);
 	if (err < 0) {
-		mgmt_pending_remove(cmd);
-		goto failed;
+		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				MGMT_STATUS_FAILED);
+		if (cmd)
+			mgmt_pending_free(cmd);
 	}
 
 failed:
-- 
2.31.1

