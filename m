Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CEC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9A6613BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEDLhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhEDLht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 07:37:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B32C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 04:36:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g13so4727008qts.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9631inc1XsM+v1S7ELn+A0kOt1I1iZ7e2ugbNmlxmmM=;
        b=ULppVF8+BHxh/rkZp7qllySV+SBXwc5/b3BuJjrNcaGoo9vF4j6DgZQxTEhq5MTVZ8
         +lppEyDTv1qnq6cTvSSRaSplLFtN1Z+0sy8wo9Z5ruYicyCBMsAfd6m5bEyhVeEMh+Al
         mSOuT+A1YJxnIvGIfADzU+AjODgnJmKicCCg5RY3L+8YatIKkWYK9escJLzApk7KDKMh
         hTvJrfN/LORTF5BcI83UrDjK44GBHTSL3YFlgcNG0JlQXawaB2V/AitIqtB1xrqTvjkL
         kr6pkG3vCwJExOhTt5EoxDC0ONGM46I4cjnJO0Rq5ZOG2w9kPGMnaAkIfNELCXuQ8TXM
         wegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9631inc1XsM+v1S7ELn+A0kOt1I1iZ7e2ugbNmlxmmM=;
        b=mvDn1CdIROxRixxbgv931CPIWDUrGyVxjiH6ri0RxVMabUkZymbRon/PQTt64xadAl
         VuTH/G5pEm3pPZWz4VMQP22sBG3CgYJe5We9zQQHh3Ns0E4Y2YLwJe89ANTbK6HKNokW
         ptEqzhMkF0SzA5zxlNXgeihBmFowID0e9akrEzY4K1Z8Kv5zq0BLegPAoCwxhGHW+Rtf
         Bcyfigqu47+r8Qg0J7yViwAiZZ2AeLuAoqT16SIrCOjg2eTcyM2sCgP9/rRQhVgpfCPI
         RujP7P6hlRnqyuKh597bRZVxdwlpc/1tGO61+/eaG890yyM8oA0ngQfSnEjiwJAOybxV
         4GYg==
X-Gm-Message-State: AOAM533IPoBipv2AALsYc3E/GYfFg/g977XUkSpA3GWZQvG1AACKTqw8
        vQsYmJH6PA9kRe8aovp2j1aJyd/Ix76Hrw==
X-Google-Smtp-Source: ABdhPJy3ubb18QXbizhLVFLDq/5gLs/i0pEBrgzYgslLn5kkuTxi02PrSfk7TNalomPwm50I1s7dGA==
X-Received: by 2002:ac8:543:: with SMTP id c3mr21339307qth.241.1620128212859;
        Tue, 04 May 2021 04:36:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.97.170])
        by smtp.gmail.com with ESMTPSA id a20sm10854268qko.36.2021.05.04.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:36:52 -0700 (PDT)
Message-ID: <609131d4.1c69fb81.c3723.e825@mx.google.com>
Date:   Tue, 04 May 2021 04:36:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8598383681515506918=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [Bluez,v2] btmgmt: Fix enable adding irk when turining privacy on
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210504111454.29697-1-sathish.narasimman@intel.com>
References: <20210504111454.29697-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8598383681515506918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476815

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      48.83 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.51 seconds
Build - Make                  PASS      208.97 seconds
Make Check                    PASS      9.35 seconds
Make Dist                     PASS      12.80 seconds
Make Dist - Configure         PASS      5.25 seconds
Make Dist - Make              PASS      84.21 seconds
Build w/ext ELL - Configure   PASS      8.62 seconds
Build w/ext ELL - Make        PASS      198.03 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============8598383681515506918==--
