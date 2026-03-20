Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99867371D1D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042300; cv=none; b=SGao+NiNDhxWhL46LVFhx0hqVkC9cFsVRtpMYYpCVPinpaMGqel3XGwuY9nQsEAs/blRRUt3OBW+qMqPkmxHb4u6DJYtCxJFhkxYCe9Co0n3hZQQEvyA+1rwTKowmlPyIplUwatvbNHI6ygE/CSoRMcSQ2+vr5IuQNflTnyyi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042300; c=relaxed/simple;
	bh=LmjKq3gKMCvyQ3p7ifAGm6FjKcAothujq9xlk5lvLe0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UiXKxeoeVZfkQhFt5Ew4mSaa87qq4KL5mCC29eoLUSPAoHOenheaXSXHE1MioUM7qFjLAc5gmiXvLgIp+KAMGu2KnnZHIaeCPysrHNVHV8FgznNAoI+EFyP/wE/JmcW3LNQGILnMCgvlAY19ZO1GIWKPCy+7oS+iwK/ov/dUvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=none smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J0myTQ9E; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J0myTQ9E"
Received: from github.com (hubbernetes-node-ac03292.ash1-iad.github.net [10.56.200.76])
	by smtp.github.com (Postfix) with ESMTPA id C13BF2E11F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774042296;
	bh=oDPcIp5WOfp9P4CRgD6Xo2n4OrXP5Xbo+RxS15LRHKc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J0myTQ9ESYJQF0/KepFx09gxeyAEa5lK6qeR8+Z83zKs6GJ6ZbteeVIi6tEMzIfQq
	 hVXcFk9nhz3eQLNYuvjae0zciC/uoaWRh0SpvhHLn/waFr6uqRMGsKXCC+qslip6Dt
	 tF816FnyRUaTRESnU7E8t5lFdk/ZatxVZlKVBkJg=
Date: Fri, 20 Mar 2026 14:31:36 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1070106/000000-e9e0d0@github.com>
Subject: [bluez/bluez] cab77c: emulator: btvirt: check pkt lengths, don't get
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

  Branch: refs/heads/1070106
  Home:   https://github.com/bluez/bluez
  Commit: cab77c96790b54fe29148207fa572ed54070d95b
      https://github.com/bluez/bluez/commit/cab77c96790b54fe29148207fa572ed54070d95b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: check pkt lengths, don't get stuck on malformed

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.


  Commit: c17542792f75d8c82b348dbb31b7b085071d6f9a
      https://github.com/bluez/bluez/commit/c17542792f75d8c82b348dbb31b7b085071d6f9a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M emulator/main.c

  Log Message:
  -----------
  emulator: btvirt: allow specifying where server unix sockets are made

Make --server to take optional path name where to create the various
server sockets.


  Commit: d51acda928781c9eb1e9950b32957d1d4911aff1
      https://github.com/bluez/bluez/commit/d51acda928781c9eb1e9950b32957d1d4911aff1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: support SCO data packets

Support also SCO data packets in btvirt.


  Commit: 3fa888728bf9862af8dccf14db21f2191c107752
      https://github.com/bluez/bluez/commit/3fa888728bf9862af8dccf14db21f2191c107752
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: 100b77c3da7a01ac86c62f3aa9913f0870ee0f9e
      https://github.com/bluez/bluez/commit/100b77c3da7a01ac86c62f3aa9913f0870ee0f9e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable path argument for --unix

Allow specifying the path for the controller socket to be used.


  Commit: f52e4dbfa35b9a6a2663966cb376d2beda717a09
      https://github.com/bluez/bluez/commit/f52e4dbfa35b9a6a2663966cb376d2beda717a09
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -o/--option option

Allow passing arbitrary arguments to QEMU.


  Commit: e23f319b65cc12957b74c6a900f871ae03a82207
      https://github.com/bluez/bluez/commit/e23f319b65cc12957b74c6a900f871ae03a82207
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: allow source tree root for -k

Allow passing source tree root for -k option, look up kernel below it.


  Commit: 04b7e47f41b21b1e8bfe47a8af38290f59720598
      https://github.com/bluez/bluez/commit/04b7e47f41b21b1e8bfe47a8af38290f59720598
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.


  Commit: 379b2c8842062dabb1b56889067efe208e36d544
      https://github.com/bluez/bluez/commit/379b2c8842062dabb1b56889067efe208e36d544
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: f5cb225dc2cfe45e9a107bbdb616429348243b57
      https://github.com/bluez/bluez/commit/f5cb225dc2cfe45e9a107bbdb616429348243b57
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: dd4baa332293f0b1265d1f84e86b28e508eabfa8
      https://github.com/bluez/bluez/commit/dd4baa332293f0b1265d1f84e86b28e508eabfa8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 34f356ce91efd3046944a31e6ed3c0bd39d966d2
      https://github.com/bluez/bluez/commit/34f356ce91efd3046944a31e6ed3c0bd39d966d2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: 4327c438f03dcf986c21ca6abdf5e67a28846eac
      https://github.com/bluez/bluez/commit/4327c438f03dcf986c21ca6abdf5e67a28846eac
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: c4beee5121af16a3204a78745465d0cb6a0392b5
      https://github.com/bluez/bluez/commit/c4beee5121af16a3204a78745465d0cb6a0392b5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: 07667bac0f13e5a04e7fe60f5eb7cdf83628789d
      https://github.com/bluez/bluez/commit/07667bac0f13e5a04e7fe60f5eb7cdf83628789d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: 81be006c93a9bd660718e059eef25729c0b2c7dc
      https://github.com/bluez/bluez/commit/81be006c93a9bd660718e059eef25729c0b2c7dc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M doc/test-functional.rst
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: 7bc9883e78e1c3b2efd97e192a3a5977438d976e
      https://github.com/bluez/bluez/commit/7bc9883e78e1c3b2efd97e192a3a5977438d976e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: 0e54374f133fc1196fa3db98c34ec172a84f0a5e
      https://github.com/bluez/bluez/commit/0e54374f133fc1196fa3db98c34ec172a84f0a5e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


  Commit: 6c9274e74ef2e7ca80829907d2b93e28f2583255
      https://github.com/bluez/bluez/commit/6c9274e74ef2e7ca80829907d2b93e28f2583255
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M test/pytest_bluez/env.py

  Log Message:
  -----------
  test: functional: warn on kernel warning/bug messages

Emit warnings if there is a WARNING/BUG message from kernel.


  Commit: e9e0d0152bd9753d3cbcd1072fc5983c2358f1ca
      https://github.com/bluez/bluez/commit/e9e0d0152bd9753d3cbcd1072fc5983c2358f1ca
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

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


Compare: https://github.com/bluez/bluez/compare/cab77c96790b%5E...e9e0d0152bd9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
