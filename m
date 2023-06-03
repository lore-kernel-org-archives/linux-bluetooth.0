Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1590EC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 02:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjFCCjw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 22:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjFCCjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 22:39:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B2E52
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 19:39:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75d401ec8fbso14183985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685759970; x=1688351970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AlnBsbChCU4jgruJPkR/6cQ+ILJz+xY1jDZknx7YUv8=;
        b=AphNstrGFtxopssASgDsU+JS/O0zQlkAfyyH2DdiLk/6hxCoE/EHBHIL74epVJToJk
         uiQbuN6ok8wbVYiQ2OHeIHqJV5IRpwG0/R6s63foJ5ibNolg/CyAHaYYDzxTTLjZirSH
         TBB5pdoYsz03mBTCpCjyMm+QuwYlkWQVGPShmj4KfFegCsILE8uPkwN/b0XcAKgq2+60
         xkRZFAswtAwnHE4/gNwH3r9XqdsHb1qWltdPsO0xwQFkbJ0fPDrNibqqjCyeA4S44kUj
         i07Kzx8zobhkly+Ks+BnqurJ/hzd4DqgeJ3x76Dt4EedEbb76dGlOwKrbWI9PsCezojR
         ZKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685759970; x=1688351970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlnBsbChCU4jgruJPkR/6cQ+ILJz+xY1jDZknx7YUv8=;
        b=IdW/hXlOItbwdvdJbOnPJN2HXQ7HvhoLF+Qrdkaytr/AeF1WDGGoESa5znuiyziYhc
         gSUKQ9Lh+M3FQC85bu7FDWWpBXbhw6gGUIYPlnyZyHOVhTEPuHVueIM5lzcOE8/j88nt
         I8xjbBEFE56uetoliR6f4yGimm32IDyeyoXLpzZ8uG1ECMqkhxQtB59kVTgMR3LrBGAc
         NK+6GFf4DT6Lkkty9YumP+JfK/cox6z34jsUlwkfGzOwKXLPOuHW5usZlXRdPiRafvYv
         b7CRZ6q9rCK53slsNv61DGMX2//sSREQntWCA3LizFcNqHLONDevyeGlQcdYzgD0zNZ+
         DmQA==
X-Gm-Message-State: AC+VfDy6xY3TOs2sBv6zJgzmdjT/AkAa8t4Qvu/fL81M1xyoulyNtIar
        +UJrwFnaaGd3SCeQN1mWrV2N7G5nppE=
X-Google-Smtp-Source: ACHHUZ6Y5Qjptgljsp4W3C3abvz62L96ssBbNQSI7VMGBhHE2hOvTBxRHOY19D+gwBodJmApUdc42A==
X-Received: by 2002:a05:620a:201e:b0:75b:23a1:8321 with SMTP id c30-20020a05620a201e00b0075b23a18321mr13735795qka.28.1685759969445;
        Fri, 02 Jun 2023 19:39:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.76.16])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a079000b007578b6d060bsm1310214qka.126.2023.06.02.19.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 19:39:29 -0700 (PDT)
Message-ID: <647aa7e1.050a0220.93d4a.4120@mx.google.com>
Date:   Fri, 02 Jun 2023 19:39:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4868014688119207909=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: Consolidate code around sk_alloc into a helper function
In-Reply-To: <20230603001628.1886596-1-luiz.dentz@gmail.com>
References: <20230603001628.1886596-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4868014688119207909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=753707

---Test result---

Test Summary:
CheckPatch                    FAIL      4.15 seconds
GitLint                       FAIL      1.28 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      31.88 seconds
CheckAllWarning               PASS      35.25 seconds
CheckSparse                   WARNING   40.12 seconds
CheckSmatch                   WARNING   109.66 seconds
BuildKernel32                 PASS      31.13 seconds
TestRunnerSetup               PASS      444.91 seconds
TestRunner_l2cap-tester       PASS      17.19 seconds
TestRunner_iso-tester         PASS      23.46 seconds
TestRunner_bnep-tester        PASS      5.67 seconds
TestRunner_mgmt-tester        PASS      118.19 seconds
TestRunner_rfcomm-tester      PASS      9.10 seconds
TestRunner_sco-tester         PASS      8.45 seconds
TestRunner_ioctl-tester       PASS      9.79 seconds
TestRunner_mesh-tester        PASS      7.14 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      5.95 seconds
IncrementalBuild              PASS      62.78 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,3/3] Bluetooth: hci_sock: Forward credentials to monitor
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
          Data: 020203000110270000022800020a00409c0001000110270000022800020a00409c00

total: 0 errors, 1 warnings, 0 checks, 136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13265972.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,3/3] Bluetooth: hci_sock: Forward credentials to monitor

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B1 Line exceeds max length (84>80): "          Data: 020203000110270000022800020a00409c0001000110270000022800020a00409c00"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structuresnet/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4868014688119207909==--
