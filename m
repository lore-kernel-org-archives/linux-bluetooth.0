Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 21:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiCAVY3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 16:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiCAVY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 16:24:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0163586B
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 13:23:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso2993363pjk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WAtI3NMrePVytacpg2HjHzLyE6Iy7Jl/3AB/5CDgNh8=;
        b=YwKB+B+YGmjqxXpUhzRlV4l3rcC0bepnC5D5/cy/XiVBSyyL7NGCcNAZoOqBvkBBsc
         i3eqdl2WEFWCHx1VoJsXIOL1OetfzqZyVhMY03reOU2JoKxdMipFUmiCz+LnLAUoY/51
         wT9R2HTlPDQs+VXaYaSXstjuIZUCwf3VmQKBM/Dxu7iriX7vw8n9MbNWXiTu/BpBnBRX
         rEQZLYeXXCPt4Gyau6wDlohBl38/4rffVTs7lDr4gRhrKK8sz2dSEqi0hANw3v9naH7I
         8rFWzAgzopq3EiJiY+biCZ1R42dU4/HddkmN7vt4sT68sKa5nb4jRZwSjqY5DswEyXVn
         DEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WAtI3NMrePVytacpg2HjHzLyE6Iy7Jl/3AB/5CDgNh8=;
        b=MG6DuFHjWlGy5fVs4gXfmlZWrqtcsQmmnySVWA46ON+PkT2lGC19vpc3j8XCn5nsk3
         cTWaznlxrXUGOSVWO3bEcLTSnZImThRljgR+3LWw2wLxwRamecuYmixLttApqGa6RD5U
         z+xh/MyNPHuwtT6WH+teqx0357aFXiKht5HhhDU5FqKudnpvJHAy1z933+6R4vVje2en
         MhcbdZve+JSQUSVWrdHnbx4HbDinRjwl3A0YqMlRLz9DMQQ1rtd1ViXiygL/IkkqRzU4
         CHCok1qJXcSkBbJ3a/rFacBclL00Y74xSuTYVKMbVHVJnQ/sjsQ6hCBX+uJ1Ju+Bb8kP
         CgNg==
X-Gm-Message-State: AOAM532YUJMHNYBNPpVqMfeBv3vXQYaLvyRlX85wmzVetyla89E34ObW
        24U1syiNMFYKkSrEnPIl/q5VIS4SugM=
X-Google-Smtp-Source: ABdhPJyj04LK25RyJJcOUPGQGbGP9J0Eei6ukloayNL4miPK5MUTxQ0W4jyMK9muttbjcG3R1gmiyA==
X-Received: by 2002:a17:902:ce82:b0:150:625:c4bb with SMTP id f2-20020a170902ce8200b001500625c4bbmr26981674plg.159.1646169826802;
        Tue, 01 Mar 2022 13:23:46 -0800 (PST)
Received: from [172.17.0.2] ([20.114.47.9])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ae00c00b001bc46eae696sm2880909pjy.32.2022.03.01.13.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:23:46 -0800 (PST)
Message-ID: <621e8ee2.1c69fb81.fe1ac.8be6@mx.google.com>
Date:   Tue, 01 Mar 2022 13:23:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8420309644792842348=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v5] Bluetooth: Scrub MGMT cmd pending queue for consistency
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301201646.759695-1-brian.gix@intel.com>
References: <20220301201646.759695-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8420309644792842348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619305

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      41.73 seconds
BuildKernel32                 PASS      36.38 seconds
Incremental Build with patchesPASS      50.12 seconds
TestRunner: Setup             PASS      654.07 seconds
TestRunner: l2cap-tester      PASS      17.90 seconds
TestRunner: bnep-tester       PASS      8.13 seconds
TestRunner: mgmt-tester       PASS      134.84 seconds
TestRunner: rfcomm-tester     FAIL      10.17 seconds
TestRunner: sco-tester        PASS      10.41 seconds
TestRunner: smp-tester        PASS      10.07 seconds
TestRunner: userchan-tester   PASS      8.48 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 10.17 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.216 seconds



---
Regards,
Linux Bluetooth


--===============8420309644792842348==--
