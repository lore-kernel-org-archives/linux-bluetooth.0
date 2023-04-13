Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3583FC77B71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 18:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDMSbW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDMSbV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 14:31:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A02D53
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:31:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mq14-20020a17090b380e00b002472a2d9d6aso1517654pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681410679; x=1684002679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4LpGS3xTQ91HqJhw8dX7CP56gWuqqYeYtxhrFR0AQQ=;
        b=sE5kZ0P9h6Xzl2DN0GvoXu1Vr4AZXYUN9zyON/qoOV9C/7Ll9YhoUlV+VMzajlHcwY
         SJIBSZfAoEU6hcsCMVFTk+FIpJTYeMclhOtiw2t5wXeN9SNx9pV/ondDHatTaUnfW3ZV
         dXDtWkDwY1kGfpCfv3y/srDYgMy7iAtfRoWSQwddESyboYFEfLramI83LUd+AIvlLX8J
         XFMDGda+8rCRgERxXpcem0YxTDI+1pzaUueNaWuWTs8vTuRe5QSNiwuCkTM4q2JFqC+B
         YPVvlRkdMsNkfJ1yKxP3dAHvlAXG7HGqoOgkUmvT0Q0TDsjSsn1pyD9OVa7HavVGG8GU
         1WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410679; x=1684002679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4LpGS3xTQ91HqJhw8dX7CP56gWuqqYeYtxhrFR0AQQ=;
        b=B16d+frwUcVawj7t8JYw4KtQLOuhvzYMNcRdeE1NWt+SL1Yiza0BTONRuswiIwN0Ma
         eaj0vn/JGgeM1rAIlBBZ6E4sei7HEpxWF1KyHb2BMfHSPFY1UT5rE6QmE+Yy1oW4ZXR6
         MRKtBt7yIFPTLNSCkutDlGzKa9/8uz3xYLk6LXQscG/RHc7+KplwJZWssrTctY66klEw
         m6IC6lYAHMHahhtLqkdbcVEELWBqrpyMdeEIbU16Sepvo7eIHldSZBJ7gmcdiRVpo0A0
         Gzd9aEw1iHsw7CwyWrQsBDXeUOXgfUsd4nUjrOXSud+r9uhPSPznWNo31/qnPQpe2pN0
         dbdA==
X-Gm-Message-State: AAQBX9ePvt2L8ktu7wAbh+MO+7abZQHfitblERtC+JF1ChcGvsPbxiWR
        xHHgJ/55PaIDaV0yHeT9PJTrJ5tSaFQMFw==
X-Google-Smtp-Source: AKy350bhF4ynJ2Y31vDKS9bdAkqyjjFFwklweBH1KePhHxn8eNWXH9uDuzD5WROwQY9s56yZDp05xw==
X-Received: by 2002:a17:902:e88c:b0:1a5:2e19:bc40 with SMTP id w12-20020a170902e88c00b001a52e19bc40mr3832212plg.26.1681410678988;
        Thu, 13 Apr 2023 11:31:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902b68d00b001a19438336esm1790257pls.67.2023.04.13.11.31.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:31:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED
Date:   Thu, 13 Apr 2023 11:31:13 -0700
Message-Id: <20230413183113.896669-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413183113.896669-1-luiz.dentz@gmail.com>
References: <20230413183113.896669-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When submitting HCI_OP_LE_CREATE_CIS the code shall wait for
HCI_EVT_LE_CIS_ESTABLISHED thus enforcing the serialization of
HCI_OP_LE_CREATE_CIS as the Core spec does not allow to send them in
parallel:

  BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2566:

  If the Host issues this command before all the HCI_LE_CIS_Established
  events from the previous use of the command have been generated, the
  Controller shall return the error code Command Disallowed (0x0C).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_conn.c         | 58 +---------------------------
 net/bluetooth/hci_sync.c         | 65 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 17f5a4c32f36..f61b249787fc 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -122,6 +122,8 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason);
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
 
