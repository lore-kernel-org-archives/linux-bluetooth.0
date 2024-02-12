Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5947A73
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=XBHooj0cbjYE1ivXgW1l0qm7/df3f7l8tDP66ZQVPoTnMNLnI3Ikg/vUXBbti6AZ2TryjikPAmtfy8WYzA27EbLLVEjw/hbohakLk8jGEAzEohwxXrb40193aN5RKx0agGFoLJ983Awus0dInCkmS+SmgVjE1l1aAXbK85HxO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=VRgZPdA6D+8hoZ3UC+OUGz8Kti/bsHC2kA8oXFsh0lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt/NqIdwxcB/nWyfPao5RVVrxdYgW1wTcnC0LTwEZ0qJM+jDBzeHYbK+iFdg4FQEcydFerTVtAYkcTraDHTsdYRgqueQYbiPv04qp/ohBrwFvIIQ5uoiMY3kzXPe1rkwbda9dq/AUzCsBabGcFPT8gVE1gimcEEaFth27eEqINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY/keaxP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY/keaxP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2574C43399;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768160;
	bh=VRgZPdA6D+8hoZ3UC+OUGz8Kti/bsHC2kA8oXFsh0lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RY/keaxPxOO1xgdxbT+BAldn1umHmQXb7d+6oIh9hFMj23nOJ/nqJ3X54cmV2RbUP
	 bh5yqTJci8NVZNlVZ090K8HzRuSTaFa/YY56Tek4xajyZViqKFxfDIICdlGgriFifY
	 FdANXmWEqJezvNi1wAqc1krUxB/BAIE48QYxPpi/f1hhvlcG/mIvF9Ak/t1HG1r0VS
	 v0FsOhLHcTDDDo+IuKpAkzgE2knjLM+7WqB1j9zfiiEcgRtYH+qa/WVW231jEvfq6i
	 ltZ6alEsxBghTG+anmGEHs14WEC8dcKqHIfHjhUKn5SaZPauVKZP4AZ4TmSjEiiqN2
	 0a+/oPyLsRR0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEDCC48BC4;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 20:02:40 +0000
Subject: [PATCH BlueZ v2 04/10] profiles: remove unused suspend-dummy.c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-disto-patches-v2-4-8bab1bd08f4d@gmail.com>
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>, 
 Nobuhiro Iwamatsu <iwamatsu@debian.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=4509;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=O5urzcyyiP0SFKs5VIgx4wp/q8Y+jAMqWGPzk079OjY=;
 b=Uru47TI0PMzfQvm0Ttb61J+M5i54qWShbtOynQf7AixSdF6TK/Gs8ZP3KxsTV8XSjdylWK0B2
 G4haOgSVxLmBZhC9T3KYvCT8EkUBRsRo2cpdk3YzfDKQx1gHev/MLiQ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

