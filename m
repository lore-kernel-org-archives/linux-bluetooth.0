Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8BF610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhJZXGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhJZXGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0EC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e65so1016969pgc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rGkuzCqQqT/Km4eLqlH/j9nAU9HyGECMw8k+90eTpCw=;
        b=d9rXnvsbUDr800T/vV+7OuWj9/t8NoXi1LKtE4aWPwqE/Ln58NXn1Ik6DJkZA86eTs
         55Ftc7c1rXvYSkdokP83ga6+HM7vsFKs1QXQOqOz3ypEvt4lSHoPRAcX4fOvYO/FLg9b
         D4oJh+feJ9hPgrS0eBQ6BMQx9yjQdhBC6KuUlJu7wb8UWKi4lDXm7GtZ23tzVYRo+OEA
         qBBVJP1Ti4WM/3V1pLSSc30tsb2TxkW+35hnpFUlwbk2YX3O0JINdKTmgbzldS3Qd7vu
         hUOe0fFHZKocHIp94Dnt/M0+HhqahaxsNXvV+wNnjsnOkTW5iw/a0FRqjz5KOdSSop2y
         bg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGkuzCqQqT/Km4eLqlH/j9nAU9HyGECMw8k+90eTpCw=;
        b=olztnyDXsQXBoqcxs8h7GgVhYB3cxe7IaG71T1Qq/jE4844NL/VIt+Gw5Z3dANnQOY
         qcDlkcv+VzbkHOwLy93/Nqq+EgxzXl7kVJ2V6tQ2jaBrpkelNQaTzL5ZzsCvtqHoTqgz
         c9eOwVlIjGyT4W8xFI99oMmRlrJl1Z92KOpKPo0Gtsku3ZPeMAXkSxMejadHuRWiqZHT
         wG0+XR55pX4100fa8zAQXPbmn9HkJgEwkVuQ+UrC4YwNbmBsaYvqokrARHCLCroazTsx
         3VxVccYCTgy57m+bGzXQErN1t7IAwOwPmAt/saC1gi8WB0sFHymwOfe/lVshe90brJWo
         KoNQ==
X-Gm-Message-State: AOAM532eE0v31qVkcUaFmJBvr9cYqyt2VnGu1/1M8/CL9rhYS98bN9v8
        LQqem6WpLg47+pbbEIPvwAoS7qKVCUQ=
X-Google-Smtp-Source: ABdhPJwVs+AjkqYGa//f1dsAGvA8/qZHfy06PcI86acIac0IzDyb8vzR9LOOYjPge88uTIyF0Tr9rw==
X-Received: by 2002:a63:6e4d:: with SMTP id j74mr21410050pgc.257.1635289415738;
        Tue, 26 Oct 2021 16:03:35 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 13/23] Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO
Date:   Tue, 26 Oct 2021 16:03:14 -0700
Message-Id: <20211026230324.1533907-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Added synchronous HCI command:
	hci_read_clock_sync

to support MGMT opcode:
	MGMT_OP_GET_CLOCK_INFO

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_sync.c         |   6 ++
 net/bluetooth/mgmt.c             | 121 +++++++++++++------------------
 3 files changed, 58 insertions(+), 70 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 4b27a89cc57e..cf54f8f14edb 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -70,6 +70,7 @@ int hci_update_passive_scan(struct hci_dev *hdev);
 int hci_read_rssi_sync(struct hci_dev *hdev, __le16 handle);
 int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type);
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val);
+int hci_read_clock_sync(struct hci_dev *hdev, struct hci_cp_read_clock *cp);
 
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index aa93813a4f6a..dc23a8784367 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1318,6 +1318,12 @@ int hci_read_rssi_sync(struct hci_dev *hdev, __le16 handle)
 					sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+int hci_read_clock_sync(struct hci_dev *hdev, struct hci_cp_read_clock *cp)
+{
+	return __hci_cmd_sync_status(hdev, HCI_OP_READ_CLOCK,
+					sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+}
+
 int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
 {
 	struct hci_cp_read_tx_power cp;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fe2ee1baca26..ac3e493c9e09 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -927,13 +927,6 @@ static struct mgmt_pending_cmd *pending_find(u16 opcode, struct hci_dev *hdev)
 	return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
 }
 
-static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
-						  struct hci_dev *hdev,
-						  const void *data)
-{
-	return mgmt_pending_find_data(HCI_CHANNEL_CONTROL, opcode, hdev, data);
-}
-
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -6702,82 +6695,76 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static int clock_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
+static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct hci_conn *conn = cmd->user_data;
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_get_clock_info *cp = cmd->param;
 	struct mgmt_rp_get_clock_info rp;
