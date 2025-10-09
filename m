Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D042D8DA4
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006175; cv=none; b=M0cSv1PuJgYbt6FzjkQjM5V4ViWiiPiooCtmAK2u9YMFQHD0X8fGBfOO3dlvqa+JWeDXobeCnOYY8ffch/dLIZ4qt94vlVXlx1c8rpCYrdPC3/BQvw4z+rOy2sHPIGp8qhGUwDEZlj+guXqlLeoRzSr6qEiyKmg/ADQHRhwg4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006175; c=relaxed/simple;
	bh=sivdIeBMjGHmxVIczXuUnhpPqHFjlSHod8sAdJ+fEqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVI9hgI+JUdNHVG6gWdKTKa1vqvLoACDqwVssCzljUH9JDZYEMyyOaHNbBuQuZYFEr5i6J7mePYBNr6xg5nU2sEtQdj6uYax7oY+5CFww9s84kkTCn1sCHNBSyOlTTKGbLJ1G9j9UJwsaTrWjSA9YBgVgP++TV0REtNtvNLjSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24AE1434DB
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:06 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 08/10] emulator: Install the emulator if built
Date: Thu,  9 Oct 2025 12:33:31 +0200
Message-ID: <20251009103554.2417973-9-hadess@hadess.net>
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

It's useful for testing.
---
 emulator/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/emulator/meson.build b/emulator/meson.build
index bc038becc567..55d77e40319d 100644
--- a/emulator/meson.build
+++ b/emulator/meson.build
@@ -17,7 +17,9 @@ if get_option('tests').enabled()
       'smp.c',
       'phy.c',
       'le.c' ],
-    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, glib_dep ]
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, glib_dep ],
+    install: true,
+    install_dir: pkglibexecdir
   )
 
   executable('b1ee',
-- 
2.51.0

