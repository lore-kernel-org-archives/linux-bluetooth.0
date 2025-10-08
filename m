Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E929B77C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914944; cv=none; b=hjji3UuSdpfytV52F/bOkeBahlwZJzjE78cRoSHNAt7aaekSPMdyv9fq+EE+9rxtWNQQkqfIO2SqLUBVMuqwRYdsm1axrlUUqcgBCuRWbmK49CxnoO5wjIJBjSQP+ODLWc60YFLvCT9XHuseUj69z6pnZ2urMiJhtCKihYjafvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914944; c=relaxed/simple;
	bh=8Ti0GWBXo+YaZYsNtM/vIzsfurzdcIdnYNWJDyhKnVQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E4hbhZwb8/v8kbLXsf6HlIW6WZUPEYjCSQzKh/B1QdBKNUWgWzUdmmWI7wNo7ZJ8A3AgS0fkqS0Y9S5CbBmArIORMB0XLsyAe9u0s1Rebh/3KgiH7wd2RLIzb4WJ33fki44zAx5u1gYtpK8KG+Kt3crlTOutLhkC98y64BOxm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DR3wa/tU; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DR3wa/tU"
Received: from github.com (hubbernetes-node-8f1328a.ash1-iad.github.net [10.56.225.69])
	by smtp.github.com (Postfix) with ESMTPA id D6B0C1405B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759914941;
	bh=pXN/7HPGml/Ak5WQ2Pb8gEHEvk+EIkmPFiqAiS8PTxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DR3wa/tUWQ5kmu3Q4E54MOdE745+3lKyArOiDD+tv2yO0ZUN2W4tNNdCRIX8l8YQe
	 1ajDqFhmfb0PCmkACbmBbvfVpim6tuPLHWKZtqvs3UWRk+axfP76sth6pVdBxhgYrq
	 FKNMjca1yzShsxQYWCOKq9Wi9O6AZYEax6zs+f48=
Date: Wed, 08 Oct 2025 02:15:41 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009311/000000-45dd1c@github.com>
Subject: [bluez/bluez] 9c0695: build: Add meson wrap for libell
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

  Branch: refs/heads/1009311
  Home:   https://github.com/bluez/bluez
  Commit: 9c0695f0180d42e4fe7116bd7a32ce957cfe3b08
      https://github.com/bluez/bluez/commit/9c0695f0180d42e4fe7116bd7a32ce957cfe3b08
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


  Commit: 34f0c5d430c1a7e5b7fb509f0e70e07d6832f560
      https://github.com/bluez/bluez/commit/34f0c5d430c1a7e5b7fb509f0e70e07d6832f560
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


  Commit: c1097719198cd4a13bdb32499c5afda8b4410012
      https://github.com/bluez/bluez/commit/c1097719198cd4a13bdb32499c5afda8b4410012
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


  Commit: a8645a329c692d8ea1d606b753adfc630dd9f979
      https://github.com/bluez/bluez/commit/a8645a329c692d8ea1d606b753adfc630dd9f979
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


  Commit: 43ff2d1628a4974d49659b9462d3188f204ae752
      https://github.com/bluez/bluez/commit/43ff2d1628a4974d49659b9462d3188f204ae752
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


  Commit: 9bdf87cbc0ff1847a911d5b44fe9ad239097a541
      https://github.com/bluez/bluez/commit/9bdf87cbc0ff1847a911d5b44fe9ad239097a541
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


  Commit: f96b08b3231737d3b1ece35683e9ca5ac3c1a26c
      https://github.com/bluez/bluez/commit/f96b08b3231737d3b1ece35683e9ca5ac3c1a26c
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


  Commit: ff3841bf986ee7ccb544c108d5d327f16f96da6f
      https://github.com/bluez/bluez/commit/ff3841bf986ee7ccb544c108d5d327f16f96da6f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-08 (Wed, 08 Oct 2025)

  Changed paths:
    M emulator/meson.build

  Log Message:
  -----------
  emulator: Install the emulator if built

It's useful for testing.


  Commit: 45dd1c371333326ea256dc0fa55c2177879ed331
      https://github.com/bluez/bluez/commit/45dd1c371333326ea256dc0fa55c2177879ed331
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


Compare: https://github.com/bluez/bluez/compare/9c0695f0180d%5E...45dd1c371333

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
