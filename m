Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE32EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF0W7W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 18:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjF0W7U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 18:59:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF426B9
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 15:59:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8303cd32aso5661455ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687906759; x=1690498759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B400Y8XQpX5Kj5os/HOHkhu+4T29AiPMC5/AIc/v82I=;
        b=dBU1DdoQjwBiwnZxYJaUhb4WXjBR0KFRzsMLYdPJUeoxbhDp8GktUa5DWkR6X8na13
         7BeyRR41lCx8xbmNM9yjQ07Mvq2zeq5QZrdjxv9dNoxZ4Q7kO4QK+zfgx1h71K6bgXoZ
         a0a9CkGr7RUONpTzx9b15ElmfGNefxaEX/NmesMLAAe+qqI6Qjp3j20ZcV1PPmVS94Bs
         ux31yfalMUF5GXu/tqIQ+RYlYkBuCuuD2e6aGxwZpb5XyLwVDsaKHXAR87zjFv50HPk6
         Yk4AuOloDW7+A+/37qgjhpah2q67KLB2QYIg+M0Q7LmHPuREwlhtZ5mzO3d2zv9rZ5be
         h5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687906759; x=1690498759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B400Y8XQpX5Kj5os/HOHkhu+4T29AiPMC5/AIc/v82I=;
        b=DBwn1PnXi1RNl7ZI+4D87KsumJRGmYaVYA2L2437VazxTTUhqklgm4obx0Xz9l2u9I
         C2m1n9xXVjkuDMo5E82uSj1gCZ+hZ2VeaVsNOWv3TYhNzUOzPT8PU1NIOek9dcZ3nHWS
         SBti9yJebmL22STHdIPfWMiF/Pm6lmf/BgxldNQ9gXrsAf385FLSpPRfRxtS6HvgbgZN
         X1daKvScMNmdE0Pxz1DsozYhpmPJt//3WBYWtQkjniNliO5DL11+Ugqsnsz5Lop8J0Aa
         jj3lbEnsIPEZDfWNjXtX+TlONYD2FWn0YyLf3Ckli50kG4LmggL8cD4LGCdvpdNCj/1l
         3Hsw==
X-Gm-Message-State: AC+VfDxAqw86YRc4JXBhz33bOcq3nym8dHKAwxd7sT4T5PXe9c0CB2VD
        qgvwSWY69o8vfJxzNClALiBrx0eLIevdtQ==
X-Google-Smtp-Source: ACHHUZ4uMrQ3LsJzTpQtGoWLzgxiHU1TCn/j5RO7PltPoJtfP2jTs6RreVJ/FJm725vdyEkZyPDYgQ==
X-Received: by 2002:a17:903:244f:b0:1ac:a6b0:1c87 with SMTP id l15-20020a170903244f00b001aca6b01c87mr14569638pls.48.1687906758598;
        Tue, 27 Jun 2023 15:59:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001b1a2bf5277sm259290plb.39.2023.06.27.15.59.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:59:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync
Date:   Tue, 27 Jun 2023 15:59:15 -0700
Message-Id: <20230627225915.2674812-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627225915.2674812-1-luiz.dentz@gmail.com>
References: <20230627225915.2674812-1-luiz.dentz@gmail.com>
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

