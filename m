Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072BCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiI2Uem (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2Uel (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:34:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134925A
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:34:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id ay9so1545157qtb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=qXtAmaxu2QJncDKc5lV+W6cnfRzbyS0mbH0MhKQtEVE=;
        b=S7Pg1PrydUlGu/Ibud/W6Pb5XE5NslJlF0BVoPxvpwLiyjVLPKIk5ghqiwxpQ9T725
         d7qey9QiZErzrsOF/+JzqiGmB/zu1XIIB0/lQ7SZlD09OdYBt7eZOr5Ga5zDsilM/cRp
         GGRilI6ioZEr8D9u6Sf23I1EqtYbV++RbjvQV9Nezk+RZCLpUeAJbwX/2q5Az5YlCFXL
         UBc2oF96EYydIGR751UQaYBKNxf0lBIpfu6N4AECSdHRt0EPwW7kvWRiJf5fTnulBhmK
         qzXT1HJuURTMmzbSR/SAarWIrdNUR+PXRw0FpNLwiEURYXUZcKtpLvEnYpanBN+jcHqP
         4B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=qXtAmaxu2QJncDKc5lV+W6cnfRzbyS0mbH0MhKQtEVE=;
        b=MhkzWpJZNiL2RAmwaHAorbgmW9prFGfL7MPU6tgpj2bV+mSvg4TfgNKNnJ6Wvqe3a1
         jUJn+0gw4Y9MreP2q8rCfbWdjmZ8o/nzMTKrOFhepyM3hz1JFjlqXKe/p+56bc8xVKnL
         k+tX7+WJE7nRaDawVJxo4SIo8zqFHRPLgReO28lKjOa/gJW8ZV8hZDooGt5+HryjqXQe
         Xyq0LFici4SsQxmdWgIjyP4E2TKK1qWmJyo+jVBFpR4I0J74sB+ngdQdUhi2BRVMqC1Y
         5rHMMTuI7iBFhqofROl2MxIVtNGURcbj9i50U7cDLcUB0osJEPodl71zxTbQtplpYmhC
         Z7Tg==
X-Gm-Message-State: ACrzQf36ZbKo907C3Rz6Nt/mpN6U2VDx45Frs9MZDaX7Sf1wCvbgxsZX
        1HKh9lwq6RS00H9ljLEfxcVTPgGzVoA=
X-Google-Smtp-Source: AMsMyM4pSIGhkGMFo9/MLW+o+gJYtCYkiMcf12MU/I2Xjynh37scA+P5LT9gpYfMrhHH622jj6VTzQ==
X-Received: by 2002:a05:622a:111:b0:35d:51e8:9620 with SMTP id u17-20020a05622a011100b0035d51e89620mr4145057qtw.172.1664483671062;
        Thu, 29 Sep 2022 13:34:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.99.219])
        by smtp.gmail.com with ESMTPSA id ay9-20020a05620a178900b006aedb35d8a1sm433428qkb.74.2022.09.29.13.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:34:30 -0700 (PDT)
Message-ID: <63360156.050a0220.1ad18.1d23@mx.google.com>
Date:   Thu, 29 Sep 2022 13:34:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1213656096540161390=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1213656096540161390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1213656096540161390==--
