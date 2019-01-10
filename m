Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0387BC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13AA214C6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 11:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCkWq06b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfAJL7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:59:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35369 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfAJL7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 06:59:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so11080712wrb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iVe9GBK3vjUsh6zZDbU+M3B7pa0EOnhMNmaG9zVBYrY=;
        b=JCkWq06bo+/bAPC7WUyMsnu6Ki5JH5kum6vexhDabmsHRJ8yZ7t3Ma7W756qaT1erA
         USQRnsvS2NAoEhFDFzpXksw/cucksc1LuIPnzVJNLH8bQrhxTrIm824kZCYhl2Tn0Kha
         ojQwHxPDL6a3mDLB08G40IkOHnH9VfpyikLNCUKeADgqTZGfmuxy6jV8bTHuJLlsEshZ
         iYoA+8E6KMh6CQIf/hjXO/xDWFa2o9FW5i/51eFTkJzbOp4jcSP8sz7YxyvuMN9UDMSG
         J6fSLxGQtMgdfg59RfkC1kCl9cySRiHcQJ+B2pOkz5k61CD8/INBbLEbv18gvEHRqEdt
         0Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iVe9GBK3vjUsh6zZDbU+M3B7pa0EOnhMNmaG9zVBYrY=;
        b=ZmCAtH342KS+OWeT0sotkTgnOw7EayH4fS76T9HBhh54wI07XIzsjUV46T+4t0WvKF
         9dFny0xANnlH5Mt7tzObNRW3k5GAuGgFjsXeJG1KOjdjitIVsAZC0aGodHa4u5ymShJV
         N2d9/eholzbHpivrNpcODGCDreEBV1I7tUscdOlo2tx2rLdPE4K0wvZ8Rxqx46NvH9PK
         1zBkte6882U7zdzUApHQU75lDPcueFx+RU7B+acgG54jOPUYy0IEl78E7V2u3sRLfi1Z
         SA1D2Q42kxkeu04AnxpCZmd8nEuHtHDRFvxQFPwv88vHQzNZKkNWvvWOimvGhEYBN90x
         pDNg==
X-Gm-Message-State: AJcUuke5BJf8yJ9SoDeWG/pDnZFJ5woSiXDUId6AB4fHOtXp7J/Ksova
        JjfszvLYZHIsDfJgdnEMplo=
X-Google-Smtp-Source: ALg8bN5VcLWMhd7Vf0pEET3iDz2DKmXkxxSkMjsKJy8SCCcR/kRYG/bd8LfjSVSu7iFtxmHtR7Sy9Q==
X-Received: by 2002:adf:a14d:: with SMTP id r13mr8543348wrr.169.1547121551940;
        Thu, 10 Jan 2019 03:59:11 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w18sm52129713wru.54.2019.01.10.03.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 03:59:11 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:59:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190110115910.jldtfzzrhvta44pa@pali>
References: <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
 <20190108165612.5krhgtmce336xjx3@pali>
 <20190109180340.5fh7adag6buij4px@pali>
 <20190109181436.atlbhkqclpq3kcta@pali>
 <CABBYNZJk=wycGzic5+DqFHg=30KX9NNwnZMpsVdgkLjzseMA2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABBYNZJk=wycGzic5+DqFHg=30KX9NNwnZMpsVdgkLjzseMA2g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday 10 January 2019 08:29:02 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Wed, Jan 9, 2019 at 3:14 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > On Wednesday 09 January 2019 19:03:40 Pali Roh=C3=A1r wrote:
> > > On Tuesday 08 January 2019 17:56:12 Pali Roh=C3=A1r wrote:
> > > > On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> > > > > > > Regarding the API I still didn't have time to start it, so it=
 will
> > > > > > > take a little longer than I antecipated.
> > > > >
> > > > > Ive just sent the patches adding support to switch the endpoints,=
 Ive
> > > > > only tested with a couple of sony headsets so I would appreciate =
if
> > > > > you guys could try it as well. Note that the SetConfiguration must
> > > > > come from the same D-Bus connection as the endpoint that would be
> > > > > used, also if there is already an stream in place it must also be=
 from
> > > > > the same client since it would be terminated in the process, this=
 is
> > > > > to prevent entities fighting to configure with its own priority t=
hough
> > > > > usually we only PA endpoints, if you want to bypass this just for=
 now
> > > >
> > > > Great! Once patches would be ready I would look at my last A2DP
> > > > pulseaudio patches [1] and would try to implement switching, includ=
ing
> > > > support for bi-directional FastStream codec -- which can benefit fr=
om
> > > > it.
> > > >
> > > > [1] - https://lists.freedesktop.org/archives/pulseaudio-discuss/201=
8-July/030344.html
> > >
> > > Hi! I applied your 6 patches from https://marc.info/?l=3Dlinux-blueto=
oth&r=3D1&b=3D201901&w=3D2
> > > but whatever I did I was not able to locate in dbus hierarchy list of
> > > A2DP codecs supported by device.
> > >
> > > I thought that somewhere in
> > >
> > > qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> > >
> > > I found A2DP codec capabilities...
> > >
> > > So how to get list of all supported A2DP codecs for particular device?
> >
> > Ah, I forgot to start bluetoothd with --experimental option. After that
> > I see sep*
> >
> > /
> > /org
> > /org/bluez
> > /org/bluez/hci0
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep3
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep5
> >
> > and qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1=
 org.freedesktop.DBus.Properties.GetAll org.bluez.MediaEndpoint1
> > list them correctly.
>=20
> You can use d-feet as well, btw did you forget to paste sep2 and sep4
> or the device just skip them?

No. This headset exports only sep1, sep3 and sep5. And supports SBC,
aptX and FastStream codecs. So count is correct, just numbering is not
canonical.

> Ive made sure not to filter any
> endpoints even if they would not have any matching local endpoints so
> we allow new endpoints to be registered later, anyway SetConfiguration
> actually checks that endpoints matches.
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
