Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535616;
	b=Z6g8uKbTQLDxaFhexAxNhPUJKEnk89Jn54QiU5qYqZtB+zn+EGcaaB+DgLJY4mR0j5RE
	 Ix8BQ3oBbIvQR8HmC/nFEQPPMpIGTKClDpSactDZzk676qowS+00N9L8eDMKQA2o8AyZY
	 BGoIQ/yDV3DflQsvQLQGJKxjKcr29xqNmj6EFKmehK5QZ6mw8t41Oha71Wv2fSN6+hf1O
	 xPomfrPXpOUKFyeA7OJAc8FV2bi96K0zZM5lsujGJg3E3U08meJ01A5Ed7iOocNe3oA07
	 z11j0d2MG9WYAP9p+/yMUWwnP+4iHPKwhFUUDvRxWGsJrQigy8XI9xpRSN7nOwMTH9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535616;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:
	 X-GND-Cause:X-GND-State;
	bh=hRGtj5qgvBe3ehYlbjNbLKfB/Dk283QhIwImtqkvhI8=;
	b=Pbya0ykLvzTTIyXMZeYz39gYmf6kWzNvaWELHqSpDJW+vtkbqu7CJVc1HjNrAXLnK81t
	 XUalhAEPnVbBzk9DbjSb5Rl4k7K8YAm/IiSxx2bzlMO/fHblYCGarLnVvbKcVMnzwMd13
	 HolZyHON3XDVEaLZbvlqKTk7xYLAkbDf+rJFZUX8qxFqez9BLSwHWmCZcnK8SluhWE38C
	 2rWkaqu6heRfgG1D/MidXXD+twqHzd/2AFC06Ib2oNolAdfvxvOzufRfnIItiGh6JY9pa
	 l3Us5mMJ2LqdEpZrVZOyZRHHEBrSVZPc23YtRAzzyEUIsmclUohhWNSO/ZjILJnAsuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A95606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A95606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 771753F59F
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:27 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 00/14] Add meson build system, tool unit tests, and HTML docs
Date: Tue, 24 Nov 2026 16:50:31 +0100
Message-ID: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTFUA/U8G510GYyvRvZj80MzdOwSzH5zbfKSrrPgZdSRnubX07gQPhPhd/jJO96kEKvAIn/y5m/NPWCE+TpV8kNq15cbMqRFHD5oo3kYmFScwEUM6deIeMTEEvWDrLM34faG0mBtuRKMlCgWp21aIq1sJtSS+IB1kuqVjBEGu6RqBg7+s5zjLu/umMqt23JPwNfdNTuIjuicdIMWNcoZZzxlQ/qhUP7Ouq21cKRLRzDnP5iAnAEz6syV3t5D31u7KBqwWWVL3VAzAa1PINxe5wOitO7uxyQzTvluiHNLh6kkg4E1fqpDcBlkffY93iwG8OzkigFMNnM5X4h4thdky3A5cH29IH3MP3zU4C1KGc7+3HS+76RZdpJD9S1CLDiFPfUQGHOYFrSp44xve+54H9xBYXOTsPsQywZqguHP/xnTkv6w45wmc4OnMHNNriWrnZIEJCFX5UxC7JyI/xDxnQlNnd1hRImzYXLxI9Cdl3j/F4tS2d6bGU8LEesJ4seViK0+z9cWlfOXQHjDzcIb+dzeW2uk5Cvhqs4XA71358YXIuwX5I0gZGnVzO1SSnhnYG+fkGAtL5j1qaLrKYSv0fBJrnoZwsoBW15XAR7KMTI0PH4oF0fchkBYrf5tTlUax+m4+gVNv6pZu4Els3sncmfYr20dqGP4qjAJA0B6wCVXDA
X-GND-State: clean

Changes since v10 that was sent back in May:
- Fix configdir not being absolute
- Add missing (empty) valgrind.supp file
- Bump version to 5.87, 5.88, update ell to 0.83
- Add Channel Sounding, Ranging, VirtIO/timetravel features
- Fix build for sdp-xml tests, hcidump and gatttool removal, gattrib/ and
  hog-lib directories removal, avrcp-parse and hfp-hf additions
