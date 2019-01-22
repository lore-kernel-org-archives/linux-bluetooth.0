Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12928C282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D420870
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avorPF6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfAVMfz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:35:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39198 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfAVMfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 07:35:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so17235921oia.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 04:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UzUhVkeUuis1+wDBnl4hn+qC/snuyoNTDkomFoU8I9o=;
        b=avorPF6gh/AK9rpZzzyzT5kj8JtXTo2AiUDL7GIxotQtzdK9KAIEBNW1Waxor/bOrH
         SGkC6/TsYwG05VpwXLye+pL1L3QPTbPCRiyZUlzXGhv1o9EZ2zb955d4zaHvDYDKz3T4
         6/8p0sSNEpAa5B6o/+1QHI9SqzTzixP4CGYQJp1LWVZYTP2SaV0PVqDOwwqYDchTTvy6
         SrHINAKAtXpkmqFLEk9DZj6VRm3EgTNivzZHKUvBmiWt9hwGsxlCs3gliPrmPdDq5dYj
         Y6gQbBiHXKjTtDg6M5YU1QxofrP0MhejqPk15WpjsJy4vmvcJfrxhUKAo72TBkr9wZ1O
         g5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UzUhVkeUuis1+wDBnl4hn+qC/snuyoNTDkomFoU8I9o=;
        b=hOR3zScrVtRHZGvNCFqfDrK1JZdSch5grOZOv6XsCqdzr7JDedMNXZQRoAbhLTojCy
         OqU/4w8sHB7p1xCq7ri/SF1n+IDZsYIyq7hjdp4QZL/obgi5bGo+CR1zUkAYjeiaKMAm
         5EWIBxBoFocCvZtYxCk+kgvf6PNTdg5d30AoIZUZgEgbnEwU3cgulL1S5CjakYrP/mKE
         ZRkdGwfjmIYi8rTxQHjZjNczcwBMN6AKxFISv4u+4wckWoz7K1GxDJ8nk8SkzU7Jdhip
         1RhSD6kyctD+al6KMURcV6EqLTkADQXsLvkY2kKGs2gEzqJFVk0a1BSPOt51S3iZaOt6
         lc7g==
X-Gm-Message-State: AJcUuke2MUzr3WIekz95oi8/9PItAHgWYY9E1Eu+eS5EOqDtHm0K9Ole
        AV/TJEBF9uRgDtSldorNizvbLPQ5zepXCpWNcpE=
X-Google-Smtp-Source: ALg8bN7ZcNZWVGR1EEk93D7CdcP8WxD1dLqrviU3ynvM1EoNUx/jCcUWvb+tZSiXzBg5ATETAY9u6MhxTErUgmVq+I8=
X-Received: by 2002:aca:aa0d:: with SMTP id t13mr8528692oie.273.1548160553950;
 Tue, 22 Jan 2019 04:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20190115141023.353-1-luiz.dentz@gmail.com> <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
 <20190121183016.jiqrtw3csllmqhif@pali>
In-Reply-To: <20190121183016.jiqrtw3csllmqhif@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Jan 2019 14:35:42 +0200
Message-ID: <CABBYNZKMPfkSvHqryeR7P8QitQVAv+-WVudSV=hpVaPjTOUu3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Jan 21, 2019 at 8:30 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Monday 21 January 2019 20:25:41 Luiz Augusto von Dentz wrote:
> > Hi,
> > On Tue, Jan 15, 2019 at 4:12 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This adds the possibility to expose remote SEP using MediaEndpoint
> > > interface to allow setting a configuration.
> > > ---
> > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > index b5ad2db12..af9485342 100644
> > > --- a/doc/media-api.txt
> > > +++ b/doc/media-api.txt
> > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > >  MediaEndpoint1 hierarchy
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > -Service                unique name
> > > +Service                unique name (Server role)
> > > +               org.bluez (Client role)
> > >  Interface      org.bluez.MediaEndpoint1
> > > -Object path    freely definable
> > > +Object path    freely definable (Server role)
> > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_=
XX/sepX
> > > +               (Client role)
> > >
> > >  Methods                void SetConfiguration(object transport, dict =
properties)
> > >
> > >                         Set configuration for the transport.
> > >
> > > +                       For client role transport must be set with a =
server
> > > +                       endpoint oject which will be configured and t=
he
> > > +                       properties must contain the following propert=
ies:
> > > +
> > > +                               array{byte} Capabilities
> > > +
> > >                 array{byte} SelectConfiguration(array{byte} capabilit=
ies)
> > >
> > >                         Select preferable configuration from the supp=
orted
> > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(object =
transport, dict properties)
> > >                         endpoint, because when this method gets calle=
d it has
> > >                         already been unregistered.
> > >
> > > +Properties     string UUID [readonly, optional]:
> > > +
> > > +                       UUID of the profile which the endpoint is for=
.
> > > +
> > > +               byte Codec [readonly, optional]:
> > > +
> > > +                       Assigned number of codec that the endpoint im=
plements.
> > > +                       The values should match the profile specifica=
tion which
> > > +                       is indicated by the UUID.
> > > +
> > > +               array{byte} Capabilities [readonly, optional]:
> > > +
> > > +                       Capabilities blob, it is used as it is so the=
 size and
> > > +                       byte order must match.
> > >
> > >  MediaTransport1 hierarchy
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > --
> > > 2.17.2
> >
> > Are there any comments for this set? Notice that I did include the
> > device path in this set so there is no need to hack to guess what
> > device the endpoint belongs to.
>
> I did not know about V2 as I'm not subscribed to list. I tested and used
> with PA only V1.

I will send a v3 which does the reverse discovery, that should make it
work with existing paired devices that reconnect and configure since
otherwise there would not be any endpoints to associate with. Note
though that in case of PA the endpoint object should be considered
optional no matter what since otherwise it won't be backward
compatible.

--=20
Luiz Augusto von Dentz
