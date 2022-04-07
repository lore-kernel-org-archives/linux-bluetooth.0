Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 05:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiDGFOt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 01:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiDGFOq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 01:14:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF895A04
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 22:12:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t7so7208605qta.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=btHuPwE/pBXrFwlpYCo29GrZPEjcMFUpyGxd8MBDI1U=;
        b=lHn543dvawt1vE6OCnlYii5kZAbezXlSJHK4lphefoVfwxVAISWp8D/5pNxK95fJSx
         3wtbM+qJ8MowAP5GMiz0kbGmz7uhWtfixHEfPbiWLxZ7/UVe+c9kt5tloz43Fgiis1/9
         c66jqesDVytkoBKfMCPma0KPwuQVpka6JOMEDk42UKeK5UpK0P2s3O6KvHWxsZ5w/pE+
         QDCX8XTtBzVjmhMjCyDWWU+hI8L5IXpxNnMg7eHEVWwRgxmmybX1JxFMgOO5AoStO8cw
         s/Jeh0RZEHyXDDV3n+n+ATxOkqwHiBs4zde4mg+MDaOU6OGV9jCZwqC6hJp3YZXelF85
         YFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=btHuPwE/pBXrFwlpYCo29GrZPEjcMFUpyGxd8MBDI1U=;
        b=8QVBVscxm8v1AlvByOXqX5dSekNPnXRool/Xxre8hJmV57MeGEr+WoHDnuqlGh75I4
         uHtjVS6lDbu25pbug8ac72vmJHBXD0flGyIKYyclE+BxADm+01xSFKBSgFk8tJG2dOcM
         VFIaaFj/3WN7/iUl/n5n9Q5dm7/7INC2wD5IJfwVkZ2/OPziD0IJ2mWuIcMUOI+bJTcd
         MMir29V/IXW5ZmKUsiomUM8GcBMW68aA35x1JDboFVONft5SZsVm5+To+4Ap1nTCkIL0
         mlTEWXew2iqgdG31+9oJVwLVyDwS7trsrsszg+P19r5om9hUZBioCnh1B+NrXoEiXjX3
         yLgA==
X-Gm-Message-State: AOAM530ZcZa0QK6ynZszL7pkJXezg00hTrsJusWt3TV4buWuYCQmqzOH
        5glpTDL3DNNP2kUKBlRzjwhP4XeOe5weVg==
X-Google-Smtp-Source: ABdhPJwEy1kxC1YiGG6AJ8U8+cqLFdGKaF4o3ofHMP92tmrDUf4mKinQ5O/oX25jsGQt351mw8RlYA==
X-Received: by 2002:a05:622a:28b:b0:2e1:d5f3:1ebb with SMTP id z11-20020a05622a028b00b002e1d5f31ebbmr10489023qtw.106.1649308365504;
        Wed, 06 Apr 2022 22:12:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.155.4])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm14637118qta.13.2022.04.06.22.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 22:12:45 -0700 (PDT)
Message-ID: <624e72cd.1c69fb81.ce944.910f@mx.google.com>
Date:   Wed, 06 Apr 2022 22:12:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0355460716209417570=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ruc_gongyuanjun@163.com
Subject: RE: [1/1] Bluetooth: hci_uart: check for missing tty operations
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220407042623.28438-1-ruc_gongyuanjun@163.com>
References: <20220407042623.28438-1-ruc_gongyuanjun@163.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0355460716209417570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=629800

---Test result---

Test Summary:
CheckPatch                    FAIL      1.93 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      31.00 seconds
BuildKernel32                 PASS      27.28 seconds
Incremental Build with patchesPASS      37.94 seconds
TestRunner: Setup             PASS      477.97 seconds
TestRunner: l2cap-tester      PASS      15.85 seconds
TestRunner: bnep-tester       PASS      6.11 seconds
TestRunner: mgmt-tester       PASS      102.09 seconds
TestRunner: rfcomm-tester     PASS      7.70 seconds
TestRunner: sco-tester        PASS      7.64 seconds
TestRunner: smp-tester        PASS      7.56 seconds
TestRunner: userchan-tester   PASS      6.21 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.93 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[1/1] Bluetooth: hci_uart: check for missing tty operations\ERROR:CODE_INDENT: code indent should use tabs where possible
#76: FILE: drivers/bluetooth/hci_ag6xx.c:39:
+        if (!hci_uart_has_flow_control(hu))$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#76: FILE: drivers/bluetooth/hci_ag6xx.c:39:
+        if (!hci_uart_has_flow_control(hu))$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 12)
#76: FILE: drivers/bluetooth/hci_ag6xx.c:39:
+        if (!hci_uart_has_flow_control(hu))
+            return -EOPNOTSUPP;

ERROR:CODE_INDENT: code indent should use tabs where possible
#77: FILE: drivers/bluetooth/hci_ag6xx.c:40:
+            return -EOPNOTSUPP;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#77: FILE: drivers/bluetooth/hci_ag6xx.c:40:
+            return -EOPNOTSUPP;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#90: FILE: drivers/bluetooth/hci_h4.c:47:
+        if (!hci_uart_has_flow_control(hu))$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#90: FILE: drivers/bluetooth/hci_h4.c:47:
+        if (!hci_uart_has_flow_control(hu))$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 12)
#90: FILE: drivers/bluetooth/hci_h4.c:47:
+        if (!hci_uart_has_flow_control(hu))
+            return -EOPNOTSUPP;

ERROR:CODE_INDENT: code indent should use tabs where possible
#91: FILE: drivers/bluetooth/hci_h4.c:48:
+            return -EOPNOTSUPP;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#91: FILE: drivers/bluetooth/hci_h4.c:48:
+            return -EOPNOTSUPP;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#104: FILE: drivers/bluetooth/hci_ll.c:117:
+        if (!hci_uart_has_flow_control(hu))$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#104: FILE: drivers/bluetooth/hci_ll.c:117:
+        if (!hci_uart_has_flow_control(hu))$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 12)
#104: FILE: drivers/bluetooth/hci_ll.c:117:
+        if (!hci_uart_has_flow_control(hu))
+            return -EOPNOTSUPP;

ERROR:CODE_INDENT: code indent should use tabs where possible
#105: FILE: drivers/bluetooth/hci_ll.c:118:
+            return -EOPNOTSUPP;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#105: FILE: drivers/bluetooth/hci_ll.c:118:
+            return -EOPNOTSUPP;$

total: 6 errors, 9 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12804440.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0355460716209417570==--
