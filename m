Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2251C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiHPWBj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiHPWBi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 18:01:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4978F944
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:01:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so2306718pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=LI24Ol4FURSAfjcTvQGAL1cwFzO+P4qp2ws2Mqh0goU=;
        b=qEQPQmfdPgcIgo95tkWmVhjbfnz3hdcS8916SMbT23u+ixqE0qeq38c/ah9kC3dn97
         IwLdZhxzm2jOWILWuM+ermTgaYnY9Y6QzvClMilLXCzR8sYm7oJAXnEoJeeaqMeHoRP8
         1c+WJizSPA3Fo18MD6RGG+lux2WQbqyx5uOs3HEVv4/gy4q0I0fQg8tCW2fnnZL0s8MD
         jxMNlwOkFCgi0d3jB/vAdu+GHMVQe1SFySl3YS9AF7DM91Wh/Bq+mK8mWJ4I2a2wH995
         MLzdBFp0L46VHgFqwj3WNrWTgYw75LbQVBzkEItMJlJhCJjDVEqGhdN7EDeO00y9039u
         GBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=LI24Ol4FURSAfjcTvQGAL1cwFzO+P4qp2ws2Mqh0goU=;
        b=znogHHNlch3jTPAb3JGWkqeRAChRFq2cFLiC+vMrWuzKWvbT+tQIhL4yG1Rky88907
         M8zGI89RhfrYs4+2oEb3xiopBFzRYYdJnG6me4UUfRj3o1OuWloEpCuicsK62sfhRvtc
         7ovQO/YPxUCzX0xvi2NXfwbNGb33hyb5HhI7vf1VfGzrFkCVE9pZrnzMCx1x8uFrtdNJ
         zuXC57sm0l+Mi+LCYTJ9S0k0TbR6TpqGCEzNwJhWl86eGDQo31KSEKqeJPFDcl8utLFa
         mQ8TDIPWp1kvlRXuhtL8xS7hQo0BRfAvqZ0bhpFHN4+/pGrFh7WnQ8vv47ZHRzMyh9cm
         5fww==
X-Gm-Message-State: ACgBeo0jx4TZ1tXCjWR4kRQ6P+17zKFIvqY3eGUmkP2ifGltgmWD5sHV
        ctD/6f9gITsv54r0HtesL/yiVVUguhM=
X-Google-Smtp-Source: AA6agR6eF3JckTqfBM+eOaew8O3W5bA0102gH7imdRrZZ49S4LwGyP++BVBxNkU9xkyrfBVAuD/c2w==
X-Received: by 2002:a17:90b:1943:b0:1f7:b63e:60db with SMTP id nk3-20020a17090b194300b001f7b63e60dbmr601375pjb.241.1660687296664;
        Tue, 16 Aug 2022 15:01:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.43.31])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016a058b7547sm9603561plf.294.2022.08.16.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:01:36 -0700 (PDT)
Message-ID: <62fc13c0.170a0220.4bec.0582@mx.google.com>
Date:   Tue, 16 Aug 2022 15:01:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2103985649152783482=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: New BT devices from the Realtek rtw89 family
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220816213523.5207-2-Larry.Finger@lwfinger.net>
References: <20220816213523.5207-2-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2103985649152783482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668216

---Test result---

Test Summary:
CheckPatch                    FAIL      1.80 seconds
GitLint                       FAIL      1.08 seconds
SubjectPrefix                 PASS      0.79 seconds
BuildKernel                   PASS      33.37 seconds
BuildKernel32                 PASS      28.31 seconds
Incremental Build with patchesPASS      48.11 seconds
TestRunner: Setup             PASS      479.04 seconds
TestRunner: l2cap-tester      PASS      16.44 seconds
TestRunner: bnep-tester       PASS      6.10 seconds
TestRunner: mgmt-tester       PASS      99.29 seconds
TestRunner: rfcomm-tester     PASS      9.36 seconds
TestRunner: sco-tester        PASS      9.12 seconds
TestRunner: smp-tester        PASS      9.20 seconds
TestRunner: userchan-tester   PASS      6.28 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.80 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[2/2] Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#92: 
Bus 003 Device 004: ID 0bda:4853 Realtek Semiconductor Corp. Bluetooth Radio

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12945318.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.08 seconds
Run gitlint with rule in .gitlint
[2/2] Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables
1: T1 Title exceeds max length (87>80): "[2/2] Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables"




---
Regards,
Linux Bluetooth


--===============2103985649152783482==--
