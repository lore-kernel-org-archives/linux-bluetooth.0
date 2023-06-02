Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0BC7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 21:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjFBV7Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjFBV7Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 17:59:24 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421AFE4E
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 14:59:20 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a28817f70bso2049698fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685743159; x=1688335159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TFXlzk6DH3T/qYZYUN0IaGccS5eT9Uts+h6623jJhC4=;
        b=JOlsTD/joo9uW2UcHfNCMIYXfDT5CU9m5Bhuz/RE9kYkduQFRsQHCMmb5R4tPlqdhA
         spmn4Qjtv0AcKUkcC1UxloZuOX1+aA6e8D53ALrnsuOtE9kT3R/Nq+u9IWlZxH6MMLN8
         EoItsSVogtJzsLVZ2zIeChLfA06ZexV/w77DZHDfPuN2aAv2VBr7bw5EoUS/Mczb46lO
         89iwP3Blbjgi/BbZ5G2vydEkinUCEbRomUdyCasK2IOq8PJLWJhDR5995hkTOT1Mzaog
         rBQYXmrnIf9pO43eXUOWh/4ujisLGAxvbOVJmQ8Hxn7yae7lXF3uMj83irEJRRWrcHKL
         KpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685743159; x=1688335159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFXlzk6DH3T/qYZYUN0IaGccS5eT9Uts+h6623jJhC4=;
        b=LHma1Fydirw499X5za+EXbKIr4Rq1zlnnReM/j0U7P1ePAxhjOdWaX0YHtxdxRtG7F
         PGgrJPf5WsyCVNGuGs0L7VTuXBQuhW7BtEqXIsbeIUS+9x3m7ztZokxMymZqwMiOgHEn
         ssgWhPz2i5ZQ0NMz919PlccAsj9CtFSNKswGZrjUwftDLfU2chqepMgAqUrlh0cGiwQ/
         ot8XcGVtSZ87MApvNv+4IkmKIfwrOcDm/yPbbJG2IEXcTFVch5m42KwnS30GjYZQautG
         tlANVQ4XfZJImvbHAwsADsuMUPMmtkOKF7OF4rW0DmdzgW2YbaLvGLYO2f5EdblPZ+R8
         bFeg==
X-Gm-Message-State: AC+VfDyRk1DD+NsOjJP6jVKzxJ1vXk4blb8g/p7DjhEA9PAZEt+iOSfS
        45mZ+joisGT2Hx4DDi7S8J0dZFwWnDA=
X-Google-Smtp-Source: ACHHUZ7dqgSN0Pc8I2rdupk7S02HI1GaSTZcCUVXcIE+Dix2LQJI6A7UNgoLsKBVw2b3KEqQH1tJjQ==
X-Received: by 2002:a05:6870:8681:b0:1a2:9d72:2703 with SMTP id p1-20020a056870868100b001a29d722703mr2566156oam.19.1685743159319;
        Fri, 02 Jun 2023 14:59:19 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.136.39])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056870769a00b00172ac40356csm1059464oab.50.2023.06.02.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:59:19 -0700 (PDT)
Message-ID: <647a6637.050a0220.77d1.5e88@mx.google.com>
Date:   Fri, 02 Jun 2023 14:59:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3706987005840995745=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_event: fix Set CIG Parameters error status handling
In-Reply-To: <d7b290a2d4a3acc77feb10873d28c5c62f26f5ae.1685740877.git.pav@iki.fi>
References: <d7b290a2d4a3acc77feb10873d28c5c62f26f5ae.1685740877.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3706987005840995745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=753675

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      35.49 seconds
CheckAllWarning               PASS      38.63 seconds
CheckSparse                   WARNING   44.13 seconds
CheckSmatch                   WARNING   119.45 seconds
BuildKernel32                 PASS      34.45 seconds
TestRunnerSetup               PASS      504.55 seconds
TestRunner_l2cap-tester       PASS      19.10 seconds
TestRunner_iso-tester         PASS      26.91 seconds
TestRunner_bnep-tester        PASS      6.74 seconds
TestRunner_mgmt-tester        PASS      130.53 seconds
TestRunner_rfcomm-tester      PASS      10.60 seconds
TestRunner_sco-tester         PASS      9.67 seconds
TestRunner_ioctl-tester       PASS      11.45 seconds
TestRunner_mesh-tester        PASS      8.50 seconds
TestRunner_smp-tester         PASS      9.65 seconds
TestRunner_userchan-tester    PASS      7.02 seconds
IncrementalBuild              PASS      34.68 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3706987005840995745==--
