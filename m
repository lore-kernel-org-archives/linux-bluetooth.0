Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94440EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 09:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjFTJA7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjFTJA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 05:00:56 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4A10F3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 02:00:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b45e465d4fso2718071a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687251651; x=1689843651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bugcBYBlBP9WkkrL1rEJVkMLEe1CPCRKjQ3xKPoKn8Y=;
        b=LmPPGyZbd4sn4h2KhYcJY3tsXB3mQkm8/1LeElDzsOSIaMNyHex5Giw3xToUQBJR42
         CkJbqCb9BNTFiV0pbzi42UWmUZpa324/gZVlg8EjzaButrRa1cSI1zMqraVo9URSU0HL
         dMBiGSIXBwZiwYUJk233ImmA7QqSE5zxNAzAF+Pr7rhD/LbYR9IatBD2xUF98Gy6MGjd
         O40win5QqY/GsqulGGw5BHUcjk1G0Llt0PKkxOPvpWe4GxV1fDjDh+RNExtzjhcbNvFf
         5OCnoVHh+BMKv3flbDLNFiL4THdoG8MH3l5vJjIwAF4kE6T02bCH2//gfnbmPnsY4E+v
         ZDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687251651; x=1689843651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bugcBYBlBP9WkkrL1rEJVkMLEe1CPCRKjQ3xKPoKn8Y=;
        b=Z7YRHVh16x3cQjFfZMYCE7TfCrV92NZd0x2AfNGDNlgYK/U1uj1pu6TlmSozIS0lCB
         yo4GJg/wK5pWfRQ+tTXiuQ/Pq+xHpP2U0HHcihWEFS2V3vk8Djs0WBeKTfHyNZP49fs7
         B5ZeMGtSGVIHH6p6nLYviTfs3ptm/15xSVxNuBdoj2jp1moE9146LCX6zQm+dAVIGfyS
         lTpMRVhSeLojGympLzpw8eB84Neahvusuiu/2S5DOJ0lylVcsJVNWi0b1In+lk1Dxmg5
         SD2HLkGS09Ujgsp7nwKDzE8cMNIlSbBz0qNTjnYdm2f4mOibYKjCTsDTieVtbBGr2tI6
         aQ8Q==
X-Gm-Message-State: AC+VfDzf82anLk5Q84V/iXKf+6jIKKAp+tn/nPixPqjSAw9oEsDHjEGu
        7tBQ8iJqirIcBh2lcDnnZimev2Bpy6E=
X-Google-Smtp-Source: ACHHUZ7lWCFCVFWzjUycGT9vVp/Bw1Nj3J8afgHa2y2RBFCOIobwaRqXrc0WjkqwjRhJTEy1UywTXA==
X-Received: by 2002:a9d:7745:0:b0:6b4:4cff:8fed with SMTP id t5-20020a9d7745000000b006b44cff8fedmr9482659otl.28.1687251650890;
        Tue, 20 Jun 2023 02:00:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.225])
        by smtp.gmail.com with ESMTPSA id q19-20020a9d7c93000000b006b29947160csm728941otn.30.2023.06.20.02.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 02:00:50 -0700 (PDT)
Message-ID: <64916ac2.9d0a0220.7bc9.343f@mx.google.com>
Date:   Tue, 20 Jun 2023 02:00:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4609194903567274634=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: [v4] Bluetooth: btusb: Add support Mediatek MT7925
In-Reply-To: <20230620082750.9218-1-peter.tsao@mediatek.com>
References: <20230620082750.9218-1-peter.tsao@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4609194903567274634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758585

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      38.83 seconds
CheckAllWarning               PASS      42.52 seconds
CheckSparse                   PASS      48.10 seconds
CheckSmatch                   PASS      129.99 seconds
BuildKernel32                 PASS      37.44 seconds
TestRunnerSetup               PASS      533.47 seconds
TestRunner_l2cap-tester       PASS      19.45 seconds
TestRunner_iso-tester         PASS      28.21 seconds
TestRunner_bnep-tester        PASS      6.93 seconds
TestRunner_mgmt-tester        PASS      130.99 seconds
TestRunner_rfcomm-tester      PASS      10.67 seconds
TestRunner_sco-tester         PASS      9.96 seconds
TestRunner_ioctl-tester       PASS      11.62 seconds
TestRunner_mesh-tester        PASS      8.61 seconds
TestRunner_smp-tester         PASS      9.71 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      35.47 seconds



---
Regards,
Linux Bluetooth


--===============4609194903567274634==--
