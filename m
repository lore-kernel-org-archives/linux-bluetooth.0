Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5F148FE9
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=ZFk2r6kjq9eVoFx32SnpG/Ot3Ljy4OghKMTJmmhli3cBTFIXlRHKGqCfUgZAT8h7Z2C5zGOcyCYAfyKUDy8hk7IoMP7AGgF++qb37NXbl23FFHmTNJuNbqItoHMb3oA2k/CqN7Lwc8SvDlOP60Pu3X2GXFk4tcoM2eRukYELuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=YBFZWOMPNTnFzWYlSB9+DBEXXEhdj2IL5RZYHTbpTkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9wfyNU1kNWb1gMbyIB3OxAB1DocShxHPIN4yihGdeoEQ5OuGeRLt+SnH+N+fPxFh/QLK11U/KChn/QsLAPFomPS/6mP4E2Qbk+IKXkGwjc49goi7kbcG5+keNIirNZ2d2j0KMvbN3+1JlkKdVm8JdBrdf/0hniogCYwh72dVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Doh9niGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Doh9niGu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DA06C43394;
	Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=YBFZWOMPNTnFzWYlSB9+DBEXXEhdj2IL5RZYHTbpTkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Doh9niGum8mGqUV+vMzDfELrysH/9DemtSJUrFF2Lag+oi4zXZwammJigDHR2K/zA
	 dSwab9nD2yQlAiH5dkq0C2Z8EOUTG+IIvE+xt0WxHhJgMCgvMH6E6liGO18SafH2qv
	 IO2ni4SAqc8gLKIa46WylYQc7FmT9rHgIwMU6dS1ju1C64hqfBht9artMPhw+rshUG
	 oi8qswL1Em52L9LXAFt7hRzQmNwUmmcv/5ZfOqggWB1DXRR/IS48Ei2Pj5QeqqagEg
	 sVYYGtZhEOjNfIdG0ddx4l8hja/wuCtdNO2I28kJ05MRlbjobXTCnTALdh9PE9INNH
	 KyZTwT+tg2H9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE12C48BF6;
	Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:12 +0000
Subject: [PATCH BlueZ v2 08/10] build: obexd: remove duplicate include
 -I$(builddir)/lib
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-8-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125069; l=710;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=OZRKsu59444Zoitt96/ZqOD/W5o3DtQdHZSS7Mt3Auw=;
 b=QQ1PG6y7ObZvheXibgk3YuKIGNRxjiKJxTOdlax43C0JPqbilmVBEzBhk/wS1PnFr4cddze0S
 m4gKvTKmUIoDyMphPCHlDNCd+AhDGrK4AjlVe20OM+VPnd5iK/5pHUw
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

The -I$(builddir)/lib include is already in the AM_CPPFLAGS. Drop the
duplicate instance in obexd.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Makefile.obexd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 01aa3a9c7..385e5618d 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -102,7 +102,7 @@ obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 				$(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
 				-DPLUGINDIR=\""$(obex_plugindir)"\" \
 				-D_FILE_OFFSET_BITS=64 \
-				-I$(builddir)/lib -I$(builddir)/obexd/src
+				-I$(builddir)/obexd/src
 
 else
 obexd-add-service-symlink:

-- 
2.43.1

