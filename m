Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B659BC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 23:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGUXAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUXAi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 19:00:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C862237E7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:00:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g17so3169841plh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=px+a3zvYjDz83L14EV7/Ch9L28G8tIC4PazCTB7h/sA=;
        b=PdrjhqpYu4vmlG5rPaLS7+M4bltcfRuXTKYpQfCw74skenQRqhO9TFsyld+30VR4y7
         BVn3Y6ek6aHMdB+RCQS/KmIxFT2vZc8vfOpeqjUqQfoXa3/NAgA+k8jBqF6JjKUOCVtJ
         66xQ9d1lUNcmeJWvdu95EAqA9nM/B7JCyolfCB2ubm4e2cHTlgnVsUgkOiHoKwiYOone
         Ak6M3/r5PkSmXRFSOeYse6vz2AbdkneY/WNeApzPpkF0BsTd0HNrNszv7O5PsDgOhPhD
         uxOkicTzsn4AkhonL/c/Y7VpUoRu7B/TzGucD1VsosDKOVd6/m4VOEfLgKCcfHX4OKSe
         OX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=px+a3zvYjDz83L14EV7/Ch9L28G8tIC4PazCTB7h/sA=;
        b=sAmyDah4OWp9eu3Tdx0bOopOOrEZSAVA7ryqHjeV7qoCqviI00QJnVHMizgDcTJWKB
         MDJe4vu/pGLd1859UqHGS6UnZiY0XuKRrYWtZj/zjEnJ1I1Sj5bU7IRZImXaG6xczgKk
         xSqFCCX5IYgSJQr8E9F/EnMmbQ9k3QOYT0G+QIELBhQveK5aSx4SX43qWUFk7xrQB3Tq
         k2IfZ0IV2aSFuc7p7WKzlsce346rda43z0tcA9aJVFbF+p8ZFNtHoPmf0Wbz0hNITqQJ
         j7sa/6L+K9oj0/09gGTBV2XdqIpJ/v6C4leQQrXiYcMfkxS7RoU5Fvqp3HrtwYpGE4KB
         GaGw==
X-Gm-Message-State: AJIora8/4YT3Xkc8HH1A0llj2g4LgBVwsEHbC674aLc8qo8jJPt8u10X
        wdFVLacTQ4HjuuZ30KoFsj1761Ph12hTrg==
X-Google-Smtp-Source: AGRyM1vqNSwJGfssTDizIdTufrn/xKuImRJaRQO0WF1kYk00h+6uqGEFD6/wDZJ0NrkFI76UiO1P5Q==
X-Received: by 2002:a17:902:c401:b0:16d:1fdc:6114 with SMTP id k1-20020a170902c40100b0016d1fdc6114mr529921plk.23.1658444436320;
        Thu, 21 Jul 2022 16:00:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b0016cf714d024sm2201697pln.236.2022.07.21.16.00.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:00:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix helding hci_conn reference while command is queued
Date:   Thu, 21 Jul 2022 16:00:34 -0700
Message-Id: <20220721230034.416231-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c | 49 ++++++++++----------------------------------
 1 file changed, 11 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1eb36009fe7..9f02341a21b6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6718,11 +6718,6 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 	mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
 			  &rp, sizeof(rp));
 
-	if (conn) {
-		hci_conn_drop(conn);
-		hci_conn_put(conn);
-	}
-
 	mgmt_pending_free(cmd);
 }
 
@@ -6741,15 +6736,10 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
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
@@ -6831,8 +6821,6 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!cmd) {
 			err = -ENOMEM;
 		} else {
-			hci_conn_hold(conn);
-			cmd->user_data = hci_conn_get(conn);
 			err = hci_cmd_sync_queue(hdev, get_conn_info_sync,
 						 cmd, get_conn_info_complete);
 		}
@@ -6885,8 +6873,6 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 	if (conn) {
 		rp.piconet_clock = cpu_to_le32(conn->clock);
 		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
-		hci_conn_drop(conn);
-		hci_conn_put(conn);
 	}
 
 complete:
@@ -6901,30 +6887,21 @@ static int get_clock_info_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_get_clock_info *cp = cmd->param;
 	struct hci_cp_read_clock hci_cp;
-	struct hci_conn *conn = cmd->user_data;
+	struct hci_conn *conn;
 	int err;
 
 	memset(&hci_cp, 0, sizeof(hci_cp));
-	err = hci_read_clock_sync(hdev, &hci_cp);
 
-	if (conn) {
-		/* Make sure connection still exists */
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-					       &cp->addr.bdaddr);
+	/* Make sure connection still exists */
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
+	if (!conn && conn->state != BT_CONNECTED)
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
@@ -6983,10 +6960,6 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (cmd)
 			mgmt_pending_free(cmd);
-
-	} else if (conn) {
-		hci_conn_hold(conn);
-		cmd->user_data = hci_conn_get(conn);
 	}
 
 
-- 
2.36.1

