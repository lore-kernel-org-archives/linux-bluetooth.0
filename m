Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0140CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF0D20776
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCIdltDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2PaG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:30:05 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C9C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:30:05 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id i89so933604uad.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7M2tfYh80B9hmGNpy89uPZ4yjgvheWE9VRKIf2ge+mQ=;
        b=FCIdltDe14eg5SienV6NQ21GpiJL8rjPbhU/wAshdh1YNbfHkypTWvf42bvYuj0OAB
         H5VzxE4Brrjkb2pw1KbGM+sIWdX59vTPQx8vlKoiTKTUFSJCMPpT63Pu70339GAI8C7s
         UcGU52fpKIFsiIVmihPWS8zhJtUTcLhp3ga1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7M2tfYh80B9hmGNpy89uPZ4yjgvheWE9VRKIf2ge+mQ=;
        b=GajY2ZImGTngqw5jwSnEyQqrckojkrPiK3EH/Zhw7bS6hre72smD0goS0uielsuPQ2
         2iWwrgkehfXZCkVV+wQEvdaU+6AgEjilqbUqvDNP0r4wglg6TgDJuKZGMKLJGeoR9kL6
         8iPCrKqaEgyV+JQj8XQgpAON21SIlli4UVrBWUU87ezlS88AGpmymJlcRb6/Ajewsl5e
         Y6k+BlhEQk5hbloLttb1o71sLDMxomT7yZjRFDWeJiQZNFjcHHfAYAe2T9tcMkouM1Ek
         7BXjU5YLoqw71P8yqqhvKT+3wrFHjxQciW65E6tceE+eMEZdtzS1f8VQf4155mIMrj41
         CBHw==
X-Gm-Message-State: AOAM531gghM60JEDQslAJj6Pjkv0LLvgA8IFEmWBmZhEmmb5DiffTs8q
        7TSF1E52d3AfK/lR4yTWuJZa6mOsMYE=
X-Google-Smtp-Source: ABdhPJw+6LKk4dQfawFM+fHduoWndhArXaiwiz8TkVuXtnxcFJo9wwt4Bq5N/zGdtdf+p3wMAahoJQ==
X-Received: by 2002:a9f:2a82:: with SMTP id z2mr5995780uai.71.1590766204006;
        Fri, 29 May 2020 08:30:04 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id c65sm1216286vkh.32.2020.05.29.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:30:03 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2 1/3] mgmt:adding load default system configuration definitions
Date:   Fri, 29 May 2020 15:29:39 +0000
Message-Id: <20200529152940.208214-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200529152940.208214-1-alainm@chromium.org>
References: <20200529152940.208214-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the load default system configuration definitions

---

Changes in v2: None

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

