Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B74C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 21:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIUVx5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiIUVxq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 17:53:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD76AA6C4D
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:53:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id go6so7875218pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=JtnkHnEK4iJZZqPcNkQ/ga7SmGpwkVbV0zGGaFvxJko=;
        b=ZY43Me8mFPBPwtmMn+VM8bREBPTjaObI7EnTxTCacMu9OV94boGS8c9rJFUWWgCK1Y
         ssCou2jwMdwH9IMk4RasF+uXuL4LcHLTYp/w9H3JphtMOVspnzl5/CLWSpYZ5S/imFOW
         ryK/vr4RyxsoS9Nj634XSzqaemoAutrN19pM3S75/7r0ytwQGADhUY99/sFTeG+Yz3Ge
         CG/blhAw4txFWOwZyuhO4CUYlRZIstrJz2x6vaBwLsxXzPRMsWrR/A6Xn5M7IHDrP5J6
         jHOTW9082tV2NFNkx3ea8MlTEFIswxrzto+ivyEB0wVD1dAiD2RLVEdX918oTpd00KBl
         XEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=JtnkHnEK4iJZZqPcNkQ/ga7SmGpwkVbV0zGGaFvxJko=;
        b=QbETPdk9vdQxzE1h4SkiA9R/BPQ3bHjEkvteJvWMjPuL9HiAaLVWnuLoI7sbRS0GTK
         XwkFF8+cJeoyzrhECBCfHuYkVFY4ChMH3pLENe9mAGragezVLSAjTcv4DptLiiGUyUoP
         At/P6i6AbT4xgNNZBOH9QwTrMy7ylz7mhyxxRszoEbMQmCJaaCvUvsWP1kSbrR8CMXCQ
         9NPAmTCPVOTp4a9Mzq2KFmIW6YJlLRa9lCS9Wgb3w2a7SS5n4m59/8ZvkocUVYyEIRD1
         7kylG4415QDY0DP+AQ1adzhIoGgWPohY0QwGHIu0Ze9+7YYIu6eOd9E+IkbT6GyrPwsK
         hp4w==
X-Gm-Message-State: ACrzQf3REfkES6SaP16zspapmzBgbmh73/g2eoTDrJ2Z76Yn4RX5oeBJ
        B35IaITQ85n5mi1rQ7exTLk4SgEK36c=
X-Google-Smtp-Source: AMsMyM42U7a52vHz7aYoY6njqffI3TlbwRt9Tuzmq2xYFE+MzBgJlJGWy9YEz+Qcc/SeOKzpgDokeg==
X-Received: by 2002:a17:902:c410:b0:177:82b6:e6ed with SMTP id k16-20020a170902c41000b0017782b6e6edmr255292plk.27.1663797224699;
        Wed, 21 Sep 2022 14:53:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b00172dc6e1916sm2462917pla.220.2022.09.21.14.53.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:53:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Fix scan-build warning
Date:   Wed, 21 Sep 2022 14:53:42 -0700
Message-Id: <20220921215342.2263924-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

src/shared/gatt-db.c:1339:2: warning: Undefined or garbage value
returned to caller [core.uninitialized.UndefReturn]
        return data.num_of_res;
        ^~~~~~~~~~~~~~~~~~~~~~
---
 src/shared/gatt-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 32cbf6cdc38b..ff2502ff9681 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1328,6 +1328,7 @@ unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
 {
 	struct find_by_type_value_data data;
 
+	memset(&data, 0, sizeof(data));
 	data.func = func;
 	data.user_data = user_data;
 	data.value = value;
-- 
2.37.3

