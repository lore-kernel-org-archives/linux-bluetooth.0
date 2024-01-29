Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B476664DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=CIPQytmK9AoyHExnI0dvnwaFKMBasnhZeqANqm4DvzOEYt1BgG7Qe9E286VSFqinQgpk0oCSkdZYolKOciOB8iU53zf3p5NjNSaPJd6TgWsImw4yjvNLG3OJE5At2XlpmViUKRyLEDJX8wJ6UgzcGoKuRvKJ0lX03f+uz4pjKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=XLSO3l0XdIpPwkgoc4l1xpQ1HRftjj49icAZy3iAi/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9VQlLQSefKTt3PPCIwYKoZ1ipShgd6P+hlErajOVpXSm9EbDlh/661bB4Ioff2++4o8WgchgdAJ+CY9Ga5v5l8/atjsdY26Hu5PYKBwmcyNC4lTuvNLU7e68r2v6w2ihn5ObTGRpGvKeMgb11toDCVTnsCBuSNtph5SW+mA2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYpFA0jO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYpFA0jO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E62F7C43394;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539456;
	bh=XLSO3l0XdIpPwkgoc4l1xpQ1HRftjj49icAZy3iAi/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dYpFA0jO3qxS6mlvqOrtJxwYYUPS9uwtVqe0RX+/67nGiSB5ztG9WFzOOiejX0ajF
	 WmshwIOSMIkAVha2/OjZSA+EVsfMR9jlyFIwtU9NKeFCXrlGBt0BU7eDfEKILOZ7HI
	 OtCxAhL8tEGJrNEPCG7sN4/GCfJSG1BAtwpwrQpV/r2FnY8x55ARj+Sdg7klPncllo
	 Evy3sXrRupxffhO5OEzB9S3G03hR8Hbau8zrp7hzwAzfj/nibYFLNSttwU4k3kS9VB
	 i6jHH4tRyyGHGsFKe2DQnc5mV5733ou9z5P2jPsO343mlaTU0Q7kxO5kfm16lPUk+z
	 9KGFnoXHoAu2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED37C4828C;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:17 +0000
Subject: [PATCH BlueZ v4 3/8] bluetoothd: remove external-dummy plugin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-3-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=1499;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=Qkz58Z8cPMkE6Ps/NGmx2S8bmRGDQE2Anw+Id8KSNeI=;
 b=80WqH9lZJW+58Gc8dcVjtF+auOhXuPiXyTvdcxmGnkuuWl6QuaghsRHkdZ0Ph6AYI9i5Ey+0Z
 5JYEfcrBOAMALIC1hmXRR3m12ZZy2KeS9AyoWpk2N7gqoetO9I6izGG
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
index 59603a0b7..9e35d7fd9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -289,14 +289,6 @@ builtin_ldadd =
 
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

