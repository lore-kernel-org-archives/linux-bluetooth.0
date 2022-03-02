Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE65C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 07:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiCBH1K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 02:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiCBH1J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 02:27:09 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D97B12CD
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 23:26:26 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id dy10so860669qvb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 23:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=t9jx5oUnbT8XAU8wHd5zQK8rTrCJZ8aRVk+gs5eYoQk=;
        b=iQPX8AhR6PE6Ah8qyiKZcju6tlvgEht8C9Lgi652DcT1XFJTRIvTmIXEaAwCL0ZjsR
         3kbRJQf14WPw5yOsHMydTG5OTfGluEko7MRIFIML/fJq8r2kDEXIDsJR3JsJORi5EO5V
         FBFsAPP1I9OLv+lOKKdkW7IL88ZXlGtD6rvKeKDWe83dpZjhU6KWsZTqi9uLH05Q/npE
         8FR4anFI1yoJ2lMdRT0gUMcWu2ooXQb9Ojth8xCKhBd3gCdjefhRJ9ddRgin/m5fElNW
         rr71jnzmNfsmbZv0SWebQkkDBITnFDThWbGf19aqwskNHlAjypUXeK5+OWmEg1nC+rlT
         hcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=t9jx5oUnbT8XAU8wHd5zQK8rTrCJZ8aRVk+gs5eYoQk=;
        b=Z6D4+PZdVTtewheiJfFjT1zFGC2yO53Qeg4YOGvxNKOh+3z+++nD++NVycSzFxpJMZ
         fPvHnKAAxs7OYTVfzZRdcDXudksQgp4x4srTMoKED+VmItzXFn6BcbUz8HjSh83I/cJs
         irhvSzM6Y68UvOq23l6Wl8O5hqxmOsiemzlo1wLTgzHBj7eVL6qgtWs7bYp2mXH0Pnvt
         2NcAGOXyHl93nORQu04WqiARXxyoBgLHxflYqgSla6ySZmKolOfKDZutrJqUlPauK0WK
         1WEnHLzLSNEG/SNhpET67WLcTkBQKYE98/KNBAjzZjxZq48aTt0MFaDy4BvL7lGfxCeb
         nWSA==
X-Gm-Message-State: AOAM530CY5vu9EhW6x26mpGX7qdr2MMJo9fmziKyUp7JH3l+itjx9toi
        VZcAW6jzTOTlS6hd/uPlB3UklV6CqwRmHA==
X-Google-Smtp-Source: ABdhPJziG1hvpSYB4QUOkeOW3wl4Po6zeLeKEDHXI5c3GagWImkmMsQCKaMqE1nUuYM0fDc2K1yfjA==
X-Received: by 2002:ad4:53c5:0:b0:42c:c4d4:65d with SMTP id k5-20020ad453c5000000b0042cc4d4065dmr19559276qvv.98.1646205985260;
        Tue, 01 Mar 2022 23:26:25 -0800 (PST)
Received: from [172.17.0.2] ([40.123.52.168])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a455600b00609a429fd8csm7925620qkp.59.2022.03.01.23.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 23:26:24 -0800 (PST)
Message-ID: <621f1c20.1c69fb81.8eb16.a57a@mx.google.com>
Date:   Tue, 01 Mar 2022 23:26:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3379099386181266125=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220302064351.225212-1-luiz.dentz@gmail.com>
References: <20220302064351.225212-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3379099386181266125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619444

---Test result---

Test Summary:
CheckPatch                    FAIL      1.66 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      30.15 seconds
BuildKernel32                 PASS      26.78 seconds
Incremental Build with patchesPASS      37.21 seconds
TestRunner: Setup             PASS      477.73 seconds
TestRunner: l2cap-tester      PASS      13.67 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      105.01 seconds
TestRunner: rfcomm-tester     FAIL      7.68 seconds
TestRunner: sco-tester        PASS      7.80 seconds
TestRunner: smp-tester        PASS      7.68 seconds
TestRunner: userchan-tester   PASS      6.52 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.66 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[RFC] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work\CHECK:LINE_SPACING: Please don't use multiple blank lines
#99: FILE: net/bluetooth/hci_sync.c:276:
 
+

total: 0 errors, 0 warnings, 1 checks, 82 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12765538.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: rfcomm-tester - FAIL - 7.68 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.155 seconds



---
Regards,
Linux Bluetooth


--===============3379099386181266125==--
