Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ACC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCQVeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCQVeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 17:34:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47844783E
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 14:33:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y2so6664521pjg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tRtNzXuuxaS8DWD8Vfv/P0ZFm11E6tTqadhzKCxmj8g=;
        b=pyBTiXOcX1jeOkMvHB/Q66RxPTBE2C5Z+fzB9zCXyLHbG8+oLk35JcTYya3JYwbH0P
         W8jEhYBkbKyxj6IaG9cge/e351ZN7IzXaHEVAFAdpSCO95IwjnySSMxI5H/c2YZOgX7D
         mJdM0lDeDU2S8T9EFhzuKCx/AJ5dLQqbr13A8+mKfii/8lZMsfBtPpcxML6EE75yvksO
         16IOXXbzxXYP52pqJGB5deDkyE88BUwV6Fgs6XC8br8n5ZW4e9m6IB6iY7vNFoYotB6N
         Dgj4lFGnILZCaPjA021YYta8haHAr2AP6/YlGRWuGsUq01CjWOvSwgWFJZ1A+nrIQ6f9
         8IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRtNzXuuxaS8DWD8Vfv/P0ZFm11E6tTqadhzKCxmj8g=;
        b=h5h/Ibi3mobX+kUWgj2yxukmyWLPSOAoKWSCELZUgc3n2wWy0VE2hV/OcFYOQM1xJ1
         I5ZLvxKh4eZo0DQZ9dsgzZnRJuc9WnIeQM8yeF+CX303d1R5Puo2in3L5ISGXbydmXCD
         ItNVFjtayFOwCXL4Nqw1al9dwc6QR1M+p7htnx9uB3kubfc/6r0pjmNIVgI39P2xnDPs
         Wg7QYNsYYANwslScuSAD7KQkS0vwaoh1HPme2Q554G4vM+4gTR5WuBVd2u2TvD+TnCEf
         NFXyapWhVp2juiLaJth/CWbEQorMPRFmlGn4jZXpXSqW8dt7H+UfioeK12nC49VyoGjr
         kUXw==
X-Gm-Message-State: AO0yUKUDdzzmaLkApej1q13VP0rWeINFuxlIt2cPykvirU7jOmq6v1tn
        Sz8nCkmw4btcLUOydviHkehNpvI+rLs=
X-Google-Smtp-Source: AK7set9Qm083c3aqy+M0C06gV7T14G+/Xl0Vy7lS4Ib7TLwyPyA9rR4ZMv7DbQRS7OTZMK0L0v75BQ==
X-Received: by 2002:a17:90a:e7cc:b0:23d:294:6a5a with SMTP id kb12-20020a17090ae7cc00b0023d02946a5amr4690537pjb.22.1679088713800;
        Fri, 17 Mar 2023 14:31:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.134.179])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b0019f3cc463absm2019025plb.0.2023.03.17.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:31:53 -0700 (PDT)
Message-ID: <6414dc49.170a0220.c8539.428d@mx.google.com>
Date:   Fri, 17 Mar 2023 14:31:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0075390356816824228=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: Bluetooth: Partial support for Actions Semi ATS2851 based devices
In-Reply-To: <20230317204620.2809181-1-raul.cheleguini@gmail.com>
References: <20230317204620.2809181-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0075390356816824228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=731306

---Test result---

Test Summary:
CheckPatch                    FAIL      1.23 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      31.61 seconds
CheckAllWarning               PASS      33.80 seconds
CheckSparse                   PASS      38.67 seconds
CheckSmatch                   PASS      107.38 seconds
BuildKernel32                 PASS      30.10 seconds
TestRunnerSetup               PASS      432.85 seconds
TestRunner_l2cap-tester       PASS      16.46 seconds
TestRunner_iso-tester         PASS      16.63 seconds
TestRunner_bnep-tester        PASS      5.29 seconds
TestRunner_mgmt-tester        PASS      106.43 seconds
TestRunner_rfcomm-tester      PASS      8.50 seconds
TestRunner_sco-tester         PASS      7.81 seconds
TestRunner_ioctl-tester       PASS      9.16 seconds
TestRunner_mesh-tester        PASS      6.73 seconds
TestRunner_smp-tester         PASS      7.70 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      27.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Partial support for Actions Semi ATS2851 based devices
CHECK: Please don't use multiple blank lines
#152: FILE: net/bluetooth/hci_sync.c:4097:
 
+

WARNING: quoted string split across lines
#160: FILE: net/bluetooth/hci_sync.c:4535:
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			  "advertised, but not supported."),

WARNING: quoted string split across lines
#163: FILE: net/bluetooth/hci_sync.c:4538:
+			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

total: 0 errors, 2 warnings, 1 checks, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13179427.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0075390356816824228==--