+int hci_le_create_cis_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9ecfc782be9..155c0fc98345 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1932,63 +1932,7 @@ bool hci_iso_setup_path(struct hci_conn *conn)
 
 static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 {
-	struct {
-		struct hci_cp_le_create_cis cp;
-		struct hci_cis cis[0x1f];
-	} cmd;
-	struct hci_conn *conn = data;
-	u8 cig;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.cis[0].acl_handle = cpu_to_le16(conn->parent->handle);
-	cmd.cis[0].cis_handle = cpu_to_le16(conn->handle);
-	cmd.cp.num_cis++;
-	cig = conn->iso_qos.ucast.cig;
-
-	hci_dev_lock(hdev);
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
-
-		if (conn == data || conn->type != ISO_LINK ||
-		    conn->state == BT_CONNECTED ||
-		    conn->iso_qos.ucast.cig != cig)
-			continue;
-
-		/* Check if all CIS(s) belonging to a CIG are ready */
-		if (!conn->parent || conn->parent->state != BT_CONNECTED ||
-		    conn->state != BT_CONNECT) {
-			cmd.cp.num_cis = 0;
-			break;
-		}
-
-		/* Group all CIS with state BT_CONNECT since the spec don't
-		 * allow to send them individually:
-		 *
-		 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-		 * page 2566:
-		 *
-		 * If the Host issues this command before all the
-		 * HCI_LE_CIS_Established events from the previous use of the
-		 * command have been generated, the Controller shall return the
-		 * error code Command Disallowed (0x0C).
-		 */
-		cis->acl_handle = cpu_to_le16(conn->parent->handle);
-		cis->cis_handle = cpu_to_le16(conn->handle);
-		cmd.cp.num_cis++;
-	}
-
-	rcu_read_unlock();
-
-	hci_dev_unlock(hdev);
-
-	if (!cmd.cp.num_cis)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_CIS, sizeof(cmd.cp) +
-			    sizeof(cmd.cis[0]) * cmd.cp.num_cis, &cmd);
+	return hci_le_create_cis_sync(hdev, data);
 }
 
 int hci_le_create_cis(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 00017f75cd41..6f060d00a70a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6137,6 +6137,71 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return err;
 }
 
+int hci_le_create_cis_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct {
+		struct hci_cp_le_create_cis cp;
+		struct hci_cis cis[0x1f];
+	} cmd;
+	u8 cig;
+	struct hci_conn *hcon = conn;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cis[0].acl_handle = cpu_to_le16(conn->parent->handle);
+	cmd.cis[0].cis_handle = cpu_to_le16(conn->handle);
+	cmd.cp.num_cis++;
+	cig = conn->iso_qos.ucast.cig;
+
+	hci_dev_lock(hdev);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
+
+		if (conn == hcon || conn->type != ISO_LINK ||
+		    conn->state == BT_CONNECTED ||
+		    conn->iso_qos.ucast.cig != cig)
+			continue;
+
+		/* Check if all CIS(s) belonging to a CIG are ready */
+		if (!conn->parent || conn->parent->state != BT_CONNECTED ||
+		    conn->state != BT_CONNECT) {
+			cmd.cp.num_cis = 0;
+			break;
+		}
+
+		/* Group all CIS with state BT_CONNECT since the spec don't
+		 * allow to send them individually:
+		 *
+		 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+		 * page 2566:
+		 *
+		 * If the Host issues this command before all the
+		 * HCI_LE_CIS_Established events from the previous use of the
+		 * command have been generated, the Controller shall return the
+		 * error code Command Disallowed (0x0C).
+		 */
+		cis->acl_handle = cpu_to_le16(conn->parent->handle);
+		cis->cis_handle = cpu_to_le16(conn->handle);
+		cmd.cp.num_cis++;
+	}
+
+	rcu_read_unlock();
+
+	hci_dev_unlock(hdev);
+
+	if (!cmd.cp.num_cis)
+		return 0;
+
+	/* Wait for HCI_LE_CIS_Established */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
+					sizeof(cmd.cp) + sizeof(cmd.cis[0]) *
+					cmd.cp.num_cis, &cmd,
+					HCI_EVT_LE_CIS_ESTABLISHED,
+					conn->conn_timeout, NULL);
+}
+
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
 {
 	struct hci_cp_le_remove_cig cp;
-- 
2.39.2

