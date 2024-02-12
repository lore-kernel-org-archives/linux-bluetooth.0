Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CE47F69
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=d0hL7DAZpIJ0F94jJQ8MrO0a3He3LcB/s9LPd35oHusLD91zEWDv9Dkeruc5oGmA4L5d+Km2waIxyCK5brQ1jOWGO4OQwM956Kc5uT0GJxoivqhEA6p3RgyVcm6tAj33xLFQz6HDlKS2IBNC9Oqh501LKoT+ayMXIcUUZJzZRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=5btvwpoDeTsjWKw6B/3bS0i+ZrvloE4dM5K9xepdv3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aui/xwEcK93KiuYD7vh3tsYt4AjDJz/xCuM53HMEhg6WAMf4Mjg8DGKSqbrXzw5UFqQCw4o4x/ptu0D91klMDClvs8CaHfRCxqJEORsI2l1YobFGiW5hlkbhN5P3+WANYFpzNMIZaNe/x1VojHRoACIeGpwdW4+qGRm74k5+QvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdyavNr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdyavNr8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4800DC43601;
	Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768160;
	bh=5btvwpoDeTsjWKw6B/3bS0i+ZrvloE4dM5K9xepdv3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qdyavNr8xkmjLlTtBugJSjaIoTUknxqdoy4A1RlWR0VOfswzgL5rTO/2jR12r7YF8
	 a530UfTdSgk2QhLVwb2KnYWLtzx4lO/5A8qKflpQip8bzCZnvavdHbYwyazcYkclfV
	 1Yb7h8olVLTOFIkS2X0mvy8e5FG8FOC1nIWELmmFJlTLx+34Jx+jSsj9nHMWio+GNy
	 p9PfWezQhydjE2Cr8UhTUzJCTtmrzKh4pvdjhNNbWSWkGdG6q/YmOEeSq5E105qTql
	 s0UaOMwxVUZ36ydx7lrQDfXybXMREXjRap14Q0XtgedlPL/0197T6xtW418uhbRd3q
	 eB4gU1GguB74w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373ACC4829E;
	Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 20:02:46 +0000
Subject: [PATCH BlueZ v2 10/10] Allow using obexd without systemd in the
 user session
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-disto-patches-v2-10-8bab1bd08f4d@gmail.com>
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Giovanni Campagna <gcampagna-cNUdlRotFMnNLxjTenLetw@public.gmane.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=2136;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=qcOLWrp/zFE+VyNJF7l0mQSwvOHD0sHm7hQeD6mJ4p0=;
 b=rYipQQQoYBBKWJFCC4K7udhkanjCpN2+07thPENzUcgBhRU5BUTR/5vfKrY1ar12U8rlU3nhq
 z6nLK6nxg1eBkKbfhKMUWhe+JJOP/fGUr426X5ynFZJBomzeWigKJaD
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Giovanni Campagna <gcampagna-cNUdlRotFMnNLxjTenLetw@public.gmane.org>

Not all sessions run systemd --user and in some cases one may be missing
systemd all together.

Provide the correct path instead of /bin/false, allowing dbus to start
the service in such cases.

DBUS implementations can ignore the Exec line all together when run in
systemd aware mode - at least the OG dbus does that. So ultimately this
change is a no-op for the systemd --user case.

On my system, this is literally the only non-system service which uses
/bin/false.

[Emil Velikov]
Port to AC_CONFIG_FILES() .in files handling. Reword commit message.
---
 Makefile.obexd                                                  | 4 +---
 configure.ac                                                    | 1 +
 obexd/src/{org.bluez.obex.service => org.bluez.obex.service.in} | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 1d37a1bd4..d88708e66 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -8,12 +8,10 @@ install-data-hook:
 
 uninstall-hook:
 	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+endif
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
-endif
-
-EXTRA_DIST += obexd/src/org.bluez.obex.service
 
 if OBEX
 
diff --git a/configure.ac b/configure.ac
index 387db8c7d..c66991a3d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -457,6 +457,7 @@ AC_CONFIG_FILES(
 	mesh/bluetooth-meshd.rst
 	mesh/bluetooth-mesh.service
 	obexd/src/obex.service
+	obexd/src/org.bluez.obex.service
 	src/bluetoothd.rst
 	src/bluetooth.service
 	tools/bluetooth-logger.service
diff --git a/obexd/src/org.bluez.obex.service b/obexd/src/org.bluez.obex.service.in
similarity index 69%
rename from obexd/src/org.bluez.obex.service
rename to obexd/src/org.bluez.obex.service.in
index a53808884..14c16d3e3 100644
--- a/obexd/src/org.bluez.obex.service
+++ b/obexd/src/org.bluez.obex.service.in
@@ -1,4 +1,4 @@
 [D-BUS Service]
 Name=org.bluez.obex
-Exec=/bin/false
+Exec=@exec_prefix@/bluetooth/obexd
 SystemdService=dbus-org.bluez.obex.service

-- 
2.43.0

