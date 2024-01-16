Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348F1BF25
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La4mUWC4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2FBAC4166A;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413118;
	bh=UCRr7mExKULPEhuMSeVm/SL6b5yFc2e+yH0Met1qPRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=La4mUWC4cM9nIlTdXdzo0nttJ3WlXRdZ26ELs8MH8I0leJk1AH9nxwzkIOL8hsKGw
	 MDOYJ7MVqitELaDrUdEAaKr7oTgDRx+dbqKJ/ZiGMMcEv9qtyOdQXg6qMaay07x0s+
	 jsj72o6pn0VoerDeGpkPLf9tfX5X1JRWWy4XCV2y6rc/rMtsmxe+5/6MuwdWYOAA/D
	 d5KGAjD620WQrC0CdZFUEdM5+gEgksJPMSgotTuG/xXWS5Lt6wwSrj1FSd5zA7+rOR
	 K6XFWxjH4/DTnQ/TgAjJ2ThUVEuutU/bESSe+4/FBXmiO2o5p4yt1s6XkH/z8Dn3kV
	 WQ3Ihvy/4KVag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A51C47DA6;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 13:52:01 +0000
Subject: [PATCH BlueZ 07/10] build: remove explicit DEPENDENCIES handling
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-autofoo-v1-7-626f6b54bd06@gmail.com>
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413116; l=3024;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=gNLYCa6gQWMALTDx8zted1MgMRNVmkqOD1MZVczYw+8=;
 b=owCAWh6QAAMYL8ZcPObqTFrWy2kTp/oylq5lR8F/UIC2kNOB1RwhvFzRt8z3JrGIjtTtFcyGF
 YWLj5gEVEY7BbusNWW0ZJwyK/C9plSRVyiIUN4YlvTWw8EUueUNrck1
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

We currently duplicate the DEPENDENCIES handling that autotools does for
us. We have two types of objects - libraries or generated headers.

Former are part of the LDADD, the latter in BUILT_SOURCES.
---
 Makefile.am    | 7 -------
 Makefile.mesh  | 1 -
 Makefile.tools | 2 --
 3 files changed, 10 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2be214631..6007f9eb7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -77,7 +77,6 @@ lib_LTLIBRARIES += lib/libbluetooth.la
 
 lib_libbluetooth_la_SOURCES = $(lib_headers) $(lib_sources)
 lib_libbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -version-info 22:12:19
-lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 endif
 
 noinst_LTLIBRARIES += lib/libbluetooth-internal.la
@@ -94,12 +93,10 @@ gdbus_libgdbus_internal_la_SOURCES = gdbus/gdbus.h \
 if EXTERNAL_ELL
 ell_cflags = @ELL_CFLAGS@
 ell_ldadd = @ELL_LIBS@
-ell_dependencies =
 ell_built_sources = ell/shared
 else
 ell_cflags =
 ell_ldadd = ell/libell-internal.la
-ell_dependencies = $(ell_ldadd)
 ell_built_sources = ell/shared ell/internal ell/ell.h
 
 noinst_LTLIBRARIES += ell/libell-internal.la
@@ -333,10 +330,6 @@ src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
-src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
-				gdbus/libgdbus-internal.la \
-				src/libshared-glib.la
-
 src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\" \
 					$(BACKTRACE_CFLAGS) $(builtin_cppflags)
diff --git a/Makefile.mesh b/Makefile.mesh
index a66e47442..45fa90339 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -45,7 +45,6 @@ mesh/main.$(OBJEXT): src/builtin.h lib/bluetooth/bluetooth.h
 
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
-mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
 
 if MANPAGES
 man_MANS += mesh/bluetooth-meshd.8
diff --git a/Makefile.tools b/Makefile.tools
index 6fda3f51d..1cde39f94 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -71,7 +71,6 @@ pkglibexec_PROGRAMS += tools/btmon-logger
 
 tools_btmon_logger_SOURCES = tools/btmon-logger.c
 tools_btmon_logger_LDADD = src/libshared-mainloop.la
-tools_btmon_logger_DEPENDENCIES = src/libshared-mainloop.la
 
 if SYSTEMD
 systemdsystemunit_DATA += tools/bluetooth-logger.service
@@ -577,7 +576,6 @@ noinst_PROGRAMS += tools/btpclient tools/btpclientctl
 tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
 tools_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
-tools_btpclient_DEPENDENCIES = lib/libbluetooth-internal.la $(ell_dependencies)
 tools/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
 
 tools_btpclientctl_SOURCES = tools/btpclientctl.c client/display.c

-- 
2.43.0

