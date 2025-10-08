Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C022FE0E
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914053; cv=none; b=k7Wm5QjVLy9nvruZUN5cZja0FqfR49zCR8HFz1TL1C9/LkFvZFNbgt4r5x5CBZwChJ6dIcdvd4+MchE/3ujTrWwYWCWfN39d0xm6f5unKGo/hzNRQk1s+uFF646fygaCefv3iAJ45zbA8PCkIRxybXK6KGgkRZCrGgzXCzyq9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914053; c=relaxed/simple;
	bh=RTLaQd0ZJrXZeEF3RnDycNArHnTFH3wUpIRfC1Ccads=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=vBlC2SgyOq5uWz62bVCw4sRVRI4iuul9RetMPUNWeomD+X41um1doGaiLopbG+FbVg+E4ADhGlwJu2yZnjHeloVUlVlzseUpcUnJS53xaNHjw1vEJFX2kNah8S99NKRhmso/ycNFYuQf3tNxU+G90xai3+m9pfWCagXDfY3A+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 736A2584F35
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BC7843219
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/9] build: Add meson build system
Date: Wed,  8 Oct 2025 10:40:47 +0200
Message-ID: <20251008085034.2178394-1-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Changes since v1:
- A couple of bug fixes in the base patch (and we found a few bugs
  in the upstream code along the way)
- Added the option to disable bluetoothd build
- The ell subproject was replaced by a Meson Wrap, this means that
  tarball builds of bluez would require either an internet connection
  or a system installation of ell.

This version does not rely on forks of upstream projects, so I would
consider this ready for merging.

I left 2 FIXMEs in meson.build, one for a test that needs a fixture
created, and one because it relies on a newer version of meson. Let me
know how you want to handle those.

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
 lib/meson.build                               |  55 ++
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
 unit/meson.build                              | 111 +++
 26 files changed, 2665 insertions(+), 1 deletion(-)
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

