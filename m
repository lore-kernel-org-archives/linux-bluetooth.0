Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD971C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiI2VaP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiI2VaM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:30:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C700552464
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:30:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so7180553pjs.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Tby3Gqr/KfKhCiWoxKg+hydzC/MAf624dZj22BtPOt4=;
        b=F2Akw8cMNBmAT+fZyV+PSB8JwAibtGvPI5JUUxGKaj1SbFiA5mCg96sqRZeNHAp5q8
         /NEo76kpTzYhkHFqmZuQ6LBLjOPiM/OjOxfPRhCiTjzZ4HGR9SUBlHTueqLfcS5HPjY7
         G2JIm4DGJxzmOU6BYERVqYEs1kAdxRj8mQdELCb9ngHAmMlwg3ko+xiF5FGd2Rgp3grA
         DkJoiM8y4M/J/SVWcxSPSQSH4JPV6StvhiKmMilJKCnzB8rGS2W2djbXkgDBsUW5QrkT
         dTp/BgVzJZs8lcM/xtLy9alsfAZxhF2393xxXcJDO0y+kcz2ehJoMdjVte4uuE6tPlhR
         VdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Tby3Gqr/KfKhCiWoxKg+hydzC/MAf624dZj22BtPOt4=;
        b=4U3s7oUfsRD/gPbdg/ZEyGTmiIei1miX7XyHbRIitnaOT8djM1A9WIV0Rh+KiE+N5X
         bdKe73hjj0EY1el2FCGJcR6eJJj4kONi8FZp/t3RsTVDGsBdUvAVQgwjAOVO7O97ajDQ
         /lRDuMz+sfpAnJD5jS5/wRXndTG5P8ioYhjhZJ07NJVRBqMNjRhuwXvX5Du+w4860vtl
         0sybs21rKwPR663jbnPBbyPfasZeDEo/bumx8mISQ/hzDyst8s2FoQlNWzyDW56cvmJK
         LBVzZAVw7oZ4/n3/Uhng8XElKrdY3ytL2iithfc+rhdy414S1qWSPXEd3sva+2OcRnZ0
         M9OA==
X-Gm-Message-State: ACrzQf16143dVRH8XI/Y31MknFznO+JEPJ8XUVnPcrDyR+F8BNeIqnxi
        82bJpXg31cTgbg7qsBFuLmvIbjQmit0TsA==
X-Google-Smtp-Source: AMsMyM5v6m9y0c5rL3isPi00mDnnC4Dp+/U1tFjESnZIM++1ROQDvC2o2hQLHTKjyeNFaSoC+Qx05Q==
X-Received: by 2002:a17:902:ec90:b0:178:a0eb:bc7c with SMTP id x16-20020a170902ec9000b00178a0ebbc7cmr5428988plg.78.1664487009890;
        Thu, 29 Sep 2022 14:30:09 -0700 (PDT)
Received: from [172.17.0.2] ([168.61.6.117])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902690300b00172b87d9770sm362532plk.81.2022.09.29.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:30:09 -0700 (PDT)
Message-ID: <63360e61.170a0220.358cc.0da4@mx.google.com>
Date:   Thu, 29 Sep 2022 14:30:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4872227406711032958=="
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

--===============4872227406711032958==
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


--===============4872227406711032958==--
