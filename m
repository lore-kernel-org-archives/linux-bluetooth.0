Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFF7E56C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112484; cv=none; b=Wt9Q2Q6WEnQ/jkt7ldLY/DPbbDjAcY45oxsqqLHwCg8viNb+eXymjDSY9zNXvBzdEFPe+dxJZjr2IcobewjfC8BbAJs28EU+uPaRCGgHKxFHeyI4/FAFp49KpYShKlyG03ftx2QoaJYpm0QIsWYJzxbSBpuKOi6O8D+V3NC6KoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112484; c=relaxed/simple;
	bh=OzzMlvRUPsVuxo2uwdVZjdw1XvEQcNHqU3yi1nNQhrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRmmtb3DQ3uYlTYceSQGcL+FdCNVG3qhtp5/F2zMSvG6l7Tl+y2SxANXbOnAKyyS21ujpcVlu8wDUhUzow4tS6grUpH+ckVdZvdw3xN3q1oU02yJpxvB3dliyD2F5fTJCY9RVkOoPlI9VW7z4w0Q1ItiUIZWvMBkzaeC7ZUmncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ6dzOII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ6dzOII"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E04C43330;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112484;
	bh=OzzMlvRUPsVuxo2uwdVZjdw1XvEQcNHqU3yi1nNQhrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rZ6dzOIItjlHhvAGBn52iczO8/L92oPOtkDfgNJUpMCY+Vz77b3jd258ZBolNytMH
	 cXQuAA7gz+liIiVGnuYuaAHHHpj+j/V9S0mrevQSal2MJE5zeLDiiUhMebSDDx4Z2R
	 bAqIiT6k2C3leXMeyTrYlIcmThNEsrDNFWD1+jZXQF5GwaPte0LVD/9nH9SqAcEwGl
	 Tc2tEXXCePXSbNLAzmQYXpFao5FCvCkvhl81q7kbpZZwWhlttyEn/iFXIw6fhuJOFi
	 Whh1SIqNpkjdiimKKWBLCMG8ihv9hA4hiV7v0bvexd2Gle775SbLPl8t57a9eT2QGX
	 tMXdE3JLo8XrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3973BC48285;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:08:00 +0000
Subject: [PATCH BlueZ v2 4/8] bluetoothd: convert external sixaxis plugin
 to builtin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-rm-ext-plugins-v2-4-5244906f05ff@gmail.com>
References: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
In-Reply-To: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706112482; l=1169;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=rf/DV6bb4eocv72jDKDqDG7KvOMIubc6ZBWpK2UcaNg=;
 b=Py3+JdBHRaqUbOQT2T1Ril4VYqW538IlZ7V5wm902vr4KnNz0UAsfVnImc5t860VfUbGcLQ8o
 8MWuUwsJrUVAko0r9mrSAQlsd1VTLKQxFR5pNhLZGwaiGe1D+CJoT8K
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

