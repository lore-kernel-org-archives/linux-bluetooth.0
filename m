Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD91F4C8C
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947441; cv=none; b=j08eyRTcB63EzZa6oue0io2zbeySMQnf67pez+ynHy/fUUodCvrdlCNLOYTXgCm8dESzkuOwtHIi9EZpmpyRkV3ek5syYAjTGDthiISGgAe1OrXSckvuW+7ceEgvHkV+oei6sbSYhyfUPYZIc4g9O2WPi0HZ8ZIOPo0WEF+Vx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947441; c=relaxed/simple;
	bh=rvq11vbICNo9qh+r+Rg/zihjljMs/lgSFynfZi4QPhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FP+oNF5ggNE6g3a3KrlVxKPfBrSeQxsSeT2DiLvWyKAWJ5Ude1uX3LOaaoHrDSaaROLnG7zdL3PU89/2sGJy5y5Lr8ga+clSxhfhaG0MCKznGc2YYKZKnzA8QRaWSjSmvW6VVs2mzvmCO+HNAKGlJorH/KyXxJGFzhxtn0N34sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2A4E1F47A;
	Mon, 11 Aug 2025 21:23:56 +0000 (UTC)
Message-ID: <efee125ec17e706644931baa11bffb6d69ba8e38.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/8] build: Add ell subproject
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 11 Aug 2025 23:23:56 +0200
In-Reply-To: <CABBYNZK4W=ExFThcES1_vu_0a7aQnzMtX54CYV+8LDinXkyELw@mail.gmail.com>
References: <20250811195850.1775759-1-hadess@hadess.net>
	 <20250811195850.1775759-2-hadess@hadess.net>
	 <CABBYNZK4W=ExFThcES1_vu_0a7aQnzMtX54CYV+8LDinXkyELw@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepheeifeeivdffgfefgedvtdfhteelveegieetgfehgfdvuedvtedufeetgeelgfeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvr
 hdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Mon, 2025-08-11 at 16:16 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Mon, Aug 11, 2025 at 3:59=E2=80=AFPM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > Add the ell library as a subproject. Rather than doing like
> > autotools
> > and relying on users checking out ell in a particular location, or
> > install ell as a system shared library, use meson subprojects to
> > build
> > our own internal copy of ell if the user hasn't installed it
> > system-wide.
> >=20
> > Note that this currently points to a fork of ell with meson support
> > added, this should be switched to the upstream repo when that
> > support is
> > merged. See:
> > https://lore.kernel.org/ell/20250807134859.930870-1-hadess@hadess.net/T=
/
>=20
> Ok, well then we will depend on ell switching to meson first, have
> you
> received any feedback if that is going to be accepted? Perhaps we
> could just turn it into a regular dependency instead of requiring to
> copy its source code since that was done due to distro not packaging
> libell back when it was introduced, but maybe that has changed since
> then.
>=20
> Anyway I do agree it is quite ugly what we are doing, requiring ell
> on
> a specific to build and the usage of submodule is probably the right
> thing to do if we don't want to deal with a system dependency.

The submodule is only used with meson. meson will automatically
fallback to the system version of the library if present. I didn't make
any changes to the autotools build.

About the ell meson patches, I haven't received feedback yet, but I'll
poke again now.

>=20
> > ---
> > =C2=A0.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> > =C2=A0.gitmodules=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> > =C2=A0subprojects/ell | 1 +
> > =C2=A03 files changed, 4 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100644 .gitmodules
> > =C2=A0create mode 160000 subprojects/ell
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index d23a06af4b53..3da0ac680152 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -35,7 +35,6 @@ test-driver
> > =C2=A0test-suite.log
> > =C2=A0coverage.info
> > =C2=A0coverage
> > -ell
> >=20
> > =C2=A0lib/bluez.pc
> > =C2=A0src/builtin.h
> > diff --git a/.gitmodules b/.gitmodules
> > new file mode 100644
> > index 000000000000..53881e4d8e3f
> > --- /dev/null
> > +++ b/.gitmodules
> > @@ -0,0 +1,3 @@
> > +[submodule "subprojects/ell"]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D subprojects/ell
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url =3D https://github.com/hadess=
/ell.git
> > diff --git a/subprojects/ell b/subprojects/ell
> > new file mode 160000
> > index 000000000000..08bc5f26f210
> > --- /dev/null
> > +++ b/subprojects/ell
> > @@ -0,0 +1 @@
> > +Subproject commit 08bc5f26f2108a778a25222fdc60b931310ad68d
> > --
> > 2.50.0
> >=20
> >=20
>=20
