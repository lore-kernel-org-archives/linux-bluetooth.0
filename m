Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9F184524
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567375; cv=none; b=af8YHhn6YzhgJDQChAlF3RWk8kGiYULRhQZ2gVaQ+/hln1tuAmZhI3R5CsAiaOSO+6mI+fLomBPUKhPFdrw2k0ArPpQeKlTx5iI3YxXJl9oCdSYGBT+jVlNBWN0pi7u6XWk59TJ47fHX+6m2RaJSe64/7PMaT+cjwz8OY36kqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567375; c=relaxed/simple;
	bh=ck+xIis7chfjd/eg+ShFludcg3y98OprFvr8QmEofbo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OoHxya8gdffjglhLZscUdqI54cVk6uWRh/H/25UHM0tCtUIZTcBQq1Ih+1Q5fP4XwEFmBQEQa6l5awTbn83YMWLDG+ZSbjof0PsR7me8I8FO8L0yc7mPDQkWI4Gx3otFldcpKtKtr0T+lEs7isWHuyVtNapkOuFrTipG9rnODTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=kqdxX7k7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GkcW8uLh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="kqdxX7k7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkcW8uLh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A083F1400248
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 14:29:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 14:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1751567371; x=1751653771; bh=o+hwJpCxnpj2M2R3dVwb4
	6FuhZ0NCpaHB+2TMOFyxoM=; b=kqdxX7k7dXoCsjH3Wx1L/blxcE8qiTFCQjOjz
	JLqfosjm0PtR6tMfUdN4h3KDeR0Ac6hha2bxoReIDkREMozg/lAcH9K//E8DWtpo
	e6vNwrhcfT1mRyTEPyejwH3MQGOrcdwKReiMMJf7XDvDRWannziuxvZIn0JNqbfE
	ajoipp5t4PPyaumA7Fz9aFcHTHU/YJ6hBCC8A6ld3oyzuxZisoTUqtX4CAAMv2ls
	aa2ykZ1E7Lwjt/XuqwXi/E4kYGwg51EH1PGR1pRPtMzKbMhW+7BnIrNkdwPgoQff
	z3vzDQHvIwoBLAJ8D2LpARAVvEtlYrpAGEYt4cyFmtPRlx2nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751567371; x=1751653771; bh=o+hwJpCxnpj2M2R3dVwb46FuhZ0NCpaHB+2
	TMOFyxoM=; b=GkcW8uLhka41pAWIsneth/vbYbtk2iAWa9oJ4ZVJWgscmJDIXoN
	TOaXeWzJk2sF6SZGROFCKwsl153E0KVOkDulW52bMliib6wpQI2hdwhHUt11j+Sd
	MbqheHjKTtQpHfDueDKtv5a3ipDH0mCYkHOeAemiXq+yF9tfYQGNao8CYRR+LAB9
	avGOP3FsmOAVVknVth+RC5Lx+NzhKPAt1vCQ0kK3S00wg/jcd+VfUZXPNx7JCzoD
	2xBCbgHn5bKfDHBFc1hNh4HqrvN09mmzD3FIwqrAFRjTZIRPKUUdQDHTDGDrX0kj
	yvYGaHlQ2jJnlO7745dCFBkc6JtgxC+BGRw==
X-ME-Sender: <xms:C8xmaOfrfRNOsWGfTW5OrZXArFmA1GDSBe-Fj5PUlM89yX9sbegS9g>
    <xme:C8xmaIMXeYHcoCgJVhGOQtSBaB9Qrw1g-KmBj9-Bfzs3siOLTlUcENx1OxVq3yigo
    x0K0c8RDGGORcXT7A>
X-ME-Received: <xmr:C8xmaPgM0ynvux41yQbmyy1ZTGOk_wJZNbTgLxy3ndXc1xfb2fPTAWk0Q5cKFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucgg
    tffrrghtthgvrhhnpeehvdffgffhteeijefgteeftdfghfdvheeuhedvjedugfeggfelje
    fgleefvefgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepuddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C8xmaL_BBra9xi8Vaak8uCfpoMzxMSwD9vjLg686n7E2hsF23INjDw>
    <xmx:C8xmaKvcSQ2nyimEhQyemOw_ehMauuk2ETvYABsuJtgYLt31IzBAng>
    <xmx:C8xmaCEzPz2gGRfwiLm7OsH82LSyWalhKNEyjGmtdikxnpk-BUIbIA>
    <xmx:C8xmaJP84Q5l42s4E7rJBbpacszVM4lRecIjHh5nbPJLkklFC4D-Rg>
    <xmx:C8xmaELQ28xYCOqaCohkIsYquDUEQEpkWyRfhQ71KVK1gQ0iwES7FIQg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-bluetooth@vger.kernel.org>; Thu, 3 Jul 2025 14:29:31 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 5A27F26F299BC; Thu, 03 Jul 2025 20:29:30 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: use pkg-config to find readline
