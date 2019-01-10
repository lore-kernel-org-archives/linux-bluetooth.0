Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36629C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 11:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048D4206B6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 11:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD2/Qzd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAJL3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:29:15 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42840 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAJL3P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 06:29:15 -0500
Received: by mail-oi1-f174.google.com with SMTP id w13so8959812oiw.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R4AHf9uQ3NLy23xBTJJXEkpepLEmWncTH1KK3FvIhK4=;
        b=uD2/Qzd6iFGlCXSzB9APiqQYKHqUy1fzfyMRl4OKMWADmL09//+5Gexr36ix0guUTQ
         3wDxkN2b44ob/Doy8sWSS/+488jfI26Do5lnNmYhPNQ6OOslKUdLlTb7jz2bK+Lp87lL
         6zkrgzs+VpQgfS4JwZaNlZTYPjLIqaHKBf5FHtN5hV5mmqhmFv59kCI519OCEcTHWGx0
         Qzmna2VdXMgffh//JrvrtekII725rfY0X7B8xrqEEUypYRyIC7NdF7aUs+CXv/pnzL/z
         UNxJD1KXDhy1a1/MVoaGaDAnvAAMCNh9A5GF+niTzBJmPN7MvIdOAFM3FcrbG97OhtNo
         09Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R4AHf9uQ3NLy23xBTJJXEkpepLEmWncTH1KK3FvIhK4=;
        b=KmbCxrtPBiOPmEpyRZNnT5/oLsNTUD0/pCqP9tb4wITav9+yPJnkKHJGUrIWNwffPF
         k4spZi5vhTkSNbobcU6Pwb82jfyZxp1A+a0vxT7QCf5PkcK/NWy/T/mM6r+l8rwu5KVt
         aCbNDi6Lk7DSi+NelwC4JC3U4lUB+bFyvGUE6iGux2iSx/s7zn8eLFyvG+9bQvMOfGEk
         OeBqXB7Y/+aX6duwkhRtiQ5jyUT3c+V595ZyH22nH2GKijLV5Cpgp2MKMh6kThi+mV86
         88fKwoIRvqbXs1mIIQv/feOd5n9B/I4z9VgJvNqOp2WcFrV1lgl+MTRyPzrI8NQ5VdEn
         8cdg==
X-Gm-Message-State: AJcUukfQ4nr6cD1aGbJHrgyliMEG5Zkl6wkOqYi8p7/5qtXLzCeeWbCG
        A/wUz4qyBLU3Dl4QE+UgPChozF+bQBqyhC37boYxFaci
X-Google-Smtp-Source: ALg8bN47EIoBQdkaCD+lyLvmpgoy6ZL5XAQ8sc+JBfLCEjLYA43e6h1fpJK6NAjYMRzuKb0KN/1KI2d3DFsmB+7Xb5Q=
X-Received: by 2002:aca:aa0d:: with SMTP id t13mr6537007oie.273.1547119754639;
 Thu, 10 Jan 2019 03:29:14 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali> <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net> <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali> <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
 <20190108165612.5krhgtmce336xjx3@pali> <20190109180340.5fh7adag6buij4px@pali> <20190109181436.atlbhkqclpq3kcta@pali>
In-Reply-To: <20190109181436.atlbhkqclpq3kcta@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Jan 2019 08:29:02 -0300
Message-ID: <CABBYNZJk=wycGzic5+DqFHg=30KX9NNwnZMpsVdgkLjzseMA2g@mail.gmail.com>
Subject: Re: bluez: dbus method call for switching endpoint
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Jan 9, 2019 at 3:14 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Wednesday 09 January 2019 19:03:40 Pali Roh=C3=A1r wrote:
> > On Tuesday 08 January 2019 17:56:12 Pali Roh=C3=A1r wrote:
> > > On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> > > > > > Regarding the API I still didn't have time to start it, so it w=
ill
> > > > > > take a little longer than I antecipated.
> > > >
> > > > Ive just sent the patches adding support to switch the endpoints, I=
ve
> > > > only tested with a couple of sony headsets so I would appreciate if
> > > > you guys could try it as well. Note that the SetConfiguration must
> > > > come from the same D-Bus connection as the endpoint that would be
> > > > used, also if there is already an stream in place it must also be f=
rom
> > > > the same client since it would be terminated in the process, this i=
s
> > > > to prevent entities fighting to configure with its own priority tho=
ugh
> > > > usually we only PA endpoints, if you want to bypass this just for n=
ow
> > >
> > > Great! Once patches would be ready I would look at my last A2DP
> > > pulseaudio patches [1] and would try to implement switching, includin=
g
> > > support for bi-directional FastStream codec -- which can benefit from
> > > it.
> > >
> > > [1] - https://lists.freedesktop.org/archives/pulseaudio-discuss/2018-=
July/030344.html
> >
> > Hi! I applied your 6 patches from https://marc.info/?l=3Dlinux-bluetoot=
h&r=3D1&b=3D201901&w=3D2
> > but whatever I did I was not able to locate in dbus hierarchy list of
> > A2DP codecs supported by device.
> >
> > I thought that somewhere in
> >
> > qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> >
> > I found A2DP codec capabilities...
> >
> > So how to get list of all supported A2DP codecs for particular device?
>
> Ah, I forgot to start bluetoothd with --experimental option. After that
> I see sep*
>
> /
> /org
> /org/bluez
> /org/bluez/hci0
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep3
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep5
>
> and qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 o=
rg.freedesktop.DBus.Properties.GetAll org.bluez.MediaEndpoint1
> list them correctly.

You can use d-feet as well, btw did you forget to paste sep2 and sep4
or the device just skip them? Ive made sure not to filter any
endpoints even if they would not have any matching local endpoints so
we allow new endpoints to be registered later, anyway SetConfiguration
actually checks that endpoints matches.

--=20
Luiz Augusto von Dentz
