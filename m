Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B3C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjC0UyF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjC0UyE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 16:54:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59542120
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 13:54:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id le6so9653290plb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvLwB+DIqU8UUGn+tdxSF2BCGhSnVGqiIfX+wxYvtVc=;
        b=ZdGQi1Aq4Yx1Ue1JWsXSVLdmQmACuqn/wlEzaUMg882CuH1xzXUFRb/SHQsXniBkyO
         i8iDPAB1oL9doIyJjYltrJWwfguYt1RoJnsZnPR7Uo5XucrjP+QEE9+rwjxuk0fGUYKi
         3zxNovQxK4Wh9KbdjILlzJBzVeQs4z6N6+SAktpQMUQ1E7Q7nXeOznFeYhKeoIj8+lKP
         x8Pr8lb2Dw+cP90wAOWzt8NQpqZb6fH/qIRDwtZFlWhj3J8RMCLmKKoNvBNlI41vsfvW
         16PAXCMGy9e6ffBM90LhtUm+AMCTW0fErLl6QI5PTeFsI6Y5GPd9jvQ65QTGCP98EZEn
         iqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvLwB+DIqU8UUGn+tdxSF2BCGhSnVGqiIfX+wxYvtVc=;
        b=uSxMCx//lwnL48vKhr0twZZFTpylaUDiuFGVGHoDroRBjSiQLRLEqCJUFEH641id4c
         u13UHHGqvfNPKpzDikU0cmE4ZRfpWSNG2L/Wuw4+xgzsoXKra2X+TyfQl9h0McvNz7D8
         8lxEo2/jnwd4ypoqdKyQ0trW4j3DL7JgZdua1moBSspb7j5KZBO7IJO82bc10RLmYx5/
         26CvHvETEeBmZaG08fZS1UJDeP4hHtlYsPbmDqK8eRKJCTEm99j6MSJscodAWRFtbsEe
         RoLYFXcTj2bTkd6jR85W3ApRVE9Tpc+bkllcKnufxNjKc8JCEW/hLIlWuCRq3jhHS7nb
         sfPA==
X-Gm-Message-State: AAQBX9cF7MZtrgWUt7MtOGjv5JGo9t8vy5PEOrnnud6lUU6ZynQ5r19/
        FFQFK623Hp1GeDD1ej2536d9urBqF4g=
X-Google-Smtp-Source: AKy350b60xewe04Fp1LcWu9RVOLNP0m9ARhnfzSh7Cy10+VC/BTQuzstuYFqVSVVxEPpkkzLcPw4nA==
X-Received: by 2002:a17:90b:4a8b:b0:237:99b9:c415 with SMTP id lp11-20020a17090b4a8b00b0023799b9c415mr13667882pjb.38.1679950442484;
        Mon, 27 Mar 2023 13:54:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id mu10-20020a17090b388a00b002369a14d6b1sm4781155pjb.31.2023.03.27.13.53.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:54:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix printing errors if LE Connection times out
Date:   Mon, 27 Mar 2023 13:53:47 -0700
Message-Id: <20230327205347.51568-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327205347.51568-1-luiz.dentz@gmail.com>
References: <20230327205347.51568-1-luiz.dentz@gmail.com>
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
index 53d3328c2b8b..e22e45fbe8db 100644
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
index 5af3f6b011c9..e4aee5950c36 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1233,6 +1233,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
 
+	bt_dev_dbg(hdev, "err %d", err);
+
 	hci_dev_lock(hdev);
 
 	if (!err) {
@@ -1240,8 +1242,6 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 		goto done;
 	}
 
-	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
-
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
@@ -2771,6 +2771,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	int r = 0;
 
+	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+		return 0;
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8d8547fa9032..ff99e8c2750f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2886,16 +2886,6 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 
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
@@ -5907,6 +5897,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
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
index 4376b6f06702..31231f0e4a28 100644
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
 
@@ -5128,8 +5129,11 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
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
@@ -6103,6 +6107,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
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

