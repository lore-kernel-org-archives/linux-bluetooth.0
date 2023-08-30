Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AEBC6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 23:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjH3XRx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 19:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjH3XRw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 19:17:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3748F
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 16:17:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a9f87adfe1so109263b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693437469; x=1694042269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uSdbp8QAM+2Rb1MEjOEDPlWFUoqXyckz9S4YkUdoqUY=;
        b=nsF+mW17fRm2pgdluXUt+YU6Ug8FnAMGctY9lTFyOe7RkU3iZKzNVcO3Ay/M9ib/b9
         AIaWBfTLadYSLLINooSvC47/SU8dO8HxMuTwW57xOddCG1uvHvdvKR0UcQUMg/TCeW+w
         KtG9INLBfD8KCsG6WTSuHsezJrRGc+QEj+IxNE2teYX+iN8T5cLcBGIP05J265C5A3XJ
         6TZaZBSTqfxHkUBOYleYi7p0QSyS0IUM+8lOgIUANuLHLRvcmPjggxms9sBBUv/XIGIE
         4T1jFdcWF7ULPlkEPtBGyAC9W1J31i54HhJCf0Oy03IDf4KrKo4JmUMeqSuHrHHif8mV
         2RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437469; x=1694042269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSdbp8QAM+2Rb1MEjOEDPlWFUoqXyckz9S4YkUdoqUY=;
        b=Trw+Xn7Qkr/jemvvdtu5BtGI873KD1FKovQOy94bGLkXcqeYUSIQnea1s3l7ACW4zu
         TC36QD8wHBanh7ovki4NeKRPobL6/cxv+XhmpolxTIUUGcvDVKC06kEmgmsgnLZq8Td2
         Tpah769unhFiZe3cqq3Ih2bmT94m/O/+MDNkYd2BJDRAfouYNrlDtiQ8uudFkxUgr3vz
         vNJUTybWmgHcPEVqT3IszuPjDuUy0rf5D9zOsvrx6Na8w+K5pldspcfCKE9tScZx7h8e
         1EHd1nENJGnU3sxv8teguIOhWRAZ6H0pxSJnRZmNo5DwF+dY5TLmVvISOS8G0wvqV87T
         VOpA==
X-Gm-Message-State: AOJu0YwRVQxVkyuoFGaaRHXdDrm+5uPWWq4Qyg5ZjFVOFKfED/2guo5g
        RU1Quu7pkwPYvJ5HTkGAMvf2ckbAJoI=
X-Google-Smtp-Source: AGHT+IHfgb2xkUL7BZW5ZgdCq1K4vpYMQuoq//Whkfo3GQBb71H49mdBJKdoHed/bn+BhwreYcvzPA==
X-Received: by 2002:a05:6808:3ae:b0:3a7:2524:6d46 with SMTP id n14-20020a05680803ae00b003a725246d46mr3363793oie.59.1693437468839;
        Wed, 30 Aug 2023 16:17:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.182.79])
        by smtp.gmail.com with ESMTPSA id e19-20020a056808149300b003a5b027ccb2sm96842oiw.38.2023.08.30.16.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:17:48 -0700 (PDT)
Message-ID: <64efce1c.050a0220.b434.08fa@mx.google.com>
Date:   Wed, 30 Aug 2023 16:17:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1944759888529886817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: SMP: Fix assumption of Central always being Initiator
In-Reply-To: <20230830220806.999566-1-luiz.dentz@gmail.com>
References: <20230830220806.999566-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1944759888529886817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780658

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      37.88 seconds
CheckAllWarning               PASS      41.46 seconds
CheckSparse                   PASS      46.45 seconds
CheckSmatch                   PASS      128.31 seconds
BuildKernel32                 PASS      37.44 seconds
TestRunnerSetup               PASS      567.35 seconds
TestRunner_l2cap-tester       PASS      32.06 seconds
TestRunner_iso-tester         PASS      65.26 seconds
TestRunner_bnep-tester        PASS      13.08 seconds
TestRunner_mgmt-tester        PASS      247.48 seconds
TestRunner_rfcomm-tester      PASS      19.32 seconds
TestRunner_sco-tester         PASS      22.55 seconds
TestRunner_ioctl-tester       PASS      21.74 seconds
TestRunner_mesh-tester        PASS      16.15 seconds
TestRunner_smp-tester         PASS      17.01 seconds
TestRunner_userchan-tester    PASS      13.56 seconds
IncrementalBuild              PASS      35.47 seconds



---
Regards,
Linux Bluetooth


--===============1944759888529886817==--
