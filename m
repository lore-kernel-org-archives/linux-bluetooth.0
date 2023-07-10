Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE45EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGJWUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGJWUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 18:20:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B692189
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 15:20:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6726d5d92afso3916850b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689027617; x=1691619617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MyDU1INtuPnC1dvOf6tBCH0BkXwEoWCuMhND3vaDQkk=;
        b=HlAJnw14Bwm1LTn2donYrO7EqGu0FXFa67hzo3LRUB3l+/FYqyH99aaseqaSaGNZL5
         UR/kRIu435FahCQFgxmGn/zedGBRqqiM+BQ4kPrC1h2Gv+Iig9i4H6MlXrMGKiKhNm7u
         kmEifj6Un41LmOrFWsM8BaZfA8UazMYBVsaZjJIuJsV+0bjs6vRFLqtzkmKm/huvGIts
         ePMYOS20o+/LzO5Dm4BYXOijaB0JBnUG196W1bgo4WzTkzp+fjN5eovxfmSm/5C20WIb
         X5LT4NBjm+bLuYjrzap2dEAO7StEt0SktsBQ4lUCEqsSxSo2cN4BaqP/L9Y3BAE9wPJ5
         Daqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689027617; x=1691619617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyDU1INtuPnC1dvOf6tBCH0BkXwEoWCuMhND3vaDQkk=;
        b=RmHy8Xwisg8OOUbe1Ll2W1MusKvMSFEwaod5ijEA8zCJwvAp2vYTm1UFjHv98wLB63
         A6pukG4XACo8mB87/og2GfT9vKbvltxhHkumA16wQzgIT9ycmfLEveNSUJjpj4TfJGNF
         1CFyNs6td8hvADWyrzM8t1rj3VO1c9vfvYypnX1ZMt2cRCvNJg6y/FrSXVgAtjslJOYz
         WZc4YEwziHzHd7Z1JbYKRWK8aKu+vbju7lpAENKWRZjSRRu85E3gwmp/lVnUBQq+giVi
         k8GmvWvNQ4SXmxPmN0dOEsnyn+XzMPwLBG3TP9oKGov6dxIqWC2eM/8znQrPsHU7S79e
         DhLA==
X-Gm-Message-State: ABy/qLbUss9r1N349n/MRUFLbemi7JioIoL8MZ2QTox27MEU7G1XFHEH
        D3DrWXEoXBmgIom4QS06zyKHws9rR/U=
X-Google-Smtp-Source: APBJJlEr/hfNfCeMsI4zy/okaWjMAwT37my5kGGJOz9eBq1vRflQco9lgPXwoLS7m75qMG9WzbIjog==
X-Received: by 2002:a17:90a:cc0e:b0:262:ec12:7c40 with SMTP id b14-20020a17090acc0e00b00262ec127c40mr20280211pju.11.1689027616744;
        Mon, 10 Jul 2023 15:20:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a9f8900b00264040322desm386519pjp.40.2023.07.10.15.20.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 15:20:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] main: Remove DEFAULT_SIRK
Date:   Mon, 10 Jul 2023 15:20:14 -0700
Message-Id: <20230710222014.1231369-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

DEFAULT_SIRK is currently not used.
---
 src/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8dfd2543ba1c..150a5af4cca4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -61,9 +61,6 @@
 #define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
 #define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
 
-/*CSIP Profile - Server */
-#define DEFAULT_SIRK "761FAE703ED681F0C50B34155B6434FB"
-
 #define SHUTDOWN_GRACE_SECONDS 10
 
 struct btd_opts btd_opts;
-- 
2.40.1

