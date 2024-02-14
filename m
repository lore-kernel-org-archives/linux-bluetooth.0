Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932E13F01C
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948095; cv=none; b=Y8fvsQhZMCBmdSbllLPgcijikz4sRDLqMZSqztk7l2QFGyLFPuDAWlhk4+huS8nrfWEtdqZO8WL6QBgid6h0BoT71i+qL5ps8S7tzDQp3Una2qMuN6Rd2UemTtIjZnwoaUfFq40VQmGRPtzWFebrMFg5YIpk67aW4FNhAm4mfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948095; c=relaxed/simple;
	bh=qAFztN0HCZ3qg5GKsjanZvr4yrxmBNXRqF4CcsED0iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxrvW1Gp4XEIqm3o8wByCKSAo7Dj2JfDVUDhKu4pfc+ii7YAaFTugpHFm1Yp50FDeQDwgQG875S7cFrxW9irmnF6KoYdAYY3+W8QOokGPTnodK4keOZdk/QKEWkimB4QSBmOnntZAoXYtk3N2gUkVzgX3hN8uC15+HyHe45DOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnD5wo4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnD5wo4B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEDABC43399;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948094;
	bh=qAFztN0HCZ3qg5GKsjanZvr4yrxmBNXRqF4CcsED0iI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AnD5wo4BnUwC6Cpc7S8wEaFnBtooFvGEpeo1vjPq+8s8NmR4hga0joq+EARUdWkfi
	 fbROPccFTXyxWb35LFAP9cH1iRIxh15iK0/tIhLhnMSezR72R6IxGT2tViMWQZe0EX
	 ufqlUFMOGer/lppWa8sWA1Y2yhijSMpCdbgJ7TMZdgpA0XAzTlC+eHjdfy4Uv9cPtL
	 eQgG4caq/A8wgJj5nLnPQtLFRFhUIQi4gDxpmBcPFsAVFrFgK7+O0qR+Ye8eq5EV48
	 72aljg+Z3jMpMaQhOXT0sKdwXcldgOIqfAFDh39BaHi4DOEDarujypcopYPZp8s4ab
	 b0ZqQSEYlSW3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F0CC48BEF;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 14 Feb 2024 22:01:25 +0000
Subject: [PATCH BlueZ 2/4] build: install obexd (dbus,systemd} services as
 needed
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hook-fixup-v1-2-0e158ffea140@gmail.com>
References: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
In-Reply-To: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707948093; l=762;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=jk17tdzYCWPHANqvkVpH7To2uT5/ZyxPCpp1GyD4nKY=;
 b=pZTvANMpFnLl1VDWjSpTeH29E7c+oRJXeKsTUg4BsrVrOag1TFNLZQKHQ3vQIm6r4q+AKWa/R
 BKVMx4PZN1pDNpibQgtGNV9PuDjWHgzWbVazPO1YXc7sCYlFNeykiE7
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Currently we ship the service files, even when built with
--disable-obex.

Move the if OBEX guard few lines further up.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Makefile.obexd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index b91ca6644..4a89e0335 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+if OBEX
+
 if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
@@ -7,7 +9,6 @@ endif
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
 
-if OBEX
 
 obex_plugindir = $(libdir)/obex/plugins
 

-- 
2.43.1

