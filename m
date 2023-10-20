Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD3C0032E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 23:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJTXmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJTXmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 19:42:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE33D79
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 16:42:16 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a68d1698adso33183039f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697845335; x=1698450135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWqBNAeX6A/2t7F/B2+AP6gAdJuZDGSc/q1r/hSrihM=;
        b=ODzzqybhSLqUwLUeSf60vxSglL3tPYdZ3ClrQXnac13D0zG7Fckm4Pbps2Iqg7+v8p
         L+fH57aBsF1xYE8rm+EGhw/AAeJwFrljtT1uSSB6pMZh80CAe072jnn3ZY/k8em1UXDe
         s84CMBBHyxFnV5VzlNX1upDiegFyjaN3uXVU0VoZvLBxVN0kF0eOBGjixR+oRc63v+Cx
         9j/SJyieaF/9r/RN/7AJ4FqEOgyizeS5SFHyNA5R70fh6QcgfuSEMq/LHbJ8gVsEQobz
         7DmSX8m79ZncR6LjRzzLw9xPj9zwvEsvDsniJAXNv1sb/F9Shw/WM8utipp8WWTek9rJ
         ERDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697845335; x=1698450135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWqBNAeX6A/2t7F/B2+AP6gAdJuZDGSc/q1r/hSrihM=;
        b=GS9uEL3olCApLtsCEJ7VjOR+NNgb+abg7QR4OQozWqO7vKRvMRUwV/cmaRzTIDoc7B
         Angve3y8Cz3/1bFd5JeV4zJ/oe7g3n9uYCnsRH0XY95dOCt5N7WHiWUL5ZbjDWkusayx
         GX/kkEBQGcF5iUJ0q4wp2/IcLsLpQ/CuOBS0ggAVn1XyCUGRwgtyeHmfkhS4zj/hO0s7
         xBgsJ82uqxcDZWKABp5xndtiOtNEagzPB1+yAqJkyZJgDZFgPTJ9rCo4e2JKg6bcLM/1
         hyimxKzhV501zlDQAvAcLISeG+h1pTB534LpfhCQ+1b2YhT0L7il+WvlS4URHvXncFy+
         qqcQ==
X-Gm-Message-State: AOJu0Yx1aupdPBEE4fyi74n9ZDvXaMhSqfWMjfSPTIIbgLlygE2RkkcP
        tiaU03oDaK7RQmYeOfwnz2LQy0iLCPZDiZKzEwU=
X-Google-Smtp-Source: AGHT+IHmNFO/kpHIxTFWFsleGdgKIY2ypifEmUJJwV7lK2M0SLW/5JBMhjH6wcXeUHdRcJ3+vXtP4Q==
X-Received: by 2002:a6b:5904:0:b0:7a6:793d:2079 with SMTP id n4-20020a6b5904000000b007a6793d2079mr5780367iob.1.1697845334687;
        Fri, 20 Oct 2023 16:42:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id br12-20020a05663846cc00b0043a1483abc9sm796376jab.74.2023.10.20.16.42.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:42:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/bap: Remove Locations, Support Context and Context defines
Date:   Fri, 20 Oct 2023 16:42:11 -0700
Message-ID: <20231020234212.3190403-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These values shall come from the upper stack.
---
 src/shared/bap.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 14a62d9241eb..13bbcf7935bd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -48,14 +48,6 @@
 
 #define BAP_PROCESS_TIMEOUT 10
 
-#define PACS_SRC_LOCATION 0x00000001
-#define PACS_SNK_LOCATION 0x00000003
-
-#define PACS_SRC_CTXT 0x000f
-#define PACS_SUPPORTED_SRC_CTXT PACS_SRC_CTXT
-#define PACS_SNK_CTXT 0x0fff
-#define PACS_SUPPORTED_SNK_CTXT PACS_SNK_CTXT
-
 struct bt_bap_pac_changed {
 	unsigned int id;
 	bt_bap_pac_func_t added;
@@ -475,13 +467,6 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 
 	pacs = new0(struct bt_pacs, 1);
 
-	pacs->sink_loc_value = 0;
-	pacs->source_loc_value = 0;
-	pacs->sink_context_value = PACS_SNK_CTXT;
-	pacs->source_context_value = PACS_SRC_CTXT;
-	pacs->supported_sink_context_value = PACS_SUPPORTED_SNK_CTXT;
-	pacs->supported_source_context_value = PACS_SUPPORTED_SRC_CTXT;
-
 	/* Populate DB with PACS attributes */
 	bt_uuid16_create(&uuid, PACS_UUID);
 	pacs->service = gatt_db_add_service(db, &uuid, true, 19);
-- 
2.41.0

