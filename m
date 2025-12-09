Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACA2D77F7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290331; cv=none; b=RVV1PEOo+KHew7G4VbQXAtnQgO+cD2KslpMuNdNEKUjQmacks9cKGOKqcXKZ3U6lpZcj11OQ9ze/HEUjmD77nj45SNj0x3xo8alPWcl3683e9RWqqfoh2+kFAr48BtGMQtdSdNOOTpnLnzzrCjUQzKU0bZByOKSYhSEVL12XoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290331; c=relaxed/simple;
	bh=f4xjLkwdFkP2X5ng/Kmam8FKAKKdIH+dYry/WO12Yjc=;
	h=Mime-Version:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=gsW43HXaaK/3ev7cdzWS1u1qXv+9hEg+6to+xfAlwLZlwHg2ZTrGTCNeY/UTWfZckEBU9M2gkwrlkrgmoh7pRzrQ41OFCuUS60/tJLjeaeNpvKlfGqkYkgqM0ex95FSBMlIYPukGeMTLFW9QGaMG1u8UnV3niguZ+xFmIhpuvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=jNEakK3U; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="jNEakK3U"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id E13DA9A28F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1765290312; h=date:message-id:subject:from:to;
	bh=f4xjLkwdFkP2X5ng/Kmam8FKAKKdIH+dYry/WO12Yjc=;
	b=jNEakK3U7iiZQ/0o9p8u1iltMcvsq0pPJalJEe7mzujnz1OK4ldx5J5guYh+cDxhiawQUdXGcFt
	dwVK/mk4124E6jxrZl5JCzQCpSRY1Nsr87RK5W+4XNsY+SY8YulMMHY96QIQqh1IYINS8mxnDVUDX
	kdWZ1pKtH+TWc9h/NIakhDmW5Sf5/6iKtqeIyZGn5ob+Cc5pXyiHaFjAyZDEAXoNvqJxxUm/wcUuV
	9VXPVZBOBj/retIN0a/UX6QeUScOjjt/Z3QKa01XutUDZa5nuDjxNNjXQwYFmxc4cw2V8njGqpSNO
	dhVO58QB+6g2nPhIy5duvimGdufEf/lZuKvw==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Dec 2025 15:25:02 +0100
Message-Id: <DETR6PAQCZNG.2PYMZRWQ9NPTS@achill.org>
Subject: Re: [PATCH BlueZ] build: Allow systemd unit build without
 libsystemd
From: "Achill Gilgenast" <achill@achill.org>
To: "Bastien Nocera" <hadess@hadess.net>, "Achill Gilgenast"
 <achill@achill.org>, <linux-bluetooth@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251208012421.838601-1-achill@achill.org>
 <eb393fee5cfc383397918349d1f714c7023bd3ca.camel@hadess.net>
In-Reply-To: <eb393fee5cfc383397918349d1f714c7023bd3ca.camel@hadess.net>
Content-Type: text/plain; charset=utf-8

On Mon Dec 8, 2025 at 12:57 PM CET, Bastien Nocera wrote:
> On Mon, 2025-12-08 at 02:24 +0100, Achill Gilgenast wrote:
>> Decouples libsystemd and systemd units from the same option and
>> allows
>> installation of services without systemd.pc by manually specifying
>> the
>> directories.
>>=20
>> This is useful in Alpine Linux where we don't ship systemd, but allow
>> systemd services to be subpackaged for downstream distributions like
>> postmarketOS.
>
> For what it's worth, this was already implemented in the meson port:
> https://github.com/hadess/bluez/commit/b8d12fa7eb9a5b7071eb130344a0816c46=
c87db8

Oh cool, I had no idea that a meson port existed. Do you know when this
will hit master?

