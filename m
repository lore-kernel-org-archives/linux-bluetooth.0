Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C60DEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjF1TV3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjF1TVV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 15:21:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09EB1FF1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:21:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so90958b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980078; x=1690572078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B400Y8XQpX5Kj5os/HOHkhu+4T29AiPMC5/AIc/v82I=;
        b=buZGVVpXhnepTzMre+fu0irC2ApFIpl2+PPr4I60pc74BCP74QHOyKft8dVWtTvRb1
         iIyJEYn08lH+gp058NWOTm9pkzhNgTfvX3MC/bBJVx4W24RLtjFwXxNCV1tbJhrDHN6n
         X9/Ez+46fVdmUsS12bOFeUPPfN/S2giSW6PYRNhBMl9nEK/x6XycusNnTkpHZBAoPjOT
         hD3lxajXsnTnmnB/w73s7mjmqfVsyIhvi+QfW+NIDSZot2rxtKJ5vJQcwz119sgFte4x
         VKSml+EnXegp1RyvulwLiFMNu2Exx/9ahVtyv36oISJEOp8P9w6t2S7GoJdcYuboyYD/
         c9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980078; x=1690572078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B400Y8XQpX5Kj5os/HOHkhu+4T29AiPMC5/AIc/v82I=;
        b=Vr2vOCiuL2riOHcVyp1MkdovQ825YgYJMfeNGFlxbmc2VJ7KFsV4JpR63iW1meSFxn
         /8FZSOCQxhUbBKLyn36GkL3pN1+KGkn8hmAS/rGvymNBZ0rDFxCIyN/zDR5D0SVO5IOi
         Q7y1g7J51hBIgjZ1aCcIhGiMt1TxNm+qrBAV595/aAsGF4DHP8Ha5KFF2woybnfyN+ch
         axI58RbLv/LGzn/K0MxLYIBE8CtGAP/TTVCYMbUg5MZN3gBbeYyGRw5ETiZ6DVvkwZsI
         WPkjQcBkUDucXP74kzJp0VJqDdpMvCmdNOYKDKz45rystz9ReeDwZl0AenIZIz/d4SQn
         QZng==
X-Gm-Message-State: AC+VfDzHq69yQBI9SiW1meN+/kVYsjgZnIjKBb+7i5VzrpwRsiRpFlPh
        Hsgs6orcGeLuVqRUFZ9iLnIitNXfVn0=
X-Google-Smtp-Source: ACHHUZ7m+TnY3xHb3Vbi3JFLu9VWHaDhrcpSrgPCO+krH/KQVSybSB4salHVmAzb0V7EbGjeiWYxtQ==
X-Received: by 2002:a17:902:bd86:b0:1b5:2fdf:5bd8 with SMTP id q6-20020a170902bd8600b001b52fdf5bd8mr14547163pls.8.1687980078193;
        Wed, 28 Jun 2023 12:21:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902b59300b001b04c2023e3sm7968004pls.218.2023.06.28.12.21.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:21:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync
Date:   Wed, 28 Jun 2023 12:21:13 -0700
Message-Id: <20230628192114.2773581-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628192114.2773581-1-luiz.dentz@gmail.com>
References: <20230628192114.2773581-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 34 ++++++++++++++++++++++++++++++++++
 net/bluetooth/iso.c      | 14 --------------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ef8297d04a8c..29bcfd576713 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5292,6 +5292,24 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
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
 
@@ -5318,11 +5336,27 @@ static int hci_reject_sco_sync(struct hci_dev *hdev, struct hci_conn *conn,
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

