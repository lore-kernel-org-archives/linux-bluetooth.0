Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED11ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 20:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiIAUCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiIAUB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 16:01:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987895ADC
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 13:01:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so50656ilb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Ni6mgJP4drMLYcf7FeYNDG0fOps1GutqULH0h2wfnPg=;
        b=MAvm5Rhe0oJUaWhuo6+NYoGZgdQPVBQ5lwr42UMmwfyzSTJ+D9LCx/aYzDQBYQF0Fs
         0RtArqotnfSAkt+huvZ016CQ7dpJr/wmaRmK8o9sYaFdJ2PLIVjETQ60n0Ou2zPkByVV
         f4EF5uGMuUdIIgoM9z6vtWcvt43b1sYT5vASxWBwnsRsim0Q1Bq+iu3U9HwG/PHjnhkL
         uVH53u5Pc+eMOqbKr6BZHM4ZWPmNtQthabucSgcEOw6Lme7+f2s8P4YDxdhjUeq9lBMf
         GIXaTu9wPZFS8toat8nCfSCRGJb3QVxNOdgjlGG2KqYSLE98FM40vkto1NQpMD5kqPsR
         BmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Ni6mgJP4drMLYcf7FeYNDG0fOps1GutqULH0h2wfnPg=;
        b=njxQhgUnkmeS5nFictdRg+IVcGort4QKtfoWKlltpKnx8hZ27eURpx5+9yyPmAtGBW
         zL0y/lfcBNZiCbudT4tHo3lnPsnlhyDwZlbHEU/uZXLeNN8B++Xp4jVbAewq4YWl/CcS
         c32ftFyEDu4RuEf6GMr4F3Wry5WUel1UAdnd54gmhOSW/YVai8HtOCwRhN9GHgtOUP3S
         /nzuWR0AXAiXRkMm0KQsGbbxMZhotaT2STa7+CGzkVzAxsvN8MEjop0kLnEj/ymdVDHW
         mf88pXYl/SonkdgLVRympvoYAM5M7gLebVzwB69ed19nb0cE0G7YF/c5wLQPUrFoow/6
         6EqA==
X-Gm-Message-State: ACgBeo3FtMhZG5Jf0cc6MsGGbfTWG6CHcm8pz7ntNUe2i6e6jda03aoB
        MdmEzO6lxYwBKsQ4BJghOYVXyqBYOGM=
X-Google-Smtp-Source: AA6agR55T+PAPr4lUZc5D8SARbSf1p/gpXrS2TbcoKF7W9r+QRfexY4JSHS8c4oKUBhrwDWT2fnENQ==
X-Received: by 2002:a05:6e02:1bc4:b0:2ee:4e77:3b05 with SMTP id x4-20020a056e021bc400b002ee4e773b05mr660002ilv.3.1662062517093;
        Thu, 01 Sep 2022 13:01:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.203.184])
        by smtp.gmail.com with ESMTPSA id t27-20020a02b19b000000b00344c3583535sm19434jah.94.2022.09.01.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 13:01:56 -0700 (PDT)
Message-ID: <63110fb4.020a0220.2c306.007e@mx.google.com>
Date:   Thu, 01 Sep 2022 13:01:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1069111321712273368=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220901191914.22706-2-brian.gix@intel.com>
References: <20220901191914.22706-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1069111321712273368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673367

---Test result---

Test Summary:
CheckPatch                    PASS      5.17 seconds
GitLint                       PASS      1.70 seconds
SubjectPrefix                 PASS      1.38 seconds
BuildKernel                   PASS      35.54 seconds
BuildKernel32                 PASS      30.46 seconds
Incremental Build with patchesPASS      70.95 seconds
TestRunner: Setup             PASS      497.18 seconds
TestRunner: l2cap-tester      PASS      16.67 seconds
TestRunner: iso-tester        PASS      15.35 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       FAIL      97.94 seconds
TestRunner: rfcomm-tester     PASS      9.52 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.31 seconds
TestRunner: userchan-tester   PASS      6.34 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 97.94 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.088 seconds



---
Regards,
Linux Bluetooth


--===============1069111321712273368==--
