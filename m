Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D15C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 22:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349549AbiFCWdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiFCWdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 18:33:00 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3E2EA09
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 15:32:59 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a15so8379338ilq.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmCa3NT9x7Hp7HvP90Wbo15D5q/wjmSRws1yCZIA7PI=;
        b=cugyfYSs28yRqoIzeOPrTL+x4kA9xXlMpAyqCi340uw4s9fAtaOOdJbtVUZwO6GRm1
         4ZMwznZqiiX+V52cXAa8uPA9yBBy+MC1FpOpGQsw1H+dlhQldAUCjFqk+urINw3BeT6B
         neRbrFA6vOFHpamZ+pcbBoV3ZeZ5f0dFf6aMcwSQwhOnHYSf5MQdy+wHbXhctfJIg8xH
         V9YAQ03GSw1CSSb7uGqUJVy530d9xhP8duwRsEolkPc5q/pN+hTLX0pScxBX3wDkPCV4
         ClTGP5eabWHOGvBes2nz6HwTLDo4rp0KuYl5QjcuucEkrk/XebZDHO3/16ztZvUnGfvl
         VG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmCa3NT9x7Hp7HvP90Wbo15D5q/wjmSRws1yCZIA7PI=;
        b=p2zFLM3b4XJRyTXJ+8dNAm9ZnvXpRQFYWzQP8bi904OT3DfLDIpEEvi8UR5F9cvXfv
         ew2HAtdQ0nS/gOfzoQbbpX8Bl7/Xa2QRFVDaKP8uUdeqhwYG5ivFNbEyhaYMu/XMV8yW
         TB4qUUDqWkFlXbkdvU9EXFHm1A7jUxu0X6kWb2s1aDiuvD+ks3Gu/hSrG8c4inAbGVjq
         zFPrecBQ+MwdSOOnimM9PLFUe4k/N5PShTfvcp5wgfAHfh4hgihTjVgnrQzsanqNKhVs
         9gj3+pcYABRO3C+WD+tCqdOIRvuS5Nb8hRiZPYClia3O9MBcqRiMySEubMnDzkXA+Th0
         mcXg==
X-Gm-Message-State: AOAM531a1HuWMoyeU/PP/eTDPV4W5s5Qc5d1gKAXrDavUtn4jw0bHFdZ
        0NMmWUVDjXUAA+5VSo7N/GhqIDPoae4=
X-Google-Smtp-Source: ABdhPJwEyowCXW4N1AUQNHgYo8IhkEBF2DoYLLxoUfhsM2g32oktxfUyrYm9YUV84hUag/yIrnUtJQ==
X-Received: by 2002:a92:c24c:0:b0:2d1:cdd0:1959 with SMTP id k12-20020a92c24c000000b002d1cdd01959mr6893408ilo.39.1654295579120;
        Fri, 03 Jun 2022 15:32:59 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id f2-20020a02b782000000b003315c00e885sm2825352jam.0.2022.06.03.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:32:58 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH 3/3] neard: Update D-Bus path and interface
Date:   Fri,  3 Jun 2022 17:32:25 -0500
Message-Id: <20220603223225.20296-4-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603223225.20296-1-puffy.taco@gmail.com>
References: <20220603223225.20296-1-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

neard has been carrying legacy interfaces since 2013
---
 plugins/neard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index cc56f922f..71de5964d 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -33,8 +33,8 @@
 #include "src/shared/util.h"
 
 #define NEARD_NAME "org.neard"
-#define NEARD_PATH "/"
-#define NEARD_MANAGER_INTERFACE "org.neard.Manager"
+#define NEARD_PATH "/org/neard"
+#define NEARD_MANAGER_INTERFACE "org.neard.AgentManager"
 #define AGENT_INTERFACE "org.neard.HandoverAgent"
 #define AGENT_PATH "/org/bluez/neard_handover_agent"
 #define AGENT_CARRIER_TYPE "bluetooth"
-- 
2.25.1

