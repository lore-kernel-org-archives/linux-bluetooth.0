Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF00023A22
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgLIB50 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIB50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 20:57:26 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9BC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 17:56:45 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n142so687025qkn.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=k+I2WAaa/Uj8JCcrSJCBXS9AIuBWJ6/7/FMQoui6OpM=;
        b=k5HwP1nUt7OmU2afKGsweo83XgrDuGICPSvuqvYe+raMwwxwAHLQar/LlvJuwTgIVm
         E1Xi1FPW13xndxo9blLi0Clo47l9ZIiISEyPO+iqVF3ha/5buEgg6TfABvMYzdzeU7+E
         Sbb2Gf2nV2Q4/nP9T+4w0vpFxCR/yjLSEGZ4peNdme0vYqdzqCG5do+QLBdLlpM9FhFW
         pI5tQVZskPIx/iasYh8tjzVYSN/ECpF86DTNS2LSI4GyrHhn+sl/g0hBbj1wFAswKghI
         HsaN+mPb5+bwo8ciwlrLZkdikTDzS1rndVjO5SVVVVmByESiwHmcJ0y6zwIhKR3DQ8rF
         aCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=k+I2WAaa/Uj8JCcrSJCBXS9AIuBWJ6/7/FMQoui6OpM=;
        b=i7gbQKUApFqYjrzYbVizOTj2KJqSCfZxu1Fr5rCqKQN1kxAn84vUzJP9kNH2xl0SIJ
         MBx5nzFTQEsK0yvkS7zSaEnhlWDuTy3dVM7lxHmEMhQgflgDZU8BXf0cjTt9ha/thJqw
         VwdCnNWfGwFONpTq0Hn/NKMy6tXUv1rDwD5RD27Tizm/JnaxzIILGleXfXdi5n9Iwsuk
         2SB/FB1pEYD5pFvKXCCHJ75xjqwaFP/cS4qoWRtaw2TGxzboozeuEGifq8ci1d/Cttw9
         BZ8IZYJSvRGBMs/AqIhfmhY6QBezfQQujf87pIPBQeqlHLRU8W3urKPDY4l4xrkNENyA
         bETA==
X-Gm-Message-State: AOAM533Ycssf1YsnpncMj3MAMJNhOEtuf1ALmvaML1qKznlR41RV93u4
        ysarqGXvPDFOsVrHtZDfoyUAMvzXpZU=
X-Google-Smtp-Source: ABdhPJyogLfZx6nMTumBCgPEvNTiMuBg1mQFnbeemNvVx7nLocffiin2TJF924agUoQR3f1TA5XSXw==
X-Received: by 2002:a37:7bc1:: with SMTP id w184mr268509qkc.190.1607479005054;
        Tue, 08 Dec 2020 17:56:45 -0800 (PST)
Received: from [172.17.0.2] ([52.232.242.205])
        by smtp.gmail.com with ESMTPSA id 5sm113629qtp.55.2020.12.08.17.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 17:56:44 -0800 (PST)
Message-ID: <5fd02edc.1c69fb81.284e5.093c@mx.google.com>
Date:   Tue, 08 Dec 2020 17:56:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2386986664528611014=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,1/2] Revert "input/hog: Remove HID device after HoG device disconnects"
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201209010030.342632-1-sonnysasaka@chromium.org>
References: <20201209010030.342632-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2386986664528611014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=398575

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2386986664528611014==--
