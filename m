Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ACBC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjC3WcZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjC3WcY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:32:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDDE1BE1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:32:23 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 31so15314879qvc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680215542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh0D3nJUSyyLy4AKNr74El1poklH37HZcnSVFwA27SY=;
        b=XUgzfZDOraIp0buwtVFCGvp4R/Cx91FtAyWF78QBV87eFCpCcxtxrHDMkpJHoxhTsw
         nbRPueRXnhuZHFbMOPrViCWSloBQp6QW43L6l5lRLXVwECJr5XZkemfcWfMKjS3diED5
         kB2s+fB4Yg7P1OPpWCgndH5N7mu3/YgdUV/KkOLqfG5yuqW5Uzx8TXzXkdiaQqHUGjV+
         EWNdNrYMvFUxmtHrv6DTSB3bAD/cb3TRUPwtSXn9wsaanUXYdequHmpLRTuSrh8d4iTk
         siJRQXb7xJJ/tf+NJeKYKtNDIuDtRthYXwWkO5Zq4E8gv5kuFhkKcelzQagF0L2L32xS
         LmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh0D3nJUSyyLy4AKNr74El1poklH37HZcnSVFwA27SY=;
        b=kP38R3ZlQ5m1LclRgt5IsAeD9Pb6nMFrGoZcgEYUyjEwzr4DL89uVRQXbiuHZPN7KM
         j0neasvukv03six+mxIibZj/DBoAk2r6FC25p2r7Xz3zdab/QXXPSgcP4NUeEAocsz3g
         sczWdDKIZ1s7FceCCh1o2mYb+XIgP6aBv67Fls/WBmUQvo9qUcBIdugMOQTayrLcB+eu
         uhFPDpXWL6FuKAkMILJ0oT6ARRmR9f2pLsYoKcYQi8r6+2swDczKj6tdw0oO03Mvhhwa
         0wC7RNAqOKr+78XRMSTY/DWpq5zr5Xl6tV8tdveEDKuGEX/pcnAIjfBNL88cQpPucxIr
         bQnQ==
X-Gm-Message-State: AAQBX9cJE/xxriM07e9K7/Ns0OhS63JDd9DyipVrZ0gytYJ7wKrMV4uv
        g2FU7RQ5k+5+JRZHrTvGPLdHGVH39x0=
X-Google-Smtp-Source: AKy350awtJXQMhFXfzUYG0Ry7QSQ68WXWEYOCCAOTv019Xfwiw7R61rPkgMlXATtXYxJHNwVvFNUzw==
X-Received: by 2002:ad4:5de8:0:b0:5c5:95db:859c with SMTP id jn8-20020ad45de8000000b005c595db859cmr39546209qvb.33.1680215542489;
        Thu, 30 Mar 2023 15:32:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.82])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b0074269db4699sm201882qkp.46.2023.03.30.15.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:32:22 -0700 (PDT)
Message-ID: <64260df6.050a0220.1b610.173b@mx.google.com>
Date:   Thu, 30 Mar 2023 15:32:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4425224271472779781=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix double free in hci_conn_cleanup
In-Reply-To: <20230330220332.1035910-1-luiz.dentz@gmail.com>
References: <20230330220332.1035910-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4425224271472779781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735599

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       FAIL      0.92 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      31.54 seconds
CheckAllWarning               PASS      34.24 seconds
CheckSparse                   WARNING   38.81 seconds
CheckSmatch                   WARNING   108.45 seconds
BuildKernel32                 PASS      30.22 seconds
TestRunnerSetup               PASS      432.40 seconds
TestRunner_l2cap-tester       PASS      15.85 seconds
TestRunner_iso-tester         PASS      15.51 seconds
TestRunner_bnep-tester        PASS      5.08 seconds
TestRunner_mgmt-tester        PASS      107.05 seconds
TestRunner_rfcomm-tester      PASS      8.07 seconds
TestRunner_sco-tester         PASS      7.52 seconds
TestRunner_ioctl-tester       PASS      8.65 seconds
TestRunner_mesh-tester        PASS      6.45 seconds
TestRunner_smp-tester         PASS      7.39 seconds
TestRunner_userchan-tester    PASS      5.30 seconds
IncrementalBuild              PASS      33.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix double free in hci_conn_cleanup

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
34: B1 Line exceeds max length (87>80): "Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]"
[2/2] Bluetooth: SCO: Fix possible circular locking dependency sco_sock_getsockopt

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[2/2] Bluetooth: SCO: Fix possible circular locking dependency sco_sock_getsockopt"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4425224271472779781==--
