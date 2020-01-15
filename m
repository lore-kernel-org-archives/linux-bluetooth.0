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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FD6C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187872187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNCWSf2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAOGgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40391 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOGgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so7722412pgt.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3PfmQT411tQtswRiQsQBGfNIHO29hvNOYy4i+YrdxFs=;
        b=KNCWSf2jRJHDdwuFYXOmbHbcYY0snCfKPNf6sNp6VPoR+/dx6bl209COw3Gsyhg3ND
         eFgaEmBde1vUzaJRh+kR7h40cV0iJ/cutJ6KTFISEZ5hv/eUHwcf1ePz0hFfU7xcGEZ9
         x67/JlCa6BmpqxaCTbkJBM0q+crQyu24qQ8V/Ax4159hTonqwwK2O83RZYpBUHD6pwIl
         cug1bV+/a0HtEU4xMEaDlslch9USD+FSJncdgLo/O9UzX7UAvCOjow/5X7GPxHUFaVp9
         p6H7lnnSnE/rMYvkfroBDOtjy5rIdcLuyMn+EfMqg5uAyfpFK3hN7CwMjJ3jlK/eCFpH
         isdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PfmQT411tQtswRiQsQBGfNIHO29hvNOYy4i+YrdxFs=;
        b=JwouqFFwuQS9OFbnRoYa5YIni1Ieh4vSJnf266x6obx2yIRRaN+u4IEAWfM3t52qpM
         XSbRArfNWlb83qVjaxG9tHLgCHh2R/WMn7a5zio+XQhHysqiXCuicrljbXclBs+tdlFi
         7GK3OP2JhSJBHYzREwpuQMTNcEdhRcGlO3LRtxqXcI63zqYw7g2OSWE4mNYU5qUoOjCn
         +lF+YLhUZIW1C02cfoTE/6AeKK7cG0bOzqr6IDHKXWdv8jkSPqA3MvKBl1SJ/sGS37mE
         jVIt/bkBpXLPVThE77qZ4dVHOwza7FKnBhICGnr+vZU1ddVhj0RqTDjhWInzavHvY6pP
         /GfQ==
X-Gm-Message-State: APjAAAX7oIOsZqEHX4n/ItkGKvHMvp6DiOd71P691EFW1Ipm4LkhHlha
        2BULDSBWz57TadISptH7N+3SgaQX5tU=
X-Google-Smtp-Source: APXvYqwQbZ3vfRWA0YiArGhdwJOtls8D2ZDyOVxotbrow6keZTghfLcgHM0HHGFxtdYUipTNk75FzA==
X-Received: by 2002:aa7:880c:: with SMTP id c12mr30098157pfo.255.1579070198340;
        Tue, 14 Jan 2020 22:36:38 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 03/11] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Tue, 14 Jan 2020 22:36:25 -0800
Message-Id: <20200115063633.32441-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063633.32441-1-luiz.dentz@gmail.com>
References: <20200115063633.32441-1-luiz.dentz@gmail.com>
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

