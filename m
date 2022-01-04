Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1E7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jan 2022 23:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiADXfo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiADXfo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jan 2022 18:35:44 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0444C061761
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jan 2022 15:35:43 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id i187so34424650qkf.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jan 2022 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XSkKxTmFC1B9ntcJdcvP9UYqICcNUEB+giz6ITmiBZo=;
        b=UNR7hpuVSG14jn1k26k8SN1TUa+Ljdd3n/yCuBjfnWzery/AYTD38zc/mRMlGL1jvs
         DRmlNuohQgKkse80tdJt7xcVAcsnpYpFnauU8iyMWCMIB5HLORBp4w7ZBe69IVekuwA/
         uUROnmJWIiphWcNwu8TUDesDrUcVqj1/mA8ENAm5Vy6Pn+U2OydvsA6g4yTH3MbfzLJc
         FuXB1xBu3h0h/3crEbCt4OeIIae3UVFGnavETYfIw2ym3o8bp2Mpy3Zeuhi6zMHUGKu+
         dCJjegDMdbCVDTugd8Gtvgy2NcLQH7dsdlmGVfjHQlfAaL/3NLGYy8vCUrqNJTWEzEn6
         aDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XSkKxTmFC1B9ntcJdcvP9UYqICcNUEB+giz6ITmiBZo=;
        b=CuUvfojfzdQ/N0EKaHU60ra7e4EAvU8W8jJw0+m17LYQ5HKfHbuLiuNO90lXouNmtg
         7ENEA1MV1Xy+fO7auyNaq6ZQZf3q7IBYhrkT03vfYpHaW6KHox41tyyWMMUHNvhrJ5wW
         mwNUN/2AGY/uy2pvfoNPKsvc81oI2ViM9y5f+vyAKVLUOERYN+uIM+RvUKIvGiPxxSDp
         +lrRhLGVVRlGDfuk88nX2/+P/wIg5ZoqldnXNw7+Fp5V9DXyUwzqRQT52GjY6qOegwjI
         HNRiXYtfyaTGM9Cx9Bkf4ZIueQSVvbm44pnioUwtNeUYvPwT0zrXHqjozknHbd58ah8l
         lDFQ==
X-Gm-Message-State: AOAM533k27nM9fIcM0yEd5ZhVn2Ug5qd+VtNGX2sdvuZk9TOoI6yZUqB
        w+PJXJHvois0jxTAdWGSpWtY0LbPf1LBiQ==
X-Google-Smtp-Source: ABdhPJz8p7zAihwJEzv+vHOi3ensaXKNg+0eXbJVnDGZq51JcO8vXvUw+ZpzzCo1OQJvxKJkb9+IFw==
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr45579383qta.305.1641339332444;
        Tue, 04 Jan 2022 15:35:32 -0800 (PST)
Received: from [172.17.0.2] ([20.119.234.78])
        by smtp.gmail.com with ESMTPSA id m4sm378099qtw.27.2022.01.04.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:35:32 -0800 (PST)
Message-ID: <61d4d9c4.1c69fb81.5df0b.2157@mx.google.com>
Date:   Tue, 04 Jan 2022 15:35:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5761540908139170604=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] emulator: Add support for vendor commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220104225635.2997485-1-luiz.dentz@gmail.com>
References: <20220104225635.2997485-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5761540908139170604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=602722

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       FAIL      0.90 seconds
Prep - Setup ELL              PASS      42.06 seconds
Build - Prep                  PASS      0.57 seconds
Build - Configure             PASS      8.51 seconds
Build - Make                  FAIL      187.79 seconds
Make Check                    FAIL      0.66 seconds
Make Distcheck                FAIL      126.19 seconds
Build w/ext ELL - Configure   PASS      8.29 seconds
Build w/ext ELL - Make        FAIL      160.94 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[RFC,BlueZ] emulator: Add support for vendor commands
14: B3 Line contains hard tab characters (\t): "	."$........"


##############################
Test: Build - Make - FAIL
Desc: Build the BlueZ source tree
Output:
emulator/btdev.c:37:10: fatal error: monitor/emulator.h: No such file or directory
   37 | #include "monitor/emulator.h"
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:7272: emulator/btdev.o] Error 1
make: *** [Makefile:4302: all] Error 2


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
emulator/btdev.c:37:10: fatal error: monitor/emulator.h: No such file or directory
   37 | #include "monitor/emulator.h"
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:7272: emulator/btdev.o] Error 1
make: *** [Makefile:11306: check] Error 2


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
../../emulator/btdev.c:37:10: fatal error: monitor/emulator.h: No such file or directory
   37 | #include "monitor/emulator.h"
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:8003: emulator/android_android_tester-btdev.o] Error 1
make[1]: *** [Makefile:4302: all] Error 2
make: *** [Makefile:11227: distcheck] Error 1


##############################
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
emulator/btdev.c:37:10: fatal error: monitor/emulator.h: No such file or directory
   37 | #include "monitor/emulator.h"
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:7272: emulator/btdev.o] Error 1
make: *** [Makefile:4302: all] Error 2




---
Regards,
Linux Bluetooth


--===============5761540908139170604==--
