Return-Path: <SRS0=jtTj=SW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B4C282E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 06:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E72208C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 06:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofEJ/HZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfDTGn2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Apr 2019 02:43:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38790 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDTGn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Apr 2019 02:43:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id a6so5331120oie.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5geVD91lNdsZHflJykgw0+xw+ZAKauDOc956hh2/OjQ=;
        b=ofEJ/HZKYQTuWZQtaQ0oVodfKvffs8XJJ8ClszEGrzlnrQMQEKfcLqorUdOiodnpps
         lQ/j0yvgMP7JSzUJPXC7ttCf1iUMe85ZAYlK/gaIOssFDiySDQWiM8rCtgm4Ko6Na0SB
         BYQxTi719MWP7LepQi4PigiN4LuwcqdNRh44sPi24+vNTRkZsODH3HfJrU1ri1GYe2ZY
         qxxDW3D5QLrkrMkCSItJrCV8T14a2ZgvZZ9rPK1f/p6oEG0UByCL7SQP7TUVNWklfr09
         /ScWVEn6OGaeIplcX3F+pIPB0sEDy5cxuXbJypgVXycOwrS6IVzUa/JBXnGZNl9iMT9P
         sZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5geVD91lNdsZHflJykgw0+xw+ZAKauDOc956hh2/OjQ=;
        b=r+eA7IB6JlhFjv2hizsXfcQUoWJU0ksnLgZRbrZV8tG263/FwS8PeiJgQXafibcp0C
         cv/N7sicJehtXG+ASwPBJ01QAWzCeELFkNBSSyOdIywPdA0lP6m4e5unC+gLzHcB3H7F
         yR/ySek06E6gcZYztI7yXYZe2ITm5bIZjKrKa4Z1+sOoUIE5krJco/7v4BLsc2k51z6E
         wvhC5zDmZklvsCWlIB5M88oKfMjgeVPUbBMx0r24oXjol0l89zncGBstXzL7FsNBexsA
         hK390wvXmyNEqxUFynPP7RNDi38VwVV+lWQuZzWJnMrdsWHA3m2YugXYW1U6W1raYUIH
         t7qw==
X-Gm-Message-State: APjAAAUMc2lC06jIWMpClUCxJjGkCkmdZaa9X058fyRDXLOw8jefBaSj
        uexwElUsj735RBOvPAOLegT82bG6emj6L5XaOC89Nmr+
X-Google-Smtp-Source: APXvYqzqp2O4WMIdSjyzgZaoAKtP5mKw5NYSNl/YeVCNleSntZA3hEa8N0z5eS9b3ld6AfMqIYvyBz9tKKxIlFqXaGE=
X-Received: by 2002:aca:47c2:: with SMTP id u185mr4042857oia.8.1555742607169;
 Fri, 19 Apr 2019 23:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com> <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali> <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali> <20190327111430.6gliqodnnojsifjd@pali>
 <20190419080348.fbgs55qqs3j2yovb@pali> <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
 <20190419110159.7tec3yejhh4lnokb@pali> <CABBYNZLEGBErmSiJAUV=+6b1SvXh98ExiMmMDkh3p=MqP53gzQ@mail.gmail.com>
 <20190419120455.ojjvok6cvp24jxd6@pali>
In-Reply-To: <20190419120455.ojjvok6cvp24jxd6@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 20 Apr 2019 09:43:17 +0300
Message-ID: <CABBYNZ+PAyJun4=3Rq0C-iKqhCeFKfUtVEgTBMNFu36HXh=amA@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 3:04 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Friday 19 April 2019 14:48:38 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Apr 19, 2019 at 2:02 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Friday 19 April 2019 13:04:01 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
> > > > >
> > > > > On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > > > > > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > > > > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz =
wrote:
> > > > > > > > Hi Pali,
> > > > > > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar=
@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dent=
z wrote:
> > > > > > > > > > Hi Pali,
> > > > > > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.co=
m>
> > > > > > > > > > >
> > > > > > > > > > > This adds the possibility to expose remote SEP using =
MediaEndpoint
> > > > > > > > > > > interface to allow setting a configuration.
> > > > > > > > > > > ---
> > > > > > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > > > > > --- a/doc/media-api.txt
> > > > > > > > > > > +++ b/doc/media-api.txt
> > > > > > > > > > > @@ -500,14 +500,23 @@ Properties        object Player=
 [readonly]
