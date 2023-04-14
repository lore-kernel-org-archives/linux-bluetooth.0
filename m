Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB13BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNU0R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDNU0P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:26:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BEB6A5A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:26:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso896034b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681503974; x=1684095974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clNKTYKeD6SM4Xa0m/+Ts3ywZT9zaqlmD0LqM3sxg7o=;
        b=M8Rc5Urd4uOwapmeeHRYVXhwc8pwOnb9zmqmIn7XEapuVAjqIsU3HteRXClsZ6hv/M
         dAm1w0nykY0O6Yuk1/p3iv/3T4SRaV4gb8Ni6TZI7baYEABGBfO/O5bvShRFvA+zXL7+
         3nl9jvhQfRiF94+Kh7HKe/+gYmgxIuvReAdqH8PGsuVtMhXhH6x6DcqzFU0wUgLA7sZR
         S/ti1jz3BZ8GgcfKuvqEVV3qT/ewVj9CEv9RXZYv+AQqcO3VhctzxRCIz/m1PhaISoNi
         FzMSj9Juc/5o+S3c60xPt4l/MFxo8QPfyioEFB4akz8wrODmOTmfHhl0vykaVDJUGSjS
         0/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681503974; x=1684095974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clNKTYKeD6SM4Xa0m/+Ts3ywZT9zaqlmD0LqM3sxg7o=;
        b=QjGixWFpcN8BeJch4M0zafDxQAKwTdowKC0Dm9xXktQjtny7/ed8gUcuiw+uqBPvUg
         moCMvexYe0DocsQHNdujX/HtrYwNaMMyqXCU0jrSmiJB2FYnkTWjq3jqhYT77CGeg8zO
         3tb3qgLtz1f8CPo6T10lRbAsgaXF6Xo8yQAeuuuVTjcFFwFRkXb4DEKf+4diG8ITCVrs
         voRTlqhK/QmB/NYMDjMNnjKc6N1E43Obh2RrWi64LfcrJq/umD00b/VtAft+gnG+kNOZ
         4b4cTetmAlmwOkq46XBp7u0D9cUbLE4mXaRocdH7sZzKvmAeQ0pxqZOC9RoR5dKw+nVK
         xB/w==
X-Gm-Message-State: AAQBX9dn6EY4YRFwCS+WDHwvrsbwEpm++MYuZjICWag/tDsbaDjO1P9H
        b3TAO0WG5RWo00AnN5r9Pa0UXTrI2Fg=
X-Google-Smtp-Source: AKy350b6wW0FkMbHXuit/LioFUXfud8ZpwAJ48sJGlL7louK3llBTsKUvV+3ypgW3UiaFoiMpMOcZg==
X-Received: by 2002:a05:6a00:4502:b0:63b:6373:786b with SMTP id cw2-20020a056a00450200b0063b6373786bmr5030503pfb.2.1681503973624;
        Fri, 14 Apr 2023 13:26:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78110000000b0062dedfd3d73sm3482453pfi.95.2023.04.14.13.26.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 13:26:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 3/3] Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED
Date:   Fri, 14 Apr 2023 13:26:08 -0700
Message-Id: <20230414202608.1152970-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414202608.1152970-1-luiz.dentz@gmail.com>
References: <20230414202608.1152970-1-luiz.dentz@gmail.com>
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
index c215e983e287..640b951bf40a 100644
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

