Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C837860EBD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhJ0WUm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJ0WUl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F13C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o133so4043003pfg.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1y+4JN7Q2bU3Q/7JRBaKNYNwLvcKOXRkWldOcveRYao=;
        b=bW0Q6gGn0aBayImjOrfXKCYiiGSlwFYsSyPF1KzZadD4klx8VEC0FLIz5xlwAzznHy
         rxImc27HpM7gDv+Th32bYU8har2cD8n4iXoECupAHPdshx4h2nPYUVAk4LY0DS7gT3oe
         UDj7Ca0QhRn+TKiO0cDRHPsHkIbgfIAatQbbfBUqup4D9zP2FyQAwAOPSLhUWii+evW0
         lv+oQaoVN7tMvWkGgXN8orxeObF9bW9z2Wqn1uCwDhgWrQ3hp2t0Lbq3OGWV99S2/EQV
         R3qsTcVJNvbEgJ6olZvrqglHRPwJAB+i/IaSXosFO2/DK1WbcTeMlTuIzQS1Qh7zYElZ
         tHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1y+4JN7Q2bU3Q/7JRBaKNYNwLvcKOXRkWldOcveRYao=;
        b=0W6c/dfSljolY5rl2pUUa0FgGdYcmHrkzCPzI56/Lzm4nVQcLMkOm7HicbktT8P2k6
         KaWYmhLUnY3lwbKpIqkS9bRR5mAq/Mtp10DaOkTHRLunoRh45krz8FUf2OKwiOyLRRAm
         iuvXKCQ75abnSs06b5kMzTRsOUhzUGfd/by3OiRjyIdgK+7Za/SJ5ZNJY6cPLye4z5R9
         6Na1hfE5Mf2VDwlTWyt+feUI279PpOx62mKXRKXpxmPmhR6yjhDuXT60JqNEMXc/P+hq
         mWloQCBCk2vwbMQw9gjS9Obh5V3pQeoK2bNEG4W9Z838l1x2PwePtjqKqDJPghUcVY4D
         3yTA==
X-Gm-Message-State: AOAM531rSTWlL8EnpfCkMh2kvUSAmRsWFTe+4YGmSzAkq4DUztPTKsBU
        T6Djq1P+EqjlqRCi7QbH1oR8yJACLzU=
X-Google-Smtp-Source: ABdhPJwdWMXPqibUmHhuKvvRux6wuWxng5+KcOEl8xv1oGeahJ0POiE/EI/YkjSVkIuNZfM0kXQC6g==
X-Received: by 2002:a63:618d:: with SMTP id v135mr345986pgb.79.1635373095004;
        Wed, 27 Oct 2021 15:18:15 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 12/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_SECURE_CONN
Date:   Wed, 27 Oct 2021 15:17:51 -0700
Message-Id: <20211027221802.1851851-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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
index ad819ff4e30d..dc27d6652188 100644
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
index 32c2820ff1a4..b414ab812569 100644
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

