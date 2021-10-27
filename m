Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6822C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E32610CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJ1ABh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhJ1ABh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47432C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id o133so4228412pfg.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q99yxSjire3ESCRPz2HpmptTvGC75OG2DPEhIVMRdwg=;
        b=NODmTurKpnBOVUgsrNOXLKFUM/Q2uOz2FY+uotUzbkER1IEWxv3ymnNZYUht3Fif2D
         c1XnEN69xM3mHafMCAW115ux8td3zHhyCpfJGqQHe5fY+YStX9eAH/v62+jslbCk1hN4
         UTd8XYo88+wiDfAI+Xijysv94CRGE9h+Z4a/oHEZunA/E1QJF4jjZoh8XxKk6FqY2tuo
         v3p5gV3OmhvPpZrCGlGgdDGwNi4XhqHFcVgJaIIXUWzy2QU7ELgzBGusV1RR4QMkAw18
         zLqDoZnWBgMdDOYIqfC5pEdPrdoSbDsLh0aanlkxcyTyhAopDBKAWobDEGcFfn+LWBBI
         04XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q99yxSjire3ESCRPz2HpmptTvGC75OG2DPEhIVMRdwg=;
        b=Jzj+AUHly4UJD/qjG6swUktKi73vLZ/BqtSFijMPb2k/+Lupa1/qSRO58FbtmXt/Tx
         /nhWpVHnr1/mEm0DapKUy1KnK/m2AXqM9yqBqwuw/NlYdlaLi4f9+lw6wNfE/qoXloYX
         ujLi4EQh0qOts8zuoUB3S9vRdhpd1nyFp8nh/V9VUqNOifuhpVcs1e7uYrJmOFb5ph+y
         TbRZzZ5DZh4AKrOtt6eCV+sTojVVjOF9AeTiqQlDC1LEEDWPie2vaKxVQBtvNDxT65ZA
         mXSOAaaCGdUQS75GrrrxBTdUTs1urAXXen5X8u3qvdkTLrn8s0vhdHTUT4QQejsTm681
         tozw==
X-Gm-Message-State: AOAM531/b6p/8JAyrowettKKh75Sn4Uxq6DAiHXNOoWY+L5dalm04NR8
        G1G3pgdR+PdFcek9m2bND7gDp7XQMZU=
X-Google-Smtp-Source: ABdhPJxVplb/5R74T5AjJETzIpIylubZWvkjOVGqP4nExQGGRYROH8R+nBuSltczjmjR4mpm58t5Zg==
X-Received: by 2002:a05:6a00:8c4:b0:44c:9827:16cc with SMTP id s4-20020a056a0008c400b0044c982716ccmr913385pfu.7.1635379150486;
        Wed, 27 Oct 2021 16:59:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 12/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_SECURE_CONN
Date:   Wed, 27 Oct 2021 16:58:49 -0700
Message-Id: <20211027235900.1882863-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Synchronous version of MGMT_OP_SET_SECURE_CONN.

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
index d809ab5e81e3..656e34617029 100644
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

