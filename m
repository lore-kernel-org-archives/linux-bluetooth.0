Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1DC43462
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4987B613C4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhELUNb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352380AbhELSDJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 14:03:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C31C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:01:59 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s37so7298100ybi.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMC4bFTIS2/8BiZiMIFg+tjFQGbs6geXPJ5Tx3KwZ2w=;
        b=FMzGEnYDvexK0p52O7rjaKHhIWJiWw7aUYDAbvVJXSLoJ7pIQwIBddCb2G2ENgzEEK
         TOYspFslk85mA/Ah4BejGI0Ne6uBHonJYKqe81/wH8NxvT4LJOUissG1RUJLaKuwQhGf
         iBNhSv7ZC+9y4wqyYcddfL7MU5xGL9S6keqXFm9PHAVOZNRpo2Z4WiIZUvTyLcTYc/0h
         hJkh7j5XPXBw4r6NL/UvAy2XVJ1WVc3e3lbino++iMvKHp3qPhOpgJpLg5iaP7e46XAg
         3tx+DoOEWi3z3QDmK4ArLBv0VmTTiSxPnfpD7odwk2tuiP6jcowO5Rfx+69NCQGCnmcx
         Y7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMC4bFTIS2/8BiZiMIFg+tjFQGbs6geXPJ5Tx3KwZ2w=;
        b=C22v92ghpW2N8VB/Slm9SBi1wk7/OOhVy7zo+3TYZd0Fk7rd2BrQ35fZ1oL5Hou0NC
         7Yl5nVMo7RxCDinW6NRsTWM4QG3nbyrbDVEeiBznn68g8d0zqtCk3Ax3iRsQAwBxGG+o
         +BGV4qnFG/x1bBKkdKX0xWJxF5Ju3NP4hVfh4wP+YdIr7IDCNSdXB7O0VK7miWTwPw1c
         a8rzQJ+D/YThN074mg2xpwuZL9z+Uj8I6gX+OpNymt9uUDhhNuyMYjiZEp7JJHEoFgZT
         1evcdFhkhMcbwDHkAT6lQVWzKm2ekVxozxTJJZfFdzWJHdLCpDyXzSv/jFviM8fldcwM
         pgBw==
X-Gm-Message-State: AOAM531fWrTb9h01sa9L9oKsvdshbL3Z/vLDBPpHGEWE2tqMOHqYBuqh
        Qyr+i5lgeelyCxowf0R/YcBwp2TxOQEw+jrcrYM=
X-Google-Smtp-Source: ABdhPJwXBhyCRKBC3FtRTiUotEN5XdhQAXqMuDRdI/cDGfVZKTKx0y5tjx/MsgvOi7/zd5RIiXsdVD/ns8Q1Ma5AFwg=
X-Received: by 2002:a25:ad8b:: with SMTP id z11mr22317148ybi.91.1620842518891;
 Wed, 12 May 2021 11:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_JV5OCS78ZoG6MtAdQCp39oQemzUvQk1DwduGy_LhDuNv9DA@mail.gmail.com>
In-Reply-To: <CAA_JV5OCS78ZoG6MtAdQCp39oQemzUvQk1DwduGy_LhDuNv9DA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 May 2021 11:01:48 -0700
Message-ID: <CABBYNZKtAf=i=au+pF4Kkf_X3oAm_WZBXCwQWchUVSoTdUCU=g@mail.gmail.com>
Subject: Re: Unable to establish ble connection between Raspberrypi4B and Laptop
To:     nagesh shamnur <nagesh.shamnur@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nagesh,

On Wed, May 12, 2021 at 6:46 AM nagesh shamnur <nagesh.shamnur@gmail.com> wrote:
>
> Hi All,
>  I am unable to establish a ble connection between my Raspberrypi4B
> and Laptop. Configuration is as below:
>
> Laptop: Ubuntu-20.04.2 LTS, bluez version: 5.53 Raspberrypi4B:
> Ubuntu-21.04 bluez version: 5.56
>
> Bluetoothctl logs @Raspberrypi4B: as attached
>
> btmon logs @Raspberrypi4B: as attached
>
> I see in the btmon output, always connection is terminated but no
> reason is present which specifies the cause for it.
>
> Initially I was using Ubuntu 20.04.2 LTS on my Raspberrypi4b which I
> later upgraded to 21.04 but still no luck. Couple of posts pointed to
> bug in bluez which was pretty old and i am assuming would have already
> fixed in the bluez 5.56 version.
>
> Can someone help me in resolving this issue?

There doesn't seem to be any L2CAP channels left which means no
profile was able to connect which causes the ACL Link to drop since
there is no use for it.


-- 
Luiz Augusto von Dentz
