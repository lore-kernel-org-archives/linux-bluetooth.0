Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F77EC83F19
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjH3UHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbjH3UHS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 16:07:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C2B96D
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 12:53:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c0d5b16aacso307205ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693425109; x=1694029909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUwXiLaCaMhydgo6QlNbgyAk60XGjxDq+lNQcZm3k3M=;
        b=MRWi2AcoOOu18dUOeybRaMIU1C5XjOVU3Tsc9eJIP0P2se/iPal1I4sdD2oOoc7+Dj
         QpOg6ifwOwa66aOKbXlB3wVOQHk03RmsHaAoBSR+1VrFTc8MKghGt52aDCpK7Q2fWv28
         PbxQELQzhXnBMFTMixjkzqYMDKyqyKlWFsEQ3u+F4+Za5pr5+xB+xa/CRHZOOikHEn/w
         hUPkQPKtsWy4r3x8x9gN4qusC/r6410mMcGvaa32WFWwctnTMxLhcy6U3M2gu+aXo/dq
         XxjCxN4MVBWaBjRPt8ofs+3AsggmSTBtxQbrJ80z7Zi867gtb16zjcz5u3bQ4Bg7bmUO
         1WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693425109; x=1694029909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUwXiLaCaMhydgo6QlNbgyAk60XGjxDq+lNQcZm3k3M=;
        b=eIrzNBuV24tPp94yXVlSNbt92XH3WBsBKQxDrVZstu1OFX/0KXGAIlp0dpds3cxwZR
         ksGI5lgMuLreuKGv3yMYo0uNacUj5TXLC0HNETSwgG1XxWboynvZcSBHS9X3qkvs6jGd
         q/5ybG0K3qsEmCxK+Y/IS8RUsBFAJD3YCMZTDGgCNUR1Jlvx+ikMdUM0SXFiz1uDkBvw
         oxhx/xdPSIj6gJLxBwtpm3+rhJnBfct/6DzEcc8sk/DGXbmiRCcmsJ4O3STm9SE9Pq6/
         VOtK6O8c750HmN7zKvDsu/5Wj38Lp2/zJwDKZuvx+QwJ/PffHpsYS/XvBz1P8Lg6YZeE
         hk5w==
X-Gm-Message-State: AOJu0YzJl2EouwDztZ3HPDwAaWi41bWIrkp51gGVaSjYR53FhyW/AOuV
        A1jH0yKAoF+RExyA4D/SVuJ0WLHF/gA=
X-Google-Smtp-Source: AGHT+IHie13jBhmP6hlw7X4wKKd7fKkM8P/PH/iMa6RFwutiEH/6QLnQ2LX+o5e3EKMc9mxu3nyvUA==
X-Received: by 2002:a05:6870:468c:b0:1bb:99fe:6ad1 with SMTP id a12-20020a056870468c00b001bb99fe6ad1mr4161441oap.6.1693424531729;
        Wed, 30 Aug 2023 12:42:11 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.136.33])
        by smtp.gmail.com with ESMTPSA id x7-20020a4a97c7000000b00573320e1241sm6692228ooi.14.2023.08.30.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:42:11 -0700 (PDT)
Message-ID: <64ef9b93.4a0a0220.6aa33.4fc4@mx.google.com>
Date:   Wed, 30 Aug 2023 12:42:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2301478559166032995=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Fix master BIS cleanup
In-Reply-To: <20230830153840.518868-2-iulia.tanasescu@nxp.com>
References: <20230830153840.518868-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2301478559166032995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780616

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      44.88 seconds
CheckAllWarning               PASS      47.65 seconds
CheckSparse                   PASS      54.35 seconds
CheckSmatch                   PASS      146.70 seconds
BuildKernel32                 PASS      41.97 seconds
TestRunnerSetup               PASS      641.38 seconds
TestRunner_l2cap-tester       PASS      36.18 seconds
TestRunner_iso-tester         PASS      89.15 seconds
TestRunner_bnep-tester        PASS      14.60 seconds
TestRunner_mgmt-tester        PASS      273.56 seconds
TestRunner_rfcomm-tester      PASS      21.61 seconds
TestRunner_sco-tester         PASS      24.81 seconds
TestRunner_ioctl-tester       PASS      24.89 seconds
TestRunner_mesh-tester        PASS      18.66 seconds
TestRunner_smp-tester         PASS      19.63 seconds
TestRunner_userchan-tester    PASS      15.24 seconds
IncrementalBuild              PASS      39.59 seconds



---
Regards,
Linux Bluetooth


--===============2301478559166032995==--
