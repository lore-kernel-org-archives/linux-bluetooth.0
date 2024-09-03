Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AE13D245
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374589; cv=none; b=nTqAiE4FTDacSA7SGDxEkiU6v/swMKGHx6o2bUZrHeg9y0DhiktzRmiTl5q/5IcTadUeoYtYDOpGvcys5I1yDQk5Dy2HCvRhbkDW4Sncf2hyb0O14gRI9658jFReD1O4mYIkWtj6hkHvoCOLWlLzB4aFtECtqzaJjtN7w/0gjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374589; c=relaxed/simple;
	bh=yfPa8oQ4CfHzdOQ29L9HmYocw0jcEMWowqBxsGxeoS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KafMwe5XuwqhA7IYfK1868y51clwRIf78ovKqB5T59CrCOqDYWPeQJ68H6+DpNIQc3t8YMQDxCHQUzzAU5Rxbk1gSEO+CbpY4lPE4CWhoj3rJVN1h+zzi/xi+SXHdvdez2QXNbeX/p7wRpT+xfzl8FICf98I8WHmfFBipgnIrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=LJZ7o/q5; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=ISqNOGDO; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="LJZ7o/q5";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="ISqNOGDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1725374038; bh=yfPa8oQ4CfHzdOQ29L9HmYocw0jcEMWowqBxsGxeoS0=;
	h=From:To:Subject:Date:From;
	b=LJZ7o/q5seuqepYc7WCUygNMEJ3uAXDngZaF/lSc+45/hn600xTjseSwWota1vjGU
	 SCfmJdrqum9a0L162QFW8lxA8ZD0AJbImiqFeVDbdYEuegXOjoPTxHnM7oLFaqRfBb
	 Qe6X9LH0KaHg956v11ZoDwvwhiBa5xqUt5vOHZ8AhyvqCg73p6HReNLsYxSPCYzwWF
	 VV9bMyKDyde67PhvbLjzQEbZl+NBcpkaGzkZW30DV/PPnInftL+fNWA8yU8HVspeQy
	 XjAN4OmUs4+9MmR+5jDIJ9lMT1g+IBC1difpKEZ+uLbPz0gTqdkDgAuzJKq8qKYdRf
	 kSNIcIqz2oVVw==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 2EDC4FB03
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 16:33:58 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KoTmxpNbC4y8 for <linux-bluetooth@vger.kernel.org>;
	Tue,  3 Sep 2024 16:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1725374036; bh=yfPa8oQ4CfHzdOQ29L9HmYocw0jcEMWowqBxsGxeoS0=;
	h=From:To:Subject:Date:From;
	b=ISqNOGDOb+B45eJjYcbVmVPR8i9TsrzxZiRvtYpUbywbftAU6jd8ykW2ETgNzbutr
	 vJod3J+VpaTf7dVLC/TkL0DSMW+g9ZxUpacCzrKA1IjulSru4jCK+yviGhg7H9W10u
	 CIicGH8XzYw+I1bTGlFj6jMZMT/j8FUXroijWKs5Ng4UMWZQbFH9+bazC3izrK5IHM
	 4g1muJfAY2KgRrJ4KUXhzaU1Il98CurUhYJzknqwDka+jj6rclbLz6FcohiUpr6FUD
	 G4BbEXqNjJimfTMjjmpl5+r+XknGdm1PVaKG1pGmaISmhF2Dn6ip5wuOGVZDQXLaSF
	 5Du4tCmNq4z+A==
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/mpris-proxy: Add systemd user unit
Date: Tue,  3 Sep 2024 16:33:15 +0200
Message-ID: <3548acb9bee2d1d8e0bd8e650a8557241e9e76ca.1725373981.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

That way it will be started automatically which is convenient on phones.
Distributions can then decide part of which install the unit should be.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Makefile.am                  |  3 +++
 Makefile.obexd               |  3 +--
 Makefile.tools               |  3 +++
 configure.ac                 |  9 +++++++++
 tools/mpris-proxy.service.in | 13 +++++++++++++
 5 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 tools/mpris-proxy.service.in

diff --git a/Makefile.am b/Makefile.am
index 46a8cfb..976c272 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -49,6 +49,9 @@ if SYSTEMD
 systemdsystemunitdir = $(SYSTEMD_SYSTEMUNITDIR)
 systemdsystemunit_DATA = src/bluetooth.service
 
+systemduserunitdir = $(SYSTEMD_USERUNITDIR)
+systemduserunit_DATA =
+
 dbussystembusdir = $(DBUS_SYSTEMBUSDIR)
 dbussystembus_DATA = src/org.bluez.service
 endif
diff --git a/Makefile.obexd b/Makefile.obexd
index b7e9f2d..4cdce73 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -2,8 +2,7 @@
 if OBEX
 
 if SYSTEMD
-systemduserunitdir = $(SYSTEMD_USERUNITDIR)
-systemduserunit_DATA = obexd/src/obex.service
+systemduserunit_DATA += obexd/src/obex.service
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
diff --git a/Makefile.tools b/Makefile.tools
index f4f9e82..dea399f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -332,6 +332,9 @@ tools_hex2hcd_SOURCES = tools/hex2hcd.c
 
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
+if SYSTEMD
+systemduserunit_DATA += tools/mpris-proxy.service
+endif
 
 tools_gatt_service_SOURCES = tools/gatt-service.c
 tools_gatt_service_LDADD = gdbus/libgdbus-internal.la \
diff --git a/configure.ac b/configure.ac
index d31eb16..6332645 100644
--- a/configure.ac
+++ b/configure.ac
@@ -428,6 +428,14 @@ fi
 #
 # Otherwise we'll end up with literal references in the final binaries or
 # manuals, which is not something we really want.
+#
+pkgbindir="${bindir}"
+if (test "$bindir" = '${exec_prefix}/bin'); then
+	pkgbindir="${exec_prefix}/bin"
+else
+	pkgbindir="${bindir}"
+fi
+AC_SUBST(PKGBINDIR, "${pkgbindir}")
 
 if (test "$libexecdir" = '${exec_prefix}/libexec'); then
 	pkglibexecdir="${exec_prefix}/libexec/bluetooth"
@@ -496,5 +504,6 @@ AC_CONFIG_FILES(
 	src/bluetoothd.rst
 	src/bluetooth.service
 	tools/bluetooth-logger.service
+	tools/mpris-proxy.service
 )
 AC_OUTPUT
diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
new file mode 100644
index 0000000..5307490
--- /dev/null
+++ b/tools/mpris-proxy.service.in
@@ -0,0 +1,13 @@
+[Unit]
+Description=Bluetooth mpris proxy
+Documentation=man:mpris-proxy(1)
+
+Wants=dbus.socket
+After=dbus.socket
+
+[Service]
+Type=simple
+ExecStart=@PKGBINDIR@/mpris-proxy
+
+[Install]
+WantedBy=default.target
-- 
2.45.2

