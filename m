Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898B2F657C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921203; cv=none; b=iKDYi2glfZEO0AIdYXC5RD8ZoZ5GoK1BwXXQCd3bKn/VAjPPhapwQINVBqgqgvcPBvLx1fbHwcPJuT3caT4hvFNK8t7ZXpNDVOuHizQQHnZ7se2ba8aN/oqhVvobGsi7jMsh7+/ivRM3+sRQoiKp+TF9yW0/36KcgZ4fjW9KLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921203; c=relaxed/simple;
	bh=sivdIeBMjGHmxVIczXuUnhpPqHFjlSHod8sAdJ+fEqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEZHRK7AiU1Y7hA1/K3+mfriuoWSnGhEYsL5Savjm7AFYhi/2sKKsoNdC5pk6y5dQk8n7qmp1RKMuMsMn1oQmhVx/zpoUn2XJcEmM4dRhFPjL5hfmoz57bNXDcc8DDwBP6y0bZ3QveM/qsz6yXjAs4iqe/XyDgF4Wb49TsTpbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6EC5F582F39
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26A7043B20
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 08/10] emulator: Install the emulator if built
Date: Wed,  8 Oct 2025 12:40:23 +0200
Message-ID: <20251008104132.2206963-9-hadess@hadess.net>
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

