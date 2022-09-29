Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 00:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiI3AAD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 20:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiI3AAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 20:00:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE6E9A
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:59:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id ay9so1804525qtb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=bKHj45SEybWcb/0bz83Qdgbgo+HcJD/ZCZa6UZ4rYZA=;
        b=VNe17onQjowt+WGtX8hiCxI0T5I0AVV3fc4S2skgiHEUvnb6qHJ6sY3876LvBW9wXT
         v5jJVkq3SjwF05exM3ImlrcvJI7ILtcRrfR85uc03Z7bAjdF0nsAOrgWqGvSqXAjK0kL
         BT4ou3Boesgi6s6gzgbhtfg4BwmwDIaTtQq5a0mPznepI6+8IPZC28IIwge4XMrpjNkX
         OxyMaf2CXF7urOoFOgr0+IqRbk9r7Kmkvzx2brKcsQJJO8Dz3WavrPq6gENZamWGwvQN
         ErNWecJ4k+JO2uJhLs4K1Y8/BJ2X4tlD7hhticYsmXuS+m/czKw+hQAOEaWm6OE4wDPs
         +oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bKHj45SEybWcb/0bz83Qdgbgo+HcJD/ZCZa6UZ4rYZA=;
        b=DmvosyF5dZy/b+Gb5rddWSJEUqGywClc5oF5SIK8dEOovG4X2rWfpp2t2kki9ZUmxT
         w0BIqi/OtIC4wa+PJs2RABE5skt5zW0lyc9HE22m8MvieiBR4+Ab9cFliVvkQipNcSQL
         8d/fNwIiPNKSk815KOD+YRGNW/QYZqfrHoH8BMxOJCjUyKA2MWfxsl0jLuiCqBs3pvgQ
         4hxgLLxjQVEFvdTuukjuMTvNXYpEF9otbSafyI/XtHnTcmmyMsX2ixoXIi8Q+ug39tfT
         G6EzowFduRbVCZQ0MUPwHiGG52jIrYzSCPXRgviK6p8p9vYvlJQxI3rJlG1AW1L5nPog
         phjg==
X-Gm-Message-State: ACrzQf0Rkuy+dlK1M8+wJ0KNIamyT8Bb8032Sc2bp6YNcXYCkBuewYFk
        LMBjnVnmKieTD3gm9jBu6V0zsAtG78iKPA==
X-Google-Smtp-Source: AMsMyM7wHm0m/9A6exZIbHerrlPud9PX4vnES5G1cwYaGoutQSFHPcqqbhIH/Z89ky/LN67qkPuzQg==
X-Received: by 2002:a05:622a:13c7:b0:35b:ba86:17b1 with SMTP id p7-20020a05622a13c700b0035bba8617b1mr4680723qtk.33.1664495997994;
        Thu, 29 Sep 2022 16:59:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.206.241])
        by smtp.gmail.com with ESMTPSA id ez8-20020a05622a4c8800b00341a807ed21sm465925qtb.72.2022.09.29.16.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:59:57 -0700 (PDT)
Message-ID: <6336317d.050a0220.41cdb.1409@mx.google.com>
Date:   Thu, 29 Sep 2022 16:59:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1628801924227128385=="
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

--===============1628801924227128385==
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


--===============1628801924227128385==--
