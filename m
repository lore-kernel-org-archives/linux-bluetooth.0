Return-Path: <SRS0=bebH=AU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E39C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jul 2020 00:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA22120775
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jul 2020 00:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo0AD9F2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIAOD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGIAOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 20:14:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15BAC061A0B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2020 17:14:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l63so435361oih.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2020 17:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAy6fpR5/xZbQxxlH57PWAcHB2SkdiT0qmgOwdkwU3M=;
        b=Vo0AD9F2JCLgzg51iFjf4CjdrlnaKjCfb72swb5t8LB83DSXRI2OQfip1ztqiVOtWp
         h+pCVqeuc8ogG0Bp72fU+bZfCUhMFUAmu0mYbjKlsX03oLT/Y2xxfu2dmclgE3cqoNqd
         XCagqhQYHGo02BryRIysoVGGab2af3B/m0R+5f8VpUd1HwKL5AFUFQSYKbLsl09NbBle
         RSXBpGHpAEWu/O5e5mbet9WxRxdhFBV0S/g9fyqOPna04xAlJk3HTD7EQCrBvqTiuJff
         sUwaBWHI5PMExnWQISzgs/lyJ++3z9mhcz2j4GPNqWb3EW4ASpHy+0n6WUhtRbtu4mt7
         RlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAy6fpR5/xZbQxxlH57PWAcHB2SkdiT0qmgOwdkwU3M=;
        b=FWsz6WwVow9r8ZoTuabfen0yVsa0Y9dw0IqJPiuugjnKvDvpEkRTFrNUB99KgO18Ps
         6z4W3Yp9/PLJu1DkaXRLwrYn3b9H6nhwZ/sN5P5J49RkdwG1cX4bxbuAerCj5JRirwha
         GNeEQ5SlmultyZry9bTtC+UOdHyMFSe/bpUDvvDdfWFTwJ2WqU3jNzQip34x0fNC+tX8
         eiRMuQYqnZibQlqrcYICg9rOJHwHrWAmvgIeCLjJsEYzoXvsVXD7o6buYYIpPTs6MmaE
         rbBN4GTK18zNst0gAJmbTKCu9Elfh6Re4IIi/0lIww2vMCOogREu0UUvcdfGWoeSlsPb
         YWEQ==
X-Gm-Message-State: AOAM531wh9iqg9G2qfCsuUwOxfIYMoqnqKjLEausnMp8+AvZvsQ6A97X
        a7Y/SdsU8JGs2GH9xvmAi24LS9ryTRGXi1VcRuE=
X-Google-Smtp-Source: ABdhPJyvh1v32zht01ybkI9BpmyAXJ9zuhxhLNX79/znuJlKBahdpKkN7WLQ9SX66Us26HIqWCH7g05n5hAURXc/6mk=
X-Received: by 2002:aca:2819:: with SMTP id 25mr8632910oix.48.1594253642055;
 Wed, 08 Jul 2020 17:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
 <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
 <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
 <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com> <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
In-Reply-To: <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jul 2020 17:13:49 -0700
Message-ID: <CABBYNZK88np0OWb0F846tGj=HqqBFz7Z+cVi-MjNrkrHMv7c8w@mail.gmail.com>
Subject: Re: Temporary device removal during discovery
To:     Andrey Batyiev <batyiev@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, Jul 8, 2020 at 3:57 PM Andrey Batyiev <batyiev@gmail.com> wrote:
>
> Hi Luiz,
>
> On Thu, Jul 9, 2020 at 12:14 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > The delta logic might be a nice addition as a separate patch, it is
> > more for detecting devices disappearing then actually cleanup during
> > power off.
> No-no, it's not about adapter powering off.
>
> I meant that (external) devices never disappear from the bluez device
> list during the discovery,
> even if the (external) devices are turned off (i.e. they should be
> purged by bluez).
>
> So:
> - bluez is central
> - bluez is discovering
> - peripheral appear for a moment, than disappear (i.e. peripheral
> would be turned off)
> - bluez would not remove device from the list (at least until
> discovery is stopped)
>
> Use case:
> - bluez is monitoring environment (discovering literally forever)
> - peripherals are brought in and out of bluez visibility range
> - bluez list of visible devices grows infinitely and causes problems
> (hundreds of devices)

That is exactly what I mean with detecting devices disappearing, so
I'm fine to introduce such logic and use the temporary timeout so it
can be removed while an existing discovery is in place.

-- 
Luiz Augusto von Dentz
