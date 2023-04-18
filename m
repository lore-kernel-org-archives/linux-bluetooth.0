Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18FDC77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDRBI7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Apr 2023 21:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRBI6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Apr 2023 21:08:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FDAD
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 18:08:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-38be7a5ab37so62316b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681780136; x=1684372136;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x304t032hE44x+HOgNsatqh326c0XbgmCCYr2SxWXvI=;
        b=jlxSNdqb7EnpecGPy8ghikAnLOHkVXosgGKM1eNp0Xc85JeRVVwy+YiWAasg0dUSNJ
         QOXIcS2fAGA1C8r888VCApbALGGG1pBck9eIU2nLqYZMUto0Tg3XdXUvdCX2S1V5gL6u
         vGrrH5rWinxELQ8CRRUVPIQ1FnBQSCsuBIebco6J6lyPhnD332O8N4bK/Js7NlqEWXrQ
         THDBZPsk/edPWOeZD1u0N6rrXzBhXdyCC8ggWXskcLTEBdUrew7oXVNg3/0rNasi7+CU
         X+49E+ogbijK9ChfXrWJE8D9kQA+4r7AHcQSv+c38CUu6HbfdTn4ghL/Ddoxn9RZ9GpM
         5uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681780136; x=1684372136;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x304t032hE44x+HOgNsatqh326c0XbgmCCYr2SxWXvI=;
        b=B1Yz4Fx8x/wzgIwHeoSg2y5otyAH3eE1fMf2qTGjLgXy3HP6wH0nEDKVgm0J3rBmH8
         Uwirr5JzqP9fD17EaoqcQgKJ+3dVN/lp2MFhi64z3fGOOTlzPQhF8ySu4KCy7oHdtlnn
         paDY8pTEhVkudwu7EIlaHERu/LuxQJZpLOhHbg9yLyVDAA4L7hPht5E0vnsmZWy+BdgY
         bwUlTrlbsI9zOhdndHQqZ3ltmsThlCzqhk0QatG/3CvcU7Sq8KcGNwIlZjU+ZfaHGIVg
         MnS+FR2eQo4mxrP4sOTRBgjFKwt3c/PftwKPwEOpTsl/cYZdsdDfwHASD8CSWhurN01l
         ld5g==
X-Gm-Message-State: AAQBX9eG4siEWAMfPJsNK26iC+nAjqz11ThPINkoG+15WXXn6q3JHBqT
        S9hlY3Qqe2JT3yjWObcPYMI8CLPIWnc=
X-Google-Smtp-Source: AKy350aMGuZgQOwS5z0dGFEDdSO4vGLIFoLuoRsVp/kRl9q6vGVzYP8yH+G1GMXlXvKWy9imuMvkiA==
X-Received: by 2002:aca:686:0:b0:38e:30:1226 with SMTP id 128-20020aca0686000000b0038e00301226mr126898oig.4.1681780135973;
        Mon, 17 Apr 2023 18:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.179])
        by smtp.gmail.com with ESMTPSA id q43-20020a4a962e000000b00546e2afe9d4sm1171784ooi.24.2023.04.17.18.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 18:08:55 -0700 (PDT)
Message-ID: <643deda7.4a0a0220.76dc.611c@mx.google.com>
Date:   Mon, 17 Apr 2023 18:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6602370235900111175=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: btnxpuart: Fix sparse warnings
In-Reply-To: <20230418000704.1937843-1-luiz.dentz@gmail.com>
References: <20230418000704.1937843-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6602370235900111175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740725

---Test result---

Test Summary:
CheckPatch                    FAIL      1.12 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.00 seconds
CheckAllWarning               PASS      35.35 seconds
CheckSparse                   PASS      40.40 seconds
CheckSmatch                   PASS      111.75 seconds
BuildKernel32                 PASS      30.89 seconds
TestRunnerSetup               PASS      439.97 seconds
TestRunner_l2cap-tester       PASS      16.21 seconds
TestRunner_iso-tester         PASS      19.55 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        PASS      109.98 seconds
TestRunner_rfcomm-tester      PASS      8.46 seconds
TestRunner_sco-tester         PASS      7.80 seconds
TestRunner_ioctl-tester       PASS      8.93 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      7.61 seconds
TestRunner_userchan-tester    PASS      5.48 seconds
IncrementalBuild              PASS      28.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btnxpuart: Fix sparse warnings
WARNING: A patch subject line should describe the change not the tool that found it
#69: 
Subject: [PATCH] Bluetooth: btnxpuart: Fix sparse warnings

total: 0 errors, 1 warnings, 210 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13214874.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6602370235900111175==--
