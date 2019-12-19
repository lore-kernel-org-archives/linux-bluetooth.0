Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402FC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CCB206EC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 15:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmKbZlUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSPdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:33:51 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55532 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLSPdu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Dec 2019 10:33:50 -0500
Received: by mail-wm1-f48.google.com with SMTP id q9so5877522wmj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2019 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GC/6dULC20HTN0JkrUN5e7bp5GUF5QpajjQT0eJZRKo=;
        b=ZmKbZlUZvzwABosH8FoUm9ZlYPe9loFwAVy0aOB15DNJq5cx35MjO5fARpERA6QZ5M
         ldIuG8NvVMozPKczi69bx5rjPSQpfibHHAsAPEpM81nkQo4dbVV72JGaZa6Dcnbq5gWI
         GVhUx9hYn45oEUGXYGTlQoy42ibf9CrX5S3eI9qBVJav33lylxTaXIMSZX+53HO7YuUn
         h3GRU0aguBoR6RhF3IAP9F8rZztA13Q+ON5X/eSGdG+ETPEs9sG7XZ4Mjk4PzYpdidBT
         Yj0a/kKYdpOVQB9K9vqtSvRDsqPvG60NtxubD6Ikmyh7h0f7xturLo3KIv71oJvj+LfE
         yfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GC/6dULC20HTN0JkrUN5e7bp5GUF5QpajjQT0eJZRKo=;
        b=CJSHW+qyrmooNwXDB3ExVfSvbWPZPmkQ6qxA+cOLltCsyfvRnGSB6vcehK8zQLGwMe
         uMsWSwDz4xHWcURs3oEYRahhEwNSiLIjvU+pxFY0o/DK0acVOfzfm3MUn4f9tcv8U//V
         7TJO2nxRdYGWwdhPI30N0XoS0NbwgSWxaWC2YigCyoeBRypHvPUzXVWn/blm45BWN8sg
         XKeK3AxTMt7XPqda6Vg9XBa/F4yZUxXmfmKz0VQSBikABWtwAAOyQHXmRS3eDtqaluEy
         LElrKZ8grZDy2EmTg08BDSUcrb9sj+Ymt6OAyrP6YQ9MSCn7oOgwSJ5uhxqET1EI6aVq
         4jQA==
X-Gm-Message-State: APjAAAW9TcEvd2njO11tPoF3fwGIZFFSeMrMpQBkLPsy2V7q281GtWCu
        boHHChNxIg0WUNxg3ucVqdM=
X-Google-Smtp-Source: APXvYqyo0gNWpi/aKyNg7hiWaiVF8lkpSMpPehq1sJ+bNo/OuP7oO9cD4/SkCmQNIzJGJOtnEhruVw==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr10195474wmg.83.1576769627100;
        Thu, 19 Dec 2019 07:33:47 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s65sm6651379wmf.48.2019.12.19.07.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 07:33:45 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:33:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Message-ID: <20191219153344.hxnoa3idqvgdwrp2@pali>
References: <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali>
 <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
 <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xjd7f24vshp7eni7"
Content-Disposition: inline
In-Reply-To: <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--xjd7f24vshp7eni7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Denis!

On Thursday 19 December 2019 08:53:54 Denis Kenzior wrote:
> Hi Pali,
>=20
> > > > But would you accept patches which exports DBus API e.g. for displa=
ying text
> > > > on HFP headset with embedded display? Or patches which implements 3
> > > > different way for reporting battery level status of HFP headset? An=
d API
> > > > for sending "computer battery level" to HFP headset? Or implementing
> > > > setup of SCO sockets (via RFCOMM layer) for custom codecs? Or expor=
ting
> > > > uinput linux device for button press events? Because all these
> > >=20
> > > So which roles are we talking about here?  Your Design document shows
> > > hsphfpd registering for both HFP AG and HFP HF roles, but maybe this =
was not
> > > the intent?
> >=20
> > My proposed hsphfpd is going to support both roles. Which means to
> > implement whole HFP profile. So for connecting bluetooth headsets (when
> > AG role is needed on desktop) and also for connecting mobile phones
> > (when HF role is needed on desktop).
> >=20
> > And my primary motivation is for bluetooth headsets as this is what are
> > asking desktop and laptop users again and again that is missing on Linux
> > systems.
> >=20
> > So higher priority has AG role and slightly lower priority has HF role.
> >=20
>=20
> So to summarize.  You have broadly 3 main use cases for HFP:
>=20
> 1. HF connecting to AG role.  Essentially a carkit role.  oFono does this
> pretty well already and has the APIs defined that cover up to HFP 1.7.  A=
ny
> vendor extensions can be easily added.  And some carkit manufacturers
> already use it.
>=20
> 2. AG role when you have a 'real modem' behind it.  oFono already provides
> everything needed for this scenario.
>=20
> 3. AG role when you don't have a real modem or you have some sort of VoIP
> use case.  oFono doesn't cover this case as you stated.

In your list are missing another two use cases:

4. AG role without real modem connecting yo HS role in HSP profile

5. HS role connecting to AG role in HSP profile


3. and 4. is my primary focus which is the most common scenario for
desktop / laptop users with bluetooth headset. 5., 2. and 1. are also
covered in hsphfpd design, but with lower priority (implemented after 3.
and 4. is fully working).

