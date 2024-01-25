Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F337EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=JU4oE7DU0K4Hj3dmKMyvfDfDPhwEekdNSiTken2h9gUZoTMnJ0IzLmO+vjHSqe7hTcDYO4QgjVmjEO9tym+M5hFOP6/Dz/+gDH420g7szgZCyy5VVW7kbsJhhQGTJ6dlAF4QqaLu9R4ICuA25Iw3zQwKhgFUBYhqYNDqaezmLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=l4M0CYae6sACNUXdM/RsB3Lv49E/9xZZDseXRMJSHq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRQVulpkAO61S7c4L0DdhuLZJGwlFIobAjwZueYlOlflNyPnBGKkreS8IIIRQt9w77Jg3CGPRlUrXoz4XtW6IjA3mhY9Z2rvjyqUEgUO7fB4kXrdxXczB7z3k2Nk71HBhlfhM6lYJRBxY4hbvlOJt3tv7P0I3EePSHdBuJIeFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTuOGrKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTuOGrKz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56093C43399;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=l4M0CYae6sACNUXdM/RsB3Lv49E/9xZZDseXRMJSHq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JTuOGrKzc/nBg/f1oZW1FJAysHpv9R9Inerc8CRdJnnkqTkdW3sDC6ERQNzX2WAPE
	 BHOnOZwKT9gH8LOhruCGA5hixfm/Eoza8JLJASjOww6b7GFEz1yNcSeAW5osYDgaLF
	 B17XLMiNQevp2bhXX7bti0R+4QifVoINbYQQrhwJA07cNRht9BVcwh/X1Ga3Tnfqkd
	 FrwYjTd+ESNE9ru2fGvXFeLhqEhS79QwYUdWj3dpo/ZB3kcaEV19pQDfkVxjyIDZp7
	 KEGzgoO2itdXjWhpDrBthbi4f6hE+8CvmAGSi1ysPTq+vjeaWILxvIZAiAHaUpXPS8
	 LriE62vmTQ7Dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFFC47422;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:28 +0000
Subject: [PATCH BlueZ v3 3/8] bluetoothd: remove external-dummy plugin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-3-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=1499;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=EjARRPevchGHDkRRE9GXFlLSL06rTs7sjbEgjh12uig=;
 b=juwWclaFPWcNd5TdWC+/p4fMBo+sdoJQR4TpExGNPc2KAmyVsySvm5XtHUk0307MGLbTJIV2U
 1g3dsfY5ypcDX+nljfxVJTfqC4YZRy4kr/zf4v9DXKvGf+50os3SKDz
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

