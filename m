Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E68C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08912077D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LYF6cBsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgE2Pik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2Pik (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:38:40 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0CC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:38:39 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id a68so1731300vsd.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qT+qHtCvE3L/ov2zGu6w9f5vlZG2T4fN53Co4LKoPm8=;
        b=LYF6cBsAEUDYo5xOvBtA/J5lf4D9jlefhp9Vxj+rCMqpJ0+xB59mnmc6OPURGGu42H
         km19k0Q/nb7vfXbL3sqxpxJKjQgaM+uYoxiKs0z6IPUyexRjU0nR8zE5Ew6lKc1s1k3a
         kpwpi8S1dQ2PcSLx7haFk5OGG3WOk9Ss8vrDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qT+qHtCvE3L/ov2zGu6w9f5vlZG2T4fN53Co4LKoPm8=;
        b=NDKuTE3tdSF7//mQVD1YKkFpb9h9gM0wlBE5rxSi+ITpL0DQJB9s91szGNvqtKOJqg
         LH5tDBYRt8jgiaDkbt/FmlFuCqrP+F/RLLQYdWvKHYdYRo6T5HM2Imj/sw8oQ3nLPXVV
         7DlKQyNC4JG+Wj9k+L+M/bXbEwv8Hfij2jYWmbquPcrAPRova8MQym0dcAg3WEz9lIom
         rVaLjzL14IWu/D8o8QtD0F6W5bEhNt0IMfoUSd5uHGrDSg4yGkUS3d6OX9IfiF6RAqhr
         hCZW+RM+sEed1T/jXCO7POdibFgysAxdA+gP9u+9ezWng5tYzTgzSFCrqMUWZkqKruDQ
         K/4A==
X-Gm-Message-State: AOAM532we/y9Dskgo4zHCnr3mNAMr/IBJ1YBm3VawwEAQxgYBOu8qUL6
        tNprw8IyPWCkrEFFaQmoBNweyOfUp1g=
X-Google-Smtp-Source: ABdhPJyF+FyzuiaobWFjmMwH3vGwcZcjusdaoCZ5M67yt+YQQbuYrlyPLwtxAfDBtpWvEF97KnquBA==
X-Received: by 2002:a67:ecc3:: with SMTP id i3mr5988342vsp.170.1590766718744;
        Fri, 29 May 2020 08:38:38 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id o2sm1309494vkl.27.2020.05.29.08.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:38:38 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v3 1/4] mgmt:adding load default system configuration definitions
Date:   Fri, 29 May 2020 15:38:11 +0000
Message-Id: <20200529153814.213125-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200529153814.213125-1-alainm@chromium.org>
References: <20200529153814.213125-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the load default system configuration definitions

---

Changes in v3: None
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