3. and 4. would share some part of code, specially handling of battery
status parsing via CSR and Apple extensions or CSR codec selection.

What do you suggest for 4. and 5.?

> So I can see value in something that implements case #3.  But having said
> that, oFono will not be receiving AT commands from external daemons:
> 	- For case 1, it'd just be a rehash of what oFono does well already.  I
> reinvented a few wheels in my time, but doesn't mean I think this one sho=
uld
> be.
> 	- The reasoning for case 2/3 I already covered upthread.
>=20
> > > If you're talking about extending oFono APIs when it is acting as the=
 HF
> > > connecting to the AG, then codec setup APIs, etc are definitely somet=
hing
> > > that would be welcome.
> > >=20
> > > If you're talking about AG role, then that is different... In general=
, if
> > > the oFono is in an AG role, then there should be nothing to configure=
 and
> > > there are no APIs for this role.
> >=20
> > Codecs needs to be configured also in AG role. Before accepting SCO
> > connection you need to configure SCO socket for correct codec. Also for
> > vendor codecs it needs to be properly negotiated via AT commands.
> >=20
>=20
> Sure, but that doesn't mean they need an actual D-Bus API to be configured
> with.  You can simply extend oFono emulator to support whatever codecs you
> want and whatever custom AT command handling that you need.  If the HF
> requests the codec, then you use it.  There's no D-Bus API required here.
> Again, take a look at how this is done in oFono today.
>=20
> > > Such a design will get a NAK from me on the oFono side.  But don't le=
t that
> > > stop you.  You can simply invoke oFono APIs directly from your daemon=
=2E  No
> > > need for any changes in oFono itself.  As mentioned above, I wouldn't
> > > recommend it, but... :)
> >=20
> > So if you are disagreeing with this design, can you propose alternative?
> > Which would support needs for desktop users? Support for HSP profile (in
> > AG role), support for HFP profile (in AG role), ability to parse and
> > interpret needed AT commands. And later also HS and HF role of these
> > profiles.
> >=20
>=20
> There have been one or two implementations of AG role fully external to
> oFono.  These implementations simply used the existing oFono APIs to drive
> the modem.

bluez & pulseaudio developers told me that it would be a good idea to
avoid implementing a new AT parser for telephony stack. And rather use
ofono implementation for telephony part...

But if I should use existing DBus API provided by ofono, it means that I
need to do parsing of all AT commands (including telephony) and
translate them to ofono DBus API.

I agree, this should work and there is not need to modify ofono. But it
means that in hsphfpd daemon I need to have full AT parser for all
telephony commands and it was something which bluez / pa developers
thought that should be avoided. Therefore I come up with idea that
telephony commands would be handled by external Telephony Agent, which
can be ofono.

> You could do that.  But as I said, we rejected such a design a
> long time ago due to complexity and other issues.

Anyway, what is the problem with accepting modem socket in ofono via
DBus and starts talking with it like with any other modem which ofono
supports? Currently ofono already takes modem socket from bluez via DBus
API, so in same way hsphfpd can pass modem socket to ofono. Basically
ofono then can reuse same code which already uses for sockets from
bluez, just it do not have to parse and interpret audio related AT
commands (as these are handled by hsphpfd itself).

What are exact issues? I do not see complexity at ofono part (as has
already everything implemented) and currently I do not see those "other"
issues.

> Or you can ignore the call control aspects entirely...
>=20
> But in the end, it is your architecture.  All I can do is point out (early
> in the process) what is and what is not acceptable to oFono upstream.

And this is why I started discussion across all projects (pulseaudio,
bluez, ofono) so describe current problem and come up with some
architecture which would be suitable for all projects. So thanks for all
your points.

You suggested to use phone simulator together with ofono and then
starts extending / patching phone simulator to supports all needed parts
which are in my hsphfpd design (battery status, button press, codec
selection)?

Also how to handle the main problem of phone simulator that it is too
much complicated to setup it on desktop? Looking at the steps...

https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Blu=
etooth/#index5h2

=2E.. that desktop user needs to run nontrivial commands in command like,
plus creating configuration file only just to connect bluetooth headset
is ridiculous and non-acceptable for desktop application.

If this problem is not fixed, ofono and phone simulator are not usable
as "main" software implementation of HFP profile for usage of bluetooth
headsets on Linux.

> > >=20
> > > Okay, I see now.  Yes, the above is correct.  My comments about not n=
eeding
> > > a modem device hold true only if oFono is in HFP HF role connecting t=
o an
> > > AG.
> >=20
> > Ok. So I guess now you understood main problem. I thought it was
> > obvious, but seems that bluetooth HFP is too complicated, so talking
> > about it always needs more detailed explanation. Sorry for that if it
> > was not clear from my side since beginning what are requirements for my
> > setup.
>=20
> Well it was a bit of reading comprehension fail on my part as well.  The =
two
> roles are really quite different, so precise language helps.
>=20
> Regards,
> -Denis

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xjd7f24vshp7eni7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfuYVgAKCRCL8Mk9A+RD
UiDkAJ0SnIq6fvBFSUX8Tlf6cbRbiP8ERACeIDANQpfUCwBxtY4OQAmXArEewL8=
=u5gK
-----END PGP SIGNATURE-----

--xjd7f24vshp7eni7--