-	struct hci_dev *hdev;
-	int err;
+	struct hci_conn *conn = cmd->user_data;
+	u8 status = mgmt_status(err);
+
+	bt_dev_dbg(hdev, "err %d", err);
 
 	memset(&rp, 0, sizeof(rp));
-	memcpy(&rp.addr, cmd->param, sizeof(rp.addr));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
 
-	if (status)
+	if (err)
 		goto complete;
 
-	hdev = hci_dev_get(cmd->index);
-	if (hdev) {
-		rp.local_clock = cpu_to_le32(hdev->clock);
-		hci_dev_put(hdev);
-	}
+	rp.local_clock = cpu_to_le32(hdev->clock);
 
 	if (conn) {
 		rp.piconet_clock = cpu_to_le32(conn->clock);
 		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
-	}
-
-complete:
-	err = mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
-				sizeof(rp));
-
-	if (conn) {
 		hci_conn_drop(conn);
 		hci_conn_put(conn);
 	}
 
-	return err;
+complete:
+	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
+								sizeof(rp));
+
+	mgmt_pending_free(cmd);
 }
 
-static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static int get_clock_info_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_cp_read_clock *hci_cp;
-	struct mgmt_pending_cmd *cmd;
-	struct hci_conn *conn;
-
-	bt_dev_dbg(hdev, "status %u", status);
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_get_clock_info *cp = cmd->param;
+	struct hci_cp_read_clock hci_cp;
+	struct hci_conn *conn = cmd->user_data;
+	int err;
 
-	hci_dev_lock(hdev);
+	memset(&hci_cp, 0, sizeof(hci_cp));
+	err = hci_read_clock_sync(hdev, &hci_cp);
 
-	hci_cp = hci_sent_cmd_data(hdev, HCI_OP_READ_CLOCK);
-	if (!hci_cp)
-		goto unlock;
+	if (conn) {
+		/* Make sure connection still exists */
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
 
-	if (hci_cp->which) {
-		u16 handle = __le16_to_cpu(hci_cp->handle);
-		conn = hci_conn_hash_lookup_handle(hdev, handle);
-	} else {
-		conn = NULL;
+		if (conn && conn == cmd->user_data &&
+		    conn->state == BT_CONNECTED) {
+			hci_cp.handle = cpu_to_le16(conn->handle);
+			hci_cp.which = 0x01; /* Piconet clock */
+			err = hci_read_clock_sync(hdev, &hci_cp);
+		} else if (cmd->user_data) {
+			hci_conn_drop(cmd->user_data);
+			hci_conn_put(cmd->user_data);
+			cmd->user_data = NULL;
+		}
 	}
 
-	cmd = pending_find_data(MGMT_OP_GET_CLOCK_INFO, hdev, conn);
-	if (!cmd)
-		goto unlock;
-
-	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
-
-unlock:
-	hci_dev_unlock(hdev);
+	return err;
 }
 
 static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
-			 u16 len)
+								u16 len)
 {
 	struct mgmt_cp_get_clock_info *cp = data;
 	struct mgmt_rp_get_clock_info rp;
-	struct hci_cp_read_clock hci_cp;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	struct hci_conn *conn;
 	int err;
 
@@ -6815,31 +6802,25 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = NULL;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_GET_CLOCK_INFO, hdev, data, len);
-	if (!cmd) {
+	cmd = mgmt_pending_new(sk, MGMT_OP_GET_CLOCK_INFO, hdev, data, len);
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
-
-	cmd->cmd_complete = clock_info_cmd_complete;
+	else
+		err = hci_cmd_sync_queue(hdev, get_clock_info_sync, cmd,
+					 get_clock_info_complete);
 
-	hci_req_init(&req, hdev);
+	if (err < 0) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
+					MGMT_STATUS_FAILED, &rp, sizeof(rp));
 
-	memset(&hci_cp, 0, sizeof(hci_cp));
-	hci_req_add(&req, HCI_OP_READ_CLOCK, sizeof(hci_cp), &hci_cp);
+		if (cmd)
+			mgmt_pending_free(cmd);
 
-	if (conn) {
+	} else if (conn) {
 		hci_conn_hold(conn);
 		cmd->user_data = hci_conn_get(conn);
-
-		hci_cp.handle = cpu_to_le16(conn->handle);
-		hci_cp.which = 0x01; /* Piconet clock */
-		hci_req_add(&req, HCI_OP_READ_CLOCK, sizeof(hci_cp), &hci_cp);
 	}
 
-	err = hci_req_run(&req, get_clock_info_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.31.1

