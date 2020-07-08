Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6C2206DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 22:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRziQvtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGHW5U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHW5U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 18:57:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FBFC061A0B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2020 15:57:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u185so139342pfu.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2020 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7QG6h/xauqnUlFYdVCs+cNioLLC9h6T11l5pPM7bJE=;
        b=qRziQvtmDkqWDt3vxVoG4szjKQ+s5SKmA4/R9nywha/B836KkdMPHi345QOkIHh8rC
         Pd7qnFiIF3UOV3QiB0ES7Gl89QDjC2rbcSZ6A0PWXsiX25sVicLyxvJd8/TwHl2M1SdW
         9CI3XxeEHD+3fFDb/i7ctOSN6z/sGr2QJ1G7kgRqsWb8Ze2AIAlNwpEPeLo92Yv6Rxj1
         LRLUu7frCf4xtrpr9U0dQP973Y/1D5asY5PEC3dlX0pKhcznHEv2ZJbuwEM6qU5i5ebq
         Jj+S7pGybVyb1oOtcsOsl0rdh7QoW4W1xG2w/YrSJsOejD1HMtsCFvkOYDjmCFkD7+1t
         soFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7QG6h/xauqnUlFYdVCs+cNioLLC9h6T11l5pPM7bJE=;
        b=e5WyGNC3o1Grtcc8TEoPW8WYz9eJGMOB3J4dIFtocGL/n+lhxHtk6QXughmak3VJMh
         Az3Z6lii/EBctAL5K8bC0puxIHQPK4/zKCxd6zI79RBux0OEZRseYRjoqXHeDFJSl353
         czVALy06Vb90kz2gQKhzIOAKODk7P2cj3JqrnsA863AMCRnQxm3mTjskEnzkGu2KPPcF
         Dp2H+WXRo71K1CQJqcuI45wVSfyTAn6jvwXiFOF4jUg3FTzYJI1ztyr8Ou4k1HA4G90S
         98A1jtl+qcL0Ot8EjkRjhPYG4VhbGax9LyLYLKjiEwoIPMm6oVFKNVjOUzybnSy/Lmxv
         AMTw==
X-Gm-Message-State: AOAM5318G21TgjSw/TiKYNokwknwUUN/0Vbofho90QBVbfOUUNzoRu9r
        0y2tv0hNhZrNQOWBAv0UWyWseGgyUu5IsOcjVnA=
X-Google-Smtp-Source: ABdhPJy9f74uSOnL6svH7hpkPKQBliOvujsZbmJVbsU4mXfkJFK5Yd1ulCLfkaG6eGfJmHYnTUThthsMleZRfRjpD48=
X-Received: by 2002:a62:4ec8:: with SMTP id c191mr20506953pfb.15.1594249039873;
 Wed, 08 Jul 2020 15:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
 <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
 <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com> <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
In-Reply-To: <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Thu, 9 Jul 2020 01:57:06 +0300
Message-ID: <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
Subject: Re: Temporary device removal during discovery
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, Jul 9, 2020 at 12:14 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> The delta logic might be a nice addition as a separate patch, it is
> more for detecting devices disappearing then actually cleanup during
> power off.
No-no, it's not about adapter powering off.

I meant that (external) devices never disappear from the bluez device
list during the discovery,
even if the (external) devices are turned off (i.e. they should be
purged by bluez).

So:
- bluez is central
- bluez is discovering
- peripheral appear for a moment, than disappear (i.e. peripheral
would be turned off)
- bluez would not remove device from the list (at least until
discovery is stopped)

Use case:
- bluez is monitoring environment (discovering literally forever)
- peripherals are brought in and out of bluez visibility range
- bluez list of visible devices grows infinitely and causes problems
(hundreds of devices)


Thanks,
   Andrey
