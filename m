Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 01:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378294AbiAUB5A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 20:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbiAUB47 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 20:56:59 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337B4C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 17:56:59 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a7so8883913qvl.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 17:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=m0vALOdDq4h6S6L9GhNnaIgK+PbdK455Nu5juYyTeNk=;
        b=Kv+N4Xyul7l5hKUk57rPad1UtdH503xVKzyiWP1F9KbUnwT3F3WWTl94yTsOw079Iw
         U4yR0+KxOri1SBKs0kxFR2MkasxB2xZDQR1ttHWqok2/qJy9VWKHvPpPgvD5ychel3a6
         eqlb8NvJ2yeFTfMyr/PVA6PwoRB9j1R3VTwAe6nXGApcXXvD8xPUXJDY+droL9lW+seC
         1UhgG+P8JJ4xWa8lgc0RvQsWf6DDXrnnNGlCVWzcySqfor+3BioCMQB/RzoAbmdBS6Vg
         uHJEswhrywdfwyNppIfZETASKboo8+iUNZvedK9haqzBqSJZin6JwW4JzdteXy4U8UkS
         rlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=m0vALOdDq4h6S6L9GhNnaIgK+PbdK455Nu5juYyTeNk=;
        b=N97ocbDaf6Bzti8VYD+WD14lKLQ+aGkDUEI0ENFigY7qqkLQaaOsxr81XlIZ0/p5Mw
         drORfhF5EU7VRf/eD5WON256Npsa9q8Os8SArLYu6MOPtmgvFOY0DxQKEd+UUlVz5BqS
         8Vt3nAG00z4Q9t39F1Hqgyxv1zZUdWDSrlFhX+TmojY/so+EV5u+egoJKIPbjgFjHyxv
         WjjfiVsMrY39dT4laCA2yNm8HgvVLUv3aTlE+weIUOGpYvUtgxd/5piriZqG0GKFW/Z5
         t7sZM6spoXtcCvqgtPWL/1u+oiQxjSYuVqMuwWPwTYSDxQXEKi6hCsFK30WIiHRqBxPr
         kGCw==
X-Gm-Message-State: AOAM531TMmqZxDopoOSCro4CTv7V/BZWrQEUpdUkFdHeR6V1mZHZC5JU
        x6BqaEK2uz34RC5HWRZ1zlyNV2BZG94kkw==
X-Google-Smtp-Source: ABdhPJyI9Htpp0aZwiHG4IGUu0n/8bU5mKZVe2BXpJE5fJxAisr/sPQ6i/O2X2cKE7O7egF9y+rDvA==
X-Received: by 2002:ad4:5d6d:: with SMTP id fn13mr1795156qvb.25.1642730218101;
        Thu, 20 Jan 2022 17:56:58 -0800 (PST)
Received: from [172.17.0.2] ([20.62.96.168])
        by smtp.gmail.com with ESMTPSA id s4sm2593490qko.113.2022.01.20.17.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:56:57 -0800 (PST)
Message-ID: <61ea12e9.1c69fb81.9022a.12a0@mx.google.com>
Date:   Thu, 20 Jan 2022 17:56:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5167141727445920559=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cgel.zte@gmail.com
Subject: RE: bluetooth: mgmt: Replace zero-length array with flexible-array member
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220121013508.950175-1-deng.changcheng@zte.com.cn>
References: <20220121013508.950175-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5167141727445920559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607119

---Test result---

Test Summary:
CheckPatch                    FAIL      1.61 seconds
GitLint                       FAIL      0.96 seconds
SubjectPrefix                 FAIL      0.87 seconds
BuildKernel                   PASS      30.32 seconds
BuildKernel32                 PASS      26.97 seconds
Incremental Build with patchesPASS      36.33 seconds
TestRunner: Setup             PASS      472.13 seconds
TestRunner: l2cap-tester      PASS      13.23 seconds
TestRunner: bnep-tester       PASS      6.01 seconds
TestRunner: mgmt-tester       PASS      103.93 seconds
TestRunner: rfcomm-tester     PASS      7.33 seconds
TestRunner: sco-tester        PASS      7.60 seconds
TestRunner: smp-tester        PASS      7.47 seconds
TestRunner: userchan-tester   PASS      6.25 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.61 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
bluetooth: mgmt: Replace zero-length array with flexible-array member\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12719219.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.96 seconds
Run gitlint with rule in .gitlint
bluetooth: mgmt: Replace zero-length array with flexible-array member
10: B1 Line exceeds max length (97>80): "https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays"


##############################
Test: SubjectPrefix - FAIL - 0.87 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5167141727445920559==--
