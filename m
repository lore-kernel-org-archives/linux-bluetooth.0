Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AB29B200
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638555; cv=none; b=sVPGi+1w//hWVCuujn3c6tEtcEs8Fitr7hl7Rr2pna1UkN9duBfun27yFcMb4bQy4b+P2mTmz0LIJUF8NRo1ymj7HfhyygSkiRYsCMc2IXLft72a480IDWT8XiJV+gx21xTBmecKKhu4ZwtJD2kuEcduLX83M2/a1ibsF/Yo728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638555; c=relaxed/simple;
	bh=9R7VgdlYnk19AxdMc0Tch1eMhae23uxIlpZVXSUrvl4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdwRDIq6YMypuXCb0D1yZNPTsZDTH3UlG+0277Rk8a+AwY6XR1XS2mcVlgFGCpBUI0chhYzQP18C6EGRTERwStzj0AOGDNHCwYqF4BoFE8mRRcnTSni4s3gPDjM9FZrQJC0NyRqchuICx986i55EBfkTRzsSeKFsNFXitvGNnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6A4044401
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 04/16] build: Separate systemd and libsystemd dependencies
Date: Wed, 28 Jan 2026 23:11:54 +0100
Message-ID: <20260128221536.2319084-5-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128221536.2319084-1-hadess@hadess.net>
References: <20260128221536.2319084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffieetgedtgeeggedtuddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

One is to install systemd service files, the other to enable deeper
logind integration into obexd.
---
 meson.build       | 3 ++-
 meson_options.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c4b48194b62a..099ad5e0dd49 100644
--- a/meson.build
+++ b/meson.build
@@ -134,7 +134,8 @@ readline_dep = dependency('readline',
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
index 66abdcb1c145..b72080f87813 100644
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
2.52.0

