Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267617A2FA
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765157081; cv=none; b=pYnzhQnVKV2/ZWqtetBGZL1/xUdFwDrbbNgP+D1XKP++776orQ/dO4f6NfIVHtrCc8QuC0R7KKaMQZnxaPMHvI1coB+wuRAowUTTNObC5eaj/SL5i50NAToY+Xk11H1+pNvsMBgZWLt39vfWia+rDGSWkm/XA5tau5ybvkjkwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765157081; c=relaxed/simple;
	bh=V7Bq5vUzKKrNbv2Qlo5mNzYXUJ2CwvhpqlKhI9xpItg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m54S3+Z2rf9vDI1P4okziDMmaD1MmeuyWKnzSG5rh9sVvVmqs7DcXhkpH+21emdpofF7GQ2Ue37+Qv0a4QCJdDtjGxuJsiVmz9dMILHRku6r6znAGSn/CM/zez8af4e6O6AK+oY6tRuBq1FCV2Qeer+I+A6bHHhfnJDChP/busE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=n1smoppV; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="n1smoppV"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id B336F9A0B45
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1765157065; h=date:message-id:subject:from:to;
	bh=V7Bq5vUzKKrNbv2Qlo5mNzYXUJ2CwvhpqlKhI9xpItg=;
	b=n1smoppV+dqDBDn0nF07sCFT3RIUVOZQhdX6ZaD1CCfxHzvXYpTHpe/G8DbxruqH9hy67HXkl6C
	1gIbBLFNmS8eUYq3JARuIWUw/bVp0lvYZUFAc8kdDGPbQfutXUI8JETpCQQAyDXumleTC6oR8Ln+Y
	CsfHHv/yX9wtC5L88WDPdlgLbYUR+EY3BSnFPMas0ry0NhhCmCPq8eXON31X+Iq/eunjN42U161AD
	8LLTKpw9hFkY5C5HikBwAJaNA3m0jx63VS/4dwnkDlLljU0arwPJEHLX4U4T71bP6koquET2vuo0H
	Sng3226N9FgOjFRHWVUxHRcCxRdf+mGL2VHA==
From: Achill Gilgenast <achill@achill.org>
To: linux-bluetooth@vger.kernel.org
Cc: Achill Gilgenast <achill@achill.org>
Subject: [PATCH BlueZ] build: Allow systemd unit build without libsystemd
Date: Mon,  8 Dec 2025 02:24:18 +0100
Message-ID: <20251208012421.838601-1-achill@achill.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Decouples libsystemd and systemd units from the same option and allows
installation of services without systemd.pc by manually specifying the
directories.

This is useful in Alpine Linux where we don't ship systemd, but allow
systemd services to be subpackaged for downstream distributions like
postmarketOS.
---
I'm by far no expert in autotools or bluez and how specific components
are best categorized, so please let me know your feedback.
---
 Makefile.am    |  6 +++++-
 Makefile.mesh  |  4 +++-
 Makefile.obexd |  2 +-
 Makefile.tools |  4 ++--
 configure.ac   | 21 +++++++++++++++------
 5 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e152ae64853c..d3cdb2890d32 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -49,13 +49,17 @@ conf_DATA +=3D profiles/network/network.conf
 state_DATA =3D
 endif
=20
-if SYSTEMD
+if SYSTEMD_SYSTEMUNITS
 systemdsystemunitdir =3D $(SYSTEMD_SYSTEMUNITDIR)
 systemdsystemunit_DATA =3D src/bluetooth.service
+endif
=20
+if SYSTEMD_USERUNITS
 systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA =3D
+endif
=20
+if SYSTEMD_UNITS
 dbussystembusdir =3D $(DBUS_SYSTEMBUSDIR)
 dbussystembus_DATA =3D src/org.bluez.service
 endif
diff --git a/Makefile.mesh b/Makefile.mesh
index e4c9fa6a32e6..e9998a9cdd75 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -6,8 +6,10 @@ dbus_DATA +=3D mesh/bluetooth-mesh.conf
 conf_DATA +=3D mesh/mesh-main.conf
 endif
=20
-if SYSTEMD
+if SYSTEMD_SYSTEMUNITS
 systemdsystemunit_DATA +=3D mesh/bluetooth-mesh.service
+endif
+if SYSTEMD_UNITS
 dbussystembus_DATA +=3D mesh/org.bluez.mesh.service
 endif
