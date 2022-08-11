Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214FAC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 10:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiHKKKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiHKKJv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 06:09:51 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D39910B2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:09:45 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10cf9f5b500so21008286fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=4I9znO+/Dp6Wk5rvWxV0aQKQ2TGjmVbskQ/NBmAc3kU=;
        b=Q1uD3b2eQMxG45gkVsU25KJylW4S28P4y87Ju9xukjqUaIsdVEzFmxNcbLW5kHOQx5
         c+YIpiAQn0OAI5LHQXr0WDIMQu0jPfzJNDf0q5D8imiH1vrwttzRy8DBydZUaUhiL3NN
         WctjcWdU+pXp+ugC1Xxqtc3uLiVKx4eNNeUFjqeVCKDKPIyNbJFEw0olsQP7+UdU2sml
         5JY1tyMPe2AMaFNs5NJ4vG0kfg2ZacZy0pElynGPlFmxObap7VnuaJePu49mDbh2PO63
         5Aw24Gig+c+RZ0o+I+VCatIS2iY2G5dUG7XxeaV3UlUHxeCDtwvXtUL7JAakgunNykdY
         ULCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=4I9znO+/Dp6Wk5rvWxV0aQKQ2TGjmVbskQ/NBmAc3kU=;
        b=Gsxn2fm4qd2Y2WK++VPXJeaZHTu0DmhW1Yxx34Gp+GsJG1fNiaBnEyJBSRQxau9x0V
         TTeKt91DgS7XaROZVt2c/wdio/NaNlQeqKvMXEtoALao4t/wDqeHd1jv+PROd+8quWge
         rbLvWCzHaE26vlMH5jNnWW0xAk/KcdspMslXVniddQSz+nNapvJx3fV3qe30iKQhubHl
         jRkmWXRV1gKxjpevSUC7YYNDLo5c+sg6JecWnL3Qe5GlH12ULmSiH5fOCC86VQ8IRgRK
         lZ7WZqYQyESu9PGysRi5WrqTYcGo469bi7ui9g6IHOkBKDxqrjsXasVIvXfL7nrgBh3o
         VjXA==
X-Gm-Message-State: ACgBeo2N/m9Cqr+130p0DxEcGgVmIUrMw9iwA2Pr/mmN4Zz4E6ePWkRZ
        9DTg4ALhrwCD6BKNREilMwI+ytT3V1o=
X-Google-Smtp-Source: AA6agR5IiecC86kCjA/z5KicIHU4/rXo0IrXpGSBkI4zQWEt/3MUHb6GHnh2DOLkKgBO/Cdf9ByRFw==
X-Received: by 2002:a05:6870:45a6:b0:116:8aef:46b2 with SMTP id y38-20020a05687045a600b001168aef46b2mr3202609oao.285.1660212584488;
        Thu, 11 Aug 2022 03:09:44 -0700 (PDT)
Received: from [172.17.0.2] ([13.85.7.138])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6b08000000b0063709cb78cbsm1104276otp.49.2022.08.11.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:09:43 -0700 (PDT)
Message-ID: <62f4d567.9d0a0220.71d10.415e@mx.google.com>
Date:   Thu, 11 Aug 2022 03:09:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0880846169859376767=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mst@redhat.com
Subject: RE: [v3] Bluetooth: virtio_bt: fix device removal
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220811094542.268519-1-mst@redhat.com>
References: <20220811094542.268519-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0880846169859376767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666822

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       FAIL      0.72 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      38.37 seconds
BuildKernel32                 PASS      34.59 seconds
Incremental Build with patchesPASS      48.74 seconds
TestRunner: Setup             PASS      566.46 seconds
TestRunner: l2cap-tester      PASS      19.52 seconds
TestRunner: bnep-tester       PASS      7.72 seconds
TestRunner: mgmt-tester       PASS      116.56 seconds
TestRunner: rfcomm-tester     PASS      11.25 seconds
TestRunner: sco-tester        PASS      11.05 seconds
TestRunner: smp-tester        PASS      11.04 seconds
TestRunner: userchan-tester   PASS      7.86 seconds

Details
##############################
Test: GitLint - FAIL - 0.72 seconds
Run gitlint with rule in .gitlint
[v3] Bluetooth: virtio_bt: fix device removal
36: B3 Line contains hard tab characters (\t): "	tkeaked commit log to make lines shorter"
38: B3 Line contains hard tab characters (\t): "	fixed error handling"




---
Regards,
Linux Bluetooth


--===============0880846169859376767==--
