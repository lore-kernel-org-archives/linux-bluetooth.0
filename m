Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD23126C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971478; cv=none; b=tetsXVZrFL1ALTWV4NfcJtp7KhCf91eS+knlo6p9+kBONekoUiJF4YmnwyRQeqTgT9/DfYZ/7FQW0F+zWooflWnwViXp+KyAkJ8PPYDikwq5EHTu5Ej1Qz8bPnkaKZJGu4PcIu9U3yY0/k7zG10jaAXdxH7RHBoA128JDb81Ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971478; c=relaxed/simple;
	bh=/+c5E/Ag9xQ/NOCmwAf9AB5iHc9bcgN5g6/RqcHl05U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MD2wv1/Oa1IOz5tF6TBfAiyzrgGDuHlVhcnqsUsPZWCbVDjmoJC25LdR/ejb3SZH5+KE31mMf4MTmtb6wtLtl0guMhhJERf4r8zti0MsztNps2F5Tlub+0so3k0h4EqW5kFCjr2xg0SX0okTRuCIq/nZBKe9QoiOgb5J8szfI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9172D3E97C
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:49 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 00/16] Add meson build system and HTML docs
Date: Tue,  5 May 2026 10:45:06 +0200
Message-ID: <20260505085741.2497401-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFxLbpLFxCMtJUMbeHtENh+l5YVSolE+JnQLak9f12BNgcdkRX8pY1i36im6EBN6PuUAos5TU4T8IcvIEyQh+Rg5Zh7o2cTH4Kmg/faki/R+V8JH4vuyHbx2sTOGR/a4iUQ8lJvbyvQdKvLFdm5egutI64hJpZ1X/QDb3bZnZ5uCuaXEaBaZ3q79lpkJX3lQfQQWo/MC4SpaHq3XwCv2uvBlfc86EvBq++P0ZPrgbCPOXyW9pzGlx9Iy4PBxaV7cbJYHA0o8sidnwy/XZ6HChybZrMsN8OqJgNdLYnnX2E4Q60qc20Bn3o0NqLbq2P64aYeEwk7vnuWYgIe2daOBdh7YvrouyuXrro8hnRMDsnrikSG+7atd1SfH6NIPlVKPzjUBPjhgbGfL8+YthBzgAVenZiv54DmDih5mbcsqGO0OEIGAvCtoSLoSrmPox9lvOntSCI+kYOthf13EKJYRxi+ToFzzNQ9DS1mGcE/e/D3dNHM6a5u4jYRRlTIBoZ5VpGuCs4zFRnC7qB0h5JoY/nG43E/f6t5lrmbWxCFGdf/feFNovg3V/UBiGCgNrLGgwFGRNiQ7OZeXlDp8s4RHBb8cmsAeTdaUcqcKNFvTPNPX4A9GWYnaBxI0EqlDanorr0Xy51neIFCo9fe80/s6N7uS5PgcuEXdY8rjlVOI5SETA

Changes since v9:
- Removed docs reference to hcidump
- Fix build with libical 4.x
- Fix build problems caused by RAP-related changes

Bastien Nocera (15):
  build: Add meson wrap for libell
  build: Add meson build system
  build: Add support for building with libical 4.x
  build: Separate systemd and libsystemd dependencies
  tools: Install gatttool if deprecated tools are enabled
  tools: Install avinfo tool by default
  emulator: Install the emulator if built
  build: Add option to allow disabling bluetoothd
  unit: Run test-bap tests concurrently
  unit: Make gobex-transfer tests run concurrently
  build: Only build profiles if the daemon is built
  build: Only build gdbus library if there is a user
  unit: Add integration tests
  doc: Add HTML documentation
  github: Add docs deployment

