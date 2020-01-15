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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E872C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8329222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odqAV9eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOB7Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:59:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36827 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgAOB7Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 20:59:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so7632597pfb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 17:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3PfmQT411tQtswRiQsQBGfNIHO29hvNOYy4i+YrdxFs=;
        b=odqAV9eNlOQsIpEpMVO99L5DkRQJZfdJPjl4Hiz1ScUXB/4reKyhvijF37mEVZpSSZ
         6zD1r0vIOhVNlq9ttuboCB8KBJ1HIU1G+0E21g2rU0YvnxNYPD054ynykLBQj7TLW6DZ
         0W1mrdiNeHF0OI6fmTndU7BzvDH1SQ0olXFmAAEMHoC8Vhz0oTUNmrUbJaCfjdfglucb
         /aAygE4ARS+uZLglZne2f/BY9hHjFakov9ocANrA+8eM0zqG2B2/4e1wl5RyapsXxm3P
         5kte6ExZxSPUvijFPFTrm6U/S1y55gMqM3I9Lu/VnTXDYu2O+B8VmeRH8JzhmjetGr/z
         WTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PfmQT411tQtswRiQsQBGfNIHO29hvNOYy4i+YrdxFs=;
        b=PgrOKt4+quouIaXVmS43G8LEiwgrvSQCNKXdHlwlP+Hb3liI2ZNmrRpad/hMLWVtYK
         1FWc173RgLK04xO3L7QxSCnL+8r5lYRbLtIWbgolFy1MXMf1zWr95qPHeEgBqL1ls+jq
         6MU98C/mGiFltkJpwoYPejJop2E52N0CkRCwGP+0IBPQdo2TxZxva+uVSPds/r21o5Oq
         8SoTkTMOpyiTTwejkfm0uR55/YNhwpgeDzA/GFa/Rb6/GbVx5EuniT0DERS5CDpqYin1
         ge5+k4VwB+5YuFqyHpVVUbOBdZ10y3xANzNSOsSzc3xy+dDsQx7OL2LouGbPszhfmmYK
         cXJA==
X-Gm-Message-State: APjAAAWV3fgTC/TC6hrI+JYVFZQ4NGQNJojgPa0WWvR8eUDBjre7L1Zh
        KpRm1xEyUb86Nfrg62UZA3za1iEJeiI=
X-Google-Smtp-Source: APXvYqywpHtNya8f0k4nL6nl3Zuux+tjPLGn5JCFrW7HYAIuDiIz78+ZtnagfcwSp4M7ErtlwyyPlg==
X-Received: by 2002:a65:4381:: with SMTP id m1mr30991594pgp.68.1579053563432;
        Tue, 14 Jan 2020 17:59:23 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q10sm20263573pfn.5.2020.01.14.17.59.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:59:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/8] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Tue, 14 Jan 2020 17:59:13 -0800
Message-Id: <20200115015918.1187-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115015918.1187-1-luiz.dentz@gmail.com>
References: <20200115015918.1187-1-luiz.dentz@gmail.com>
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

