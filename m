Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA191758B
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921348; cv=none; b=i9iHMhDR/1lA5MYuaSfZb6EQqaTFSrfFNS+tmhpEBlqes1o3V9ZVN4I5yhX3/4R13Jh3lptur/vO8Bo4wVPlwbpw/eQPut8J0v1b2nHPaElq4ZfmI1k8myibG9l//ygixsC0ZQUMhhcFvObKXECv9gH7PWxa4W6RMU8tBqALMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921348; c=relaxed/simple;
	bh=sjHITEzKpKQOhBrtcxHP2XM7DACWk/4W6dfo+sKhNko=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f+livENw2Pi3zj+7j0Ab5Hf4RikouPoRHwYaZnpNnuB4dqmg3Vrw2onkErZ1IHcmT7GIwlrUNzZj0l3yHyTtWJ1NBtiX4XITBQn/dOL+PkLC+eqNkQLUYbsYra1f/3fu2NxQB48hWmUIOQHuSvufkac5YK7AA6EPKySGW3gBKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hxwBH5Kp; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hxwBH5Kp"
Received: from github.com (hubbernetes-node-a79bd51.ash1-iad.github.net [10.56.176.19])
	by smtp.github.com (Postfix) with ESMTPA id BD8BB60039C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759921345;
	bh=+sIqgb8B4N/iS9XqUZLraM8+HE/GKl/COH93kFeeAkI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hxwBH5KpUJ6SJ9G5f3a/WUrTePRb9RSSzwR2U5UjWM5XSULt66Wq5E7q20j4lxOWg
	 2l01BI4om9C76P4J+latB7WZlnAyJyu2u3pZZcJHX5Pwxqa+KQRl73DENIKouhFPJ4
	 9T7t7zniSxQKaaPhCDTAHkNSQs4zTfTdlZluaQtQ=
Date: Wed, 08 Oct 2025 04:02:25 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009338/000000-2c2412@github.com>
Subject: [bluez/bluez] a19359: build: Add meson wrap for libell
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

  Branch: refs/heads/1009338
  Home:   https://github.com/bluez/bluez
  Commit: a19359abd9ad54a424518ac4edbca0dcd7fa3f30
      https://github.com/bluez/bluez/commit/a19359abd9ad54a424518ac4edbca0dcd7fa3f30
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

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


  Commit: 28290d2b62b84cfd25092c2b562cc73a1dc40346
      https://github.com/bluez/bluez/commit/28290d2b62b84cfd25092c2b562cc73a1dc40346
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

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


  Commit: f957f95564787cd1992ff3a84f54f4f76d8c8e29
      https://github.com/bluez/bluez/commit/f957f95564787cd1992ff3a84f54f4f76d8c8e29
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

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


  Commit: da5b74b28c7c5b752c7066966c2d5bdbbf120cc1
      https://github.com/bluez/bluez/commit/da5b74b28c7c5b752c7066966c2d5bdbbf120cc1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Separate systemd and libsystemd dependencies

One is to install systemd service files, the other to enable deeper
logind integration into obexd.


  Commit: ce00b97f1c240bdec48bb1b437595851932c4b4d
      https://github.com/bluez/bluez/commit/ce00b97f1c240bdec48bb1b437595851932c4b4d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install gatttool if deprecated tools are enabled

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486


  Commit: 2e15dff70a95bf1bf061fbf6a228c4c4f3dc61f5
      https://github.com/bluez/bluez/commit/2e15dff70a95bf1bf061fbf6a228c4c4f3dc61f5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

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


  Commit: c5df447c8a4c5a26e4246778fe5ef887b3379433
      https://github.com/bluez/bluez/commit/c5df447c8a4c5a26e4246778fe5ef887b3379433
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install btmgmt along with other tools

btmgmt is not installed by default, but it is useful for debugging
some issues and to set the MAC address on HCIs which don't have their
MAC address configured.


  Commit: ebdb99025cbe518f59aa1050c907eba0a34fb6e8
      https://github.com/bluez/bluez/commit/ebdb99025cbe518f59aa1050c907eba0a34fb6e8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M emulator/meson.build

  Log Message:
  -----------
  emulator: Install the emulator if built

It's useful for testing.


  Commit: 82088ac51c0bb28997252ffd1e651bdfdc27ccf9
      https://github.com/bluez/bluez/commit/82088ac51c0bb28997252ffd1e651bdfdc27ccf9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Add option to allow disabling bluetoothd

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.


  Commit: 2c24125880a98e786dc629cf0079642fdb8d6dad
      https://github.com/bluez/bluez/commit/2c24125880a98e786dc629cf0079642fdb8d6dad
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M lib/meson.build
    M meson.build

  Log Message:
  -----------
  build: Add License field to pkg-config file

And require a much newer version of meson.


Compare: https://github.com/bluez/bluez/compare/a19359abd9ad%5E...2c24125880a9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
