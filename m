Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B91EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 11:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGCL5p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCL5n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 07:57:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C6192
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 04:57:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262ea2ff59dso2024125a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jul 2023 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688385461; x=1690977461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gZapfMt19PPtXWIKkpctHNVf8Wzrn9e8IhDmCQUnx70=;
        b=j+aQXGeGSVOsyv5zyLGk8BKKkhrZZZk23QZUNIsQ3Bf/UcGzmK7w/fdobJdz6G9gz7
         Tknh/KSwlZkLG9D10H1QuuXmx3hATUsuj9atRYFQTWj61bA7+c4eW4yJGgWN2PS1ZsB0
         btW6uSsILvCsJndQD1UNN9ybqeXmOoKtXcAcuAWK3+F2MHOAqqiEHpnAIPrteIpeL7yi
         uGSw8CbP9zZVAoiKOo+VrfC8u8Out5RRF1x97zwL47WcxdoTL7WJOg/iuBp9S0SUXsVm
         EJZjb1ol9+hLwMFZRsb84QykC3aCxt6lY+DcP9I3EAsiyv5EbJBQHXKU5FhAxvGz/R2g
         iwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385461; x=1690977461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZapfMt19PPtXWIKkpctHNVf8Wzrn9e8IhDmCQUnx70=;
        b=R2/P+OJajFzERhO4IaGMCtCqUEJHfib9urnWW9vxL+TVk1U1EDKrC6hC+P7DZL0k0X
         w8vGJ412BwQJZ2GpXBJu/niP89iZZc1Nttzq6z9j2faRWRbyr6ZvXCm6cli28ofrdX5Y
         XvcmgeM/h0jlHNCYbSlhgJDl2f+yJ6PJBCTcRvdNkxava/9Y5hLa9YUQAcj9WIxO1gMw
         7V5ZiHlOyFvXlY6lDj9uMy7+UCb5F3N+XGlkYTTpk4KwcdWS+d/jKJWv0EE24i/byELT
         h1l/4PK5Db4T6H+cwdDnI48eBBBPVihPX8R/oeXrY4RVOLPPVXIj2xiqfgVRN5jg/3/o
         hbeA==
X-Gm-Message-State: ABy/qLawjKwS32A/3PA958ezwwvCsSjqShrzoUfcATGJKVqpXQ95FLWN
        P2l3tQcfLicM4EGKOHLo7IR9jYPbDTA=
X-Google-Smtp-Source: APBJJlFgOP9XC3kyCDDtCznEezAJnQMK+lAakaa14E37506zkvqWvqpskQM1dt1AkwoKwXDin3ch7w==
X-Received: by 2002:a17:90a:598b:b0:263:9329:19df with SMTP id l11-20020a17090a598b00b00263932919dfmr6467680pji.36.1688385460797;
        Mon, 03 Jul 2023 04:57:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.22.167])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a01c500b00263c48abf89sm2030875pjd.37.2023.07.03.04.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 04:57:40 -0700 (PDT)
Message-ID: <64a2b7b4.170a0220.2b329.3b02@mx.google.com>
Date:   Mon, 03 Jul 2023 04:57:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4827968611235288439=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: coredump: fix building with coredump disabled
In-Reply-To: <20230703113112.380663-1-arnd@kernel.org>
References: <20230703113112.380663-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4827968611235288439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761988

---Test result---

Test Summary:
CheckPatch                    FAIL      0.83 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      32.44 seconds
CheckAllWarning               PASS      35.05 seconds
CheckSparse                   PASS      40.55 seconds
CheckSmatch                   PASS      111.19 seconds
BuildKernel32                 PASS      31.62 seconds
TestRunnerSetup               PASS      447.80 seconds
TestRunner_l2cap-tester       PASS      12.89 seconds
TestRunner_iso-tester         PASS      23.81 seconds
TestRunner_bnep-tester        PASS      5.52 seconds
TestRunner_mgmt-tester        PASS      132.56 seconds
TestRunner_rfcomm-tester      PASS      9.02 seconds
TestRunner_sco-tester         PASS      10.35 seconds
TestRunner_ioctl-tester       PASS      12.04 seconds
TestRunner_mesh-tester        PASS      7.02 seconds
TestRunner_smp-tester         PASS      8.11 seconds
TestRunner_userchan-tester    PASS      5.79 seconds
IncrementalBuild              PASS      30.03 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: coredump: fix building with coredump disabled
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")'
#86: 
Fixes: 872f8c253cb9e ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Add support for hci devcoredump")'
#87: 
Fixes: 9695ef876fd12 ("Bluetooth: Add support for hci devcoredump")

total: 0 errors, 2 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13299982.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3226.
Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3226.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: coredump: fix building with coredump disabled

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (84>80): "drivers/bluetooth/btmtk.c:386:30: error: 'struct hci_dev' has no member named 'dump'"


---
Regards,
Linux Bluetooth


--===============4827968611235288439==--
