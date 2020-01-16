Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC3C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BEF2075B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 21:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiV1/Bp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgAPV1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:27:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41251 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgAPV1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 16:27:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so10854157pfw.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C3eecGffM0NAB0Avs1pmgva0qvU9wrzoyA6xCHPC2g=;
        b=hiV1/Bp60EEyG92jSiM964m+aGUcFr0s+PTVBH3Ft+3keQof6LKb5qcV6bTI4IeCrh
         yMLpASwsD2/IYr247XG21CyfKDonDb97TvnQLYTeuCHmccfG3CRd1LXwvy+RJcal+sNT
         +/W2I0VJkc47KSHsVQKM1+ROec3BiM3g2XojT0mx/IUFpTE0AbiIQ2auezXlwGxQd3+H
         cmDAfijeJQTwcHOX2lH8cGzcywthf+wHWquTszd07+tweOLylzrqQBC60LpKhhWanANd
         7f9GWSRUC3dgqwZEjGlrgrsdfGI8MOzljm5e7cWw/D5UK2NPllGKEKgdk+Cf9TVhQ7Tr
         zYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C3eecGffM0NAB0Avs1pmgva0qvU9wrzoyA6xCHPC2g=;
        b=qlQcrWWi10J56v1nfpTctzpn4Swf9gH5shFux+PJwO45iHIvBBZzhG6A10jYVZ2pRU
         hyrBd3oehcwlw2zXTRT5BBjciYbOEOiOYj+MUArBEIDL5bmAyqleDmabLZ3tr+Wewtky
         yz+vxZ1AeSLe8VZsCQUi5Flcx1q4Ys8InqJGyTJFen1pWnyD3QJdYakFpq+1O08RoWGq
         Xbw7fagFGcuuDruKksqCYWBVUyIdhYoCPzCIEkGLZIZ7u/CcHkUvETec+FzCK22OKYVX
         8/jIkt4/XSFtmqqBVeyG/ZKIJseAM5UOoVgOHecxRkvF0+Ih9niQ6oiI0PafvAqJ5g9B
         zHzA==
X-Gm-Message-State: APjAAAWCgzk33B6pQG6mhzOiccG1Mh9hVpx2KmAlAlNzGUDLIIo79tVB
        GYN6FxBcUVNhWhKQgOJil1wusl1fXxM=
X-Google-Smtp-Source: APXvYqzhbm63vVwz8MkLbqVEozvPCGUpkRxUdFLI5tbDejRiQv2z8BEuZPI3JYtPEXnqUEnqNdDqWA==
X-Received: by 2002:a63:a508:: with SMTP id n8mr40201640pgf.278.1579210065241;
        Thu, 16 Jan 2020 13:27:45 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.39])
        by smtp.gmail.com with ESMTPSA id 207sm27141173pfu.88.2020.01.16.13.27.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:27:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Thu, 16 Jan 2020 13:27:42 -0800
Message-Id: <20200116212743.21016-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
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
index 093aedebdf0c..b9ea88cfd2d2 100644
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
@@ -724,6 +764,7 @@ enum {
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
+	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 };
-- 
2.21.0

