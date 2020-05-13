Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411FFC2D0F8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 07:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1633A20769
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 07:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYVb5UMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgEMHJQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMHJQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 03:09:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDFC061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 00:09:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s10so16913049iog.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pZ0khIBt5fB/CdtSxjuGI1bNZXWH+u3Yb0DVZK1Hhsc=;
        b=MYVb5UMYR/ppBdGissyse1ziOAs60giWeGKsbyka0SginBBjIbtDuib9411xHzh9F3
         vydrc75qzCqu96La9qISjF6aVKhXOQq3mFK5N+XJbobYG5iZgyU6eKoAyZIb8YhWyzeL
         Uv1sBBec3CsOVxzZCQoKrZJV0ni+kGr7CIdqjiYQ7zPuAym0BuPASwKayGUQ8/r3WIx1
         +0yWm1AACwFsCoDfeAjqC4sjskMngWgPY363u/suG8DNk6EDJ2mpuSDlznlfCt161rJR
         7WNrYD66sQaiBJH+uCG0vMF8BFS6+yb+nQe8iDw0ehtM0XKpdeA436tQfUlZGF3vQa6u
         wfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pZ0khIBt5fB/CdtSxjuGI1bNZXWH+u3Yb0DVZK1Hhsc=;
        b=INp14hyw5qQG8sO84JAmb6hXNfcbB10pUyPeuI59rpiNm0FDuE8T4pwqUAh3GOLllI
         S2/6RweNezNvAquwJSJI/tBbRA8Te5hVd6rXQRtp+2Wh6JNGwYuI/ujl5r0tf0yw3VMT
         O5if46mvf4ac+9C2yxKG8S4F8Mh/mXKkhlRhCwRe3VksBJdvn8cYLbEB3G1KHJO/b++m
         OAvN4OtjPslhddlrAvIRzLvNkmXJLDJbW+uWMhTWRhKArYLZhScMqgY7vjBpXyGwRFxa
         24mQuO624st8G1p7+13FAv9cvOu3AaqnokG+hQXX7viov49tpqej5yXcZ0ZuYwMBmjEC
         os2A==
X-Gm-Message-State: AGi0PuaZU6SyHsjzdcY4fqww1Xv7/RbnOFd31453tAWO8QZ+WPL+EENY
        xrqvTaDNLOQNdrzR0iOD/Bx3PZTwCDqEqOTCcR9rVA==
X-Google-Smtp-Source: APiQypKNkawFxe9k1U4/JuDIV+OLWINcNo1btsqmmmo+9gLP58NUoSeYr/RRAeTyog1Ni6kZttav6R5YUOWnEZttjVc=
X-Received: by 2002:a02:a681:: with SMTP id j1mr7396318jam.13.1589353753962;
 Wed, 13 May 2020 00:09:13 -0700 (PDT)
MIME-Version: 1.0
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 13 May 2020 12:39:02 +0530
Message-ID: <CAOVXEJL_zq0_-KTh2HEBT1VvSCCkuwdecXLaEGFquMi30oH6Eg@mail.gmail.com>
Subject: OPP File Transfer From Settings always uses L2cap Conf as BASIC_MODE-
 OS: Ubuntu 18.04
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

In Ubuntu when trying to do OPP File transfer using Bluetooth settings
the L2cap Configuration  uses BASIC_MODE

whereas obexctl it is using ERTM_MODE mode.

Once the initial connection made from obexctl.later any transfer of
files from setting UI also used ERTM mode.

How to change the MODE to ERTM for the transfer of file using settings?

Regards
Sathish N
