Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 23:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbiCaXvP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 19:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCaXvO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 19:51:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EFA1BBF42
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 16:49:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t19so923040qtc.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pttW/lzNf36qtDPgfJLwRY8OeGMxIVaOk7hllpWFaZs=;
        b=UlPNW+ZmwfVkUNNLipAQqyhusNtH/pdoX0chipFfaIjAM4ksZEJPA/DTMJP9SoW5TK
         YD79kINroT+p0ZmDh53/YwKj2kS5Xy3/UOQaL92I2H72wKcdm8IPyeoCZ8jvy2K7esxa
         5AQqu7Nx4iRgxKuZfigGJ9sK72DsSDMf/MXiCVFYm5Hn/MZQkTy9HHJIfBBJH4cCjnwW
         PewFzQ4dlHl+DwrBULQdLDpJp+HkhfwARdUG+l4AvIFwh/PFZKlG6lvimfVxVg5DofNB
         KvDvJRu3z30R0jVECpoyROTaHIehzDEsbx0TzjnJXaAh5LCO2l7JSs91aBsPlse1ZR3N
         cwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pttW/lzNf36qtDPgfJLwRY8OeGMxIVaOk7hllpWFaZs=;
        b=47i9J5B6xpDtG0VanYV3T5cgCfW7X9CKsTgzixTeWvNud8M8dM/+Rpn76JxfsVvTGc
         M/gQmplWYNzIDkqu54cWMCq/TT5APIt5LEzNgHxUrUzzU6nOHcMKoK8FGQ2U1ELT0pTe
         rsmwr6hiKjT5pIEWYDoIX0XFn8gNdFYmm4vYhJejwTiliImnxAwk13ndNnI55snk+qbG
         FLvg3zGQII5RgOTWDmFlqavZ0THhWEakN1A8eiw0kO9NPgJlImnC5oDGq9omQIFc1OxS
         c4hgQihKoX/9xmq8qs3CBGBkDcl8XiE7nyxzU7ynphOu9+6TSNtO8/GGY+i4AZ4A2+sv
         1UDg==
X-Gm-Message-State: AOAM532V4RddMbyDuiX689SsOl9p+A/jMIHJSKTb/E1ZYAK1AKZBdM05
        kaJ02Y+olnwbr4N/f6fF5twAuRpY+iXY8A==
X-Google-Smtp-Source: ABdhPJwrHZfHg5Sb6PrVzZtU5eBDHQOm+ZhB5rizyG74A1XtAiuvJtyXh6sJtH9GLX1JlrAxY4PXjQ==
X-Received: by 2002:a05:622a:608:b0:2e2:750:ced6 with SMTP id z8-20020a05622a060800b002e20750ced6mr6714112qta.393.1648770564230;
        Thu, 31 Mar 2022 16:49:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.165.94])
        by smtp.gmail.com with ESMTPSA id f17-20020ac87f11000000b002e1e831366asm576887qtk.77.2022.03.31.16.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 16:49:23 -0700 (PDT)
Message-ID: <62463e03.1c69fb81.6a069.3f73@mx.google.com>
Date:   Thu, 31 Mar 2022 16:49:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1582044513734303548=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Check parameter for CIG related commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220331223207.3243206-1-luiz.dentz@gmail.com>
References: <20220331223207.3243206-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1582044513734303548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628004

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      1.06 seconds
Prep - Setup ELL              PASS      52.87 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      10.62 seconds
Build - Make                  PASS      1517.65 seconds
Make Check                    PASS      12.83 seconds
Make Check w/Valgrind         PASS      530.48 seconds
Make Distcheck                PASS      279.36 seconds
Build w/ext ELL - Configure   PASS      10.79 seconds
Build w/ext ELL - Make        PASS      1470.20 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1582044513734303548==--
