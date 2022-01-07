Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E59DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiAGXhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 18:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiAGXhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 18:37:10 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0DC061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 15:37:10 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f138so7521691qke.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 15:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iUMN5cVbLalD6GdkR0RmXSa/ynSaZogXkq/HaZTRsBI=;
        b=qts0eRULEbgPVAcv7jxZVNNSvT38LdXCABIZLizTWus5QSzc2GBYmcSMQ2Z8xUnj8O
         2/NI/3rv0wajo89JstUgzXrQ2vvGST2MUo31u7XFpHBXQ/3pK9BVIxQOfEV8m6tbbVaL
         g5lh3mkRg9nCV3fpOBx6arXBBMbJDLpv1wqDGfZX9NT6hkKLKUd9okxYCsXTJMnWSENW
         W7YcQ0WUEADpK3p/FpYsjj8rXSNrNBAXUC8symEIIU/qf4g3cZ+9b4xylRKUG72sB5sw
         uZ7hryMJZGHnnOfwiprxUkfuxbWYWv2G5lSCpuZUR/sW2tGqhXHukEqx/ynwQYaAWZwC
         tfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iUMN5cVbLalD6GdkR0RmXSa/ynSaZogXkq/HaZTRsBI=;
        b=4NUBhAutKJWuYV1E55TpIP1Rv1K8ZiFNWgI5A9MuwedVbfmcsnHR3WhJnDif4OV4LI
         0EQ583Pdd4mwJKRBL7KB5PIKOO6yg1wQBhCTPdmXzLM6xhmMZxPeqfs9LSnlwXPqTUik
         IP0J6AfWxaDz7OvWG3Z5TxEAzEM6B0MfqW3n49U2rfVSg3xeYwSoRMTP2uE0nSisRUm+
         mQk0HesUPvnhbQbSqRcm6yjU07VpqT0euhWyjqkGSRXeSzw6LCFNsadIhgmwIOf4emXJ
         DMtRTLRRHBcJ69GdQE+G6Vedwo52bo/U4/WbY1d0pQargxfyjg7qSfpp77nVX4p6qqxb
         J/sg==
X-Gm-Message-State: AOAM530WzZLoJYQ5mBJ3Udi44OmYFsktUBM0/ttdqJ5gjnjp3dfSuFX+
        Dj3InRRE0LRveW7qiou6DtrnXvojDU0=
X-Google-Smtp-Source: ABdhPJyibVMCyq7IifaZMy9iwvtojCC/uML2j1bUXz01ycfj/fAj41o1Gk2k5F/Ykwxw39NsGe+0tg==
X-Received: by 2002:a05:620a:468f:: with SMTP id bq15mr27959477qkb.231.1641598629207;
        Fri, 07 Jan 2022 15:37:09 -0800 (PST)
Received: from [172.17.0.2] ([104.209.141.193])
        by smtp.gmail.com with ESMTPSA id az16sm67868qkb.124.2022.01.07.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:37:09 -0800 (PST)
Message-ID: <61d8cea5.1c69fb81.4eecb.0579@mx.google.com>
Date:   Fri, 07 Jan 2022 15:37:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5084989004377790345=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] tools/mesh-cfgclient: Fix typos in config storage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220107215003.115147-1-inga.stotland@intel.com>
References: <20220107215003.115147-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5084989004377790345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603678

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      46.48 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      9.15 seconds
Build - Make                  PASS      1768.59 seconds
Make Check                    PASS      11.95 seconds
Make Check w/Valgrind         PASS      492.07 seconds
Make Distcheck                PASS      258.59 seconds
Build w/ext ELL - Configure   PASS      9.54 seconds
Build w/ext ELL - Make        PASS      1643.87 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5084989004377790345==--
