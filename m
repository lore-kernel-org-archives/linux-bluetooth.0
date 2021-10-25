Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52657C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFE160187
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhJYXnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhJYXng (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05392C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so189848pjb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jAA++EQewo3lTWLcQrngKRi5KWKS3wLqSYoZFhjrvb4=;
        b=UJDh5oPMqwgJVxdAmXkk3CvZJiyV5HK8yJGUPoMogE+joxKEopJ2vvDxjunv1ZnuTF
         s11DGYxVBVVGqDNBfcH7tYvjh1MxRspPR2NQZeUmpX8ATraz35it5MOU9zTeHt6AUESz
         bKX6bFuWJx9H9XdlP28L8GiHMoANYoYEPeoGBgGfXxe5uAKIMvo4Sv9WB7i7HKrMt+nB
         /EvHzLnxvlEnI8ihlOwSk3tsvqQAl9MEHvvTV0IJjNQEi9aKEUw8xt9mwGJbvz+pkZfL
         Et77HMgnU4jcQUNoIkDyhpXUiVxhnLoI0ITqRUfK587/DPVdml7dklvO4rpbwPBI6cNd
         n9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAA++EQewo3lTWLcQrngKRi5KWKS3wLqSYoZFhjrvb4=;
        b=aX7aDWfHHVRVgnX8z4FYGWmHnAse8Uy9E8bfOOrdC3NEhmEl91iJtl3Pvzl9KavyDK
         SzSFSVquERP8dSt/qb0x1s282GXxwBfqRSEQtKLOUb+7YjV5Vk9UyJSaahrZFCIXX5wd
         HbnUW/dmvG3d68cozbi2VHJUM8a/LHvLErvGDCSbOBgqhDFGH0EaXP6Slj4Vu3JdrVGu
         zkyP0xt8H5nupA5ySavV0/yL+PpZ2GXd6P7Ad86KqYErlJzJcMmHSLZu7sLtJ5oDw3hG
         0UahJyVXUXrhlkazIxO/x0s8+VI+xbQY3D/u6H0afzVIzyp634yqZ5Mz0QLMRNDytp/F
         oaAg==
X-Gm-Message-State: AOAM5305zOCdUIERxyhOLwOmjKgeok45rgBTS5U2xPqJuVI8y+CjupnR
        9Uu7hLHL8uFJ0HZu3+FF+7tbOQCCdGE=
X-Google-Smtp-Source: ABdhPJwsORaHeYDEstfHs+nRjuJJdJp3MJcBxUGGSSUCOQJN1nuWtALXGN7S4dLp/Q+93Bzj2pvnFg==
X-Received: by 2002:a17:90b:1c90:: with SMTP id oo16mr24174116pjb.199.1635205273313;
        Mon, 25 Oct 2021 16:41:13 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 13/23] Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO
Date:   Mon, 25 Oct 2021 16:40:52 -0700
Message-Id: <20211025234102.1140719-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c             | 125 +++++++++++++------------------
 3 files changed, 61 insertions(+), 71 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index ab97a001d460..0ed35acc0efc 100644
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
index aaf20601c227..5787ef1587e4 100644
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
index 1acdb5fd3bb5..3e6a599f44ae 100644
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
@@ -6705,82 +6698,76 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
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
-
-	hci_dev_lock(hdev);
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_get_clock_info *cp = cmd->param;
+	struct hci_cp_read_clock hci_cp;
+	struct hci_conn *conn = cmd->user_data;
+	int err;
 
-	hci_cp = hci_sent_cmd_data(hdev, HCI_OP_READ_CLOCK);
-	if (!hci_cp)
-		goto unlock;
+	memset(&hci_cp, 0, sizeof(hci_cp));
+	err = hci_read_clock_sync(hdev, &hci_cp);
 
-	if (hci_cp->which) {
-		u16 handle = __le16_to_cpu(hci_cp->handle);
-		conn = hci_conn_hash_lookup_handle(hdev, handle);
-	} else {
-		conn = NULL;
+	if (conn) {
+		/* Make sure connection still exists */
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+						&cp->addr.bdaddr);
+
+		if (conn && conn == cmd->user_data &&
+						conn->state == BT_CONNECTED) {
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
 
@@ -6818,31 +6805,27 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
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
+						get_clock_info_complete);
 
-	hci_req_init(&req, hdev);
+	if (err < 0) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_GET_CLOCK_INFO,
+				MGMT_STATUS_FAILED,
+				&rp, sizeof(rp));
 
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

