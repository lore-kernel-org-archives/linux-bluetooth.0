Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256F2FABE5
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345282; cv=none; b=pB7Lup68hozKiDoYO5XglnD7c5AmADRBKQDEpNDSUHsucfwt1SGKRrHPzj8H9xT4hiXk7+FRtWnF67AwdP1QbHzueMHjN1EkUN/XWw9H7Ps/8i25+9DiDyWIVHsx9As5+mXLpkXFY6afzt83C4ZUfNAR2yPgMmHpf8hMvj+cIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345282; c=relaxed/simple;
	bh=IUtaQRYl/5XMVIru8mAB0vbcDREUURpTgxSEDjZe5d0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f+tviPz3+RGBC13xeedwtO7cR+NBJS7wgTfVT+xTzVt+g2eOWPldYXop40TWRX18AyucBV7qArPHC1RutEr32Qok4y/J1CCw3MWads0naIyqnxIy6sxa+NPF497Y0AHR9N1f7iEY7Q2LBaWYU77xfmU/pAyaJZDPOtedBShGOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id AB0125819A6
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:14 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7057E42EF2
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:07 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/9] build: Add meson build system
Date: Mon, 13 Oct 2025 10:32:10 +0200
Message-ID: <20251013083259.3152260-1-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Changes since v4:
- Dropped patch not intended for immediate merging
- Fix running unit tests under dbus-session

Changes since v3:
- Fixed project version (thanks George)

Changes since v2:
- Fixed the 2 FIXMEs

Changes since v1:
- A couple of bug fixes in the base patch (and we found a few bugs
  in the upstream code along the way)
- Added the option to disable bluetoothd build
- The ell subproject was replaced by a Meson Wrap, this means that
  tarball builds of bluez would require either an internet connection
  or a system installation of ell.

This version does not rely on forks of upstream projects, so I would
consider this ready for merging.

Bastien Nocera (9):
  build: Add meson wrap for libell
  build: Add meson build system
  build: Make more use of 'feature' options
  build: Separate systemd and libsystemd dependencies
  tools: Install gatttool if deprecated tools are enabled
  tools: Install avinfo tool by default
  tools: Install btmgmt along with other tools
  emulator: Install the emulator if built
  build: Add option to allow disabling bluetoothd

 attrib/meson.build                            |  17 +
 btio/meson.build                              |   1 +
 client/meson.build                            |  54 +
 completion/meson.build                        |   3 +
 doc/meson.build                               |  41 +
 emulator/meson.build                          |  36 +
 gdbus/meson.build                             |  19 +
 gobex/meson.build                             |   8 +
 lib/meson.build                               |  53 +
 mesh/meson.build                              |  75 ++
 meson.build                                   | 297 ++++++
 meson_options.txt                             |  53 +
 monitor/meson.build                           |  47 +
 obexd/meson.build                             | 121 +++
 peripheral/meson.build                        |  13 +
 plugins/meson.build                           |  29 +
 profiles/meson.build                          | 170 ++++
 src/meson.build                               | 103 ++
 src/shared/meson.build                        |  80 ++
 subprojects/ell.wrap                          |  11 +
 .../0001-build-Add-meson-build-system.patch   | 922 ++++++++++++++++++
 test/meson.build                              |  41 +
 tools/mesh/meson.build                        |  16 +
 tools/meson.build                             | 341 +++++++
 tools/mpris-proxy.service.in                  |   2 +-
 unit/meson.build                              | 114 +++
 26 files changed, 2666 insertions(+), 1 deletion(-)
 create mode 100644 attrib/meson.build
 create mode 100644 btio/meson.build
 create mode 100644 client/meson.build
 create mode 100644 completion/meson.build
 create mode 100644 doc/meson.build
 create mode 100644 emulator/meson.build
 create mode 100644 gdbus/meson.build
 create mode 100644 gobex/meson.build
 create mode 100644 lib/meson.build
 create mode 100644 mesh/meson.build
 create mode 100644 meson.build
 create mode 100644 meson_options.txt
 create mode 100644 monitor/meson.build
 create mode 100644 obexd/meson.build
 create mode 100644 peripheral/meson.build
 create mode 100644 plugins/meson.build
 create mode 100644 profiles/meson.build
 create mode 100644 src/meson.build
 create mode 100644 src/shared/meson.build
 create mode 100644 subprojects/ell.wrap
 create mode 100644 subprojects/packagefiles/0001-build-Add-meson-build-system.patch
 create mode 100644 test/meson.build
 create mode 100644 tools/mesh/meson.build
 create mode 100644 tools/meson.build
 create mode 100644 unit/meson.build

-- 
2.51.0

