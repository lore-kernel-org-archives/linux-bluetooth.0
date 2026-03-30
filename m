Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFE3D0930
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874333; cv=none; b=mXMLdB2ewUHEvnfZAkEM6hTWuUYv4KrXjPsd7Mo5EmzhbBDWD6I27TfdQflfOg0LeYTUbZjV+/B8dvxj7YhxVCvzW/ErGWFxeoPHev3c4uGuRmPiKjKL70qGvQuzgjAg95XGOAXpWSYJXYPTv1+5WJQ4gxSo3Uit9HiwHVmfzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874333; c=relaxed/simple;
	bh=CjCR8AbGq1xlIqb/22RHXbyj9MASwBrX0RB54S7czVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOItqgLtK/eIww88nGOhh5UcYW8GaCZiJ/bNgvZSuyguCKMBQUc59fj8S6Jl6ggnMLDW1AirxVZ0tZSJ+GoUuDmFTtziY7isFyTvnAHCm/lnwV0+sTS/hM4Y43glTdMX5M8vUWUUxNbX4B2TSNHsF47QKhjNIYvTNNFcdMBTyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AEA43EBF7;
	Mon, 30 Mar 2026 12:38:50 +0000 (UTC)
Message-ID: <177a2b4ff440d84853662e042082f6580e41aed4.camel@hadess.net>
Subject: Re: Integration testing for BlueZ
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Mar 2026 14:38:49 +0200
In-Reply-To: <c606541c5c1309b9d4be685962f429581eaa7ffb.camel@iki.fi>
References: <20260218024605.70890-1-ronan@rjp.ie>
			 <20260218024605.70890-3-ronan@rjp.ie>
			 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
			 <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
			 <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
		 <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
	 <c606541c5c1309b9d4be685962f429581eaa7ffb.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTF6QtHem0A+2X5SF1Qk08+y6kAsRlLdsYGRS/cQ8IrE116gY8yIM4TLeazURAdlNQipzT6KTjxpACEaxoDk32eVaBm85goU9CTbi9nFz0MHQofo24BHmHxwjKbIAqlTHTbtXJV4hX910MNfLLdOsDVVaYkxflThy0kCJDwIUYq0QE0yjTSgHUj/Ahf/8JRzNm1ciaOIoTnBqgxqpbaEV6nhZgAGMVFaM7FWGuLeSe8UDlmCdGlz4RCU7S0leEZkpMQ3hcLvCuJ6eJ15inTjRACezfoDVaA9h9rLTKBFaeUsRe0JgOsJ4KKISAxd3fYUAGuRKeRUJqwc/h1oQAOqyQj0BXFXrpSV3BjuWpaKz3vbohcu5Q9PtZyzA25c08n20nio/iDpI4Fv1u0V7xfzMWgFgZD3U132VwkmaN6B+umGwM8ZCVtNgd1abVon/WcDu0Rw/K4hFff4PCmJVeLWNSaoBGTbf/Xi5OPExbE8XLtEa7gPy0NT+gdxIP1cdFlo9MsSDOiWxLLjoZvz6KrnrR/vtx0C0OSSRLjQ+nWfFWhUzRwnYS1db6S+mx7bhyc6+DeX++sgbqkjYoW/FLTJLyiQtvfNbIHKie+T/BmkxxdtDB7OAeqV5/XGLYduo5Lxd6t4CDkOor8WxlOyigHubzTM40ARYfFqLflnIbCuMdQZFw
X-GND-State: clean
X-GND-Score: -100

On Wed, 2026-02-25 at 20:58 +0200, Pauli Virtanen wrote:
> Hi,
>=20
> ke, 2026-02-25 kello 17:01 +0100, Bastien Nocera kirjoitti:
> [clip]
> > > Feel free to git a review to Lars's patch; hopefully, that will
> > > help
> > > us get this resolved quicker. We might as well create a unit test
> > > for
> > > shell to try to emulate different modes and environments. That
> > > way,
> > > we
> > > prevent introducing regressions like this in the future.
> >=20
> > I wrote one, which I can integrate into meson.
> >=20
> > This starts "btvirt" (so requires root), launches bluetoothd if
> > there
> > isn't a daemon already running, and launches "bluetoothctl list".
> >=20
> > You can run it manually with:
> > $ sudo top_builddir=3D/path/to/bluez/builddir/ ./integration-test.py
> >=20
> > If "bluetoothctl list" doesn't output any text, the test errors
> > out.
> > I've tested that pointing the bluetoothctl_path() output at an old
> > version of bluetoothctl worked.
> >=20
> > This pattern of using Python to create test suites using python-
> > dbusmock is something I've already used in PolicyKit, upower,
> > power-
> > profiles-daemon, gnome-bluetooth and many other places.
> >=20
> > This test is pretty heavy-handed if we just want to test whether
> > bluetoothctl outputs things correctly, but it has the benefit of
> > testing the emulator as well as bluetoothd. We could start adding
> > more
> > tests to the mix, such as creating more adapters, pairing them,
> > etc.
> >=20
> > Hopefully, this is a useful test to run on CIs, although I'm
> > probably
> > missing spawning a system bus on top of everything else.
> >=20
> > What do you think?
>=20
> Adding some testing for this is a good idea, and I'd think Python is
> the way to go.
>=20
> I was planning on pushing this a bit further, and automate also end-
> to-
> end integration testing.=C2=A0That is, QEmu instances connected to each
> other via btvirt, so we can have repeatable tests in a "real"
> environment.
>=20
> This is maybe overkill for simple bluetoothctl command line tests,
> but
> it allows things like automated testing of Pipewire <-> Bluez <->
> btvirt <-> BlueZ <-> Pipewire audio setup.
>=20
> This involves lots of subsystems, and it's currently 100% relying on
> manual testing and sometimes things are missed, like breaking A2DP in
> some setups in 5.86, or breaking BAP in 5.85.
>=20
> Here's a working prototype, needs some more work though so details
> may
> change but the general shape is probably going to stay:
>=20
> https://github.com/pv/bluez/blob/func-test/unit/func_test/test_cli_simple=
.py

Do you still have a copy of the above file somewhere? I wanted to
finish porting them into my own integration tests which I'm hoping to
add to the regression/unit tests that are usually run for every
commit/MR.

>=20
> https://github.com/pv/bluez/blob/func-test/doc/test-functional.rst
>=20
