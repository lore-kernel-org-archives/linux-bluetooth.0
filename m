Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892C371066
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625707; cv=none; b=WDj3J96Id4OOJV4eaS+S8OzlZ6VZ2GOdHwOPgQWwUfeP1xV9xukiA3JG9EhlkjE87K13r9St74SO476sJQFgrRRulbnOwTWHsOOoJqE9txv23/lEadsfFLFtOp2C6Hy/GgPSPqSE6O6GV3KWoSUnahCxf3H02pI7Qkrm77lBuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625707; c=relaxed/simple;
	bh=gCLLu2PhT3NywKJUF5AJoLPgGbHZKwp92oKTjRaAMNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVf1uNoBFpIpxRV2BAnr/F4Qf3Fg3zk4Ex5xllkFI5a0g9leMauPxdnIItbdQ/8T49ALbrUkcETQiDUOzXOgHpcTXQL8rucsci9Wpkk0LL7NfhEOuYXmPxCcCV/z98eUji7pNQr6bQcAqoshdg+h5KmYoQe7lkCI2Zc8mD8Vk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 026DA43B7D;
	Wed, 28 Jan 2026 18:41:42 +0000 (UTC)
Message-ID: <f8c5750e4da21f7c15c63a00e4d798850bd24397.camel@hadess.net>
Subject: Re: [PATCH BlueZ v6 10/20] tools: Install btmgmt along with other
 tools
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 28 Jan 2026 19:41:42 +0100
In-Reply-To: <CABBYNZLzbZMfjW1RNOs8yiFdthPXgMukprbS2LO9EMAA+YbLXw@mail.gmail.com>
References: <20260128155548.2025252-1-hadess@hadess.net>
	 <20260128155548.2025252-11-hadess@hadess.net>
	 <CABBYNZLzbZMfjW1RNOs8yiFdthPXgMukprbS2LO9EMAA+YbLXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepkeekvefhfeelgeefgfeitddufeduueeuieffteelleeujeejgfektdelieethfehnecuffhomhgrihhnpehmvghsohhnrdgsuhhilhgunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugeptddvieffteegfeeujeffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehluhhiiiguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpt
 hhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: -100

On Wed, 2026-01-28 at 13:26 -0500, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Wed, Jan 28, 2026 at 11:50=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > btmgmt is not installed by default, but it is useful for debugging
> > some issues and to set the MAC address on HCIs which don't have
> > their
> > MAC address configured.
> > ---
> > =C2=A0tools/meson.build | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/meson.build b/tools/meson.build
> > index 63ae1363972e..40215df691b7 100644
> > --- a/tools/meson.build
> > +++ b/tools/meson.build
> > @@ -160,7 +160,8 @@ if get_option('tools').enabled()
> > =C2=A0=C2=A0 if readline_dep.found()
> > =C2=A0=C2=A0=C2=A0=C2=A0 executable('btmgmt',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sources: [ 'btmgmt.c', '../src/uui=
d-helper.c',
> > '../client/display.c', '../client/mgmt.c' ],
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dependencies: [ libbluetooth_internal_d=
ep,
> > libshared_mainloop_dep, readline_dep ]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dependencies: [ libbluetooth_internal_d=
ep,
> > libshared_mainloop_dep, readline_dep ],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install: true
> > =C2=A0=C2=A0=C2=A0=C2=A0 )
> > =C2=A0=C2=A0=C2=A0=C2=A0 executable('obex-client-tool',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sources: [ 'obex-client-tool.c', g=
obex_sources, btio_sources
> > ],
> > --
> > 2.52.0
> >=20
>=20
> Bluetoothctl support mgmt menu nowdays, the code behind it is the
> same
> as btmgmt.

Noted, I'll drop it from the next revision of the patchset
