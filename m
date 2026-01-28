Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7222D7B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638555; cv=none; b=me5nMyDOCi1bcm2Ip7FKBe4cm0+qvzt9Z8+O7nFpMgdtPG3WnWRRO6WLMiusznG388gOkz126x1BNeVGArYHrXFkxXnrdLYI4AtZBBJkrm9BH4Hh9vlWiw0Q5CbT0NWgP36D9kong6RCtB0nBusQuVeiCaPcRc4pypBJ20c02d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638555; c=relaxed/simple;
	bh=5Ga+F45f8qbSxq6GkP3Nd52TOD8ZaEWtxUJKTClaVn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J4vO7gzA/YkaH+BTAHZlUed/Ii5e8a0IXX3qV6A53mBtvuNMa5x+31VgoZzp83UsWCz2+zOjKb0WZC5JK7ryJQVWPFnp+4rfkvHPrs3EMZJZ4IHe1QQsAuoVuRMKtUz2pnfWSMgG8MpfetPbNRpyn7YmIYu2ii3j9ruEUqAIDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD828443E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 00/16] Add meson build system and HTML docs
Date: Wed, 28 Jan 2026 23:11:50 +0100
Message-ID: <20260128221536.2319084-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeduiedufeekkeffkefffefggeetjedtvedvtedufedtheduueeivedukeffjeejtdenucffohhmrghinhepshgvrhhvihgtvgdrihhnnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepteffkedvkeeggeefgfehpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 0

Changes since v6:
Drop:
  doc: Port sap-api.txt to RST
  doc: Port health-api.txt to RST
  doc: Add "C" code-block markers for coding-style doc
  tools: Install btmgmt along with other tools

SAP and health profiles were removed, the C code-block marker needs a
dependency check (both autotools and meson), and btmgmt was superseded
by bluetoothctl's mgmt submenu.

"build: Only build gdbus library if there is a user" was fixed to
also build gdbus if the daemon was built.

"github: Add docs deployment" was modified to be ready to deploy
in bluez' github.

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

Paul Otto (2):
  client: Expand GATT submenu documentation
  doc: Add introduction to GATT

 .github/workflows/docs.yml                    |  54 +
 attrib/meson.build                            |  17 +
 btio/meson.build                              |   1 +
 client/meson.build                            |  29 +
 completion/meson.build                        |   3 +
 doc/_static/bluez.css                         | 452 +++++++++
 doc/_static/bluez.png                         | Bin 0 -> 17550 bytes
 doc/_static/bullet.svg                        |   1 +
 doc/_static/card.png                          | Bin 0 -> 38230 bytes
 doc/_static/inter.woff2                       | Bin 0 -> 345588 bytes
 doc/_static/toc_bullet.svg                    |  39 +
 doc/bluetoothctl-cmd.rst                      |  34 +
 doc/bluetoothctl-gatt.rst                     |  79 +-
 doc/conf.py                                   |  39 +
 doc/copy-subdir.py                            |  14 +
 doc/daemons.rst                               |  12 +
 doc/dbus-gatt.rst                             |  18 +
 doc/dbus-obex.rst                             |  33 +
 doc/dbus.rst                                  |  76 ++
 doc/deprecated-tools.rst                      |  22 +
 doc/dev-maint.rst                             |  17 +
 doc/favicon.ico                               | Bin 0 -> 937 bytes
 doc/gatt-intro.rst                            | 141 +++
 doc/index.rst                                 |  47 +
 doc/meson.build                               | 290 ++++++
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
 50 files changed, 4055 insertions(+), 24 deletions(-)
 create mode 100644 .github/workflows/docs.yml
 create mode 100644 attrib/meson.build
 create mode 100644 btio/meson.build
 create mode 100644 client/meson.build
 create mode 100644 completion/meson.build
 create mode 100644 doc/_static/bluez.css
 create mode 100644 doc/_static/bluez.png
 create mode 100644 doc/_static/bullet.svg
 create mode 100644 doc/_static/card.png
 create mode 100644 doc/_static/inter.woff2
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

