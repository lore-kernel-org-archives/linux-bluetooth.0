Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C43C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBAE20644
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 14:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnGUv5xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgFOOw0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOOw0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 10:52:26 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2FBC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 07:52:26 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id i1so3997952vkp.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U47mD7HI4pVeug6As2ImtcNTuS18CXWl9hDoOJueBcg=;
        b=HnGUv5xrM0yZzSZmcg/qOyMDquyIdHz2IfxEDrmhu0nVs4FT7QTO9WCGJA89ZgPW9K
         bz6fyZOB8iPCNbwNdKJUfiv4YBrDgPDImks98ybbxJi0pLzng9FLtwKkynry+h6a7vnA
         3dhlHxsdcpdgrhkUjhLKkjn4+F8BGdDasW9jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U47mD7HI4pVeug6As2ImtcNTuS18CXWl9hDoOJueBcg=;
        b=PSm9Sz0tiwmYV8cv3fcFOiuh908q08UAg6pgy7LNvsIZzYZ+exjRbq7dcTuTSh/+mn
         TquKEISY1/QYdEXvN39v+idbi3Igmo1SgKyB+4YhgkwRsysNs4m1aypE+2AVyRYVuAUH
         MQ+h0wbjZiPFXAtaHxtuD6zB+ZuVk9LbA9+5wgeGIQIVrGxcmFO9k7eXOL9XRfvwFfem
         KpZ6wMtHgV6unM1FQYqup/xJS/zKzkccHhqYELkrU1LgzzECdczmOiukkZqOkDuN/LoX
         xJybVC6EIA/3ZPlAEu8rfFHeVMdW4W2u8hYvwM7MiUKLS9MzeTgz4GnX28hA1sIWNsb8
         e/DQ==
X-Gm-Message-State: AOAM530JWjEEjvFhYiC3eRjepvQ5mdkcsDfkM8zQyGLdebDtuom59+m5
        a0fd9rQKVgpn/7jEdT/E9KrzIZ7dk5Y=
X-Google-Smtp-Source: ABdhPJyJ3jGsapW98P9ZCwmm5V8GqpgBawGWzehtwaQVjQ3W5xWJIOJMpLm9KcI2Tg0Mi0zBp5M6sw==
X-Received: by 2002:a1f:2d8e:: with SMTP id t136mr18590612vkt.61.1592232744814;
        Mon, 15 Jun 2020 07:52:24 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id k5sm1802086uak.20.2020.06.15.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:52:24 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] main: adding missing connection parameter entries
Date:   Mon, 15 Jun 2020 14:52:21 +0000
Message-Id: <20200615145221.224747-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the missing connection parameter entries for loading
connection parameters from main.conf

---

 src/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/main.c b/src/main.c
index 77886d58e..ceb839d11 100644
--- a/src/main.c
+++ b/src/main.c
@@ -411,6 +411,22 @@ static void parse_controller_config(GKeyFile *config)
 		  &main_opts.default_params.le_scan_win_connect,
 		  0x0004,
 		  0x4000},
+		{ "LEMinConnectionInterval",
+		  &main_opts.default_params.le_min_conn_interval,
+		  0x0006,
+		  0x0C80},
+		{ "LEMaxConnectionInterval",
+		  &main_opts.default_params.le_max_conn_interval,
+		  0x0006,
+		  0x0C80},
+		{ "LEConnectionLatency",
+		  &main_opts.default_params.le_conn_latency,
+		  0x0000,
+		  0x01F3},
+		{ "LEConnectionSupervisionTimeout",
+		  &main_opts.default_params.le_conn_lsto,
+		  0x000A,
+		  0x0C80},
 		{ "LEAutoconnecttimeout",
 		  &main_opts.default_params.le_autoconnect_timeout,
 		  0x0001,
-- 
2.27.0.290.gba653c62da-goog

