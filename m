Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 22:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbiFJWMD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiFJWMD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 18:12:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808681FD9C3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 15:12:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so409820ioe.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtseVxzN5o/guOVe4zJxt+CZRQTnRic71Tf67otw8Ho=;
        b=EhP/klazZqgi1tJgrg811o3eqC77ZXQqWYvY3K/6LjFMz0iBLEbMxnJpc2B+Ijtfd/
         C0GQb+vO2BiEuZ0a+salPR/xmWNaiDpdazYwkr5iONCPBxlZO1iZgMMbJuJ8BZtLyJXf
         krdImU70N3o/Acnz0J71UNPX+z9jwTtKtG3pb5MaVIMvhx4Mw8dsRkr3Io9+b/y/cpwQ
         AyoyFH0peBEyK3RiU1BsRMBtc/3RQjunZEFXhSUr+KzvbLbit37d0sZ9qaASWAWvfjdw
         6jCPTx3ubianxl7SDvz8CuiWVQZkK8CIrV4TYXW43rtg9yFrWqbFa3xcKg2M0zp9/FPp
         P0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtseVxzN5o/guOVe4zJxt+CZRQTnRic71Tf67otw8Ho=;
        b=q1uqlh/JT4tteUuTuBdAamVvzIlEbaGtIFKwiYk7AqX/tLrQ3Jd8O+cQ0Lek5my44m
         476JSKZjhEp7GpzjbESLz/Z+37ZMlcHfVvGH3hISa5U8BAeUdl5TTIxMPydG0OzpvtQs
         OAy7Fxou856hzT9W19+V07EIN2WA6fy4Eo9oYH0kMylHRI2ZH3FA7f+9hDmSIB+KFu7U
         uUoa1V0E6PUXwKZywq+bijpioycSSLUrPSXcNcNtx4lspJgb4y62ipnwcciPgNhw0Voj
         h5Ema0wRq3n8GwhFzlyKH57w16xFxKIukGkwZMEs6/KFIK0fZQRpq50W4r8e5aT0pSSk
         acHg==
X-Gm-Message-State: AOAM533n0YQt7SDAV84reArxDOzJttWfmG1x1KWt/N+DXR3BqFkrd/dH
        wH3hkuY4EqCp2eohJmOLnnzax0PpR7I=
X-Google-Smtp-Source: ABdhPJypWCYpjt/CcLGJ9GQpo6HzF7D5MNQr4/mf3KH/pjILGAo6u2OxZ9uN/guw2lUP+7KUhULU7Q==
X-Received: by 2002:a05:6638:16ce:b0:332:44e:af98 with SMTP id g14-20020a05663816ce00b00332044eaf98mr5286705jat.112.1654899120477;
        Fri, 10 Jun 2022 15:12:00 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id k5-20020a026605000000b0032b3a7817b3sm117544jac.119.2022.06.10.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 15:11:59 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH v2 3/3] neard: Update D-Bus path and interface
Date:   Fri, 10 Jun 2022 17:11:24 -0500
Message-Id: <20220610221124.18591-4-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610221124.18591-1-puffy.taco@gmail.com>
References: <20220610221124.18591-1-puffy.taco@gmail.com>
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
index e03f981e0..77a4630da 100644
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

