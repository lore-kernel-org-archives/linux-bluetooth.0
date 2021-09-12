Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2BAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Sep 2021 21:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBCB60F56
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Sep 2021 21:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhILVco (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhILVcm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Sep 2021 17:32:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F48C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Sep 2021 14:31:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c10so8438607qko.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Sep 2021 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IRcpQhncmfuJY+ecQzGj1FszdgtIuJA1sF4xzlagmho=;
        b=SQZUktjURo3zcuAzUCChP3NbXQx6I9fyHZvZrTCjuuSqA7H4jQw5HlaWrEkR8SSPMi
         HraU4hOtQ8uXde8OV1ZzjVgbhcBlgIh19kNVj0COVAp9OSoalyC6aRicrpyxGZtYmEr3
         SHT8U+RxhfRIgdZ+AlJeFKqEb1a/dwRI63d07CKpMMOR73fsSqqqSaDlSmyj1Tztd2q7
         N5wX75s95Jez1pOudRF6Z+9OLKDpW0BkqDMNaANf40t8/MDISOrxlF6UDYyJVe4l2McX
         9/rBhlk4wvcB37SI0iPD/G2Q8SJdH/j7yRJ/P8u6GT5gT6gixjl31xO/MBwkDH5xT853
         y0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IRcpQhncmfuJY+ecQzGj1FszdgtIuJA1sF4xzlagmho=;
        b=KEYDyF1Bo5s62PlTiqlvS9mVlA5fGTSFFQ2szSG8lADQ5sl1/mOX2HPNtd2J6LzDPt
         xKUcHxzrdqJ40Hv6+nYUUPFwZbsBw3Jvn4K6c1FjIXPGNm9pI5CHXpqXqVjTE8+5fvd9
         taT8+K6L5dFEQ22VEF+9JpgCeG+UO06RZJt3lxJggW78GLPHDc1BHsVYBmxg82WNHzdc
         EvtORNyJyxUKi/+5jx5zW+HiGymGuHjGXEzWMk7qgz0fzGq+G+Dc+wGSx7OOjWKXfkMv
         XxlsD9sCW5QhD7nhZGNVTh2sU9cz8aBGO71GaK9nLEOMf27cF4jOquLdERNlsd1eNF3E
         UqqA==
X-Gm-Message-State: AOAM530pXC3zIx1FJWYyA5HU3s5xRIoMyWu1oTcq9FjN1WdMa/xZKPUW
        FcxEXdFjG3Vjk8Az+rhcIpgIODztXCU=
X-Google-Smtp-Source: ABdhPJyCD5Tdru3zzMdmWZ991t1ex80FyhdFy0iODsF7w2ibTbw/6D3MzZO/r1kORtIr3Un7OGf44g==
X-Received: by 2002:a37:a883:: with SMTP id r125mr7150204qke.408.1631482286475;
        Sun, 12 Sep 2021 14:31:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.162.120])
        by smtp.gmail.com with ESMTPSA id j23sm3945013qkl.65.2021.09.12.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 14:31:26 -0700 (PDT)
Message-ID: <613e71ae.1c69fb81.14755.5e5c@mx.google.com>
Date:   Sun, 12 Sep 2021 14:31:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7307092584059482375=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: profiles/audio/media.c: fix build with glibc >= 2.34
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210912204839.3018089-1-fontaine.fabrice@gmail.com>
References: <20210912204839.3018089-1-fontaine.fabrice@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7307092584059482375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=545463

---Test result---

Test Summary:
CheckPatch                    FAIL      0.28 seconds
GitLint                       FAIL      0.10 seconds
Prep - Setup ELL              PASS      40.46 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.03 seconds
Build - Make                  PASS      174.80 seconds
Make Check                    PASS      8.67 seconds
Make Distcheck                PASS      205.44 seconds
Build w/ext ELL - Configure   PASS      7.10 seconds
Build w/ext ELL - Make        PASS      164.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
profiles/audio/media.c: fix build with glibc >= 2.34
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '28f540f45bba', maybe rebased or not pulled?
#7: 
upstream commit 28f540f45bba (initial import) in 1995 [0].

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'caab74c97542', maybe rebased or not pulled?
#10: 
commit caab74c97542 (media: Implement new callbacks for pass-through

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#19: 
In file included from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/bits/sigstksz.h:24,

- total: 0 errors, 3 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] profiles/audio/media.c: fix build with glibc >= 2.34" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
profiles/audio/media.c: fix build with glibc >= 2.34
16: B1 Line exceeds max length (142>80): "In file included from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/bits/sigstksz.h:24,"
17: B1 Line exceeds max length (136>80): "                 from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/signal.h:328,"
18: B1 Line exceeds max length (160>80): "                 from /tmp/instance-0/output-1/per-package/bluez5_utils/host/bin/../s390x-buildroot-linux-gnu/sysroot/usr/include/glib-2.0/glib/gbacktrace.h:36,"
19: B1 Line exceeds max length (149>80): "                 from /tmp/instance-0/output-1/per-package/bluez5_utils/host/bin/../s390x-buildroot-linux-gnu/sysroot/usr/include/glib-2.0/glib.h:34,"
21: B1 Line exceeds max length (164>80): "/tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/unistd.h:489:12: note: previous declaration of 'pause' was here"
44: B1 Line exceeds max length (83>80): "  - http://autobuild.buildroot.org/results/c4fbface34be8815838fd7201621d7a8fddd32c5"
45: B1 Line exceeds max length (83>80): "  - http://autobuild.buildroot.org/results/62b88740f19fbe4a1ad7959dc141d539eb88c1f8"
47: B1 Line exceeds max length (95>80): "[0] https://sourceware.org/git/?p=glibc.git;a=commit;h=28f540f45bbacd939bfd07f213bcad2bf730b1bf"
48: B1 Line exceeds max length (82>80): "[1] https://github.com/bluez/bluez/commit/caab74c97542a56b591f0b16b44ab6ba4b40f0f5"


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


--===============7307092584059482375==--
