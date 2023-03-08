Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7349AC678D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 15:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCHPCk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjCHPCK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 10:02:10 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A6B329B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 07:02:09 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id v10so6873083iox.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Mar 2023 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678287729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm3yy5+cflMIOU4G4D/BZCJdfoyAcxiQlQ3sktYqiAU=;
        b=pWdAZTXxm6VrCuiAivi3MVlM1RvSlioFdnRWlTGqNw9wYqs/mQLT5GwrCCOaYPzkEY
         C/BW7GZIBCUwXEMqP+hbFk0ekEl9iSl8x5N7uhyCeT3MYjhmtEy6n31xC2u47+kcY8Zh
         fIn/SVd3/96yX5yxi3wRbgx0j4656wZ5M4I03/tZJ7b5v5VBF0lL82fJt4I4/GtZDkkb
         ko9vlCMYSm7ZcLF+eWOGf+aoUFmgNSh45n+1eZpshJjYV9X1mu1tunjvlj5V2bRU8n+P
         xj1Y+hCV9RDS2lGvYhoL89iMLJ7q0GtMQMbM5FIVhwHadt/8Z8rC7Dfus/+v/9uTHIti
         JDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qm3yy5+cflMIOU4G4D/BZCJdfoyAcxiQlQ3sktYqiAU=;
        b=ZWGHDTlBo+YLDqAxsV5y5BbtIoDz7ysAqvcUO7aZLsm0y/L0bBeLueTY+m7GxNda+k
         9NbsXS6lwrw78DCh3XPvYWUS8BdCIH7n/4lu/oqNBGMzdkzTs6ecaWtpOBLJpVbUr+O+
         3LrKTIlqcpEzTGbKryNjec+M7laIz3gQNf6LdgiRg7aivfIXR5lEyz6P6puODl602oNY
         XW+6Yamkrj5oqaW0pWQyaA89XOr4eM9Q0wyR5H+6d/71nywQsiXE0FS1H2xzjV9Ki7ST
         OsSGXYEPLD9mgO6E/x07qMmZpFg5UdnMs3Nj42yGm+7x+e1MNxF/u4hxNycxP89By9sl
         k0Rg==
X-Gm-Message-State: AO0yUKXayGP+auIYVpwzeTG9zhmUmN/OpzNy+7dlrcPX0bhIzyg8zhBT
        w5vno0bqQukpnRxxUewBck0hjj26BB0=
X-Google-Smtp-Source: AK7set82YG1XxKrLhRLHmrFPGNXaBR5Ba8pa55VIcOyaRJJSuP9VRa4vcF5Mt069CY0ZYLmXH7A0ng==
X-Received: by 2002:a5e:d90c:0:b0:74c:9cc1:baf4 with SMTP id n12-20020a5ed90c000000b0074c9cc1baf4mr14431811iop.7.1678287728786;
        Wed, 08 Mar 2023 07:02:08 -0800 (PST)
Received: from [172.17.0.2] ([40.122.242.103])
        by smtp.gmail.com with ESMTPSA id x25-20020a02ac99000000b003b443977af0sm5063152jan.7.2023.03.08.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:02:08 -0800 (PST)
Message-ID: <6408a370.020a0220.fa73d.8268@mx.google.com>
Date:   Wed, 08 Mar 2023 07:02:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8514115313961305614=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, stephan.gerhold@kernkonzept.com
Subject: RE: [v2,RESEND] Bluetooth: btqcomsmd: Fix command timeout after setting BD address
In-Reply-To: <20230308133155.165537-1-stephan.gerhold@kernkonzept.com>
References: <20230308133155.165537-1-stephan.gerhold@kernkonzept.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8514115313961305614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727907

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.89 seconds
CheckAllWarning               PASS      34.05 seconds
CheckSparse                   PASS      38.32 seconds
CheckSmatch                   PASS      107.32 seconds
BuildKernel32                 PASS      29.96 seconds
TestRunnerSetup               PASS      433.21 seconds
TestRunner_l2cap-tester       PASS      16.12 seconds
TestRunner_iso-tester         PASS      16.61 seconds
TestRunner_bnep-tester        PASS      5.40 seconds
TestRunner_mgmt-tester        PASS      107.58 seconds
TestRunner_rfcomm-tester      PASS      8.64 seconds
TestRunner_sco-tester         PASS      7.98 seconds
TestRunner_ioctl-tester       PASS      9.34 seconds
TestRunner_mesh-tester        PASS      6.86 seconds
TestRunner_smp-tester         PASS      7.87 seconds
TestRunner_userchan-tester    PASS      5.68 seconds
IncrementalBuild              PASS      27.86 seconds



---
Regards,
Linux Bluetooth


--===============8514115313961305614==--
