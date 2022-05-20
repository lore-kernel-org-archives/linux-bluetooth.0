Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 16:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351418AbiETQKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351395AbiETQKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 12:10:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188D17CE78
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 09:10:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e17so6961661qvj.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=92Pw4pNAX95qiS9x7BsjOAYPP0fxa1Y04Mu4i4Oco84=;
        b=pEs0wfRjPvuSPu32CHLxD5WQihO04AvzFRKJR1lgh/0TbVKB4yDqPDDLMSj+X5W0HF
         EKFZl17RCdFiL3j13dEcw09NGx+VQLICHdOGdv8+lPqOnWDf42HbMuPDtayJBRUnhv0A
         pvLtz73LD13VRGi/R1/Tdbs8uXUV+LyCLSbt6vwtmu93aHF92rijSq5+mVqzThxaw+Qh
         AFL/1s/rhgkb6WV1avQXD5BOKCxG8pgoCs1WECG0p2fAFrFLrB9jAcSAhgVN4+UyJugp
         cS1cKMv5JqKDrBiFAPdkPcKB9rxPX3b6QXu1FVlKUO2XJSSK2F2cPtbSnYWmvwadLVxt
         8YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=92Pw4pNAX95qiS9x7BsjOAYPP0fxa1Y04Mu4i4Oco84=;
        b=H9rWKAQAUn+mDrrq1Zd3GlL9A4vYjXmyDTYtGgYMKxQGg2FQpo3RGhfMXzKBz0o3EG
         TvVyf1qjG7sDwyyruG7ac1bqOAVWW1+PguH/mMJLj4FHt2kvwD+xoOiuzB1fssd0wDzR
         V8wCuDz/6Gn5FFdktbFZmntvvyE78XhxQSrCEXFD29t1unLDVfSw6XcIFF7HdfntTF2F
         JgOd9XqN6IB0jvg2fEVnRf/eDSEWEsk2C8e2qnyscgb2Yz8B/P7WHK0QioD3Bxdk86Gi
         Ad+Bp3dcX2xT1BvNGLbjfw7e2ji3JDavBmhoG2PN8l8uNDVMZcPuQ5zIxw/wOQWPsScr
         APwg==
X-Gm-Message-State: AOAM530YurzbipfscOoL3M4Qgw4RnMCcznERlSKdpaMuQsSJJX+Osa0j
        RuNQ/1/F58bT6GN9kfP6tCCkBzuuLOYjJg==
X-Google-Smtp-Source: ABdhPJzDIuLcWx+sjdILwUisQRj/ulUah/Q3YWV6Jc1IoPanRDF7nYJXQ3FzF1wP6hOKIzFHV02xsQ==
X-Received: by 2002:a05:6214:1cc4:b0:431:4cbc:1d91 with SMTP id g4-20020a0562141cc400b004314cbc1d91mr8666083qvd.64.1653062999603;
        Fri, 20 May 2022 09:09:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.121.86.90])
        by smtp.gmail.com with ESMTPSA id n22-20020a37a416000000b0069fc13ce1e8sm2871694qke.25.2022.05.20.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:09:59 -0700 (PDT)
Message-ID: <6287bd57.1c69fb81.a6ee2.0f35@mx.google.com>
Date:   Fri, 20 May 2022 09:09:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8545357891181623628=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hakan.jansson@infineon.com
Subject: RE: Bluetooth: hci_bcm: Autobaud mode support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <cb20a6f49c91521d54c847ee4dc14451b0ee91dd.1653057480.git.hakan.jansson@infineon.com>
References: <cb20a6f49c91521d54c847ee4dc14451b0ee91dd.1653057480.git.hakan.jansson@infineon.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8545357891181623628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643647

---Test result---

Test Summary:
CheckPatch                    PASS      3.61 seconds
GitLint                       PASS      1.98 seconds
SubjectPrefix                 FAIL      0.89 seconds
BuildKernel                   PASS      35.16 seconds
BuildKernel32                 PASS      31.24 seconds
Incremental Build with patchesPASS      51.57 seconds
TestRunner: Setup             PASS      512.66 seconds
TestRunner: l2cap-tester      PASS      18.90 seconds
TestRunner: bnep-tester       PASS      7.01 seconds
TestRunner: mgmt-tester       PASS      113.17 seconds
TestRunner: rfcomm-tester     PASS      10.72 seconds
TestRunner: sco-tester        PASS      10.46 seconds
TestRunner: smp-tester        PASS      10.39 seconds
TestRunner: userchan-tester   PASS      7.18 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.89 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8545357891181623628==--
