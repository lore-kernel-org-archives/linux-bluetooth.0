Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B130C76195
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 20:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjCXUpc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjCXUpb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 16:45:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A279B13DC1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 13:45:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u20so2035898pfk.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679690729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDScRyIfsTebtpYTTraE3O7YzpARmjAA3agUIqqoS5w=;
        b=dF2aO/OgVNJE2+IiltfCsV+6GC8NGuQyCskJ5E1rLE693Lu3yHuGoAGd4goz1/C68k
         3CvuuyL85I4ENfMi9Dvypt9Hk6PDaFYxT88veM5FWHeMNVOEBVPLUpQ9tN/ZX9bXtI2y
         sSweh5eY344LP1WEO4Km5ftqbl+ArragRS5OdEqsdGqbtUqNI+zWvObV9DAR6Q5BCKz2
         G3gQxHJJUk0lYbJCdOyjebAP4PVMa6fstpL4mOyoyHPhBEQta+OvrzNzbyBWcudwh0AD
         aJobDeW7tGinYnIdPrUdgxqA89inFopSWU6nlaR4OM4PQHzpcsLBzhZ+TH/mSGURh2gd
         fezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDScRyIfsTebtpYTTraE3O7YzpARmjAA3agUIqqoS5w=;
        b=gZlgKLRg3Wcb8aDNdQt47fFrMNUoyM2FtDSAsuqvyqOp2/oA2vchvaNe4q7acdajfD
         Zas2fu0pIYahbZHumgLPxQJoA7ml/q3qJm1zhPOFcJqf97S3pEs8ofBsTXpOXdxjLI9l
         urwd1ouP4lxFpnjlk5vhE5Pnn3tlYfTuxTSHfC0yjL9Vio+Vo1LcKJFWL3OUh+rI0ODF
         o6MLDwpCmKRjZkCQE8+8G4hu3ZxtoZ9YGmTHqK4WdFwOf9z43S1L5KEcPvURgN5bZ/nr
         dHL8NbyC4azwby2+Uf5907kKlLpU8FnIf0Qr+b2P27DlrzIxqmNUFSsIHodqJBZu3xoH
         sp7Q==
X-Gm-Message-State: AAQBX9fs+tw1eudRkQrHv/64PSyC0sWTMGKTaxG+ofzkXpHHqZNOfPCQ
        k2gZ7/x+eKxzZbLCqPWpjETK2M5WNKw=
X-Google-Smtp-Source: AKy350bpWANjmuMYP+L6dG/Ed3/Rmsx9KyLuISur182sg0H2OQovXK3owyJwW6gdnl7Mn6UUl2h4tg==
X-Received: by 2002:a62:2581:0:b0:628:1b3:d499 with SMTP id l123-20020a622581000000b0062801b3d499mr3798716pfl.21.1679690729479;
        Fri, 24 Mar 2023 13:45:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7804d000000b0062b485b8e5esm1669916pfm.81.2023.03.24.13.45.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:45:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix printing errors if LE Connection times out
Date:   Fri, 24 Mar 2023 13:45:25 -0700
Message-Id: <20230324204525.3630188-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324204525.3630188-1-luiz.dentz@gmail.com>
References: <20230324204525.3630188-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes errors like bellow when LE Connection times out since that
is actually not a controller error:

 Bluetooth: hci0: Opcode 0x200d failed: -110
 Bluetooth: hci0: request failed to create LE connection: err -110

Instead the code shall properly detect if -ETIMEDOUT is returned and
send HCI_OP_LE_CREATE_CONN_CANCEL to give up on the connection.

Link: https://github.com/bluez/bluez/issues/340
Fixes: Fixes: 8e8b92ee60de ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  7 +++++--
 net/bluetooth/hci_event.c        | 16 ++++++----------
 net/bluetooth/hci_sync.c         | 13 ++++++++++---
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6ed9b4d546a7..d5311ceb21c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -954,6 +954,7 @@ enum {
 	HCI_CONN_STK_ENCRYPT,
 	HCI_CONN_AUTH_INITIATOR,
 	HCI_CONN_DROP,
+	HCI_CONN_CANCEL,
 	HCI_CONN_PARAM_REMOVAL_PEND,
 	HCI_CONN_NEW_LINK_KEY,
 	HCI_CONN_SCANNING,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0cd339ba7858..a51a6cfd5687 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1235,6 +1235,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
 
+	bt_dev_dbg(hdev, "err %d", err);
+
 	hci_dev_lock(hdev);
 
 	if (!err) {
@@ -1242,8 +1244,6 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 		goto done;
 	}
 
-	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
-
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
@@ -2773,6 +2773,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	int r = 0;
 
+	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+		return 0;
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad92a4be5851..e68f2a7d863a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2881,16 +2881,6 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 
 	conn->resp_addr_type = peer_addr_type;
 	bacpy(&conn->resp_addr, peer_addr);
-
-	/* We don't want the connection attempt to stick around
-	 * indefinitely since LE doesn't have a page timeout concept
-	 * like BR/EDR. Set a timer for any connection that doesn't use
-	 * the accept list for connecting.
-	 */
-	if (filter_policy == HCI_LE_USE_PEER_ADDR)
-		queue_delayed_work(conn->hdev->workqueue,
-				   &conn->le_conn_timeout,
-				   conn->conn_timeout);
 }
 
 static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
@@ -5902,6 +5892,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	if (status)
 		goto unlock;
 
+	/* Drop the connection if it has been aborted */
+	if (test_bit(HCI_CONN_CANCEL, &conn->flags)) {
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
 		addr_type = BDADDR_LE_PUBLIC;
 	else
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5a6aa1627791..632be1267288 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -246,8 +246,9 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
-				PTR_ERR(skb));
+		if (!event)
+			bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
+				   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
@@ -5126,8 +5127,11 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
 	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
 		return 0;
 
+	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN_CANCEL,
-				     6, &conn->dst, HCI_CMD_TIMEOUT);
+				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
 static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -6102,6 +6106,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 				       conn->conn_timeout, NULL);
 
 done:
+	if (err == -ETIMEDOUT)
+		hci_le_connect_cancel_sync(hdev, conn);
+
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
 	return err;
-- 
2.39.2

