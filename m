Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 03:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiD1Du4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiD1Duy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 23:50:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4869732
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 20:47:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r9so3146573pjo.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/B+bsHLKGCz+4XMd8nFKf9v6zOOCZ8yPsJEoWZsGbps=;
        b=X8dPUP0RACUheA1sLfZEMu1eEzxjbce2liI1xrdQQUk3Sohzj10AEaWwOQt1UmvhFv
         akPKF47braShUHMN0yUyEmwl6ZyT3EnA7zJ7NrFJsy7NKI50p9G33ky5F+tmQd3430Sk
         sme5Y4pMMqNabbUE57fRkpJm30ql4Pw0PiF33e4kIZ6H+dER4oh9S5itjEMUKUmccDYG
         ImaOoH/rPJX5yxNiWfsZmkGyDaXWf/eiS8g4crjexGXypI9GXxuMXvftDdDTvq+qtQFi
         5CAOxOn4AI12GcBC+ftYqx16lmk3BoGVbj0aTQXItO2AkpV6GnSqBqjSl12rQ9JR0vh4
         zBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/B+bsHLKGCz+4XMd8nFKf9v6zOOCZ8yPsJEoWZsGbps=;
        b=w3xODfUK5caLOi8G0wXatANUMnVkIdoHI78ZihFvCqCMC+Zz3DkJ5ssxIiC2C4gq+N
         Ltu1Aug2IvduGj3KgwTDoVYKUq3XYKl98mAHUiFrYC5hjKCpUqMiyQjxKZrwf1k/gPAo
         XZtQOX+RjH03CUMn01FHQ1u5wgMjt9w8KjVOIF3kkuGUXZzr5AwepGX9/oiFnt/qnXTZ
         cEqjaKqvL8ssMRcexeEbEMAnNPXEc2tdeevx3htaowc5BrQ0jZF4TT3BI/u3fVWBmJmF
         T/JZHxkPEm9J93x6C8qUWuEKNRBgrRBmAOMojaB7mhwfOJNSHSaMEKXdxXvzw45PZMlS
         /TBQ==
X-Gm-Message-State: AOAM533xVK8pwlsfc3EZEQPTA3h/6G6l+dlM4tpLAz5sAZ5pjJRn2p64
        VAhfhHIJF2gcSflSK6ZtsYmJaGF1New=
X-Google-Smtp-Source: ABdhPJwJN0gQUV/R3PU6dCAMbsJoiqSOaQxBUYTwdj8davsppykBu8wSoxfS+eCYWUHV3b5wl/9DcA==
X-Received: by 2002:a17:90b:3b87:b0:1da:4c83:8394 with SMTP id pc7-20020a17090b3b8700b001da4c838394mr5184411pjb.230.1651117660188;
        Wed, 27 Apr 2022 20:47:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.253.210])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090ac38200b001cd4989feecsm8604382pjt.56.2022.04.27.20.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 20:47:39 -0700 (PDT)
Message-ID: <626a0e5b.1c69fb81.7b667.4f88@mx.google.com>
Date:   Wed, 27 Apr 2022 20:47:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2144786426561306814=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aahringo@redhat.com
Subject: RE: net: 6lowpan: simplify lookup by nhc id
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220428030534.3220410-2-aahringo@redhat.com>
References: <20220428030534.3220410-2-aahringo@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2144786426561306814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636426

---Test result---

Test Summary:
CheckPatch                    PASS      5.77 seconds
GitLint                       PASS      1.40 seconds
SubjectPrefix                 FAIL      0.92 seconds
BuildKernel                   PASS      41.46 seconds
BuildKernel32                 PASS      37.48 seconds
Incremental Build with patchesPASS      63.86 seconds
TestRunner: Setup             PASS      646.14 seconds
TestRunner: l2cap-tester      PASS      20.96 seconds
TestRunner: bnep-tester       PASS      7.82 seconds
TestRunner: mgmt-tester       PASS      130.76 seconds
TestRunner: rfcomm-tester     PASS      12.14 seconds
TestRunner: sco-tester        PASS      11.49 seconds
TestRunner: smp-tester        PASS      11.45 seconds
TestRunner: userchan-tester   PASS      7.68 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.92 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============2144786426561306814==--
