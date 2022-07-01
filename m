Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 09:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiGAJRr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiGAJRp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 05:17:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F634D174
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 02:17:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h192so1897382pgc.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=q0hwFSh/nsyvBsEt/Ow2enVFIdh7Ev7k5f4DG74Bx/s=;
        b=krZcpxNlnVdvrbWlKtCpYHP9vUiJVynfXj3RSsW110dmBy8dbk/CbBkRxrMmUXLAyh
         vX2rvbKIK+LQphWcfmRHhvTLOzLQSWL1JcMgRkVsxMckOM6oovUY86OocZ5fPLbtfCkt
         /c/8Y0O+ofhrCQgvVoCWFT6S2Dji5ggDuCsGAPyL1Pw2EVnVrZi0G3Ha/OEzeLFUqcnv
         TnbFeaL/H0EOViOYQmEwskuROq2YDZVQWJce5DVbI/worHa0BAvCcZTMDa8ADua+QaWZ
         w+aW/HSbubtpgfov4dxdhqLE2fIjOpbbERDRim+cC+gLOKzEvjprgeKj87UWtJLdJZu9
         Wphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=q0hwFSh/nsyvBsEt/Ow2enVFIdh7Ev7k5f4DG74Bx/s=;
        b=r9IY9hadfiVckWx6NZuAkY+uTkee+O1s1oEkd/53yvoZ2bIFtr3DOdezsDYeX2ecQF
         U5mHQUIy+Uz3K/0S1wehrv9yYeZYjCwdPgAv/qsnnKwFuo6/KlghxeMkp4A4snUehcJU
         8EV8baWG3LrEo/DRgRG4Ec4CTy7Zvh9M2q6ftjNzORl796FocEW7rrxDi542YMZtonYP
         1h/f3TsZxCJrRDJE8epPAf+dGJZwfhZ3n7VXgbIH2ZWeicGRXQdGqXkZo5U+CXN3Tskp
         sVkVjx6X2ANVWoUGyFGIC08CohUK77ZLSTzVyq/WZD8f7qfv0/oCsPXNL/6AScQqZ6CF
         54Zg==
X-Gm-Message-State: AJIora/U2OpX+WC6/RSXuoxwLiyMPfeoM2SVFFG8/LesTnt1nCWkMO+3
        tdwkmLj8JLvvnQPU2oA5FBs+35ax+/Q=
X-Google-Smtp-Source: AGRyM1v6xfJU9ZXAQGb+YsiN4OLtpxmEYo3WKoEIItNF8/5LA32TYesq9J6ObAMSkMHWi88fKMbfwQ==
X-Received: by 2002:a05:6a00:1a09:b0:525:a0d:d1d3 with SMTP id g9-20020a056a001a0900b005250a0dd1d3mr20267427pfv.27.1656667061676;
        Fri, 01 Jul 2022 02:17:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.74.254])
        by smtp.gmail.com with ESMTPSA id v16-20020a170902e8d000b0015e8d4eb24fsm14932562plg.153.2022.07.01.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:17:41 -0700 (PDT)
Message-ID: <62bebbb5.1c69fb81.c6b26.5b9c@mx.google.com>
Date:   Fri, 01 Jul 2022 02:17:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6402488156249592839=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix crashed after cancel the on-going transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220701080601.3010-1-wangyouwan@uniontech.com>
References: <20220701080601.3010-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6402488156249592839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655700

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.48 seconds
Prep - Setup ELL              FAIL      29.22 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      10.80 seconds
Build - Make                  PASS      1151.93 seconds
Make Check                    PASS      13.56 seconds
Make Check w/Valgrind         PASS      363.71 seconds
Make Distcheck                PASS      308.78 seconds
Build w/ext ELL - Configure   FAIL      7.36 seconds
Build w/ext ELL - Make        SKIPPED   0.15 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   664.12 seconds

Details
##############################
Test: Prep - Setup ELL - FAIL
Desc: Clone, build, and install ELL
Output:
writing RSA key
writing RSA key
writing RSA key
writing RSA key
writing RSA key
make[1]: *** [Makefile:3241: unit/cert-intca.pem] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1262: all] Error 2


##############################
Test: Build w/ext ELL - Configure - FAIL
Desc: Configure BlueZ source with '--enable-external-ell' configuration
Output:
configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
configure: error: Embedded Linux library >= 0.39 is required


##############################
Test: Build w/ext ELL - Make - SKIPPED
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
build_extell test did not pass

##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
gobex/gobex-transfer.c:420:7: warning: Use of memory after it is freed
        if (!g_slist_find(transfers, transfer))
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============6402488156249592839==--
