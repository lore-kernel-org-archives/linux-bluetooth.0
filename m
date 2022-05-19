Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 21:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiESVCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 17:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiESVC0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 17:02:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB44ED8E8
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:02:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6314757pjg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hcmgIg9VT5bkgq8zMO5spFjBkY+AbzMQMXi4XmZwC+c=;
        b=j0Y1vTSnnwSv0BYbQDklR7xHNdaF4XMNwyGyKNEtC4p7myK7uU2XwLAfDlvJH6W2VQ
         c/pV8On4N8MLhEad1ERkcPdNp1NM2wKHN1kepXd3lsgltW8Vjs9ubmg4ui4fYLasSxqD
         NB0u+Tb5BtuM3tO1uE1NX6v0wz1l964gJwCY8M3p/8AOoB7erT/md01E4QljRbA5+xdX
         O6zl4OMbstd2RJRSVxm3O7BcqBSbXyNxDjp1Cz6c5RuKxr+mdGHK52A4rS8gdyYgvDPQ
         wni7r544oY+MElV7Z9E12pJZEXqp2fiogf9oIx73jvk4ffQb60DuC8ez4cJmkIuIC7cs
         LpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hcmgIg9VT5bkgq8zMO5spFjBkY+AbzMQMXi4XmZwC+c=;
        b=1Re7SfHKiEd/NUxb1Z0S9w8LBKJ4EBMp+t5+bK7nDockYgsUjULV44EIaKYicdqJHP
         6S7sjg6BSByOodWJLZTk6XRdkIzoID4rl/aMn90EjtX1f833PTte1m40rzfwqqW2Srdp
         4DMA38vkHvbDcUm8087n4jF7Au5flvbyeT4a8Y8hrzNtQBLhEJayX5puGW9/4eafQBmg
         KBoFcFhWhcGeqxqujjOYWE+FtZjzRn1XABcsXQLpi/0R4tSMzBpEvPRdK7r0TrIALRmR
         Bce6vEZXrh/5sb08BbLrvA6SkbTJZ9ZBRSADx8UqLEGL0kGQc/SH/kuw7w7HODqAulLa
         5U0Q==
X-Gm-Message-State: AOAM533yt5gIXos8VELXYqQDoWkNQw7I7+hqnLp55Nd9778LHDBxsN7a
        HjtXsspvRMYNdEPhcLt5fVsjkuhi3Ns=
X-Google-Smtp-Source: ABdhPJx1czkuep5D37yj6mNNieiE0/r/Zl3GRXtMJ5nlfEoAorjTmiB0iaSxt5klnPvZxb5bXeu8YA==
X-Received: by 2002:a17:902:e851:b0:15e:d129:fb20 with SMTP id t17-20020a170902e85100b0015ed129fb20mr6412690plg.140.1652994140858;
        Thu, 19 May 2022 14:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.120.35])
        by smtp.gmail.com with ESMTPSA id c78-20020a621c51000000b0050dc76281fdsm91435pfc.215.2022.05.19.14.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:02:20 -0700 (PDT)
Message-ID: <6286b05c.1c69fb81.fa1e6.0516@mx.google.com>
Date:   Thu, 19 May 2022 14:02:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0370631611269369516=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: Fix uses of bitmap_from_u64
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220519201545.2422259-1-luiz.dentz@gmail.com>
References: <20220519201545.2422259-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0370631611269369516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643308

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      31.36 seconds
BuildKernel32                 PASS      27.70 seconds
Incremental Build with patchesPASS      38.20 seconds
TestRunner: Setup             PASS      470.62 seconds
TestRunner: l2cap-tester      PASS      16.85 seconds
TestRunner: bnep-tester       PASS      5.81 seconds
TestRunner: mgmt-tester       PASS      99.22 seconds
TestRunner: rfcomm-tester     PASS      9.17 seconds
TestRunner: sco-tester        PASS      8.99 seconds
TestRunner: smp-tester        PASS      8.99 seconds
TestRunner: userchan-tester   PASS      5.94 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.02 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: MGMT: Fix uses of bitmap_from_u64\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#110: 
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);

total: 0 errors, 1 warnings, 0 checks, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12855993.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0370631611269369516==--
