Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70507C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435F5208C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJowusiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfFGPSP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:18:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37566 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfFGPSP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:18:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so2182579otd.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G7aVRk2Ge363S575gy4QB7G8NGmja2hNrew46x90zos=;
        b=GJowusiz7ag2NZMg6SbkvcPAI5oFDHmARydA+oJz3V37EfT0w+ihrHJA6yTTgWRy32
         r2kObH9+s0I5gytqE7coMuhXKiKAfYbmR5QCc4bP3bHNRJ5yQVBbN0OCj3EaVJdV1sRL
         uqdUdrA1Hpr3pw6hKZ2ocOz0tbUBxr2GXOmKUsF+NmeISvSm2lVUc2abQHmlqqAhz7z5
         vkBZP4aQQT5qbhSkJbUVXnCuYRkyPKgssegK1RKk+EP3yCs7IBygJvrY8ePs8WloOTU2
         FSwT+YH3XBZ+oCmp+cqfIDGoMDUAi1DhPhY5eyxDnYKq2mqNBEv20UdwwH+1HcwkoFM4
         3BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G7aVRk2Ge363S575gy4QB7G8NGmja2hNrew46x90zos=;
        b=fvp0tzBGHSBG01UZ+TUyXe5OuLF+Oy48tjSM5SOIA+5H/nKgvvGjYVeUep+2KKNRwh
         0O6ocvKyITUmXQgonLqmmA/lWlM+nHEdevk28ByglRHxKr1yIDcmrwi9UCW+7+MHTTLx
         RJv3NCR+aHornzjZTFMbtFP6zVtQYRLlHgAkwiXDLJ5LEweGHZ0uEWBjAFtdxuroOhAu
         c42AZjrlH7i3h8iKHjH2Xrzp0DdqBPQlaNMxvAmj0CFDh4Gipt7OfueeV+Bj79IZLETC
         9vwohiJufE1XsTaYAzL8z/304tvGzoxXP1OEpqIMYBgMFYveBMmzPL6acgE9qUIfAPc2
         V/dA==
X-Gm-Message-State: APjAAAW1joSLaZTPj3PCSaQ5WxM+A9lzAimeebhTq0ygo04ZopEX+S7P
        MWSjWQClN4hg0I966ffqXwnTTJMHWn0gbVhxvGs=
X-Google-Smtp-Source: APXvYqxAUQz80+bNOd2HW2GdbYQJiFAy89xO5hIan/2SQmzAdbrabNolOvc3MATIwi3sSLljq6Q2ECbS7esugQlHrOw=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr5700680ota.79.1559920694361;
 Fri, 07 Jun 2019 08:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190506124310.19151-1-luiz.dentz@gmail.com> <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali> <20190507085255.zplj5ddopl3z5n2v@pali>
 <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
 <20190507185740.ywubjwgm7mer7txf@pali> <20190607130434.lw5vfapnkflp65cq@pali>
In-Reply-To: <20190607130434.lw5vfapnkflp65cq@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jun 2019 18:18:04 +0300
Message-ID: <CABBYNZJyviu4CRjS616nakNkGZjQkwDto8=pmWdX8TFiNCD05Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jun 7, 2019 at 4:04 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Tuesday 07 May 2019 20:57:40 Pali Roh=C3=A1r wrote:
> > On Tuesday 07 May 2019 13:13:17 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Tue, May 7, 2019 at 11:52 AM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > On Monday 06 May 2019 15:02:25 Pali Roh=C3=A1r wrote:
> > > > > On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > I hope this fixes the problems you have been seeing, it should =
at
> > > > > > least take care of the issues with wrong order of SelectConfigu=
ration
> > > > > > and restoring the exact same endpoint used last time.
> > > > >
> > > > > Hi Luiz! Great, this should make bluez to be more deterministic.
> > > >
> > > > Hi! Now I looked at it and in cache file I see:
> > > >
> > > > LastUsed=3D04:01
> > > >
> > > > What would happen when A2DP application (e.g. pulseaudio) register =
DBus
> > > > endpoints in different order? Or e.g. do not register some endpoint=
s due
> > > > to missing codec librayr (aptX).
> > > >
> > > > I guess that in this case LastUsed information stops working...
> > >
> > > It would most likely fail at SelectConfiguration and then try with th=
e
> > > other endpoints.
> >
> > Yes, that is truth. My point is just about validity of LastUsed value.
> >
> > > >
> > > > Should not be there stored rather dbus endpoint name identifier?
> > >
> > > Originally I tried to avoid having the local endpoints because of thi=
s
> > > problem, but now that SelectConfiguration can fail it shouldn't reall=
y
> > > be a problem. At least with the seid if you have a system that didn't
> > > changed the order or number of endpoints it will keep working as
> > > expected,
> >
> > But this may happen. And such thing is allowed. Any application,
> > including unprivileged can register own new endpoint to bluez. It is no=
t
> > specific to pulseaudio. And in my opinion central bluetooth daemon whic=
h
> > expose such functionality should be robust and be prepared that
> > application on "other side of dbus IPC" does not have to be well
> > behaved.
> >
> > > if we choose to encode the D-Bus connection, etc, as soon as
> > > PA is restarted, the system is rebooted, etc, the D-Bus connection ma=
y
> > > have changed making the stored values in LastUsed invalid.
> >
> > That is truth.
> >
> > My idea was to encode just dbus path of local dbus endpoint. We can say
> > (in IPC API) that client application should preserve dbus path for one
> > same endpoint between dbus daemon / computer restarts. Because otherwis=
e
> > functionality of "choose last used endpoint" would not work.
> >
> > This is less strict requirement and current one (that registration orde=
r
> > of all existing applications in system must be same across reboots),
> > less error prone and still should be easily implemented.
>
> So what about this my idea? Is there anything wrong with such thing?

That makes the assumption that the path doesn't ever change which is
something we never required for the endpoints, besides can be clashes
if the same path is used in which case the stored value would be
ambiguous, so I prefer to just have the endpoint id, if we are so
eager to detect endpoint changes we can save some hash/unique id
generated but I think it is a bit overkill if this is working as it
currently is and we can always fallback if we cannot recover the last
used, anyway this is not even supported by the spec since it has no
guarantees regarding peers endpoints uniqueness.

> > > Anyway
> > > chances are the LastUsed is only invalidated if you update PA, in
> >
> > Or once we include support for dynamic codec loading (based on encoder
> > library presence in system), installation of any irrelevant application
> > may bring a new supported codec and therefore a new endpoint. So codecs
> > can become in any order...
> >
> > Or another example, when different application (not PA) register also
> > some endpoint.
> >
> > > which case there could be new endpoints or a change in their order an=
d
> > > package can also provide a script to clear the LastUsed if that
> > > happens, but then again LastUsed setting does not actually store the
> > > configuration just the endpoint so SelectConfiguration has control
> > > over the configuration.
> >
> > Yes, whole thing is only about initial codec selection. In the worst
> > case user would have pre-selected different codec as which was last
> > used.
> >
> > But I think that storing dbus path of endpoint as described above shoul=
d
> > be more reliable solution.
> >
> > Applications (e.g. PA) talking to bluetooth daemon does not register or
> > request directly SEID. Instead they register their dbus path and dbus
> > connection and bluetooth daemon later allocates SEID for that path.
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
