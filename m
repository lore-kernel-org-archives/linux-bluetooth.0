Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF65C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 15:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiBCP20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 10:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiBCP2Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 10:28:25 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BBC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 07:28:25 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id i19so2798643qvx.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=ZCuq67QqYZk8nHqiIOZOSBHB1vXHm77cc4IZKsokV3s=;
        b=eNKSIIAS6DGJJ5MF3s6T7SCepAC9aw856K9agDBbBc3POBvSUPObg/Xi41/I4TT+vo
         KFMpF3lYVVdNwatnB4b4R1xxDLhv/N6khTL41wcQUGGBbnuKu2THWHyYtwCxDJXJs7Ez
         rEFvVNr69WhLBLVb6nAUy5/DWoVvMOhwjGzAL7DrOf4cr02eOU6/W7AiLC86IeoUm9pW
         Fp0tBRVZ0vF3Mzb0b3b0cZ5bbqfhMU4y4k+qhS1VHMFziXf4A4jZtGThBEQHVbJRPAjC
         QXC6qcCXLg1CSATIsQd6Yb8mqgiE8wrTpVALUHavWiOckkyqQCNRRWvlqxy65/7iHXtl
         1acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=ZCuq67QqYZk8nHqiIOZOSBHB1vXHm77cc4IZKsokV3s=;
        b=kBBKdTq7qqWG0kofXkQpbY/TFHh0UI8gPZ2DXA57yQ7G3sZe/EPxzdlHxykBiXLDcC
         pM9pDczW/FYbQ+S7ePqaRiGSiaMgzTWulckdgTyvtO1OeI5yWgYgNmXAMzLL0s6rvfkR
         hC0UOcwBH8CSelpC1JxlLRW70EbHzUrVTfDAhjWOmZCoQyBf27oJPkhR0ULYa+aESVi6
         1pXZgW8g4Pi11nA4N2R9tKU1YHDaVM2WnQt66EKft8d198MKHLzlfkz1CWute19cqV6G
         rUxY5moHhNCqOtKL/S8IgcKiCXXUkKSYwrk1PLg79LjNhlCpBGFikkSFgO6Z9+3sIxBH
         0lWA==
X-Gm-Message-State: AOAM530rw8YjFYwNkWleq4bz4F/sEaayjqv69R2oUaN+OfNTD7fjXG6q
        OMSQuS9BHXRjIBdsotO8Y2wGWP1ywLc=
X-Google-Smtp-Source: ABdhPJyWJ2T6AkAQtwgsKZ9bdBD8P5hDMeyJd4BLD8LL6rLDAfCXenuA52yFQX8uFGrLyOIh/KDrxg==
X-Received: by 2002:a05:6214:252c:: with SMTP id gg12mr31506582qvb.3.1643902104836;
        Thu, 03 Feb 2022 07:28:24 -0800 (PST)
Received: from [172.17.0.2] ([40.70.188.154])
        by smtp.gmail.com with ESMTPSA id f16sm5665297qtk.8.2022.02.03.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:28:24 -0800 (PST)
Message-ID: <61fbf498.1c69fb81.8cfb.b445@mx.google.com>
Date:   Thu, 03 Feb 2022 07:28:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0245609298991626317=="
MIME-Version: 1.0
Subject: RE: [BlueZ] mesh: Remove unused io caps
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
In-Reply-To: <20220203143914.746965-1-michal.lowas-rzechonek@silvair.com>
References: <20220203143914.746965-1-michal.lowas-rzechonek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0245609298991626317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: mesh/mesh-io-api.h:14
error: mesh/mesh-io-api.h: patch does not apply
error: patch failed: mesh/mesh-io.h:78
error: mesh/mesh-io.h: patch does not apply
error: patch failed: mesh/mesh.c:254
error: mesh/mesh.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0245609298991626317==--
