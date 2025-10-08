Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83F208CA
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914056; cv=none; b=YY/lfCKt7lfHQ99H0tWCz0ELgscXQktEVppEXBG+dLvg2BnYkAVK5Zh4XJFHzrxkbhlmnX2hP9EkUET1vcewMwPwAL0cgU0J+I3ArzTttUwAcjMOObEXljBwHlEyRM0VrDhrAeyxEcll8b+/T0XPebQRcpvxjfUqIDL1w2o+NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914056; c=relaxed/simple;
	bh=sivdIeBMjGHmxVIczXuUnhpPqHFjlSHod8sAdJ+fEqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXAHhvya+ytKx74Gq6opvQE+jZs7eS0MOCNMsBd8NfZ4VM9FdxGN3WPfTNIwhSkogeR/SmKAQLPUcXU2E194gx5u75bXFY4mJ8RdhOMBsFaTsqzUPCLq4QrZCK52PAVMK/mKJEOkl/V/s9690ykNp0g4WMRPJ01YlM952Cco41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 77713584F3C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65C9B4423F
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/9] emulator: Install the emulator if built
Date: Wed,  8 Oct 2025 10:40:55 +0200
Message-ID: <20251008085034.2178394-9-hadess@hadess.net>
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