=20
diff --git a/Makefile.obexd b/Makefile.obexd
index 7ad74e1286b6..25aa8feb73d1 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 if OBEX
=20
-if SYSTEMD
+if SYSTEMD_USERUNITS
 systemduserunit_DATA +=3D obexd/src/obex.service
=20
 obexd-add-service-symlink:
diff --git a/Makefile.tools b/Makefile.tools
index 561b03d0b95b..72dffe7cd005 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -74,7 +74,7 @@ pkglibexec_PROGRAMS +=3D tools/btmon-logger
 tools_btmon_logger_SOURCES =3D tools/btmon-logger.c
 tools_btmon_logger_LDADD =3D src/libshared-mainloop.la
=20
-if SYSTEMD
+if SYSTEMD_SYSTEMUNITS
 systemdsystemunit_DATA +=3D tools/bluetooth-logger.service
 endif
 endif
@@ -340,7 +340,7 @@ tools_hex2hcd_SOURCES =3D tools/hex2hcd.c tools/missing=
.h
=20
 tools_mpris_proxy_SOURCES =3D tools/mpris-proxy.c
 tools_mpris_proxy_LDADD =3D gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS=
_LIBS)
-if SYSTEMD
+if SYSTEMD_USERUNITS
 systemduserunit_DATA +=3D tools/mpris-proxy.service
 endif
=20
diff --git a/configure.ac b/configure.ac
index 16b81aca37e6..2d9352b59557 100644
--- a/configure.ac
+++ b/configure.ac
@@ -352,29 +352,38 @@ AC_ARG_WITH([systemdsystemunitdir],
 			AS_HELP_STRING([--with-systemdsystemunitdir=3DDIR],
 			[path to systemd system unit directory]),
 					[path_systemunitdir=3D${withval}])
-if (test "${enable_systemd}" !=3D "no" && test -z "${path_systemunitdir}")=
; then
+if (test "${enable_systemd}" !=3D "no" -o -z "${path_systemunitdir}"); the=
n
 	AC_MSG_CHECKING([systemd system unit dir])
-	path_systemunitdir=3D"`$PKG_CONFIG --variable=3Dsystemdsystemunitdir syst=
emd`"
 	if (test -z "${path_systemunitdir}"); then
-		AC_MSG_ERROR([systemd system unit directory is required])
+		path_systemunitdir=3D"`$PKG_CONFIG --variable=3Dsystemdsystemunitdir sys=
temd`"
+		if (test -z "${path_systemunitdir}"); then
+			AC_MSG_ERROR([systemd system unit directory is required])
+		fi
 	fi
 	AC_MSG_RESULT([${path_systemunitdir}])
 fi
 AC_SUBST(SYSTEMD_SYSTEMUNITDIR, [${path_systemunitdir}])
+AM_CONDITIONAL(SYSTEMD_SYSTEMUNITS, test "${path_systemunitdir}" !=3D "")
=20
 AC_ARG_WITH([systemduserunitdir],
 			AS_HELP_STRING([--with-systemduserunitdir=3DDIR],
 			[path to systemd user unit directory]),
 					[path_userunitdir=3D${withval}])
-if (test "${enable_systemd}" !=3D "no" && test -z "${path_userunitdir}"); =
then
+if (test "${enable_systemd}" !=3D "no" -o -z "${path_userunitdir}"); then
 	AC_MSG_CHECKING([systemd user unit dir])
-	path_userunitdir=3D"`$PKG_CONFIG --variable=3Dsystemduserunitdir systemd`=
"
 	if (test -z "${path_userunitdir}"); then
-		AC_MSG_ERROR([systemd user unit directory is required])
+		path_userunitdir=3D"`$PKG_CONFIG --variable=3Dsystemduserunitdir systemd=
`"
+		if (test -z "${path_userunitdir}"); then
+			AC_MSG_ERROR([systemd user unit directory is required])
+		fi
 	fi
 	AC_MSG_RESULT([${path_userunitdir}])
 fi
 AC_SUBST(SYSTEMD_USERUNITDIR, [${path_userunitdir}])
+AM_CONDITIONAL(SYSTEMD_USERUNITS, test "${path_userunitdir}" !=3D "")
+
+AM_CONDITIONAL(SYSTEMD_UNITS, (test "${path_systemunitdir}" !=3D "" || tes=
t "${path_userunitdir}" !=3D ""))
+
=20
 AC_ARG_ENABLE(datafiles, AS_HELP_STRING([--disable-datafiles],
 			[do not install configuration and data files]),
--=20
2.52.0
