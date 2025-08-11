Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7552D9EFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943701; cv=none; b=MDHO9s2/ErTMHEiFS+cwiyN3QWCl513Tohq7lAEUMUZRacEZsUlcSzvEPcJROde5YT8QPX5hD5mOW5OczOHvGUHyuUV4jnp2/ZMzohw9FoiQoFiiGde59fayuHaeXJpO5FB4JkjejE0RpsIMC1frAMWc+90A1hdfXMtVZy4QFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943701; c=relaxed/simple;
	bh=E/4s86+zv2iSqOUM3+J6HSWErv9yeYO28IUDU3w9ktI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NZn0gAQV2ROBlRTJWX/4e347VvpvqWS4Gin6mtd9O3xwgZO9QeWJyLIetDDHnncPkl6bGtAtvvLIT66hdLwi4QFKtRXTnqsrnQ8cMPG2Te9p1yUIHXGilLXlnPNXUcBF59Hp0VSDfg8ewWMdHUuH6mxY+6NCC0m98PbkejuOuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GK80RZS5; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GK80RZS5"
Received: from github.com (hubbernetes-node-b43dc93.va3-iad.github.net [10.48.141.37])
	by smtp.github.com (Postfix) with ESMTPA id 2C4B4E040F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754943699;
	bh=tgEzrT0giKzxW6rmSKSj+Cqv+pUVTgI6yoTIVeHEXIk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GK80RZS5UgoeyQbhtKQcZXyiXr7/nPvdrvxyZnxo8lRCt+TVyJGjIolIrv0N4KILZ
	 5pYnIdfnv1Bf88MYd4ZgFiu97F4/tWw19GvWe3t13kip/lCbPTphUikrnVkA2Vau2E
	 1Ju+zJrz9gAE5f2wVCnxYMJOSyms9ohXn5ck8Jko=
Date: Mon, 11 Aug 2025 13:21:39 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990211/000000-3bcf3b@github.com>
Subject: [bluez/bluez] 1ee87e: build: Add ell subproject
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/990211
  Home:   https://github.com/bluez/bluez
  Commit: 1ee87ec0a0439e19eddf8a0a536b7a5d9f1e8119
      https://github.com/bluez/bluez/commit/1ee87ec0a0439e19eddf8a0a536b7=
a5d9f1e8119
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M .gitignore
    A .gitmodules
    A subprojects/ell

  Log Message:
  -----------
  build: Add ell subproject

Add the ell library as a subproject. Rather than doing like autotools
and relying on users checking out ell in a particular location, or
install ell as a system shared library, use meson subprojects to build
our own internal copy of ell if the user hasn't installed it
system-wide.

Note that this currently points to a fork of ell with meson support
added, this should be switched to the upstream repo when that support is
merged. See:
https://lore.kernel.org/ell/20250807134859.930870-1-hadess@hadess.net/T/


  Commit: 5053fe10fc3e3d5dbbb82d4c3049c063d5c9cc8f
      https://github.com/bluez/bluez/commit/5053fe10fc3e3d5dbbb82d4c3049c=
063d5c9cc8f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

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
- asan: b_sanitize=3Daddress
- lsan: b_sanitize=3Dleak
- ubsan: b_sanitize=3Daddress,undefined
https://mesonbuild.com/Builtin-options.html#base-options

--enable-coverage is replaced by the b_coverage option:
https://mesonbuild.com/Builtin-options.html#base-options

--enable-valgrind can be replicated by running the test suite with:
meson test --setup valgrind


  Commit: 5954256c2d3f7940919d5784c78bb65339ab4bb1
      https://github.com/bluez/bluez/commit/5954256c2d3f7940919d5784c78bb=
65339ab4bb1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

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


  Commit: 77252be95ebff991ddb7036eec30371be0998c66
      https://github.com/bluez/bluez/commit/77252be95ebff991ddb7036eec303=
71be0998c66
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M meson.build
    M meson_options.txt

  Log Message:
  -----------
  build: Separate systemd and libsystemd dependencies

One is to install systemd service files, the other to enable deeper
logind integration into obexd.


  Commit: 2fba306add1797113bbd82b7f535b0d50a3a4829
      https://github.com/bluez/bluez/commit/2fba306add1797113bbd82b7f535b=
0d50a3a4829
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install gatttool if deprecated tools are enabled

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D720486


  Commit: 996b2370329ca40b19bf48fac087a631cda547e0
      https://github.com/bluez/bluez/commit/996b2370329ca40b19bf48fac087a=
631cda547e0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install avinfo tool by default

It's used for checking which audio codecs are supported by a Bluetooth
audio device, which is more useful now that PulseAudio/PipeWire support
alternative codecs like LDAC or aptX).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1699680


  Commit: 9dfad07446932fffc6ff102cd543cd3899a0f722
      https://github.com/bluez/bluez/commit/9dfad07446932fffc6ff102cd543c=
d3899a0f722
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M tools/meson.build

  Log Message:
  -----------
  tools: Install btmgmt along with other tools

btmgmt is not installed by "make install", but it is useful for debugging=
=E2=80=A2
some issues and to set the MAC address on HCIs which don't have their=E2=80=
=A2
MAC address configured.


  Commit: 3bcf3badf4ced0f67baf18f155860a4264732110
      https://github.com/bluez/bluez/commit/3bcf3badf4ced0f67baf18f155860=
a4264732110
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M emulator/meson.build

  Log Message:
  -----------
  emulator: Install the emulator if built

It's useful for testing.


Compare: https://github.com/bluez/bluez/compare/1ee87ec0a043%5E...3bcf3ba=
df4ce

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
