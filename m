Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D32BC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 22:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIHWD2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 18:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIHWD1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 18:03:27 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC1102F
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 15:03:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h22so43996qtu.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Sep 2022 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=GIlPp3LcjRn2GcUA9XZBpL+1+3WfoLZYMdmQX2/y3gE=;
        b=OQkClkdVVSh62LDy63Hb2s/6PuJ2blZzmRkcwfC1/dbvV63StT+WXh96oDKFldyYHH
         CLei1rCfo6MSgHjRiTfH+hdTn0K21n2cD8XKHqgmF51BXahBvITh6LccQBsD1CScrlKB
         NrN3/3edN0YOaGLYhc0l0h4DB0v5TPEquNAkYKnkdlpTexABxrNF0pGNPbnRcjB+vl5j
         rJ/4y3WPfI6dew4wOrGiWo8Rq1PDj4jO6a5Xk0rkxAYfHLcvqM8ji4ABmRB5MTlUhtIr
         1rUCi1kCzR9SdDFcCxZ8wwPlEcN6GN0NOzzchFU4kP+48RRE71go941B5/86x8+jgrNu
         Dojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GIlPp3LcjRn2GcUA9XZBpL+1+3WfoLZYMdmQX2/y3gE=;
        b=Xz2SQ/yAgIrrd1eXK02aLcr7pxQIoW8J+FD6DRvOciXS7Lf8174SUToTWSpZEm7IGh
         LmTySfW+wMlZCB6+TLXZYdGN+o4KX61aFAEFMTdhjnWFntcQ75e6Mda+4B6RnLzDEg+w
         bqYLXO1pLsAVWfpt8ujvsy8KtZRXChIZBvqGHw3CzpJWx3vjv5tp/usEU3TN5ZmODsCK
         Iro01fsn2G/XXT5omFeB7BgYl2FmykFuBv3IYg1gAM+xadYg86JPnTH7UFFvcDGUJdje
         cbiPwe61U4P3wAG9PyUtAF2dQkixUWq0HNqowiBbYKK1adXzlEfD1dWIHoOhDm+eu+pb
         F7sg==
X-Gm-Message-State: ACgBeo0bza5aHgV55cFN2SlB0/tFGD3v8cfDO5Pbp/P95cySj3LpDJdG
        jBOXRUwWLvAgBA5Ywh0TPrc5ayCCev0=
X-Google-Smtp-Source: AA6agR4x1Ie36KNHiOocnMCd80yTcDpadp7GrEiFFNh0Bt5XbdcbIo0pYHnLrR1Yl25wQIdbPYY4Hw==
X-Received: by 2002:a05:622a:120d:b0:342:f643:3d6e with SMTP id y13-20020a05622a120d00b00342f6433d6emr9943442qtx.263.1662674604891;
        Thu, 08 Sep 2022 15:03:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.157.165])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006b5e296452csm19261586qkp.54.2022.09.08.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:03:24 -0700 (PDT)
Message-ID: <631a66ac.050a0220.974f2.2ff9@mx.google.com>
Date:   Thu, 08 Sep 2022 15:03:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7412063397849395052=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix HCIGETDEVINFO regression
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220908212135.3543626-1-luiz.dentz@gmail.com>
References: <20220908212135.3543626-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7412063397849395052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=675393

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      34.77 seconds
BuildKernel32                 PASS      30.00 seconds
Incremental Build with patchesPASS      44.14 seconds
TestRunner: Setup             PASS      500.75 seconds
TestRunner: l2cap-tester      PASS      16.99 seconds
TestRunner: iso-tester        PASS      15.79 seconds
TestRunner: bnep-tester       PASS      6.46 seconds
TestRunner: mgmt-tester       PASS      102.05 seconds
TestRunner: rfcomm-tester     PASS      10.00 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: smp-tester        PASS      9.55 seconds
TestRunner: userchan-tester   PASS      6.58 seconds



---
Regards,
Linux Bluetooth


--===============7412063397849395052==--
