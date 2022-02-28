Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 18:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiB1Spr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbiB1SpS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 13:45:18 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F75473A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:44:22 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p19so22418009ybc.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMDxHOhE1DGtLVy6lIjIv+fobHY3F15WDVFcK9E2w30=;
        b=UUcm6fQYf/FdycHdWXLnZPaEjoxZ2sN7sS64ILv4+bqiQ6cwFEpi5LuOiKiVN15EFI
         DtwjBlbuVVr60Huvm5QRwJPOOjXqH0eZNZnzSYsZ4+gFW66vjz/mGbTVG/S/EIajfm3m
         /froyLBfPyxXLYHW02gxTd0//aJNAASUCFVwU1RYqkXGxptd5ddyRGnVPQj7HxxnSsZg
         M8I03atU8ZXM+MdCxN3W2CxQ8Sho1woTHHtqrFXBm/2CUpLSEoVnQPeD6tYmFzRy4QvR
         1ngw7Tu/v1lSw69nuSlaYwNjCOA9cj1WSTlJ5Yfqy8pMVe+rVs6IMDm/acYtaDLH6QhT
         gMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMDxHOhE1DGtLVy6lIjIv+fobHY3F15WDVFcK9E2w30=;
        b=gTrzfBgobPtN7kz9bw3f4QVqg88sVAo6tHBQKgj9Y4lhJHKZ57HtGBkNkpbzMswLDV
         45RiK4GCniBmu0WUwzVmJ+VcZAOnWvEFeqTqh2jX4NuW3WIYtyhlPaclwAG/X634Ola1
         8nbed+Xxb1O6p/y89cCcVlkvuMTbS7DfhhS/4fiR147HREUTWhA27CikRdrQ8H8Q2L+E
         NDbXpy89y8B69R63QgPxcQA4pS7asVvrcUj2O6YtqpPUE0OwVnNqyV6JS0pm+wRSaV/b
         wOZOx+tISArUNz8OfL+nOLkh4pbWwyFAqKWsF+OUlMMXGg2op0AcGCai1OFh3y2UOXzP
         hiyw==
X-Gm-Message-State: AOAM5321yoKri7wuiiUfTK3h4nubTeaieZsCIt0krHyY/iT5tMwo5e7j
        3NsI46FXNVQuboo65JJfjXk8YesZAtVInd5DcEDOatqej4w=
X-Google-Smtp-Source: ABdhPJwYkTUFAWuNfxG2eeYzC1bmqtaLuLPi9zbLWruAaoHho/C6gDaIRWqvnxSFaqodI6g+Jpp58OFp4kfhilzDxLI=
X-Received: by 2002:a25:d803:0:b0:614:b201:a798 with SMTP id
 p3-20020a25d803000000b00614b201a798mr20242523ybg.612.1646073861308; Mon, 28
 Feb 2022 10:44:21 -0800 (PST)
MIME-Version: 1.0
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
In-Reply-To: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Feb 2022 10:44:10 -0800
Message-ID: <CABBYNZLthsOUzh0ce9co1r9x02FRFPoBkTrpehUtUtMiwiyzGw@mail.gmail.com>
Subject: Re: Battery1 vs. GATT reporting
To:     Ed Beroset <beroset@mindspring.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ed,

On Mon, Feb 28, 2022 at 9:45 AM Ed Beroset <beroset@mindspring.com> wrote:
>
> In
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=713f6f09 a
> flag named "external" was added which, if I'm understanding correctly,
> is supposed to mark the Battery1 profile as safe to also share via GATT.
>   However, I was recently working on an application that relies on the
> GATT API for battery power and found that it only seemed to work as
> expected (reporting via both) if I set the flag to false rather than
> true as in the commit.  I looked through the code and it all looks
> correct, but my observation indicates that perhaps the sense of the flag
> is somehow inverted.
>
> Here's the project I was working on, with the relevant bug report.
> https://github.com/AsteroidOS/libasteroid/issues/13
>
> So can someone verify that:
> 1. the interface is intended to be shared via GATT and Battery1
> 2. that it does not work that way today

Did you check if that was not fixed already? It seems to work alright
with git latest using bluetoothctl:

[NEW] Primary Service (Handle 0x0000)
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0020
0000180f-0000-1000-8000-00805f9b34fb
Battery Service


-- 
Luiz Augusto von Dentz
