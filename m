Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75D1BDF7
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac1uA1Io"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEEA3C43394;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414737;
	bh=q29zwMnPHfDj+QDW3qBZFkRDk1zS2Y2PC4ZUEo65UAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ac1uA1IoTfme7nprz5Brvt33cPXb2mP2Ld34j0dYRsVWRl4HvxnRx4DNcRmZq4Csj
	 2HgQUGpVCucyRk+f/Q2vlN7vRPVh2hxHvrnimyv9o/3IHESfCfV1tOy4fSLJ/p9Oub
	 2X6ENa6/o3c68UUuOd6qmuoDlWFBfiAPM0pNpnMCqbOh04ygb1hzcfMqVlse5JpjTC
	 CZS32/WZg0THrEBYqcMYKkvzUVMkTqU50pFBw0dts6Q9JahQlkPE3TRmK0Qz3CzCNG
	 A0+PNCDRbzdO/SoyQox0n0Cxx6SjIb3m48QhVGMxDpaxli+4EZmjjsxSC/8KnZETpj
	 o4XkNYSJ3ezVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A30C47DB1;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:18:55 +0000
Subject: [PATCH BlueZ 3/8] plugins: remove external-dummy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-rm-ext-plugins-v1-3-62990fb07369@gmail.com>
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
In-Reply-To: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705414735; l=1467;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=FecdMyOyGLp8uWyLNLvMT2ck23keA9dEAYQHnkbOt9M=;
 b=X65MrH+reLklf1XqSb/Wwl5JI9ozm3QLlvebtoV1OnKPeeTKZz0NpSHk013hqMi8VfRiZl4c/
 +ax5bdQKvVFCcNe6On0jBTLAfguALkg47ls9MNTgm0X3aGVWrQ6yudZ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

The external plugins infra is going away - remove this dummy plugin.
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

