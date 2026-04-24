Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679338552C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022022; cv=none; b=RXGEzfXCFTpi7LB4CxCTsbKtM+ai1S5F/FoaXMxg3783uXiHsO/IPz26uiDHivzULVtsGtnptumTNC6PBC0EQWY45nTHOaVo88BeQ2UZuT4L3v1SopPfmN/z9gT1QXv9WqCeAtR6Co061YmU6jijC4oTN98nIl5aZlaAIeVIFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022022; c=relaxed/simple;
	bh=4QulE5aJRF0SQ4AZFtDdds43BHkR0qi/iVE2qp3eYjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDzWm/FxThj/vLczgwW10QMuot11xOFxgcuwjDHPehO6zMNhB5u0whjUmHd8oGrOKdGB5dO9zRJMnCoxD4U/513EtPKxCNEma9MDh+z++XtZZPYBeqxrbH5sjrCrvB4/R4/yaC6oBoH1lNBi7wSvtu6QCc43e96GQr/HmczWl9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BD363EBE3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 03/15] build: Separate systemd and libsystemd dependencies
Date: Fri, 24 Apr 2026 11:11:06 +0200
Message-ID: <20260424091324.3097084-4-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE4fwvglj1stUpqbfNOHgbX9pBEbBFXfBn+DQ4MiAAA6Q5/kgmY6sH9Wwik1ceYLp6ZNgfTynQHBkQ4N55lyQu4yW7V3nHJyk/iilnZtTxZrqQt0GkMVUUvcdSDhQ/I4N0PSGb4UvWo71F8G+un+/Zry4Qu718gJ7Tc1UFESpRs/KnFyu+QdCxtlRBx+YBGSmskVeXbdXm6PlGkslt6AZjsbtBecG/FMoAlwgc27KEpaEMzn5WZDvunlzCnmcJc3y7KTB1b/TPjvmtdlfkTY0qe3MmA5mFjVST1KD1dS2cnveNKU91CrDhd4MGiADuFUUUingjVS7GXUQtIFa0rmXsTs1E/v6Uqiz5cKE5hjq6wz+pJsoRO9jSEatKZ3SlYgNb8YRLUhHoyC56LOexV9zZAepIkpW0udfzEN0sW7R++YWMrWZREHY9A9tPXerkpzRU66x1XEv3Zpx9u6DYAXS9nY2tPEM8B8t3RwPRKDbxKTADyCpRQwZAWO/ijLverE+CK6tNHTtt0NaVX3U7WgENvE11d9Qwt6/oTkxg+mvxuLjERGQrp92MX0PiYvN52Csm32vKjUpKmiMh90uCi/oSotrsilWoTFKF8srA6wm0pwrwwT+PFypSWaHArBrO5qhsoXBfJWMpy8xCgWHY/3yMRRUpwgTOiG1VmQuPVOh42Tg
X-GND-State: clean
X-GND-Score: 0

One is to install systemd service files, the other to enable deeper
logind integration into obexd.
---
 meson.build       | 3 ++-
 meson_options.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index d3c43d79141f..0b5cc0b7ce69 100644
--- a/meson.build
+++ b/meson.build
@@ -138,7 +138,8 @@ readline_dep = dependency('readline',
   required: get_option('client').enabled() or
     get_option('mesh').enabled())
 systemd_dep = dependency('systemd', required: get_option('systemd'))
-libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
+libsystemd_dep = dependency('libsystemd',
+  required: get_option('obex').enabled() and get_option('logind').enabled())
 
 ell_args = {
   'version': '>= 0.39',
diff --git a/meson_options.txt b/meson_options.txt
index 4a0c726c2098..54cfdbb0d7c1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,7 +6,8 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
-option('systemd', type: 'feature', value: 'enabled', description: 'Enable systemd integration')
+option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
+option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support in tools')
 option('datafiles', type: 'feature', value: 'enabled', description: 'Install configuration and data files')
 option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
-- 
2.53.0

