Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461B2E9757
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195082; cv=none; b=c/wrcpSfMc3dhZ729BuhR4Yfxd0ku2QbZSu9ZJhE9pE8jR3iOCoNoBez4p5wrw3W/F8WqPVf7Rzm+GW35BpiUs3OBgAyiKvdFEXDa4p61i09Y6PzUfCTL+liUoh3g7SpwAZYJNkNoNTuCeMMKqrNPk6IqtUnve/MiWD37if9/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195082; c=relaxed/simple;
	bh=uzP+zpNr2LEU0vi48i/A1xmLSiRRnOFlf4os9GRhlT8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bk61yeCZ33a1NrNqvoRH1L5FWErvZ5oT17QuDPFwpSdLW/ozbVfeZxSl17+nDySES8WlBsg1nkaMa9NRGDE1/HLsz82yTS/owNxODik1sMwnDACC6e4kqGOWntSxuUD8DBd/cXexMRe6wlbs6KAGTGvmHKN8RnV5QpF1KVxGhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33C5D431FF;
	Mon,  8 Dec 2025 11:57:52 +0000 (UTC)
Message-ID: <eb393fee5cfc383397918349d1f714c7023bd3ca.camel@hadess.net>
Subject: Re: [PATCH BlueZ] build: Allow systemd unit build without libsystemd
From: Bastien Nocera <hadess@hadess.net>
To: Achill Gilgenast <achill@achill.org>, linux-bluetooth@vger.kernel.org
Date: Mon, 08 Dec 2025 12:57:51 +0100
In-Reply-To: <20251208012421.838601-1-achill@achill.org>
References: <20251208012421.838601-1-achill@achill.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnheptdehffevfeffvedtheethfejveeljeehheeljefhkeevffehieefhfeuudduieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprggthhhilhhlsegrtghhihhllhdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhor
 hhg
X-GND-Sasl: hadess@hadess.net

On Mon, 2025-12-08 at 02:24 +0100, Achill Gilgenast wrote:
> Decouples libsystemd and systemd units from the same option and
> allows
> installation of services without systemd.pc by manually specifying
> the
> directories.
>=20
> This is useful in Alpine Linux where we don't ship systemd, but allow
> systemd services to be subpackaged for downstream distributions like
> postmarketOS.

For what it's worth, this was already implemented in the meson port:
https://github.com/hadess/bluez/commit/b8d12fa7eb9a5b7071eb130344a0816c46c8=
7db8

