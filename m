Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62302313523
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191911; cv=none; b=jjqtr1QvJXt31dOE+6HbvI8RhTvNfGMRYs9O+HovKVECUruHcLqHacq/1Tt1Vbl5YDGrrgaGUdDRZs9bwx3zQpKEfquwy3G4W+itIRrLQ5H2MGQYxuhsu2PQDHPabQQH7Ie2coXSY0NKzDsVHHcTIqCEdlG22Iifc/AXquzDzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191911; c=relaxed/simple;
	bh=g9736/J+HcVOoMLHSMw5bkUDwOo1HsQp2CVM4vrG+eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9kTZkviPoFPTw3G8W1AR3sisgN1JuxxVrVX3FJWo8PT42MTsQYh1uoQ03UWrXNb5yEoDdvkXQxCnSYN8CzsuXKhHG133W2qJmjloYaNThROHwRFY1zw13O74cdHLpIvdNWXPHh6sUrwmZQ6lAnRsLfF5uv5c+mEuX3uDAlEzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 813954388D;
	Fri, 27 Feb 2026 11:31:40 +0000 (UTC)
Message-ID: <62306adc1550b46aa164ddb57e8a4167dddeb261.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] shared/shell: gracefully recover from failed
 input initialization
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Ronan Pigott
 <ronan@rjp.ie>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 27 Feb 2026 12:31:39 +0100
In-Reply-To: <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
References: <20260218024605.70890-1-ronan@rjp.ie>
		 <20260218024605.70890-3-ronan@rjp.ie>
		 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
		 <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
		 <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
	 <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepheeifeeivdffgfefgedvtdfhteelveegieetgfehgfdvuedvtedufeetgeelgfeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepkedufeelheegfeekkeffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehluhhiiiguvghnthiisehgmhgri
 hhlrdgtohhmpdhrtghpthhtoheprhhonhgrnhesrhhjphdrihgvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: -100

On Wed, 2026-02-25 at 17:01 +0100, Bastien Nocera wrote:
> On Wed, 2026-02-18 at 13:45 -0500, Luiz Augusto von Dentz wrote:
> > Hi Ronan,
> >=20
> > On Wed, Feb 18, 2026 at 12:45=E2=80=AFPM Ronan Pigott <ronan@rjp.ie> wr=
ote:
> > >=20
> > > February 18, 2026 at 7:58 AM, "Luiz Augusto von Dentz"
> > > <luiz.dentz@gmail.com> wrote:
> > >=20
> > > > Yeah, the revert part doesn't really fly since
> > > > e73bf582dae60356641a32fc27ae03d359ec4c47 does fixes a valid
> > > > issue,
> > > > that said we do have another proposal under discussion:
> > > >=20
> > > > https://patchwork.kernel.org/project/bluetooth/patch/20260217222954=
.432676-1-larsch@belunktum.dk/
> > >=20
> > > Hi Luiz,
> > >=20
> > > I'm aware it fixes a valid issue. My hope with the patch is to
> > > fix
> > > that same issue in another way.
> > >=20
> > > The problem adressed IIUC is that once the input is initialized,
> > > a
> > > subsequent epoll_wait would hang
> > > since the epoll_ctl call had failed to actually add the new event
> > > source. The reverted patch had
> > > fixed this by trying to avoid initializing stdin in all cases,
> > > which inadvertently broke
> > > bluetoothctl. My suggestion is to revert that change, and instead
> > > check the return value of
> > > io_set_read_handler so that we can avoid digging ourselves into a
> > > deeper hole. Even if bt_shell_printf
> > > is refactored so that it doesn't require the input fd, which
> > > sounds
> > > prudent, I think it probably makes
> > > sense to check the return values here, so I believe the reverted
> > > patch would no longer be necessary.
> > >=20
> > > I have seen Lars's patch, and that is actually what prompted me
> > > to
> > > submit this one. Unfortunately,
> > > it isn't correct since it causes non-interactive bluetoothctl
> > > invocations to also print several
> > > extraneous lines relating to the interactive shell.
> >=20
> > Feel free to git a review to Lars's patch; hopefully, that will
> > help
> > us get this resolved quicker. We might as well create a unit test
> > for
> > shell to try to emulate different modes and environments. That way,
> > we
> > prevent introducing regressions like this in the future.
>=20
> I wrote one, which I can integrate into meson.
>=20
> This starts "btvirt" (so requires root), launches bluetoothd if there
> isn't a daemon already running, and launches "bluetoothctl list".
>=20
> You can run it manually with:
> $ sudo top_builddir=3D/path/to/bluez/builddir/ ./integration-test.py
>=20
> If "bluetoothctl list" doesn't output any text, the test errors out.
> I've tested that pointing the bluetoothctl_path() output at an old
> version of bluetoothctl worked.
>=20
> This pattern of using Python to create test suites using python-
> dbusmock is something I've already used in PolicyKit, upower, power-
> profiles-daemon, gnome-bluetooth and many other places.
>=20
> This test is pretty heavy-handed if we just want to test whether
> bluetoothctl outputs things correctly, but it has the benefit of
> testing the emulator as well as bluetoothd. We could start adding
> more
> tests to the mix, such as creating more adapters, pairing them, etc.
>=20
> Hopefully, this is a useful test to run on CIs, although I'm probably
> missing spawning a system bus on top of everything else.

I've integrated tests for both bugs (no output in 5.86 and btmgmt
hanging) into the integration tests at:
https://github.com/hadess/bluez/commits/wip/hadess/add-integration-tests/

and I've independently tested that both problems were fixed by the
patches I sent to the list this instant.
