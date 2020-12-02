Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF71C64E7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C7C20663
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 15:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgLBPHq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLBPHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 10:07:46 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C2DC0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 07:07:00 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 62so804491qva.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ttsiJfWz27zjDFreVWhFnbNZEZnBAz3Z4Qef6F30VbE=;
        b=vRT8rErbXEXzdSIoaj/yHE40G19LxXqlJ3DKedt08uBwIsTPcN0wF3Z3G0uK4NxPvf
         WCLTTs2j7KEVCJw08PRmvY5hQdEz4y+3o7oCmGGGSwYaavdt4Qrz+lotAl8LK3Lq0bUZ
         /tvTJz8UFOxNqPbnOrBMGn3xNmH2ZkAJiL7i+t6aNfnGAaGH45s5rybZ4Mjyb7Kypjrr
         qI6Uv20wht6g5VU1kOV0VTt5C4z2dF3kXVxxbrCq4jMsD9jIJeV0OJr335bh15TMhoG+
         j3MRP1elweKNX1noYB3t4TsCtn9sYthoqoG46YOzgPDvgHMGscJ3HbVXd6D6PG6WOiM3
         vSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ttsiJfWz27zjDFreVWhFnbNZEZnBAz3Z4Qef6F30VbE=;
        b=QUbo/IKWdZrzoGZKWlSTS6Mchml4+5FgREz9125EXLHjOw9sd4p+q8tYwzozLk9rnR
         WO4NwCx6pUa2pKraVXwOuu9AsXzC0Ta9oCulttyb3T6ZX2Q2/T0FqSKYpH8C2WAX3P0C
         RimeN8+WySYZ2pR9VwXCD1rkxotov4Ha3kOjjkchMz+G/z9WYD7UUzbxfVoYjpOF2afR
         w7sohnCS9ZwMo3p2Nixcd6wuUNjhSc0uw7kcNucNPUqS5AA5Du1K2NYhWdmP4dwKb/qU
         NZNvSnynMDZ6E0igo8glJLtcUe8E4l6+/8zHl2DMLRS3dbqUUSlztItTuljh4obtRLg2
         SLFQ==
X-Gm-Message-State: AOAM532rgVWRgHyNdCXYGYKmx5BuiTe+U4K1Pgw+tKXmHzBI6CpE/Yil
        UQr5lcyqA7WNKPHY3jbdsFa0F4qFzMM=
X-Google-Smtp-Source: ABdhPJzCSNFCuIbjlsmyCTCC/NPDeWrAhebfQnlZtbYEF8VJH2FI+ttncaPkzFYenWShAitBhGKIIA==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr2831410qvx.31.1606921619231;
        Wed, 02 Dec 2020 07:06:59 -0800 (PST)
Received: from [172.17.0.2] ([52.149.180.28])
        by smtp.gmail.com with ESMTPSA id e10sm1812024qte.48.2020.12.02.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:06:58 -0800 (PST)
Message-ID: <5fc7ad92.1c69fb81.8a5f7.5b7b@mx.google.com>
Date:   Wed, 02 Dec 2020 07:06:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7115018605227032488=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, info@metux.net
Subject: RE: [1/7] net: 8021q: remove unneeded MODULE_VERSION() usage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201202124959.29209-1-info@metux.net>
References: <20201202124959.29209-1-info@metux.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7115018605227032488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=394659

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
net: ipv4: remove unneeded MODULE_VERSION() usage
WARNING: From:/Signed-off-by: email name mismatch: 'From: "Enrico Weigelt, metux IT consult" <info@metux.net>' != 'Signed-off-by: Enrico Weigelt <info@metux.net>'

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] net: ipv4: remove unneeded MODULE_VERSION() usage" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============7115018605227032488==--
