Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC0C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C583222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+musFu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgAOVC2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41694 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgAOVC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so8762103pgk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3PfmQT411tQtswRiQsQBGfNIHO29hvNOYy4i+YrdxFs=;
        b=K+musFu+7i+99cIFyegTTbRgVirmxrnAkbbBeYupRqZ0Pb0Od29vIkiY++/SdO2Jf8
         WCCFxWdYBopl/iR82DhTgoKxBG2JYH8/Ni7usLDf+kadVCEzmPPC72JpXeYiT1QkESuQ
         ArYTh+d+4biVV5/3/xArukwci5y/Z+dI6OjifkuU4Zpmfrmw80F5l6nEUGQc3WeC5to7
         q5j+XBwRj+BT9v02fvAf2Vh3vGAsKbVetggqQhRUNHNZTq4C20nOVFdF1jONORmZ+3de
         0PrAJdIkAS/ksh+1ZYGZf66ajlyTnCX3WAdN5cCr9jCzzkFsYdmkwX+kwsiEDBrb+NY0
         8F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PfmQT411tQtswRiQsQBGfNIHO29hvNOYy4i+YrdxFs=;
        b=CS25hQ1fcM0uc43FXRub8antnN4op0K/0RmmvSlM6YOSgxPuFUoP1wl/QduWn9956R
         MeV/HKVWCP39ZpzGO40rPdrfO1pUs3/3b9e7OTx1ohjaUk6wT7DXK1mzHGU0nW0Cg/xX
         s/dTjYjNsaEfv8C6CR5MkwHpT/l3fmxXsxI2G+mV1pNmeEUXOgMKRhzuQ1VV2Rlau++u
         IVaJzjat0pVMBxYbx3XyX8Blwya8GgGg5Ebg/Ief3PQKGwMWbXRCN+yJsi06M/a2dmyq
         cMVz0thGIkXtLzpldXMs9Wkh2o5eeEzNDnmnurnRYOZ2nseRkhCil+HjpwoRxvOBFEFV
         v90g==
X-Gm-Message-State: APjAAAVTtRPeE1Jitlz1dgN/9bXUtvCxCI/LUF1CaZqOiM7Ym55HqHU6
        lZyaUqz4axN9QMDkotjPgZfGPHlCLKM=
X-Google-Smtp-Source: APXvYqx9KIIYaAI4R6POIEvvUsqhOVQLH7vZmKAXWssRzPagQULRPoA2cDSVt3G9vBtZ6GsNQJpEpw==
X-Received: by 2002:a62:197:: with SMTP id 145mr33544375pfb.188.1579122147391;
        Wed, 15 Jan 2020 13:02:27 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 03/11] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Wed, 15 Jan 2020 13:02:13 -0800
Message-Id: <20200115210221.13096-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/l2cap.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 093aedebdf0c..d85fb2c8e6eb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -119,6 +119,11 @@ struct l2cap_conninfo {
 #define L2CAP_LE_CONN_REQ	0x14
 #define L2CAP_LE_CONN_RSP	0x15
 #define L2CAP_LE_CREDITS	0x16
+#define L2CAP_EXT_FLOWCTL_CONN_REQ	0x17
+#define L2CAP_EXT_FLOWCTL_CONN_RSP	0x18
+#define L2CAP_EXT_FLOWCTL_RECONF_REQ	0x19
+#define L2CAP_EXT_FLOWCTL_RECONF_RSP	0x1a
+
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -360,6 +365,8 @@ struct l2cap_conf_rfc {
  */
 #define L2CAP_MODE_LE_FLOWCTL	0x80
 
+#define L2CAP_MODE_EXT_FLOWCTL	0x81
+
 struct l2cap_conf_efs {
 	__u8	id;
 	__u8	stype;
@@ -483,6 +490,39 @@ struct l2cap_le_credits {
 	__le16     credits;
 } __packed;
 
+#define L2CAP_EXT_FLOWCTL_MIN_MTU		64
+#define L2CAP_EXT_FLOWCTL_MIN_MPS		64
+
+struct l2cap_ext_flowctl_conn_req {
+	__le16 psm;
+	__le16 mtu;
+	__le16 mps;
+	__le16 credits;
+	__le16 scid[0];
+} __packed;
+
+struct l2cap_ext_flowctl_conn_rsp {
+	__le16 mtu;
+	__le16 mps;
+	__le16 credits;
+	__le16 result;
+	__le16 dcid[0];
+};
+
+struct l2cap_ext_flowctl_reconf_req {
+	__le16 mtu;
+	__le16 mps;
+	__le16 scid[0];
+} __packed;
+
+#define L2CAP_RECONF_SUCCESS		0x0000
+#define L2CAP_RECONF_INVALID_MTU	0x0001
+#define L2CAP_RECONF_INVALID_MPS	0x0002
+
+struct l2cap_ext_flowctl_reconf_rsp {
+	__le16 result;
+} __packed;
+
 /* ----- L2CAP channels and connections ----- */
 struct l2cap_seq_list {
 	__u16	head;
@@ -724,6 +764,7 @@ enum {
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
+	FLAG_EXT_FLOWCTL_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 };
-- 
2.21.0

