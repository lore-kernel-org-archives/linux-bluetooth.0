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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC20DC282DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DB521855
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtlSQwbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfDTHb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:31:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45321 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTHbZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Apr 2019 03:31:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so5350208oia.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2019 00:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wpbGDdHDkE0oRf8s+Ua0l67WFTaOua3dEnl3hJfkMNI=;
        b=WtlSQwbUhBZdYU6aFGinSMuQn9ZrXbhRYvY+f7JolwBJAVWvI1+L55ECNZs8jJjb/y
         oQeNcAMw+yxBz10Ns4VbodHwNiaheQjhh7/MUU7EaKVmI80Lrhc1QZGzTBXv1hoUO3RR
         WHcEVdGAIQ2mkkIg123VUOLcP6BgJRgpTpmb1rdTKhi7zYMnFRhR8pAadnIkMk6kj10j
         Gjc55qQh47940CD7E5xqXCt3GrgdAKW0s1cStGdRYjxplDkUufntqHQtKeDEHh7zBPGp
         6l8C6h77yVBFUDSkQ5MbES4ZDojZ5vtrSB/XOB499Cl14/3+DaVySVZA9+jRqoViDJvz
         Rqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wpbGDdHDkE0oRf8s+Ua0l67WFTaOua3dEnl3hJfkMNI=;
        b=INJE4kE+ACmRCGb1rjtk6PlpF/+z41q/jLHq5Xlp9/VszojaLNiAuXvGq846mPpHMP
         UiFRlJb2AMzb+Z239GPf3zNPey2BFi8syHm/l9bHlDEQ49jMBUxbnZihtKVgY6zfRcmE
         sjfo9ITMZJi+YAhB8GAq1zFo3CclHoqZ5Q/iRNQcpQ+VcBLQfuhVWclgkCr2pe6424Dw
         aT00+pl/O0oAdxfJY4A6Fhj6KmGqIqqaEJBTY4Dxj5od0gbG16Kw8Y7sBU1ez+H2JByo
         tis9wgsGat/8DWYcbtYDj8t0r4f/GdEWDLE4svfJ0oQOsoiR2R0soWQGD4Ftwrt6ahTz
         0udA==
X-Gm-Message-State: APjAAAUEIVhfGxCMyj7bSWOc0T3KJ/l8H3DQ31PL7aMQSjEGTGQGWURs
        P7xmuH3UT8ly8tffJr+tiI90OZEewJE9kk22Fck=
X-Google-Smtp-Source: APXvYqyHzLLzHdMR+IehH41eK2moVmctRNlKLeU+6vFhfGW/AqxB0d7/jGxYiDpJZWciixZwzcNZJiNSBFOyrvk6ERg=
X-Received: by 2002:aca:47c2:: with SMTP id u185mr4114628oia.8.1555745484191;
 Sat, 20 Apr 2019 00:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190122175622.dj6riiim6zukpetw@pali> <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali> <20190327111430.6gliqodnnojsifjd@pali>
 <20190419080348.fbgs55qqs3j2yovb@pali> <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
 <20190419110159.7tec3yejhh4lnokb@pali> <CABBYNZLEGBErmSiJAUV=+6b1SvXh98ExiMmMDkh3p=MqP53gzQ@mail.gmail.com>
 <20190419120455.ojjvok6cvp24jxd6@pali> <CABBYNZ+PAyJun4=3Rq0C-iKqhCeFKfUtVEgTBMNFu36HXh=amA@mail.gmail.com>
 <20190420070058.3wn2ikabgrtmgqze@pali>
In-Reply-To: <20190420070058.3wn2ikabgrtmgqze@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 20 Apr 2019 10:31:14 +0300
Message-ID: <CABBYNZ+QKNc=1+gX6n6pY+k5rXAARKBQ+yjXovud1Fvw9AzgPw@mail.gmail.com>
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

