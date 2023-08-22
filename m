Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E38EE49AB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 21:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHVVFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjHVVFs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 17:05:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D346CD7
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 14:05:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a7d4030621so3011834b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692738337; x=1693343137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0OJcoqaVSxkebl4XBVvusypfXgxPS2/Dv3t/RnfJczI=;
        b=ADHzr2p55ID++OK5GbTGo9eBI98pVfJNNlss97ZSKPh6WVSgjeiX7zCVdQsi7xPO05
         IvNLN7vnVSQNMNcUKy+eIVsm97xn3W9Eg/gnq2n7dW57CXgC4xGx0GE6mTIgci/Ooflm
         Km8UzP6RbzTNfYaBsq3AQBvNLuE9KjJpEINPocgeZRwDQ+U7YOVAwF8a4HozLAU/H+hH
         Sx707lhZu95yCtaJL0prKdtK91sPlDqRM/+6iq2KdN1UrUenr2OCxrb5muJmQLAnNq7X
         ti7AXJ83ZAg/+0IxCbDZOzVEcanAdqDMGCDzqQ2q/OVX23dArE11x9dVFvjr/YG1qQLj
         aXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692738337; x=1693343137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OJcoqaVSxkebl4XBVvusypfXgxPS2/Dv3t/RnfJczI=;
        b=a/HrFsZbA9HM/giFjXI69x5jmME7s8hjC3BczmoCkw4Mds/RshtDLrspA+EKgKBR/A
         er1doa88YG3FvJrUvHcBPM93V97+hh7yuLIbgANgpEKAmN3YC9zXy6oU5OWZMfPpBkw0
         KV9ucMHIpMgqb4buwgWz5Ze4O+oXU6LmUW9nyTnv+pjCKozxoROyc8Rr+xpRkgQI5K5G
         /ocOezb//LtSlLBTBgsLrBHY5AjbHRRgXD4pDMxgli5ynopvAmwV1dyNzIxQLcatyXeZ
         RWiDqjnzclYh/T7e0y9PSI2J6cojuxSZr+9PhmSS42dop41BzjShD2HH3WDDXbVvG5Pb
         Iunw==
X-Gm-Message-State: AOJu0YzFxClptBVm9da8lb2mKEMEBEo6eytbksXzm6EEThNPLJ84O+Um
        X6E/1DG1gyz1yIxQ+f0dPdFoLv7OPNo=
X-Google-Smtp-Source: AGHT+IHitQM1yWC5/FP6Q3XGgcSbIApwKIvqBUOEUq4wgey279jWvZb34c7boP/6D/R4F+GoMXtokg==
X-Received: by 2002:a05:6808:3a8c:b0:3a4:8a41:c69c with SMTP id fb12-20020a0568083a8c00b003a48a41c69cmr10195285oib.13.1692738337453;
        Tue, 22 Aug 2023 14:05:37 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.150])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cab12000000b0064f50e2c551sm625799qvb.1.2023.08.22.14.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:05:37 -0700 (PDT)
Message-ID: <64e52321.0c0a0220.839b.3884@mx.google.com>
Date:   Tue, 22 Aug 2023 14:05:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3703386927278619872=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <20230822202726.3757640-1-luiz.dentz@gmail.com>
References: <20230822202726.3757640-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3703386927278619872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778353

---Test result---

Test Summary:
CheckPatch                    FAIL      1.68 seconds
GitLint                       FAIL      0.62 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      39.37 seconds
CheckAllWarning               PASS      43.21 seconds
CheckSparse                   PASS      49.19 seconds
CheckSmatch                   PASS      133.67 seconds
BuildKernel32                 PASS      38.09 seconds
TestRunnerSetup               PASS      578.49 seconds
TestRunner_l2cap-tester       PASS      33.27 seconds
TestRunner_iso-tester         PASS      70.78 seconds
TestRunner_bnep-tester        PASS      13.74 seconds
TestRunner_mgmt-tester        PASS      255.28 seconds
TestRunner_rfcomm-tester      PASS      20.06 seconds
TestRunner_sco-tester         PASS      23.47 seconds
TestRunner_ioctl-tester       PASS      22.77 seconds
TestRunner_mesh-tester        PASS      17.02 seconds
TestRunner_smp-tester         PASS      18.09 seconds
TestRunner_userchan-tester    PASS      14.38 seconds
IncrementalBuild              PASS      37.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
WARNING: quoted string split across lines
#155: FILE: net/bluetooth/hci_sync.c:4671:
 			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

WARNING: quoted string split across lines
#158: FILE: net/bluetooth/hci_sync.c:4674:
+			 "HCI LE Coded PHY feature bit is set, "
+			 "but its usage is not supported.")

total: 0 errors, 2 warnings, 0 checks, 45 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13361444.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (116>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#"


---
Regards,
Linux Bluetooth


--===============3703386927278619872==--
