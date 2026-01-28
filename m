Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1463033F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615767; cv=none; b=oRxuqPZh/iLeWocr8OIIT4UKTvnQmJYWA22b3JgccAh/leVQlL5tQw5t0gw1C1o+viVtE8k0P6rhvfs8Z0a5xx1yTlLsY6Ywi5d5VwLiXSK9IEu5OKM9Jcp67Dots6RsPM9gnFXjfvQ7NEc5449WiOHoW4QzwyktkNqMk+T0PQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615767; c=relaxed/simple;
	bh=kEM5dVBiug55pBXLsa3SpEVxaPqLauMG70vFuw6Z+gQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=itv0ipFA3UU5cnE3jeJaXUVMU4BekJ+ciwWBd5kM1qYY07R3OnmFfQhXZuqrN4E2RmQ/qTCKbwo9H7t8pnufp+krsOBx/6g/4utilqMddpMmECLI6DVImB1YKmxpM8ixEXu+FUpWof+Jbpno7gqtV9SQB3ou9zqZ8wJT+yyVUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D42B043FC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:55:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 00/20] Add meson build system and HTML docs
Date: Wed, 28 Jan 2026 16:11:38 +0100
Message-ID: <20260128155548.2025252-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 49
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffejuddtudduveegvdevhfethedtgeeihefghfehueekvefgjeeggeefvdegteevnecuffhomhgrihhnpehgihhthhhusgdrihhopdhsvghrvhhitggvrdhinhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffgedvuedtgeefhfevkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

This is a follow-up from the
"[PATCH BlueZ v5 2/9] build: Add meson build system"
patch series in October 2025.

In addition to updating the build system to the latest changes in the
codebase (uinput split, 6lowpan-tester, battery test, tmap/gmap test
and profile, hfp profile, mcp test, rap), this new version also adds:
- Test suite parallelisation speed-ups (the complete test suite now runs
  in 3.6 seconds instead of 16 seconds on my system, and speed-ups to
  the tests themselves were contributed thanks to this port)
- HTML Documentation generation including for D-Bus APIs, C API docs,
  man pages and qualifications (144 pages in total)

As a reminder, meson brings us:
- easier to understand, better documented build system language instead
  of something maybe out of GNU Makefiles, m4 and shell scripts, and
  better error messages when problems are seen
- requirements are limited to the ninja native binary, and Python 3
- better support for "vendoring" dependencies such as ell without having
  to include them directly in the bluez sources
- simpler "dist" process which uses a git snapshot, and does not require
  the creation of any temporary files (Makefile.am -> Makefile.in,
  configure.ac -> configure, etc.)
- better native support for various sanitisers, running tests under
  valgrind and other analysers, and generating coverage statistics
- native support for integrating Rust in the C codebase, which is
  something I've experimented with and managed to created a full Rust
  plugin

Adding meson support does not require removing autotools, so when this
patchset is merged, it is expected that a transition period exists so
that the CI and other automation can be ported to meson without
disruption to existing processes.

Planned enhancements to the CI made possible by meson include:
- Running the test suite under an PPC64 big endian QEMU
- public library ABI regression testing with abidiff
- code coverage generation to effective upstream testing

Note that "github: Add docs deployment" will need to be modified before
it is merged to the main bluez repo, as it is currently setup to deploy
documentation to this test website:
https://hadess.github.io/bluez/

Bastien Nocera (18):
  doc: Port sap-api.txt to RST
  doc: Port health-api.txt to RST
  doc: Add "C" code-block markers for coding-style doc
  build: Add meson wrap for libell
  build: Add meson build system
  build: Make more use of 'feature' options
  build: Separate systemd and libsystemd dependencies
  tools: Install gatttool if deprecated tools are enabled
  tools: Install avinfo tool by default
  tools: Install btmgmt along with other tools
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
 Makefile.am                                   |  18 +-
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
 doc/coding-style.rst                          |  46 +-
 doc/conf.py                                   |  39 +
 doc/copy-subdir.py                            |  14 +
 doc/daemons.rst                               |  12 +
 doc/dbus-gatt.rst                             |  18 +
 doc/dbus-obex.rst                             |  33 +
 doc/dbus.rst                                  |  84 ++
 doc/deprecated-tools.rst                      |  22 +
 doc/dev-maint.rst                             |  17 +
 doc/favicon.ico                               | Bin 0 -> 937 bytes
 doc/gatt-intro.rst                            | 141 +++
 doc/health-api.txt                            | 152 ---
 doc/index.rst                                 |  47 +
 doc/meson.build                               | 294 ++++++
 doc/org.bluez.HealthChannel.rst               |  72 ++
 doc/org.bluez.HealthDevice.rst                |  94 ++
 doc/org.bluez.HealthManager.rst               |  68 ++
 doc/org.bluez.SimAccess.rst                   |  40 +
 doc/protocols.rst                             |  20 +
 doc/qualifications.rst                        |  76 ++
 doc/sap-api.txt                               |  20 -
 doc/tools.rst                                 |  24 +
 emulator/meson.build                          |  36 +
 gdbus/meson.build                             |  19 +
 gobex/meson.build                             |   8 +
 lib/meson.build                               |  53 +
 mesh/meson.build                              |  60 ++
 meson.build                                   | 300 ++++++
 meson_options.txt                             |  57 ++
 monitor/meson.build                           |  37 +
 obexd/meson.build                             | 121 +++
 peripheral/meson.build                        |  13 +
 plugins/meson.build                           |  29 +
 profiles/meson.build                          | 188 ++++
 src/meson.build                               |  90 ++
 src/shared/meson.build                        |  85 ++
 subprojects/ell.wrap                          |  11 +
 .../0001-build-Add-meson-build-system.patch   | 922 ++++++++++++++++++
 test/meson.build                              |  41 +
 tools/mesh/meson.build                        |  16 +
 tools/meson.build                             | 307 ++++++
 tools/mpris-proxy.service.in                  |   2 +-
 unit/meson.build                              | 163 ++++
 unit/unittest_list.sh                         |  15 +
 58 files changed, 4411 insertions(+), 222 deletions(-)
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
 delete mode 100644 doc/health-api.txt
 create mode 100644 doc/index.rst
 create mode 100644 doc/meson.build
 create mode 100644 doc/org.bluez.HealthChannel.rst
 create mode 100644 doc/org.bluez.HealthDevice.rst
 create mode 100644 doc/org.bluez.HealthManager.rst
 create mode 100644 doc/org.bluez.SimAccess.rst
 create mode 100644 doc/protocols.rst
 create mode 100644 doc/qualifications.rst
 delete mode 100644 doc/sap-api.txt
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

