Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6062C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A802080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 19:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AFjSuofb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgIOT3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgIOT3k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 15:29:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4183C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 12:29:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so3815451ljd.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKidKktc0S1Z/jV12RUT77V60BgHZyP6LKFdtmWca74=;
        b=AFjSuofb3fIC9UwOKOzBilqlj92UYCwMjnlc/w1ENjqv6dW+68g3oL+12WUQz8GGBh
         1+VlxjOh+mOCcT/zYDrBm8AOG34XYJQFkj/PY1eFEYpJo0wv1wL8jVNQq4CE+GY0TNCp
         mro5JqT00zK3TMg+yfIcnolAyFK3rV4CgQupA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKidKktc0S1Z/jV12RUT77V60BgHZyP6LKFdtmWca74=;
        b=h2+Mv8eR7RJNWbKDOnDHN06O+6l/eF3T6fJ2LZfEntZ7e6gRPLkisQTKKjErN/SwXg
         RdFQO0WeuS2fdnNxgLpELTNdiM9NE8+dUrngphysQbMiApXQMqBltpr0h1dJJRRymYmC
         e9l+nPZFAOc2c048pG6O93ULt6ba0H/5/ZpGda6bpS6oKz+ja8ad8YjMJoxd+PFAQuql
         lyHVisaZqKpKkbW+fks6U2GUIGNoEl/Bs6Q3YgkzpEBfmZ8yAUsqPg2zLJRKJBdd0uPR
         /bqrZXpUrNyOrGkBN7XCYCGBrdrr1Q/S7MZa56/TRUNRY+biNxJIgnAOs24pZjO+zZ/H
         fEuA==
X-Gm-Message-State: AOAM533EXIlTJqvyp3gesepJ4kkfUj28F7JsqVgQjnQjZGXvML3wHQYD
        /Y83LXgh5e9UeKQb8ZxbhnTTGyon/VIXE5HlonTBAdOYGDCDog==
X-Google-Smtp-Source: ABdhPJxvUSqfKnB0sUqgEJybeFI4PsgzbJGUO1R5olnaJFgOserSMvmGrDPbDePyKl8DNK/6+R4pE8VCcsuLUWbGvEA=
X-Received: by 2002:a2e:b051:: with SMTP id d17mr6839865ljl.190.1600198172033;
 Tue, 15 Sep 2020 12:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
 <CABBYNZJeXkqmx1h85bxFBqJ4eDVfaPQJ9P1m_HApbJj48zT+_A@mail.gmail.com>
In-Reply-To: <CABBYNZJeXkqmx1h85bxFBqJ4eDVfaPQJ9P1m_HApbJj48zT+_A@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 15 Sep 2020 12:29:21 -0700
Message-ID: <CABmPvSEZoYCSE_421Qu2b=z91NxajNxWNahA5xcOMqgPmV-ivA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 1/8] adapter: Remove indirect dependency of headers
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the extra fix to get this series through! We're waiting for
further comments on
https://patchwork.kernel.org/project/bluetooth/list/?series=348071.

Regards,
Miao

On Mon, Sep 14, 2020 at 12:48 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Fri, Sep 11, 2020 at 11:53 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > Given that adapter.h refers symbols from lib/bluetooth.h and lib/sdp.h,
> > these two headers should be included directly in adapter.h.
> >
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  src/adapter.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/src/adapter.h b/src/adapter.h
> > index f8ac20261..c70a7b0da 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -26,6 +26,9 @@
> >  #include <dbus/dbus.h>
> >  #include <glib.h>
> >
> > +#include <lib/bluetooth.h>
> > +#include <lib/sdp.h>
> > +
> >  #define MAX_NAME_LENGTH                248
> >
> >  /* Invalid SSP passkey value used to indicate negative replies */
> > --
> > 2.26.2
>
> Applied, thanks. Note that I did introduce a path to fix the build
> problem with  g_dbus_proxy_get_path.
>
> --
> Luiz Augusto von Dentz
