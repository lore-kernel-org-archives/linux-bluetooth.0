Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B87CF1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113209; cv=none; b=NrrnZZ1q7/vquyf+nvsjX9Zg9eOZDwGEjNNTmKVdd6S2vleLHWqy7C14ZtK1XK43ZgVCboMCc2tOIQVOjoVP5prGx6z5NWhW0nPFV0Ghl34Qnicx4AtxfHSeCA1LqshPG8vb8u5n3tuUb97qHflzV4p9f2CmdMrwxmcOq6C7fcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113209; c=relaxed/simple;
	bh=toyJ4GrY7o8KYOgecH7/KThdc2ubpDqyQCXsnPn9xww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4DpSyBZKfP7XE+CA3C4tA/i6WNItyD4WzUEde+ZjoGQ0GgmR8EU/pgIALb91RxHwAaUaeqmx+7asHzvyG5xKCilVaUf2ddAr65L82roJEhW0f9VfK8xJHlwHGds7QmAe7uVD6vfO9xX5MP/WUfLp+0oS8QdwPSbMci1XeVcQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbhevjPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbhevjPv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A7A3C433A6;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113209;
	bh=toyJ4GrY7o8KYOgecH7/KThdc2ubpDqyQCXsnPn9xww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dbhevjPvbaHTAI36gnb4ni4niUalicdGm/1fhVq/XxSZLX///85HxN0nUIYCwyXuP
	 gG7oeQEMLaRshpSdGdgi2D8SG7MD1tmVwWOVJML7f9/038IYodjFEEDPGFWxlTevzW
	 DN0XBNNH+EcHqZlhyDeeKz+Czc1WZvnrKJn5IdeAniPgk97ffeMPrfXxZPBaNXrlnl
	 Ak8U+W8WvTq9kh5GhBkZRScPUMfV8ckzUWiN2QfV4GYx7cXCj+YF50UVwEa3y6HN5a
	 Ez+xMcLZajvjSAvBDQj5rwc8/Eb2ACifYPKWRyz6Dz6ydcca3qxG/0oyRWVcmO7jxz
	 L632P0JipYhtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE5C48285;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:20:09 +0000
Subject: [PATCH BlueZ v2 4/6] build: manage .service.in files via
 configure.ac
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-autofoo-v2-4-a210f20aa2f7@gmail.com>
References: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
In-Reply-To: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706113208; l=6157;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=rLzrk85DeqngNt6mdM8WnH+vWX4MHWwZz3Hi/NGeDbQ=;
 b=3rTe4Zch6HHf5+ZFmVrpiqEU/hPEQU5uLWuqtcYbRRMk6s04dk1v8aHWPwPabGPCHSOBkay5M
 QJirzQvAJ3SCYP9Cdz+R2mGH1SdEM6L8NWQGSQh2uWCb0gCfLeoPLXd
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Considering we do basic substitution, we don't need to manually sed,
track dependencies, dist nor clean. Just add the files to
AC_CONFIG_FILES() call it a day - it does everything for us.
---
 Makefile.am                       | 14 ++------------
 Makefile.mesh                     |  5 +----
 Makefile.obexd                    |  4 ++--
 Makefile.tools                    |  3 ---
 configure.ac                      | 11 ++++++++++-
 mesh/bluetooth-mesh.service.in    |  2 +-
 obexd/src/obex.service.in         |  2 +-
 src/bluetooth.service.in          |  2 +-
 tools/bluetooth-logger.service.in |  2 +-
 9 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b913402b3..59603a0b7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -47,7 +47,7 @@ dbussystembusdir = $(DBUS_SYSTEMBUSDIR)
 dbussystembus_DATA = src/org.bluez.service
 endif
 
-EXTRA_DIST += src/bluetooth.service.in src/org.bluez.service
+EXTRA_DIST += src/org.bluez.service
 
 plugindir = $(libdir)/bluetooth/plugins
 
@@ -345,7 +345,7 @@ builtin_files = src/builtin.h
 
 nodist_src_bluetoothd_SOURCES = $(builtin_files)
 
-CLEANFILES += $(builtin_files) src/bluetooth.service
+CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
@@ -736,13 +736,6 @@ MAINTAINERCLEANFILES = Makefile.in \
 	aclocal.m4 configure config.h.in config.sub config.guess \
 	ltmain.sh depcomp compile missing install-sh mkinstalldirs test-driver
 
-SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
-		$(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
-		       -e 's,@libexecdir\@,$(libexecdir),g' \
-		       -e 's,@statedir\@,$(statedir),g' \
-		       -e 's,@confdir\@,$(confdir),g' \
-		< $< > $@
-
 if RUN_RST2MAN
 RST2MAN_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 			$(RST2MAN) --strict --no-raw \
@@ -752,9 +745,6 @@ RST2MAN_PROCESS = $(AM_V_GEN)test -f $@ || \
 		{ echo "Generated manual page $@ does not exist"; false; }
 endif
 
-%.service: %.service.in Makefile
-	$(SED_PROCESS)
-
 %.1: %.rst Makefile
 	$(RST2MAN_PROCESS)
 
diff --git a/Makefile.mesh b/Makefile.mesh
index 45fa90339..ea50383d2 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -51,9 +51,6 @@ man_MANS += mesh/bluetooth-meshd.8
 endif
 manual_pages += mesh/bluetooth-meshd.8
 
-CLEANFILES += mesh/bluetooth-mesh.service
-
 endif
 
-EXTRA_DIST += mesh/bluetooth-mesh.conf mesh/bluetooth-mesh.service.in \
-		mesh/org.bluez.mesh.service mesh/mesh-main.conf
+EXTRA_DIST += mesh/bluetooth-mesh.conf mesh/org.bluez.mesh.service mesh/mesh-main.conf
diff --git a/Makefile.obexd b/Makefile.obexd
index 5d1a4ff65..c2b5c6d7a 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -7,7 +7,7 @@ dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
 endif
 
-EXTRA_DIST += obexd/src/obex.service.in obexd/src/org.bluez.obex.service
+EXTRA_DIST += obexd/src/org.bluez.obex.service
 
 if OBEX
 
@@ -112,6 +112,6 @@ obexd/src/builtin.h: obexd/src/genbuiltin $(obexd_builtin_sources)
 	$(AM_V_at)$(MKDIR_P) $(dir $@)
 	$(AM_V_GEN)$(srcdir)/obexd/src/genbuiltin $(obexd_builtin_modules) > $@
 
-CLEANFILES += obexd/src/builtin.h $(builtin_files) obexd/src/obex.service
+CLEANFILES += obexd/src/builtin.h
 
 EXTRA_DIST += obexd/src/genbuiltin
diff --git a/Makefile.tools b/Makefile.tools
index 1cde39f94..044342e29 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -77,9 +77,6 @@ systemdsystemunit_DATA += tools/bluetooth-logger.service
 endif
 endif
 
-CLEANFILES += tools/bluetooth-logger.service
-EXTRA_DIST += tools/bluetooth-logger.service.in
-
 if TESTING
 noinst_PROGRAMS += emulator/btvirt emulator/b1ee emulator/hfp \
 					peripheral/btsensor tools/3dsp \
diff --git a/configure.ac b/configure.ac
index cab5da581..b4d362494 100644
--- a/configure.ac
+++ b/configure.ac
@@ -441,5 +441,14 @@ if (test "${plugin_phonebook}" = "ebook"); then
 fi
 AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])
 
-AC_CONFIG_FILES(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
+AC_CONFIG_FILES(
+	lib/bluez.pc
+	Makefile
+	mesh/bluetooth-meshd.rst
+	mesh/bluetooth-mesh.service
+	obexd/src/obex.service
+	src/bluetoothd.rst
+	src/bluetooth.service
+	tools/bluetooth-logger.service
+)
 AC_OUTPUT
diff --git a/mesh/bluetooth-mesh.service.in b/mesh/bluetooth-mesh.service.in
index c8afbf53e..9c3ff01a3 100644
--- a/mesh/bluetooth-mesh.service.in
+++ b/mesh/bluetooth-mesh.service.in
@@ -5,7 +5,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 [Service]
 Type=dbus
 BusName=org.bluez.mesh
-ExecStart=@pkglibexecdir@/bluetooth-meshd
+ExecStart=@exec_prefix@/bluetooth/bluetooth-meshd
 NotifyAccess=main
 LimitNPROC=1
 ProtectHome=true
diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index fc0dce993..03d09a679 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -4,7 +4,7 @@ Description=Bluetooth OBEX service
 [Service]
 Type=dbus
 BusName=org.bluez.obex
-ExecStart=@pkglibexecdir@/obexd
+ExecStart=@exec_prefix@/bluetooth/obexd
 
 [Install]
 Alias=dbus-org.bluez.obex.service
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index beb98ce0c..63e157587 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -6,7 +6,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 [Service]
 Type=dbus
 BusName=org.bluez
-ExecStart=@pkglibexecdir@/bluetoothd
+ExecStart=@exec_prefix@/bluetooth/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
 #Restart=on-failure
diff --git a/tools/bluetooth-logger.service.in b/tools/bluetooth-logger.service.in
index 009002731..5657c8d84 100644
--- a/tools/bluetooth-logger.service.in
+++ b/tools/bluetooth-logger.service.in
@@ -4,7 +4,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 
 [Service]
 Type=simple
-ExecStart=@pkglibexecdir@/btmon-logger -p -b /var/log/bluetooth/hci.log
+ExecStart=@exec_prefix@/bluetooth/btmon-logger -p -b /var/log/bluetooth/hci.log
 NotifyAccess=main
 CapabilityBoundingSet=CAP_NET_RAW
 LimitNPROC=1

-- 
2.43.0

