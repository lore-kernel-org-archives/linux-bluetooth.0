Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A82F6579
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921204; cv=none; b=lripK54gW9GFAaLq5eATmQGELsiC/bSNVh8ylIDF0WXxvRL6lQqG4Cq7h7rI7eoZgbiFGGvWUDdQYUN5gsWP20QI142FkBAlN5d0N05l3u8Tl9j997qIiTkZJrsAfVV9AVZGfRPcmzl/adlwlMilJzwPZ+ID+JVgLwRYDSpNCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921204; c=relaxed/simple;
	bh=KoKPVx4uymDzuNmkPcQzhiO2prXOFdxGK8tFn9p5q2o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OskSxkQOUyr8M3BC1ZhFgrIspwJeIsySf8MglURL3qYsC5FNH5bdVKReTd/550+Bc9QvqI3ybVdmit7bqKtnl4Q6cSzJKaKBpBfdjVb4uO3FOZVHSCn/z+gxJZJLZR5iW1tmcU2Bk9VpafQxHt/fMZmwG4SkOkP2X/BO6c6rlTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6FE07582F8C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75D3643B22
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 09/10] build: Add option to allow disabling bluetoothd
Date: Wed,  8 Oct 2025 12:40:24 +0200
Message-ID: <20251008104132.2206963-10-hadess@hadess.net>
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

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.
---
 meson.build       | 12 +++++++++---
 meson_options.txt |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 5fce108e4317..c429864b9c8b 100644
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

