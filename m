Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00967C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C880A2089E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilyM+cxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfFGPXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:23:52 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45987 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfFGPXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:23:52 -0400
Received: by mail-ot1-f52.google.com with SMTP id n2so2168687otl.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SIynrcBU2opRbYQHu+rzQ51GzaMTNMtb96Ffxxpg3Lw=;
        b=ilyM+cxhfMfaScMm47P9h8nWu+alF4oQRItQveIKebuQO0ItdtIfRpgHDB7kfkSNpF
         A8TdymxqUdOsuNGi7KQGTlB/6MYYH0s7tgXK7sFQK+g84BsDONPwgJnr/46+T5Azk+DJ
         n8J58YuxA9MAjFc60sSSd5E6nSyLxZKfNE9GjsSPe2Or0asHD4VIKlm5IT0tIdwvh215
         wxqhiZnZrd2yLdLJDUZrsLWK7olyCoJVwf64PSfDnjMT/ZzumxFWGd+echHs5JgyRUZ3
         N6Xjj7Ebg/ZWUy2bjEbP4E7ErIsTAcx9Ot62TM/KcjN7elmNZsTjypT9RWud+mTttHec
         AiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SIynrcBU2opRbYQHu+rzQ51GzaMTNMtb96Ffxxpg3Lw=;
        b=L5z4XSG5wxkwcMFvKxwEIXuhlRTffgrJllhSUJJKxsUz7/sdFL9I5KaDr5d8QIgX+q
         YDTGqkmfgcJcqZM/MwTiy6Z00MCc1aOhxkMF0azmC3r3uCgE+t5wMDqvAJ51bd94NNXs
         NiHDarxQEAWPcvpTlbnbKc5+yLp3oVsst4pnIqOtFesUP+y3DSOT5awOjKObE1Zl0a2z
         FMm3QJmNf1RZUsTEgh0I+SZS50DsYrUXNR+Wb1x+H07VH7Qqin+XlraTsH2CZReruFtV
         Nf6zMpTYg3X92E/fskj87U2IGNFl3huQ9iXGiK7fXzV7MFrqLP9NijFa8D3o+1igVtIF
         2ybQ==
X-Gm-Message-State: APjAAAUhOA0bbBl45SpZbdwJBddDqvIiDO39YaYUhJoFDQRH0npmDAQ7
        ERp6rF/k2Jlm8L81EJESYcOYuTs6Qv/mkrl3YBeiCBaw
X-Google-Smtp-Source: APXvYqy5A1T2XAH1eBotXvm+qRXnRLqGtNrQEHUsmpxhrFD3WmecoMXDIqNGz1hCCMNz4ykctBGVR8mDGf86fYqM1Ck=
X-Received: by 2002:aca:e44b:: with SMTP id b72mr4274363oih.108.1559921031223;
 Fri, 07 Jun 2019 08:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190518190618.m7rdkthvpz4agxd2@pali> <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
 <20190519122223.gabew7qfftihlbic@pali> <20190607130021.ntd3dfd6nzmuy3m3@pali>
In-Reply-To: <20190607130021.ntd3dfd6nzmuy3m3@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jun 2019 18:23:41 +0300
Message-ID: <CABBYNZKQ0WYTH4Oa_eFv11Ok8=42oY_GPFzN-D6UqfeNsvaXug@mail.gmail.com>
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

On Fri, Jun 7, 2019 at 4:00 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Sunday 19 May 2019 14:22:23 Pali Roh=C3=A1r wrote:
> > On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Sat, May 18, 2019 at 11:12 PM Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > > >
> > > > Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
> > > > transfer configured in bluez? It is reliable with big/infinite
> > > > retransmit count? Or in best-effort manner and some packets may be
> > > > dropped? And it is possible to change between these two modes for
> > > > application which uses bluez DBUS API? I'm asking because some A2DP
> > > > audio codecs are designed to deal with packet loss and for those co=
decs
> > > > it would be probably better to configure L2CAP socket to unreliable
> > > > mode.
> > >
> > > We don't use ERTM with AVDTP, both signaling and transport sockets ar=
e
> > > using basic mode which don't support retransmissions, there the
> > > concept of flush timeout which iirc we don't currently it.
> >
> > On bluez.org site there is no information how to use bluez sockets and
> > the only documentation/tutorial which I found on internet was this:
> >
> >   https://people.csail.mit.edu/albert/bluez-intro/x559.html
> >
> > I do not know how up-to-date it is, but seems that by default bluez
> > L2CAP sockets are reliable and to change them to unreliable mode it is
> > needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0x28)
> > request. As default is zero =3D infinity =3D reliable connection.
> >
> > I do not understand low level bluetooth details, but is ERTM related to
> > OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?
> >
> > So what are default settings for L2CAP socket used by AVDTP/A2DP
> > profiles which are transferred to user application via DBUS?
>
> Hi! Do you have any idea about OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT? It is
> related to ERTM or not?

The OCF usually describes an HCI command which may affect the entire
ACL connection, ERTM is a L2CAP channel mode that includes
retransmissions. The A2DP stream transport doesn't ERTM so no
retransmissions shall take place.

--=20
Luiz Augusto von Dentz
