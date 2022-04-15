Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbiDOWd3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiDOWdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 18:33:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DACB85BED
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 15:30:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p10so8063761plf.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b5Twos+p4hSu1P5iPCm13kYMd+uhzpPNeflKVvMpzNE=;
        b=PjoZsgdYB0kcBtvQUbiLxBqLIpl+5MXjfm+OSluyJth5cUBpJ/+8wsyMDzdrdSQ4Xw
         BpXrogPVHEKPIe580Pt/DHkevp37M1dgdiR9LGfTgrzu+SaHT+dIlZfcKNE6Yse0UsQR
         lc/Eteb02Mnaqvd5NcxovzsCL3i2WDm4Gi0Um5FALg8E3O24t6S1BANC2C9NiBKTaqYA
         oE/LGKVQsAt9WlDffnYTvn2wrI681MhbLuCUFO5SeulurYHbfb5gKvHnveGFMP+tSSt3
         uinEr+4QgBKVBDrfJHgjRDIoMkZsQ34EPEYNBHq/SyYQtD/iJbE+emut/4i5T3g/HYo2
         yThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5Twos+p4hSu1P5iPCm13kYMd+uhzpPNeflKVvMpzNE=;
        b=XfS38A17CJ8IPehzjF++C16wgyDEi96Cx5L6DO6EVuwDd2QTQetEO/f/FBUHNrchJV
         QInncGlIELUnGnNMsZVkgkqqnQMcUvXatSCe6YBlkW7k7qRNQHDG5GX4y5ZeZtgkvR4a
         ymuVVuorHOil0zZGV9+7FXSyV42pff1GeWz1LRxeCrO4C/XWn7zuhRXGaV8/tEVduwcl
         Y4I4VmR3efYP1QfWY43geC2WgRCnodLWYKeIU8nSwnjrYwR+pmRtoG76MnmNi2aZCKN1
         NpmQ/niV9gD8uRVRSTmtY3kMDCx3Jpp+ftMAjgXjhT2TwooNl2ZoHDXgT8d5USQGAHMU
         rFkw==
X-Gm-Message-State: AOAM533nbw3JB1AIepXj68CVtSC9CxgKGBCNu9UE4896m3YHigHnRY0v
        AD/U3GoYXUafuuJVJAgoncYg2DA2Juk=
X-Google-Smtp-Source: ABdhPJxOkV5VsP0MJf7Cl0KcBT8yzYfLZ/UJBkQEWz7G7mSEUbxdlL/iKlgXzRHXTXpmbHECllR7HQ==
X-Received: by 2002:a17:902:e8cf:b0:156:36e0:6bcb with SMTP id v15-20020a170902e8cf00b0015636e06bcbmr1090077plg.105.1650061852610;
        Fri, 15 Apr 2022 15:30:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t38-20020a634626000000b0039cc30b7c93sm5132594pga.82.2022.04.15.15.30.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 15:30:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 3/3] build: Make use of StateDirectory and ConfigurationDirectory
Date:   Fri, 15 Apr 2022 15:30:49 -0700
Message-Id: <20220415223049.1155838-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415223049.1155838-1-luiz.dentz@gmail.com>
References: <20220415223049.1155838-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of StateDirectory[1] and ConfigurationDirectory[1] to
inform systemd what those paths are used for instead of using
ReadWritePaths and ReadOnlyPaths which can lead to issues.

Fixes: https://github.com/bluez/bluez/issues/329

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html
---
 src/bluetooth.service.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f18801866..4d39ad49d 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -15,12 +15,12 @@ LimitNPROC=1
 
 # Filesystem lockdown
 ProtectHome=true
-ProtectSystem=full
+ProtectSystem=strict
 PrivateTmp=true
 ProtectKernelTunables=true
 ProtectControlGroups=true
-ReadWritePaths=@statedir@
-ReadOnlyPaths=@confdir@
+StateDirectory=bluetooth
+ConfigurationDirectory=bluetooth
 
 # Execute Mappings
 MemoryDenyWriteExecute=true
-- 
2.35.1

