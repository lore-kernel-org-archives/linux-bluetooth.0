Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95472C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E520674
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 17:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLIDxyo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgESR6N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESR6M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 13:58:12 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E00C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 10:58:11 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y85so496944oie.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F7DcFkSepJd9IN24nZKE3LT1DxojLQUVqUkLLASq1CI=;
        b=kLIDxyo+nzSKEzxPhziP6NdSNlj78f7OX6KJ8xsjru80rnafHBUwEp7T09Libcx6Ev
         R3XHEZiFWWfmG5zpcJOEIfuYya9xKlZMnWuGZmdJLEc3LE/1CUq4eBUImWuUy41XANpc
         ldkzf3ofHGsLA97MUDUTrn/6vUu1nMtj9VunDYbOyJ+N2urfJnlK6PYx/pubIuFO1iTN
         qM+uT8tFsewK4cB3LDAW4YspB3xIAbB7akbX8z8gYCQJRqVac0vmfDbpWFGqIxzhjHtQ
         /8Xa5DwqmcKFcHKME6IigIdTLbc7aGeDVcpFC0uzS2eDOuOSmAMC4XePKVqK/ZE8tq7x
         vRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F7DcFkSepJd9IN24nZKE3LT1DxojLQUVqUkLLASq1CI=;
        b=GFZfncdLgAfATh8kEsJG/TgRVig4cf29iyIGwe4OEc6yOXdNrzJfcWhSpB3eGK0HzR
         RVHCzDb8gojxYXVX7wqG/N2a6vQaxkv5NU9d/sp6keO1RxlQydJp7NoebrMGrdhTIx4Q
         VnK2Jqx7WNxle8r0xStRK+ylPahK7nSxbbpVpayY2RAOYMVpz3pCj4C/FllOSEizNHOM
         eLmBH1YFyiAhxw0wvfuBVa/q2MNT6oQgHI2cteJGD1UtHgJgsWhm7HaTCAqI2AoXMpyn
         NuYHCX3crGNeW2W7wr9nBRZnwkL3pEc63HMQagLdjJ3CLL6Fo3N30NvK7mm+W3yxGGM/
         2sdg==
X-Gm-Message-State: AOAM533uz238TIfm5fNRT3lVSWWo311NlJCQWfnh8+RaKQpeLSqyYkqt
        5wk4Z6fCrv95QSCF9Y6mNt2/r+/reNOiPZjGjXmGwg==
X-Google-Smtp-Source: ABdhPJw1wqLoO/q/J5FOnH7KX8MSxLnT1TNaPjepASK/ZjuVA9dVh4i+774PxwIL9WT6fwIntYa6ErelFaWQEx5f53c=
X-Received: by 2002:aca:1b1a:: with SMTP id b26mr452382oib.82.1589911090932;
 Tue, 19 May 2020 10:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200512023609.43163-1-rafael@espindo.la> <87pnazudbo.fsf@espindo.la>
In-Reply-To: <87pnazudbo.fsf@espindo.la>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 May 2020 10:57:58 -0700
Message-ID: <CABBYNZLaA5c=K72qK-W=erURzJiuw-4wkBaBuCuv16HUXsm6Zw@mail.gmail.com>
Subject: Re: [PATCH] Mention disabling SELinux in HACKING
To:     Rafael Avila de Espindola <rafael@espindo.la>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rafael,

On Tue, May 19, 2020 at 8:58 AM Rafael Avila de Espindola
<rafael@espindo.la> wrote:
>
> So, is this OK?
>
> Cheers,
> Rafael
>
> Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la> writes:
>
> > Running bluetoothd from the build directory I noticed that as soon as
> > a bluetooth audio device was connect, bluetoothd would be disconnected
> > from dbus and print
> >
> > Disconnected from D-Bus. Exiting.
> >
> > Luiz Augusto von Dentz suggested trying with SELinux disabled and that
> > solved the problem.
> >
> > This patch just documents how to disable SELinux before running
> > bluetoothd from the build directory. I would love to say more about
> > why that is needed, but could not find anything on the audit log.
> > ---
> >  HACKING | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/HACKING b/HACKING
> > index e10986fcb..29b136b34 100644
> > --- a/HACKING
> > +++ b/HACKING
> > @@ -76,6 +76,9 @@ automatically includes this option.
> >    Copy configuration file which specifies the required security polici=
es
> >      # sudo cp ./src/bluetooth.conf /etc/dbus-1/system.d/
> >
> > +  Disable SELinux
> > +    # sudo setenforce 0
> > +
> >    Run daemon in foreground with debugging
> >      # sudo ./src/bluetoothd -n -d -f ./src/main.conf
> >
> > --
> > 2.26.2

Applied, thanks.

--=20
Luiz Augusto von Dentz
