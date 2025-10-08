Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171402F6175
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921199; cv=none; b=plL28ZdiRMdY6TGpX3qAMaN1Y2W4gJnXVkm1FGG7QiDZK83Mg3Ods458cLzspVZtA6SUM4JbbIWHo5Qqyo9J2NPiJrX0wabKjmZfF9mH3yj4+aU/QqiF5AAqhbsJONgEYRKLyHTLG/Tqgw9MOTe1bIHJ1Vs03h5BLVyiPPr0hkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921199; c=relaxed/simple;
	bh=+ltYsXlcVLhJ3IiDDkcSc6p5PI9u+syE5cx8gSLFCp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG3co3M0lufLHqv10ODCDabt2Yupdo4bEUVt9zqrKi/JqA9NJL4Gg3T4lkP1Jr0DRyD1yhYcc58m+irn8qlZoN9tlaxRuJJixFDLLCX8A54cwpKx6bHjG4ft17ZxhJmJphvc0ZTS3iqwSJXJSQRd3OieQuXfAUp+laQ2tvwZvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5A2F3582DD7
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54BF543B24
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 05/10] tools: Install gatttool if deprecated tools are enabled
Date: Wed,  8 Oct 2025 12:40:20 +0200
Message-ID: <20251008104132.2206963-6-hadess@hadess.net>
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

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486
---
 tools/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/meson.build b/tools/meson.build
index 5e73b048c118..3e8f7ad439dd 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -231,6 +231,7 @@ if get_option('tools').enabled()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
+      install: true
     )
     executable('hciattach',
       sources: [
-- 
2.51.0