The file has been used for about 8 years now - see commit
fb55b7a6ab48c4f782b16030e051029bcfa93e07 ("profiles/hog: Use no suspend
support instead of the dummy FIFO").

Inspired by a Debian patch by Nobuhiro Iwamatsu, which was changing the
/tmp/hogsuspend socket patch to /run. Looking through the codebase we
have a few more sockets that could use a to /run fix, but that will
follow-up at another day.

Cc: Nobuhiro Iwamatsu <iwamatsu@debian.org>
---
 Makefile.plugins               |   2 -
 profiles/input/suspend-dummy.c | 149 -----------------------------------------
 2 files changed, 151 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 7cf66fd59..e960eedea 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -74,8 +74,6 @@ builtin_sources += profiles/input/hog.c \
 			profiles/battery/bas.c profiles/battery/bas.h \
 			profiles/scanparam/scpp.c profiles/scanparam/scpp.h \
 			profiles/input/suspend.h profiles/input/suspend-none.c
-
-EXTRA_DIST += profiles/input/suspend-dummy.c
 endif
 
 if HEALTH
diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
deleted file mode 100644
index ea1835e0f..000000000
--- a/profiles/input/suspend-dummy.c
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Nordic Semiconductor Inc.
- *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
- *
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-
-#include <glib.h>
-
-#include "src/log.h"
-#include "suspend.h"
-
-#define HOG_SUSPEND_FIFO	"/tmp/hogsuspend"
-
-static suspend_event suspend_cb = NULL;
-static resume_event resume_cb = NULL;
-static guint watch = 0;
-
-static int fifo_open(void);
-
-static gboolean read_fifo(GIOChannel *io, GIOCondition cond, gpointer user_data)
-{
-	char buffer[12];
-	gsize offset, left, bread;
-	GIOStatus iostatus;
-
-	if (cond & (G_IO_ERR | G_IO_HUP)) {
-		/*
-		 * Both ends needs to be open simultaneously before proceeding
-		 * any input or output operation. When the remote closes the
-		 * channel, hup signal is received on this end.
-		 */
-		fifo_open();
-		return FALSE;
-	}
-
-	offset = 0;
-	left = sizeof(buffer) - 1;
-	memset(buffer, 0, sizeof(buffer));
-
-	do {
-		iostatus = g_io_channel_read_chars(io, &buffer[offset], left,
-								&bread, NULL);
-
-		offset += bread;
-		left -= bread;
-		if (left == 0)
-			break;
-	} while (iostatus == G_IO_STATUS_NORMAL);
-
-	if (g_ascii_strncasecmp("suspend", buffer, 7) == 0)
-		suspend_cb();
-	else if (g_ascii_strncasecmp("resume", buffer, 6) == 0)
-		resume_cb();
-
-	return TRUE;
-}
-
-static int fifo_open(void)
-{
-	GIOCondition condition = G_IO_IN | G_IO_ERR | G_IO_HUP;
-	GIOChannel *fifoio;
-	int fd;
-
-	fd = open(HOG_SUSPEND_FIFO, O_RDONLY | O_NONBLOCK);
-	if (fd < 0) {
-		int err = -errno;
-		error("Can't open FIFO (%s): %s(%d)", HOG_SUSPEND_FIFO,
-							strerror(-err), -err);
-		return err;
-	}
-
-	fifoio = g_io_channel_unix_new(fd);
-	g_io_channel_set_close_on_unref(fifoio, TRUE);
-
-	watch = g_io_add_watch(fifoio, condition, read_fifo, NULL);
-
-	g_io_channel_unref(fifoio);
-
-	return 0;
-}
-
-int suspend_init(suspend_event suspend, resume_event resume)
-{
-	struct stat st;
-	int ret;
-
-	DBG("");
-
-	suspend_cb = suspend;
-	resume_cb = resume;
-
-	if (stat(HOG_SUSPEND_FIFO, &st) == 0) {
-		if (!S_ISFIFO(st.st_mode)) {
-			error("Unexpected non-FIFO %s file", HOG_SUSPEND_FIFO);
-			return -EIO;
-		}
-
-		if (unlink(HOG_SUSPEND_FIFO) < 0) {
-			int err = -errno;
-			error("Failed to remove FIFO (%s): %s (%d)",
-				HOG_SUSPEND_FIFO, strerror(-err), -err);
-			return err;
-		}
-	}
-
-	if (mkfifo(HOG_SUSPEND_FIFO, 0600) < 0) {
-		int err = -errno;
-
-		error("Can't create FIFO (%s): %s (%d)", HOG_SUSPEND_FIFO,
-							strerror(-err), -err);
-		return err;
-	}
-
-	DBG("Created suspend-dummy FIFO on %s", HOG_SUSPEND_FIFO);
-
-	ret = fifo_open();
-	if (ret < 0)
-		unlink(HOG_SUSPEND_FIFO);
-
-	return ret;
-}
-
-void suspend_exit(void)
-{
-	if (watch > 0) {
-		g_source_remove(watch);
-		watch = 0;
-	}
-
-	unlink(HOG_SUSPEND_FIFO);
-}

-- 
2.43.0