- Update docs index to reference new docs, fix dbus-gatt link, remove
  security-bugs doc
- Rename "integration tests" to "tool integration tests"

Bastien Nocera (13):
  build: Add meson wrap for libell
  build: Add meson build system
  build: Separate systemd and libsystemd dependencies
  tools: Install avinfo tool by default
  emulator: Install the emulator if built
  build: Add option to allow disabling bluetoothd
  build: Only build profiles if the daemon is built
  unit: Run test-bap tests concurrently
  unit: Make gobex-transfer tests run concurrently
  build: Only build gdbus library if there is a user
  unit: Add command-line tool tests
  doc: Add HTML documentation
  github: Add docs deployment

Paul Otto (1):
  doc: Add introduction to GATT

 .github/workflows/docs.yml                    |   54 +
 btio/meson.build                              |    1 +
 client/btpclient/meson.build                  |   23 +
 client/meson.build                            |   34 +
 completion/meson.build                        |    3 +
 doc/_static/bluez.css                         |  452 +++++
 doc/_static/bluez.png                         |  Bin 0 -> 18354 bytes
 doc/_static/bullet.svg                        |    1 +
 doc/_static/card.png                          |  Bin 0 -> 35387 bytes
 doc/_static/figtree.woff2                     |  Bin 0 -> 14364 bytes
 doc/_static/toc_bullet.svg                    |   39 +
 doc/bluetoothctl-cmd.rst                      |   36 +
 doc/conf.py                                   |   39 +
 doc/copy-subdir.py                            |   14 +
 doc/daemons.rst                               |   12 +
 doc/dbus-gatt.rst                             |   20 +
 doc/dbus-obex.rst                             |   33 +
 doc/dbus.rst                                  |   78 +
 doc/deprecated-tools.rst                      |   20 +
 doc/dev-maint.rst                             |   19 +
 doc/favicon.ico                               |  Bin 0 -> 29152 bytes
 doc/gatt-intro.rst                            |  141 ++
 doc/index.rst                                 |   47 +
 doc/meson.build                               |  296 ++++
 doc/protocols.rst                             |   22 +
 doc/qualifications.rst                        |   76 +
 doc/tools.rst                                 |   24 +
 emulator/meson.build                          |   42 +
 gdbus/meson.build                             |   19 +
 gobex/meson.build                             |    8 +
 lib/meson.build                               |   53 +
 mesh/meson.build                              |   60 +
 meson.build                                   |  341 ++++
 meson_options.txt                             |   55 +
 monitor/meson.build                           |   38 +
 obexd/meson.build                             |  124 ++
 peripheral/meson.build                        |   13 +
 plugins/meson.build                           |   29 +
 profiles/meson.build                          |  166 ++
 src/meson.build                               |   96 +
 src/shared/meson.build                        |   86 +
 subprojects/ell.wrap                          |   11 +
 .../0001-build-Add-meson-build-system.patch   | 1545 +++++++++++++++++
 test/meson.build                              |   37 +
 tools/mesh/meson.build                        |   16 +
 tools/meson.build                             |  257 +++
 tools/mpris-proxy.service.in                  |    2 +-
 unit/meson.build                              |  189 ++
 unit/output_checker.py                        |  214 +++
 unit/tool-integration-test-skipped.sh         |    3 +
 unit/tool-integration-test.py                 |  271 +++
 unit/unittest_inspector.py                    |   46 +
 unit/unittest_list.sh                         |   15 +
 unit/valgrind.supp                            |    0
 54 files changed, 5219 insertions(+), 1 deletion(-)
 create mode 100644 .github/workflows/docs.yml
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
 create mode 100644 unit/meson.build
 create mode 100644 unit/output_checker.py
 create mode 100755 unit/tool-integration-test-skipped.sh
 create mode 100755 unit/tool-integration-test.py
 create mode 100755 unit/unittest_inspector.py
 create mode 100644 unit/unittest_list.sh
 create mode 100644 unit/valgrind.supp

-- 
2.56.0

