Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363823AB9D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193023; cv=none; b=eJR+stitX2LWHI7c03dh8lDjf6EXBmwL/YD3mAtBNARhG1XtbR6k1HRSu19V+mlpLm2r5V5WxO+5W2ME2Qse1boJxJcE47q6DjIkqhA/B8b382QIk1mNHw1xufM+gsLnwk0gzL0w11Z5mBnxqNGSH6W8on/7YQC8pOUYldJtH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193023; c=relaxed/simple;
	bh=fhGDfanbxdhK2sSCdr9aaTskaArDZSTd11pq9mBWkXE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BrTnorA1mw2QGa3FIEARPkyaRyXGXWQNzpXK6vAqQafkBpEUud5HbNSUoJBSoj/8WSsdNUknlRoiyoKNov+AhYKfPcTRjembeYIMJ83Rme+uTszCZCDdk9CNZuTKXbMjVX5dqn55f9CAxZQzSrJSAqv1kRjDaz6OY1BEQAIJGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 108A7438E4;
	Tue, 22 Jul 2025 14:03:32 +0000 (UTC)
Message-ID: <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
From: Bastien Nocera <hadess@hadess.net>
To: Francesco Giancane <quic_fgiancan@quicinc.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 22 Jul 2025 16:03:32 +0200
In-Reply-To: <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
	 <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
	 <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepqhhuihgtpghfghhirghntggrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-07-22 at 14:26 +0100, Francesco Giancane wrote:
> Hello!
>=20
> On 22/07/2025 13:54, Bastien Nocera wrote:
> > On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
> > > Hi,
> > >=20
> > > I am posting this patch series to better decouple `bluetoothd`
> > > daemon
> > > and `libbluetooth`, as mentioned in the subject.
> > >=20
> > > I am introducing this change to make new BlueZ more granular.
> > > This will allow more control on which components are actually
> > > selected
> > > to build.
> > >=20
> > > Major use case for this change is fixing circular dependencies
> > > when
> > > bootstrapping new builds where the whole build root is to be
> > > recreated
> > > (e.g. Yocto Project).
> > > In these scenarios, to have Bluetooth support enabled in Python,
> > > `libbluetooth` is required at build time to be present but the
> > > direct
> > > chain of dependencies would require a Python installation
> > > available,
> > > thus introducing circular dependency.
> > > Separating the library and header files from the rest allows
> > > build
> > > systems to break the dependency loop.
> > FWIW, I'm currently porting bluez to meson (currently stuck on
> > porting
> > ell with its gazillion of SSL certificate tests), which would make
> > python a pre-requirement for bluez (if meson ended up being the
> > only
> > build system).
> >=20
> > What part of Python itself has Bluetooth support? Wouldn't it also
> > be
> > possible to make that part of Python separate so it can be built
> > after
> > bluez?
>=20
> Python uses autoconf to detect compile-time dependencies.
>=20
> They implemented Bluetooth network management with standard socket()
> calls.
>=20
> This code path is enabled at compile time only if it detects
> bluetooth.h=20
> header.
>=20
> So for python to support Bluetooth in std library, libbluetooth
> should=20
> be already deployed.
>=20
> With this current patch series I posted, you can build a "lite"
> version=20
> of bluez to ship just enough
>=20
> the library and the headers so that python can have bluetooth support
> (building a full BlueZ package requires
>=20
> python too... hence the circular dependency).

Right, so you're trying to do:
- bluez (lib and headers only)
- python (with Bluetooth support)
- bluez (full)

And if meson were the only build system, you'd need to do:
- python (without Bluetooth support)
- bluez (full)
- python (with Bluetooth support)

I guess having a minimal uapi header upstream would allow to do:
- python (with Bluetooth support)
- bluez (full)

Definitely the best option.

I think it might be best to only migrate to the upstream kernel uapi
the minimum needed to build Python with Bluetooth support, and extend
it as needed afterwards.

In the short-term, why not apply your bluez patches to your bluetoothd
recipe rather than upstream? That should also motivate developers to
land the "correct" fix upstream ;)

Cheers

>=20
> Francesco
>=20
> >=20
> > > `--enable-bluetoothd` flag is added to the `configure` script and
> > > it is keeping the same behavior as other flags.
> > >=20
> > > Francesco Giancane (3):
> > > =C2=A0=C2=A0 configure.ac: introduce `--enable-bluetoothd` flag
> > > =C2=A0=C2=A0 Makefile.am: build `bluetoothd` if enabled
> > > =C2=A0=C2=A0 README: document `--enable-bluetoothd` flag
> > >=20
> > > =C2=A0=C2=A0Makefile.am=C2=A0 |=C2=A0 8 ++++++++
> > > =C2=A0=C2=A0README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++++=
+++++
> > > =C2=A0=C2=A0configure.ac |=C2=A0 4 ++++
> > > =C2=A0=C2=A03 files changed, 26 insertions(+)
