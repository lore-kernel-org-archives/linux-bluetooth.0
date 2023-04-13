Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3379DC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 00:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDMAu4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Apr 2023 20:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDMAuz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Apr 2023 20:50:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D052717
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 17:50:54 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e22so2182479ioc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681347053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7i48K2CETyRnaSAGXa8gn5v2N+GGOASJXw/lEyz4N3U=;
        b=s5cSW84Is9xWoX0x1hAoD06+5QoHRc7W5KomguAVAQPyAQtMibsdMpIGMkqx5MiXIC
         2Hrlysc0bHg2DadLu46AmAwp/J3tbfKEDzLFdAyXR6JLDEoyH5NQ/7qrCVbMHfqZ99u5
         G+9ad9+CoX1/CL5UBBqNkGlO2GOqbfkc6jLtz+Z4hZ09BZy7IG+diknT6hUl9WvZJsnb
         cnAiwhU1A4BDLy+fjmmglSYoCZCPHVafw57L8o/AlQHQVdwZjg/BhFfXAPFJzP+6NNHe
         8CBq44xD1iR8tG9j4N/NTFcqPkM7jyFtKCmSYz4g1Khgms75EU2X7kQFwHV5YmXO2qMD
         Hm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681347053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7i48K2CETyRnaSAGXa8gn5v2N+GGOASJXw/lEyz4N3U=;
        b=Mlsxgi05Y4eREXWNO7/1+pUTI6cMVdqYXVzuTk+dzbM5unrZ4RTDNZasj1Z25GiGBW
         OKXOtnLoqwfGhasvB5TlUsMTLOoi4SKTV8CnfwM1PxI3M+HZ/PQmOCoAsu07CmGbpWWf
         wXeX2R5tu1wxJvsYiwpZXFaR6tHux6+t/7HwIQBEOytZRGTZGr2DRYH/YPilVsiPF8kp
         h9W8LbWziBp31pyC1zCo17Tg2iYUQ6zLwwJ2PC6/5NYskfjW/DEU8yf8JK6qccLvJqls
         Z4HdQqXtC254dDZ4ygMHndWz1SferEAzu9Bmiev1kiUmWFiAzaR8E2kqsz4gWRpOW+c8
         DBpQ==
X-Gm-Message-State: AAQBX9cDfHVoV9DCyoO+pMNlRnqoqW5KA69WsEWffZIw76pANKjwMAOM
        zNV+aHYY/I0Fs4WgP+X+9a608oz/Y7iBwQ==
X-Google-Smtp-Source: AKy350byv5xVK1PewbiPxgjp60AjlR6cuIv5K8lSAypTT4xFU0hfZCZS3g9N4OmHYxI2+nyciiRcqQ==
X-Received: by 2002:a5e:da06:0:b0:760:430:daf with SMTP id x6-20020a5eda06000000b0076004300dafmr91064ioj.1.1681347053073;
        Wed, 12 Apr 2023 17:50:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r14-20020a6bd90e000000b00758facb11fdsm141717ioc.17.2023.04.12.17.50.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:50:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED
Date:   Wed, 12 Apr 2023 17:50:46 -0700
Message-Id: <20230413005046.642682-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413005046.642682-1-luiz.dentz@gmail.com>
References: <20230413005046.642682-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c         | 68 +++-----------------------------
 net/bluetooth/hci_sync.c         | 65 ++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 62 deletions(-)

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
index 5524f08b91ae..155c0fc98345 100644
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
@@ -2012,15 +1956,15 @@ int hci_le_create_cis(struct hci_conn *conn)
 		 */
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			if (link->conn->state == BT_BOUND) {
+				err = hci_le_create_cis(link->conn);
+				if (err)
+					return err;
+
 				cis = link->conn;
-				break;
 			}
 		}
 
-		if (!cis)
-			return -EINVAL;
-
-		break;
+		return cis ? 0 : -EINVAL;
 	case ISO_LINK:
 		cis = conn;
 		break;
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

