Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 22:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiDMW0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiDMW0u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 18:26:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F7E0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 15:24:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r66so3075215pgr.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFXCZQuqR9G+Tae11xI5XfHvIETyKNxgLX0a6177EzQ=;
        b=gGM2+jaP08zsDQRKjZ0Bdo7LCMSSIFs+KWm1a9ROpxXXKVOYtCuVSnANn2tU/mXJch
         llAOI+f2Mv+QuFKCpjAgwwh0XctXiRbDrhe825jTsjT14ueY/GMp9ScFSMa1ai0Hma5k
         yYHUX11bieYYQxhgOec+DIwo6kBolUlQHlb86+y7HvkjpeQ0n22p8cGawMOe5dM8kuVR
         0r39gXUCZXJDoiYEasVaT8WVdVy+vH4zyE53H8xYBcabJh0+9kDOlsNeOa/xRWfz6BZh
         O+4x8Sun08d4pq5S6icGBgQaoVm85VBsod4GU65HmeUoVxs0tBOAJNdVNXPLGc4FdSjB
         qcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFXCZQuqR9G+Tae11xI5XfHvIETyKNxgLX0a6177EzQ=;
        b=6Dh2HyLAQ9LWXiNQGMEQidjvIX5wqrp+samkI3g+8L8Y7xk/UxsE07SCnB4IGTKaYp
         KlgvK7NWMs6LzOMmkmZrIad8tom2AkrNH1PsUNhWDyo/mNgeVdn84Sk/aNGV+WA9nu2j
         f8oEtgrHQxISw2P9EDZIsn6881tnJIDNlbYkOjMRSGfgJRzIDdfshbRZVQM3zQh6hO4R
         W/lFqzj6x1hzz2g6t/yHQHjlN7vLKkWAtGYk4TadKMox5vVaWK6hMKb27BAQadPW9YeF
         jj5lw7pP/QfOwetSR3pFaE05LSvG4oQk+Tu3Yb7kTBVH9MFGSuFUck03wpFJ6Cxphfo0
         KOtw==
X-Gm-Message-State: AOAM530KqhMgtSboROWCqfpGybsUuk4kzYJLjz4TW/puMvQDYnL6AnMH
        k7FPszXS2Oblnke1M/ulH4+itLmO2kY=
X-Google-Smtp-Source: ABdhPJxFYURZ2NX5LPMo2LrJdummrlIn5Ubsk1+Cnv6L93YZL5hC+78E8OUbQ6/inumMveVbtiqt9A==
X-Received: by 2002:a05:6a00:23d5:b0:505:dfd4:2f33 with SMTP id g21-20020a056a0023d500b00505dfd42f33mr11886217pfc.59.1649888666294;
        Wed, 13 Apr 2022 15:24:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm90861pfv.48.2022.04.13.15.24.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 15:24:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] policy: Change AutoEnable default to true
Date:   Wed, 13 Apr 2022 15:24:25 -0700
Message-Id: <20220413222425.187199-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes the default of AutoEnable to true so controllers are power
up by default.

Fixes: https://github.com/bluez/bluez/issues/328
---
 plugins/policy.c | 6 +++++-
 src/main.conf    | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 48f5db7d3..0bbdbfc88 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -892,7 +892,11 @@ static int policy_init(void)
 	}
 
 	auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
-									NULL);
+								&gerr);
+	if (gerr) {
+		g_clear_error(&gerr);
+		auto_enable = true;
+	}
 
 	resume_delay = g_key_file_get_integer(
 			conf, "Policy", "ResumeDelay", &gerr);
diff --git a/src/main.conf b/src/main.conf
index 401796235..91b98b8c4 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -276,8 +276,8 @@
 
 # AutoEnable defines option to enable all controllers when they are found.
 # This includes adapters present on start as well as adapters that are plugged
-# in later on. Defaults to 'false'.
-#AutoEnable=false
+# in later on. Defaults to 'true'.
+#AutoEnable=true
 
 # Audio devices that were disconnected due to suspend will be reconnected on
 # resume. ResumeDelay determines the delay between when the controller
-- 
2.35.1

