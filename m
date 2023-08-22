Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF1CEE49AB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjHVUOb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjHVUOa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 16:14:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66702CC
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:14:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76ce59842c1so281267285a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692735267; x=1693340067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FQSZPG6BLfzH1L3CVK7D83MaFk8WK/sKqMLclDweYsg=;
        b=oKCy+TFtQVb2zozlfDNPCymibJVBLpTS+Hs07JMNW62BJWfF+EKGppE69iaFxxSR95
         +OXuZ/e0lWLDlvuxPdcEFH5tjIS/nXSGnjR2aoLr3kLw9Ps7tol5ztJgWfz3svTx5Y1F
         Ojni/Oq512RefUXbArFwjhgN7uwaH/iEFH57NZfH5ynhggIcCa++GZWp8Z0y1pPgriAy
         4yiIiFNvauH1TZBpLOA4amvg7ZQQhw+RmG1edMzCGL0KtL/FniVs4dpK/O2mxlt/Uv2d
         b8qzuAX0Ndy3P5f4B1eKnxFv/TcJjqhPvVrNnsrUpBczoOhWXicH6XjNhWgoYBs8/CqJ
         t7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735267; x=1693340067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQSZPG6BLfzH1L3CVK7D83MaFk8WK/sKqMLclDweYsg=;
        b=jp5qwr+eLtJNim7U87+joqPdupDIWdO98kxzBcxER3PaldYLYNtcntEQ5MyMorBhqE
         c/CZTTZYhvsBQ6dA6skgYJvFNY7/pIKH4+anEO75o75lKA7APNC676aPmysj2HVqXXhU
         MXz9tBIYri1rz5NLrcZMxHa09oCprkOaE9zuhkxu8Z40yyCiUYGaiXz2s3E1JsMLdiM1
         llFM9F9vcZgLT6C/5zHO0cr5rSR2stUi3oUx3F8odboDN5yTPvLc1kBU77pGR4S1rJWa
         HPUzf8DwQxQkybKMFYONgnWLR+nPcl+9vJ9p3RxnJFCSFltd1Iop3efPeUZkZK4o9Jec
         Yb6w==
X-Gm-Message-State: AOJu0Yx91IGz1bpooc+dP4PW/BOjrgjpvtk94IEgYTPS6lrI1m02ehxM
        9kErjiduZqULl4UOMR0JWhKUTqVbk8A=
X-Google-Smtp-Source: AGHT+IGKc/FJ4UL8+c7G3QcUm0hc4/sqvHn9PtBjGV7OzdZCsEDmogxWHgUgjrm2k1SPbWGgunxx7g==
X-Received: by 2002:a05:620a:2450:b0:76c:e932:bf7c with SMTP id h16-20020a05620a245000b0076ce932bf7cmr11895569qkn.8.1692735267363;
        Tue, 22 Aug 2023 13:14:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.193.184])
        by smtp.gmail.com with ESMTPSA id q22-20020ae9e416000000b00765aa3ffa07sm3420857qkc.98.2023.08.22.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:14:27 -0700 (PDT)
Message-ID: <64e51723.e90a0220.808b3.e372@mx.google.com>
Date:   Tue, 22 Aug 2023 13:14:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5132859747889966412=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <20230822191444.3741307-1-luiz.dentz@gmail.com>
References: <20230822191444.3741307-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5132859747889966412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778336

---Test result---

Test Summary:
CheckPatch                    FAIL      1.31 seconds
GitLint                       FAIL      0.61 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      33.22 seconds
CheckAllWarning               PASS      36.40 seconds
CheckSparse                   PASS      41.61 seconds
CheckSmatch                   PASS      113.71 seconds
BuildKernel32                 PASS      32.12 seconds
TestRunnerSetup               PASS      500.59 seconds
TestRunner_l2cap-tester       PASS      28.88 seconds
TestRunner_iso-tester         PASS      52.09 seconds
TestRunner_bnep-tester        PASS      11.46 seconds
TestRunner_mgmt-tester        PASS      227.05 seconds
TestRunner_rfcomm-tester      PASS      17.28 seconds
TestRunner_sco-tester         PASS      20.68 seconds
TestRunner_ioctl-tester       PASS      19.46 seconds
TestRunner_mesh-tester        PASS      14.52 seconds
TestRunner_smp-tester         PASS      15.55 seconds
TestRunner_userchan-tester    PASS      12.10 seconds
IncrementalBuild              PASS      30.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
WARNING: Possible repeated word: 'is'
#81: 
This introduces HCI_QUIRK_BROKEN_LE_CODED is is used to indicate that

total: 0 errors, 1 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13361346.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (116>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#"


---
Regards,
Linux Bluetooth


--===============5132859747889966412==--
