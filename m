Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA43264E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693314; cv=none; b=tlVFsIpmLrQ23xiQTwxNuxJK9RHOAktTDYfHKOM+T/kT0NeJrYWjP4X3nJj+VEEe5j9zvobPgIrK02SNgc9TAP0prsBQVXO255JE+ik4oKhmkvRTk6FT8SnjRPU44itTPqU6uSw76aQQL8QgwzxqlcPKUbNFRvWQM6OVdUV9mOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693314; c=relaxed/simple;
	bh=+hUCqExMKZj3eYnRdB3+scrWy4/f+Wbh/01u/kP1KrE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=COsCzzjooNOgky0iX6zWThIFxYqUNb/0GfaWWcXqnoEcOHKTBygiKz1ntLn3oYlf6hpDMvsHHbMBuFP2oX6SAhsKgvV4ToMngIHKsOGacM3AF8Z5fiTm22yzCUM0bsQo1Z4c8oDq8hNbCl6xAxahEYREyubjGb5HKY9gAB2RK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z5oTNH8p; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z5oTNH8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778693310;
	bh=icTitDZx6RDos6DKC7BJnJKUC4jOt1EAz3KuO2+s+Q8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z5oTNH8pB5rovDqq7XTwIYEoHcwJyXWkyc2AoukxCoB2VSUcRNFbXds4KHBl2VCMy
	 KXwwjEg5CerP21a9mQnaVDpOrmErgdoaRAzGQb1dX6Czn2Mzxe3PcnFR7H5AR5yOBp
	 iJnfAqMdbtdTPn1gHvP8+dwA9p12m89Y9+B+kCts=
Received: from github.com (hubbernetes-node-c048ddc.va3-iad.github.net [10.48.12.54])
	by smtp.github.com (Postfix) with ESMTPA id A1283781155
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 10:28:30 -0700 (PDT)
Date: Wed, 13 May 2026 10:28:30 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1094320/000000-d2d058@github.com>
Subject: [bluez/bluez] 57ef69: emulator: btvirt: check pkt lengths, don't get
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

  Branch: refs/heads/1094320
  Home:   https://github.com/bluez/bluez
  Commit: 57ef69b7882151f5e6d94e9be8e3902277f81c80
      https://github.com/bluez/bluez/commit/57ef69b7882151f5e6d94e9be8e3902277f81c80
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: check pkt lengths, don't get stuck on malformed

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.


  Commit: 639f99a94734bcc1eb812a8d9dbf4e776017287e
      https://github.com/bluez/bluez/commit/639f99a94734bcc1eb812a8d9dbf4e776017287e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M emulator/main.c

  Log Message:
  -----------
  emulator: btvirt: allow specifying where server unix sockets are made

Make --server to take optional path name where to create the various
server sockets.


  Commit: ad264c862239892f0d9965b0b679ae36c88b5777
      https://github.com/bluez/bluez/commit/ad264c862239892f0d9965b0b679ae36c88b5777
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: support SCO data packets

Support also SCO data packets in btvirt.


  Commit: 2bf4030bb151631b24a425a82bddc8f3b2649595
      https://github.com/bluez/bluez/commit/2bf4030bb151631b24a425a82bddc8f3b2649595
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: btdev: clear more state on Reset

On controller Reset command, initialize most fields in struct btdev to
zero, similarly to the state just after btdev_create().

This excludes some fields like command bitmasks, which hciemu may have
adjusted.

To make this easier, add struct_group() macro similar to what kernel
uses.


  Commit: cf32208ed16e44e89474f4faa67293261641b208
      https://github.com/bluez/bluez/commit/cf32208ed16e44e89474f4faa67293261641b208
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable path argument for --unix

Allow specifying the path for the controller socket to be used.


  Commit: eef206c5e2f6291febea934eeb08d20ec3ff02b3
      https://github.com/bluez/bluez/commit/eef206c5e2f6291febea934eeb08d20ec3ff02b3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -o/--option option

