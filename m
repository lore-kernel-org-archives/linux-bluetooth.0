Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA7DC49EA5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 07:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06B261482
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 07:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFZHKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZHKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 03:10:30 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CABC061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jun 2021 00:08:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g19so6434393qvx.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jun 2021 00:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bgPQ/I1PyczwSWemyC70fSa9eJYC6ssRzGVT00fANE4=;
        b=aFc0pyS82pW7ZvtvgtOM4cEKsUaJDbCNyL85exNxv8jzljtWEWqDXaXa3X2kn9N1Bl
         Zh1nmrkljkASSeJROriZql2yE0sdTWy1e1st0SemHdZAfD0iSPe2LOXiNTWaEAyWv1bT
         q2zWFmQk8HBrmpMQfaTKkZczSKBWLtkuW4sTXsZeOUFxfegH4xthxXaD19LK8rWKJwIi
         kZCHbcWVLRYOkZX8rLzZKdpAXoQ7owy6pZez/J3GrAsGtDmNVTx8o63DITqrON2qg/FD
         YyJQGKnMg+PihDWJZNRB/mpWLIq3euxqyUzUnIkO5r1QUbS+xagnsoGAE1yUWZSZQuGj
         NvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bgPQ/I1PyczwSWemyC70fSa9eJYC6ssRzGVT00fANE4=;
        b=SWayr4AVzZNq0/3+/jYxtSMi3+zM687PnGOdYkVCwn4L/i1RQzz1m4QwHoVwjaemqw
         hEqCHjqFoj1vJNWCD8myHzm9AMPrqDcUP3W4xzT3tyVwdhocN0octxmj7UNrwFUoyziD
         CJiuEebYzDWayvh0riQU0/t+VKuB4lsYYvq5xCpYX062tepi7huybTk/SpZQ2f7j9Dyr
         xYvgdvEx8qUbo8rK9PU4WEI13k9hYKU1GTWNTWNFHAvgbOwSAHleWwwjgignPqkvsKzL
         jIauOuVgWbV77Rqyu9zcvC40DlLiEEoG+EU0dCDXdi6sk4k9ZzoUPQ762FnAgzNFpfow
         6LOw==
X-Gm-Message-State: AOAM532ZTYGJd5Ysj9XQUOSynkI8FBJu3S+rCWUzdkYCpG5rUF0nCCN/
        +ZuSKX5wRkZdkhY5gZazK3cjb2JEpVJ2Vg==
X-Google-Smtp-Source: ABdhPJyXX+MvhAwJoTYz1Au/88nBIDqy/h0eSMd4pq6iDcyk6zLcp4OkMgsVlXr53zX07n4Vtbe/Nw==
X-Received: by 2002:ad4:54b4:: with SMTP id r20mr15029720qvy.13.1624691286206;
        Sat, 26 Jun 2021 00:08:06 -0700 (PDT)
Received: from [172.17.0.2] ([137.117.103.188])
        by smtp.gmail.com with ESMTPSA id i185sm2199211qke.34.2021.06.26.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 00:08:06 -0700 (PDT)
Message-ID: <60d6d256.1c69fb81.2de6f.dc33@mx.google.com>
Date:   Sat, 26 Jun 2021 00:08:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3551940365947810053=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v4,1/3] emulator/btdev: Update the white list and resolving list size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210626063010.152987-1-hj.tedd.an@gmail.com>
References: <20210626063010.152987-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3551940365947810053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=507457

---Test result---

Test Summary:
CheckPatch                    FAIL      2.14 seconds
GitLint                       FAIL      0.35 seconds
Prep - Setup ELL              PASS      46.45 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.02 seconds
Build - Make                  PASS      202.40 seconds
Make Check                    PASS      9.53 seconds
Make Distcheck                PASS      239.28 seconds
Build w/ext ELL - Configure   PASS      8.24 seconds
Build w/ext ELL - Make        PASS      190.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
emulator/btdev: clean up the queue before closing the test
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#20: 
==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)

- total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] emulator/btdev: clean up the queue before closing the test" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
emulator/btdev: clean up the queue before closing the test
17: B1 Line exceeds max length (87>80): "==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)"
32: B1 Line exceeds max length (87>80): "==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)"


##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============3551940365947810053==--
