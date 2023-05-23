Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCC1C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 19:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbjEWTdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbjEWTcz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 15:32:55 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C36196
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 12:32:29 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6237c957c5aso31892946d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684870330; x=1687462330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yXPnVe7R4xiAoQCSE2Wr3LJ4A+XF1aMUcnKvmu8e1TU=;
        b=cjOa0YHyVrqUP+rHGZBA79d9LnOkTVWe/jTru9ZK13KUsSIyWvwj4Wsfxaar7+xgAd
         P7uHaCSh/mCzC6H2SGIEs45bC+PuJu9egVoQ690I9Qgdq4Qcsnx2wgFqdoTgf2Di23cD
         7hXt/iO7f6GUKq2sCymX7i/06WRgu1w2q3G/adREuGa0SUze/+PwO4f/q9Sa+AGbBN6T
         hqi0GpAx3lcRw2LAgIZ5dWZNRoQIydB55/ni195uyu031fIq5ATYX1PruylKGbGOlslw
         Vn6IMnyekzQ5chcabWw60ujtVjl34RpkUXTs96nuuAplPqh0S4OvpJ3cdB+z9IWVRMgr
         qtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870330; x=1687462330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXPnVe7R4xiAoQCSE2Wr3LJ4A+XF1aMUcnKvmu8e1TU=;
        b=bMoWn7Eerm9cHuZ4MRUtboruu5NMQ1FpYAAge385ohqWnAPeMbdbyGTpIGL2qW7pbP
         ATNJeTor15Ac/cv8s36nIuIANf/vhUEF2iWzorSsXywFTF9S1cjwVQvCwgfwaEIfpGFD
         nP3WeGUmYBAh+a8FxD4TwFwBiIfQRg24ElYsCTZdxqpF41kd0pqlfBSCkhzMBjLHWObF
         geAJIyw754Z2HWFd0f6oI8cZgefK0FT4u3VXkOPjAWLO9YqOlG4rP4J2d3zr0jwHQd2z
         P+699xr4cmkZLwo7u5VNOwAv80FhsGBxHYEXtk0uiF/6K05Bt9vzNk6CYfz2B/kjOeUG
         5m0g==
X-Gm-Message-State: AC+VfDxTwjzCOcQRt49T34wGjS1nVsgbi3rv0tG2r6UGXI4IWsi1cN22
        PBHG3DOWMY+gQdAgRKsC6dMAdBR81RM=
X-Google-Smtp-Source: ACHHUZ4qSFa1SUfQSYwhG8uKAMLwcA6ihfknv5nMnxwuKjpiTsIhzdBpXATX+QcAF2tqshDmr6Z6Rw==
X-Received: by 2002:a05:6214:c46:b0:5f1:606b:a9ca with SMTP id r6-20020a0562140c4600b005f1606ba9camr21566451qvj.37.1684870329749;
        Tue, 23 May 2023 12:32:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.24.66])
        by smtp.gmail.com with ESMTPSA id bz16-20020ad44c10000000b00621253d19f9sm2975734qvb.98.2023.05.23.12.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:32:09 -0700 (PDT)
Message-ID: <646d14b9.d40a0220.c3de0.d21a@mx.google.com>
Date:   Tue, 23 May 2023 12:32:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1432929457296869868=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in bt_accept_unlink
In-Reply-To: <20230523190347.2584368-1-iam@sung-woo.kim>
References: <20230523190347.2584368-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1432929457296869868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750377

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.08 seconds
CheckAllWarning               PASS      36.09 seconds
CheckSparse                   PASS      40.84 seconds
CheckSmatch                   PASS      110.21 seconds
BuildKernel32                 PASS      31.86 seconds
TestRunnerSetup               PASS      452.30 seconds
TestRunner_l2cap-tester       PASS      17.47 seconds
TestRunner_iso-tester         PASS      22.33 seconds
TestRunner_bnep-tester        PASS      5.71 seconds
TestRunner_mgmt-tester        PASS      116.58 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      8.46 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        PASS      7.29 seconds
TestRunner_smp-tester         PASS      8.28 seconds
TestRunner_userchan-tester    PASS      6.02 seconds
IncrementalBuild              PASS      30.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix use-after-free in bt_accept_unlink
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#75: 
CPU: 0 PID: 128 Comm: kworker/0:3 Not tainted 6.2.0-00001-gef397bd4d5fb-dirty #58

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 3ad340b7a678 ("Merge 6a1cd83c73a590cbf19d2bd75c22dc551bcf2170 into 04c0ec2ca4c0e76c6c9833f8e58909a86aad3e44")'
#207: 
Fixes: 1bff51ea59a9 (Bluetooth: fix use-after-free error in

total: 0 errors, 2 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13252806.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Fix use-after-free in bt_accept_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (90>80): "BUG: KASAN: use-after-free in bt_accept_unlink+0x77/0x1f0 net/bluetooth/af_bluetooth.c:189"
7: B1 Line exceeds max length (81>80): "CPU: 0 PID: 128 Comm: kworker/0:3 Not tainted 6.2.0-00001-gef397bd4d5fb-dirty #58"
116: B1 Line exceeds max length (91>80): "page:0000000067fcb39f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x104d58"
117: B1 Line exceeds max length (89>80): "head:0000000067fcb39f order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0"


---
Regards,
Linux Bluetooth


--===============1432929457296869868==--
