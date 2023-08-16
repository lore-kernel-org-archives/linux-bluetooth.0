Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252ECC001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 15:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjHPPiW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbjHPPhz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 11:37:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8ED210D
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 08:37:54 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-791071b9a5eso226149639f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692200274; x=1692805074;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FSo3J6LSQxL4Ic9FWxG33cTAMe78cK9Ov58Fs8a3mAc=;
        b=T42RdyUh9F09yKjXPgnAGR1WiVhlGuW96JoowGo4XN6g8d+gHFj9nfnCn3JsnIernl
         sCkpVNCCaO/ENuJY1bm8u5wvL5gtpAdlJT3EW3DBy97NCMoZkGuWhdS5k9KmPvtpUgan
         ivAHllFxbQ92dhiPDd7r/kibQFrxYdGb9EhoD55qo7XM9wdTZODF1+OY2mN4j5htFZBq
         zUc3UpaKqjc/BdxzzK7WZ3lHB+zUnkd6YfNkzPvu362wnVWpXJ7H2/kw1Uf8tihBXMAU
         H/p83Uz8xRYY1Lvqva/DzHCJUL0JcHEwA7JOsDa7sxJ5NGVHR1sI62McreCcPk7mSy5S
         /yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200274; x=1692805074;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSo3J6LSQxL4Ic9FWxG33cTAMe78cK9Ov58Fs8a3mAc=;
        b=eunqgCmtxCM80kL+R6ugrIjqjaOzMosYQELdm+2/lgtplnAZHK9q1NjdPxxTrf5J9p
         i4gfUU9NBtRvyEJwUX0pflQXVWN+nWkitQNfXklLXLKvhzuHxPRcwVSi8R+nTTdajIs/
         TqcTEXwYrJ5yXrhS9VjW9Dv77AlcoDWdMPDhU+P1+968jyGFKDLSRZ0N7J8GUu+U2SVT
         eYUXoIbiO2Gr36vfsHwEVIzo8u3nyd+vzGHh6qtb4ts1DNFw99jFwivNb7duAdl1FMB8
         AVq8t8tpmXNAfEqGZGdYKm7UuEnCcc40xMM4o26CENm0m1bNoGyovhn4LfLPYSKcKrBV
         s0gQ==
X-Gm-Message-State: AOJu0Yy6mmIVDqjkEss7pmavyVbWDo7nxlu7+LUfgMpV+1kkD9ZzHr8O
        6yzZpjsf0CKeU+OhaFPxUyFKIZEXd/w=
X-Google-Smtp-Source: AGHT+IFJbraEdI+66vSKHxRoIAQmvN4iSPdGotYMSnIkshkSSeaXDtiKdRJtr07QXnXjl57+DuOD4A==
X-Received: by 2002:a5e:8601:0:b0:791:2194:10a2 with SMTP id z1-20020a5e8601000000b00791219410a2mr2564617ioj.15.1692200273995;
        Wed, 16 Aug 2023 08:37:53 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.150.242])
        by smtp.gmail.com with ESMTPSA id m17-20020a5e8d11000000b0078754bed499sm4623433ioj.37.2023.08.16.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:37:53 -0700 (PDT)
Message-ID: <64dced51.5e0a0220.1dd53.68ce@mx.google.com>
Date:   Wed, 16 Aug 2023 08:37:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4544890713288265632=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
In-Reply-To: <20230816150033.7812-2-iulia.tanasescu@nxp.com>
References: <20230816150033.7812-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4544890713288265632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776677

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      34.19 seconds
CheckAllWarning               PASS      37.71 seconds
CheckSparse                   WARNING   42.53 seconds
CheckSmatch                   WARNING   115.52 seconds
BuildKernel32                 PASS      33.18 seconds
TestRunnerSetup               PASS      502.00 seconds
TestRunner_l2cap-tester       PASS      25.29 seconds
TestRunner_iso-tester         FAIL      73.14 seconds
TestRunner_bnep-tester        PASS      11.79 seconds
TestRunner_mgmt-tester        PASS      229.27 seconds
TestRunner_rfcomm-tester      PASS      17.51 seconds
TestRunner_sco-tester         PASS      20.68 seconds
TestRunner_ioctl-tester       PASS      19.54 seconds
TestRunner_mesh-tester        PASS      14.72 seconds
TestRunner_smp-tester         PASS      15.55 seconds
TestRunner_userchan-tester    PASS      12.33 seconds
IncrementalBuild              PASS      31.56 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 95, Passed: 93 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.409 seconds
ISO Connect2 Suspend - Success                       Failed      14.537 seconds


---
Regards,
Linux Bluetooth


--===============4544890713288265632==--
