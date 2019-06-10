Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE880C282DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884C92085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 13:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDS7qD8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfFJNCs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:02:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41402 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389169AbfFJNCs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 09:02:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id 107so8183632otj.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2019 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TiUOwP0jczQ4Ll1lsznhUvyfF3vRcu8ajaiSow6WHmw=;
        b=RDS7qD8bcxZXoQcBarZ/jRKQbtTLSSWo5TG3vxhyEdff05mIhXNc0ot2UAwLNs6A04
         k28xn6VceIO37NfAYAW89aG9mnCA8de0rxg1AeVSauYtY17+iZSf4N7SgND/v6P7pHOR
         M20kioCAKGMOhViyMjqZR+YtPjhibAznyPgqR+vWQWT0dTggLVZ5rBhMoO4wR5yd8qIO
         98fzhUdGsvvhSW+/dzl007atD6epO9fmdNgF8LrTOgsU2gcp3qJ3yfmspQIu58jUsc+v
         jhZX9M5qLi1XwCUnF1Ng2p2454zuA4vl3xByvzKa+qKMbkTjNxU9tIdeaQN0VTJXWHh7
         K7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TiUOwP0jczQ4Ll1lsznhUvyfF3vRcu8ajaiSow6WHmw=;
        b=VoyND8bmw4r3IvXzkrykGlz8Gfb5Y7XJuYqXO7Ykq1yNBa3bydJqHrBINzGP9WGZw9
         58v+/6xRRw9op2Q0mKr1G/9TkWLTWJBUm1eBUU0qvJmxPbDUmjt5L85pevq1zo24h7PL
         HuqC7qsE8y9OEyb9+vEuWnAjFjQ9IjNrKvpVjXPd6kxITvIzHv9Bd4wGdU2+aSPj1nmo
         X8GFaU0nple4APJDIgf7bRAosVBkr1VSINwaZUHYvNBNd6kM2Dya/IVpu8kkG2ph7ABe
         ItX/ktaKpRJIDpnw0eiOxXHte6D+2GEE21aREyo1We3VnUHGO/wqwoMUnLX5HmJWoHBp
         /InA==
X-Gm-Message-State: APjAAAXWhkrsRiGhjt0vLcDhUZu0llFlfqjgrP8raIEhSibw4qQxEYnQ
        GHUWxCKcFMtXirF5GZPkxxpUWV8u6LtzeNS6nmSf3Xebq+Y=
X-Google-Smtp-Source: APXvYqw9T1Fqi4IpG9sLtsaA/ttIpIECxXubmPcu+t37TDkb9YvzA2ZSSAsg8xLgPg2hYPjz8fMsejc7B8ilLe1xXSc=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr16455492ota.79.1560171766829;
 Mon, 10 Jun 2019 06:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190506124310.19151-1-luiz.dentz@gmail.com> <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali> <20190507085255.zplj5ddopl3z5n2v@pali>
 <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
 <20190507185740.ywubjwgm7mer7txf@pali> <20190607130434.lw5vfapnkflp65cq@pali>
 <CABBYNZJyviu4CRjS616nakNkGZjQkwDto8=pmWdX8TFiNCD05Q@mail.gmail.com> <20190610123518.iytoko5ep7iwk7fw@pali>
In-Reply-To: <20190610123518.iytoko5ep7iwk7fw@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Jun 2019 16:02:34 +0300
Message-ID: <CABBYNZL5FNXLCJ+zgzTHhznKCbU5gJ4oWw6Cn4L0zT-mYmmkmw@mail.gmail.com>
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

On Mon, Jun 10, 2019 at 3:35 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Friday 07 June 2019 18:18:04 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Jun 7, 2019 at 4:04 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Tuesday 07 May 2019 20:57:40 Pali Roh=C3=A1r wrote:
> > > > On Tuesday 07 May 2019 13:13:17 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Tue, May 7, 2019 at 11:52 AM Pali Roh=C3=A1r <pali.rohar@gmail=
.com> wrote:
> > > > > >
> > > > > > On Monday 06 May 2019 15:02:25 Pali Roh=C3=A1r wrote:
> > > > > > > On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > > > > > > > Hi Pali,
> > > > > > > >
> > > > > > > > I hope this fixes the problems you have been seeing, it sho=
uld at
> > > > > > > > least take care of the issues with wrong order of SelectCon=
figuration
> > > > > > > > and restoring the exact same endpoint used last time.
> > > > > > >
> > > > > > > Hi Luiz! Great, this should make bluez to be more determinist=
ic.
> > > > > >
> > > > > > Hi! Now I looked at it and in cache file I see:
> > > > > >
> > > > > > LastUsed=3D04:01
> > > > > >
> > > > > > What would happen when A2DP application (e.g. pulseaudio) regis=
ter DBus
> > > > > > endpoints in different order? Or e.g. do not register some endp=
oints due
> > > > > > to missing codec librayr (aptX).
> > > > > >
> > > > > > I guess that in this case LastUsed information stops working...
> > > > >
> > > > > It would most likely fail at SelectConfiguration and then try wit=
h the
> > > > > other endpoints.
> > > >
> > > > Yes, that is truth. My point is just about validity of LastUsed val=
ue.
> > > >
> > > > > >
> > > > > > Should not be there stored rather dbus endpoint name identifier=
?
> > > > >
> > > > > Originally I tried to avoid having the local endpoints because of=
 this
