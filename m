Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F85C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF99E64E4D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 19:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhBQTqy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhBQTqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 14:46:38 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7AC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 11:45:58 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 18so16261740oiz.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhyyvVa4DUSBsWhWdhQEcuzLqyCH04G4ccYNrAhQTIg=;
        b=cTf1M3Hzc9axT3MCy1QdgAw83eeTCemJgcpT7hH4zY2BuQQbP7w9VpespCUNDCNA+V
         LFUGRt61ceGbXsYrbS+u8brSCQ3kgn7J0TYdio0wuCCCzI2UqbnG8Zvc0uivo55Eimwn
         vHS+t3K6PICIFOChjbGXT1Iapm6TJRsj9zNsc/yaCtLyUpBybGMlbpi2SRXz0h/eS01i
         Q9AX6MWz0E58vbjWf4XPG54DCcHd8Z0idikyrQXnOtwGfUc2fzQZPBSzYjca8EmRTURw
         lyTHEo4Y7N2NGlsCDyEGJ4vWixxQIbOsRcwNJAh2VsYU6EoU3gmJxl1xms1mWXMAFYKJ
         kRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhyyvVa4DUSBsWhWdhQEcuzLqyCH04G4ccYNrAhQTIg=;
        b=c1TRNhw/Szo7nnOZCPDh2cdA8Sr+Eu/Bf3Dbh+bxJp6cOTn+KOkr46DEtcuxUK6evq
         IqvTMueRZgGl3BklpRx8JFDPJtcGnQIgWnqOLCih5kxjvwyTuK33dSbP0et8ugjbolDC
         otWNjGRSh7eXvNOoWwXFaYt8Q/jsK/cXQfXCvWndW89Zs0hIegYp3I8BXRX/gyxmRhbv
         /7NoVBAgjWY96ZI2Aos8InL8HJjtrH7dSyxh+6IB0yEPhzID6wzL4UvPZI6TogKyCk/h
         DZa/cLIpYIwModAvW5WRFin4L6WhVbyJhhvbRQ7eHNIKhqC1tmTY+ZJh8SDgpF5wwnq3
         1WvA==
X-Gm-Message-State: AOAM531RkQqXC7G6w506y3Nuzo2MYdjuouD12E9jQpw7J6zJC527mnHm
        l9j/XtjOw+nAAiOJMZ4/CD/VtNRrm7vZOl5vq3NGIOfO24g=
X-Google-Smtp-Source: ABdhPJyfhWcLJDyrhGqkEMZoyXPt7vCxjiopocxxqIvTWrk8ymXW4r+kAcc2F2mXVCihhBrkTSjGZO+UTttX3nKJxIE=
X-Received: by 2002:aca:c109:: with SMTP id r9mr321657oif.64.1613591157365;
 Wed, 17 Feb 2021 11:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20210216233337.859955-1-luiz.dentz@gmail.com> <602c5bd2.1c69fb81.cf0ee.0856@mx.google.com>
In-Reply-To: <602c5bd2.1c69fb81.cf0ee.0856@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Feb 2021 11:45:46 -0800
Message-ID: <CABBYNZKnft35iJNnKRQp1N=X319m1VY7Ne2SJ9pGKWOGbbpXvg@mail.gmail.com>
Subject: Re: [BlueZ,1/3] avdtp: Fix setting disconnect timer when there is no
 local endpoints
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Tue, Feb 16, 2021 at 3:57 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434305
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Can you give this set a try with the use case you had? I tested with
unplugged use case and it now seems to trigger session_cb immediately
so it should work for your case as well.

-- 
Luiz Augusto von Dentz
