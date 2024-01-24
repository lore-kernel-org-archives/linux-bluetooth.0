Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5387E566
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112484; cv=none; b=XeBJRLJVrIMn/cohyDNC0hE0zRjBQd6fH+37HPVxy73LB870WJPo5j7hlIU8/pfxXqOW/sd7O2nIlN+pQxxrXtAJVvsDriTIq75K7ZJjQKQd4lguIL8mbYtAIj1MjlGw070c9iJLFxtivrVEMOZrPMmWBRRCOfIcRSSSNjQamPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112484; c=relaxed/simple;
	bh=l4M0CYae6sACNUXdM/RsB3Lv49E/9xZZDseXRMJSHq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOWCV2a7mx4yZjxs45PyvLNOQnNrl+1njBPeJI9jTZmV3ZgQf8ZBBiRbB/rK0tQTtml6exKuMtBXTuKLZZlmVbjJMRZ/fkLSLcbew/z+JBbgJbAawpILSRrMa+93glL7EDYJouIw2oMSG1q+Kd7ixM2y+IZ5NOmdmtop9Hob3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrIg8Hn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrIg8Hn9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 437D4C433B2;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112484;
	bh=l4M0CYae6sACNUXdM/RsB3Lv49E/9xZZDseXRMJSHq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hrIg8Hn9vlUaR9SYp+vjr2aPx3EdQFfz2GziULUwA38wLc31stLHN0CR7/o+pIJz4
	 IVmRmqkDx/4yzZSlwGqDyudE0V5kyo0RmjMIZGU24zgLprmQWwvZN4JlB4NTHdve1v
	 u+6NNMUWfIOs2eU7aQFG2sfAWnDW8oX+8MhqHToOYhp6O3zF3YNoAZ7mgQzdl5aisk
	 SZ9X+8bQRQtn58oBVdL3HCe3ln0BaFYsKuS/GkSe02S9GHxwxNUhLr8HwASWhAC3LM
	 jxvQAeROQmBSUbrH0pPG67fnGFonqPT87W9STfrvfPbxGyjERXINIUai72E5d6xs/d
	 Wkp9KJIt8E3sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB0BC47E49;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:07:59 +0000
Subject: [PATCH BlueZ v2 3/8] bluetoothd: remove external-dummy plugin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-rm-ext-plugins-v2-3-5244906f05ff@gmail.com>
References: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
In-Reply-To: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706112482; l=1499;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=EjARRPevchGHDkRRE9GXFlLSL06rTs7sjbEgjh12uig=;
 b=ZIHZDeCR9elO3hjmYcxf38mHEk89NHJwIeNS1CjQ0qMq0osCQhYPhZbpbQZdvd4A5IdK5yhdm
 WCWyDkf94aBDXrws2HdDq834pFZ5gJqasqnc111rEf6kFGGjsaHbIkp
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

The external plugins infra is getting deprecated and disabled by
default. Remove this dummy plugin.
---
 Makefile.am              |  8 --------
 plugins/external-dummy.c | 28 ----------------------------
 2 files changed, 36 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e738eb3a5..ea51b25cc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,14 +293,6 @@ builtin_ldadd =
 
 include Makefile.plugins
 
-if MAINTAINER_MODE
-plugin_LTLIBRARIES += plugins/external-dummy.la
-plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
-plugins_external_dummy_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
-				    -no-undefined
-plugins_external_dummy_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
-endif
-
 pkglibexec_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
deleted file mode 100644
index 1c209e8b7..000000000
--- a/plugins/external-dummy.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include "src/plugin.h"
-#include "src/log.h"
-
-static int dummy_init(void)
-{
-	DBG("");
-
-	return 0;
-}
-
-static void dummy_exit(void)
-{
-	DBG("");
-}
-
-BLUETOOTH_PLUGIN_DEFINE(external_dummy, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_LOW, dummy_init, dummy_exit)

-- 
2.43.0

