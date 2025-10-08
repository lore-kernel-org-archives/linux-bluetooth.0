Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812C2F4A10
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914056; cv=none; b=USYTHdISOHnMu8cUfQW8PX4WvvvkbL5OQGyuJAKPK2x5mbCLhyb7iA1S3e6xRJr9JfA/elg/t9bYC/X90tNg6u9rtw6LgSdNg3rRGZOqm6WtKk0ae4D+IyVWZ0BN5rAXafzHwL0mDWhXQd/2OruGO9+ymyyUOIV/OshypjTCtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914056; c=relaxed/simple;
	bh=4YD16ZOGkqrbvWkwBUG+4puUgJAqz+6bB9Clckt+w18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rS80FX8ZZFZ07VMQsHQNhpTJcpoA4EESkLoZfLa9CtTT3hCEfGT66Nay7KH9pdPtznLMR+nQ8gWlaEjzDe+PvoFY4iGRoS6AWJjWT+qfHwpoMLTDZnBFghwAYRxVvUXWdVEUNeBRRZUk94lzp/CFMjHNe4sbhHBOhCqR2ucVe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 64F3E584F3A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2322D43188
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/9] tools: Install btmgmt along with other tools
Date: Wed,  8 Oct 2025 10:40:54 +0200
Message-ID: <20251008085034.2178394-8-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008085034.2178394-1-hadess@hadess.net>
References: <20251008085034.2178394-1-hadess@hadess.net>
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

