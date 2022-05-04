Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 10:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347723AbiEDKID (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiEDKIA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 06:08:00 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B6286D9
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 03:04:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f186so575680qke.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=q6rsMbaLsU9r8TTn8lkTR2g2jgeMYEBRH7fEMRG8DyU=;
        b=n2z50Co8vM6ZJMB91mGdNOIPP7CO33Sc4GP4omqFWcv7WxJSu4sVOSQYqAxdYZDQeQ
         lECS2jF2BwJaYPA8nql0aukh9iwAt1/hcZnmaoNryZN2TaBAse0acj5jPBLYh6p0lQzm
         yGi3MSA6oBDIh57s6WgHwkorWAnM4slaAnVZrr4uIH/3hw0BAxB/AE9hoQbthWhmxxxv
         zw423c8mrtmcT/k+bKalNP47pXVDpK/gp42EU1eS8Sh8oFBQGywdlSCnUHb+O5+f3AcP
         QdGa6fyTK25C6NwEEHAcXNou+VzIiw9tVBZJk5U8fD7vqr47cKG6FGAtNkiEcNmgsV5t
         0LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=q6rsMbaLsU9r8TTn8lkTR2g2jgeMYEBRH7fEMRG8DyU=;
        b=pIIo72MvcS1ylWvFkhkIWzSAnWc9MC3EM+9XPBP1JxfzmHomIYVeeM22/PGzg+asgY
         fIs8MmfDrgbDAgY94vyg1CPHN35WUnehD5UTohKLT1pqzIL4JiEDyxEoNQT2eanCGgx0
         GXloehM62TGbez38HJSoHL7OQmZWAAAIa0SV50Ew6BLsPiWMqwRKfFLP2AVWSiAggmYq
         OEZ2GcjGdiT3n+FWxMKLQTyzZjdhvAqo6YHmJDzWiAUDg4bNR1hXsrhu8pwgpLtiaC/C
         z9R1QhhH3ODToYy/3mcZ5XRKhG+KZZE0Eat6H0WVBWKRibqxULp3n7BzEe4DXStgbr9i
         0CBg==
X-Gm-Message-State: AOAM533YQ8vtwRVW7JAstSOK3QVIzKXSSLmdujjxfrmdt4GW8IBeK0S3
        ZivmPCGa1nqHV6oBdtV2KGwRwjIcHlY=
X-Google-Smtp-Source: ABdhPJyvcH/Nqspw8bEY+n/QteZZ84+7t/NXHz51srfKrWcEDIaNf047MUurEPaYEpd0zJMyoMC4Sw==
X-Received: by 2002:a37:6549:0:b0:69f:a625:fe2b with SMTP id z70-20020a376549000000b0069fa625fe2bmr15096105qkb.132.1651658664557;
        Wed, 04 May 2022 03:04:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.239.72])
        by smtp.gmail.com with ESMTPSA id o26-20020a05620a111a00b0069fc13ce242sm7292200qkk.115.2022.05.04.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:04:24 -0700 (PDT)
Message-ID: <62724fa8.1c69fb81.9760.44e3@mx.google.com>
Date:   Wed, 04 May 2022 03:04:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0793106985342319226=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hakan.jansson@infineon.com
Subject: RE: Bluetooth: hci_bcm: Autobaud mode support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
References: <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0793106985342319226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638213

---Test result---

Test Summary:
CheckPatch                    PASS      3.55 seconds
GitLint                       PASS      2.05 seconds
SubjectPrefix                 FAIL      0.89 seconds
BuildKernel                   PASS      31.78 seconds
BuildKernel32                 PASS      28.33 seconds
Incremental Build with patchesPASS      46.11 seconds
TestRunner: Setup             PASS      478.79 seconds
TestRunner: l2cap-tester      PASS      17.45 seconds
TestRunner: bnep-tester       PASS      6.18 seconds
TestRunner: mgmt-tester       PASS      101.56 seconds
TestRunner: rfcomm-tester     PASS      9.85 seconds
TestRunner: sco-tester        PASS      9.53 seconds
TestRunner: smp-tester        PASS      9.57 seconds
TestRunner: userchan-tester   PASS      6.40 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.89 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0793106985342319226==--
