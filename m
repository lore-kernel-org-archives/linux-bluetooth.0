Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47DBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55FD610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhKIWwV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhKIWvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 17:51:52 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F5C06120C
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 14:22:23 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id i6so754986uae.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUa7dcTqTW3SaKZOfGJJl5nk6mW25BOg7+5tVDMRQXw=;
        b=mwUdvl9+0mjgeRcN2qrWy58K+5JYXUcVm6LkTIA8cXRS9FVp1+lxKJimDleyv76se9
         w9f8HF6HUwnDgmrAf6adwM0L0j5a31B6ZnWUKIQdW9sUgX2xgMeQXLde0o9RFyyeAdDw
         L/BoGE7/Bv4AgthV3UW7W0stGj73TpPJ73G0PZ79fvPZxdgrR9C9eCXX671MCuBna1bb
         DE+E9RRwLQS6kMg1wTkB2mzkRJGKtCheyY7ptCjWZQTR0i1sblo93B5lCYL0R/K1Jxx7
         eENlAFiR8ZV76DwFJShGVuzVSiguLvtDsTCLxc4aH/TSr3JZehMowOm6K2ffXV9CBp9d
         +reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUa7dcTqTW3SaKZOfGJJl5nk6mW25BOg7+5tVDMRQXw=;
        b=czMAvw+CFisHtbjy4wh6RKEgqo3f831SqtsswrN2TtFhxW8EuJT9VXXDR9AFvvfalP
         jpnkYgleI17zq9GOOo2uxS9VEeRMrbA+BOC9V1iYCJffrRkbk0yTD8OnxPwiyOZMXF1p
         h8qwf5moMlJ49ifIxj4JwUgB2/PHNFXih7dXWOilGVn46n/u7uVk4XdrhdaDx6TEbk/b
         MnH36TbSFxrw2owYUBwxjVcNR1ReKgZnHVwq+A88ka/qJgXyw9HDImD57mRx8We9x/Ty
         NhSLUPKnVipJad8kDo6fncke7O8BUngfHIPrjLigmiBvghI+2jZgC+tINXEDLYM15qqV
         +L8w==
X-Gm-Message-State: AOAM533EnlHWxhOTsKajnSXCGsqJ2jTrc4BU3A4xbuXe2ti+QTs89Ehs
        sWiiA5/OYnavZPL3/p959ClA+JaE1uQ7i1v9gbZYb6iz
X-Google-Smtp-Source: ABdhPJyQdosZBqkM8AQqMW8M6+n2cpmXzEF+6TmUvuje+8qyeVinKGOaiKN08sBZjKqIrwU4K2X+SdMhNLcbtIMa/wY=
X-Received: by 2002:ab0:5a23:: with SMTP id l32mr15049261uad.129.1636496542029;
 Tue, 09 Nov 2021 14:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20211105211245.424024-1-luiz.dentz@gmail.com> <20211105211245.424024-2-luiz.dentz@gmail.com>
In-Reply-To: <20211105211245.424024-2-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 14:22:11 -0800
Message-ID: <CABBYNZLLpQK8v9zALGD1Br3C5wKH2QjSMtRxdSqZLaKArB6CmQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/6] mgmt-api: Add new Device Flag to use Device
 Privacy Mode
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Nov 5, 2021 at 2:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a new flag to Get/Set Device Flag commands so it is possible
> to set the Device Privacy Mode which allows to connect when the
> remote device uses either identity or random address.
> ---
>  doc/mgmt-api.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 97d33e30a..b7a152c14 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3421,6 +3421,7 @@ Get Device Flags Command
>         available bits:
>
>                 0       Remote Wakeup enabled
> +               1       Device Privacy Mode enabled
>
>         This command generates a Command Complete event on success
>         or a Command Status event on failure.
> --
> 2.31.1

Any comments on this? I'd like to apply it if that's ok with you.

-- 
Luiz Augusto von Dentz
