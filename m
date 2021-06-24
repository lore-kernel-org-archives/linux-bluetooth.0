Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA4C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77987613B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 22:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhFXWLH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhFXWLG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 18:11:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 15:08:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a2so5885643pgi.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBee1llRETyTgI8ynfPaEgwZTkqMbpQ7SW+PAd/N8I4=;
        b=J9RShdcKWQNqJVmRD8s5ZXuv8bllX+jlYenfr3/C58nh9lanmaw3vLS4dpwBs9KiZX
         BG6ub62IkDHj97Ty7dGRoCCRdYxse3JPXEhDYqkyADCaz06czpNYw6ZHSoxTJpLbnB3u
         wMJ+bE1PETx8ACPCB20rbTzgURGvS3B3GtqGEZKf/C42xEJ2CzPCvgo4zAOt4CVao1Zk
         rDhr3vYyHFO1z6w2wIbegyFJKUPvC9kl21+0UpH4f01OhxSTLid6Ds5bdhbQM/JEkpAk
         udievG50DrlF+uTERGD0NPhLJ84iyL2puxyrWJe++hclWGv4VsOJ6PFw+7pKxV8Omdws
         bJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBee1llRETyTgI8ynfPaEgwZTkqMbpQ7SW+PAd/N8I4=;
        b=gRuG8bTCx5a3DLESZvHQGLjyE3RazqHlVtuBIW5St5rwcJULoGEEyyf/h74bRmjZMG
         78LrXuOL61kYwTaeFRXqQ9Yp+dQAj0cnCXD4qvD8RDspMAXag6vBVcbvp/9FxWriKLAJ
         OvNkFpgiGE7z+RQXSBIGzUF7HZ893HdbeQvVwdlKFngkHQDAL32dpADes/HTvwED/lKu
         R1lNgO10xFtHgwDvmPLWmou4jXnoPdiYCW8Q/z+UCwRJJiH9m4hiPqRTz+kJ3t/+2lNB
         djIUAeYWDyyKxo9yQ1yG5XRb9Q7VdLRjLMWimHkIKX1vERgV3AQDgZ6LJuVcDNZs/4sD
         0ooQ==
X-Gm-Message-State: AOAM5322IkJyRgkIQTsHXwQ3xgKEY7vB0WsvXtDDrtOPgXLTVzlbFjZj
        MfGqRhtoqharYKkm0IIy/otrjiaEub3Rhg==
X-Google-Smtp-Source: ABdhPJyul/sGq4TJRqOQ7pkZUoHwl3kF1AVUV7dewXdNZWfSCxXe9bYN+zsuMWGA2yk1jTIxqwMgbw==
X-Received: by 2002:a63:4041:: with SMTP id n62mr6458228pga.204.1624572525677;
        Thu, 24 Jun 2021 15:08:45 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p20sm3268094pgi.94.2021.06.24.15.08.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:08:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix toggling of experimental features
Date:   Thu, 24 Jun 2021 15:08:44 -0700
Message-Id: <20210624220844.3920039-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When toggling experimental features it may cause the old value to still
be in effect since it was read after read info which upon completion
would attempt to call adapter_register without first updating the
experimental features which could affect the likes of advertising
instances when LL Privacy is enabled.
---
 src/adapter.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2175120f4..84bc5a1b0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9253,14 +9253,15 @@ static void set_exp_debug_complete(uint8_t status, uint16_t len,
 static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
 {
 	struct mgmt_cp_set_exp_feature cp;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
 
-	/* If already enabled don't attempt to set it again */
-	if (flags & BIT(0))
+	/* If already set don't attempt to set it again */
+	if (action == (flags & BIT(0)))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(cp.uuid, debug_uuid, 16);
-	cp.action = 0x01;
+	cp.action = btd_opts.experimental ? 0x01 : 0x00;
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
@@ -9289,14 +9290,15 @@ static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 static void rpa_resolution_func(struct btd_adapter *adapter, uint32_t flags)
 {
 	struct mgmt_cp_set_exp_feature cp;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
 
-	/* If already enabled don't attempt to set it again */
-	if (flags & BIT(0))
+	/* If already set don't attempt to set it again */
+	if (action == (flags & BIT(0)))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(cp.uuid, rpa_resolution_uuid, 16);
-	cp.action = 0x01;
+	cp.action = action;
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
@@ -9480,10 +9482,6 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
 
-	if (btd_opts.experimental &&
-			btd_has_kernel_features(KERNEL_EXP_FEATURES))
-		read_exp_features(adapter);
-
 	err = adapter_register(adapter);
 	if (err < 0) {
 		btd_error(adapter->dev_id, "Unable to register new adapter");
@@ -9707,6 +9705,9 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 		return;
 	}
 
+	if (btd_has_kernel_features(KERNEL_EXP_FEATURES))
+		read_exp_features(adapter);
+
 	/*
 	 * Protect against potential two executions of read controller info.
 	 *
-- 
2.31.1

