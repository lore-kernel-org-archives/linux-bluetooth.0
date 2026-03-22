Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEA184
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216289; cv=none; b=UgF+SZDEn5N6wKAI8ryiWmcFMizIpVUdbVIBLp2xabQkODOdyVQGRBPzaq49ISBURcVJfrxF+yFawvlGwA/EetVShjvz5gp7aCMaZC83IfP/1Mhf0FSCkYCoHJENfhQo90jiRdIWgLRvmKuxeCyeGG6h384vBnOW1HJwIV/e7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216289; c=relaxed/simple;
	bh=nmjYnu7Yrjy6jeQp99ZRhAjtOIE8n/BVlPAvSAmQW74=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fs63tupqmLmvChpk0GosmICdAdNRLxQrJFjuxDcYFQaQTRLjAxiNjOAYwHYrwnXk963S+h6i7PXBH375oT3O8fA5V9b8nhDdney4zXIAlDhAYJlgppPzIBHZexVeYvCJG3ws9m68G14FtyflPhdd2UGuywWhVltnf9mzUZyj3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=none smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DcXA4Mly; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DcXA4Mly"
Received: from github.com (hubbernetes-node-9d30b9c.va3-iad.github.net [10.51.95.34])
	by smtp.github.com (Postfix) with ESMTPA id 249659000B8
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774216287;
	bh=/uYx3zGHkeInBTzPeFQPX/dwcZTP02qclYk9G2WQIEc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DcXA4MlycqRBhNhab5LQEuv99IsHulWGv3kEsEhgI/rKuYNj5jLf8fzn3EqYAmf5G
	 hdAH+ph6R37fOzCdoCGPKpDEDEYRVX5XbTBhArYjJVd524cwM3uvN6sRiykmECEJkZ
	 Vel2cHT6praOe7nLc0hiHnAW3MLflbp3Qe0hSjfM=
Date: Sun, 22 Mar 2026 14:51:27 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1070560/000000-4774c2@github.com>
Subject: [bluez/bluez] 2ffd8b: emulator: btvirt: check pkt lengths, don't get
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

  Branch: refs/heads/1070560
  Home:   https://github.com/bluez/bluez
  Commit: 2ffd8b5782f1baac9189aac986975b9a4204ada9
      https://github.com/bluez/bluez/commit/2ffd8b5782f1baac9189aac986975b9a4204ada9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: check pkt lengths, don't get stuck on malformed

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.


  Commit: 19e12f0672c5f54e6b73d2877f1e9280db187187
      https://github.com/bluez/bluez/commit/19e12f0672c5f54e6b73d2877f1e9280db187187
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M emulator/main.c

  Log Message:
  -----------
  emulator: btvirt: allow specifying where server unix sockets are made

Make --server to take optional path name where to create the various
server sockets.


  Commit: 27668aa72674573750113acda7f70897ade5a150
      https://github.com/bluez/bluez/commit/27668aa72674573750113acda7f70897ade5a150
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: support SCO data packets

Support also SCO data packets in btvirt.


  Commit: 3cffeff1e62f5d054ce0fc0f6d8d803ddbff2d8d
      https://github.com/bluez/bluez/commit/3cffeff1e62f5d054ce0fc0f6d8d803ddbff2d8d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

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


  Commit: e85c42fd262558ef6d41ffd912b9c3c56642d924
      https://github.com/bluez/bluez/commit/e85c42fd262558ef6d41ffd912b9c3c56642d924
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable path argument for --unix

Allow specifying the path for the controller socket to be used.


  Commit: 84265e4520714e7464761fc3d6609e24dc45dc45
      https://github.com/bluez/bluez/commit/84265e4520714e7464761fc3d6609e24dc45dc45
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -o/--option option

Allow passing arbitrary arguments to QEMU.


  Commit: 62b9ad22e79b65d5c821877e1a01cf3007b5eaf9
      https://github.com/bluez/bluez/commit/62b9ad22e79b65d5c821877e1a01cf3007b5eaf9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: allow source tree root for -k

Allow passing source tree root for -k option, look up kernel below it.


  Commit: 10a824db6ed3d205a84b860c7913795dcfc69265
      https://github.com/bluez/bluez/commit/10a824db6ed3d205a84b860c7913795dcfc69265
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.


  Commit: 1e316413ab5f978d77bef386c113f0c81a91a1c7
      https://github.com/bluez/bluez/commit/1e316413ab5f978d77bef386c113f0c81a91a1c7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M Makefile.tools
    M configure.ac
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


  Commit: 08579ede8eb97217567f0b766774354b662e5c89
      https://github.com/bluez/bluez/commit/08579ede8eb97217567f0b766774354b662e5c89
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

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


  Commit: 152388184e5c5786177e1388f962f2bcdc5ae352
      https://github.com/bluez/bluez/commit/152388184e5c5786177e1388f962f2bcdc5ae352
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 8e36daa8bb99f2f79914d14484e7443b7c5a3924
      https://github.com/bluez/bluez/commit/8e36daa8bb99f2f79914d14484e7443b7c5a3924
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M doc/test-functional.rst
    A test/functional/__init__.py
    A test/functional/requirements.txt
    A test/functional/test_bluetoothctl_vm.py
    A test/functional/test_btmgmt_vm.py
    A test/pytest.ini
    A test/pytest_bluez/__init__.py
    A test/pytest_bluez/env.py
    A test/pytest_bluez/host_plugins.py
    A test/pytest_bluez/plugin.py
    A test/pytest_bluez/rpc.py
    A test/pytest_bluez/runner.py
    A test/pytest_bluez/tests/__init__.py
    A test/pytest_bluez/tests/test_rpc.py
    A test/pytest_bluez/tests/test_utils.py
    A test/pytest_bluez/utils.py
    A test/test-functional
    A test/test-functional-attach

  Log Message:
  -----------
  test: add functional/integration testing framework

