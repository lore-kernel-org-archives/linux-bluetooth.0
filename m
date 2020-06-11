Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C559BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 02:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B0A206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 02:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n48McVKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFKCCF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKCCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 22:02:04 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955FC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 19:02:04 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y123so2509083vsb.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 19:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gX5gEjaAhk+Yg1HTNrJsp+Drp+hSN+9K/wcCOjy1ow=;
        b=n48McVKc1gbG6gCedoSb9KXhbQldd7w8g+rbDnruuJJafGw4HlJMT1q8iJ/PK8RD5l
         95tGaPTZrrpMaddjnpkXvmj2ul8Fjlkx1/1kQtUMlUnMYXpPMMM5CEZoFarnfUGDxy/p
         l0nxttdikMSNpjxYgku7zq1+XxQLlsz4Nwi6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gX5gEjaAhk+Yg1HTNrJsp+Drp+hSN+9K/wcCOjy1ow=;
        b=VIt6rt9FxQVFThmIwHCHeYkDjAGeUUM/jMKpPamG/9LTUZGjKnN15dzUGiA4jydgYa
         BSUPk+a2MbZFaS4OAMGFxb64Q1/oASqnKTMm/PBLIrtlkQ7PymD4We/WBxzGb7z24I78
         2yK/LLq+2tawGQ6J7800qWLusLa4FHi4fgdLNHx9X6WX5XLLzoVs2Su8edPuuA6/tOgM
         UpwXaR/GyBVzkepih68H2TTO5Is7gWmZCnJ2qfbwVhtXAxLQz3bAQtwIDJ3+yltMvBNY
         sPxTB3A47rfF6BuxZzl7GhlfnIDF4mrnJNND0jZtj7H4MDCTWZseR4ZYCrsS7INdxCtR
         ptJg==
X-Gm-Message-State: AOAM533T9B50PqFlPwQbHptU9z+1R+yUivmROJntlkN+9QG73Sy67er2
        YX9ZrPNtoe6DaNHZbadhym3PuZJkxE4=
X-Google-Smtp-Source: ABdhPJwXb7mBN1gnfSkpRn3XyZfzv84gmJOkhIbBRH6c86mTPBPseSrDYV7kGCId50gOMQ55cXlshA==
X-Received: by 2002:a67:fc0b:: with SMTP id o11mr4820672vsq.114.1591840923496;
        Wed, 10 Jun 2020 19:02:03 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r17sm243197vsi.34.2020.06.10.19.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 19:02:03 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Subject: [PATCH v3 1/3] mgmt: read/set system parameter definitions
Date:   Thu, 11 Jun 2020 02:01:55 +0000
Message-Id: <20200611020157.70230-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200611020157.70230-1-alainm@chromium.org>
References: <20200611020157.70230-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch submits the corresponding kernel definitions to mgmt.h.
This is submitted before the implementation to avoid any conflicts in
values allocations.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Yu Liu <yudiliu@google.com>

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
- Fixed sparse errors

Changes in v2:
- Renamed the mgmt.h per Marcel's comments.
- Addressed Marcel's comments in the implementation.

 include/net/bluetooth/mgmt.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fa..09452d2ea6d3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,36 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_OP_READ_DEF_SYSTEM_CONFIG	0x004b
+
+struct mgmt_tlv {
+	__u16 type;
+	__u8  length;
+	__u8  value[];
+} __packed;
+
+struct mgmt_rp_read_default_system_config {
+	__u8 parameters[0]; /* mgmt_tlv */
+} __packed;
+
+#define MGMT_OP_SET_DEF_SYSTEM_CONFIG	0x004c
+
+struct mgmt_cp_set_default_system_config {
+	__u8 parameters[0]; /* mgmt_tlv */
+} __packed;
+
+#define MGMT_OP_READ_DEF_RUNTIME_CONFIG	0x004d
+
+struct mgmt_rp_read_default_runtime_config {
+	__u8 parameters[0]; /* mgmt_tlv */
+} __packed;
+
+#define MGMT_OP_SET_DEF_RUNTIME_CONFIG	0x004e
+
+struct mgmt_cp_set_default_runtime_config {
+	__u8 parameters[0]; /* mgmt_tlv */
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
-- 
2.27.0.290.gba653c62da-goog

