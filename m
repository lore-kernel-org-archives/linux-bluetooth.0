Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 15:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjE3PBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjE3PBM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 11:01:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D863A0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 08:01:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-256e1d87a46so140377a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685458870; x=1688050870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vr7ca4vFqASxUEM+89U7ZwWKpQe3RK4Mfv4Qv8u6oXc=;
        b=UxRnWs2/L0sNtBrjHgHfWu3EWcqaTcWWjStMIbRzU8EVUxF+cYQ4UW1i2jealZs6x9
         j24LqTQnGVh9LBRTZG4zWDwDzJ8vDWUljwr6Aswk+wuvBygPTnJ+COjr0fa5NabB0oXM
         84iDFAT2WD36J9YpCZGFHuhPVnFUgGjKEUFhidnsNoFUORXCZCMD7N+XqqjqiaGO/OPT
         km+shGbYPhti9bQOG3qPV8QvzAx8QkE05CMhBoY/k+LocbgZ1SMj+o7APDpnSjL6RqrC
         HH7fBAgWZwOtv87Eewq8XINs705MODVfYCkCKtRbpMCv/pAzTcCK5zAL7In/BevrWx3d
         DkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458870; x=1688050870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr7ca4vFqASxUEM+89U7ZwWKpQe3RK4Mfv4Qv8u6oXc=;
        b=Eyk3BO5xAbT7tX0qVTyTTjjwl+F3BoTeFt3IwIhmqpZR1WNDq5zODqcQ0qrJKWogmd
         nMBv41rJYLMmkB4ovSaP7VcJ02l8B6ZLf/UZNw5O0SgjdPElikYSvbtdaZ6XpdgE/Sc0
         t+dN4DawJLjdocBQ9f1uWSlB2OAbADptNjhawlHjlSJy2qpeVUcRGYY2dRN4y3+q44Tk
         LNduiWRqcIF6vVY1rNXYH1HNY+UrnBTfgIz991tUPYKV4IUn4qGIGLwWPrqOpEWHt67p
         TdFjhVmc9Ep3STV8LicNmyMohhc2ln2vsy4ES5RKJWsvTOHD8AbbFPzKqmuBXOoBu3MY
         Pjkw==
X-Gm-Message-State: AC+VfDyk6HCfLGT0ZX5hCR2DT7dI7P9srsIzjiY9qaiJ3oO5RgVnFvn0
        pbSAmEEvyx/oExNhS0ZTcjemUz+OQ2c=
X-Google-Smtp-Source: ACHHUZ5opkLcOuKLTlaToTUicof1Hn+mS2D/4rvKWxO/ZZcwML+W8X+8xYj62LOTd7ENZvJrrWAW5g==
X-Received: by 2002:a17:90a:d504:b0:256:d207:ab95 with SMTP id t4-20020a17090ad50400b00256d207ab95mr1174815pju.6.1685458870133;
        Tue, 30 May 2023 08:01:10 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.14.132])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a420900b0024b9e62c1d9sm8826350pjg.41.2023.05.30.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:01:09 -0700 (PDT)
Message-ID: <64760fb5.170a0220.66234.ffb9@mx.google.com>
Date:   Tue, 30 May 2023 08:01:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5291212367382318578=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Add support for connecting multiple BISes
In-Reply-To: <20230530142159.410567-2-iulia.tanasescu@nxp.com>
References: <20230530142159.410567-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5291212367382318578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752269

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      38.88 seconds
CheckAllWarning               PASS      43.17 seconds
CheckSparse                   WARNING   48.97 seconds
CheckSmatch                   WARNING   130.37 seconds
BuildKernel32                 PASS      38.66 seconds
TestRunnerSetup               PASS      536.46 seconds
TestRunner_l2cap-tester       PASS      19.48 seconds
TestRunner_iso-tester         PASS      26.38 seconds
TestRunner_bnep-tester        PASS      6.79 seconds
TestRunner_mgmt-tester        PASS      133.06 seconds
TestRunner_rfcomm-tester      PASS      10.68 seconds
TestRunner_sco-tester         PASS      10.02 seconds
TestRunner_ioctl-tester       PASS      11.81 seconds
TestRunner_mesh-tester        PASS      8.74 seconds
TestRunner_smp-tester         PASS      9.85 seconds
TestRunner_userchan-tester    PASS      7.32 seconds
IncrementalBuild              PASS      36.95 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5291212367382318578==--
