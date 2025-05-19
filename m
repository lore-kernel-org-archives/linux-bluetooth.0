Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094979FE
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682579; cv=none; b=IEjpn4RswGJGwt+SNiYwfGoIQJztc/ASBijbQWIYYZA8McUyu302rro5tsOZJHfao2/RReURIqvPt7gSHwcoMKtU7cJPTcweSKAUhDQv6vwLSou5WUgjzWjjeqOcQ4fGSfMjBiAbYdQwNLzLB9tlIcunVb6rhWfxNtkaiZ/SKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682579; c=relaxed/simple;
	bh=i0JXAlxpcnrfCn32HdsQoH4KPC5oSzqF3llZGvlW0cQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOhdv1sGLoa79IZEePD1/OscDq74ZNriHys1iud/4uBCAsnHNNf146BN6t7EOdPzrzeJZgu/meWoMENSP2WzAFvA1xvQyz1eokLBPcJLeA9FtmHjrszjDk7w57hxBuj7fVkeQfy34CIohL8mCib6/rp8U9jo4e1oJLRolh/nlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DAF5440DD;
	Mon, 19 May 2025 19:22:54 +0000 (UTC)
Message-ID: <d4c4cb4cc03b23f21ac9e9c5041937ccfc3f81f5.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/3] doc/device: Add Disconnected signal
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	 <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 19 May 2025 21:22:54 +0200
In-Reply-To: <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
References: <20250519161412.107904-1-frederic.danis@collabora.com>
	 <20250519161412.107904-3-frederic.danis@collabora.com>
	 <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgdruggrnhhishestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhot
 hhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Mon, 2025-05-19 at 12:44 -0400, Luiz Augusto von Dentz wrote:
> Hi Fr=C3=A9d=C3=A9ric,
>=20
> On Mon, May 19, 2025 at 12:18=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
> <frederic.danis@collabora.com> wrote:
> >=20
> > ---
> > =C2=A0doc/org.bluez.Device.rst | 17 +++++++++++++++++
> > =C2=A01 file changed, 17 insertions(+)
> >=20
> > diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> > index 80501eddd..6229f95ad 100644
> > --- a/doc/org.bluez.Device.rst
> > +++ b/doc/org.bluez.Device.rst
> > @@ -155,6 +155,23 @@ array{array{byte}} GetServiceRecords()
> > [experimental]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :org.bluez.Error.NotConnecte=
d:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :org.bluez.Error.DoesNotExis=
t:
> >=20
> > +Signals
> > +-------
> > +
> > +void Disconnected(string reason)
> > +````````````````````````````````
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This signal is launched when a de=
vice is disconnected with
> > the reason of
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the disconnection.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Possible reasons:
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-unknown:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-timeout:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-local-host:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-remote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-local-suspend:
>=20
> Perhaps it would be better to use to the actual HCI code instead of
> converting it to string, since I suspect application using this
> signal
> may want to recover the actual error to do some sort of reconnecting
> policy, etc, or having them both in case the client just wants to
> print it.

If there are applications using those signals (I'm guessing, Bluetooth
settings apps), whatever the format of the error, could we have an
expected behaviour associated with individual error types?
