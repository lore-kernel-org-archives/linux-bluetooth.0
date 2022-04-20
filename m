Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354038AbiDTNoO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiDTNoN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 09:44:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453F3ED1B
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 06:41:27 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b17so1306730qvf.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sVehTUqX6IRI3HmYqAiw2+7Qw/15M5FRv4WJJdMsfJA=;
        b=jAoEpYkYhSG+xXHH3rWeVSMabfOGTMuBw72jhHMpyH77Apf8ohkylSpqLa2Ee6qR4S
         BB+Gqce8Z16R0VstLcJf1l4ymHTbGYrUWW+uSPCNORv0fXibF+MB+MoES+aC2AWiOcsO
         17URzo4ShbRZCRmdueLQP1hTPRVlQXnbjodJUicbv7QenVz99RTdozw0+1XC3NQY97yj
         dOffXQoR3Ux6RXqkApQSLYhwnpqJGhpTLybKxIF/aJ01dCy/jxkNnAnbxPiYMpRdLCUj
         2tJ2HiathQO2Q0EdsIhejtQ498ysiVQK+xa23zEgiCtML73oLyziv3MPH4fG9VlbaEcV
         S4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sVehTUqX6IRI3HmYqAiw2+7Qw/15M5FRv4WJJdMsfJA=;
        b=7lU5qpvDA44yHNeBZHyD4Qrtu3UmFu+Y+Xne0lSdimaN/anRP9hWHlsUOaljMdh5LY
         sMPxeCHgELzOF64fie7Y6BBlbdBlhTgCvzmuIo3OZXZrGqwprj4DvIGPNtaaOl94AVsf
         OplpSWXkDKdv453cKShwRKqTJbZrCdw4GVI1MZrg+hpyZWu0XjvnPHBt2ZGsO2v58tPz
         T3oSLgo68mTmz5oBsbC4LI42s0+eyfeLug3HUGTgHRxcd1ZCp021wMxcVGr4v90eUcDx
         Ilv2eUJ1OOQEXKN9eBHQmTU7j6/+lHJ0cPerr12048JY5VPPB9nU8SbhetRmIuulYsRb
         PD+g==
X-Gm-Message-State: AOAM531sWUXSsJQwfGpICYJnGPIeknfvIGo0Z3y8GZbbNyrwiMr010Cu
        5pXdTgfmqihngjfNZUJ4fFcqS5odj9rqAg==
X-Google-Smtp-Source: ABdhPJy8Kam5Rxdzfkn2x5cNl/6k135FHYG4lPaqpOMJPvE3tuEKXj1NKu75T+/Qb7AApohzaqv4Ng==
X-Received: by 2002:a05:6214:dc3:b0:446:4569:1f97 with SMTP id 3-20020a0562140dc300b0044645691f97mr15108336qvt.62.1650462086370;
        Wed, 20 Apr 2022 06:41:26 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.34.46])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm1840137qta.75.2022.04.20.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:41:26 -0700 (PDT)
Message-ID: <62600d86.1c69fb81.ed5ab.d454@mx.google.com>
Date:   Wed, 20 Apr 2022 06:41:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2662508853920506524=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v4] Bluetooth: arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1650458740-16957-1-git-send-email-quic_saluvala@quicinc.com>
References: <1650458740-16957-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2662508853920506524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633779

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       FAIL      1.03 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      44.45 seconds
BuildKernel32                 PASS      39.01 seconds
Incremental Build with patchesPASS      53.14 seconds
TestRunner: Setup             PASS      673.40 seconds
TestRunner: l2cap-tester      PASS      22.58 seconds
TestRunner: bnep-tester       PASS      9.19 seconds
TestRunner: mgmt-tester       PASS      144.05 seconds
TestRunner: rfcomm-tester     PASS      13.57 seconds
TestRunner: sco-tester        PASS      13.22 seconds
TestRunner: smp-tester        PASS      12.82 seconds
TestRunner: userchan-tester   PASS      9.32 seconds

Details
##############################
Test: GitLint - FAIL - 1.03 seconds
Run gitlint with rule in .gitlint
[v4] Bluetooth: arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms
1: T1 Title exceeds max length (90>80): "[v4] Bluetooth: arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms"




---
Regards,
Linux Bluetooth


--===============2662508853920506524==--
