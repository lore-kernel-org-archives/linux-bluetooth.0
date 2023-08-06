Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FBCC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHFVAi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHFVAh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 17:00:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531301719
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 14:00:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68706b39c4cso2588923b3a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691355634; x=1691960434;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7d+xvE/EDkACZA/XyS/+3Ghc5Yr3CveXZEM7ilLYj78=;
        b=juOcKewF81BWCYuep5yabt1pqnMwGpAbDsoJ1iABT5IFKow5rQTZ+lw7em505JnOQw
         +Hzn315VVdWFOwA15e/FfPo69xFgVNdIwHhRXyqkLN8dE7Ln3rNi5PGNkBzGJKh9PLlb
         BPYq2q4WMYXVNczxyx7+mCPiOerHjYyoqkB7fryUELSbZH3lURdr/DfJeoILEZy+NF7C
         8dsOC2SbnGEjdSNvcdAKnhOMv88d6LGYAHihIKJh/nOFcYwCldzIBHxs09etejOmpJ3X
         P4YGY+NiCleXI9hpwEO3Nn7kZPJFLXPPGChPOs1ifNP6sViWG2GSZ39alaVsJ40rVGZh
         vg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691355634; x=1691960434;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7d+xvE/EDkACZA/XyS/+3Ghc5Yr3CveXZEM7ilLYj78=;
        b=iiKRRoAsyralZKGno0o/8th7ZANukhV4cHCy4nVuIQDwpSPp6mqLfnfDZEdO1b/gf1
         veARRFqMRXUd9LXbPCgI22Jy3oC2OE3GJm6Sn4UG+ALPoXu30ws3643hmsMEPLiTrqDO
         HdoJIUFXMXULNr2KgZWIevojmImO8t8WKQznYDmBer2soolEVM/1mw7TzAD/5MJgqP/0
         49aA9P2zVlYrXP6wGNuO6sxM0DwiullvfsrES7EVk5IJqIHDM2WpJ3TcnmvyGInPIe3i
         DG4Wci9KqZQ4Wy31nqxzBLggGaL7KuSKMZezDb8+5w/Tts/N6eqhUzPl6+72+fVasKAq
         p8+Q==
X-Gm-Message-State: AOJu0YwKnyCBVLpvGpuNEalzxdAnIOr91h7eZ0E1wdXZZ1sw8w9OtN5k
        x6tWoHhAnmMAAX9LT/i8H66nBBVF+3s=
X-Google-Smtp-Source: AGHT+IHCNQOFzxfi5CGOep5nUx4h0mJ9h1dZwkrM5EM1Xqf6mpzQVoMKrUMjIfMBt2Co0Joir92khg==
X-Received: by 2002:a05:6a20:8e09:b0:132:cb65:b47c with SMTP id y9-20020a056a208e0900b00132cb65b47cmr8917715pzj.43.1691355634032;
        Sun, 06 Aug 2023 14:00:34 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.0.231])
        by smtp.gmail.com with ESMTPSA id i5-20020a63bf45000000b00563397f1624sm3433142pgo.69.2023.08.06.14.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 14:00:33 -0700 (PDT)
Message-ID: <64d009f1.630a0220.1ae59.5d95@mx.google.com>
Date:   Sun, 06 Aug 2023 14:00:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2953949323672323537=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/4] Bluetooth: hci_sync: fix canceling LE scanning / CIS create conn state
In-Reply-To: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2953949323672323537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773450

---Test result---

Test Summary:
CheckPatch                    FAIL      2.55 seconds
GitLint                       FAIL      1.27 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      33.28 seconds
CheckAllWarning               PASS      36.11 seconds
CheckSparse                   PASS      40.39 seconds
CheckSmatch                   PASS      112.02 seconds
BuildKernel32                 PASS      30.97 seconds
TestRunnerSetup               PASS      485.38 seconds
TestRunner_l2cap-tester       PASS      22.99 seconds
TestRunner_iso-tester         PASS      44.11 seconds
TestRunner_bnep-tester        PASS      10.17 seconds
TestRunner_mgmt-tester        PASS      210.83 seconds
TestRunner_rfcomm-tester      PASS      15.40 seconds
TestRunner_sco-tester         PASS      18.57 seconds
TestRunner_ioctl-tester       PASS      17.02 seconds
TestRunner_mesh-tester        PASS      12.77 seconds
TestRunner_smp-tester         PASS      13.66 seconds
TestRunner_userchan-tester    PASS      10.60 seconds
IncrementalBuild              PASS      48.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,2/4] Bluetooth: hci_sync: fix use-after-free in hci_disconnect_all_sync
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#100: 
CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W          6.5.0-rc1+ #10

total: 0 errors, 1 warnings, 0 checks, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13342903.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/4] Bluetooth: hci_sync: fix use-after-free in hci_disconnect_all_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (99>80): "BUG: KASAN: slab-use-after-free in hci_set_powered_sync (net/bluetooth/hci_sync.c:5424) [bluetooth]"
17: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
80: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============2953949323672323537==--
