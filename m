Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AADC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 07:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiHLHNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 03:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiHLHNj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 03:13:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E042C11C
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 00:13:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y18so187768qtv.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=0d5IaUzVJKdIBYVrzQeOp+YY5HwVA77SzYFooHDa/wE=;
        b=GCzJ1fBIDbp8qlT0ljWKlMZ+i7n0wxYQi0oIrSe4LBnFBFfcPY0CWjGi8RNdtdiNct
         2/Skq8YQMO4r6IBA9Hy/qYBaAOejR1tm9s2NHEyLAXusyqIQBXT439RRWslPHsqSvPyH
         5Y/MRRIGBoc+U2VBESLrVCmWQgVsLjYGeETnaDcdXqMpRXRNnIZoxvjmNKSty5wesvh3
         TCX6akQQ1HiVvLPAorqp2i4YQNgP/ZhiINhR0gragxA5DQpHlHXzi2aFgQjHYsFYV5bd
         ZNt7dncrzuiwrn9xIHqxuQBmXfN2FrFVpAqWRE1/8ZfV0ZLNq0Yetvtn9jDkMgs0/DpI
         b+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=0d5IaUzVJKdIBYVrzQeOp+YY5HwVA77SzYFooHDa/wE=;
        b=Lr8rMllFfIFw87JvLGo8uTVscvzGQHl8PCiULo9JroWCDSGpISu0sq2DRpY9wMME37
         vhmD/bmN80/Ze8nd9fGgO7wpsrevEo9uoBmOLNqUBl7m/HeFSAF+FQQMVZIxq7zpY1Z3
         7mgzTKr+u/lJlvCchZHOic9qsxpbPB8g3+aeury17QPQHZzaMb+Xl55Jl6vsm+H86xBN
         /XLVIMMfUXyvQgpudmRDSJ0IoF38xM8gQmEUDTcP9qqhM8paExH8YKvf+InSZ43mhOni
         5nlVX5Qinm7c9Li1rPRKoe9VRWLGTZKS0E6BGJ4Q/KABFHGbZ2+03z5xgf1tO6WFS5VV
         IOVQ==
X-Gm-Message-State: ACgBeo2WGS2LYtiioPr3xtn/zNtBQNHaXpX2fyAGp0j/HPAKUeHLlSOY
        zz7Jt/7LDORplzkW1b8ztT54lesg4i8=
X-Google-Smtp-Source: AA6agR7oqjp+oplt/5JB1UtmRUN69YKxqXtWdyIi6kEMC9bDoUZY4RSN6R5MuaPgy4HlmtNyV+SZXA==
X-Received: by 2002:a05:622a:50e:b0:343:57fb:2819 with SMTP id l14-20020a05622a050e00b0034357fb2819mr2474017qtx.243.1660288416512;
        Fri, 12 Aug 2022 00:13:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.15.105])
        by smtp.gmail.com with ESMTPSA id bk42-20020a05620a1a2a00b006b978b521c8sm1079999qkb.69.2022.08.12.00.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 00:13:36 -0700 (PDT)
Message-ID: <62f5fda0.050a0220.ebb71.24fe@mx.google.com>
Date:   Fri, 12 Aug 2022 00:13:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8963113445540283551=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, palmer@rivosinc.com
Subject: RE: Bluetooth: L2CAP: Elide a string overflow warning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220812055249.8037-1-palmer@rivosinc.com>
References: <20220812055249.8037-1-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8963113445540283551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667062

---Test result---

Test Summary:
CheckPatch                    FAIL      1.60 seconds
GitLint                       FAIL      1.01 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      41.49 seconds
BuildKernel32                 PASS      34.89 seconds
Incremental Build with patchesPASS      50.21 seconds
TestRunner: Setup             PASS      605.56 seconds
TestRunner: l2cap-tester      PASS      20.02 seconds
TestRunner: bnep-tester       PASS      8.10 seconds
TestRunner: mgmt-tester       PASS      122.17 seconds
TestRunner: rfcomm-tester     PASS      11.73 seconds
TestRunner: sco-tester        PASS      11.48 seconds
TestRunner: smp-tester        PASS      12.14 seconds
TestRunner: userchan-tester   PASS      8.96 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.60 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: L2CAP: Elide a string overflow warning\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
In file included from /scratch/merges/ko-linux-next/linux/include/linux/string.h:253,

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#95: 
                 from /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:31:

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#98: 
    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2003:15:

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#99: 
/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#102: 
/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#107: 
    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2004:15:

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#108: 
/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]

WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
#111: 
/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'

total: 0 errors, 8 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12941909.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.01 seconds
Run gitlint with rule in .gitlint
Bluetooth: L2CAP: Elide a string overflow warning
9: B1 Line exceeds max length (85>80): "In file included from /scratch/merges/ko-linux-next/linux/include/linux/string.h:253,"
10: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/bitmap.h:11,"
11: B1 Line exceeds max length (85>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/cpumask.h:12,"
12: B1 Line exceeds max length (91>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/mm_types_task.h:14,"
13: B1 Line exceeds max length (85>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/mm_types.h:5,"
14: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/buildid.h:5,"
15: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/module.h:14,"
16: B1 Line exceeds max length (88>80): "                 from /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:31:"
18: B1 Line exceeds max length (104>80): "    inlined from 'bacmp' at /scratch/merges/ko-linux-next/linux/include/net/bluetooth/bluetooth.h:347:9,"
19: B1 Line exceeds max length (118>80): "    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2003:15:"
20: B1 Line exceeds max length (167>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
23: B1 Line exceeds max length (124>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'"
27: B1 Line exceeds max length (104>80): "    inlined from 'bacmp' at /scratch/merges/ko-linux-next/linux/include/net/bluetooth/bluetooth.h:347:9,"
28: B1 Line exceeds max length (118>80): "    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2004:15:"
29: B1 Line exceeds max length (167>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
32: B1 Line exceeds max length (124>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'"




---
Regards,
Linux Bluetooth


--===============8963113445540283551==--
