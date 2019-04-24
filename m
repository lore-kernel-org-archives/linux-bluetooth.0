Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B62C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 18:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642520835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 18:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7kp8VHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbfDXS0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:26:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36029 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbfDXS0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 14:26:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so15116790oia.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o6u5JeNsh7Bhm5wBYQw+jL8xEO3vZECTdVlofKIoQ0c=;
        b=m7kp8VHFsWO4IO5gKkoGEaduONpsiaMXHJ5kBE7Vxi1QQUusgFsm0IhbLn9/b1wL8J
         9kgvRYgj+Er5BdIZBzkDp8nhRU7PKzga2xLScOxCeWM5uf3C1Aapb6ybAXoQ+N2HLSyY
         +TKgQvJrcg2z+DIE69rziVtmJ6weHEsa0P3ne8114b99kJwZSKh+ldFeiTNfrVT9MiXe
         XCz+sdXxITDV929quEJzKtu3x04zo5GYSgvC6dAc7v+8tDBIgb3cvFkMYW3Bkxtnk/7R
         7EbNBHLPG4vWNWHQTL+udyVSfDEvxsUVl4RU7/RJZClRjfJIToWwGc2a2Pr+m90lgI1l
         whEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6u5JeNsh7Bhm5wBYQw+jL8xEO3vZECTdVlofKIoQ0c=;
        b=rykrsCoU+bvEQx3hOSJDsSOq7h0mquQ/IBit2iVHKr+OMUEuNmsazsoiX97RSU8WM+
         Ya3hpJkk0GzzRHFpWHNy9N2GOmRf2zR2q35dPs70+Lg+eh3/LsVskXFe6cH52GOL0BNd
         BGPYpEg1OSSO83rn6WHtnx6p8ejFQT/ib/Ea0YuSZn9R22ZOQ1X+Ba0xi0YxgOjyTSkg
         28WP33HeT5VH4bNtUFFe5FZ0+G9Jw09x1plcyNVeTos5NIBqPb4XbXVM9nqTZmEKpe0e
         AnT3ef/AUnz2vXNsKjkQizibfjp4J4l4KyXoDU/LKc63nNZYLPQtU6KlvzRcOaKEazs+
         QAtw==
X-Gm-Message-State: APjAAAV8+p4HBFm6aCYnVPYFWkCyziNNvnTu9Y182yRK1Jl9pNgemNBM
        BOAaVFWU+m4CBwH/MSpZ7RnZeWSEiMbFmdhM/mk=
X-Google-Smtp-Source: APXvYqywCitek/B29WI1dxmo4kZsti2vNa0nKygLITrvj4mz2PXvaFeRz2vgmj2WXAD/F+P9LWXNfq4C3t8vQvxTRDo=
X-Received: by 2002:aca:b255:: with SMTP id b82mr310769oif.82.1556130412279;
 Wed, 24 Apr 2019 11:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190424083921.15679-1-luiz.dentz@gmail.com> <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424170122.4szmly36ztnn6l3e@pali>
In-Reply-To: <20190424170122.4szmly36ztnn6l3e@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 24 Apr 2019 21:26:41 +0300
Message-ID: <CABBYNZJiyGLx5NbAtnY867fsiEB2MdtSXpSJ6mSHebLDfo5fGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Apr 24, 2019 at 8:01 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> > On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > > @@ -2355,8 +2421,12 @@ done:
> > >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList =
*list,
> > >                                         const char *sender)
> > >  {
> > > +       struct a2dp_sep *first =3D NULL;
> > > +       struct a2dp_channel *chan =3D find_channel(session);
> > > +
> > >         for (; list; list =3D list->next) {
> > >                 struct a2dp_sep *sep =3D list->data;
> > > +               struct avdtp_remote_sep *rsep;
> > >
> > >                 /* Use sender's endpoint if available */
> > >                 if (sender) {
> > > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct =
avdtp *session, GSList *list,
> > >                                 continue;
> > >                 }
> > >
> > > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=3D =
NULL)
> > > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > > +               if (!rsep)
> > >                         continue;
> > >
> > > +               /* Locate last used if set */
> > > +               if (chan->last_used) {
> > > +                       if (chan->last_used->sep =3D=3D rsep)
> > > +                               return sep;
> > > +                       first =3D sep;
>
> This assignment is useless as 2 lines below you are returning sep from
> function. So assignment of sep into first does nothing.

Right, there was supposed to be a continue at this point.

> > > +               }
> > > +
> > >                 return sep;
> > >
> > >         }
> > >
> > > -       return NULL;
> > > +       return first;
> > >  }
> > >
> > >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8=
_t type,
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
