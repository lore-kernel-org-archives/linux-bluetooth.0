Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D752C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 23:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiKNXgA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiKNXf6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 18:35:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D07F9FC8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 15:35:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so21897673lfv.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 15:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2EXjO0vBMtr6bTqBE9yTKO5/eFLMpO7gBdysgIPEcw=;
        b=cn9yVZS806GSy0KPkTGYeJbItHm9bJ3X8au0gI/Rce9xyX6IL4fVmMtFA5cOnEibNr
         KkVHbRHyO07flVqB4aPTyYta1p6N2E3TRqjKAovepdELxGqoY53Sh6Zv9seG8A7asL5O
         4QGvC25WIHI6pVWIkthz2Rx7vDFyDHyzJlNrhL86Xm/Mi4NVxt0rya/CZ3JN6dBFhf+b
         RPb+h+xJKXkQD3/u5pPtaGHRkGaCRsVmVwjiGmfjIRoC1KhyWIbKUxmWPAdL/T5+xs40
         dyMcsBz/Mw5Q4Vdlzmh8THBpoyOB2Ouxopjt9xvdA0DndgIobcJGnrTGntho2CyLB+9W
         rNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2EXjO0vBMtr6bTqBE9yTKO5/eFLMpO7gBdysgIPEcw=;
        b=wD5kOfkDemoFCb4PboGZkGSVRA53CDqnvdmEMvu/MfqmtGdRTCw3ummoz3uljlyP+j
         rOzJP1t6YRkHi+KYDFas2fLUaCwaa6ckjA6uKNHVJjLzjRJnfZzT/CTbZHlO3EwPfYNv
         2cjTkoYzoyXvGAMJYe4FQrkhYmeljCqKsiOTEs5uPrUgKbo99YD+eeFoTCphoOaz1QhW
         WUV0c2CF5Y7LrHotisqb7OQu7tAIDHzPd3XONSMyRgm07pW+EVChtBMxhNfHeZDVp/ZS
         G9M6wZbitXCY5kfVj/ykCfjqg1pj6MAKp53/V6BcYZkgo9S3UE48n38J3CIeDcvOMIHd
         SB9Q==
X-Gm-Message-State: ANoB5pmeeGHYHpwxzoNq10LpcguW7bjPcPxAXRgRwI18JTCJC7f5CUuu
        dKTpl91vjl9AuXASQYcYqBzUuh10qrbQC0i+lUw9OFsz
X-Google-Smtp-Source: AA0mqf6UvSQXMpkB+y3TcrLDINNO6a/fexWIfN6DL2v1QGwxa+YR2FtbR+LMHl0znNte0Tu/Rho1rNYXz2fwGYdh1Sk=
X-Received: by 2002:a19:8c54:0:b0:494:70b2:26bb with SMTP id
 i20-20020a198c54000000b0049470b226bbmr4576399lfj.26.1668468954497; Mon, 14
 Nov 2022 15:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20220901110719.176944-1-hadess@hadess.net> <20220901110719.176944-6-hadess@hadess.net>
 <02bf340b-c908-6ee8-ca78-4203b965f3b5@dressler.it>
In-Reply-To: <02bf340b-c908-6ee8-ca78-4203b965f3b5@dressler.it>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Nov 2022 15:35:42 -0800
Message-ID: <CABBYNZJgao0tRQwEw9a+LFRzaTX8AwRmAsj+C=XLhoxVTCDg6w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 6/6] adapter: Remove experimental flag for PowerState
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <jonas@dressler.it>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jonas,

On Sun, Nov 13, 2022 at 8:03 AM Jonas Dre=C3=9Fler <jonas@dressler.it> wrot=
e:
>
> Hi everyone,
>
> Can we please apply this one, too? The property being experimental means =
distros
> need to downstream patch BlueZ for the feature to work, I'm not sure all =
packagers
> are aware of that.

Well experimental can be enabled by passing -E to bluetoothd, so it
can be enabled at runtime, that said we might switch it to stable on
the next release.

> FWIW, I can confirm the feature in gnome-shell works after removing the f=
lag!
>
> Cheers,
> Jonas
>
> On 9/1/22 13:07, Bastien Nocera wrote:
> > Now that the feature has been tested, that the API is deemed adequate
> > and the reliability sufficient.
> > ---
> >   src/adapter.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 8fb2acdc8..841096d7f 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -3864,8 +3864,7 @@ static const GDBusPropertyTable adapter_propertie=
s[] =3D {
> >       { "Alias", "s", property_get_alias, property_set_alias },
> >       { "Class", "u", property_get_class },
> >       { "Powered", "b", property_get_powered, property_set_powered },
> > -     { "PowerState", "s", property_get_power_state, NULL, NULL,
> > -                          G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > +     { "PowerState", "s", property_get_power_state },
> >       { "Discoverable", "b", property_get_discoverable,
> >                                       property_set_discoverable },
> >       { "DiscoverableTimeout", "u", property_get_discoverable_timeout,
>


--=20
Luiz Augusto von Dentz
