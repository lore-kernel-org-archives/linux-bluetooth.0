Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D7657DB
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=qJOZGMGZdLLsguSTggsPfVTQ/mgEVlfRQMXTC/D2/BHFOIL4rLK7nxDztD0ON0L8MKFA3DpiUuZyNFhgJfGenY7b7yFSP/vzU0Ocex4qZHnMdNqmYOYXkXA4C5qaFmzk4/lZMPQwzrgZB86TSsi1/H1LltB6hZF2/SNW34Dymlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=OzzMlvRUPsVuxo2uwdVZjdw1XvEQcNHqU3yi1nNQhrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8qDSXdoXbIuJ4bK8gRk1jZg99uM+iEKf+kX0JLAjHfuGQrgRevuxbXZFFtVpoS7PCqrGsXpoW7zq9jjPlklEzhKcGNhCAIrFHITd+DdqYSr3kDT3QWlXh9p0RIKfMPfM4Kr2GIPCjFASUitwOzpaK0zLktvjOn/PavyBRCYpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD7rkTCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD7rkTCM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC49AC43399;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539457;
	bh=OzzMlvRUPsVuxo2uwdVZjdw1XvEQcNHqU3yi1nNQhrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jD7rkTCMzLlTJqYSZqD/EcK01NtMEQoyJiai8pXo1P8wnvueGh7LYTQE3kEtSv7Fn
	 3IHU+AlFQmFWJSvIKhDEPxCYBga4I6Sy5rhm8SiS4fy+IZcPb8Kdea3iz2Ci4FfYlB
	 PRubrsej++GSP8TulXhasNN9XYmBysB3epTc3vBu75HASyI3ShfJoe84hu8VRi+JwR
	 Y53vi+yzHSXobSwSFeyqX8KYAjvMNBWrK37ey8D2/O0qSmrPLrq3ly0u/xFVvpyRWe
	 2dc5zBah9lkW25CEztV1JoVOfl9pFSl3ZoyTgC4rho6Pbs6cEHJNdkEiG9jLtjE7dc
	 t/DBmmh7G/OHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE8C47DDB;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:18 +0000
Subject: [PATCH BlueZ v4 4/8] bluetoothd: convert external sixaxis plugin
 to builtin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-4-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=1169;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=rf/DV6bb4eocv72jDKDqDG7KvOMIubc6ZBWpK2UcaNg=;
 b=LpvifZ947TFhdMkhkLq+ZXA8o8W3kZb21ATZ17SDCuUgnVWqd4paSy/5mpAv3u1kzhsOGvnpN
 C8/kIVmsFuPC3kAiI0VPn/dbRvRdlqjpGugOEqDstFFL54DvhCgt2z0
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Convert the only known external plugin to built-in. It's a tiny 20K
binary that distros ship a separate package for.

Make it a builtin, which allows distros to drop the separate package, it
also enables us to compile out support for external modules - both in
terms of extra code and hide the internal bluetoothd API.

This means that libudev.so is pulled in, which is fine since its ABI has
been stable for over a decade.
---
 Makefile.plugins | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 5880ed0df..7cf66fd59 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -110,11 +110,9 @@ builtin_modules += battery
 builtin_sources += profiles/battery/battery.c
 
 if SIXAXIS
-plugin_LTLIBRARIES += plugins/sixaxis.la
-plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
-plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
-plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
-plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
+builtin_modules += sixaxis
+builtin_sources += plugins/sixaxis.c
+builtin_ldadd += $(UDEV_LIBS)
 endif
 
 if BAP

-- 
2.43.0

