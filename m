Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF6C282DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34393205ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwOTWl5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfDSSjb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41911 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbfDSSjb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id 64so4976842otb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J9eMv1mM1mFHgYrEmY8CjCThoVQi/44J5X8TvdqPKJ8=;
        b=SwOTWl5qdAstbY+MZR1L6PFqNOCwKu0NpQf8tE8snfPnPBUn0NCyzdcK6nPpJ10r5Y
         gU776fybRtDk9zS7TMAR06Kc9Cl9DGqMQGJ/f4SaxzwpRJPZ5YEpp4Xz0hjNDXdV/t3/
         AB2KEuzxr7fghLsevGPZMnS9+zj1upxtgjs3kciLp9df4lUXMjpfh8xbVTQLDmrIcPBI
         Qj2k0+pCW9tX2EugaAVFckG6WNat9t9Rww9gZx8fZVWq0Ly29H9fmMvfobn4R0khrHJP
         wlaDABomJMr/udJpNBPKD4p/arJ9rgN4B3F7OmRJHShL7ZZQwY1Tk4ADXHN72s/Urf0L
         xhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J9eMv1mM1mFHgYrEmY8CjCThoVQi/44J5X8TvdqPKJ8=;
        b=EFqNg2jiH7ggCv38kMhEl1ZN5gtssxKeTZyPnW/nnZ/QBOQ195djO5LQarFltcMaSs
         ktqwvLfg3p8RE5J4dvHAPv62BtuVYvrJ5/yAeAA9IugwE8+F3iy2Oc6Ib842gpi9QMXH
         FfuMLxZmnFv2+3VMYVbbl6sDhfJoW1YBHL5NYfHagAVqea58KQRiEaxmPXQGQmwkdoia
         GCoOd2/OLL5qbLlGTajhwZEAz6MOlyOlRIcCmC5HCf+/o8wcu1RpCMPnnsWtuLsqO8QB
         PzSPC+a65AsQptCirK9eJQGf5nrRpYhCd/kb6Ilczxxazk9y3QOXvspUqHYGEf84F8Ca
         hm9w==
X-Gm-Message-State: APjAAAVDwm7lWkJNrFlZiHG3ac9rOxLh+2sZ8zLtrd0o6ggN0dexlEBz
        yS+ocG3mNr973IgJ6Cgqi1SPtVxrBXQJcwL5ZBWAcvCR
X-Google-Smtp-Source: APXvYqxoRnavbBn3eH9zpszlHxCt1LWrc3xhamhPjMeKX7XU7WbW4Ad/zd9DHhGQ2lTDcK0fpZltAmnZlxTCUWxHQ8E=
X-Received: by 2002:a9d:618d:: with SMTP id g13mr1847493otk.254.1555674528632;
 Fri, 19 Apr 2019 04:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com> <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali> <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali> <20190327111430.6gliqodnnojsifjd@pali>
 <20190419080348.fbgs55qqs3j2yovb@pali> <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
 <20190419110159.7tec3yejhh4lnokb@pali>
In-Reply-To: <20190419110159.7tec3yejhh4lnokb@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Apr 2019 14:48:38 +0300
Message-ID: <CABBYNZLEGBErmSiJAUV=+6b1SvXh98ExiMmMDkh3p=MqP53gzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Apr 19, 2019 at 2:02 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Friday 19 April 2019 13:04:01 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > >
> > > On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > > > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrot=
e:
> > > > > > Hi Pali,
> > > > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gma=
il.com> wrote:
> > > > > > >
> > > > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wr=
ote:
> > > > > > > > Hi Pali,
> > > > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > >
> > > > > > > > > This adds the possibility to expose remote SEP using Medi=
aEndpoint
> > > > > > > > > interface to allow setting a configuration.
> > > > > > > > > ---
> > > > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > > > --- a/doc/media-api.txt
> > > > > > > > > +++ b/doc/media-api.txt
> > > > > > > > > @@ -500,14 +500,23 @@ Properties        object Player [re=
adonly]
> > > > > > > > >  MediaEndpoint1 hierarchy
> > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > >
> > > > > > > > > -Service                unique name
> > > > > > > > > +Service                unique name (Server role)
> > > > > > > > > +               org.bluez (Client role)
> > > > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > > > -Object path    freely definable
> > > > > > > > > +Object path    freely definable (Server role)
> > > > > > > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_=
XX_XX_XX_XX_XX/sepX
> > > > > > > > > +               (Client role)
> > > > > > > > >
> > > > > > > > >  Methods                void SetConfiguration(object tran=
sport, dict properties)
> > > > > > > > >
> > > > > > > > >                         Set configuration for the transpo=
rt.
> > > > > > > > >
> > > > > > > > > +                       For client role transport must be=
 set with a server