Add framework for writing tests simulating "real" environments where
BlueZ and other parts of the stack run on different virtual machine
hosts that communicate with each other.

Implementation is factored into test/pytest_bluez/ support plugin that's
in principle reusable for other projects, and test/functional/ actual
test files.

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

There is no requirement that the tests spawn VM instances. The test
runner finds any tests in test/**/test_*.py


  Commit: 17cdfac4c4bbc6a80aa18a87dd67aba08a1b446e
      https://github.com/bluez/bluez/commit/17cdfac4c4bbc6a80aa18a87dd67aba08a1b446e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    A test/functional/test_pipewire.py
    M test/pytest.ini

  Log Message:
  -----------
  test: functional: add Pipewire-using audio streaming tests

Add tests for Pipewire hosts connecting A2DP, BAP, and HFP to each other
and stream audio:

test/functional/test_pipewire.py::test_pipewire_a2dp
test/functional/test_pipewire.py::test_pipewire_bap_bcast
test/functional/test_pipewire.py::test_pipewire_bap_ucast
test/functional/test_pipewire.py::test_pipewire_hfp

The A2DP test would have catched the regression fixed by 066a164a524 and
the BAP test that fixed by 6b0a08776a.


  Commit: 073ce8ba77355266a3e876d3412ba809a628f89a
      https://github.com/bluez/bluez/commit/073ce8ba77355266a3e876d3412ba809a628f89a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M doc/test-functional.rst
    M test/pytest_bluez/__init__.py
    A test/pytest_bluez/btmon.py
    M test/pytest_bluez/plugin.py

  Log Message:
  -----------
  test: functional: add --btmon option to start btmon

After test finishes, any btmon dumps created are copied to current
working directory.


  Commit: d7a0148977a5de6181e5b3c8f4f55e7b6c0e9962
      https://github.com/bluez/bluez/commit/d7a0148977a5de6181e5b3c8f4f55e7b6c0e9962
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

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


  Commit: c2f62809633722b71e32a50ca318f1fdb162b680
      https://github.com/bluez/bluez/commit/c2f62809633722b71e32a50ca318f1fdb162b680
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M doc/test-functional.rst
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: 39b41b097a373599c9cebb8f2885dc4001b6bb6c
      https://github.com/bluez/bluez/commit/39b41b097a373599c9cebb8f2885dc4001b6bb6c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M doc/test-functional.rst
    M test/pytest.ini
    A test/pytest_bluez/build_kernel.py
    M test/pytest_bluez/plugin.py

  Log Message:
  -----------
  test: functional: add option for building kernel image first

Add convenience option test/test-functional --kernel-build to build a
kernel image first.


  Commit: 3450e875f32b2fd07901523322a15cba390e902f
      https://github.com/bluez/bluez/commit/3450e875f32b2fd07901523322a15cba390e902f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M doc/test-functional.rst
    A test/functional/test_agent.py
    M test/pytest_bluez/__init__.py
    A test/pytest_bluez/agent.py

  Log Message:
  -----------
  test: functional: add custom Agent1 implementation for testing

Enable more precise testing of the Agent1 interface, and allow doing
operations like pairing without bluetoothctl.


  Commit: 3f56b7e5be50d5f620215f5630645689ca7016b4
      https://github.com/bluez/bluez/commit/3f56b7e5be50d5f620215f5630645689ca7016b4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    M test/pytest_bluez/env.py

  Log Message:
  -----------
  test: functional: warn on kernel warning/bug messages

Emit warnings if there is a WARNING/BUG message from kernel.


  Commit: 4774c23c19e158769fe963fef9c5df3b597bf2c3
      https://github.com/bluez/bluez/commit/4774c23c19e158769fe963fef9c5df3b597bf2c3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-22 (Sun, 22 Mar 2026)

  Changed paths:
    A test/functional/test_obex.py
    M test/pytest_bluez/host_plugins.py

  Log Message:
  -----------
  test: functional: add basic obex file transfer tests

Add tests

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list


Compare: https://github.com/bluez/bluez/compare/2ffd8b5782f1%5E...4774c23c19e1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
