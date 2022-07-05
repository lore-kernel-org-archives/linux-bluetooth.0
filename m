Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2784C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGESU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGESU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 14:20:28 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B620F1408B
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 11:20:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id u20so11887447iob.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jul 2022 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8nwCtKEovSswwjhDZQ7mWaEO/0exoCee83qQoxYOe0Y=;
        b=RNWsz06ogSx8FeuEBf2mYSiFahu1bBjv1zH1F5u3Ef40Q+7p4qUY0kBN5SgNLkAWw/
         SeYzDbW8QTpBl/L4AfdcpF1gBM0+D1GJCMcJk5RUEVOSTPqxXh6YEXK61hgNwvuAt7xo
         pzPxBlgCz4cj9MjoPRjWqW5H1Dhm7HQJ62dDQGoSp1tZUCNz5RCTcmRDRNuQaVSk3uVM
         SeDurM9kuMEPU3aN4wUyDhjYsM2aUh/3TeXgPJRw4j/hXGqXDuKNAmSfXALrLArdCEew
         WfHHyV8VPZQxlg7teVgVYkbvXymCUgwJ/iJZL/R1JG0Tzav8hoe8iGY5aTngJqM+sYWt
         vmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8nwCtKEovSswwjhDZQ7mWaEO/0exoCee83qQoxYOe0Y=;
        b=NDFEZOHwQFwRWns86NfrsFoxLUucEfXKwkdDP+noHFj4hwPX/bNAlFHlxwsKbKw0hV
         d6Lfp5I8TckL3B9kn37KxIwnTTBfCxUn8i8PVgAn2xMgEY8lqxUyRLPDpeuJxu5iE1+Q
         ItvnW79wYxpaNBiQIVbYs6W63j4WuYCs849JfGYKa4r8600ufLeU0HQjKJaYM1mwBD7s
         9dHrNU7MDM6yfY6mTQaqn0acaZfpgho78y0ZwcK7aQLKxPeqRdaAOw3pa5Pa9zw5uWdk
         f3gdm0WobLfOSKCu7w3nL+k0bwKIT6lGWCPsH8x41/iSyCkgG7uC+ckDtkQk7vwqx+E3
         Lfyg==
X-Gm-Message-State: AJIora+GzQnEYGiaCL2EACo6SV5SHOmhIl4+p7e4HOz0s/YDM3srnmH3
        9m4nElan1p4Ui9TopS7XYcNEE8XK9ro=
X-Google-Smtp-Source: AGRyM1tZnGfFIV/aYL420BQz0S4ZbdKSYmDob9cdnCtl0XUDthRgKWQljD2zwHzsJvZzQdMERr6Wjw==
X-Received: by 2002:a05:6602:1355:b0:63d:a9ab:7e30 with SMTP id i21-20020a056602135500b0063da9ab7e30mr20128064iov.119.1657045225769;
        Tue, 05 Jul 2022 11:20:25 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.44.111])
        by smtp.gmail.com with ESMTPSA id m18-20020a056638409200b0033ed4aa6ab1sm2718120jam.93.2022.07.05.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 11:20:25 -0700 (PDT)
Message-ID: <62c480e9.1c69fb81.b96e9.2f1a@mx.google.com>
Date:   Tue, 05 Jul 2022 11:20:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0269673463146966855=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: core: Fix deadlock on hci_power_on_sync.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220705172501.1610923-1-luiz.dentz@gmail.com>
References: <20220705172501.1610923-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0269673463146966855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=656752

---Test result---

Test Summary:
CheckPatch                    FAIL      1.57 seconds
GitLint                       FAIL      0.78 seconds
SubjectPrefix                 PASS      0.80 seconds
BuildKernel                   PASS      31.82 seconds
BuildKernel32                 PASS      27.22 seconds
Incremental Build with patchesPASS      40.95 seconds
TestRunner: Setup             PASS      466.79 seconds
TestRunner: l2cap-tester      PASS      16.42 seconds
TestRunner: bnep-tester       PASS      5.59 seconds
TestRunner: mgmt-tester       PASS      95.09 seconds
TestRunner: rfcomm-tester     PASS      9.00 seconds
TestRunner: sco-tester        PASS      8.75 seconds
TestRunner: smp-tester        PASS      8.95 seconds
TestRunner: userchan-tester   PASS      5.74 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.57 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: core: Fix deadlock on hci_power_on_sync.\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#108: 
[1]: commit dd06ed7ad057 ("Bluetooth: core: Fix missing power_on work cancel on HCI close")

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#108: 
[1]: commit dd06ed7ad057 ("Bluetooth: core: Fix missing power_on work cancel on HCI close")

total: 1 errors, 1 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12906901.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.78 seconds
Run gitlint with rule in .gitlint
Bluetooth: core: Fix deadlock on hci_power_on_sync.
1: T3 Title has trailing punctuation (.): "Bluetooth: core: Fix deadlock on hci_power_on_sync."
33: B1 Line exceeds max length (91>80): "[1]: commit dd06ed7ad057 ("Bluetooth: core: Fix missing power_on work cancel on HCI close")"




---
Regards,
Linux Bluetooth


--===============0269673463146966855==--
