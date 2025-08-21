Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C1322756
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781930; cv=none; b=IxTRmGzRO+iFtO8+5NJK+c6F23WR0ynoXE9437SARnP1YW9RTIcK7Dd3qpjkLMWILg7xm13ihDvLQh7FqwdYOSOy9aHoVztGPW6NshG71p0FgBzf4b4SHYvQSAmKHxH2mzUhVofOfvAxkM7+azVPFPwMeJvIBMkGUSfUjCpFchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781930; c=relaxed/simple;
	bh=NT9WC74aH1hxzX/MFSZ9uTp5jOPj5I38WseaMt+dLf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zhj44suzM+tl4im5DALDmxiEWaY/XdKgci3BeqS5A4rFQOFRr66HzZORCEzrfkZDwDH8T5S5Bfe8Unhay9zvr1Wh9p2iymApIvxlvCrpjU2IPpnQdOsU2sXpLovDQWLFGbtdjsUUN2fCglGaNmV/UUUIoz8bOG+w4KIs7Em/Hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01CD71F6BE;
	Thu, 21 Aug 2025 13:12:00 +0000 (UTC)
Message-ID: <3ddcf434781e0a4de50c79b91d79e586e5ae3130.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for
 DualSense
From: Bastien Nocera <hadess@hadess.net>
To: sdoregor@sdore.me, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 21 Aug 2025 15:12:00 +0200
In-Reply-To: <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
		 <20250603095617.92785-3-sdoregor@sdore.me>
		 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
		 <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
		 <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
	 <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehsughorhgvghhorhesshguohhrvgdrmhgvpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrn
 hgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-06-03 at 21:35 +0300, Egor Vorontsov wrote:
> On Tue, 2025-06-03 at 11:38 -0400, Luiz Augusto von Dentz wrote:
> > Perhaps it is possible to write the link keys directly via cable
> > but
> > then we need the OOB data, etc, to generate the keys which in my
> > opinion it just extra work that doesn't really add anything if just
> > works, or autopair, is used.
>=20
> In my experimental PoC I just generated a random 128-bit string and
> used it as the link key for both sides (placed into `LinkKey=3D' in
> BlueZ's `/info' and sent to DualSense over USB), which showed to be
> working perfectly.
>=20
> > Is it not seamless right now? Doesn't it use 'just works'/autopair?
>=20
> It is kind of seamless, but you still have to accept the pairing
> manually (e.g. be discoverable and with an active agent). In terms of
> security I'd say this behavior is indeed preferable (otherwise one
> could spoof the VID:PID and zero-click bond with the host), but it
> still requires two separate confirmations.
>=20
> If we could generate a static key, place it to both devices BUT at the
> same time mark the device as unconfirmed/untrusted/etc. locally, so
> that it is still going to trigger one and only one interactive pairing
> confirmation, that'd be the intended design at least in my view.
>=20
> Another possible way would be to automatically accept the first, dummy
> pairing request that doesn't bear a link key yet -- so no security risk
> there, but still more seamless experience for the user.

The way it's supposed to work right now, is that you get an
authorisation request when you plug the device in and the Bluetooth
panel is open. This is what it does with PS3 and PS4 controllers (after
my recent bug fixes for PS4 controllers).

Then, when you unplug the controller and click on the PS/Power button,
it's supposed to connect without any more confirmations or the need to
have the Bluetooth panel open. This is how it works with PS3
controllers which don't pair.

PS4 controllers expect to pair, so they need to be authorised again.
Unfortunately, Sony won't share any cable pairing information with
kernel drivers writers, so we can't easily reimplement this.

So a "pairing" dialogue after the "authorisation" dialogue is how it
works. Removing the first "authorisation" dialogue is out of the
question, that's what makes it possible to plug the controller for
charging without pairing it.

See the patchset that starts with:
adapter: Add btd_request_authorization_cable_configured()
that I sent in 2017 and implemented that cable pairing authorisation.
