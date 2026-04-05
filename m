Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DA23E32B
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775396273; cv=none; b=ZkIdfn8YEXk32Xmcuvo0t0ykCQjOpHbirixIUxkk4RAyvg+N7ly5PIypWB6yHDYaZvsk1i9FxbiDmXbICULeiOaC3OPlypIS/K8KoDCPbkhDWZmBhdOZFwKkpeCUkVPcclDLtGYPr/Wjetw+wFvZEy69sFHVuPvSicQ4d55oVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775396273; c=relaxed/simple;
	bh=q025ERarCZBaCkY0L4uYKGpnYwDRF6va+ESX+9lHrEQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hNaVtEvf1fFA9mMG335nF0Qg+/m7LV03zWH4lHegDl7CNyntC6cDj2+Snl6dLqEzLU+KD00Tr36DIkFmdm7TJezlWEbIDOeoRKkUQGVzK/zr/mpM1r9F+Zhn3IrSni5MB0cdEaIHDDL+aLa77i7Np2A00ecN1VATnQiRNrHP/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jCbuu1R7; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jCbuu1R7"
Received: from github.com (hubbernetes-node-043e610.ac4-iad.github.net [10.52.13.60])
	by smtp.github.com (Postfix) with ESMTPA id 6F097700CAC
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775396271;
	bh=qx5+w30GWyJQvowJb8/IYFp/GbT8T5in1fYClHEwmSw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jCbuu1R73vNJdv+elj/+KA9NSZvrZ76Wq+VDLuOegBJLi5eDPZQKJqJkBAZiqSTGJ
	 69xO0f/GzfXjt5F1XWbVIJGeuifHuS6gU0MJyvdwMixVKfGMFmiRbkRmV3rPdYNMGW
	 KWR2OSHz4jqGt6UBCGxlyUqMegfYnu222SpgWL5k=
Date: Sun, 05 Apr 2026 06:37:51 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077422/000000-9a7446@github.com>
Subject: [bluez/bluez] 31d2b6: emulator: btvirt: check pkt lengths, don't get
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

  Branch: refs/heads/1077422
  Home:   https://github.com/bluez/bluez
  Commit: 31d2b60f6456e2fbad407ae6630aa196fe9fcbe6
      https://github.com/bluez/bluez/commit/31d2b60f6456e2fbad407ae6630aa196fe9fcbe6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: check pkt lengths, don't get stuck on malformed

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.


  Commit: 94ea75c544b1e3ba176b1a408274abe826e058e5
      https://github.com/bluez/bluez/commit/94ea75c544b1e3ba176b1a408274abe826e058e5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M emulator/main.c

  Log Message:
  -----------
  emulator: btvirt: allow specifying where server unix sockets are made

Make --server to take optional path name where to create the various
server sockets.


  Commit: c16cc13cc4ad4d61b09ecd8f215d1dee8096a1e5
      https://github.com/bluez/bluez/commit/c16cc13cc4ad4d61b09ecd8f215d1dee8096a1e5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: support SCO data packets

Support also SCO data packets in btvirt.


  Commit: b123f742cdc6a4e692fcaf32ce71e1cae2adcf6d
      https://github.com/bluez/bluez/commit/b123f742cdc6a4e692fcaf32ce71e1cae2adcf6d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: ab46826be681be50f5176e96b978f8434c2bbd2c
      https://github.com/bluez/bluez/commit/ab46826be681be50f5176e96b978f8434c2bbd2c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable path argument for --unix

Allow specifying the path for the controller socket to be used.


  Commit: ca0f20a60d2d9872363cea218bfa9bbaed1146d0
      https://github.com/bluez/bluez/commit/ca0f20a60d2d9872363cea218bfa9bbaed1146d0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -o/--option option

Allow passing arbitrary arguments to QEMU.


  Commit: c7e5ddf890c639b5d8a0db4b67b789aa869281d4
      https://github.com/bluez/bluez/commit/c7e5ddf890c639b5d8a0db4b67b789aa869281d4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: allow source tree root for -k

Allow passing source tree root for -k option, look up kernel below it.


  Commit: 10e406f945efafb0bb3f17b22d03dbbc65e3754b
      https://github.com/bluez/bluez/commit/10e406f945efafb0bb3f17b22d03dbbc65e3754b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.


  Commit: 129d3482f8bf3f598b8614ddd2bc09cd830f42e1
      https://github.com/bluez/bluez/commit/129d3482f8bf3f598b8614ddd2bc09cd830f42e1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: 89f1a846295f8908a2bf086e63ce8ffe73217a63
      https://github.com/bluez/bluez/commit/89f1a846295f8908a2bf086e63ce8ffe73217a63
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: 1dad213f0b8d16fe20f3b595c949a53ce73b3fea
      https://github.com/bluez/bluez/commit/1dad213f0b8d16fe20f3b595c949a53ce73b3fea
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 59aef27bd01b8827384fcadd8f1e8e4e2272d079
      https://github.com/bluez/bluez/commit/59aef27bd01b8827384fcadd8f1e8e4e2272d079
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: 4f0b558635628ca6662da60429fd750653a26cc2
      https://github.com/bluez/bluez/commit/4f0b558635628ca6662da60429fd750653a26cc2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: 67579c12d81b455f53adb5313aed35c0aaacc513
      https://github.com/bluez/bluez/commit/67579c12d81b455f53adb5313aed35c0aaacc513
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: d11831eea875563767ac7b90f2d70d894c61a938
      https://github.com/bluez/bluez/commit/d11831eea875563767ac7b90f2d70d894c61a938
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: d5f4a2be72ed0645a2ce95fcbe7411196bbe9e61
      https://github.com/bluez/bluez/commit/d5f4a2be72ed0645a2ce95fcbe7411196bbe9e61
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M doc/test-functional.rst
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: dafbf1b8536f0cfc10ff84a76bc5d8fcc0a67545
      https://github.com/bluez/bluez/commit/dafbf1b8536f0cfc10ff84a76bc5d8fcc0a67545
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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

The point in this is to make running tests simpler for contributors, so
that they don't need to read instructions what options the kernel should
be built with just for running these tests.


  Commit: 7669690a0c522c5c7bb9be9e502c2092505fcf34
      https://github.com/bluez/bluez/commit/7669690a0c522c5c7bb9be9e502c2092505fcf34
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

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


  Commit: 43611c89a4c33f58167704d1c6a9edae59f65d70
      https://github.com/bluez/bluez/commit/43611c89a4c33f58167704d1c6a9edae59f65d70
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    M test/pytest_bluez/env.py

  Log Message:
  -----------
  test: functional: warn on kernel warning/bug messages

Emit warnings if there is a WARNING/BUG message from kernel.


  Commit: 9a7446499754caca432255a3c2516ca2e319a9c6
      https://github.com/bluez/bluez/commit/9a7446499754caca432255a3c2516ca2e319a9c6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-05 (Sun, 05 Apr 2026)

  Changed paths:
    A test/functional/test_obex.py
    M test/pytest_bluez/host_plugins.py

  Log Message:
  -----------
  test: functional: add basic obex file transfer tests

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list


Compare: https://github.com/bluez/bluez/compare/31d2b60f6456%5E...9a7446499754

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
