Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04751C004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 18:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32DB2054F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6PSs/Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfEGS5p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 14:57:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEGS5o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 14:57:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2so21482640wmi.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JzoKcjxETd5T9AMKg2PhVoI9r4n7Aur4yFwm+tthmMc=;
        b=G6PSs/Eq2wbGEFQHMJLwZIKyyFRwqGUGJCLyl66x6nVcNm45gRU5p6nY7r1S3mpOL2
         QSYPL0EhkZJ+iL6LTb2mJL32cDCXhpDsoEbrTb358NnSBwrMGjxOThYy2uaXd2kbFmmz
         1Hj34x+UXrn49U+if0yGhjni1Wd+8OsDjUCgwlTJ7lQavWrWvBdNfkMN2MAWaZ7CCAmf
         ljdLv+O3NUJqCJWeWBeAP4gBoiNlre9bwDAywWJ7hozBEpi37DL9qX5hS7aGSJ7UvEPk
         9Yvn9r/E46CBtI97V8LuoKVZY0pwouo8LVNR7s+yx1o/2gcX9awfSh86mW5bT9ayCWuG
         r3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JzoKcjxETd5T9AMKg2PhVoI9r4n7Aur4yFwm+tthmMc=;
        b=chR3kaiV79nW64RrGPTISUS+L/EhJVDu+WvmmYdFVDaYjTTyP+bvulSeKJc/7v12jn
         jGOzBgALQmUGe+1kvMYrrPwiZUfnjnFGqs5a7G2IMziqWklAxK7cMF5UnPQhSvTJdxbr
         KjaaWQW+QhEZWPY+T4+aHG5qYZ+H2OuHhn+2s8hqBNFXUKIyjHcSGG4usEC/OfzcY6Ng
         muHsRehZrKiBtCI2wpnNwlh4Lf/qfZUNpkCagA9K7RajvfL817zMQgtaTlMTCtexsnJS
         qVbzYFVJzofWLmKC+UuYNoJ80LssyC6FEM7eqIzCtYJnwoolOykPZqOb0wlsG6pYwuNd
         G8SQ==
X-Gm-Message-State: APjAAAXf0ugJTp5la4ErqCGZGrbDfzsJ6z46TqgHL6xAxHFdhC4FUc5a
        bvsu/y/EYV0iG4P1QCczdhs=
X-Google-Smtp-Source: APXvYqxz6dsowFAG8kynoFT6etQfWx+gXpXBnKCF9ijlAbDTHyUVD4oOEgfIt/4D59sxcjOemqZ8fA==
X-Received: by 2002:a1c:a751:: with SMTP id q78mr4614261wme.64.1557255462502;
        Tue, 07 May 2019 11:57:42 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g12sm16880363wmh.17.2019.05.07.11.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 11:57:41 -0700 (PDT)
Date:   Tue, 7 May 2019 20:57:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
Message-ID: <20190507185740.ywubjwgm7mer7txf@pali>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
 <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali>
 <20190507085255.zplj5ddopl3z5n2v@pali>
 <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7gdwia2vmnv6rwc4"
Content-Disposition: inline
In-Reply-To: <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--7gdwia2vmnv6rwc4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 May 2019 13:13:17 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Tue, May 7, 2019 at 11:52 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Monday 06 May 2019 15:02:25 Pali Roh=C3=A1r wrote:
> > > On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > I hope this fixes the problems you have been seeing, it should at
> > > > least take care of the issues with wrong order of SelectConfigurati=
on
> > > > and restoring the exact same endpoint used last time.
> > >
> > > Hi Luiz! Great, this should make bluez to be more deterministic.
> >
> > Hi! Now I looked at it and in cache file I see:
> >
> > LastUsed=3D04:01
> >
> > What would happen when A2DP application (e.g. pulseaudio) register DBus
> > endpoints in different order? Or e.g. do not register some endpoints due
> > to missing codec librayr (aptX).
> >
> > I guess that in this case LastUsed information stops working...
>=20
> It would most likely fail at SelectConfiguration and then try with the
> other endpoints.

Yes, that is truth. My point is just about validity of LastUsed value.

> >
> > Should not be there stored rather dbus endpoint name identifier?
>=20
> Originally I tried to avoid having the local endpoints because of this
> problem, but now that SelectConfiguration can fail it shouldn't really
> be a problem. At least with the seid if you have a system that didn't
> changed the order or number of endpoints it will keep working as
> expected,

But this may happen. And such thing is allowed. Any application,
including unprivileged can register own new endpoint to bluez. It is not
specific to pulseaudio. And in my opinion central bluetooth daemon which
expose such functionality should be robust and be prepared that
application on "other side of dbus IPC" does not have to be well
behaved.

> if we choose to encode the D-Bus connection, etc, as soon as
> PA is restarted, the system is rebooted, etc, the D-Bus connection may
> have changed making the stored values in LastUsed invalid.

That is truth.

My idea was to encode just dbus path of local dbus endpoint. We can say
(in IPC API) that client application should preserve dbus path for one
same endpoint between dbus daemon / computer restarts. Because otherwise
functionality of "choose last used endpoint" would not work.

This is less strict requirement and current one (that registration order
of all existing applications in system must be same across reboots),
less error prone and still should be easily implemented.

> Anyway
> chances are the LastUsed is only invalidated if you update PA, in

Or once we include support for dynamic codec loading (based on encoder
library presence in system), installation of any irrelevant application
may bring a new supported codec and therefore a new endpoint. So codecs
can become in any order...

Or another example, when different application (not PA) register also
some endpoint.

> which case there could be new endpoints or a change in their order and
> package can also provide a script to clear the LastUsed if that
> happens, but then again LastUsed setting does not actually store the
> configuration just the endpoint so SelectConfiguration has control
> over the configuration.

Yes, whole thing is only about initial codec selection. In the worst
case user would have pre-selected different codec as which was last
used.

But I think that storing dbus path of endpoint as described above should
be more reliable solution.

Applications (e.g. PA) talking to bluetooth daemon does not register or
request directly SEID. Instead they register their dbus path and dbus
connection and bluetooth daemon later allocates SEID for that path.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7gdwia2vmnv6rwc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXNHVIgAKCRCL8Mk9A+RD
UsTqAJ9P3pN4r3HupxFJn6/GvUfeyKmbPACfWnKuFtdQ+IvbAGCeg3s70fuPMdc=
=lLFz
-----END PGP SIGNATURE-----

--7gdwia2vmnv6rwc4--
