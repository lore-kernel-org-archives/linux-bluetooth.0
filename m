Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 03:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiGBDLM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDLL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 23:11:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF63B3C5
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 20:11:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id he28so2260146qtb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 20:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=d3SqsiTsvPOheIXIN7eeBDsDuXsgKJVIvhQzfAD6Gr8=;
        b=XJUQx8HoOlqW4GHWTwfjeWknfcIbYaQO198MON7IciDh67SMX7k1jOKFhD9gEkt1gN
         RqrdPj4o6/OwNMUpqTuPeyK/P4R/EaruGxjHxzfq3wOMMDP7pG8IUwAUghVMGZW8ZE+8
         YmI5cEb71pDoLufbqGXXFkccFwyhdBTdsEmYpr3oh67BZnDM8DxnpEErz222CpSDtdlQ
         AH+cFqhWvYvIHtAPA5O1YHaXPDBizIZao/umZiGIH1o/Nb/VSOuUH7jtnvzCzXNWmIPf
         bzBYgRMI884+oEqQ9dvLdLy4zGNS2udBpGWo5qloIlXqda3L40yds1SHLPZApT9KL5Ci
         KpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=d3SqsiTsvPOheIXIN7eeBDsDuXsgKJVIvhQzfAD6Gr8=;
        b=lMlnr7MGXe/XRZXtV7mgW2jLF6EjjFyWOSf72Ctr2qKx6ggLPOQ89GtSCr9VqL6c3I
         qsqwfTLds9RQ9T/SNXvmvxBOJPWQrOcQ7Elz0hHB2EaVDb5vJ9qLZ1PSR9BCD3zXTY2s
         5cIoYoWgFIK1PsN0CJE04QALVB3ohZD9XizDknr4CSOlq5ALkA8X9UK7hNZxsCqKg15i
         PuTJ7oCWNN7DliHfvUp+kNyZ0bdc3ni9Lb2kMlAiFjP+pLE1FNzr+s039c7BGnHITIn2
         r2HyhDUwkVx8rR6OPYlQNN7v2MLE6JnLsP+YV4NExLbXICg789kFXlBYYhkdN5qTDoog
         Bebw==
X-Gm-Message-State: AJIora9zovT+qZGBfXuiI4vcoC39ZmhmCQTdgeapStsRVHEk4cRRK8dZ
        TBNAcvxbajUOB/+g09A346TDBepBmVM=
X-Google-Smtp-Source: AGRyM1tKJWDbkOCOm1guLF15Kzdcr+YZzJIHHV78GjtntZ5x5Ss4C3zSBo/dbNPTLHH+wZ+lqaoG4Q==
X-Received: by 2002:a05:6214:20c6:b0:470:5525:390e with SMTP id 6-20020a05621420c600b004705525390emr19068422qve.39.1656731468476;
        Fri, 01 Jul 2022 20:11:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.155.134])
        by smtp.gmail.com with ESMTPSA id g84-20020a379d57000000b0069c72b41b59sm18838481qke.2.2022.07.01.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 20:11:07 -0700 (PDT)
Message-ID: <62bfb74b.1c69fb81.44323.bcc1@mx.google.com>
Date:   Fri, 01 Jul 2022 20:11:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9109462966227638877=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v6,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220702001748.1003783-1-luiz.dentz@gmail.com>
References: <20220702001748.1003783-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9109462966227638877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655963

---Test result---

Test Summary:
CheckPatch                    FAIL      11.79 seconds
GitLint                       PASS      7.58 seconds
SubjectPrefix                 PASS      6.52 seconds
BuildKernel                   PASS      39.92 seconds
BuildKernel32                 PASS      35.22 seconds
Incremental Build with patchesPASS      203.93 seconds
TestRunner: Setup             PASS      576.19 seconds
TestRunner: l2cap-tester      PASS      19.53 seconds
TestRunner: bnep-tester       PASS      7.02 seconds
TestRunner: mgmt-tester       FAIL      113.63 seconds
TestRunner: rfcomm-tester     PASS      10.95 seconds
TestRunner: sco-tester        PASS      10.53 seconds
TestRunner: smp-tester        PASS      10.69 seconds
TestRunner: userchan-tester   PASS      7.19 seconds

Details
##############################
Test: CheckPatch - FAIL - 11.79 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v6,3/7] Bluetooth: Add BTPROTO_ISO socket type\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#177: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 1718 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12903856.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 113.63 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
Read Exp Feature - Success (Index None)              Failed       0.111 seconds



---
Regards,
Linux Bluetooth


--===============9109462966227638877==--