> > > > > > > > > > >  MediaEndpoint1 hierarchy
> > > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > >
> > > > > > > > > > > -Service                unique name
> > > > > > > > > > > +Service                unique name (Server role)
> > > > > > > > > > > +               org.bluez (Client role)
> > > > > > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > > > > > -Object path    freely definable
> > > > > > > > > > > +Object path    freely definable (Server role)
> > > > > > > > > > > +               [variable prefix]/{hci0,hci1,...}/dev=
_XX_XX_XX_XX_XX_XX/sepX
> > > > > > > > > > > +               (Client role)
> > > > > > > > > > >
> > > > > > > > > > >  Methods                void SetConfiguration(object =
transport, dict properties)
> > > > > > > > > > >
> > > > > > > > > > >                         Set configuration for the tra=
nsport.
> > > > > > > > > > >
> > > > > > > > > > > +                       For client role transport mus=
t be set with a server
> > > > > > > > > > > +                       endpoint oject which will be =
configured and the
> > > > > > > > > > > +                       properties must contain the f=
ollowing properties:
> > > > > > > > > > > +
> > > > > > > > > > > +                               array{byte} Capabilit=
ies
> > > > > > > > > > > +
> > > > > > > > > > >                 array{byte} SelectConfiguration(array=
{byte} capabilities)
> > > > > > > > > > >
> > > > > > > > > > >                         Select preferable configurati=
on from the supported
> > > > > > > > > > > @@ -532,6 +541,20 @@ Methods            void SetConfi=
guration(object transport, dict properties)
> > > > > > > > > > >                         endpoint, because when this m=
ethod gets called it has
> > > > > > > > > > >                         already been unregistered.
> > > > > > > > > > >
> > > > > > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > > > > > +
> > > > > > > > > > > +                       UUID of the profile which the=
 endpoint is for.
> > > > > > > > > > > +
> > > > > > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > > > > > +
> > > > > > > > > > > +                       Assigned number of codec that=
 the endpoint implements.
> > > > > > > > > > > +                       The values should match the p=
rofile specification which
> > > > > > > > > > > +                       is indicated by the UUID.
> > > > > > > > > > > +
> > > > > > > > > > > +               array{byte} Capabilities [readonly, o=
ptional]:
> > > > > > > > > > > +
> > > > > > > > > > > +                       Capabilities blob, it is used=
 as it is so the size and
> > > > > > > > > > > +                       byte order must match.
> > > > > > > > > > >
> > > > > > > > > > >  MediaTransport1 hierarchy
> > > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > --
> > > > > > > > > > > 2.17.2
> > > > > > > > > >
> > > > > > > > > > Can you try this set?
> > > > > > > > >
> > > > > > > > > Hi! In V3 you added only "a2dp: Add reverse discovery" pa=
tch right?
> > > > > > > > > I tested my setup also with this patch and there is no di=
fference,
> > > > > > > > > pulseaudio is working fine :-)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Applied.
> > > > > > >
> > > > > > > Hi! I have one bug report for these patches.
> > > > > > >
> > > > > > > When I manually disconnect A2DP profile, but let HFP active t=
hen all SEP
> > > > > > > paths on D-Bus disappear.
> > > > > > >
> > > > > > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX=
_XX org.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34f=
b
> > > > > > >
> > > > > > > So pulseaudio would still see bluetooth device as active (bec=
ause HFP is
> > > > > > > in use), but does not see any A2DP codec as all remote SEPs f=
rom DBus
> > > > > > > were removed.
> > > > > > >
> > > > > > > It is possible to not remove remote SEPs when A2DP sink profi=
le is
> > > > > > > manually disconnected?
> > > > > >
> > > > > > Hi Luiz! Have you looked at above problem?
> > > > >
> > > > > Hi! This one problem is still there.
> > > >
> > > > This should have been fixed:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D9f7=
659a44601e043bdb6724b0ab4f3f59c46e9fe
> > >
> > > Hi! It is still not fixed. I have that commit applied (it is in maste=
r
> > > branch), but SEPs still disappears from dbus after calling
> > > DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb as described
> > > above; even HFP/HSP is still active.
> > >
> > > Can you reproduce that problem?
> >
> > We remove the objects when we disconnect AVDTP, this is working as
> > intended as we don't want to initiate the connection directly from the
> > endpoint as those may have disappeared or changed to some other codec
> > while disconnected.
>
> That is a bit problematic. Pulseaudio see device as active when either
> A2DP or HFP/HSP profile is connected. It makes sense. But when A2DP is
> disconnected then bluez remove SEP from dbus which says to pulseaudio
> that all codecs (as they belongs to SEPs) are unsupported. Which leads
> to situation that pulseaudio has no idea which codecs are supported nor
> if A2DP is supported at all.

Usually, all audio profiles are connected simultaneously, we even have
a policy plugin to enforce this. Also keep in mind that we never
intend to PulseAudio to trigger connections, for that you use the
Bluetooth system settings.

> So if bluez remove all SEPs from dbus, how can pulseaudio again activate
> A2DP connection with codec X? It is impossible as SEP endpoint exported
> by dbus does not exist anymore.

It doesn't, if you want to reconnect that should be triggered via
Device.Connect, the daemon will remember the last connected SEP and do
the right thing, if the user wants to later overwrite the default it
is free to do so by selecting a different SEP. So, in short, it is a
design choice not to support connecting directly from SEP, anyway in
most cases that would not even be possible since the device should not
be connected PA would not list any audio device for it.


--=20
Luiz Augusto von Dentz
