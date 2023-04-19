Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC332C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjDSQCu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjDSQCt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 12:02:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6111A
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 09:02:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so1632936a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681920168; x=1684512168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hhLBbiAgF6vFC4fMu9oM6HLWBCcx2KWqG8Yi1rYL/Z8=;
        b=PvVQARm1xtXtdZPzzMWpgmBOvoAfqzCu/NkFp2wGGclMNODD2cMUFM1N3dkmUo7ymZ
         JL0I7GgrkbkO1CJ5RRSSkjllmx/KRTFEDmlDLpUu1azIRCo9G20CVEMzLsx74xYjO/c2
         tFTOtXFkwEE0CYaC1jIu1+dHhDJlnHHjeH7dlTg771Bj/zyyxSrP3f/frfwiczRSs13T
         D/zC7SyqFnr01q78BuhsECP1HE7DYulNgWFkqN1tmrMEUHY1u+IHcZblnjefxwO2ZcNN
         0hfZtvy5wqQbY78UX3RbVbPPUf8kQkFhKK4o8qyAIAuoDzFnlEsgo5xVW+hdnhdyYn5t
         XdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920168; x=1684512168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhLBbiAgF6vFC4fMu9oM6HLWBCcx2KWqG8Yi1rYL/Z8=;
        b=KXhEbEUn2qvJ8ldPercsJpJNAcgTFDEwyiCRRDKQzKhyXl6NfT3PSCCk/G8HnmcJcg
         CecHl2nytjNs9ZeUVioBnWKixjepU9LfARp3XX4XGYzxJj9wU3RoB6iro/8/+mf38FuM
         sorDbYpgBEBp7pYV/eS2tragv/v6GoSVaI5MTTbUjbNp7PDibF9XPwGQueXdXu+Gy30L
         qcmMA3QiqvQuHxAxdsSjf6jbgzeuKMKsrrYTZdF1GPMUao5Priy8siE4a771iH6I9TDO
         oi9nqjX5tS2Uyg2dddN0ULCzvX94TBYkF9ENGJsTSIkwQTHxbqSRbkdz2auRRKxUbP8F
         +/Ow==
X-Gm-Message-State: AAQBX9cYFXw9zX5IlvJhCgu/koH8ylRnyFCUfp/RYq1jGrjg/Q0T20z0
        7+eYDdvmz9TDuKgK/MCrVqhFdR3XCEY=
X-Google-Smtp-Source: AKy350bRNdiqKn+XJ7Q4K/V3d9oH8qXxH1YDM5pKB7mICoJu79FMo2yABd75TFtYj9ucj10EM/7dqA==
X-Received: by 2002:a17:90a:6e46:b0:247:4f32:d108 with SMTP id s6-20020a17090a6e4600b002474f32d108mr3450587pjm.13.1681920167708;
        Wed, 19 Apr 2023 09:02:47 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.244])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a4e0200b00246774a9addsm1523305pjh.48.2023.04.19.09.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:02:47 -0700 (PDT)
Message-ID: <644010a7.170a0220.86a64.322c@mx.google.com>
Date:   Wed, 19 Apr 2023 09:02:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1710519774777431519=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable flow control before checking boot signature
In-Reply-To: <20230419152413.1688840-1-neeraj.sanjaykale@nxp.com>
References: <20230419152413.1688840-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1710519774777431519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741399

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      43.02 seconds
CheckAllWarning               PASS      46.60 seconds
CheckSparse                   PASS      51.84 seconds
CheckSmatch                   PASS      138.05 seconds
BuildKernel32                 PASS      41.38 seconds
TestRunnerSetup               PASS      573.80 seconds
TestRunner_l2cap-tester       PASS      20.80 seconds
TestRunner_iso-tester         PASS      26.49 seconds
TestRunner_bnep-tester        PASS      7.21 seconds
TestRunner_mgmt-tester        PASS      141.73 seconds
TestRunner_rfcomm-tester      PASS      11.55 seconds
TestRunner_sco-tester         PASS      10.92 seconds
TestRunner_ioctl-tester       PASS      12.47 seconds
TestRunner_mesh-tester        PASS      8.81 seconds
TestRunner_smp-tester         PASS      9.86 seconds
TestRunner_userchan-tester    PASS      7.63 seconds
IncrementalBuild              PASS      39.02 seconds



---
Regards,
Linux Bluetooth


--===============1710519774777431519==--
