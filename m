Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9222157B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345871; cv=none; b=n1/toN2NnCjGlzP5qN9ny+6rPvmo8S0OL75w76rPe6xw0I5VExChyxEa51760wOCMfbFPf5sIh8KM17w+1FFcKTtjOYkOAFt6u2r9Ayeyyv/gMQUymupaC4ckMJRGT+lFMzKoh7a8GAF3Ha2T+P2GvSaXSOhlC1LJOX5ay6BU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345871; c=relaxed/simple;
	bh=dMxIoffZPCAxhUkYwFGlmCRpdZoar7T6ImeXYls4pB8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BJo8kKg5KtvmERhEUBaptSlZY6F/QccUy9YALBbXUG1erSy5SQwsHugsM9mxZfI9KyVf4a6oBxj7vRSJuoPMWT1ByoiLm9BHDYMyjdhWF27x5rx5tzE6vWH776R1Zdyv4YNcDmzoiOG+I403Ff67BIfHxwa4aX/kGij897mVGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qe99o16l; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qe99o16l"
Received: from github.com (hubbernetes-node-a6be26a.ac4-iad.github.net [10.52.144.41])
	by smtp.github.com (Postfix) with ESMTPA id 67B01640BCC
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760345868;
	bh=sxUYGGp5m2ze1EmhZKMvy4DnNpGdiby0bVAe4VkImq0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qe99o16l8rJ0pSTkvtuDYUKNu9sIamEfjB5OMIpWKu0NUuy+QkfmguW8/WvCj1Gfc
	 57RB0F/r1pVRgwMeuWazXLb3yQbjnF0PXDcVG2lhPVR779AVH3EEfl8M4PlINE3Nmv
	 R3it3aEPLvgppJGO5okAtppW93/jFt40Z7JBqvf8=
Date: Mon, 13 Oct 2025 01:57:48 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010619/000000-aaf853@github.com>
Subject: [bluez/bluez] d988be: build: Add meson wrap for libell
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

  Branch: refs/heads/1010619
  Home:   https://github.com/bluez/bluez
  Commit: d988beeea7f3ecb0e0afaeb0f9caeab339a0a6d6
      https://github.com/bluez/bluez/commit/d988beeea7f3ecb0e0afaeb0f9caeab339a0a6d6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

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


  Commit: b56c43e062347c2ae984a39de31b893518e096f7
      https://github.com/bluez/bluez/commit/b56c43e062347c2ae984a39de31b893518e096f7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

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


  Commit: 332be810577f6a8e4576ffc48034af9545bc2e26
      https://github.com/bluez/bluez/commit/332be810577f6a8e4576ffc48034af9545bc2e26
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

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


  Commit: 224c87320fe5442c921c897497605302fbb4fe77
      https://github.com/bluez/bluez/commit/224c87320fe5442c921c897497605302fbb4fe77
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Separate systemd and libsystemd dependencies

One is to install systemd service files, the other to enable deeper
logind integration into obexd.


  Commit: e807e36c14fbe2744aae8bb67b3f6c6302263382
      https://github.com/bluez/bluez/commit/e807e36c14fbe2744aae8bb67b3f6c6302263382
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install gatttool if deprecated tools are enabled

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486


  Commit: b7d1b282919d2494da7aa5255cfa48e9fd251566
      https://github.com/bluez/bluez/commit/b7d1b282919d2494da7aa5255cfa48e9fd251566
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

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


  Commit: 784ce017df7df6787270a5e5ae662b54e282bfd5
      https://github.com/bluez/bluez/commit/784ce017df7df6787270a5e5ae662b54e282bfd5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install btmgmt along with other tools

btmgmt is not installed by default, but it is useful for debugging
some issues and to set the MAC address on HCIs which don't have their
MAC address configured.


  Commit: 64b7af7074b04f4e0c9da5a66081af8c24fb16ce
      https://github.com/bluez/bluez/commit/64b7af7074b04f4e0c9da5a66081af8c24fb16ce
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M emulator/meson.build

  Log Message:
  -----------
  emulator: Install the emulator if built

It's useful for testing.


  Commit: aaf85318377320e5794b0a18e6b7eecc29d299b8
      https://github.com/bluez/bluez/commit/aaf85318377320e5794b0a18e6b7eecc29d299b8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Add option to allow disabling bluetoothd

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.


Compare: https://github.com/bluez/bluez/compare/d988beeea7f3%5E...aaf853183773

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
