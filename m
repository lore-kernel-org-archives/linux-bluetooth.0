Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiBIJZw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:25:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbiBIJZt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:25:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD4E0B2A96
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:25:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso3440979pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbGl2g+xSsgoPigjMOhOL2LjoIGxCaud1t0GsUmz8Ic=;
        b=SUBqX8PdHolVXO9Ec0CTGckqgeuirioszUEVCkjId/QIt4rx8V+Er9MVp9+AWZcOEt
         vXV9lO9DoREsfv9gLAZzOh9gYTMGH5JNoXuZ2O9sAXR4Tldq+Lk1jYlB98JUP60zHjAw
         tGwf/611fI8mxqM2pFY12hCgqLOn0+NU1e0Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbGl2g+xSsgoPigjMOhOL2LjoIGxCaud1t0GsUmz8Ic=;
        b=Y8iz5flk2VX6/5o3gPmImyomHbUkMPq9yTDy96CQGk639hJm3+eVuwcYv1lnSW0NUt
         ScmSNVz/U5ZHx3aEjcebdukyJGPNBKliU/gfrdmNXv8EnXjhSBMMoLqo3n/Ar4ikWl7I
         DKEg+PskhIaZZajfK+zkPjywe5ZxMBJRwcmzjjI86bh8ub+c0Byk/4OgpqyFZEwMMftg
         uHORWJSKtipXC/KPmSFlPq1EJOFPuVw7mp55q7qylQEuBTksU4C7GUUQE7+ikiM8HVni
         51u3gNaouEOsf3arN3Njd4bT9RnN0EfgFTmzM1lr8aXC2dMZGYCH5hCQ+fej3o+5Y60v
         /eVA==
X-Gm-Message-State: AOAM531gA5pi0f26coXuYGEwugeulIIjUBajb0n6+zH+Th8INyFIEyQd
        0sCUigXQzKtLduDtQCb7PWAaopQgHp2kVQ==
X-Google-Smtp-Source: ABdhPJx71x5puUV4TU5bwl89O4+GlrcVcrfPpwAN2pJ7pWHM+P1hYOsCo4LTbc2qhUu/ynIWoB6rRw==
X-Received: by 2002:a17:902:b286:: with SMTP id u6mr1205141plr.155.1644398675467;
        Wed, 09 Feb 2022 01:24:35 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id f8sm19261995pfe.204.2022.02.09.01.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:35 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 6/9] lib: Add structure and constant for MGMT_OP_SET_QUALITY_REPORT
Date:   Wed,  9 Feb 2022 17:24:11 +0800
Message-Id: <20220209092414.751642-4-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the struct and constant for
MGMT_OP_SET_QUALITY_REPORT.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- This is a new patch that adds the structure and constant for
  MGMT_OP_SET_QUALITY_REPORT.

 lib/mgmt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index db9a24cd6..2741d5d66 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -96,6 +96,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_QUALITY_REPORT	0x00040000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -757,6 +758,11 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
 	struct mgmt_adv_pattern patterns[0];
 } __packed;
 
+#define MGMT_OP_SET_QUALITY_REPORT		0x0057
+struct mgmt_cp_set_quality_report {
+	uint8_t action;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.35.0.263.gb82422642f-goog

