Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A63AEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjF0ShS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjF0ShQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 14:37:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84D196
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 11:37:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4008dbf2ef4so886291cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687891033; x=1690483033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MyyHCJLmE7njhSS3d0lPlhd9/qu/u/yhy8eVMKYK6yI=;
        b=XMFJDcKFZrvnTj1qfTifqlzkRqhfY7quaj+w89+jLe4AWf0mAXwVQOcnBbvnrg+o0H
         RlhaWW5bTf7i+3i+3T9OoBvmQk+K3wohm3d8qrBoBpuFbRwT5UWz/5rF0DMBKe4XCUNr
         l5tZoNbnyGiQcrxhn2/F/160NwHQhutc7K+DomsJv7hW8Z65dm5PiiLZmRkFJux1HUCn
         v0ARk6cfX1x+80qDEQXULCA1RcQqUmg4FDQBGcvVd1QV1jVBI+gqAMmE2UViVOI96lgi
         3xLiSrQ3aMUNI9YlfetqdFgatkDp90i+pAIw/0QdyAxYi3GOqLJWL//gDE7hIhtjVe8p
         hOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687891033; x=1690483033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyyHCJLmE7njhSS3d0lPlhd9/qu/u/yhy8eVMKYK6yI=;
        b=jptRDPpkDS/+llaKvRd2jSHSlwiRhQF55YTpk6Nq91IKJJnaYaLdEYvQQJU/lbMHAj
         6mJmf9c/lEUTLC87owZ5eEploo+fmgX1Uw63PGRI5Fi2rflXDzeZMypCAFjLvS/8ZXaY
         pIhD6wibMNryfOE1cgNbFpXnptklBRmzVXdhPANNz7G4H/b1Ret+sxUCgGa3W6M4Omq8
         ymVM54FEWaxXvc+a4dAVkWTq6bzC/0sqQRi3pP5ZTbE67a61WNPVDPqrPTMzKxmLJ8JG
         Z2s4Qzm1Z2DSdxvFvaTmTRDKif5eJpbGNWwJ9g6qiGHxZpo0O3OmtyOdV3yp6ZRx/4h0
         tATg==
X-Gm-Message-State: AC+VfDzibUa+9SeorIy1yv160Qytv+dHvOGrXmfsSWUOxCpQxpNeqRyR
        Ph534ePCoCAyVYtQEB+7pjvgui4wdoM=
X-Google-Smtp-Source: ACHHUZ757jozEp/kAmzOpoLSmEtyB0qhds5kxjUEWuWGgqW8Rj7x4W20BmKqsDQgvikSQvXgqhnEnA==
X-Received: by 2002:ac8:4e50:0:b0:400:8613:5378 with SMTP id e16-20020ac84e50000000b0040086135378mr16462400qtw.20.1687891033106;
        Tue, 27 Jun 2023 11:37:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.217.79])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e012000000b0075d49ce31c3sm2583545qkk.91.2023.06.27.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:37:12 -0700 (PDT)
Message-ID: <649b2c58.e90a0220.27db2.6f00@mx.google.com>
Date:   Tue, 27 Jun 2023 11:37:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4746480249932805801=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kuniyu@amazon.com
Subject: RE: af_unix: Followup fixes for SO_PASSPIDFD.
In-Reply-To: <20230627174314.67688-2-kuniyu@amazon.com>
References: <20230627174314.67688-2-kuniyu@amazon.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4746480249932805801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760703

---Test result---

Test Summary:
CheckPatch                    FAIL      1.86 seconds
GitLint                       FAIL      0.98 seconds
SubjectPrefix                 FAIL      0.52 seconds
BuildKernel                   PASS      32.39 seconds
CheckAllWarning               PASS      35.01 seconds
CheckSparse                   PASS      39.57 seconds
CheckSmatch                   PASS      112.14 seconds
BuildKernel32                 PASS      31.26 seconds
TestRunnerSetup               PASS      442.82 seconds
TestRunner_l2cap-tester       PASS      16.57 seconds
TestRunner_iso-tester         PASS      22.53 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      128.55 seconds
TestRunner_rfcomm-tester      PASS      8.45 seconds
TestRunner_sco-tester         PASS      7.85 seconds
TestRunner_ioctl-tester       PASS      9.22 seconds
TestRunner_mesh-tester        PASS      6.67 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      56.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,net-next,1/2] af_unix: Skip SCM_PIDFD if scm->pid is NULL.
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#148: 
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13294846.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,net-next,1/2] af_unix: Skip SCM_PIDFD if scm->pid is NULL.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[v1,net-next,1/2] af_unix: Skip SCM_PIDFD if scm->pid is NULL."
24: B1 Line exceeds max length (96>80): "WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_pidfd_recv include/net/scm.h:138 [inline]"
25: B1 Line exceeds max length (105>80): "WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_recv.constprop.0+0x754/0x850 include/net/scm.h:177"
27: B1 Line exceeds max length (82>80): "CPU: 1 PID: 3245 Comm: syz-executor.1 Not tainted 6.4.0-rc5-01219-gfa0e21fa4443 #2"
28: B1 Line exceeds max length (115>80): "Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014"
31: B1 Line exceeds max length (199>80): "Code: 67 fd e9 55 fd ff ff e8 4a 70 67 fd e9 7f fd ff ff e8 40 70 67 fd e9 3e fb ff ff e8 36 70 67 fd e9 02 fd ff ff e8 8c 3a 20 fd <0f> 0b e9 fe fb ff ff e8 50 70 67 fd e9 2e f9 ff ff e8 46 70 67 fd"
59: B1 Line exceeds max length (199>80): "Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48"
[v1,net-next,2/2] net: scm: introduce and use scm_recv_unix helper

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B1 Line exceeds max length (106>80): "Link: https://lore.kernel.org/lkml/CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com/ [1]"
27: B1 Line exceeds max length (98>80): "  * Resolve conflict with https://lore.kernel.org/netdev/20230626205837.82086-1-kuniyu@amazon.com/"
32: B1 Line exceeds max length (92>80): "v1: https://lore.kernel.org/all/20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============4746480249932805801==--
