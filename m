Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2B2FB612
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345286; cv=none; b=lXPLWU/Yn6QmjFEJwXKEj+JJtbt5ewpHiOLx7cgG8C+580jouQwW+73ri0MLVGVBXIlM1NjjenbD+pAaoB9RlS7CFDuCIXkGLDoVWgvxzhAvUomAoXcMFHtTnLMc41m9kV2s4LMHUrHbQkdpd1LfOR7BGoNBG7Bzs+MJ+jqQ79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345286; c=relaxed/simple;
	bh=x4ixRCWIFEpab/FSds5n2STuUq4zi0BbmbJbqyShtnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKzMeS+B/CgRZQcmRM6Uu1ay+dsleWnlsEel5M2SqvcVvYetz5H8S/OCDVoOCmol4/jFk3urw742xOlcLpkhfQoYbiGtEYeCMSl/wqrY5BnyoM70iF4mGH/pAEXlIBuplg4phskSNS7gG1br/mNrnVmlkPBHvjAYr9EXlptEfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 617B7582126
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:17 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEF4443345
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:09 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 9/9] build: Add option to allow disabling bluetoothd
Date: Mon, 13 Oct 2025 10:32:19 +0200
Message-ID: <20251013083259.3152260-10-hadess@hadess.net>
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

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.
---
 meson.build       | 12 +++++++++---
 meson_options.txt |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 58e17c947570..b5f9be1532fa 100644
--- a/meson.build
+++ b/meson.build
@@ -253,7 +253,9 @@ subdir('attrib')
 subdir('btio')
 subdir('plugins')
 subdir('profiles')
-subdir('src')
+if get_option('daemon').enabled()
+  subdir('src')
+endif
 if get_option('client').enabled()
   subdir('client')
 endif
@@ -284,8 +286,12 @@ endif
 # Fix permissions on install
 install = find_program('install')
 sh = find_program('sh')
-meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
-meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + storagedir)
+if get_option('daemon').enabled()
+  meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
+endif
+if get_option('daemon').enabled() or get_option('mesh').enabled()
+  meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + storagedir)
+endif
 if get_option('mesh').enabled()
   meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + meshstoragedir)
 endif
diff --git a/meson_options.txt b/meson_options.txt
index 6a39e2ceabec..9e9587f3ef6e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,6 +6,7 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
+option('daemon', type: 'feature', value: 'enabled', description: 'Enable bluetoothd daemon')
 option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
 option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support')
-- 
2.51.0

