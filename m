Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39242E7BCB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345283; cv=none; b=kkN8mIDaqxfmsZstKIdRxZOQSqhP/eXfuDnFMmCEm4KVsHcU8FtETgaMhVcik0DvgzO6YgWLPyhfjy7p0fCkDv0dBDq8TZHtRX8mF9s0SqQiqXu/Bj0uzCYDdAr7GDng9ga+Yz0qH07scb2Bg67fS21IafnSojTBVm3mScLFZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345283; c=relaxed/simple;
	bh=1zHVD/dDrIwJ6kTNin9lmgji3IyuvRv/RKnIsDu3lSY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkoN558XYrozk049ajcrfE403SW8bNAfBQno1yvKVKTqA8dfnhpwSOTsBEp1zX5t0xpa/FA5ALJjn3YZWKqkBmhnmi9VPnsn2XuFg4fhn/LUB3mLCcjEnDegIeOVQRXmFXian2UXWU5J2+afKFwfpZ38wTX78WH6hWpOyd3puPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8015358211D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B79743287
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:08 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 4/9] build: Separate systemd and libsystemd dependencies
Date: Mon, 13 Oct 2025 10:32:14 +0200
Message-ID: <20251013083259.3152260-5-hadess@hadess.net>
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

