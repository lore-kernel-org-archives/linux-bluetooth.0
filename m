Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EA43C05D
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284333; cv=none; b=bYBXyiv++RFGU1r51QP73XejrICiWzq66YyMYOplL5UNzUpzOM2+OJhnQMnWpjrXhepAP4Iec9j2g+gMGVYnH+cezwCaRg25gIGs1ncJBv3Vr4lVbe9lU1ewJ9xDe6kriLpn8zMPMh+KPJDEUKjbBbHsGuJ9VGsUpgUTW/Njuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284333; c=relaxed/simple;
	bh=E/o4NE+9aG5A0YH3VVl/QooVoy8dFHVQcV14ch27Ngk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Re5ve91CkJ2tltHXENOnGtM1kEvPFZWqwxts3Jl0oIZMIGYtvttEBKaMXZqIGtlbONukLq/IGrawKWfvOIKsH0T1TFYNsQQ36KLrkdwMWSOgFriB0noeJV5dzO5c/+7ju4GX6vq3ca/zW054KOFvy+e/YPqud/3hPowtQAW29Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=D0IMXSVt; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="D0IMXSVt"
Received: from github.com (hubbernetes-node-14c492b.va3-iad.github.net [10.48.204.89])
	by smtp.github.com (Postfix) with ESMTPA id 9814F4E0451
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772284331;
	bh=n0FyQvjImRcW40b/J9eEidRQRjaTEg7v5ueZi3g91q4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=D0IMXSVtAiI3UdSsTYAGsbJj6p0IxW9xvX4GHayUMN1tOCBQRe6MPjvx6+PviCmDG
	 5WrafMw8dtTiEJLS9pfGCihcTjtx3alMpiEvPBcP2CholwzumTPmw5PQJ5r9fFH6Du
	 ZN16gNFbqgPxWVvtw919Nh4H2/pMH+bQU0RIo3sg=
Date: Sat, 28 Feb 2026 05:12:11 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059428/000000-feb53f@github.com>
Subject: [bluez/bluez] 16cc4d: emulator: btvirt: check pkt lengths, don't get
 stu...
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

  Branch: refs/heads/1059428
  Home:   https://github.com/bluez/bluez
  Commit: 16cc4d43f56f9fe76c1bb048235b43d389039699
      https://github.com/bluez/bluez/commit/16cc4d43f56f9fe76c1bb048235b43d389039699
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: check pkt lengths, don't get stuck on malformed

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.


  Commit: ccb109943ea6f0a9e50940a2c49188e437be874b
      https://github.com/bluez/bluez/commit/ccb109943ea6f0a9e50940a2c49188e437be874b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M emulator/main.c

  Log Message:
  -----------
  emulator: btvirt: allow specifying where server unix sockets are made

Make --server to take optional path name where to create the various
server sockets.


  Commit: b79db08053a6bfc8175c25a3d7712a600b4fb4f4
      https://github.com/bluez/bluez/commit/b79db08053a6bfc8175c25a3d7712a600b4fb4f4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable path argument for --unix

Allow specifying the path for the controller socket to be used.


  Commit: cacb4e991a58aeabaca5d937f655e72116a945c0
      https://github.com/bluez/bluez/commit/cacb4e991a58aeabaca5d937f655e72116a945c0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -o/--option option

Allow passing arbitrary arguments to QEMU.


  Commit: 49b9867ce58599ae039db702c41b93a6f21266c6
      https://github.com/bluez/bluez/commit/49b9867ce58599ae039db702c41b93a6f21266c6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: allow source tree root for -k