Allow passing arbitrary arguments to QEMU.


  Commit: c0775bb788bdabecc573224b3d218c5e8348a38b
      https://github.com/bluez/bluez/commit/c0775bb788bdabecc573224b3d218c5e8348a38b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: allow source tree root for -k

Allow passing source tree root for -k option, look up kernel below it.


  Commit: f1e9b638a13c9893f4c29d6c958fbf5f9303f1cc
      https://github.com/bluez/bluez/commit/f1e9b638a13c9893f4c29d6c958fbf5f9303f1cc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

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


  Commit: a7947e84803d743fdb53948964f71ed312da4038
      https://github.com/bluez/bluez/commit/a7947e84803d743fdb53948964f71ed312da4038
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.


  Commit: 24d0b8f8ec6b7c4f0a52b004bbf94063cda40af5
      https://github.com/bluez/bluez/commit/24d0b8f8ec6b7c4f0a52b004bbf94063cda40af5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable KVM paravirtualization & clock support in tester kernel config

Enable KVM guest and PTP options in tester kernel config.

This allows synchronizing tester VM guest with host clock, needed for
testers that want to compare timestamps outside the VM guest.


  Commit: f106db3fc469d7a7e12997b0ec588b3090c21a03
      https://github.com/bluez/bluez/commit/f106db3fc469d7a7e12997b0ec588b3090c21a03
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 79314e1cd2bb69b5cb9178754bec2136e6bd3f8c
      https://github.com/bluez/bluez/commit/79314e1cd2bb69b5cb9178754bec2136e6bd3f8c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    A test/functional/__init__.py
    A test/functional/conftest.py
    A test/functional/requirements.txt
    A test/functional/test_bluetoothctl_vm.py
    A test/functional/test_btmgmt_vm.py
    A test/pytest.ini
    A test/test-functional
    A test/test-functional-attach

  Log Message:
  -----------
  test: add functional/integration testing framework

Add framework for writing tests simulating "real" environments where
BlueZ and other parts of the stack run on different virtual machine
hosts that communicate with each other.

Add some smoke tests for bluetoothctl and btmgmt.

The implementation for the VM setup is maintained separately in the
pytest-bluezenv plugin, https://pypi.org/project/pytest-bluezenv

Implements:

- RPC communication with tester instances running each of the VM hosts,
  so that tests can be written on the parent host which coordinates the
  execution.

- Extensible way to add stateful test-specific code inside the VM
  instances

- Logging control: output from different processes running inside the VM
  are separated and can be filtered.

- Test runner framework with Pytest, factored into a pytest plugin

- Grouping tests to minimize VM reboots

- Redirecting USB controllers to use for testing

There is no requirement that the tests spawn VM instances.


  Commit: c0146e6abc9005ce88f23c625aac786a83c51d8c
      https://github.com/bluez/bluez/commit/c0146e6abc9005ce88f23c625aac786a83c51d8c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

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


  Commit: e4b50e8d1946995bb2d9ff46a7d4183b19e08c78
      https://github.com/bluez/bluez/commit/e4b50e8d1946995bb2d9ff46a7d4183b19e08c78
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: ba02713d7ebd2af3419b22fc0b0b49b503ceb7fe
      https://github.com/bluez/bluez/commit/ba02713d7ebd2af3419b22fc0b0b49b503ceb7fe
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    A test/functional/test_agent.py

  Log Message:
  -----------
  test: functional: add some Agent1 interface tests

Add test

test/functional/test_agent.py::test_agent_pair_bredr


  Commit: d2d05811090238ea21fe52e00942c57d6b7546de
      https://github.com/bluez/bluez/commit/d2d05811090238ea21fe52e00942c57d6b7546de
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    A test/functional/test_obex.py

  Log Message:
  -----------
  test: functional: add basic obex file transfer tests

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list


Compare: https://github.com/bluez/bluez/compare/57ef69b78821%5E...d2d058110902

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