Paul Otto (1):
  doc: Add introduction to GATT

 .github/workflows/docs.yml                    |  54 +
 attrib/meson.build                            |  17 +
 btio/meson.build                              |   1 +
 client/btpclient/meson.build                  |  20 +
 client/meson.build                            |  33 +
 completion/meson.build                        |   3 +
 doc/_static/bluez.css                         | 452 +++++++++
 doc/_static/bluez.png                         | Bin 0 -> 18354 bytes
 doc/_static/bullet.svg                        |   1 +
 doc/_static/card.png                          | Bin 0 -> 35387 bytes
 doc/_static/figtree.woff2                     | Bin 0 -> 14364 bytes
 doc/_static/toc_bullet.svg                    |  39 +
 doc/bluetoothctl-cmd.rst                      |  34 +
 doc/conf.py                                   |  39 +
 doc/copy-subdir.py                            |  14 +
 doc/daemons.rst                               |  12 +
 doc/dbus-gatt.rst                             |  20 +
 doc/dbus-obex.rst                             |  33 +
 doc/dbus.rst                                  |  76 ++
 doc/deprecated-tools.rst                      |  21 +
 doc/dev-maint.rst                             |  17 +
 doc/favicon.ico                               | Bin 0 -> 29152 bytes
 doc/gatt-intro.rst                            | 141 +++
 doc/index.rst                                 |  47 +
 doc/meson.build                               | 293 ++++++
 doc/protocols.rst                             |  22 +
 doc/qualifications.rst                        |  76 ++
 doc/tools.rst                                 |  24 +
 emulator/meson.build                          |  36 +
 gdbus/meson.build                             |  19 +
 gobex/meson.build                             |   8 +
 lib/meson.build                               |  53 +
 mesh/meson.build                              |  60 ++
 meson.build                                   | 329 +++++++
 meson_options.txt                             |  55 ++
 monitor/meson.build                           |  37 +
 obexd/meson.build                             | 122 +++
 peripheral/meson.build                        |  13 +
 plugins/meson.build                           |  29 +
 profiles/meson.build                          | 168 ++++
 src/meson.build                               |  90 ++
 src/shared/meson.build                        |  85 ++
 subprojects/ell.wrap                          |  11 +
 .../0001-build-Add-meson-build-system.patch   | 922 ++++++++++++++++++
 test/meson.build                              |  37 +
 tools/mesh/meson.build                        |  16 +
 tools/meson.build                             | 262 +++++
 tools/mpris-proxy.service.in                  |   2 +-
 unit/integration-test-skipped.sh              |   3 +
 unit/integration-test.py                      | 271 +++++
 unit/meson.build                              | 194 ++++
 unit/output_checker.py                        | 214 ++++
 unit/unittest_inspector.py                    |  46 +
 unit/unittest_list.sh                         |  15 +
 54 files changed, 4585 insertions(+), 1 deletion(-)
 create mode 100644 .github/workflows/docs.yml
 create mode 100644 attrib/meson.build
 create mode 100644 btio/meson.build
 create mode 100644 client/btpclient/meson.build
 create mode 100644 client/meson.build
 create mode 100644 completion/meson.build
 create mode 100644 doc/_static/bluez.css
 create mode 100644 doc/_static/bluez.png
 create mode 100644 doc/_static/bullet.svg
 create mode 100644 doc/_static/card.png
 create mode 100644 doc/_static/figtree.woff2
 create mode 100644 doc/_static/toc_bullet.svg
 create mode 100644 doc/bluetoothctl-cmd.rst
 create mode 100644 doc/conf.py
 create mode 100644 doc/copy-subdir.py
 create mode 100644 doc/daemons.rst
 create mode 100644 doc/dbus-gatt.rst
 create mode 100644 doc/dbus-obex.rst
 create mode 100644 doc/dbus.rst
 create mode 100644 doc/deprecated-tools.rst
 create mode 100644 doc/dev-maint.rst
 create mode 100644 doc/favicon.ico
 create mode 100644 doc/gatt-intro.rst
 create mode 100644 doc/index.rst
 create mode 100644 doc/meson.build
 create mode 100644 doc/protocols.rst
 create mode 100644 doc/qualifications.rst
 create mode 100644 doc/tools.rst
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
 create mode 100755 unit/integration-test-skipped.sh
 create mode 100755 unit/integration-test.py
 create mode 100644 unit/meson.build
 create mode 100644 unit/output_checker.py
 create mode 100755 unit/unittest_inspector.py
 create mode 100644 unit/unittest_list.sh

-- 
2.54.0