> > > > > problem, but now that SelectConfiguration can fail it shouldn't r=
eally
> > > > > be a problem. At least with the seid if you have a system that di=
dn't
> > > > > changed the order or number of endpoints it will keep working as
> > > > > expected,
> > > >
> > > > But this may happen. And such thing is allowed. Any application,
> > > > including unprivileged can register own new endpoint to bluez. It i=
s not
> > > > specific to pulseaudio. And in my opinion central bluetooth daemon =
which
> > > > expose such functionality should be robust and be prepared that
> > > > application on "other side of dbus IPC" does not have to be well
> > > > behaved.
> > > >
> > > > > if we choose to encode the D-Bus connection, etc, as soon as
> > > > > PA is restarted, the system is rebooted, etc, the D-Bus connectio=
n may
> > > > > have changed making the stored values in LastUsed invalid.
> > > >
> > > > That is truth.
> > > >
> > > > My idea was to encode just dbus path of local dbus endpoint. We can=
 say
> > > > (in IPC API) that client application should preserve dbus path for =
one
> > > > same endpoint between dbus daemon / computer restarts. Because othe=
rwise
> > > > functionality of "choose last used endpoint" would not work.
> > > >
> > > > This is less strict requirement and current one (that registration =
order
> > > > of all existing applications in system must be same across reboots)=
,
> > > > less error prone and still should be easily implemented.
> > >
> > > So what about this my idea? Is there anything wrong with such thing?
> >
> > That makes the assumption that the path doesn't ever change which is
> > something we never required for the endpoints, besides can be clashes
> > if the same path is used in which case the stored value would be
> > ambiguous, so I prefer to just have the endpoint id, if we are so
> > eager to detect endpoint changes we can save some hash/unique id
> > generated but I think it is a bit overkill if this is working as it
> > currently is and we can always fallback if we cannot recover the last
> > used, anyway this is not even supported by the spec since it has no
> > guarantees regarding peers endpoints uniqueness.
>
> My main objection against endpoint id is that it is less stable then
> application dbus path. Endpoint id depends on ordering which is defined
> by all application which registers to dbus. And so it does not depend on
> application itself. On the other hand endpoint dbus path is fully under
> application control, so independently of other applications, dbus path
> can be stable -- if application make it stable.

Yes, it may be more stable but it is also not unique so in the event 2
endpoints happen to have the same path we would have to disambiguate
them somehow and because of that I don't think we should be using
that. Im not sure why this would be a big deal since we should call
SelectConfiguration it is not like we would end up in a situation
where the stream would fail to setup since if that fails we fallback
to the priority ordering, if the user felt something out of order it
was either the system has changed (PA update, etc) or the device has
changed (new firmware, etc).

> > > > > Anyway
> > > > > chances are the LastUsed is only invalidated if you update PA, in
> > > >
> > > > Or once we include support for dynamic codec loading (based on enco=
der
> > > > library presence in system), installation of any irrelevant applica=
tion
> > > > may bring a new supported codec and therefore a new endpoint. So co=
decs
> > > > can become in any order...
> > > >
> > > > Or another example, when different application (not PA) register al=
so
> > > > some endpoint.
> > > >
> > > > > which case there could be new endpoints or a change in their orde=
r and
> > > > > package can also provide a script to clear the LastUsed if that
> > > > > happens, but then again LastUsed setting does not actually store =
the
> > > > > configuration just the endpoint so SelectConfiguration has contro=
l
> > > > > over the configuration.
> > > >
> > > > Yes, whole thing is only about initial codec selection. In the wors=
t
> > > > case user would have pre-selected different codec as which was last
> > > > used.
> > > >
> > > > But I think that storing dbus path of endpoint as described above s=
hould
> > > > be more reliable solution.
> > > >
> > > > Applications (e.g. PA) talking to bluetooth daemon does not registe=
r or
> > > > request directly SEID. Instead they register their dbus path and db=
us
> > > > connection and bluetooth daemon later allocates SEID for that path.
> > > >
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
