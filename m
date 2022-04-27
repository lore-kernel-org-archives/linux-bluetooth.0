Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3767EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 07:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349945AbiD0HQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiD0HQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 03:16:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3549C90
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 00:13:24 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so691679qkp.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8RAPSWfxtVjKAXtiZaBfDlWcBfzlGfcfJopSz/8uEoQ=;
        b=q7EtK+FEa22NE2y4HcWlFcLzI1CpXbNgxikMNMbubTJGPcUltEjzwwTz9vY8vbspck
         L7e/oOF4AzqyaZrsb8afOqv8C0rkt1kWNoqJLyx0SIsaZBvssA4LFpkizYOj6SYl9UzQ
         Kz/eDXvlgjoVeV+jodruOA+YDTvqHKrSNWxZs4OdAk39ZmLfcWOOHO+Vo1eT3uUjMjqP
         QatLbBg9bfTkMlJmJiefj5+T7lANIOpC5RrXMaekPE92YTLAQOqTEv/Y/KvVUTWHeGZ5
         XEJQiudRXHRCMhu36lDOB6KWP3/1x+KLJNCOvDS8myqCFYV+cgKKxmQZAVPw8gFU7e6y
         +4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8RAPSWfxtVjKAXtiZaBfDlWcBfzlGfcfJopSz/8uEoQ=;
        b=6peYVUufXCAWXWxmBaN9XOdBSVC7Q7MWzRTLsR34jiVaSzr1cE14tXqjyvAbEd6DpA
         vueL2FKObODi1xEiGduTi7WE2XsFbJ0J5Vr8/goLoHXLW+SleEBiavSpzitkJQjQqV9L
         O31tE/XhvenwLvIZrR89osL2JuTNpBt/HACSTfdnsUu74opv+e8X8t3XscZb1wJsqqBH
         exjXJgISnxOSBNywftFkTIkVuXI7E2ZcNFYyjyr7eOukDh3OoGbcN8R2FRIRZD5krfmE
         DPVSsK58n1PSs3eQGlVuvtudOnSNeBl2xTjFiWdHqs+5nH90j+i4tVqLdUwCQrvbh9m5
         PHOA==
X-Gm-Message-State: AOAM530higItCirjVZcKtlHMCEl1IGrVJ8t/0O3SgGNs6mu6R9KyAVln
        wjKbeY1VeOJmY2OY61xpXp0n1Jil3NPXVw==
X-Google-Smtp-Source: ABdhPJywsvGCceO3cLeRjmGJt8UixDNyBU9ZvevuysZRNSsgeRdgWvMvmW5QvLmV2/CcaQWyMU7eFA==
X-Received: by 2002:a37:bbc4:0:b0:69c:3f31:3eb8 with SMTP id l187-20020a37bbc4000000b0069c3f313eb8mr15474491qkf.489.1651043602975;
        Wed, 27 Apr 2022 00:13:22 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.80.168])
        by smtp.gmail.com with ESMTPSA id h5-20020a05622a170500b002f3818c7b92sm1486374qtk.49.2022.04.27.00.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:13:22 -0700 (PDT)
Message-ID: <6268ed12.1c69fb81.28796.9cb8@mx.google.com>
Date:   Wed, 27 Apr 2022 00:13:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1454614459983095481=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, juerg.haefliger@canonical.com
Subject: RE: Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220427063504.384540-1-juergh@protonmail.com>
References: <20220427063504.384540-1-juergh@protonmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1454614459983095481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636030

---Test result---

Test Summary:
CheckPatch                    FAIL      1.76 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.96 seconds
BuildKernel                   PASS      41.93 seconds
BuildKernel32                 PASS      35.32 seconds
Incremental Build with patchesPASS      48.09 seconds
TestRunner: Setup             PASS      620.05 seconds
TestRunner: l2cap-tester      PASS      19.76 seconds
TestRunner: bnep-tester       PASS      7.58 seconds
TestRunner: mgmt-tester       PASS      120.59 seconds
TestRunner: rfcomm-tester     PASS      11.37 seconds
TestRunner: sco-tester        PASS      11.02 seconds
TestRunner: smp-tester        PASS      11.43 seconds
TestRunner: userchan-tester   PASS      8.40 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.76 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files\WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address mismatch: 'From: Juerg Haefliger <juerg.haefliger@canonical.com>' != 'Signed-off-by: Juerg Haefliger <juergh@protonmail.com>'

total: 0 errors, 1 warnings, 5 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12828329.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1454614459983095481==--