> > > > > > > > > +                       endpoint oject which will be conf=
igured and the
> > > > > > > > > +                       properties must contain the follo=
wing properties:
> > > > > > > > > +
> > > > > > > > > +                               array{byte} Capabilities
> > > > > > > > > +
> > > > > > > > >                 array{byte} SelectConfiguration(array{byt=
e} capabilities)
> > > > > > > > >
> > > > > > > > >                         Select preferable configuration f=
rom the supported
> > > > > > > > > @@ -532,6 +541,20 @@ Methods            void SetConfigura=
tion(object transport, dict properties)
> > > > > > > > >                         endpoint, because when this metho=
d gets called it has
> > > > > > > > >                         already been unregistered.
> > > > > > > > >
> > > > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > > > +
> > > > > > > > > +                       UUID of the profile which the end=
point is for.
> > > > > > > > > +
> > > > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > > > +
> > > > > > > > > +                       Assigned number of codec that the=
 endpoint implements.
> > > > > > > > > +                       The values should match the profi=
le specification which
> > > > > > > > > +                       is indicated by the UUID.
> > > > > > > > > +
> > > > > > > > > +               array{byte} Capabilities [readonly, optio=
nal]:
> > > > > > > > > +
> > > > > > > > > +                       Capabilities blob, it is used as =
it is so the size and
> > > > > > > > > +                       byte order must match.
> > > > > > > > >
> > > > > > > > >  MediaTransport1 hierarchy
> > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > --
> > > > > > > > > 2.17.2
> > > > > > > >
> > > > > > > > Can you try this set?
> > > > > > >
> > > > > > > Hi! In V3 you added only "a2dp: Add reverse discovery" patch =
right?
> > > > > > > I tested my setup also with this patch and there is no differ=
ence,
> > > > > > > pulseaudio is working fine :-)
> > > > > > >
> > > > > >
> > > > > > Applied.
> > > > >
> > > > > Hi! I have one bug report for these patches.
> > > > >
> > > > > When I manually disconnect A2DP profile, but let HFP active then =
all SEP
> > > > > paths on D-Bus disappear.
> > > > >
> > > > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX =
org.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb
> > > > >
> > > > > So pulseaudio would still see bluetooth device as active (because=
 HFP is
> > > > > in use), but does not see any A2DP codec as all remote SEPs from =
DBus
> > > > > were removed.
> > > > >
> > > > > It is possible to not remove remote SEPs when A2DP sink profile i=
s
> > > > > manually disconnected?
> > > >
> > > > Hi Luiz! Have you looked at above problem?
> > >
> > > Hi! This one problem is still there.
> >
> > This should have been fixed:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D9f7659a=
44601e043bdb6724b0ab4f3f59c46e9fe
>
> Hi! It is still not fixed. I have that commit applied (it is in master
> branch), but SEPs still disappears from dbus after calling
> DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb as described
> above; even HFP/HSP is still active.
>
> Can you reproduce that problem?

We remove the objects when we disconnect AVDTP, this is working as
intended as we don't want to initiate the connection directly from the
endpoint as those may have disappeared or changed to some other codec
while disconnected.

--=20
Luiz Augusto von Dentz
