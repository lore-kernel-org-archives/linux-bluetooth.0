Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7451487F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=QDe6XY/g6WRyCHxb8Jho90semLvmraPmygQWb0GTVXnDEvblVudSC+aAPPvM/oIHRJf44r0/I2YXeqiZ1sHynp2vflrkfLZW0utkvs++7N6Byu0r8HMABFcGOlQ+xZ6pCLIQpANq1TyWxg/0Sa4ceNtfk/R4+ZGc+UPA0Io/RQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=pn4oXOiprsJ9P+/w7VthZ06gnonlcvDwigv5H1AczbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=iNKDuRu/vYMOpCarooiXblLR6lf4y5aihHDBBkcDMmaPwHhWgO0sHo9fWcFtCEf8etb4lzTZ7idA0/2NWa5XtDcNXjSksvfpEt7s9zusSINFjvwY+BG32Acw11k/8XuZJ3RJ6YJNr+r0q+6rX9do+BSonorQJSZVoWzsN+JPjew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNt7DmlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNt7DmlD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03BFDC43390
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=pn4oXOiprsJ9P+/w7VthZ06gnonlcvDwigv5H1AczbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To:From;
	b=QNt7DmlDvdgltjZzwKSN39HQ46JaTlT/VgZpLtVlBz1kE4ulwwWFOi2x3t4FqiUyd
	 rubZ83CH5ouSe0dyidyEBTxyLMdJfoODTFK9JCXCEssvQ7VvayTz8DBDz+4RzdD4Tc
	 N71FEWWP/Z/RfSuZU4kpn+aZPmEvUOQRGvGnRF1q6KbQnnBG7eIGRVNi7sAkMUim3Y
	 mdn3+4MtQYvt0TejiDrymS83qym0iz9UgAW8fiiXfWPwnrF45CwCpsJF+PTKH1btIN
	 9F/xD+R8MkculwfK1fn+MuB7WNgilobGkfGpqYvg1l2b1lCtBkJJPb0+dg4nsGWjoe
	 N0/E17hERIMYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF694C48BF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:10 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:06 +0000
Subject: [PATCH BlueZ v2 02/10] build: install obexd (dbus,systemd}
 services as needed
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-2-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125068; l=708;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=ydMrW4KQq1RxtsNE5Z3GD8gOdVpX/eInfAQOzvCNhPM=;
 b=IrYvb1KVOghrustydreRo3bmyf2og6elMhJBTvp+Y0TbzI7qTGuQPiB0b1hSXzDQHXXSxnBXQ
 K2QeywgpuavAtAGEmgRUGM7CedeeoFoKeaQl+LP4GwYSBJfYVcujLMP
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Currently we ship the service files, even when built with
--disable-obex.

Move the "if OBEX" guard few lines further up.
---
 Makefile.obexd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 0e8bc6de7..e8e4a6144 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+if OBEX
+
 if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
@@ -16,7 +18,6 @@ endif
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
 
-if OBEX
 
 obex_plugindir = $(libdir)/obex/plugins
 

-- 
2.43.1

