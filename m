Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7425782F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006818; cv=none; b=pVoSPgKzZunSmoNWy99O2QChk9EjyHzfpkGsteZnwWZjgG7pB3wN4876zVWCSFdWIqCayXyUegBs00hHbhZdcVV/OxOFSD1f5ReIqrhNFxtpV4dMfH6ujuTQ+3oPmdxO82Vg7VC5RbQ3nYZpBq4AIDVM9QcsbAdjKxfuxiG9WXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006818; c=relaxed/simple;
	bh=ojxjfj3YqatHh3ruOSBnnBkr01NcCHYR5WnhUYyz2Ns=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gU0i/Y+9xN6WBkgb5n9bjTfysWF3d+RAwpx0t8Uqcg3hPniuUzvfkJnMME/urCMWfV43aVXf79myvMnn5hBF5MXwcmqO/5sym7e72PcV9zl1mbmOUN6grK/OCfoEq2AvQnceZSTZJIlXdBZzVUbFEjtJGkA12TPJQPTBGYbbnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g/otjQS2; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g/otjQS2"
Received: from github.com (hubbernetes-node-9fae943.ash1-iad.github.net [10.56.152.26])
	by smtp.github.com (Postfix) with ESMTPA id 6FFED1403F0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 03:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760006815;
	bh=QAhGIe3vfUx7W82v4+hVRKFZbdNiOqWAYRKrvD+l9Ds=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g/otjQS2Q07C0FDI6Plk0/BX+3OXYqpIVwR3kVvdn36RE0WB2ZkaIEQ2IbAH70tI3
	 dBNSqlKOJDfqAzbVzjle9v6Xxrk5X7nCqOZ3kPDMV/xIA7vrl8IXKVkmywAiWshBAZ
	 q8GX+4ijrhdUqYXgEfGp2apkK9ChL3WNAmSH0bLI=
Date: Thu, 09 Oct 2025 03:46:55 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009682/000000-d81ea1@github.com>
Subject: [bluez/bluez] 1608a5: build: Add meson wrap for libell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1009682
  Home:   https://github.com/bluez/bluez
  Commit: 1608a596533b79e346ab64bd13f5848412a5a057
      https://github.com/bluez/bluez/commit/1608a596533b79e346ab64bd13f5848412a5a057
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    A subprojects/ell.wrap
    A subprojects/packagefiles/0001-build-Add-meson-build-system.patch

  Log Message:
  -----------
  build: Add meson wrap for libell

Rather than relying on libell being able to build with meson from
upstream, apply the meson build patches on top of the latest upstream
release.

The build should still fallback to the system libell if available, and
will fail to build if a system libell is not available, and no network
access is available, as in many build systems.


  Commit: 00f10ccc2aba5ad30e797fac3ffa6c857670403c
      https://github.com/bluez/bluez/commit/00f10ccc2aba5ad30e797fac3ffa6c857670403c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    A attrib/meson.build
    A btio/meson.build
    A client/meson.build
    A completion/meson.build
    A doc/meson.build
    A emulator/meson.build
    A gdbus/meson.build
    A gobex/meson.build
    A lib/meson.build
    A mesh/meson.build
    A meson.build
    A meson_options.txt
    A monitor/meson.build
    A obexd/meson.build
    A peripheral/meson.build
    A plugins/meson.build
    A profiles/meson.build
    A src/meson.build
    A src/shared/meson.build
    A test/meson.build
    A tools/mesh/meson.build
    A tools/meson.build
    M tools/mpris-proxy.service.in
    A unit/meson.build

  Log Message:
  -----------
  build: Add meson build system

The options default were selected to try and match the existing
autotools default as best as possible. Further commits will likely
change those defaults, but at least it should be clear what defaults
were changed from.

However, a number of options were removed:

--enable-pie is replaced by the meson base option "b_pie":
https://mesonbuild.com/Builtin-options.html#base-options

