Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72202F6592
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921204; cv=none; b=l9xzTT+QtEsrbDYZ5i/XHvCgrtnHoOYJaslAw0zn2piNICg43/Iea2RnOT1l/roHqMULYG7E4/sTGP8bhzZKI7SAlEgXJspFAobKq3OQDcK9sZNCZzXjosr125Srswvl/LRy3iV4cojvKOJ6eS+6iLRREAORLcDZD33C9EmirfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921204; c=relaxed/simple;
	bh=4YD16ZOGkqrbvWkwBUG+4puUgJAqz+6bB9Clckt+w18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPECAoljw+yp5uIb9moAx9dkWCxsMk9HtQNNmV6F0TJl/OHKlIiPiEt96kmsNFaDp3cmwiqh5ZSWbTh/wtrv0qmLiezhcH5CPYe777djiNLsvfhyr8zpYcM5FJKK2GWEGK/hGQHY0dWBlxMSYpxecytPtZ41TFoC0tPGJ2/hDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 72105582F90
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D940643B09
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 07/10] tools: Install btmgmt along with other tools
Date: Wed,  8 Oct 2025 12:40:22 +0200
Message-ID: <20251008104132.2206963-8-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008104132.2206963-1-hadess@hadess.net>
References: <20251008104132.2206963-1-hadess@hadess.net>
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

