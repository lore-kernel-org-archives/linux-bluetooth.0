Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1571C76188
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 23:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjDCXf5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjDCXf4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 19:35:56 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E5E1BE4
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 16:35:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso1246748ott.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680564954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+2SwUwNMrwzATWpx0IObIc6o4NNW0TwYVffKH2s8rqQ=;
        b=eGEtsWdAXFsBVmmg5xcTuE57FGrDKeAmqDchxi3X/Tfo9YjlkX8xdFN7y8tCqgiizK
         MAlw5uyLmua7sWtS+GFBq5jAOwOlIkD/9JezfO0whuwK6cMjG/MmRHs5u4NOyNnxgWrE
         1cAJaRHFACevXIh6NHoQsn+zvOQ9uKiI2zyq8rk39rfnatlbzyV9U+uc/Lp+iTyXp8A5
         e+ZRYP8BQPFnO7wONzwRWjzxa6q9hO4BLMGXyaDBHGDjF1U+gFy/q0wN3wlErLgLZQuL
         4nTCXZIZutTe7ULJJEnIfxSoLjPsJyoxrKlycmg+f4+nNePJYqhvzLAOQzP1EEDVkMD6
         g3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680564954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2SwUwNMrwzATWpx0IObIc6o4NNW0TwYVffKH2s8rqQ=;
        b=tcyBpw4djtc0l0Ez8b0r4zjUBMuT+2Cuo4UxBL363ReUo/vWlfbF1tcu4xzaR/IOrI
         JVouQQ+F3WzP+5u6aNA4NfxhbJngb+AaCbvsY/ZdIcwptzd0SSwHOXJs+QyuLSJzFwtA
         E+wOTaghKG7wJfAdXkLQi62+epOOeTFrPBkw5U+nxsStkQAv+nmS0U9JyGJF8r3cPnL8
         xlDIIHh3nbLT1yRxAWgNgOY55DVdkcH1q/8c3Cv8t0q/vg4NFWzlhVTiyouSmY4/Z3Dj
         mJb/9r4v6auKSBwIRko1hygcXKtx3pLBMdLdYu8Sz/tRKStMFpJoRy417QFyZkd4bIHs
         DcDw==
X-Gm-Message-State: AAQBX9eXykVQCH2gYtT4E2V+aLSn0tfz1RzjtncZ6N2HnXAg4/ktmNSO
        mdldSIs3kH8KKyTWrt05dTT6UWpxXj8=
X-Google-Smtp-Source: AKy350ai/TzVxGHrEev1s0POovCPoSSe862tFKwkfI/TE7MyKZ9VXLjcore1RT2wDRMb4QJz0/ubyA==
X-Received: by 2002:a05:6830:e8a:b0:6a1:796e:c380 with SMTP id dp10-20020a0568300e8a00b006a1796ec380mr409791otb.6.1680564954684;
        Mon, 03 Apr 2023 16:35:54 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.50])
        by smtp.gmail.com with ESMTPSA id k21-20020a0568301bf500b006a17bffbc61sm4857527otb.38.2023.04.03.16.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 16:35:54 -0700 (PDT)
Message-ID: <642b62da.050a0220.49f60.a71e@mx.google.com>
Date:   Mon, 03 Apr 2023 16:35:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5243097980631607708=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_conn: Fix possible UAF
In-Reply-To: <20230403224412.2021594-1-luiz.dentz@gmail.com>
References: <20230403224412.2021594-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5243097980631607708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736584

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      38.44 seconds
CheckAllWarning               PASS      41.94 seconds
CheckSparse                   PASS      47.49 seconds
CheckSmatch                   PASS      128.77 seconds
BuildKernel32                 PASS      37.21 seconds
TestRunnerSetup               PASS      529.38 seconds
TestRunner_l2cap-tester       PASS      18.42 seconds
TestRunner_iso-tester         PASS      18.87 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        PASS      123.34 seconds
TestRunner_rfcomm-tester      PASS      9.76 seconds
TestRunner_sco-tester         PASS      8.91 seconds
TestRunner_ioctl-tester       PASS      10.46 seconds
TestRunner_mesh-tester        PASS      7.89 seconds
TestRunner_smp-tester         PASS      8.89 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PASS      34.74 seconds



---
Regards,
Linux Bluetooth


--===============5243097980631607708==--
