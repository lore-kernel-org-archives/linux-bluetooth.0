Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C92D877A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006175; cv=none; b=FcewSurPMQ1aKfKXQd1EKvUTlvil+WsX9sjsaRHPcuCXSXkWHuQS3eQhtdZ08Sg319ARKnSElyVSnafT2lSix5QnmkwLvJbGUMXXF9Jkle71aHHH09J5tNo/sJmiZJne+52pjFvpdj4Ahk1jYwVtx532pEVsKRQXhBejp321k0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006175; c=relaxed/simple;
	bh=4YD16ZOGkqrbvWkwBUG+4puUgJAqz+6bB9Clckt+w18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1bKvW7XQqxJPzs9zG8ozQJHnsH7ZsI/mAT0SE5Ln86CIuqG70ZZA49Yx15Ae5+6s3sgZQvru86ooe2QMO0msv+WE2cm4JR4iR5akguSGyv/6K2zyqDwivnv0h+FoSVdg/vD5gkHWRAVaj03lKQRa86L2rods0wM7unqFnP67rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCD3F434D7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:05 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 07/10] tools: Install btmgmt along with other tools
Date: Thu,  9 Oct 2025 12:33:30 +0200
Message-ID: <20251009103554.2417973-8-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009103554.2417973-1-hadess@hadess.net>
References: <20251009103554.2417973-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

