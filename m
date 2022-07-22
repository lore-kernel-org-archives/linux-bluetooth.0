Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B4C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 00:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiGVA0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiGVA0E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 20:26:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA687232
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 17:26:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso6802562pjp.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJNc1ptOUQntvWRKuqSnCEsdNI0TJwvIdxhe6AwEyRw=;
        b=SbuVJqL+h129ATCC5aXvrulTmuYmL6aYbc1RGf4cWGOzyuxAEBcre7gYKh8pvV+GIH
         Qtj6lIJN9G6I19A8zNR9SOeCc+RG7ryKCziQVBKqQbew4H8EoEhuLxGwmv47+sPbCab/
         zc2t3fFByJa2NXaxcFiv/1/u/mIQmeMEZnpEG5JHC41bvSVIvIsGhFz5wREvlrBkcgzd
         QT9Md/RWkm5KJ/nYQMkYEHuLaAvVypSMlji1oyA6FR9BGVlHRAyToRvEnWHWvlJL9rLw
         9IuOqCCPyun7Qg1T147sR0/C9uCc+O1U3W0wwBMNYzYBCJd+7Rwz913Qtyo+ZtKZnab5
         OCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJNc1ptOUQntvWRKuqSnCEsdNI0TJwvIdxhe6AwEyRw=;
        b=Or8hGg5sBU6u8u4Srpj7DMLDGxvhTmoLas53P0q3HLhophmJN2xbPrm0dhwlQ1qHq6
         3Opy/ECopHuMWR/qjvunLlll3sd6pPxKCZFaBo3h2NT+XcjxRcS7TLV9P5epQ/yQFCcK
         hEGI+SvdOUuQ/hV2UXf49o32s3gxUOoYgepi1K8hXngmCBt6oxi/1TQdgHjFWIePAYO+
         Km03YP9bWl8dQaSA2icfJp9adw9rzj9LUbj4ue6UDczumJYbyMHKRnz/6cPMOXF3QxB/
         +fHUrSU4e4EhF11PaRK3UqJlWdhrNW4J+wTht965tK7lixiUjzFItJmPJpBjbeOGigU2
         zkHw==
X-Gm-Message-State: AJIora8JT+Hvt7aUglBV3jx3dnZImg6wT8BgEFKGOGq2ekG/Gc/9PdVR
        c7PG/QqN2ee65mUEXD7bPuaeFAm0kSPMSg==
X-Google-Smtp-Source: AGRyM1uADGTQmG6Q61SlEjy/UAo/I81Zn31+FJSWxvG8+Itwx/UkOvZvWeNVywuQwwEwFX8hx/Xrcw==
X-Received: by 2002:a17:90b:3b4d:b0:1f0:4547:8a31 with SMTP id ot13-20020a17090b3b4d00b001f045478a31mr1075614pjb.129.1658449562232;
        Thu, 21 Jul 2022 17:26:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i128-20020a636d86000000b0041a4df3d3e2sm2070676pgc.68.2022.07.21.17.26.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:26:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Fix helding hci_conn reference while command is queued
Date:   Thu, 21 Jul 2022 17:26:00 -0700
Message-Id: <20220722002600.632792-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the use of hci_conn_hold from Get Conn Info and Get Clock
Info since the callback can just do a lookup by address using the cmd
data and only then set cmd->user_data to pass to the complete callback.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix CI findings

 net/bluetooth/mgmt.c | 51 +++++++++++---------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0c6878095709..aa651129b714 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6711,11 +6711,6 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 	mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
 			  &rp, sizeof(rp));
 
-	if (conn) {
-		hci_conn_drop(conn);
-		hci_conn_put(conn);
-	}
-
 	mgmt_pending_free(cmd);
 }
 
@@ -6734,15 +6729,10 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
-	if (!conn || conn != cmd->user_data || conn->state != BT_CONNECTED) {
-		if (cmd->user_data) {
-			hci_conn_drop(cmd->user_data);
-			hci_conn_put(cmd->user_data);
-			cmd->user_data = NULL;
-		}
+	if (!conn || conn->state != BT_CONNECTED)
 		return MGMT_STATUS_NOT_CONNECTED;
-	}
 
+	cmd->user_data = conn;
 	handle = cpu_to_le16(conn->handle);
 
 	/* Refresh RSSI each time */
@@ -6824,8 +6814,6 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!cmd) {
 			err = -ENOMEM;
 		} else {
-			hci_conn_hold(conn);
-			cmd->user_data = hci_conn_get(conn);
 			err = hci_cmd_sync_queue(hdev, get_conn_info_sync,
 						 cmd, get_conn_info_complete);
 		}
@@ -6878,8 +6866,6 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 	if (conn) {
 		rp.piconet_clock = cpu_to_le32(conn->clock);
 		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
-		hci_conn_drop(conn);
-		hci_conn_put(conn);
 	}
 
 complete:
@@ -6894,30 +6880,21 @@ static int get_clock_info_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_get_clock_info *cp = cmd->param;
 	struct hci_cp_read_clock hci_cp;
-	struct hci_conn *conn = cmd->user_data;
-	int err;
+	struct hci_conn *conn;
 
 	memset(&hci_cp, 0, sizeof(hci_cp));
-	err = hci_read_clock_sync(hdev, &hci_cp);
+	hci_read_clock_sync(hdev, &hci_cp);
 
-	if (conn) {
-		/* Make sure connection still exists */
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-					       &cp->addr.bdaddr);
+	/* Make sure connection still exists */
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
+	if (!conn || conn->state != BT_CONNECTED)
+		return MGMT_STATUS_NOT_CONNECTED;
 
-		if (conn && conn == cmd->user_data &&
-		    conn->state == BT_CONNECTED) {
-			hci_cp.handle = cpu_to_le16(conn->handle);
-			hci_cp.which = 0x01; /* Piconet clock */
-			err = hci_read_clock_sync(hdev, &hci_cp);
-		} else if (cmd->user_data) {
-			hci_conn_drop(cmd->user_data);
-			hci_conn_put(cmd->user_data);
-			cmd->user_data = NULL;
-		}
-	}
+	cmd->user_data = conn;
+	hci_cp.handle = cpu_to_le16(conn->handle);
+	hci_cp.which = 0x01; /* Piconet clock */
 
-	return err;
+	return hci_read_clock_sync(hdev, &hci_cp);
 }
 
 static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -6976,10 +6953,6 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (cmd)
 			mgmt_pending_free(cmd);
-
-	} else if (conn) {
-		hci_conn_hold(conn);
-		cmd->user_data = hci_conn_get(conn);
 	}
 
 
-- 
2.36.1

