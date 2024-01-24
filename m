Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9537CF23
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113209; cv=none; b=Sxf7SrzpHStzbYodtH1pvtcsTecrK5R64bKxuwI6Hny18XE0T871y2swVSycCv8K8ze0bAM1C7xdGUmm9T99u0vdyWxx4tQ9FRj0E1FPARtvb7glNYbxvFhLiUgZAHtFoObowORf897GySl1ydmaXHU/DTPgMayN195GMe5NPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113209; c=relaxed/simple;
	bh=dVTUZQkYwPKvUuWPXkou9GBGhKLkuj2YH5CkA7Rt2fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smG4+YqGswEQdUUpvRKveVfi4/5FcykFWw4WAQnxQDZkcJz1YzSWpzBMrLylWGWB6fJIkxjAf4FFUORAisfyNtgWrS+HI3jRU8HKwSITxM67xWdpvijRvW1gFQ5osZ3Tgm7we9uGtqhcbq7e5xE27TrQkhh3kIx9tJu1e0qTeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsShKkQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsShKkQO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C6A9C43394;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113209;
	bh=dVTUZQkYwPKvUuWPXkou9GBGhKLkuj2YH5CkA7Rt2fM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LsShKkQOnijGCGgh2DIhEuVk1WSWxnUF4ygMEVE0xn7WPtPXaMjJcTcYd7GZD7u/g
	 McHfQp7nJu2Kd7qcMGrY9e7G7xrJfUFeCrCk1PvuC+6hXeOrB5QEC1mlPmVjY2wX2P
	 zExynbC7UViI9T3OqhizdHMSVxy2du5wqAIotrmXRbyEsCirQk3UBuZKXNFcV2VWOr
	 iVOitVzXFZ4QaDCdxxYOmjZnc3W3xsnFtIBLjva2S4WGZZwrHuPMFOdXjkimVJkLqy
	 BZCgZJT8NL6p+E3jZIME2/ftMMJ4vLzzL8PKG2azK6YRpE6KHGLbuBVYyKlCMfA689
	 nI3tpMuaLoM5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B4C48260;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:20:07 +0000
Subject: [PATCH BlueZ v2 2/6] build: remove .service files from
 DEPENDENCIES lists
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-autofoo-v2-2-a210f20aa2f7@gmail.com>
References: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
In-Reply-To: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706113208; l=2006;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=762dq8m5AI+SZ17OHCwzsFezHIwdX+iiIO34RX2fr1g=;
 b=QbQo9uv7Uea+Clh7WUkyIBen1bVqzha3q0ywR4wKCHPMWufsnwXG+5yG7ByVS6r36eyWk96nH
 zMvaoRzSukFASyXiM2dluABIG3MVG+yinOESxQhex/5T7yY2wPKhCs8
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
index a470e40cf..be8f74f13 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -341,8 +341,7 @@ src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 
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