> ---
> I'm by far no expert in autotools or bluez and how specific
> components
> are best categorized, so please let me know your feedback.
> ---
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++-
> =C2=A0Makefile.mesh=C2=A0 |=C2=A0 4 +++-
> =C2=A0Makefile.obexd |=C2=A0 2 +-
> =C2=A0Makefile.tools |=C2=A0 4 ++--
> =C2=A0configure.ac=C2=A0=C2=A0 | 21 +++++++++++++++------
> =C2=A05 files changed, 26 insertions(+), 11 deletions(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index e152ae64853c..d3cdb2890d32 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -49,13 +49,17 @@ conf_DATA +=3D profiles/network/network.conf
> =C2=A0state_DATA =3D
> =C2=A0endif
> =C2=A0
> -if SYSTEMD
> +if SYSTEMD_SYSTEMUNITS
> =C2=A0systemdsystemunitdir =3D $(SYSTEMD_SYSTEMUNITDIR)
> =C2=A0systemdsystemunit_DATA =3D src/bluetooth.service
> +endif
> =C2=A0
> +if SYSTEMD_USERUNITS
> =C2=A0systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
> =C2=A0systemduserunit_DATA =3D
> +endif
> =C2=A0
> +if SYSTEMD_UNITS
> =C2=A0dbussystembusdir =3D $(DBUS_SYSTEMBUSDIR)
> =C2=A0dbussystembus_DATA =3D src/org.bluez.service
> =C2=A0endif
> diff --git a/Makefile.mesh b/Makefile.mesh
> index e4c9fa6a32e6..e9998a9cdd75 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -6,8 +6,10 @@ dbus_DATA +=3D mesh/bluetooth-mesh.conf
> =C2=A0conf_DATA +=3D mesh/mesh-main.conf
> =C2=A0endif
> =C2=A0
> -if SYSTEMD
> +if SYSTEMD_SYSTEMUNITS
> =C2=A0systemdsystemunit_DATA +=3D mesh/bluetooth-mesh.service
> +endif
> +if SYSTEMD_UNITS
> =C2=A0dbussystembus_DATA +=3D mesh/org.bluez.mesh.service
> =C2=A0endif
> =C2=A0
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 7ad74e1286b6..25aa8feb73d1 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -1,7 +1,7 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0if OBEX
> =C2=A0
> -if SYSTEMD
> +if SYSTEMD_USERUNITS
> =C2=A0systemduserunit_DATA +=3D obexd/src/obex.service
> =C2=A0
> =C2=A0obexd-add-service-symlink:
> diff --git a/Makefile.tools b/Makefile.tools
> index 561b03d0b95b..72dffe7cd005 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -74,7 +74,7 @@ pkglibexec_PROGRAMS +=3D tools/btmon-logger
> =C2=A0tools_btmon_logger_SOURCES =3D tools/btmon-logger.c
> =C2=A0tools_btmon_logger_LDADD =3D src/libshared-mainloop.la
> =C2=A0
> -if SYSTEMD
> +if SYSTEMD_SYSTEMUNITS
> =C2=A0systemdsystemunit_DATA +=3D tools/bluetooth-logger.service
> =C2=A0endif
> =C2=A0endif
> @@ -340,7 +340,7 @@ tools_hex2hcd_SOURCES =3D tools/hex2hcd.c
> tools/missing.h
> =C2=A0
> =C2=A0tools_mpris_proxy_SOURCES =3D tools/mpris-proxy.c
> =C2=A0tools_mpris_proxy_LDADD =3D gdbus/libgdbus-internal.la $(GLIB_LIBS)
> $(DBUS_LIBS)
> -if SYSTEMD
> +if SYSTEMD_USERUNITS
> =C2=A0systemduserunit_DATA +=3D tools/mpris-proxy.service
> =C2=A0endif
> =C2=A0
> diff --git a/configure.ac b/configure.ac
> index 16b81aca37e6..2d9352b59557 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -352,29 +352,38 @@ AC_ARG_WITH([systemdsystemunitdir],
> =C2=A0			AS_HELP_STRING([--with-
> systemdsystemunitdir=3DDIR],
> =C2=A0			[path to systemd system unit directory]),
> =C2=A0					[path_systemunitdir=3D${withva
> l}])
> -if (test "${enable_systemd}" !=3D "no" && test -z
> "${path_systemunitdir}"); then
> +if (test "${enable_systemd}" !=3D "no" -o -z "${path_systemunitdir}");
> then
> =C2=A0	AC_MSG_CHECKING([systemd system unit dir])
> -	path_systemunitdir=3D"`$PKG_CONFIG --
> variable=3Dsystemdsystemunitdir systemd`"
> =C2=A0	if (test -z "${path_systemunitdir}"); then
> -		AC_MSG_ERROR([systemd system unit directory is
> required])
> +		path_systemunitdir=3D"`$PKG_CONFIG --
> variable=3Dsystemdsystemunitdir systemd`"
> +		if (test -z "${path_systemunitdir}"); then
> +			AC_MSG_ERROR([systemd system unit directory
> is required])
> +		fi
> =C2=A0	fi
> =C2=A0	AC_MSG_RESULT([${path_systemunitdir}])
> =C2=A0fi
> =C2=A0AC_SUBST(SYSTEMD_SYSTEMUNITDIR, [${path_systemunitdir}])
> +AM_CONDITIONAL(SYSTEMD_SYSTEMUNITS, test "${path_systemunitdir}" !=3D
> "")
> =C2=A0
> =C2=A0AC_ARG_WITH([systemduserunitdir],
> =C2=A0			AS_HELP_STRING([--with-
> systemduserunitdir=3DDIR],
> =C2=A0			[path to systemd user unit directory]),
> =C2=A0					[path_userunitdir=3D${withval}
> ])
> -if (test "${enable_systemd}" !=3D "no" && test -z
> "${path_userunitdir}"); then
> +if (test "${enable_systemd}" !=3D "no" -o -z "${path_userunitdir}");
> then
> =C2=A0	AC_MSG_CHECKING([systemd user unit dir])
> -	path_userunitdir=3D"`$PKG_CONFIG --variable=3Dsystemduserunitdir
> systemd`"
> =C2=A0	if (test -z "${path_userunitdir}"); then
> -		AC_MSG_ERROR([systemd user unit directory is
> required])
> +		path_userunitdir=3D"`$PKG_CONFIG --
> variable=3Dsystemduserunitdir systemd`"
> +		if (test -z "${path_userunitdir}"); then
> +			AC_MSG_ERROR([systemd user unit directory is
> required])
> +		fi
> =C2=A0	fi
> =C2=A0	AC_MSG_RESULT([${path_userunitdir}])
> =C2=A0fi
> =C2=A0AC_SUBST(SYSTEMD_USERUNITDIR, [${path_userunitdir}])
> +AM_CONDITIONAL(SYSTEMD_USERUNITS, test "${path_userunitdir}" !=3D "")
> +
> +AM_CONDITIONAL(SYSTEMD_UNITS, (test "${path_systemunitdir}" !=3D "" ||
> test "${path_userunitdir}" !=3D ""))
> +
> =C2=A0
> =C2=A0AC_ARG_ENABLE(datafiles, AS_HELP_STRING([--disable-datafiles],
> =C2=A0			[do not install configuration and data
> files]),
