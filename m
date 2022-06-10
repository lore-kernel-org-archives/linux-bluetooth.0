Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F66BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 02:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiFJC6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJC6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 22:58:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D86AA7F
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 19:58:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w21so22747482pfc.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 19:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YZFsXy4mlP/WMwwXapUojCAtz3Ubs3AxP2H2/dS6IKc=;
        b=PjnwAD8BdasolWNrRWIql+rKhMOpntHLsT/DbF6YDl2/T/sUbXU9p7si0PEJbF0Bjy
         y8Z/r/r1OUfaV0GNZPb7VlKh7NpWsH0P5hDJGhGDXbvyqjlC5vqjQcHRsEyYoeVPZiE7
         MVM4RguQyPx3BTkLaRV5HYC3CFouETbgZNTFQ1boqNB9Mxxti+K6hGj/IlYIlTz4/PIh
         sYW2TOuZIT3XRaq+nqoVDXx7R7HUxPMW4yXYgmsj5c4Hyc3hgSAhGutqIy6M7r3RhoS9
         BZBAmpTNETdWdYqzVIrK5LT/nTDxu848flj0Hze7r17wImuQr/KNxB4Opf9Ao3nfLqZg
         U6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YZFsXy4mlP/WMwwXapUojCAtz3Ubs3AxP2H2/dS6IKc=;
        b=5fWeHPdDZK9H+g0N3Ma1woUhjnUGd3LhzFJ9X9g+MCrgbRFyjH3/SQr4cAI308B6Rb
         nD+oU1aGQO7wyVOKFY18pfRQosrf5Sy1a2xJ66OD/K41U2Gsat+KbCDW5QWArUnHITTK
         CQYra7yRukAGzN6raJ9axiN8C/75PGHVVmYmp1ow0JHCt0QCu2aq2G3kxSBk45jEDGBR
         bUi2mOq0bJkQD5krgM2eKL3GWBXF864to8/Gxz+o2ufIIWRyVxPqkdoshnVU4RHJxYAm
         Rm9WAYNjMfRJjeCAmXmKVpLQD5krbOLWkv0ugs8mJD4nMpYoNdPIDlg9L7SQG8SbRONm
         lqIQ==
X-Gm-Message-State: AOAM532RY6oGWMZygP3KEMsc+p/lcmVQdOEdEvS/AGPi9iPJDP1We2rt
        rW2GuNiku/xTkv7p2et1vQrhkST0ty0=
X-Google-Smtp-Source: ABdhPJyMx6Knh3Mjh66K+PbDao7+Y7ASxDkO6XEWyD1piXvMvHionlCQfZkAgXI+hG0xm4PAwKvNxQ==
X-Received: by 2002:a63:81c3:0:b0:3fc:c510:1a3 with SMTP id t186-20020a6381c3000000b003fcc51001a3mr37641214pgd.581.1654829932019;
        Thu, 09 Jun 2022 19:58:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.118.73])
        by smtp.gmail.com with ESMTPSA id z41-20020a056a001da900b0051b62689ec2sm15287616pfw.129.2022.06.09.19.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:58:51 -0700 (PDT)
Message-ID: <62a2b36b.1c69fb81.3185b.c6ff@mx.google.com>
Date:   Thu, 09 Jun 2022 19:58:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3659139241535135992=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: Bluetooth: btmtksdio: Add in-band wakeup support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <742cdffcf110e1601257207fb2b0d3f426d4008c.1654819586.git.objelf@gmail.com>
References: <742cdffcf110e1601257207fb2b0d3f426d4008c.1654819586.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3659139241535135992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649029

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      31.50 seconds
BuildKernel32                 PASS      27.88 seconds
Incremental Build with patchesPASS      38.46 seconds
TestRunner: Setup             PASS      476.73 seconds
TestRunner: l2cap-tester      PASS      17.07 seconds
TestRunner: bnep-tester       PASS      5.76 seconds
TestRunner: mgmt-tester       FAIL      104.69 seconds
TestRunner: rfcomm-tester     PASS      9.32 seconds
TestRunner: sco-tester        PASS      8.97 seconds
TestRunner: smp-tester        PASS      9.20 seconds
TestRunner: userchan-tester   PASS      6.01 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 104.69 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 491 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Add Advertising - Success (Name+data+appear)         Timed out    2.360 seconds
Add Ext Advertising - Success (Name+data+appear)     Timed out    2.572 seconds



---
Regards,
Linux Bluetooth


--===============3659139241535135992==--
