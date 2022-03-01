Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9422C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiCATQn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCATQm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 14:16:42 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C41F4B859
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 11:16:00 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c4so10852453qtx.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=l1G4LaFYJln5eDuSLo1mp3hainDmw8LM3PEUv4SuOQc=;
        b=laTtH2VXSLbv729Ikd0AjmnpKnwVx63cvSaQlufql2Xwy4Lgi8TsKISD7h1QvNG/u3
         DX4KaXDv1Z7LrNakT95xco69ng/bLkALqz4PTwY5FQc75eRszwGTC5WWwjlHoKMesk4v
         bclWJyE2s3Tq5/nblZWfgry5eUvmk8ka3Q7L6Q6BNHBxheDo7Sh7+e3PSmSGHWZAbawJ
         NEtxegrhTlWLk2sv+NFIojF5fPGZsgXq1U8SpQ2X9J2LW0CcmlTtFcnEdtTcRCgl4rdV
         Un2/K52wYn2f2O0awZxZEifCdwXVBwwtcozu1UqpB9Mw6ypu1nGLIQSg7ABtY3mhTsmn
         nUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=l1G4LaFYJln5eDuSLo1mp3hainDmw8LM3PEUv4SuOQc=;
        b=CqIrZ93rKhwOIoKiVEBkolRve8f21OwpS/QmfdGQhJqJp6Bqr29+Sq6WUoRODnM2tv
         UOpe9MW6S93cywrrzDceaXP8vT5HBTG1EFq6Tw5S0rxCJjz1gSW05GanSa71pRRuSWml
         Y3XqwFtLG2M9xaDK57oYI4rYjCPDocKTnY8QdqBU//EBYyBu+Yxpdw62Qxu4WXUXrJHz
         tTfHcTqp1inyleiUpBNTKA1HxDRMpFfRaBuH01Uyaf76d/r9mKQc5eTxlfCDn0UemtYk
         LqCBva/FCL+AFQr9YUbR9w1j59Bsh7IUyE+Sf+hmW4V1gH6bbOFbuIs5mDdgWCLwHqgS
         uDkw==
X-Gm-Message-State: AOAM530jWSlz8Y540HAtpHR+5EYwzDiNL9/JS/UKS6Pjs5Cir96bS4vy
        Hsy0DnV0uBJtA/LwkdDaLHd1Eno9mgxC9w==
X-Google-Smtp-Source: ABdhPJxln01Ubq3XfNZR2D2CLJz61hqe/qsnxpI8D16EbkJVXj+URBnEl6oWxznzQ0l7tUCm8KOKcQ==
X-Received: by 2002:a05:622a:302:b0:2de:735:77 with SMTP id q2-20020a05622a030200b002de07350077mr21230429qtw.417.1646162159124;
        Tue, 01 Mar 2022 11:15:59 -0800 (PST)
Received: from [172.17.0.2] ([20.42.50.220])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b002ddd5fab777sm9283468qtx.41.2022.03.01.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:15:58 -0800 (PST)
Message-ID: <621e70ee.1c69fb81.1091.0c37@mx.google.com>
Date:   Tue, 01 Mar 2022 11:15:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5892007297570026217=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v3] Bluetooth: Scrub MGMT cmd pending queue for consistency
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301185311.740803-1-brian.gix@intel.com>
References: <20220301185311.740803-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5892007297570026217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619287

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      30.63 seconds
BuildKernel32                 PASS      27.14 seconds
Incremental Build with patchesPASS      37.25 seconds
TestRunner: Setup             PASS      473.90 seconds
TestRunner: l2cap-tester      PASS      13.56 seconds
TestRunner: bnep-tester       PASS      6.16 seconds
TestRunner: mgmt-tester       PASS      104.22 seconds
TestRunner: rfcomm-tester     FAIL      7.66 seconds
TestRunner: sco-tester        PASS      7.79 seconds
TestRunner: smp-tester        PASS      7.61 seconds
TestRunner: userchan-tester   PASS      6.50 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 7.66 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.154 seconds



---
Regards,
Linux Bluetooth


--===============5892007297570026217==--
