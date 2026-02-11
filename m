Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A91E7660
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813969; cv=none; b=dGiTx03keYUcGGSdGGCq4ZMNa7sRwZDwY3jDMz9gcEOJ24P8uC6HrzBmC/MW5X1Uwlx06cFlwf1rDPKSyRq6n1DJxDj0vIqaqOnKmVCDf9HHbtUbTJrKuonNjVdzypgkWq6oJIeTMyoS76YD8zg4I5HL2KxMz9s8Rbj+cd06cJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813969; c=relaxed/simple;
	bh=ggNHXjdFbos+neIKu8WnosBU1mMBYU7gM/olyUFo0Kc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Gwi2XnKmkv7mR/9JZmnDPBvUaPZ7hmNf9b9tTZJLy9QaE08xmIc6g9wurO+tZwW9cakIvUlwO+3YqMV/wqqI+RjF5vbKjaT6tJ/m6yNozaM4RaO2od2SAP8toMpIMzNGXuyqGLTqMdyWQLkLefiezuKqiJaZk2GJXy8W/K0d48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35331441E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:45:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 00/15] Add meson build system and HTML docs
Date: Wed, 11 Feb 2026 13:41:56 +0100
Message-ID: <20260211124550.3830639-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeduiedufeekkeffkefffefggeetjedtvedvtedufedtheduueeivedukeffjeejtdenucffohhmrghinhepshgvrhhvihgtvgdrihhnnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepfeehfeefudeggedugfehpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

Changes since v7:
- Use Figtree as the documentation font
- Update main logo
- Update favicon
- Update OpenGraph card logo
- Fix GATT introduction not being linked from the docs
- Don't install btmgmt man page
- Drop merged "client: Expand GATT submenu documentation"
- Update vendored ell to 0.82

Bastien Nocera (14):
  build: Add meson wrap for libell
  build: Add meson build system
  build: Make more use of 'feature' options
  build: Separate systemd and libsystemd dependencies
  tools: Install gatttool if deprecated tools are enabled
  tools: Install avinfo tool by default
  emulator: Install the emulator if built
  build: Add option to allow disabling bluetoothd
  unit: Run test-bap tests concurrently
  unit: Make gobex-transfer tests run concurrently
  build: Only build profiles if the daemon is built
  build: Only build gdbus library if there is a user
  doc: Add HTML documentation
  github: Add docs deployment

Paul Otto (1):
  doc: Add introduction to GATT

 .github/workflows/docs.yml                    |  54 +
 attrib/meson.build                            |  17 +
 btio/meson.build                              |   1 +
 client/meson.build                            |  29 +
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
 doc/deprecated-tools.rst                      |  22 +
 doc/dev-maint.rst                             |  17 +
 doc/favicon.ico                               | Bin 0 -> 29152 bytes
 doc/gatt-intro.rst                            | 141 +++
 doc/index.rst                                 |  47 +
 doc/meson.build                               | 295 ++++++
 doc/protocols.rst                             |  20 +
 doc/qualifications.rst                        |  76 ++
 doc/tools.rst                                 |  24 +
 emulator/meson.build                          |  36 +
 gdbus/meson.build                             |  19 +
 gobex/meson.build                             |   8 +
 lib/meson.build                               |  53 +
 mesh/meson.build                              |  60 ++
 meson.build                                   | 300 ++++++
 meson_options.txt                             |  55 ++
 monitor/meson.build                           |  37 +
 obexd/meson.build                             | 121 +++
 peripheral/meson.build                        |  13 +
 plugins/meson.build                           |  29 +
 profiles/meson.build                          | 167 ++++
 src/meson.build                               |  90 ++
 src/shared/meson.build                        |  85 ++
 subprojects/ell.wrap                          |  11 +
 .../0001-build-Add-meson-build-system.patch   | 922 ++++++++++++++++++
 test/meson.build                              |  37 +
 tools/mesh/meson.build                        |  16 +
 tools/meson.build                             | 302 ++++++
 tools/mpris-proxy.service.in                  |   2 +-
 unit/meson.build                              | 163 ++++
 unit/unittest_list.sh                         |  15 +
 49 files changed, 4006 insertions(+), 1 deletion(-)
 create mode 100644 .github/workflows/docs.yml
 create mode 100644 attrib/meson.build
 create mode 100644 btio/meson.build
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
 create mode 100644 unit/meson.build
 create mode 100644 unit/unittest_list.sh

-- 
2.52.0

