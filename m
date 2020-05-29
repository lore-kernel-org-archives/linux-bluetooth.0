Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848CEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 14:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F2C207BC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxcGj63W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgE2Ouf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2Ouc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 10:50:32 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6FC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 07:50:32 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c15so869884uar.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLzJJaMVoDM5EoEAk4znCaHIyIqYaht6B8SksNLwgIU=;
        b=cxcGj63W2HHgk+jMAsUqsmOnx+5DN5L+bvZU23RTLJzgtst/Epq8Uy37/4sdlq+wfD
         LyIXYP+pfxHUpe0ZUx0NHK7lkUMIkhamzFBwfrxpeA3mF5yRDIeeeBZ1exBulFfoiCMd
         wFdLNflN9E96fY6Pkh2od6dxFX0wyhO/san1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLzJJaMVoDM5EoEAk4znCaHIyIqYaht6B8SksNLwgIU=;
        b=GuAKFTk88SaDYHw+srXGGtMbaSWD7RYvU94m7AkL5VYnMZoODhJN0SEc5nj/qImktD
         yuHGZyyChJgGXfgij7fPvWSAEyhRLoVrOTllJM/Qk+vYEQkxBQZzJYpgMlPHJcCSyTGt
         8d+UpFS+i5y/G0f4JETZW2HEvgVyebt4opcGRssi5QOdzsrv+Xzu9Wb4d92oKxC09Wjc
         85n5Fre3d7uWT6oAfFc+hmq2QMs4q9Cmngega0vYNq2DWpttfryxnDpHOm72tz9aEQeA
         tglnHreHxjPMsc4k4ru1BnfvXT1yzuJuYAzJQFDCase/EZ8+b3Fs6cT6xUqy6ahqIH3o
         G0Mw==
X-Gm-Message-State: AOAM5313oEvqW9hyGwkUQhcJmCWeSdpXSgmCoSddDs3onk+UtALyfND1
        f5pHNKi44jpFwHfybYcpsdDrYM5ThxU=
X-Google-Smtp-Source: ABdhPJy4BxQ5TdZSuJUH1ug8Zmkiv2EO2YisKvbp3uaeepzaDqY/BiCZUcZ8EtW70YPKsqJYIrmP0g==
X-Received: by 2002:a9f:23e7:: with SMTP id 94mr6116936uao.84.1590763831250;
        Fri, 29 May 2020 07:50:31 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id c65sm1196998vkh.32.2020.05.29.07.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:50:30 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 1/3] mgmt:adding load default system configuration definitions
Date:   Fri, 29 May 2020 14:50:06 +0000
Message-Id: <20200529145007.198906-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200529145007.198906-1-alainm@chromium.org>
References: <20200529145007.198906-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the load default system configuration definitions

---

 lib/mgmt.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index b4fc72069..ea89c46b1 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -628,6 +628,24 @@ struct mgmt_rp_set_exp_feature {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS	0x004b
+
+struct mgmt_system_parameter_tlv {
+	uint16_t parameter_type;
+	uint8_t length;
+	uint8_t value[];
+} __packed;
+
+struct mgmt_rp_read_default_system_parameters {
+	uint8_t parameters[0]; // mgmt_system_parameter_tlv
+} __packed;
+
+#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS	0x004c
+
+struct mgmt_cp_set_default_system_parameters {
+	uint8_t parameters[0]; // mgmt_system_parameter_tlv
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -933,6 +951,8 @@ static const char *mgmt_op[] = {
 	"Read Security Information",			/* 0x0048 */
 	"Read Experimental Features Information",
 	"Set Experimental Feature",
+	"Read Default System Configuration",
+	"Set Default System Configuration",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.27.0.rc0.183.gde8f92d652-goog