>
>> ---
>> I'm by far no expert in autotools or bluez and how specific
>> components
>> are best categorized, so please let me know your feedback.
>> ---
>> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++-
>> =C2=A0Makefile.mesh=C2=A0 |=C2=A0 4 +++-
>> =C2=A0Makefile.obexd |=C2=A0 2 +-
>> =C2=A0Makefile.tools |=C2=A0 4 ++--
>> =C2=A0configure.ac=C2=A0=C2=A0 | 21 +++++++++++++++------
>> =C2=A05 files changed, 26 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/Makefile.am b/Makefile.am
>> index e152ae64853c..d3cdb2890d32 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -49,13 +49,17 @@ conf_DATA +=3D profiles/network/network.conf
>> =C2=A0state_DATA =3D
>> =C2=A0endif
>> =C2=A0
>> -if SYSTEMD
>> +if SYSTEMD_SYSTEMUNITS
>> =C2=A0systemdsystemunitdir =3D $(SYSTEMD_SYSTEMUNITDIR)
>> =C2=A0systemdsystemunit_DATA =3D src/bluetooth.service
>> +endif
>> =C2=A0
>> +if SYSTEMD_USERUNITS
>> =C2=A0systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
>> =C2=A0systemduserunit_DATA =3D
>> +endif
>> =C2=A0
>> +if SYSTEMD_UNITS
>> =C2=A0dbussystembusdir =3D $(DBUS_SYSTEMBUSDIR)
>> =C2=A0dbussystembus_DATA =3D src/org.bluez.service
>> =C2=A0endif
>> diff --git a/Makefile.mesh b/Makefile.mesh
>> index e4c9fa6a32e6..e9998a9cdd75 100644
>> --- a/Makefile.mesh
>> +++ b/Makefile.mesh
>> @@ -6,8 +6,10 @@ dbus_DATA +=3D mesh/bluetooth-mesh.conf
>> =C2=A0conf_DATA +=3D mesh/mesh-main.conf
>> =C2=A0endif
>> =C2=A0
>> -if SYSTEMD
>> +if SYSTEMD_SYSTEMUNITS
>> =C2=A0systemdsystemunit_DATA +=3D mesh/bluetooth-mesh.service
>> +endif
>> +if SYSTEMD_UNITS
>> =C2=A0dbussystembus_DATA +=3D mesh/org.bluez.mesh.service
>> =C2=A0endif
>> =C2=A0
>> diff --git a/Makefile.obexd b/Makefile.obexd
>> index 7ad74e1286b6..25aa8feb73d1 100644
>> --- a/Makefile.obexd
>> +++ b/Makefile.obexd
>> @@ -1,7 +1,7 @@
>> =C2=A0# SPDX-License-Identifier: GPL-2.0
>> =C2=A0if OBEX
>> =C2=A0
>> -if SYSTEMD
>> +if SYSTEMD_USERUNITS
>> =C2=A0systemduserunit_DATA +=3D obexd/src/obex.service
>> =C2=A0
>> =C2=A0obexd-add-service-symlink:
>> diff --git a/Makefile.tools b/Makefile.tools
>> index 561b03d0b95b..72dffe7cd005 100644
>> --- a/Makefile.tools
>> +++ b/Makefile.tools
>> @@ -74,7 +74,7 @@ pkglibexec_PROGRAMS +=3D tools/btmon-logger
>> =C2=A0tools_btmon_logger_SOURCES =3D tools/btmon-logger.c
>> =C2=A0tools_btmon_logger_LDADD =3D src/libshared-mainloop.la
>> =C2=A0
>> -if SYSTEMD
>> +if SYSTEMD_SYSTEMUNITS
>> =C2=A0systemdsystemunit_DATA +=3D tools/bluetooth-logger.service
>> =C2=A0endif
>> =C2=A0endif
>> @@ -340,7 +340,7 @@ tools_hex2hcd_SOURCES =3D tools/hex2hcd.c
>> tools/missing.h
>> =C2=A0
>> =C2=A0tools_mpris_proxy_SOURCES =3D tools/mpris-proxy.c
>> =C2=A0tools_mpris_proxy_LDADD =3D gdbus/libgdbus-internal.la $(GLIB_LIBS=
)
>> $(DBUS_LIBS)
>> -if SYSTEMD
>> +if SYSTEMD_USERUNITS
>> =C2=A0systemduserunit_DATA +=3D tools/mpris-proxy.service
>> =C2=A0endif
>> =C2=A0
>> diff --git a/configure.ac b/configure.ac
>> index 16b81aca37e6..2d9352b59557 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -352,29 +352,38 @@ AC_ARG_WITH([systemdsystemunitdir],
>> =C2=A0			AS_HELP_STRING([--with-
>> systemdsystemunitdir=3DDIR],
>> =C2=A0			[path to systemd system unit directory]),
>> =C2=A0					[path_systemunitdir=3D${withva
>> l}])
>> -if (test "${enable_systemd}" !=3D "no" && test -z
>> "${path_systemunitdir}"); then
>> +if (test "${enable_systemd}" !=3D "no" -o -z "${path_systemunitdir}");
>> then
>> =C2=A0	AC_MSG_CHECKING([systemd system unit dir])
>> -	path_systemunitdir=3D"`$PKG_CONFIG --
>> variable=3Dsystemdsystemunitdir systemd`"
>> =C2=A0	if (test -z "${path_systemunitdir}"); then
>> -		AC_MSG_ERROR([systemd system unit directory is
>> required])
>> +		path_systemunitdir=3D"`$PKG_CONFIG --
>> variable=3Dsystemdsystemunitdir systemd`"
>> +		if (test -z "${path_systemunitdir}"); then
>> +			AC_MSG_ERROR([systemd system unit directory
>> is required])
>> +		fi
>> =C2=A0	fi
>> =C2=A0	AC_MSG_RESULT([${path_systemunitdir}])
>> =C2=A0fi
>> =C2=A0AC_SUBST(SYSTEMD_SYSTEMUNITDIR, [${path_systemunitdir}])
>> +AM_CONDITIONAL(SYSTEMD_SYSTEMUNITS, test "${path_systemunitdir}" !=3D
>> "")
>> =C2=A0
>> =C2=A0AC_ARG_WITH([systemduserunitdir],
>> =C2=A0			AS_HELP_STRING([--with-
>> systemduserunitdir=3DDIR],
>> =C2=A0			[path to systemd user unit directory]),
>> =C2=A0					[path_userunitdir=3D${withval}
>> ])
>> -if (test "${enable_systemd}" !=3D "no" && test -z
>> "${path_userunitdir}"); then
>> +if (test "${enable_systemd}" !=3D "no" -o -z "${path_userunitdir}");
>> then
>> =C2=A0	AC_MSG_CHECKING([systemd user unit dir])
>> -	path_userunitdir=3D"`$PKG_CONFIG --variable=3Dsystemduserunitdir
>> systemd`"
>> =C2=A0	if (test -z "${path_userunitdir}"); then
>> -		AC_MSG_ERROR([systemd user unit directory is
>> required])
>> +		path_userunitdir=3D"`$PKG_CONFIG --
>> variable=3Dsystemduserunitdir systemd`"
>> +		if (test -z "${path_userunitdir}"); then
>> +			AC_MSG_ERROR([systemd user unit directory is
>> required])
>> +		fi
>> =C2=A0	fi
>> =C2=A0	AC_MSG_RESULT([${path_userunitdir}])
>> =C2=A0fi
>> =C2=A0AC_SUBST(SYSTEMD_USERUNITDIR, [${path_userunitdir}])
>> +AM_CONDITIONAL(SYSTEMD_USERUNITS, test "${path_userunitdir}" !=3D "")
>> +
>> +AM_CONDITIONAL(SYSTEMD_UNITS, (test "${path_systemunitdir}" !=3D "" ||
>> test "${path_userunitdir}" !=3D ""))
>> +
>> =C2=A0
>> =C2=A0AC_ARG_ENABLE(datafiles, AS_HELP_STRING([--disable-datafiles],
>> =C2=A0			[do not install configuration and data
>> files]),
