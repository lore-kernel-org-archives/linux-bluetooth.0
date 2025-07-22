Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F21C32
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188857; cv=none; b=tkJRXzyQAuBXSF8mYcBQjZr3+WTPT7lFoWp57G3NVPVZAG/Zx/FaySsCVmziTNAqzQeypS4TZJl70O5XHlYiBHrfP5mt6cwcH+bfwqcEWdDXVHLVkbQmf3EpZ8lB+kaZ8zOxf2Gwt/U+rS1B6fXI677vA2ioBCylFR1Tj+0Dy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188857; c=relaxed/simple;
	bh=5eVYpo8i2DuJ2Ky2OgvLLL/LVWTWYoqg7+TBf1/hrkg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqkgVaLX1QgF0u3xeTikPHViWG2yrjHuYHVQALMoXpg/OHjkQqG76I5eoI9BDRq/UQDm0qRMTaF1/kF2EaRKBZVjH9B8Fu7mTUjS/nmfBvrfQfaaJ7tnpF5QylS1zO4lO/tLLzPOfZd0fgNXNUA5IOLcbNiHjYAtXWR3PdgnOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD9E644402;
	Tue, 22 Jul 2025 12:54:13 +0000 (UTC)
Message-ID: <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
From: Bastien Nocera <hadess@hadess.net>
To: Francesco Giancane <quic_fgiancan@quicinc.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 22 Jul 2025 14:54:13 +0200
In-Reply-To: <20250721152219.517-1-quic_fgiancan@quicinc.com>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepqhhuihgtpghfghhirghntggrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
> Hi,
>=20
> I am posting this patch series to better decouple `bluetoothd` daemon
> and `libbluetooth`, as mentioned in the subject.
>=20
> I am introducing this change to make new BlueZ more granular.
> This will allow more control on which components are actually
> selected
> to build.
>=20
> Major use case for this change is fixing circular dependencies when
> bootstrapping new builds where the whole build root is to be
> recreated
> (e.g. Yocto Project).
> In these scenarios, to have Bluetooth support enabled in Python,
> `libbluetooth` is required at build time to be present but the direct
> chain of dependencies would require a Python installation available,
> thus introducing circular dependency.
> Separating the library and header files from the rest allows build
> systems to break the dependency loop.

FWIW, I'm currently porting bluez to meson (currently stuck on porting
ell with its gazillion of SSL certificate tests), which would make
python a pre-requirement for bluez (if meson ended up being the only
build system).

What part of Python itself has Bluetooth support? Wouldn't it also be
possible to make that part of Python separate so it can be built after
bluez?

>=20
> `--enable-bluetoothd` flag is added to the `configure` script and
> it is keeping the same behavior as other flags.
>=20
> Francesco Giancane (3):
> =C2=A0 configure.ac: introduce `--enable-bluetoothd` flag
> =C2=A0 Makefile.am: build `bluetoothd` if enabled
> =C2=A0 README: document `--enable-bluetoothd` flag
>=20
> =C2=A0Makefile.am=C2=A0 |=C2=A0 8 ++++++++
> =C2=A0README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
> =C2=A0configure.ac |=C2=A0 4 ++++
> =C2=A03 files changed, 26 insertions(+)
