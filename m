Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF5C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 11:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiFJL5t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbiFJL5r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 07:57:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3413E0F
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 04:57:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 129so24580717pgc.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=igzCllVRZ/Iftq2E4CRi0LLTYy5lp/pHxz7UxtsP51k=;
        b=AMHpDk9qHv4rnINo0J+czujxSJ5L1vIr4mcyRxfGpGhF/Aj+B3KLVP1Mc85bVv1ciD
         m8LQ9GEoo9bRzqFVvjozjIV8VxDxxEylklPsG7alvRajANIQjbVtK2PjQm0qDYkHwnSD
         lzzPGxXJJmAcCDlE0yjlaveSDcViegjnsadOG6gPPukJsk+WZqg06YO73RiKBRai9KH0
         pypB4izDuwD1667UwBvGGpx+4Xc9NS0S2LmeyOBc/CwPjwJk7QAAA7hbliMsIQGIc/EE
         918NvBa57pjju0K6RVsJfZW3/NM0UnWXiLO29EUIYVL6Fotty9vS+lXggn6IZvaCGUtv
         tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=igzCllVRZ/Iftq2E4CRi0LLTYy5lp/pHxz7UxtsP51k=;
        b=iSfeEMSfU7ofFNRGHtGbgLMdusEWoLA4su9YwP/bTkdNvW8xOxCYh9t8kDcmyKTmam
         HnVZaRM9ewdTmimYCVwN0Ts0posjNl/TtNXgS69kP+6YgNG7pMYYssEC/z18oMB6Hs3Q
         QKlKEM+Vpf/jz0zFBbiM3bvi+g//JwbcniGTkqHgLK4z2HTws9Tew5ReSb1ZCxDhA81n
         ooXWENcIQ3io9GAUAwrT5LssGywIy0dZAq4oCdvxMpCqMSbjQvp9kkjX7tjzL2//pJNm
         pZAKjq4+3a8MoC/1yg3/FY+e5Qy9Sl4SsKtcGNt4mMB8hiDHF5ULfy37lz4e/rb9xNK8
         9T5g==
X-Gm-Message-State: AOAM533UE9bgXY0TM3Wqi1C1UvTPhdT6ilOQXbXUZV/dtvORvkqvBNiX
        JWuWEGQB9X44LEq02zUiHqsbjMsnChk=
X-Google-Smtp-Source: ABdhPJwW94agBEXWe1eF1KOLz4qzyxonadu3UN/oau3OcaUn+a+eZsJC5dpkbmGotsbd4TKYGAnpMQ==
X-Received: by 2002:a05:6a00:140b:b0:4e1:2cbd:30ba with SMTP id l11-20020a056a00140b00b004e12cbd30bamr45784722pfu.46.1654862266473;
        Fri, 10 Jun 2022 04:57:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.90.34])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b0015e8d4eb2d8sm1565166plw.290.2022.06.10.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:57:46 -0700 (PDT)
Message-ID: <62a331ba.1c69fb81.67749.24cf@mx.google.com>
Date:   Fri, 10 Jun 2022 04:57:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8467504198797606930=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [v2] Bluetooth: RFCOMM: Use skb_trim to trim checksum
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220610110749.110881-1-soenke.huster@eknoes.de>
References: <20220610110749.110881-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8467504198797606930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649266

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      31.50 seconds
BuildKernel32                 PASS      30.28 seconds
Incremental Build with patchesPASS      39.69 seconds
TestRunner: Setup             PASS      487.85 seconds
TestRunner: l2cap-tester      PASS      18.02 seconds
TestRunner: bnep-tester       PASS      5.79 seconds
TestRunner: mgmt-tester       FAIL      106.97 seconds
TestRunner: rfcomm-tester     PASS      9.38 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.11 seconds
TestRunner: userchan-tester   PASS      6.15 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 106.97 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 491 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Add Advertising - Success (Name+data+appear)         Timed out    2.769 seconds
Add Ext Advertising - Success (Name+data+appear)     Timed out    2.405 seconds



---
Regards,
Linux Bluetooth


--===============8467504198797606930==--
