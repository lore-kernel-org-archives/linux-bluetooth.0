Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3BEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jan 2022 02:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiAECVM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jan 2022 21:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiAECVM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jan 2022 21:21:12 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E6C061761
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jan 2022 18:21:11 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id fq10so36195850qvb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jan 2022 18:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ydp60EfnrkCrWKcyOyNYzNDlpm+SoyHlWqcBNTrZOGY=;
        b=iw6BPrSHsKtS3M1nTKbXu4L4NNaxlIXKc7SpniG2zMBBuXL8M62LQmqrmTvZ9zIiT8
         gZgxwIlJ7oellwde7m/hUVLZg3GjEiXjhKKCrE/UyGZ4YBMw53Vz7/3+BKfOpaRxN99G
         TZ1SzIldRmtoiCqvi/LG58y9iY9FLLV2lug/7dNzX92Qw02ITEErHJIbDurBVFwx/8k2
         cmzTsvC2vVA5qDOJzMntz8psdwDjr0fmRSXP/oaFA2RwMSbsVtRlasSAnyNX3n7YBGRl
         KYxapSheovTgrCy0bZ+3QhqvK7Q7U9iPGFWvkktDy7UxKdhxd7xewhqUYEHyISwCE8Z5
         kB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ydp60EfnrkCrWKcyOyNYzNDlpm+SoyHlWqcBNTrZOGY=;
        b=5iTJRCGFmGyNJBtCSbAsjCYhKIecmQb6oNIFw/FQxT1+JTlmJ3L3K8uOQwZhSHtISq
         bJ2N2dYTHRxUmTuIKZEJs2Ct+qhMJ+fShs0TudFgbFytVZ1q25wQEamX6/6vTBOFDNfz
         weXDCN6K7o9oHUIniq1NreJ2Wx/EYHf8MwyNrsHNG1xpTGJm6LdWHDBUvdEfjyIvq3qp
         YvS9uwdB1hrsJmsN9tZA61F689jO2GT+HaQBw4n6Fi9lC9NfMHgA8j1Y8UYZSg31DMqr
         wuYVm2fXpLGtkdixxWNXkZh+I03TkW2RouY5UvA0gzgGYa8r1gx+BmBpYQsOPhYzOCU4
         PM3A==
X-Gm-Message-State: AOAM531HaWl2qvTAGcXHZihD7MQKcSdVEKSsyHB7R1/ZXBP0cUwhSsTA
        5PiZgkqFe3n49PNH855LyD0RD76ZDpUI6A==
X-Google-Smtp-Source: ABdhPJzFuO4qi/xiIL1lK4VfsJjLG9Udz1zLdXobeNyvhr7g9WH2Wme0G/3pkwGdhbLOz/wF2iA3aA==
X-Received: by 2002:ad4:5ba3:: with SMTP id 3mr47200074qvq.59.1641349270749;
        Tue, 04 Jan 2022 18:21:10 -0800 (PST)
Received: from [172.17.0.2] ([20.120.96.163])
        by smtp.gmail.com with ESMTPSA id o17sm35157266qtv.87.2022.01.04.18.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 18:21:10 -0800 (PST)
Message-ID: <61d50096.1c69fb81.3ebbf.15d7@mx.google.com>
Date:   Tue, 04 Jan 2022 18:21:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5226707403690191985=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,v2] emulator: Add support for vendor commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220104234326.3001935-1-luiz.dentz@gmail.com>
References: <20220104234326.3001935-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5226707403690191985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=602734

---Test result---

Test Summary:
CheckPatch                    FAIL      1.56 seconds
GitLint                       FAIL      1.00 seconds
Prep - Setup ELL              PASS      47.91 seconds
Build - Prep                  PASS      0.64 seconds
Build - Configure             PASS      9.26 seconds
Build - Make                  PASS      1615.44 seconds
Make Check                    PASS      13.15 seconds
Make Distcheck                FAIL      147.40 seconds
Build w/ext ELL - Configure   PASS      10.01 seconds
Build w/ext ELL - Make        PASS      1559.50 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[RFC,BlueZ,v2] emulator: Add support for vendor commands
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#297: FILE: monitor/emulator.h:18:
+} __attribute__((packed));

/github/workspace/src/12703916.patch total: 0 errors, 1 warnings, 146 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12703916.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[RFC,BlueZ,v2] emulator: Add support for vendor commands
14: B3 Line contains hard tab characters (\t): "	."$........"


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




---
Regards,
Linux Bluetooth


--===============5226707403690191985==--
