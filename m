Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A052C21E2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006174; cv=none; b=blf0TsqBWMiYKcWHn4oKI4cE8Y5c43xwPFRNRSZhqWZXEAsiF9CCf0DD948Tr4SVF671YcWcyCwr1yo3HZNZ2bNIXFllxXatN2OFQuK6jA+C4NWkDPdgorgl0WFeiHYd11gnkcOYR92CCKm/B3YWqUfy6JdtsGDzNRqoJVx1cdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006174; c=relaxed/simple;
	bh=1zHVD/dDrIwJ6kTNin9lmgji3IyuvRv/RKnIsDu3lSY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTXG3kbqE1ooSOHCBM1ClkTGGZfoAwx6yyFofm1ONc8JJqkZDWB9SVYz5FUmUKUjIs+Yse6CMhgfXTMCtuYtFoxUeunK7+/ZVrMuS0rBLENYgzSNfpXOVuoFiZOLG3H3HHReedFZD/GIfPYn1GIE/cVMO7qVF1YiqbafwdE8eqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9DAA434CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:04 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 04/10] build: Separate systemd and libsystemd dependencies
Date: Thu,  9 Oct 2025 12:33:27 +0200
Message-ID: <20251009103554.2417973-5-hadess@hadess.net>
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

One is to install systemd service files, the other to enable deeper
logind integration into obexd.
---
 meson.build       | 3 ++-
 meson_options.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 0bda065489c9..58e17c947570 100644
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

