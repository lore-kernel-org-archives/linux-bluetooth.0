Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C98BC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 21:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F97B214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 21:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuGDoORD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBVcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:32:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46722 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBVcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 16:32:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id y30so429970pga.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yc9twyfo2ofnnZ2ALGcCp/mhrgMLu+tyCCMaRloUOOY=;
        b=TuGDoORDgdYpEUZkmoa6yL29eO0sz1Lj4DPT7WTpAA9Nx3rZdaA/GO0DVBFrZ1D0mW
         e8W/EL6eZwLWyU6g2iP55baan6ECAJSmbUTPOKj39QpfftyQ9Z1LPDzDllwLysxq1sbp
         pzeoR1zXTbAJ5dEFsylCgsKEh4mtilaZ79SbPjL86BGWilPQMc/gKdgAk3aQVGQBQGDo
         SDdcVI3w3UJGlY5ke1CU4e29iiAgcg/gIsbgFnMm+6xugN7Vj8lEsVTW4IG03ZLfpsDy
         Iv7qfCit6jhaov6UnGqkX7ykmSrqkBcvjGW3GY5XHPFCtyXigujsEQoSUvIrdTfnM9GT
         25JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yc9twyfo2ofnnZ2ALGcCp/mhrgMLu+tyCCMaRloUOOY=;
        b=S9rEgeRCqvtWpr+M4fYUAX80aGRc64ElcYlUqb5lmfrZS8hGIDhGxS/UKLeFZnyZjW
         rYlX5VmVBzt6qNxTeSZzgen2E425NgEO6gp5UVwFjWLbF5vR1duQ5Nb3DefnfKLhq5/f
         R8YYIVSXlhEhvsSvmGR0GJtwzY2HQZbmXJ/6+7RzZCyArat+p7nmDsdLDhaSj4v+YiNy
         9YuW10J02S8+LbmOIUD08C8KwjeI8i8FnSnnMlVpZWpRjELMtyO8rBNNZwC1A+Vr85gi
         MVMgVhyxmfY9k3Q6YxErXL0yrOGePbGyntSrq6XEtjeU5qzuXdzDL2VudQP4h3lm9ous
         rtTw==
X-Gm-Message-State: ANhLgQ1cu88nkZsNLMYIm3laT/ZP2mAjtq/abA0zittVN1bwLrH8TB0e
        DNGbxMvgE4karPJh6n7wxIFlzO0nCu0=
X-Google-Smtp-Source: ADFU+vs+tCi+BednGzslt1wC7A2BoVdFIFUvLyjJNUaOojFIgXRo0eZ8IguSOSL0zjhfpkI9Bn4mcQ==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr894213pge.134.1583184760374;
        Mon, 02 Mar 2020 13:32:40 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i22sm22183749pgi.69.2020.03.02.13.32.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:32:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Mon,  2 Mar 2020 13:32:34 -0800
Message-Id: <20200302213237.19540-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200302213237.19540-1-luiz.dentz@gmail.com>
References: <20200302213237.19540-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/l2cap.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 093aedebdf0c..3e6544e53516 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -119,6 +119,10 @@ struct l2cap_conninfo {
 #define L2CAP_LE_CONN_REQ	0x14
 #define L2CAP_LE_CONN_RSP	0x15
 #define L2CAP_LE_CREDITS	0x16
+#define L2CAP_ECRED_CONN_REQ	0x17
+#define L2CAP_ECRED_CONN_RSP	0x18
+#define L2CAP_ECRED_RECONF_REQ	0x19
+#define L2CAP_ECRED_RECONF_RSP	0x1a
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -359,6 +363,7 @@ struct l2cap_conf_rfc {
  * ever be used in the BR/EDR configuration phase.
  */
 #define L2CAP_MODE_LE_FLOWCTL	0x80
+#define L2CAP_MODE_EXT_FLOWCTL	0x81
 
 struct l2cap_conf_efs {
 	__u8	id;
@@ -483,6 +488,39 @@ struct l2cap_le_credits {
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
@@ -724,6 +762,7 @@ enum {
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
+	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 };
-- 
2.21.1

