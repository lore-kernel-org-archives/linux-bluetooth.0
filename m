Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC88C33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FED206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1hPg63O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgAGHlC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgAGHlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so28106957pgk.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D29XVIE1DJx7pijGI4f7PleLZq2uD3iA9N+IJVs1/cU=;
        b=L1hPg63ObFf+OXiso6wX2HmwzI+OZ0FKhWAqYMHm+TFv7UOeST/V9QKBAM2WI1df9a
         ATmwCrVNF54W6qwdzjJK4xyiK/X3FmVadZmRvOeEdLA3zM0VHx/xkV0zJwgsNM7SZ6XC
         Q3o7mFpG/XhP+cGHWXLIBspnU9S5myxfNQwU/Rn/j5FdXDCGGJVh+F0+khnl9Wy7jzxB
         4ZITC7kmXpf5TxcoxhURYalSWyu0J5Sh2kkQUafdPw1LhvGgyGATz9nt4iq9mkMBXvj3
         qeznUR34APpi5r/hWuoRPbAXdyhRJCcKAlcSx6JGiDYb2fLLDQa+F4s9Wujd8Nz3xI1T
         SjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D29XVIE1DJx7pijGI4f7PleLZq2uD3iA9N+IJVs1/cU=;
        b=Ymy+5BB0T2lCGiRfkCb2tqlb4a7VgxnDCk4SCXcI2t3eXpFa9bJaDevBV8Q53HFq8Z
         TLaq9xKwdcFiUC30/hHtGUMEnGbEXKXFtcuP1ffJJCwvilzAmCVtoAEEmqOsWvGy9sDA
         xJE++d8x0LGJei40pA1Zr7HGtNEL6NGX6+BzEN4TqkhhR1Xvb2+pKmifFeW+5cmZ7XBD
         kSdQFIy7nEylNlgNHb8+Y+LJ/xpKgqg6/I5Hs9Q01ibwoeTqiMFwgfjeNdJnT11vahDQ
         6bUlpI9893z0i9DEEh9ApCBrrwyM4M53G+N/ALn+88GpX7gMexodNlC7ANLn253jQF+F
         yqTg==
X-Gm-Message-State: APjAAAUdYhawSXjzuol0crKrPWyDFV2Yc2aCSwcSkKNRqzjPOAtIHGuF
        je0TGLRJZK65sHfoeRZER6tpYfZnV/8=
X-Google-Smtp-Source: APXvYqxx3jtKGvrHeN5Y1CF4UduV93cJkAZziTfvEsl2Nxfio3aq0tl8YclK1+eEOCpReI6jE1WkCw==
X-Received: by 2002:a65:678f:: with SMTP id e15mr114918716pgr.130.1578382861062;
        Mon, 06 Jan 2020 23:41:01 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Mon,  6 Jan 2020 23:40:49 -0800
Message-Id: <20200107074056.25453-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107074056.25453-1-luiz.dentz@gmail.com>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the definitions for the new L2CAP mode called Enhanced
Credit Based Mode.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 093aedebdf0c..5646a40c793c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -119,6 +119,11 @@ struct l2cap_conninfo {
 #define L2CAP_LE_CONN_REQ	0x14
 #define L2CAP_LE_CONN_RSP	0x15
 #define L2CAP_LE_CREDITS	0x16
+#define L2CAP_ECRED_CONN_REQ	0x17
+#define L2CAP_ECRED_CONN_RSP	0x18
+#define L2CAP_ECRED_RECONF_REQ	0x19
+#define L2CAP_ECRED_RECONF_RSP	0x1a
+
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -360,6 +365,11 @@ struct l2cap_conf_rfc {
  */
 #define L2CAP_MODE_LE_FLOWCTL	0x80
 
+/* This is essentially L2CAP_MODE_LE_FLOWCTL but works with BR/EDR */
+#define L2CAP_MODE_ECRED	0x81
+
+#define L2CAP_MODE_ECRED_MASK	0x80
+
 struct l2cap_conf_efs {
 	__u8	id;
 	__u8	stype;
@@ -483,6 +493,39 @@ struct l2cap_le_credits {
 	__le16     credits;
 } __packed;
 
+#define L2CAP_ECRED_MIN_MTU		64
+#define L2CAP_ECRED_MIN_MPS		64
+
+struct l2cap_ecred_conn_req {
+	__le16 psm;
+	__le16 mtu;
+	__le16 mps;
+	__le16 credits;
+	__le16 scid[0];
+} __packed;
+
+struct l2cap_ecred_conn_rsp {
+	__le16 mtu;
+	__le16 mps;
+	__le16 credits;
+	__le16 result;
+	__le16 dcid[0];
+};
+
+struct l2cap_ecred_reconf_req {
+	__le16 mtu;
+	__le16 mps;
+	__le16 scid[0];
+} __packed;
+
+#define L2CAP_RECONF_SUCCESS		0x0000
+#define L2CAP_RECONF_INVALID_MTU	0x0001
+#define L2CAP_RECONF_INVALID_MPS	0x0002
+
+struct l2cap_ecred_reconf_rsp {
+	__le16 result;
+} __packed;
+
 /* ----- L2CAP channels and connections ----- */
 struct l2cap_seq_list {
 	__u16	head;
@@ -724,6 +767,7 @@ enum {
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
+	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 };
@@ -923,6 +967,7 @@ void l2cap_cleanup_sockets(void);
 bool l2cap_is_socket(struct socket *sock);
 
 void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan);
+void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan);
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
-- 
2.21.0