Allow passing source tree root for -k option, look up kernel below it.


  Commit: 526a4b1090836b9f97f71d79944e0145c954e6f5
      https://github.com/bluez/bluez/commit/526a4b1090836b9f97f71d79944e0145c954e6f5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.


  Commit: 88b06e80e3e9761ff8ecdceb124d8deca4747eb7
      https://github.com/bluez/bluez/commit/88b06e80e3e9761ff8ecdceb124d8deca4747eb7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: use virtio-serial for implementing -u device forwarding

Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
kernel seems to be sometimes dropping part of the sent data or insert
spurious \0 bytes, leading to sporadic errors like:

    kernel: Bluetooth: hci0: command 0x0c52 tx timeout
    kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
    btvirt: packet error, unknown type: 0

This appears to occur most often when host system is under load, e.g.
due to multiple test-runners running at the same time.  The problem is
not specific to btvirt, but seems to be in the qemu serial device layer
vs. kernel interaction.

Change test-runner to use virtserialport to forward the btvirt
connection inside the VM, as virtio-serial doesn't appear to have these
problems.

Since it's not a TTY device, we have to do vport <-> tty-with-hci-ldisc
forwarding of the data in test-runner, so this becomes a bit more
involved.


  Commit: 896d393768d79c3d4fd36e9e584c8c57d023d017
      https://github.com/bluez/bluez/commit/896d393768d79c3d4fd36e9e584c8c57d023d017
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 266aab3e510e73e73358922916335f4c40e9cd9d
      https://github.com/bluez/bluez/commit/266aab3e510e73e73358922916335f4c40e9cd9d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    A unit/func_test/__init__.py
    A unit/func_test/conftest.py
    A unit/func_test/lib/__init__.py
    A unit/func_test/lib/env.py
    A unit/func_test/lib/host_plugins.py
    A unit/func_test/lib/rpc.py
    A unit/func_test/lib/runner.py
    A unit/func_test/lib/tests/__init__.py
    A unit/func_test/lib/tests/test_rpc.py
    A unit/func_test/lib/utils.py
    A unit/func_test/requirements.txt
    A unit/func_test/test_bluetoothctl_vm.py
    A unit/func_test/test_btmgmt_vm.py
    A unit/pytest.ini
    A unit/test-functional

  Log Message:
  -----------
  unit: add functional/integration testing framework

Add framework for writing tests simulating "real" environments where
BlueZ and other parts of the stack run on different virtual machine
hosts that communicate with each other.

This uses tools/test-runner to launch VM instances, but does not use the
intra-VM setup code to allow reusing the same VM instances for multiple
tests.

Implements:

- RPC communication with tester instances running each of the VM hosts,
  so that tests can be written on the parent host which coordinates the
  execution.

- Extensible way to add stateful test-specific code inside the VM
  instances

- Logging control: output from different processes running inside the VM
  are separated and can be filtered.

- Test runner framework with Pytest (more convenient than Python/unittest)

- Grouping tests to minimize VM reboots

- Redirecting USB controllers to use for testing

There is no requirement that the tests spawn VM instances, the test
runner can be used for any tests written in Python.


  Commit: 4caba4aaccf48fd6086241a5d7633f6b2851176e
      https://github.com/bluez/bluez/commit/4caba4aaccf48fd6086241a5d7633f6b2851176e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    A unit/func_test/test_pipewire.py
    M unit/pytest.ini

  Log Message:
  -----------
  unit: func_test: add Pipewire-using smoke tests

Add test for Pipewire hosts connecting A2DP/HFP BREDR services to each
other


  Commit: feb53f9ee079a4ba880720bcbb3057f9eda3d965
      https://github.com/bluez/bluez/commit/feb53f9ee079a4ba880720bcbb3057f9eda3d965
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-28 (Sat, 28 Feb 2026)

  Changed paths:
    M Makefile.am
    M configure.ac

  Log Message:
  -----------
  build: add functional testing target

This adds check-functional: target that runs the functional test suite.

Also add a --enable-functional-testing=<kernel-image> argument for
configure that can be used to include it in the check: make target,
possibly with a predefined kernel image.


Compare: https://github.com/bluez/bluez/compare/16cc4d43f56f%5E...feb53f9ee079

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