--enable-maintainer-mode is replaced by the "debug" build-types:
https://mesonbuild.com/Builtin-options.html#core-options

--enable-debug and --disable-optimization are replaced by the
debug build type:
https://mesonbuild.com/Builtin-options.html#details-for-buildtype

Each of the sanitisers have their own b_sanitize option:
- asan: b_sanitize=address
- lsan: b_sanitize=leak
- ubsan: b_sanitize=address,undefined
https://mesonbuild.com/Builtin-options.html#base-options

--enable-coverage is replaced by the b_coverage option:
https://mesonbuild.com/Builtin-options.html#base-options

--enable-valgrind can be replicated by running the test suite with:
meson test --setup valgrind


  Commit: 19ec8a22f4881bd83adf0ed530f275b54fd4a536
      https://github.com/bluez/bluez/commit/19ec8a22f4881bd83adf0ed530f275b54fd4a536
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M client/meson.build
    M emulator/meson.build
    M lib/meson.build
    M mesh/meson.build
    M meson.build
    M meson_options.txt
    M monitor/meson.build
    M obexd/meson.build
    M peripheral/meson.build
    M plugins/meson.build
    M profiles/meson.build
    M src/meson.build
    M tools/mesh/meson.build
    M tools/meson.build
    M unit/meson.build

  Log Message:
  -----------
  build: Make more use of 'feature' options

This allows finer control around what is built and what is not,
trying to build as much as possible by default.

This also makes it easier to enable all the "auto" features which would
then fail if dependencies are missing (maximalist builds, for testing),
or disable everything by default, and only enable select options, which
minimises side-effects for distributions.


  Commit: f9eb5989f36910e0806aa0009dc28297079c23ab
      https://github.com/bluez/bluez/commit/f9eb5989f36910e0806aa0009dc28297079c23ab
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Separate systemd and libsystemd dependencies

One is to install systemd service files, the other to enable deeper
logind integration into obexd.


  Commit: 4a4e6bbc6a41af5fec9747e44ba20ae263d2e5cb
      https://github.com/bluez/bluez/commit/4a4e6bbc6a41af5fec9747e44ba20ae263d2e5cb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install gatttool if deprecated tools are enabled

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486


  Commit: 436b08c2c52785bc5040a4a923ba2520d5e77133
      https://github.com/bluez/bluez/commit/436b08c2c52785bc5040a4a923ba2520d5e77133
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install avinfo tool by default

It's used for checking which audio codecs are supported by a Bluetooth
audio device, which is more useful now that PulseAudio/PipeWire support
alternative codecs like LDAC or aptX).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1699680


  Commit: ba36317ab1c48e28849e1aa6ed432459e3901ea1
      https://github.com/bluez/bluez/commit/ba36317ab1c48e28849e1aa6ed432459e3901ea1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install btmgmt along with other tools

btmgmt is not installed by default, but it is useful for debugging
some issues and to set the MAC address on HCIs which don't have their
MAC address configured.


  Commit: 2f4572be011a2cb6a5d8d594e8532f287cb2ceb3
      https://github.com/bluez/bluez/commit/2f4572be011a2cb6a5d8d594e8532f287cb2ceb3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M emulator/meson.build

  Log Message:
  -----------
  emulator: Install the emulator if built

It's useful for testing.


  Commit: 40d1d7c7cb035ebf4c174ce8fbbf2ea498e85f2e
      https://github.com/bluez/bluez/commit/40d1d7c7cb035ebf4c174ce8fbbf2ea498e85f2e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Add option to allow disabling bluetoothd

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.


  Commit: d81ea160f99160cf60b912d654db3da29fc990dc
      https://github.com/bluez/bluez/commit/d81ea160f99160cf60b912d654db3da29fc990dc
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M lib/meson.build
    M meson.build

  Log Message:
  -----------
  build: Add License field to pkg-config file

And require a much newer version of meson.


Compare: https://github.com/bluez/bluez/compare/1608a596533b%5E...d81ea160f991

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
