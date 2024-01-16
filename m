Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE781BDFB
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApJLJNf7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AADF5C43601;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413118;
	bh=oSBR49ZYtm2Ne2TBfdgcT8bcfRYNWoBxVia8FYQ10Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ApJLJNf70bDvQUBBSE9L3bzkeRo1FiTUMqLrcR4fmkqNRKJ5TUETtlsl85tYvy1RS
	 Cws14670FSLv3zM5kaBPxnmbcJohlFcWJUWvswqnSnm3EP3FJme2fmmzvyHpHNmpIG
	 jGdEwpZwCCUr4/4VVQS2qmkjSXSM0Wd+pE4NWRbOd0xGj+Sx7mBNpwPXK25pByLZfP
	 7QyDlz4DkGNinOY6Q6+xnA8drjHHfug+yPQEFRbdDrq4zIkWlZ8Ue3LIvLAFuP6osJ
	 XZCVpAzzau2k1igxdhFx0xDpl/lR861tlp255970iLNHfe9wBRW+WStE8bEFN0NrI7
	 fQE3LUHYV8PkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A943C47077;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 13:52:00 +0000
Subject: [PATCH BlueZ 06/10] build: remove .service files from DEPENDENCIES
 lists
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-autofoo-v1-6-626f6b54bd06@gmail.com>
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413116; l=2006;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=DuGow5VEhfCAdhkTLDcYWkDA2anwlvRVmTKY2spMLAs=;
 b=stau6M2z0zUkfJnG32fvib7RtUs/Yv5GMyHxHncOVRZfCsBmsh+ZWsHzw9RgzVOwzMXdNPUdO
 1HvJeDY9c4xChBWIW/Q/ihAfLhuhk+irWPPRMByJGQwYFJE3ZTS3cxz
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

The DEPENDENCES lists are for binary objects, while the service files
are required by systemd (et al) after the install stage. The services
files are referenced by _DATA, so the service.in -> service conversion
can happen then.
---
 Makefile.am    | 3 +--
 Makefile.mesh  | 3 +--
 Makefile.tools | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 564f1b935..2be214631 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -335,8 +335,7 @@ src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 				gdbus/libgdbus-internal.la \
-				src/libshared-glib.la \
-				src/bluetooth.service
+				src/libshared-glib.la
 
 src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\" \
diff --git a/Makefile.mesh b/Makefile.mesh
index 63f085de1..a66e47442 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -45,8 +45,7 @@ mesh/main.$(OBJEXT): src/builtin.h lib/bluetooth/bluetooth.h
 
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
-mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la \
-				mesh/bluetooth-mesh.service
+mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
 
 if MANPAGES
 man_MANS += mesh/bluetooth-meshd.8
diff --git a/Makefile.tools b/Makefile.tools
index e541084e9..6fda3f51d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -71,8 +71,7 @@ pkglibexec_PROGRAMS += tools/btmon-logger
 
 tools_btmon_logger_SOURCES = tools/btmon-logger.c
 tools_btmon_logger_LDADD = src/libshared-mainloop.la
-tools_btmon_logger_DEPENDENCIES = src/libshared-mainloop.la \
-					tools/bluetooth-logger.service
+tools_btmon_logger_DEPENDENCIES = src/libshared-mainloop.la
 
 if SYSTEMD
 systemdsystemunit_DATA += tools/bluetooth-logger.service

-- 
2.43.0

