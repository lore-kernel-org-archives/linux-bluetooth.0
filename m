Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1367CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDB0610C8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJ0WUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJ0WUm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB6AC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l203so4081317pfd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OFTRF03EGUXqzLk/tnQ32C55EqHnSWsfmnSe6nFflRc=;
        b=o90u2Gxcam2s7p/iOp9JzPTG7sIjppYXudA7QtepjOoJnN7wZrCuIXtghgxFfheJCV
         //SUS3SVzlSAtOUGNqx67jPX/hewsb7rV6SMJZPM2xZjEuTCGI2qg9U5RGnvdSKhAusJ
         OFnVKjXKsqvdIvdnhYN+g0K0V+v0LcJfrhFdhGgBVEQJ8JT/VHhrME1bgBP2FpuVMtU9
         0B220RGzSFya4DFCiTWVjmna+KmJhOwQBQsvOlvIjDuwSdOWhCIcOcR1RZl04y8LvWsf
         PmPhTKYHSlqVXAH9htzuI+10zMbV5GeME82AWhpUbxG7Vu3l40mGe5zeUX3v/nD7AUvr
         6zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFTRF03EGUXqzLk/tnQ32C55EqHnSWsfmnSe6nFflRc=;
        b=ucXFedTIhPF5m2klopnbOfR6yn8QUmK7uR8NnBz6zDdy5K1nv1B7OXcdVh8GwLSLMd
         yAsA2/YEDM4SR4ywTmcqtQNVYNsyf/cACtmuPwErD4PL4sn0oZ5DE30zAj4RHn/5EikC
         VK2e9uU1FLc5QjozxrWN0Imv6PZ4UN8EPDv+2L98r6tav2y4PPiUrmzLlnpVdvY0Zi4d
         zMUEhFATD4Fia/OSDMk0Tg/jPPUEtAuiape/qWhNPaYpc8SMsGJ9aQJkOcrtjCnC1l9D
         UrmEJ5vJkgcvvu9L0WlqHbSARGdQmsABNOHVHNqAAJMhp5slnEFch//DLwt9URilTHx1
         k0CQ==
X-Gm-Message-State: AOAM530tVMPWyiwBtsn/di1UQ3ZJH5XG6aSbUcfANClPB7VGN1vmcK7c
        oGjsO2m6XCb3SVODcNRUE2G3rIrXeCE=
X-Google-Smtp-Source: ABdhPJyTrMTQS/oUnKsBYnQgY4eYEeZ28jSSBldMRhdy9P4Vfqx9KjiQL+iSRp+P/mNlcQYnG/cpcA==
X-Received: by 2002:a63:aa4d:: with SMTP id x13mr346981pgo.418.1635373095748;
        Wed, 27 Oct 2021 15:18:15 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 13/23] Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO
Date:   Wed, 27 Oct 2021 15:17:52 -0700
Message-Id: <20211027221802.1851851-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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
index dc27d6652188..37595b393ac1 100644
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
index b414ab812569..82e12eebcca7 100644
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
+			  sizeof(rp));
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

