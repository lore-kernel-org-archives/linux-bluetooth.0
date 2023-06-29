Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A7EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 00:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjF2ANS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjF2ANR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 20:13:17 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58917172D
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 17:13:16 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-345d3ec6b4bso487685ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687997595; x=1690589595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMEinuH9L88jnA4c6I+yH6xWI/+ZvsUhNLs3Rf7k25k=;
        b=LSOj7xYY5aJGlTn1Xlo/G+HYwUvduGchOWLlN6/e7w62fGXMrXvUH4WKSQLNjfn2CY
         rc2ELtvEd8yYEBsrKmAdtOiyl/v9isGUhC15Om2gwEKf2N37l13cbciVUYqJdR3tBKty
         JRDB0vrAxu61YI0Z+cAPRlnoPmZK/jaq+ArJmbNV58ZEjhbgvxcKeRHWmwuGB2fPF+5/
         UBGZF00g7mb3iO+M6fO8aq4/46RzhJQcliACBftbLybviRyMw6LFRGDjcOSp7yzL3NA3
         7mYUMe/hoAd1XpEFBOkTzcJqvV1Xj5BfDa5n4pOdeU2Hr9cV14INqW1wXaTyeprDFpki
         pjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997595; x=1690589595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMEinuH9L88jnA4c6I+yH6xWI/+ZvsUhNLs3Rf7k25k=;
        b=Fsm2zXKgaXOV1cA5yOX7XK4PFjkS0//1DWMjj0jYwtmhmz55cIZRfTg44Lo9jF/sTW
         n3Nb3IGEtN6jF6j6wIXGmf+RxW1yneHaXDuW49HF5Vla0HbUiLvayNRMk0hVa8gAyVb8
         MzEirh4esswOmMsMKhqrvi8QB3u29WHnpXAymQ2cdRp5VTbMPC2RpXLFEgJYOXppVWCJ
         kVkK70gxho5N3cmRvEdh3GlI7armWtRIoLp1nW0R4fHQiTo4Bdd5X0P3/y9VD9ilN1K0
         K1+6fo4bufxoY3KDPbH57Oh88Tqi1Xp6laPf+Z+vHbLpeyMeeXdhavRWemuMEi3A2sMP
         avLA==
X-Gm-Message-State: AC+VfDywayhu8JPg3XKnFumigNAN6mM9A2zGlsRQIlOfY56hGKS4FsUO
        2niR36MUpFEt4KEV5DCJ0xIbgNTGsFM=
X-Google-Smtp-Source: ACHHUZ7hrf2AvjjyDUvgLJ2XtABzZ4+imbCQhU2v4c/xDr3JrpvMdumLQ+jUsB7uOLeLNGI9FYXjDg==
X-Received: by 2002:a92:c14b:0:b0:345:ba06:378 with SMTP id b11-20020a92c14b000000b00345ba060378mr6526899ilh.8.1687997594826;
        Wed, 28 Jun 2023 17:13:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id h7-20020a92d847000000b003459d60aaeasm3014291ilq.45.2023.06.28.17.13.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 17:13:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/3] Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync
Date:   Wed, 28 Jun 2023 17:13:09 -0700
Message-Id: <20230629001310.2946122-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629001310.2946122-1-luiz.dentz@gmail.com>
References: <20230629001310.2946122-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO_LINK connections where not being handled properly on
hci_abort_conn_sync which sometimes resulted in sending the wrong
commands, or in case of having the reject command being sent by the
socket code (iso.c) which is sort of a layer violation.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 23 +++++++++++++++++++----
 net/bluetooth/hci_sync.c | 34 ++++++++++++++++++++++++++++++++++
 net/bluetooth/iso.c      | 14 --------------
 3 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 88f18f375684..0b717989cd4f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1223,7 +1223,12 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct hci_conn *conn = data;
+	struct hci_conn *conn;
+	u16 handle = PTR_ERR(data);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		return;
 
 	bt_dev_dbg(hdev, "err %d", err);
 
@@ -1248,10 +1253,17 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn = data;
+	struct hci_conn *conn;
+	u16 handle = PTR_ERR(data);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		return 0;
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	conn->state = BT_CONNECT;
+
 	return hci_le_create_conn_sync(hdev, conn);
 }
 
@@ -1321,10 +1333,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 
-	conn->state = BT_CONNECT;
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 
-	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync, conn,
+	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync,
+				 ERR_PTR(conn->handle),
 				 create_le_conn_complete);
 	if (err) {
 		hci_conn_del(conn);
@@ -2858,6 +2870,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	/* If the connection is pending check the command opcode since that
 	 * might be blocking on hci_cmd_sync_work while waiting its respective
 	 * event so we need to hci_cmd_sync_cancel to cancel it.
+	 *
+	 * hci_connect_le serializes the connection attempts so only one
+	 * connection can be in BT_CONNECT at time.
 	 */
 	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
 		switch (hci_skb_event(hdev->sent_cmd)) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2e9140300712..f8c7b13ca4fc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5293,6 +5293,24 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	if (conn->type == LE_LINK)
 		return hci_le_connect_cancel_sync(hdev, conn, reason);
 
+	if (conn->type == ISO_LINK) {
+		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+		 * page 1857:
+		 *
+		 * If this command is issued for a CIS on the Central and the
+		 * CIS is successfully terminated before being established,
+		 * then an HCI_LE_CIS_Established event shall also be sent for
+		 * this CIS with the Status Operation Cancelled by Host (0x44).
+		 */
+		if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+			return hci_disconnect_sync(hdev, conn, reason);
+
+		/* There is no way to cancel a BIS without terminating the BIG
+		 * which is done later on connection cleanup.
+		 */
+		return 0;
+	}
+
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
 
@@ -5319,11 +5337,27 @@ static int hci_reject_sco_sync(struct hci_dev *hdev, struct hci_conn *conn,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int hci_le_reject_cis_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				  u8 reason)
+{
+	struct hci_cp_le_reject_cis cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(conn->handle);
+	cp.reason = reason;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_REJECT_CIS,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 				u8 reason)
 {
 	struct hci_cp_reject_conn_req cp;
 
+	if (conn->type == ISO_LINK)
+		return hci_le_reject_cis_sync(hdev, conn, reason);
+
 	if (conn->type == SCO_LINK || conn->type == ESCO_LINK)
 		return hci_reject_sco_sync(hdev, conn, reason);
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 84d238d0639a..9c41af55f2c7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -614,18 +614,6 @@ static void iso_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
-static void iso_conn_defer_reject(struct hci_conn *conn)
-{
-	struct hci_cp_le_reject_cis cp;
-
-	BT_DBG("conn %p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = cpu_to_le16(conn->handle);
-	cp.reason = HCI_ERROR_REJ_BAD_ADDR;
-	hci_send_cmd(conn->hdev, HCI_OP_LE_REJECT_CIS, sizeof(cp), &cp);
-}
-
 static void __iso_sock_close(struct sock *sk)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
@@ -650,8 +638,6 @@ static void __iso_sock_close(struct sock *sk)
 		break;
 
 	case BT_CONNECT2:
-		if (iso_pi(sk)->conn->hcon)
-			iso_conn_defer_reject(iso_pi(sk)->conn->hcon);
 		iso_chan_del(sk, ECONNRESET);
 		break;
 	case BT_CONNECT:
-- 
2.40.1

