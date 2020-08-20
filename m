Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5190C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 16:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A282072D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 16:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E0rxJ6YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgHTQ5Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgHTQ5T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 12:57:19 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F55C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 09:57:19 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id s29so780630uae.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QYuR2e8AkRz6vIxG3CqwQqEQ7G/qCpkD6SKe9AUP/Rg=;
        b=E0rxJ6YBO2Ep5q2WB3Hki5mUK6bXNhjLmh23hVYGsYhh2eh8h0SeCbLhpeSf5x0RHY
         wIuMss2ECTZkkbiNAz0YjV+gjbISwMjfFGqj2EHARF0FfujtYjWBmE/0QkNzEPRHzQdx
         poND40MbXd8K2NAHuAG2L6zhdOlsg5EHSXots=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QYuR2e8AkRz6vIxG3CqwQqEQ7G/qCpkD6SKe9AUP/Rg=;
        b=Zu2EsEvU3rMGHhxzJuCK1EfmYZn+srcZb5T/RLgwuOOeFeTrReCcjVFSuLE15okLWy
         dpLE6I+3VEZB1BM1dH7rxVvxUWMpPjpVWL+SMX8Cipu6ZPuHrYmMJgH+slRmOGEhWKN3
         8ymi5ffH8B6S1YK1MY3x5iRxh9uOC70Uip0uprkG4uHIRJlVpskVrUvM//42zshy6hDZ
         G1JBNS0Rt3fqf56XifK08tipfZrEsMlSDQGWSJbIv1XUrsTNEP5PJ2m1EhCTOwtwbq+S
         r7otytG7RULKQuFDpjP/tjNHunjMYdvyxangq57arOGKO+Fh6c1TK50i5ePPfLViYjPA
         6Xqg==
X-Gm-Message-State: AOAM533gaeCJbiJYkoUzAvVeqj/2PYDzAWM56FyrVsgPo1Y//CDGUYGR
        cSdAuky0HUFZJrIOYro0HUZ4YwbIKg4Vr5UrpwdmZw==
X-Google-Smtp-Source: ABdhPJxuiPNsNRab4REiueDhEETHzegNMG3ZBMS8VZdE2G7/syTOMsdkXHxsD8c9BBsm0AK9nSGmqyLkyVnC3fw0VU8=
X-Received: by 2002:ab0:624d:: with SMTP id p13mr2316482uao.136.1597942636770;
 Thu, 20 Aug 2020 09:57:16 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 20 Aug 2020 09:57:06 -0700
Message-ID: <CANFp7mV=Uf37Hk0RgNY3dUpr46DZOSTtKzcp7ptWF8YCKEzuCQ@mail.gmail.com>
Subject: Request to queue patch for 5.7 and 5.8 stable
To:     netdev <netdev@vger.kernel.org>
Cc:     aros@gmx.com, Manish Mandlik <mmandlik@google.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi netdev@,

Please include upstream commit
6fb00d4e94bc28c39fa077b03e6531956de87802 for release to stable
branches 5.7 and 5.8.

This fixes a suspend/resume issue on Bluetooth controllers and has
been extensively tested on Chromebooks. It's also needed to fix the
bug reported at https://bugzilla.kernel.org/show_bug.cgi?id=207629

I assume this is the right way to request a stable patch following the
faq at https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt.
If this is incorrect, please let me know the correct procedure. I
think this patch was missed in normal stable backporting because it is
missing a Fixes: tag. We will be more vigilant about the inclusion of
this tag during code review going forward.

Thanks
Abhishek
