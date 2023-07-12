Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EEEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 04:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGLEj0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGLEjY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 00:39:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C8139
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 21:39:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-767ca28fb32so13704185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689136762; x=1691728762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HnYSYZdUyzGTsdHp0hLh4I+zD2spM9ogeISavqWbDsw=;
        b=J1mfU50emBAnLuMNfZqM/3Z3vEA1SqNvys6Ryo/A8FybOnA31D4CWhNw6L0bv5Hmnx
         +D6o8RRB7Kmem8O7ZQAyx0VvglY8oN69/165GmbtTIwlv8nsBIMInFJ+kRenGKUeuYcv
         5bjHDEf9q2Uh3vGEVa1III8Nn6l13FHXHdSXZ+rNrKCupcxdfapKPhfPM+MvKIFKgFKQ
         OQfo39ajK0X9phzkH27xf3JFeCRnE7RLkGsQteBstLR62FObo64nitQ3CViSVk7j3HYC
         bkthQ6GBHwC6LJfac65vM3tmGUPfYMF6vkTnNDJzJhAef/8Vft1bP8cYtZXvBlhpocgT
         2faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136762; x=1691728762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnYSYZdUyzGTsdHp0hLh4I+zD2spM9ogeISavqWbDsw=;
        b=dtPrrqYWIwfp4bKqPpr4aBN86sqrcG6YLNBgEYWkvCo8hzxSKlhaen1QT6Tmc7PzhX
         nWam0o155e7bk4OJGudRPyJK53VubLgf1Hr0fRdgn9Edb2NASP2yaMHIsBpodTK91br5
         xfkLHrq72YCeWp72wKHA61qESlMWqZX3LpGlQRqhVVTKrA7Z5mzH9RpBRxak5vGYCPvr
         7wymTDa5lLZKo3T3umwL3PN8BPQvggGoruiqfdU2JeeAPsBB5lmPlg1Pfrs2IWkmuZDs
         7BHLvopZ/5V42KKP0xzp9sjw533Vt3MC004QFRyln/0NJ6Lo+tJe0EG8EhYAmZCS9cm0
         NDmQ==
X-Gm-Message-State: ABy/qLbQQKKSrLMCKs5xrY0vw0k87Omm46XGVCCllwbqDhmQneTcfF9Q
        /i0zexdyuILEBpZlPEAf7zw8Lf2Qofk=
X-Google-Smtp-Source: APBJJlE2H8MANE8Z7T/N6az0ytVSoUSDugY8DAQy6WjeeDiPSs+2iXjKE3vJ6KV6UDLY8AQiLKle8Q==
X-Received: by 2002:a05:620a:1792:b0:765:5a1f:89 with SMTP id ay18-20020a05620a179200b007655a1f0089mr865331qkb.13.1689136761977;
        Tue, 11 Jul 2023 21:39:21 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.203.193])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00767cfac77c3sm1774567qkl.134.2023.07.11.21.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:39:21 -0700 (PDT)
Message-ID: <64ae2e79.050a0220.6992e.580a@mx.google.com>
Date:   Tue, 11 Jul 2023 21:39:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4697270334922067771=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: Fix null pointer when processing coredump
In-Reply-To: <20230712034206.12484-1-chris.lu@mediatek.com>
References: <20230712034206.12484-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4697270334922067771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764635

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.41 seconds
CheckAllWarning               PASS      37.07 seconds
CheckSparse                   PASS      41.83 seconds
CheckSmatch                   PASS      112.94 seconds
BuildKernel32                 PASS      32.24 seconds
TestRunnerSetup               PASS      494.86 seconds
TestRunner_l2cap-tester       PASS      23.46 seconds
TestRunner_iso-tester         PASS      42.33 seconds
TestRunner_bnep-tester        PASS      10.63 seconds
TestRunner_mgmt-tester        PASS      220.73 seconds
TestRunner_rfcomm-tester      PASS      16.10 seconds
TestRunner_sco-tester         PASS      17.10 seconds
TestRunner_ioctl-tester       PASS      18.45 seconds
TestRunner_mesh-tester        PASS      13.72 seconds
TestRunner_smp-tester         PASS      14.62 seconds
TestRunner_userchan-tester    PASS      11.37 seconds
IncrementalBuild              PASS      30.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btmtk: Fix null pointer when processing coredump
WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
#82: 
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
---

total: 0 errors, 1 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13309551.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4697270334922067771==--
