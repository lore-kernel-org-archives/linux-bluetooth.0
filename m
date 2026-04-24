Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276637E2F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022023; cv=none; b=L3VZZrDPXAmm83Fp6mZSQsRfJONho9IAi0R/2YFSSaE9xT24enNzxiIvF4alcGWbLl7wHdoTqAw8wdvV82RB5ddohfDvz7AUC1y4xArhzVFzFA/LBBBi3K03QIVa6zIz6cKvWpYLmLpJbhMRBw7CfygzniJbXKLi0V5Ip6qPJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022023; c=relaxed/simple;
	bh=8Vk8MP9VMPZiFyJamjXUA3+kIziDBT+t0U29cY0TMI4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MY2I7OUuwJlVbaKtHEkoq0urnLshMns0b7QO5N/yQinhK5a0bVugsXEbjyLHum6wmO22iYM0hXD1xXpx9utHr+kuEW2W55wo8vZOoabfJNXJIvX6pWKrL8jblQRRSUyp9FmWh/VI3kh7aujt3etEVvVR9OhJXVKoIEtb2FbYges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 298EC3EBE4
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 00/15] Add meson build system and HTML docs
Date: Fri, 24 Apr 2026 11:11:03 +0200
Message-ID: <20260424091324.3097084-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTElM1nui0nfrPVv6LIHXd0VoV85iG9vW9rfJGa7/rwK8jd87+zGinZ0bwvdeamFMTeUOOzE6WT4pydna4GpKlyI2C5L7g0fGEq/tWxZVC+MH29oxnYK/MKVsWZ0ciwTqbE6YqAxv/Dlizfr9mLCZa2PLzEKErxkmCtWQcjLCML7jbEb125l0HmYtrrISu7mMDGzX4aUXvKU5r0jAX5zfsNAQalJYuN6DBLeRhe2v65HVQ0OkpdkYUsqQ1wOX2twwWffrP6jRBsnCatEU+RGMpXkofd2k5vb8Aqm8xb++1cs+BoUZlxzXPRmwZpfHvfYXwSYJvB2bS5USHneQd9QcFU2OBar1IHRG9/Y6moOZtQPbnTpIZH00qE+G292PKEDNmP0RuO3FEFbzwb0wSfBm/lka0uFKrULhS7YDM/Hxl/+XZXn5j9Xljz4EGWR2YOCFB8Zxj1ipBi2mZTu4P+vznp4WRha3CEMIJRu65ChT9hiri7SIA9z9hLIQm/f15l7TLCTzd8VVQa8+h/wTlPxEe6nyKb2mc1TqMYxftkHp5pfzskMD5Mt7TwH4K2DVeIIKvhDOCtB5ggdQMM8SUATlsRqP1ywamrmrkG2HmbuqzbdEoW29vxV7v0uPVU326B474d9VyICXJ4JpOaWta9DbnCyYGv5S2lyeTezEuVKCq57pQ
X-GND-State: clean
X-GND-Score: 0

Changes since v8:
- add btsnoop protocol to the docs and generate man page
- fix duplicated labels when linking to SCO and ISO docs
- add test-util to the test suite
- remove hcidump
- fix btpclient build
- remove glib dependency from btvirt
- add bluetoothctl completion crash regression test
- add config warning regression test
- link btmgmt against glib

Bastien Nocera (14):
  build: Add meson wrap for libell
  build: Add meson build system
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
 client/btpclient/meson.build                  |  19 +
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
 doc/deprecated-tools.rst                      |  22 +
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
 meson.build                                   | 323 ++++++
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
 tools/meson.build                             | 262 +++++
 tools/mpris-proxy.service.in                  |   2 +-
 unit/integration-test-skipped.sh              |   3 +
 unit/integration-test.py                      | 271 +++++
 unit/meson.build                              | 194 ++++
 unit/output_checker.py                        | 214 ++++
 unit/unittest_inspector.py                    |  46 +
 unit/unittest_list.sh                         |  15 +
 54 files changed, 4577 insertions(+), 1 deletion(-)
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
2.53.0

