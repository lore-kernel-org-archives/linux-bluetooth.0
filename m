Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC568C282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E5B20882
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKOJ7/yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA3MYZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:24:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45080 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3MYZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 07:24:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so20882844ota.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ZyFPhpjAUdxP9q7eq+5sfzAFfU/Sem54xvGYNVqWpU=;
        b=dKOJ7/yPnvoqVEBgbV4NcOfpGrJ0f5z+Q5FhwcXN8VzgSwKuZPsH6NNLQTYRSdnmz0
         OZeWDxf+jYNUS3mpHF8wDmnOEuTov/fvCeHiWX3Iw39JZY3j17QLCvrZI/EL8NJMDMu7
         Dd9Jnv0f9cyfHJ1zaYUwimKlA2Z/wapMALRrPkbb817iX3iL+z6LJvusXlkZRR6l60W9
         1t0VWsUZCIuqPW5KjM8WF3jwSw3pHfcZrMdBAgfQA47xuxtY+SByZ4fKp602AF3EPW+D
         MQwIG5l6Gl8gjIokGfXG44vk6yDpa0EA8Rt43a7ZcacnZWOBcqxcY323ZtEXejDW8ngu
         oeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ZyFPhpjAUdxP9q7eq+5sfzAFfU/Sem54xvGYNVqWpU=;
        b=HH/vf+HGKt+CZN74rTFbJG72zypfPH7o8ghrxVyvvwzZD3bcWSNxZJtis13okTe0xU
         EqZ9SufhipIJPp3bVQEBY/HRFYrlIl6wPCgmv0XPjVmoiFcHAABVHsffBV3q92YvUB9l
         rd4UrEc/CuwAusSa+CTsMgOk35ilBYwWhxcN8fDCsAmQbQOpaLTu2ifLDUt9bfxkvpBa
         oTcrAJ/N9OdE6Epl4R/wC42ffmKN4yIXhVClNmJB3YG2lY+pK2Phk+POIp+Ltvqi/RXT
         kqa3lvVYrvhW1TmZCQ3gIqZAwMUbaCHySOE8fum7iwipd2km1IrlvL1MVxqnc5SqdkIb
         5QGA==
X-Gm-Message-State: AJcUukd9ezwJr7WX1hp3iW/Pizo2QzaIsZYUI/K1ZphtR8jS4xoRTHne
        WKY61+Trku3crBAJ/0QX2Mt7YUtPxJ4dUQ3hhLc=
X-Google-Smtp-Source: ALg8bN7mDNkA6THsZKA2xDoxwT/H0LYmaoOSyROusjbG3RRtQBmih+ER0fs8lxhqW0EO3WQWm0kdxtPm3wpxbgPvOQc=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr21969369otf.52.1548851063503;
 Wed, 30 Jan 2019 04:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20190123174504.12350-1-pali.rohar@gmail.com> <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali> <20190130081517.GI32745@reaktio.net> <20190130120631.usx67zjk4kmbhcla@pali>
In-Reply-To: <20190130120631.usx67zjk4kmbhcla@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 30 Jan 2019 14:24:11 +0200
Message-ID: <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali, Pasi,
On Wed, Jan 30, 2019 at 2:09 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Wednesday 30 January 2019 10:15:17 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Roh=C3=A1r wrote:
> > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > Hi Pali,
> > > >
> > > > > ---
> > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++=
++++++++++---
> > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > index 18569c895..a21410f5a 100644
> > > > > --- a/tools/parser/avdtp.c
> > > > > +++ b/tools/parser/avdtp.c
> > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, u=
int16_t vndcodec)
> > > > > {
> > > > >         if (vendor =3D=3D 0x0000004f && vndcodec =3D=3D 0x0001)
> > > > >                 return "aptX";
> > > > > +       else if (vendor =3D=3D 0x0000000a && vndcodec =3D=3D 0x00=
01)
> > > > > +               return "FastStream";
> > > > > +       else if (vendor =3D=3D 0x0000000a && vndcodec =3D=3D 0x00=
02)
> > > > > +               return "aptX Low Latency";
> > > > > +       else if (vendor =3D=3D 0x000000d7 && vndcodec =3D=3D 0x00=
24)
> > > > > +               return "aptX HD";
> > > > >         else if (vendor =3D=3D 0x0000012d && vndcodec =3D=3D 0x00=
aa)
> > > > >                 return "LDAC";
> > > > >         return "Unknown???;
> > > >
> > > > lets keep the focus on btmon support since nobody should be using h=
cidump anymore.
> > >
> > > In btmon I already implemented it and patches are now merged. I just
> > > found another place where this capability parsing is implemented and
> > > based on fact that users still use hcidump I quickly looked at it and
> > > implemented this parsing.
> > >
> >
> > I agree, hcidump still comes up on many places (guides, blogs, mailingl=
ist posts, etc),
> > so it makes sense to add these patches to hcidump aswell. Especially wh=
en the patch is quite small.
>
> Exactly, people still use hcidump...

Well it is a deprecated tool which we might remove starting on BlueZ
6.x which we would like to do in the very next release, if that
doesn't happen than perhaps Id take these patches in for a very last
BlueZ 5.x release.

@Marcel: Or you have a better plan? We could do one last 5.x and then
start working on removing the deprecated tools/etc.

> >
> > > > Regards
> > > >
> > > > Marcel
> > > >
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >
> >
> > -- Pasi
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
