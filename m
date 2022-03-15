Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2C6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351434AbiCOTIZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351420AbiCOTIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 15:08:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448E13D
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 12:07:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s11so56803qtc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2fH4t10b5PThePRd0mDb2l/IoOJojKIPIizn4tGURBs=;
        b=SfR8rLfOVMlGUtT04V3Vv+jdlQpQ4ZFeUkeze5YzgRcS88sYKldioLaxXVytTFmt4H
         Yeyo6thweaYlvmtetURyWNc3fJ5zbCqPzCpLQJj2mG/jkMlHpzy9yn41qIp3V0HAgDZH
         z8oIBPdo2LjlATls0JFbIeJPX8NhuzPnEgFV9iplVCYyJsHXSn9N4ntK3ox1bux9ZuYH
         hVmnNJ2mY/9B7f573zcuf3vI2MG46g6J9USjH9CZjzo+eZvCfl8XKUTwSs4lE9e5KIbX
         5XZpqNMLLHYEbBNhnT/XUd1+47fscQfuav9AQS0hhJCM636iaJK9Dy1NS1JEcZ2BWVp6
         w0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2fH4t10b5PThePRd0mDb2l/IoOJojKIPIizn4tGURBs=;
        b=JUzuD5MM1FkqYzkc56hjLviWspR/vfoeXrLo4pGiWKtjRuvCfRFCRCt6AvQuEluyxe
         dOZZtoomFhq4bCfe5INaHdHx0zYU8uj4R2xM/h0/BGYoBaADoGFSpB62/ikyKuhcLuTm
         DeCCx8jdEAvb5XW18733Rz76PLRgEhs+B+iRPD1jqC2TXWuPNu1oB/WUnSTg8QQ5/txo
         r522qVY+bAs7VjX2DOMq1jJDDICeWGH+2Xq4f944mI+S3INs/Ib1Avtah9itcuViSpmh
         aEoVkG2pT1WVQdjgQPKT19BRSHKHBk2VV/HH9WjM0ZUKmElTuKs/uJEZOVwnvETkQSBQ
         jx1g==
X-Gm-Message-State: AOAM530kAQwZhhR2KhX6zJ1FnwfMFFQyQ1TnUUs3a43BL2mqgdemqbHc
        8YtwSCHgpTls27Mi6dmkS+gqYHYB4ZQ=
X-Google-Smtp-Source: ABdhPJwGd53jL38ZQZuKuY6NSaVGLr6aNNZklgjmYPhcM039hdg4rtrOeS0zs8xsR9MywoLFW/87jw==
X-Received: by 2002:a05:622a:1386:b0:2e1:e812:f4c with SMTP id o6-20020a05622a138600b002e1e8120f4cmr1137895qtk.653.1647371226543;
        Tue, 15 Mar 2022 12:07:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.87.251])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1404782qki.33.2022.03.15.12.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:07:06 -0700 (PDT)
Message-ID: <6230e3da.1c69fb81.5565d.936d@mx.google.com>
Date:   Tue, 15 Mar 2022 12:07:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6036409427635317485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [RESEND,1/5] Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <7b4627d5017be2c26ded9daf7fd297bed6614852.1647367024.git.objelf@gmail.com>
References: <7b4627d5017be2c26ded9daf7fd297bed6614852.1647367024.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6036409427635317485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=623609

---Test result---

Test Summary:
CheckPatch                    PASS      8.10 seconds
GitLint                       PASS      4.93 seconds
SubjectPrefix                 PASS      4.21 seconds
BuildKernel                   PASS      33.61 seconds
BuildKernel32                 PASS      30.33 seconds
Incremental Build with patchesPASS      66.22 seconds
TestRunner: Setup             PASS      530.30 seconds
TestRunner: l2cap-tester      PASS      17.09 seconds
TestRunner: bnep-tester       PASS      6.59 seconds
TestRunner: mgmt-tester       PASS      112.55 seconds
TestRunner: rfcomm-tester     PASS      8.57 seconds
TestRunner: sco-tester        PASS      8.52 seconds
TestRunner: smp-tester        PASS      8.35 seconds
TestRunner: userchan-tester   PASS      7.19 seconds



---
Regards,
Linux Bluetooth


--===============6036409427635317485==--
