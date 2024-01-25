Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AD385
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=NT5N0Rlqt8jSAG/MqJrKlqSZtP3iM7veJ9sEOy8vBr+PN59sKJHxgeyxXr4Kjq8AW+jaXZ0Am0hcmwW+F6P4kqccK5kbymuBf/e9qEQaqXubjl3hN9QaBTXa+E3D0WLtUfZU41GwMOiJhW7uFxPuR5yORSwSZnJneS/7sMgHgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=OzzMlvRUPsVuxo2uwdVZjdw1XvEQcNHqU3yi1nNQhrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOPNJEUWmfP3DmdjAdiy2FNarhM0WEogqYTYm+Pp0X5tUFqtjJNlq6Q8uhT5WuAiDp3Hq5WkJfO4Jq2mQr8sGnmVPIqMGb0lIQxxr+vOUBnTY132KwWeynm6dhdLyRxAbji1aW60RcQZqUmFUI21PCYH9DLBeLuEnfwquZPA/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHW/H8PP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHW/H8PP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61862C43394;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=OzzMlvRUPsVuxo2uwdVZjdw1XvEQcNHqU3yi1nNQhrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SHW/H8PPoCBoHf52Bn8eEUh7pzpSNvINcIACQ6mNYzQlG+5LCDUzotWD0xIE15dKx
	 MYpCDs9TMdsDdF+KhIgWPC0MyRwbDziRzqlrPYpxmlNt8ty6qu3aZ/hyzx4gH48RMd
	 nRV8FQs3ApYAisBODHtl7rn/faFOajNIbiFTpBziCUr04lYCGPEaXRvzOmOcaMeYPl
	 CV6rN7hwXOdz0idWmIPRSCuY6KC8Zr4+L7VsBtIpTAPWMSIDxxWs+OLmbUE6ldvuVv
	 5Ry62vN07mFh2KGXCWQR61zxibjbhv8XPn8/SW03F3cLfrx1mjiUeLeqIoailXp7Dc
	 2kYwuKu60qJ0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C41C47E49;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:29 +0000
Subject: [PATCH BlueZ v3 4/8] bluetoothd: convert external sixaxis plugin
 to builtin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-4-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=1169;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=rf/DV6bb4eocv72jDKDqDG7KvOMIubc6ZBWpK2UcaNg=;
 b=KxRl4ybPO5mJHkVzDDAtgZUvph+fZVnffBMx8aPVzyUh8lR3h3/ICmd//jTaWiDwEwFCUB0vc
 5XsfOXvGPILBw7RutVwXSkIDTxksANQNjoLHHU9R/mmileW53K8fPps
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

