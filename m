Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8885EC282DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60820820
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 12:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwE+9uVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbfFJMRI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:17:08 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37176 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388850AbfFJMRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 08:17:07 -0400
Received: by mail-oi1-f176.google.com with SMTP id t76so6058298oih.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2019 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qt9+CC8ZEW/8WTr5R65H9ifK0bri9j7zNuqyOv5eOB4=;
        b=EwE+9uVKJhXAwdjBRkxO28aov09WY713/5AvX2B0ovpM9cS5jpV9a3LYWEKUm7pzl1
         WzImXx81/BLv4J5oD2vuQVGUFKYUPsAc0woNya9qqvNwOtOU4VbXRFXD7ZFBvhruzqft
         UuPEUO31QhFWsKWIRtJ4TBuAAsYSm2DOqFxH/xkN6Rpu9J90x8enaoCuKDOOils7tEwr
         I/42i6Yi1rBcEba/BsJXjB1NKqiEl2622pNfjnVrVy+RYXGzh1fbnTa0brbpV/OA4b9p
         0ekXVWsymdPV4Sl0NeILhcbKeYjpPdGlbuEhIwpRvoFDTTg0pDrBJxP9vh35R9pe6j+G
         VUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qt9+CC8ZEW/8WTr5R65H9ifK0bri9j7zNuqyOv5eOB4=;
        b=nFscumOM2gqWrBc6MRR3eLr1qK1LbYkUjWgS84F/qCCZhfqJEGglqTe49NE6RPsyuj
         +j/CMOuWT8uhjhBjoAxKu1NCO/Fm+8YJUhZZDYPThVpUHCoU0VHkogUR1o8malX8g1Om
         3O6BbfBHKQEIMoVoYsjtVKhqYm8dvLutxZwyhgDgsUzToE88nINe9PDCTXded0A/DHir
         WBQoJrjtYBYvAYJOuIZr+HArEXQ1sNLkUlKMqBVHDckGRNNDIDWgR56nfA5iDxBqOkQw
         wybRCSkYLsi51yeCKGXm9XS4BJcwK/4gLro7ftztQMjK9kt8HbehMaECwvPUMwW2DyxL
         wNsA==
X-Gm-Message-State: APjAAAXkq7Ov57Em57XmeWFAWqG4NgeaE3P5VyNgNMm1Vbp4enn0e3Oy
        moelpJmncsOgzbypHxRU7RKPy23BO163TAFKZgo=
X-Google-Smtp-Source: APXvYqyiXnZhBbkGhrCx2/5dPhydjiQdTVzzA3Ye6zxpUaEzekQYTOIeZ2BeJyF1bEoIiz7vAl7FxyycAV6T+7EvQxc=
X-Received: by 2002:aca:e4c9:: with SMTP id b192mr9564488oih.82.1560169026750;
 Mon, 10 Jun 2019 05:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190518190618.m7rdkthvpz4agxd2@pali> <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
 <20190519122223.gabew7qfftihlbic@pali> <20190607130021.ntd3dfd6nzmuy3m3@pali>
 <CABBYNZKQ0WYTH4Oa_eFv11Ok8=42oY_GPFzN-D6UqfeNsvaXug@mail.gmail.com> <20190610105130.un3muj4knwoua5cb@pali>
In-Reply-To: <20190610105130.un3muj4knwoua5cb@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Jun 2019 15:16:54 +0300
Message-ID: <CABBYNZJKmX-VutDjuT_q_n7VnMXLi8omqK4JU5Du8r3RFCsNwA@mail.gmail.com>
Subject: Re: bluez A2DP socket reliability
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Jun 10, 2019 at 1:51 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Friday 07 June 2019 18:23:41 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Jun 7, 2019 at 4:00 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Sunday 19 May 2019 14:22:23 Pali Roh=C3=A1r wrote:
> > > > On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Sat, May 18, 2019 at 11:12 PM Pali Roh=C3=A1r <pali.rohar@gmai=
l.com> wrote:
> > > > > >
> > > > > > Hello! How is L2CAP layer of bluetooth socket used for A2DP aud=
io
> > > > > > transfer configured in bluez? It is reliable with big/infinite
> > > > > > retransmit count? Or in best-effort manner and some packets may=
 be
> > > > > > dropped? And it is possible to change between these two modes f=
or
> > > > > > application which uses bluez DBUS API? I'm asking because some =
A2DP
> > > > > > audio codecs are designed to deal with packet loss and for thos=
e codecs
> > > > > > it would be probably better to configure L2CAP socket to unreli=
able
> > > > > > mode.
> > > > >
> > > > > We don't use ERTM with AVDTP, both signaling and transport socket=
s are
> > > > > using basic mode which don't support retransmissions, there the
> > > > > concept of flush timeout which iirc we don't currently it.
> > > >
> > > > On bluez.org site there is no information how to use bluez sockets =
and
> > > > the only documentation/tutorial which I found on internet was this:
> > > >
> > > >   https://people.csail.mit.edu/albert/bluez-intro/x559.html
> > > >
> > > > I do not know how up-to-date it is, but seems that by default bluez
> > > > L2CAP sockets are reliable and to change them to unreliable mode it=
 is
> > > > needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0=
x28)
> > > > request. As default is zero =3D infinity =3D reliable connection.
> > > >
> > > > I do not understand low level bluetooth details, but is ERTM relate=
d to
> > > > OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?
> > > >
> > > > So what are default settings for L2CAP socket used by AVDTP/A2DP
> > > > profiles which are transferred to user application via DBUS?
> > >
> > > Hi! Do you have any idea about OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT? It =
is
> > > related to ERTM or not?
> >
> > The OCF usually describes an HCI command which may affect the entire
> > ACL connection, ERTM is a L2CAP channel mode that includes
> > retransmissions. The A2DP stream transport doesn't ERTM so no
> > retransmissions shall take place.
>
> Fine, no retransmission is good for A2DP.
>
> And how it is with delivering packets? It is possible that may be
> delivered to other side in wrong order?

It is a single hop with guaranteed ordering at L2CAP channel, you can
control the priority on a per socket manner but afaik PA is already
setting that to high priority which helps when dealing with
congestions due to other traffic like OBEX, etc.

--=20
Luiz Augusto von Dentz
