Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73763C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 23:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjEBXc3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 19:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEBXc2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 19:32:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ABB3591
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 16:32:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5465fb99so3555493b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683070347; x=1685662347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QZZrqVhIZu+ZS94Oc1C+GFJGMXC0JZehKAUyz0IFvQw=;
        b=l4BzVnLQu5AXa4EKowFBI1B14sn5r6YiobkuFlhLkXLuof+dHsNx0VvXRXc06yHG5i
         pJ4ISQ76x3XXhEK4Uzlr/MBdxVBnuCz7RqQBWRyaRDx9ydGiFAejbTLXSoSqgUtVPmte
         NTQt1nH1myZlQVfhKEmEWl0ztwQFyLyyGl8f1HS7lareyUYVRzSPV0UR/vN+mFTxNfuU
         SZRF8QmhqJ/87Y0YKYjh8bLYIHly/1VV8gLNi2qnwE/xZ8cT2lDAdLO4JyBIhTBuAds6
         8x0SmO/y/v/3x24kiAOsCoEW6yVpwofuVDrtlLF39Nlz6WvH9jA6+1UCaUQ+wdocrYos
         x7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683070347; x=1685662347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZZrqVhIZu+ZS94Oc1C+GFJGMXC0JZehKAUyz0IFvQw=;
        b=AOOgYl8u+ktlcVvdX25lDGKJjNdGI+PRWCe/akB/9X/A20Hc+qN8w+xF9HTB1Z42ZE
         IgO0IbKu6DV0yZ72O24nmK5MHmdmtgfxIvqG/z2B5iBCUlmIXmEM22vGzw/EtUvxZ5w8
         ZtxOAxEN3Qy9qhwQS+5EdAyMy58bVzByFYIk3FUDEQQUYNWAkBOwd6jCOOxmqMmcUbvg
         vDGN/tKEcv78QbmbQcsyYppiidSTYK9xCosTmoW0yPSJT0zfyvFfYOx4xjrSdv+9mLJX
         odNVdBGPRbTroQaTkO/uBoSyoPTY0q6GxzJM1MwxgFC/XyDah0pJLfGkCZg/NqZeLGwX
         trfg==
X-Gm-Message-State: AC+VfDxCY/4RBt2QU00a+PjPmwUzjBDaOcTO+x7V3H7pvvsLQ/7mJ+J+
        JzlPqqSYHFzGfOlmc+Cwyyf/1raA+sA=
X-Google-Smtp-Source: ACHHUZ7xcQpRg0oMr/pzQtuDYrLfj9N0/LKcEU0ZfamFklwXmRXXoYy9nMhmjhggUs1C8z+DAtxbhg==
X-Received: by 2002:a05:6a21:339f:b0:e9:5b0a:deff with SMTP id yy31-20020a056a21339f00b000e95b0adeffmr24037792pzb.22.1683070346994;
        Tue, 02 May 2023 16:32:26 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.0.230])
        by smtp.gmail.com with ESMTPSA id a22-20020a62d416000000b0063f9de332f8sm17118582pfh.167.2023.05.02.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 16:32:26 -0700 (PDT)
Message-ID: <64519d8a.620a0220.73244.3d2a@mx.google.com>
Date:   Tue, 02 May 2023 16:32:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0656462902792029262=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v5,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
In-Reply-To: <c90f4606c85f5862e2e3e1dc330af4ac95f2bc9f.1683065391.git.objelf@gmail.com>
References: <c90f4606c85f5862e2e3e1dc330af4ac95f2bc9f.1683065391.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0656462902792029262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744518

---Test result---

Test Summary:
CheckPatch                    PASS      2.52 seconds
GitLint                       FAIL      1.07 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      32.25 seconds
CheckAllWarning               PASS      35.15 seconds
CheckSparse                   PASS      39.68 seconds
CheckSmatch                   PASS      110.69 seconds
BuildKernel32                 PASS      30.98 seconds
TestRunnerSetup               PASS      440.96 seconds
TestRunner_l2cap-tester       PASS      16.53 seconds
TestRunner_iso-tester         PASS      20.25 seconds
TestRunner_bnep-tester        PASS      5.29 seconds
TestRunner_mgmt-tester        PASS      112.02 seconds
TestRunner_rfcomm-tester      PASS      8.47 seconds
TestRunner_sco-tester         PASS      7.87 seconds
TestRunner_ioctl-tester       PASS      9.17 seconds
TestRunner_mesh-tester        PASS      6.66 seconds
TestRunner_smp-tester         PASS      7.74 seconds
TestRunner_userchan-tester    PASS      5.50 seconds
IncrementalBuild              PASS      40.80 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v5,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding"


---
Regards,
Linux Bluetooth


--===============0656462902792029262==--
