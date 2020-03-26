Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE71C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD7A20719
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2yaUpOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgCZVMt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:12:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45418 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZVMr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 17:12:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id c9so7511435otl.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si3MmAzVMydwvGpXwEZ58XeQRNXfZJ2KstlfE1u7GIc=;
        b=E2yaUpOhMP1LTNXshtmCz+ULsEPR/vKvrraImVIa3Y90gEOahM6NcfYIyVAifpqs0T
         6K0Neeu/k8H3VwIO1uemtinBZeneQZKiO6FV29unAU+O3i+zkETcvMfQCpG61Jw9Iix7
         3T9Jnh1v0yr1y3MqX/crerGKoJmX7+FvV/7GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si3MmAzVMydwvGpXwEZ58XeQRNXfZJ2KstlfE1u7GIc=;
        b=V+qMbSjbuT8/yx3mRZZ/e9uCG3dAgRibgUZKPwW51CPyas4ih6vpYaDoUehK3DDUUd
         Skh1IErBPimDAvzbK7QdUh79Q6pvx01XDdJxfy2+oUiccYkE8US+XA94kbZxN2aDAaqD
         WGayUkRDKGz48BwEkffu3C1NTtunviGeEko5jzk0Ju5iwGjTQzcvBB7qF/NEslRDcOcx
         Au9BpqKWN+gy8Mb/Z0ztq79Ft1t+L3pQppaT0BvRhnXG2AM7bJ5FDuIPNWMetcZqTAOE
         IY5oMNko75PRwzblyxyQkRkYZ0E0pXOqN1x1ZlsPtfouIjOg9OgQTvXRs0GL6xI6ZaSd
         j/Wg==
X-Gm-Message-State: ANhLgQ1Ry3+bCT8Cx5p7PyZYBzJZ85aka7Go9sOOVUa6fm7WxQNh3ovI
        LVFKMoOw1WmTfjoy0BNci1wCd6alUp8QH5lyISC8kSch
X-Google-Smtp-Source: ADFU+vsaK6WBMt0zbPNguI5evfiUkE48J6wDIfiIYEv2A4VV4mP3be79yvNI54dt72OYef4hWNI7FJOta9J5mrTIgIs=
X-Received: by 2002:a9d:1b6d:: with SMTP id l100mr4306893otl.70.1585257166585;
 Thu, 26 Mar 2020 14:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOxioNmHcCTkc1MA6Zw8WTPBHCTpE9XZyzfOeuj97EP2NeBw=A@mail.gmail.com>
 <CAOxioN=7jGXxp+=c674Ai3bU5N3f-qRpd3zHDuOdSO93W3dnwQ@mail.gmail.com> <CABBYNZLTj2OjtbVfasAFEzQCGmEpcHzvsbozP2WzPP_UQN29pA@mail.gmail.com>
In-Reply-To: <CABBYNZLTj2OjtbVfasAFEzQCGmEpcHzvsbozP2WzPP_UQN29pA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 26 Mar 2020 14:12:34 -0700
Message-ID: <CAOxioN=UrXsrnMZLutmJTMg_OuK1yk-fKTDUU32anJcvHav3gw@mail.gmail.com>
Subject: Re: [PATCH] autopair: Fix compiler warning
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks, Luiz.

On Thu, Mar 26, 2020 at 2:09 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Mar 26, 2020 at 10:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi BlueZ maintainers,
> >
> > Could you take a look at this fix? Thank you!
> >
> > On Tue, Mar 24, 2020 at 12:49 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > With clang, comparing an array with NULL generates a warning because the
> > > value is always non-NULL. With maintainer mode enabled, this becomes a
> > > compilation error.
> > > ---
> > >  plugins/autopair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/plugins/autopair.c b/plugins/autopair.c
> > > index 043bd9b9d..3089430a8 100644
> > > --- a/plugins/autopair.c
> > > +++ b/plugins/autopair.c
> > > @@ -75,7 +75,7 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
> > >          btd_device_get_product (device));
> > >
> > >      /* The iCade shouldn't use random PINs like normal keyboards */
> > > -    if (name != NULL && strstr(name, "iCade") != NULL)
> > > +    if (strstr(name, "iCade") != NULL)
> > >          return 0;
> > >
> > >      /* This is a class-based pincode guesser. Ignore devices with an
> > > --
> > > 2.17.1
>
> Applied, thanks.
>
> --
> Luiz Augusto von Dentz
