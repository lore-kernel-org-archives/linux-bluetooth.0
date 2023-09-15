Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD36FCD37AA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjIOWgp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjIOWgd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 18:36:33 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BEF83
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 15:36:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34fc2773fa4so3265225ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694817383; x=1695422183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KIwihnEpq3AIpWwVtXNKdSezF3sHlRojDjc0QG00zCk=;
        b=Yz0xfo9blAK9nLPPF6Q6k+0K+bRKFPLDe/zSahF4s0pU6aViJthhrA9HX6IwCyITPx
         YZGm9IoPq/mYw0Ok+IktYfq9QStD6F0JLLHCG79sBZXC0YmLwGeh/L9tGTYHJTRJIhMV
         AddhAsWlIaheeycWw/pRokNTi9vt+8Zyv8TDftnCeYFn5TbHOpBBQ4dtgiAfGbZtgKVw
         KQ6JTNMv4523UTGOxyGnxQ32/J4bUwMDlYGYd2EPh5pscHjgXyekHCXYDpSWqwXmzERx
         rAtCS+wKAHCalhSVh2jFt5d/V1DAXC931XDkTZTBvbKNRJ+aCVkpGERIEBWJEareuzbS
         Nf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694817383; x=1695422183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIwihnEpq3AIpWwVtXNKdSezF3sHlRojDjc0QG00zCk=;
        b=WJiApv4EG1Pv9fgkGqvKdNNjmrRcjjoPdoIG+4RCgkAomdaKybRm9DaYaj6B0SIgwc
         YJ1GFBsRTQhgNfj/8S9FsLFs4Fij+d1bcKr00IH3QrHRRd3QBXC3bKT66reXz8MwSjjy
         gKgcJc+0EXCqYJKqRGVIDuZojEDZYI1gHBf6+ov2zgidlRQEp7e+PsRQSOwbyr5W79Bx
         v33z4siXRh5FTorHTl6XCOErYRVH+Up6AjH3toKHNhIiDEZXrci8XluVfd0VdBWWNRz6
         6R31RHjlk0KwqNvmO/DqJwUlC8/+bCtgAkPUcamlNb0yXHoUsYt67bPpSPt46bkQsjkh
         rNsg==
X-Gm-Message-State: AOJu0YzQlErbSH2hR96C2+cl/qmBiVKXSeXPU5TBD6mfwl5/P2+oEwIW
        pYrjZvV9XwnChjaLgsSC0lsVAMCTJIc=
X-Google-Smtp-Source: AGHT+IGShqTm2fgEgDvjvZZyyM7gUXm0/ZElLMlitCvDmK8KuZzReOvG3m8J5D/VJ/x2gugGPeVmuA==
X-Received: by 2002:a92:c563:0:b0:343:c8b1:b7f0 with SMTP id b3-20020a92c563000000b00343c8b1b7f0mr4297876ilj.23.1694817382804;
        Fri, 15 Sep 2023 15:36:22 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.112])
        by smtp.gmail.com with ESMTPSA id g25-20020a02b719000000b00439862fc2a7sm1260975jam.130.2023.09.15.15.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 15:36:22 -0700 (PDT)
Message-ID: <6504dc66.020a0220.cc7f9.1c22@mx.google.com>
Date:   Fri, 15 Sep 2023 15:36:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5960513270637905060=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_core: Fix build warnings
In-Reply-To: <20230915214412.3611547-1-luiz.dentz@gmail.com>
References: <20230915214412.3611547-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5960513270637905060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784843

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.59 seconds
CheckAllWarning               PASS      37.42 seconds
CheckSparse                   PASS      43.00 seconds
CheckSmatch                   PASS      115.38 seconds
BuildKernel32                 PASS      33.58 seconds
TestRunnerSetup               PASS      509.12 seconds
TestRunner_l2cap-tester       PASS      31.24 seconds
TestRunner_iso-tester         FAIL      55.28 seconds
TestRunner_bnep-tester        PASS      10.81 seconds
TestRunner_mgmt-tester        FAIL      234.75 seconds
TestRunner_rfcomm-tester      PASS      16.39 seconds
TestRunner_sco-tester         PASS      19.65 seconds
TestRunner_ioctl-tester       PASS      18.85 seconds
TestRunner_mesh-tester        PASS      13.54 seconds
TestRunner_smp-tester         PASS      14.42 seconds
TestRunner_userchan-tester    PASS      11.17 seconds
IncrementalBuild              PASS      32.28 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 97, Passed: 93 (95.9%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       0.408 seconds
ISO Connected Suspend - Success                      Timed out    2.435 seconds
ISO Connect2 Suspend - Success                       Failed       0.515 seconds
ISO Connected2 Suspend - Success                     Timed out    2.723 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 483 (97.2%), Failed: 11, Not Run: 3

Failed Test Cases
Set Static Address - Success 2                       Timed out    2.391 seconds
Suspend - Success 1                                  Failed       0.264 seconds
Resume - Success 2                                   Failed       0.279 seconds
Suspend - Success 3 (Device in WL)                   Failed       0.293 seconds
Suspend - Success 4 (Advertising)                    Failed       0.292 seconds
Suspend - Success 5 (Pairing - Legacy)               Timed out    1.858 seconds
Suspend - Success 6 (Pairing - SSP)                  Timed out    1.993 seconds
Suspend - Success 7 (Suspend/Force Wakeup)           Failed       0.271 seconds
Suspend - Success 8 (Discovery/Suspend)              Timed out    4.683 seconds
Resume - Success 9 (Discovery/Suspend/Resume)        Timed out    3.990 seconds
Resume - Success 10 (Multiple Suspend/Resume)        Timed out    5.987 seconds


---
Regards,
Linux Bluetooth


--===============5960513270637905060==--
