Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD15239D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAHVlX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAHVlX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 16:41:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33284C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 13:40:43 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 81so11145435ioc.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 13:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K/gxY/WgnXPNBso4atY2aZcnBRLSakwHDhmqzhzepFQ=;
        b=B3rOXejRbbM9oxso0ueG19W86yaoMn5Nrl2X7rXyijjtitixf6xqFkVSXBKkt1FENx
         z/Re7jrZIuCFL3nWIA21RkGoTp+jEWUYsAvJWY829+tEahC31MvD9DvgQ8I2tSCITUKP
         gjkYZuR4k8nF2QfieIZOckEjxJvvkjzg/QGDGs3WDLXLXL21Pl7G3nXWaFZHfWaQgUCR
         ySdqNyMgMeG3RRV0Jt5TJSxd1qIljeGUKQiWuLPRDcuvKJAGtTIfymdHoYCqPx8BXvrC
         TR2Wh0usDaMOWzGgIru+dxTAncvCglYLmMhg9dbI5CPkV1GjVLGhmgeQPKy1POvW8PLm
         N53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K/gxY/WgnXPNBso4atY2aZcnBRLSakwHDhmqzhzepFQ=;
        b=aV/qdFKOZO7Msn61ohM1dmIBzbkJYSM2NTXg/tVJjzkd52GutWPCAEJPyV1HDyZB2e
         BNaBy2YitG6reVFBEyE2W3ov9XoAioN7jT4aZPfWocTq1KqkNYMV7VYiMSy1ghDqfuHJ
         WbmH7fgSqLsscodfhtt/QCp0RHOQjLLudBgRPsdYZHJJBPpdndiK9WX4RnomgwNh6tRU
         NcpLew6A2r94x/mhhJXjgUbF0qi1xicss7Or6n7/8fJdfbIKH36nFcVewR0a+QeGBAPN
         vm7DUsyn0WAV209mFySP0rL9elNF7QSJh8ruOOxADRPOX2eXxdPkELfdWbBUVsMg427H
         hRkA==
X-Gm-Message-State: AOAM533lYzZF2Q6uM0Jjf+mNI/0ZPfRrO0G0aCklAbm/dBcgVzJD1X8u
        o1qjROUQ2+RRxkjnt8RJ0+LrWqwsYxU=
X-Google-Smtp-Source: ABdhPJzVO5sWEZw4PVIoUNGJ6ApOQ7tDus5e7ao5usJMhQG7usEeqv80dK0ZAv3AigJdold1mMrDKQ==
X-Received: by 2002:a02:b042:: with SMTP id q2mr5080516jah.29.1610142042471;
        Fri, 08 Jan 2021 13:40:42 -0800 (PST)
Received: from [172.17.0.2] ([40.70.15.6])
        by smtp.gmail.com with ESMTPSA id v3sm6033659iom.24.2021.01.08.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:40:42 -0800 (PST)
Message-ID: <5ff8d15a.1c69fb81.d489c.a708@mx.google.com>
Date:   Fri, 08 Jan 2021 13:40:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0486438480095567727=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] util: Introduce util_debug_va
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210108211513.5180-1-luiz.dentz@gmail.com>
References: <20210108211513.5180-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0486438480095567727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=411499

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0486438480095567727==--
