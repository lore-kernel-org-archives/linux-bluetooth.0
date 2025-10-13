Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BB2FB610
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345287; cv=none; b=o46IzBhd2AsdIZ2mC2cEnPHRr8Ht1b21aGUM1SHVq55TwyY5uxEwmDmVsciQPN2eS7/1qyLUKayj/eNjufdjhSCsCy9N4LtRuk0okrkHcCa7QhzMeWtIgHMGAcxB84g4o3XD7PMrGXT43cUSyqQ0ysETjihuHaFDV3lbttHIhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345287; c=relaxed/simple;
	bh=4YD16ZOGkqrbvWkwBUG+4puUgJAqz+6bB9Clckt+w18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiiNJez5ihI9kQk+CnarPW6etVrwtPujGQNIR5qsIlCygAug1brF/ZsPJ9YwEy2b82liY46T54xmAnsTq9QT4TXNgdXgkLyOAobt2pXHgAQ5WhmyabE3coP0bXs/C1tV4vQ7f9om0Ey4RrZIyJz/sIpoMtV5ze3uqTu6NRhF7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6A8E7582120
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EABA43292
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:09 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 7/9] tools: Install btmgmt along with other tools
Date: Mon, 13 Oct 2025 10:32:17 +0200
Message-ID: <20251013083259.3152260-8-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013083259.3152260-1-hadess@hadess.net>
References: <20251013083259.3152260-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

btmgmt is not installed by default, but it is useful for debugging
some issues and to set the MAC address on HCIs which don't have their
MAC address configured.
---
 tools/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/meson.build b/tools/meson.build
index 66156ab0224b..9ca76079325e 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -171,7 +171,8 @@ if get_option('tools').enabled()
   if readline_dep.found()
     executable('btmgmt',
       sources: [ 'btmgmt.c', '../src/uuid-helper.c', '../client/display.c', '../client/mgmt.c' ],
-      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, readline_dep ]
+      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, readline_dep ],
+      install: true
     )
     executable('obex-client-tool',
       sources: [ 'obex-client-tool.c', gobex_sources, btio_sources ],
-- 
2.51.0

