Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A22D8390
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006175; cv=none; b=m1Hcgnpey6jGmdS71Y4NY3tnfvM9s1FB14ECPpQtdJRePovS/3lFU4OMol0aI4N16DrJJ/m8jl9oG0RaVMLGqVR/KtzUAhZWLmQ2HB9s1317pQ9gzZh20vWWHMYX0a7rVGKmSKJkMFSIQmQF7E8/XlPbyvkiDwtxd/Q3Wg/iYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006175; c=relaxed/simple;
	bh=x4ixRCWIFEpab/FSds5n2STuUq4zi0BbmbJbqyShtnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WihfeUhIWD2mb+kNusA6yUFmET40n60qniemr2P7FauuiEZZv/zS9I7xBb3mLRMukScMl7l0JKtDFVCchuUzK2xw0/UWsUgxTFQ+EyKzgpaNiLbJaBTHR33KyLqBkHFUgt0y2PGNBfbmo8z0VYVpJ8koI/QyLVvOxiKQyyiOklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DB9A434E6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:06 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 09/10] build: Add option to allow disabling bluetoothd
Date: Thu,  9 Oct 2025 12:33:32 +0200
Message-ID: <20251009103554.2417973-10-hadess@hadess.net>
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

