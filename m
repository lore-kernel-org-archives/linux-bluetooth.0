Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9066C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C87920B80
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JoioZDZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgFEOYI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFEOYH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:24:07 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FD0C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 07:24:07 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 59so3353219uam.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oH6EO3gTiZyj4rBz2+doVVrrs75k/NK/sVSg4O5tgdc=;
        b=JoioZDZywo7Wb+J1omrVu/agYRt1nAjLbNASvymxZMhBmUVsfzTlm9xjC0w3Y2kgnU
         ohdlminOVSd0Omb9LLOpJENVAkUWtoFG4TirvrQ62JAM1LVJXaSW3VTmknpUX9SYupao
         KYnpVdEep1RUCvYNdzsNeX0/OwOe6t0o6EGAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oH6EO3gTiZyj4rBz2+doVVrrs75k/NK/sVSg4O5tgdc=;
        b=JDJf8IWi11JLm7amzi9lwiW7opNnAtj4foNhaod6MUwCba2T8yZzFRgpG4ZIWolRlF
         E/UlNVOM8U/PzLBVg+uAhBwj5/c62k5tu2TZkF/J/gCxNSVlefGVwOPYib6euFn2icHc
         bUGgND+I8cUx0PI7enZ4Gmn2UIK9/qBaRF7mp41X/jVHcpcAwV4yBW5GFJSUDV/8UFKA
         NwGqJfQSiGI4TljoGhtXo/Yv+kMTqoQufQVYSUfC1kGQ15KMI7PVF3G0Uqh3DN5ClV3w
         WeD8nT/rgmVdehWvJGHj14kPyADlqWf2E74KE9MPNhm/HaN4hHiMf0D52vupeyGq8u4F
         SeVg==
X-Gm-Message-State: AOAM532mJ7BzHA45LLWbEk80ZMqkhlz8E0mYMUgsTQHp9Mcch1i9DeP1
        u4yGecy0DAmDs4s55qxpOMEts1gCqyg=
X-Google-Smtp-Source: ABdhPJzoFL8ZBoLER/I/7WPpyRZ/8FwNItH5IzV/bJpjaE7cptpjUIsVjXZrNfTM1hf9TiZNQVCRwA==
X-Received: by 2002:ab0:7202:: with SMTP id u2mr7080455uao.119.1591367046103;
        Fri, 05 Jun 2020 07:24:06 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r139sm62320vkr.20.2020.06.05.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:24:05 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] mgmt: read/set system parameter definitions
Date:   Fri,  5 Jun 2020 14:24:01 +0000
Message-Id: <20200605142401.3588-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch submits the corresponding kernel definitions to mgmt.h.
This is submitted before the implementation to avoid any conflicts in
values allocations.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

The implementation will follow after some additional validation is
performed on the TLV parsing logic.

 include/net/bluetooth/mgmt.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fa..1081e371f03d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,24 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS	0x004b
+
+struct mgmt_system_parameter_tlv {
+	__u16 type;
+	__u8  length;
+	__u8  value[];
+} __packed;
+
+struct mgmt_rp_read_default_system_parameters {
+	__u8 parameters[0]; /* mgmt_system_parameter_tlv */
+} __packed;
+
+#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS	0x004c
+
+struct mgmt_cp_set_default_system_parameters {
+	__u8 parameters[0]; /* mgmt_system_parameter_tlv */
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
-- 
2.27.0.278.ge193c7cf3a9-goog