Date: Thu,  3 Jul 2025 20:29:08 +0200
Message-ID: <20250703182908.2370130-1-hi@alyssa.is>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardcoding -lreadline won't do the right thing when other libraries
need to be linked too, which is the case when static linking.
pkg-config can take care of finding the right libraries for us, so use
it instead of checking for headers.
---
 Makefile.tools | 18 +++++++++---------
 configure.ac   |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index e60c31b1d..6d7fcffa1 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -18,7 +18,7 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/hci.h client/hci.c
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
-			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
+			$(GLIB_LIBS) $(DBUS_LIBS) $(READLINE_LIBS)
 endif
 
 if ZSH_COMPLETIONS
@@ -380,7 +380,7 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 				tools/mesh-gatt/onoff-model.c
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
-				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
+				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c $(READLINE_LIBS)
 
 EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 endif
@@ -399,7 +399,7 @@ tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
 				mesh/crypto.h mesh/crypto.c
 
 tools_mesh_cfgclient_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
-						$(ell_ldadd) -ljson-c -lreadline
+						$(ell_ldadd) -ljson-c $(READLINE_LIBS)
 
 bin_PROGRAMS +=  tools/mesh-cfgtest
 
@@ -506,7 +506,7 @@ noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 						tools/obex-client-tool.c
 tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
-			       src/libshared-glib.la $(GLIB_LIBS) -lreadline
+			       src/libshared-glib.la $(GLIB_LIBS) $(READLINE_LIBS)
 
 tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 						tools/obex-server-tool.c
@@ -517,16 +517,16 @@ tools_bluetooth_player_SOURCES = tools/bluetooth-player.c client/print.c \
 				client/player.c
 tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
 				src/libshared-glib.la \
-				$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
+				$(GLIB_LIBS) $(DBUS_LIBS) $(READLINE_LIBS)
 
 tools_obexctl_SOURCES = tools/obexctl.c
 tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
-			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
+			$(GLIB_LIBS) $(DBUS_LIBS) $(READLINE_LIBS)
 
 tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c \
 			client/mgmt.c
 tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
-				-lreadline
+				$(READLINE_LIBS)
 if DEPRECATED
 noinst_PROGRAMS += attrib/gatttool
 
@@ -536,7 +536,7 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/utils.c src/log.c client/display.c \
 				client/display.h
 attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
-			src/libshared-glib.la $(GLIB_LIBS) -lreadline
+			src/libshared-glib.la $(GLIB_LIBS) $(READLINE_LIBS)
 
 endif
 endif
@@ -586,5 +586,5 @@ tools/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
 
 tools_btpclientctl_SOURCES = tools/btpclientctl.c client/display.c
 tools_btpclientctl_LDADD = src/libshared-mainloop.la src/libshared-glib.la \
-				lib/libbluetooth-internal.la -lreadline
+				lib/libbluetooth-internal.la $(READLINE_LIBS)
 endif
diff --git a/configure.ac b/configure.ac
index 10d63d67f..cae4e6f0c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -330,8 +330,7 @@ AC_ARG_ENABLE(client, AS_HELP_STRING([--disable-client],
 AM_CONDITIONAL(CLIENT, test "${enable_client}" != "no")
 
 if (test "${enable_client}" != "no" || test "${enable_mesh}" = "yes"); then
-        AC_CHECK_HEADERS(readline/readline.h, enable_readline=yes,
-                AC_MSG_ERROR(readline header files are required))
+        PKG_CHECK_MODULES([READLINE], [readline], enable_readline=yes)
 fi
 AM_CONDITIONAL(READLINE, test "${enable_readline}" = "yes")
 

base-commit: 50fb9042e1ad471115e21ed83daebae278594aa7
-- 
2.49.0

