Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI2TrU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiI2TrT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:47:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A01D3581
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:47:19 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id m18so1548834qvo.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=5eZsE0Td2EVJ1RQN93rw+vKBrOxs1EGieSA38aKt6xQ=;
        b=N7KGgjh5huExX0KC65xOXcgoRvoB25Me51ZcSGnpNTshRnsSz/b56+2pUWbrxfpO9+
         jffwMrxQOmmWg4WlyM1CotpKLme25RYzdQhIgl1k4VQuIK3CC9hCEDIwTNs4UESUdObk
         VRpF7TpzF0sdolUeN4JoVC7NtlRVR4WSyPb+Cv6ItwfOD53tfTBB5b5BdXRNb6Yu5HVS
         XBsnU4Ugvm+V2xx6dUEh4MdPZA3B/2UwMGxFAuJxyH5m6Gn0I7tdZBuaHDCCo4UTDLsz
         9+9vdwZ4+QjRaH+8rQqrS/ROd30K385XFtYOkTGJ1T/JYiGi+attTbSvEduIk8dyo3Mm
         Nj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5eZsE0Td2EVJ1RQN93rw+vKBrOxs1EGieSA38aKt6xQ=;
        b=2sLhoxrHM0uBGDnZ802iAK1Wzug3WTwYbdqcvO84fBJw0twfNqb3S5TkLiYAekMtZe
         2xMF5Vfx/mIxh/wyzLSqEnXLcJJwsRd2DZfBiqLJKqgM+cKNaq3Q0hxyQ6Mp17ch8N8w
         JJIi/z4bq5WFnBSzDoSmMSoor4fv8EdO5mlmXTe65PLfz51zhSDMotVfifk61fcr0ytZ
         HUAWkseGFHc2wdzVDN+QYlYQkVoznnMTA3zjSHp4EF5w5hoWCkR53S+rZiov1hN/9i1f
         Bzn0q9KRXd0j7MVVBabUjaqLVk1/1QxLz3IpXP1OnjiLxLxuiqFeq4sDgr5KdWxRtBhk
         ndPA==
X-Gm-Message-State: ACrzQf2/9Zf8LSuFc8/1vj3cBYrk2Hj/2ap/J+Ik32loMd5U0yKKy2iv
        S/yA8PnGiO6BCT+i0glyBiLJLhdwSaNsCw==
X-Google-Smtp-Source: AMsMyM6eM/+O3EdUD7+pZV8O6vL55fMD/HrJcUFJBWA8xBUBtrkX9mMneJTZNIyynfdr2u0emQ+j3Q==
X-Received: by 2002:a05:6214:1cc6:b0:4af:91b4:c62f with SMTP id g6-20020a0562141cc600b004af91b4c62fmr3921938qvd.33.1664480838104;
        Thu, 29 Sep 2022 12:47:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.9.174])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a088500b006ce2c3c48ebsm223084qka.77.2022.09.29.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:47:17 -0700 (PDT)
Message-ID: <6335f645.050a0220.88641.0ee3@mx.google.com>
Date:   Thu, 29 Sep 2022 12:47:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1672165487452120460=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1672165487452120460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1672165487452120460==--
