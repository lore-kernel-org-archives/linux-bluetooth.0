Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819C241663
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921200; cv=none; b=hS6sAYFrRqVg5bLGreYM6DEbgpq04YYO+ar9hjcQft19313FyQvdYGxS9xMcRG1qXAZj1nVUSNY17WgbdZ0GJYLwjt72wXOL7u5XEk2GMUZ0g/VVgvhPdpJlO672FPRyha9RhIijuHXbh7C/nsjwPl7cM94VItdoRvo9G/w91EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921200; c=relaxed/simple;
	bh=lMsXoTkEgHsGKpEHhNta42TA2Qxr3KAutn8nGwXfskk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0FC5EHjchrUw3ZqtzimcO+Y/SehRmrJglIkG3qeHsSYBMQqSmZLKQuSH6fUQwHmJDvPB7UcroauoDvtOmX4N4Mxdcy+5gDejkFk1gknbccJR/IC7DwZBa4foCmWh/wDZzJtwbiDzcT4Ml37sboBHRL6N0w6YmsYfmhZy6UgPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 53296581616
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1964D43B21
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 04/10] build: Separate systemd and libsystemd dependencies
Date: Wed,  8 Oct 2025 12:40:19 +0200
Message-ID: <20251008104132.2206963-5-hadess@hadess.net>
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

One is to install systemd service files, the other to enable deeper
logind integration into obexd.
---
 meson.build       | 3 ++-
 meson_options.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 25a5bb780edc..5fce108e4317 100644
--- a/meson.build
+++ b/meson.build
@@ -135,7 +135,8 @@ readline_dep = dependency('readline',
   required: get_option('client').enabled() or
     get_option('mesh').enabled())
 systemd_dep = dependency('systemd', required: get_option('systemd'))
-libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
+libsystemd_dep = dependency('libsystemd',
+  required: get_option('obex').enabled() and get_option('logind').enabled())
 ell_dep = dependency('ell',
   version: '>= 0.39',
   required: get_option('btpclient').enabled() or get_option('mesh').enabled(),
diff --git a/meson_options.txt b/meson_options.txt
index aae4f377f0a2..6a39e2ceabec 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,7 +6,8 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
-option('systemd', type: 'feature', value: 'enabled', description: 'Enable systemd integration')
+option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
+option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support')
 option('datafiles', type: 'feature', value: 'enabled', description: 'Install configuration and data files')
 option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
-- 
2.51.0

