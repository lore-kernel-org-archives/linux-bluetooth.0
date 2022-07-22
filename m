Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA969C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 00:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGVAIU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVAIU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 20:08:20 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9269BE4C
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 17:08:18 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s188so4127708oie.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=i1YGbcvuhFe6RxcisY/eCQkO6Y2fAtAkvGDJKeeTbr0=;
        b=NxghDVbpyYENEAhpIRahTkbPEsjwsh7+Ht+FLp7xDzV1AbBqSUiqwJNPKg6eHhxslv
         AiW3W74P+QBvZCpkRgdB6syMmUYyBxdp53YrEMprf7uXMpEuvXJJNXTxVVDNGYqjdzax
         /4ZJXiAQwJ/38v3eX8MXQVqncEC4aLnZhmHBcXnhWKmKsTrLHcSjhKG3h+Tjy1Cn6QOL
         Mw7+DQX0anFSAyNDGvpGX22Am9m96z8IoEnPbyJmF+IRBdiQ+ZuJ8lmD4liMrXiZp4yR
         SOxvmbm1Nk4ByQNDhOrlz/LH2rag9M79HaUAyESNVkjBd/rLrEqd8VrjTsMckxUYLfmU
         0K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=i1YGbcvuhFe6RxcisY/eCQkO6Y2fAtAkvGDJKeeTbr0=;
        b=k/pERTR/mvONFGD/GlkYY4n+ssFK9ZEn5jVegRtvILI9IAqumOChk6yuiG5RHQnuN2
         /fJOOsXJ0NE8l/SzBOIcfCvXidSjZK9+GRMbgJ05QWUdy7/C8WfgXR2z3hPx0/Qw7zWL
         ODbyfMA2DzEcu/+JFNJRKwTtrpQ9FctcX8M1Xb5yX3ZSdJJQPM8i50A9YT1S2Q0tZHSv
         CBV43Hx92Wh8MrS/Qp9RHlFF78A8jSSPDWT86tr4eiNT9rwZMx9aQuxkRfbDXaecGjDp
         FiK5Fhs2jHSe8vPxmwMfTYolZ880jlf0qFoZ7SeTf2utXgh/P+OaGuLYEcmA6lSA83Y6
         fWLA==
X-Gm-Message-State: AJIora8QQEnxxdfiWEGPkYr86ebCbMee/wwWpWKEYQ3bnIj4jqey5fu1
        UwC2eCQ/3jjonx1txA2tpdnwqNE0rjM=
X-Google-Smtp-Source: AGRyM1sqgF80Q5p8YIVWCKt12YS1Vob5hX6H+lbt7UKLOEkaDslzPk1gQ23hNow64IVw4X7FyGxlXQ==
X-Received: by 2002:a05:6808:1648:b0:335:41f7:1e1 with SMTP id az8-20020a056808164800b0033541f701e1mr335120oib.216.1658448497146;
        Thu, 21 Jul 2022 17:08:17 -0700 (PDT)
Received: from [172.17.0.2] ([104.44.134.164])
        by smtp.gmail.com with ESMTPSA id 21-20020aca0d15000000b003352223a14asm1217306oin.15.2022.07.21.17.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:08:16 -0700 (PDT)
Message-ID: <62d9ea70.1c69fb81.94969.5067@mx.google.com>
Date:   Thu, 21 Jul 2022 17:08:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1286288845682222304=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: MGMT: Fix helding hci_conn reference while command is queued
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220721230034.416231-1-luiz.dentz@gmail.com>
References: <20220721230034.416231-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1286288845682222304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662025

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      47.09 seconds
BuildKernel32                 PASS      39.84 seconds
Incremental Build with patchesPASS      66.17 seconds
TestRunner: Setup             PASS      678.27 seconds
TestRunner: l2cap-tester      PASS      20.05 seconds
TestRunner: bnep-tester       PASS      7.53 seconds
TestRunner: mgmt-tester       FAIL      121.92 seconds
TestRunner: rfcomm-tester     PASS      11.21 seconds
TestRunner: sco-tester        PASS      10.93 seconds
TestRunner: smp-tester        PASS      10.70 seconds
TestRunner: userchan-tester   PASS      7.65 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 121.92 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Get Clock Info - Success                             Failed       0.200 seconds



---
Regards,
Linux Bluetooth


--===============1286288845682222304==--
