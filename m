Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064D213236
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914053; cv=none; b=rhEiXSEIsLbWyGPz63iDuuqNKzLg3wK2uzr3iRv4Rz2z0bsT9QBoJiZpx41dstzPLwFd9he02c8s6SlijbUkbQ7I/CTDxBAIKdiMQGk2QBEnL7wivMbJOMIk6LxWyEs2hENBIzsgtc6ernwQtUiFVcX2jnG6MRx9grjkPX53joQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914053; c=relaxed/simple;
	bh=lMsXoTkEgHsGKpEHhNta42TA2Qxr3KAutn8nGwXfskk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLKVjslOvfZtTLYT3ceL+OZDjW00mbd1QrnSMSRWabhUcvYJbmQEzzgMsmxLy6Wj4SvPqm6AmB4T+hoeGwg9aqLwlmIgwrUXFYJIf4JqZARiLawvfKxc6pVjNapmggGBa4vUYnmKnJ055K9k4AhCbmQzCP9WduuPBgsN9W8Qutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 57FFC584F36
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57755431DC
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/9] build: Separate systemd and libsystemd dependencies
Date: Wed,  8 Oct 2025 10:40:51 +0200
Message-ID: <20251008085034.2178394-5-hadess@hadess.net>
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