On Sat, Apr 20, 2019 at 10:01 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Saturday 20 April 2019 09:43:17 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Apr 19, 2019 at 3:04 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Friday 19 April 2019 14:48:38 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Fri, Apr 19, 2019 at 2:02 PM Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
> > > > >
> > > > > On Friday 19 April 2019 13:04:01 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > > > > > > > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > > > > > > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von De=
ntz wrote:
> > > > > > > > > > Hi Pali,
> > > > > > > > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.r=
ohar@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von =
Dentz wrote:
> > > > > > > > > > > > Hi Pali,
> > > > > > > > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von De=
ntz
> > > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@inte=
l.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > This adds the possibility to expose remote SEP us=
ing MediaEndpoint
> > > > > > > > > > > > > interface to allow setting a configuration.
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++=
--
> > > > > > > > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.tx=
t
> > > > > > > > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > > > > > > > --- a/doc/media-api.txt
> > > > > > > > > > > > > +++ b/doc/media-api.txt
> > > > > > > > > > > > > @@ -500,14 +500,23 @@ Properties        object Pl=
ayer [readonly]
> > > > > > > > > > > > >  MediaEndpoint1 hierarchy
> > > > > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > >
> > > > > > > > > > > > > -Service                unique name
> > > > > > > > > > > > > +Service                unique name (Server role)
> > > > > > > > > > > > > +               org.bluez (Client role)
> > > > > > > > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > > > > > > > -Object path    freely definable
> > > > > > > > > > > > > +Object path    freely definable (Server role)
> > > > > > > > > > > > > +               [variable prefix]/{hci0,hci1,...}=
/dev_XX_XX_XX_XX_XX_XX/sepX
> > > > > > > > > > > > > +               (Client role)
> > > > > > > > > > > > >
> > > > > > > > > > > > >  Methods                void SetConfiguration(obj=
ect transport, dict properties)
> > > > > > > > > > > > >
> > > > > > > > > > > > >                         Set configuration for the=
 transport.
> > > > > > > > > > > > >
> > > > > > > > > > > > > +                       For client role transport=
 must be set with a server
> > > > > > > > > > > > > +                       endpoint oject which will=
 be configured and the
> > > > > > > > > > > > > +                       properties must contain t=
he following properties:
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +                               array{byte} Capab=
ilities
> > > > > > > > > > > > > +
> > > > > > > > > > > > >                 array{byte} SelectConfiguration(a=
rray{byte} capabilities)
> > > > > > > > > > > > >
> > > > > > > > > > > > >                         Select preferable configu=
ration from the supported
> > > > > > > > > > > > > @@ -532,6 +541,20 @@ Methods            void SetC=
onfiguration(object transport, dict properties)
> > > > > > > > > > > > >                         endpoint, because when th=
is method gets called it has
> > > > > > > > > > > > >                         already been unregistered=
.
> > > > > > > > > > > > >
> > > > > > > > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +                       UUID of the profile which=
 the endpoint is for.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +                       Assigned number of codec =
