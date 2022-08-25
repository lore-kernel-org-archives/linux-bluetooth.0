Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F12ECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 23:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiHYXLE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 19:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiHYXLC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 19:11:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBE2ED7E
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 16:11:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m5so19503655lfj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=U9Sv02WeVhm2c+EOXR+LhbpcjXkIe1UUAJfdlQLHF/c=;
        b=IzrxgtTC3eIyF9MOhKRGnZ7lUQ+jIamxcZZUF0/EMxl1nobu3Q5LFaC9Ojfjg5OXkh
         EC5vcF+KD8la+XEGSWUyQVloNNVypKu/35el4VuBEKxucAJUUotAcCw1qmCadQQTT+W8
         d5VIewsrL1pBkvHXTegdyKEFYvCyAK5KmrZJUq/FnDmy2miMeGbHGKILPt/eMfkOu5z1
         yn5ytvldPJd4rqkJt48RDDYYqzXWnT7iYALZyP0mODkRzQVSngWA/CHAxKo0cYMPW3Ei
         3FClcM1ITCJrlvxd3CAmwIkAunlVKxDi/6n0dxPzSSJrTOImx7fCr83ipE4OEAeBLZHw
         Jy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=U9Sv02WeVhm2c+EOXR+LhbpcjXkIe1UUAJfdlQLHF/c=;
        b=LTYH1h7m8MYxLIHryj+yGNza1XuiKw1j9GZ23PyWIeVWmjqqZX3lhlEHpwqoSMJBrw
         53yX48Skc9NFav0xk7KGnKykTxjO14yysDkQTakf/Emd2v5+LOL5gKdv11aPXJp1ZyOs
         Ba4ueufSdrWnm1Mg8JiVVGry5DuDsACFngkXxxwimUJRfv49VC1PObJ68ovZYt+b6VCC
         D/RUJe/1WhTRnOAUEPCBWkuyrHNBCdAdvNuRbqLFTFmX1OAxjYaa/t+CF16yFQveJvtP
         zMHybTybmAJN6sZ4CGIrN29IcFfBwgOsxkHqP/7nQyCbY08vt53CNSHLqaBOQJ4MrgBC
         b5jA==
X-Gm-Message-State: ACgBeo0FYqjpQHnN18YhOoGoU+kxAId47OlEv/AL0UfBvbG8N22trbgj
        7FlXB++jP0hx7ANiJmSBep7qk11YIuzKzXRwkMCq0QI5
X-Google-Smtp-Source: AA6agR68GCyx9x74g8JL8xcxj9oemjPnuSDx0q42HD9aJA52A+mt54Y5tobQvmnpJ4ktCdO98xgaGllkgaAf85zEaWI=
X-Received: by 2002:a05:6512:3d0c:b0:492:d277:6627 with SMTP id
 d12-20020a0565123d0c00b00492d2776627mr1566632lfv.251.1661469059771; Thu, 25
 Aug 2022 16:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
 <6422b1f3f94e959917f919af20a2aa43b4c13a89.camel@hadess.net> <CABBYNZ+TKBSHr67Avm+g-_ce8bKE17OSp9xMayJk_y--MsAuDQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+TKBSHr67Avm+g-_ce8bKE17OSp9xMayJk_y--MsAuDQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 25 Aug 2022 16:10:48 -0700
Message-ID: <CABBYNZKpB2p5mh8q6he21MM1m3qapwYccsEgUa9q5OrbjRnZzQ@mail.gmail.com>
Subject: Re: [PATCH] adapter: Implement PowerState property
To:     Bastien Nocera <hadess@hadess.net>,
        Archie Pusaka <apusaka@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie and Bastien,

On Thu, Aug 25, 2022 at 4:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bastien,
>
> On Thu, Aug 25, 2022 at 8:32 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Thu, 2022-08-25 at 15:26 +0200, Bastien Nocera wrote:
> > > This property should allow any program to show the transitional
> > > state,
> > > not just the one that requested the change, and will also show
> > > transitional states that were the results of other system changes,
> > > like
> > > rfkill changes.
> >
> > Looks like the bot doesn't like where I put those comments.
> >
> > If anyone can comment on the API I used, and I'll iterate the actual
> > implementation. I'd like the API to be settled by the time GNOME 43
> > ships, so we can rely on it there.
>
> I wonder what are you actually after with these changes, in most cases
> I'd say the changes shall just be queued, anyway perhaps the problem
> was something related to:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=ede7b915980fbc80eff80aa189c35ca016956c61

Btw, I think this shows that perhaps it would be best practice to
create a github issue when there are bugs for Gnome/Chrome OS so we
can properly use the Fixes: tag to close them which makes it easier
for downstream to find out if a similar issue was fixed and attempt to
reuse the same fix.

-- 
Luiz Augusto von Dentz
