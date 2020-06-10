Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECECDC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA26A2078C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gs6Bl4D7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgFJUFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUFI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:05:08 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00676C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:05:06 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j13so2058523vsn.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIUmtc7FzPb7IfswT/w4sEtz1eyk64UOiSJB4Fk7/AM=;
        b=Gs6Bl4D7wkwfRnVrABNZ7yCOiliz0UBQEGPFtt7Ln5DZFso2zqI16sGSOaedzEjeuI
         mLv3F5YOTLwOzM3nccGiVWXZo+Ri8lQXxgNG3r0U6q+fxsZbFYA3JE+dtJeFrsUsDOYz
         8e1/urFMewoXqDn2sdsQBIHHkyXW2ePN3aV1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIUmtc7FzPb7IfswT/w4sEtz1eyk64UOiSJB4Fk7/AM=;
        b=EOUEqzDpMHPf9aTqdj13bkIpqXS6mjGMJwrViP+/zqDKlte60NggtK3IaVCpQjrRfX
         fTSZtqVX+y0Mr03/dcSpY0OF9n0dYi/04kxvOqyx+I6qwZYxOD8K29IylmKoUIfQ+C1v
         8wZCrqN6XGlKKqi36LuHzRGfUbcMOfGGbnRdxr48kjcNtjKxwSThQjR0RswT5uzT9Ekr
         megO9D7+LPd+i+NvqmfaiRkSk5JIFlEnf26S+qT9g5PmwW+Q9kAvtGeW0aqFlmPlceu1
         bAOvXaGIMFxNJ68IyytKDtbcjf19CVdeAApEWErXcsXS7/gIPePhEXPJYuVgZzlL3TsC
         HDJg==
X-Gm-Message-State: AOAM531Oi1rOIn4ZSs6jTfe4TnuppiK22cygr64Av8zvHcDFQU63D/pQ
        MLUY3ZXhA17zIA1tjes2uJNWmwbXHxQ=
X-Google-Smtp-Source: ABdhPJzEzKTvjZedKX8Dr9t1/m+8xBykG7HsayRVgVc9XoQk7aXvU+9tgsiXychua6CjXFFhyy5w8A==
X-Received: by 2002:a67:6143:: with SMTP id v64mr4080289vsb.140.1591819506004;
        Wed, 10 Jun 2020 13:05:06 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q185sm107253vkq.10.2020.06.10.13.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:05:05 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Subject: [PATCH v2 1/3] mgmt: read/set system parameter definitions
Date:   Wed, 10 Jun 2020 20:04:51 +0000
Message-Id: <20200610200452.107406-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200610200452.107406-1-alainm@chromium.org>
References: <20200610200452.107406-1-alainm@chromium.org>
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

