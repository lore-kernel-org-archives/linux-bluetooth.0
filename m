Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF33C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jul 2022 22:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiGXWDY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jul 2022 18:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXWDY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jul 2022 18:03:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8BDEE34
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 15:03:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 125so7484937iou.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=B/d22Rjw4LrU/ob437MKLzSooBwoJ+6uXmSQnHnCtUY=;
        b=ktpJvk8olevpqOYheJ69igcU6bAVRqM4/KhA5VLUvxV2AjfyKdLjy90gDDEOAfLMBE
         YiGSvEvfvFhZMn9EuGoxmR2khslsshC4X8ifTt7DhKNL2Pt+EPrltf6Sbay4xULsEH8I
         jAWn1UTESDj5FhCei4PJ/hhAcJ5K/YrkWh1vZ0xZykI4dTUdQI8P7C9x+SDgMHCExsHI
         sdzama87wR57Ox7RV7BDg2AHhC8PdjjLW21wOjET3wc/L903PfW4/3xeYpbHRXB22HHS
         LASqCgxbTzJ2Br87MdlclcqWQaVuwoLUu/WziroZHW2WUuWUrQqa3Vq9XFEOD22e6Yhp
         ygDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=B/d22Rjw4LrU/ob437MKLzSooBwoJ+6uXmSQnHnCtUY=;
        b=Yyw44RY1YfW150Pa31nRpsVrzCCk0BfUqZWoqBQ7rrAw81pIR71KaCXG2LAcTdhlWV
         kNwjA8nnxx750qMCe+3mrbQerLDHyfMTLbVEHIpk1mRf/dc/VNll2MB6W74dLtdo+1TO
         mvG+w7xQTSPar41w8Pmv/HlzLrvoEj7pShnD8Q7khsDYfXCHEkYkqv1csy+C4wtgEDcI
         ByuOexEZv/g5EoBiimo4GrBN+Ej7RpW9N77nVCPmwDZCRhtPN3xCko+QITtNiA8I9Msb
         Z/XaLiTFzfQQ+NDPcZuu9wGXHqhkDg2BFiDwqkuQtRcuDhAArDIikaK0R9gjb88+MwAZ
         KwOg==
X-Gm-Message-State: AJIora8ouYKZ35/n+CYuSOMQ3tW8eNgSwAHbsMLWgmsZRJ8wnYC0mAU4
        9Ul7rF1ryiscvAb35uVJqarJ8Pn2UU4=
X-Google-Smtp-Source: AGRyM1u5ZE2DFty0X+GzP7EvOJ2ZIn/lSh5YkyhCz00+MiDUSHF3Uqn2vCf6a42w0DwDDn/rTfK1zg==
X-Received: by 2002:a05:6638:16cf:b0:341:4543:b354 with SMTP id g15-20020a05663816cf00b003414543b354mr4037061jat.114.1658700200580;
        Sun, 24 Jul 2022 15:03:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.228.139])
        by smtp.gmail.com with ESMTPSA id a15-20020a056638164f00b00339db3266c7sm4749745jat.124.2022.07.24.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 15:03:20 -0700 (PDT)
Message-ID: <62ddc1a8.1c69fb81.f40b3.5478@mx.google.com>
Date:   Sun, 24 Jul 2022 15:03:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2851579788595889008=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: Bluetooth: hci_sync: Fix opcode format in debug message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220724212639.29269-1-ismael@iodev.co.uk>
References: <20220724212639.29269-1-ismael@iodev.co.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2851579788595889008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662601

---Test result---

Test Summary:
CheckPatch                    FAIL      1.37 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      37.10 seconds
BuildKernel32                 PASS      32.02 seconds
Incremental Build with patchesPASS      49.05 seconds
TestRunner: Setup             PASS      536.08 seconds
TestRunner: l2cap-tester      PASS      16.75 seconds
TestRunner: bnep-tester       PASS      6.11 seconds
TestRunner: mgmt-tester       PASS      99.35 seconds
TestRunner: rfcomm-tester     PASS      9.41 seconds
TestRunner: sco-tester        PASS      9.12 seconds
TestRunner: smp-tester        PASS      9.25 seconds
TestRunner: userchan-tester   PASS      6.28 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.37 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: hci_sync: Fix opcode format in debug message\WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12927635.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2851579788595889008==--