that the endpoint implements.
> > > > > > > > > > > > > +                       The values should match t=
he profile specification which
> > > > > > > > > > > > > +                       is indicated by the UUID.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               array{byte} Capabilities [readonl=
y, optional]:
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +                       Capabilities blob, it is =
used as it is so the size and
> > > > > > > > > > > > > +                       byte order must match.
> > > > > > > > > > > > >
> > > > > > > > > > > > >  MediaTransport1 hierarchy
> > > > > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.17.2
> > > > > > > > > > > >
> > > > > > > > > > > > Can you try this set?
> > > > > > > > > > >
> > > > > > > > > > > Hi! In V3 you added only "a2dp: Add reverse discovery=
" patch right?
> > > > > > > > > > > I tested my setup also with this patch and there is n=
o difference,
> > > > > > > > > > > pulseaudio is working fine :-)
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Applied.
> > > > > > > > >
> > > > > > > > > Hi! I have one bug report for these patches.
> > > > > > > > >
> > > > > > > > > When I manually disconnect A2DP profile, but let HFP acti=
ve then all SEP
> > > > > > > > > paths on D-Bus disappear.
> > > > > > > > >
> > > > > > > > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_X=
X_XX_XX org.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9=
b34fb
> > > > > > > > >
> > > > > > > > > So pulseaudio would still see bluetooth device as active =
(because HFP is
> > > > > > > > > in use), but does not see any A2DP codec as all remote SE=
Ps from DBus
> > > > > > > > > were removed.
> > > > > > > > >
> > > > > > > > > It is possible to not remove remote SEPs when A2DP sink p=
rofile is
> > > > > > > > > manually disconnected?
> > > > > > > >
> > > > > > > > Hi Luiz! Have you looked at above problem?
> > > > > > >
> > > > > > > Hi! This one problem is still there.
> > > > > >
> > > > > > This should have been fixed:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=
=3D9f7659a44601e043bdb6724b0ab4f3f59c46e9fe
> > > > >
> > > > > Hi! It is still not fixed. I have that commit applied (it is in m=
aster
> > > > > branch), but SEPs still disappears from dbus after calling
> > > > > DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb as describ=
ed
> > > > > above; even HFP/HSP is still active.
> > > > >
> > > > > Can you reproduce that problem?
> > > >
> > > > We remove the objects when we disconnect AVDTP, this is working as
> > > > intended as we don't want to initiate the connection directly from =
the
> > > > endpoint as those may have disappeared or changed to some other cod=
ec
> > > > while disconnected.
> > >
> > > That is a bit problematic. Pulseaudio see device as active when eithe=
r
> > > A2DP or HFP/HSP profile is connected. It makes sense. But when A2DP i=
s
> > > disconnected then bluez remove SEP from dbus which says to pulseaudio
> > > that all codecs (as they belongs to SEPs) are unsupported. Which lead=
s
> > > to situation that pulseaudio has no idea which codecs are supported n=
or
> > > if A2DP is supported at all.
> >
> > Usually, all audio profiles are connected simultaneously, we even have
> > a policy plugin to enforce this. Also keep in mind that we never
> > intend to PulseAudio to trigger connections, for that you use the
> > Bluetooth system settings.
>
> Look, I'm able to achieve state when A2DP is not connected and HFP/HSP
> is. Only via public dbus API. So such thing is possible and it could be
> available in the future in some program (command line or bluetooth gui).
>
> And as this state is not only possible, but also valid then pulseaudio
> needs to deal with it.
>
> And as you wrote that pulseaudio should not trigger connection, how it
> should know list of available codecs?

User just have to connect A2DP, Bluetooth settings should know it is
not connected, it is a user action after all.

> > > So if bluez remove all SEPs from dbus, how can pulseaudio again activ=
ate
> > > A2DP connection with codec X? It is impossible as SEP endpoint export=
ed
> > > by dbus does not exist anymore.
> >
> > It doesn't, if you want to reconnect that should be triggered via
> > Device.Connect, the daemon will remember the last connected SEP and do
> > the right thing, if the user wants to later overwrite the default it
> > is free to do so by selecting a different SEP.
>
> A2DP is connected, HSP is. Currently HSP audio output is used in
> pulseaudio and user want to switch it to codec X. bluez has remembered
> codec Y (but this information is not available to pulseaudio).
>
> How should now pulseaudio activate A2DP with codec X?
>
> > So, in short, it is a
> > design choice not to support connecting directly from SEP, anyway in
> > most cases that would not even be possible since the device should not
> > be connected PA would not list any audio device for it.
>
> If device is not connected then pulseaudio does not list audio device.
>
> But if HSP is connected and A2DP not, then pulseaudio show that
> bluetooth audio device.

User has to connect A2DP and then he has to option to switch to
whatever codec that has been discovered, as I said this is a design
choice, we don't want to duplicate controls.

--=20
Luiz Augusto von Dentz
