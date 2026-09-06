Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44525265621
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713409; cv=pass; b=TImkXAw8BaNDBvGHs1N2VOSdRau3F2ZZPSG3OFfgDkPRSzTsL6o8VeiP8S94b9WNnA/SJGG4L62zixqZz6cwEmuabwlQksxRoEjdkvwTUlvPxZ4Ako2bN1TP71VMJE+pyX7fvDVkN3gwgHvQ+BFVLplihW8q+AmbgMwGljSFGRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713409; c=relaxed/simple;
	bh=RgaPDXIuhpn5JtIGpXZRmaDHf2hazYTRd/L5tuHArHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mo5oeCsME1P5SBYQN5PSdhu0tehPhyh6oX3XvrSUoqPNc3zMWVnXvLGWzJ+M9RFxikrt8Sgm0JMXjP3iL/D442koEIPQ58fJAfMwwCBD5j2qIYGkspn4jRkI3qtTnt51MNshMCmjAyuOAMCDlB7/CWds0DarWj329Yr/0ZY+duw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DD3zPbwn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DD3zPbwn"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGQV6FT2zyPr;
	Sun, 06 Sep 2026 19:49:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hVqLUES6kmu514yEuhaH5geZ4eNx0rMEcfYUq2vKwUk=;
	b=DD3zPbwnV/ju8eeUhmquf2E6luA+Ji/mI3FbQyQaM4K4ZveloNlLu7go2PZuamErxUEWwr
	tql2irWqdEYeCPxWgyWH35Rpjxuum0l6pv1E2SvvR3PGnZoDAylECG1BQ33+0EY0QhfQk4
	05CpA+QUUvdA+ziklv8wZuSP3CtIkR8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713395;
	b=gyjuYdaCA8Xu64+BbXw15tOe6RpzcW9iBlTUiafLZ26e2rW1Ea0j3wpnXptbH1oj9Ax3ih
	BTu+OVSnsStKiufSD30fWF7NAb1iAY8zoL0U010oCmaCpseSxOPuiEJbTeglc8Q2GAh1Ie
	q3Edhx1w6VvLMWe6vDyWK/yCEFJjt+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hVqLUES6kmu514yEuhaH5geZ4eNx0rMEcfYUq2vKwUk=;
	b=QBdR9WvhpUp0lFJ5dDQLyQ586idNBjrSyE1X3GBdHDjtnizhZTM8tkVg2FnI8lKzyrLMZZ
	9Ztn42WYT5eRu8V/dnTeY5T3QjS4Xe/n+krHXNGQ5YbuYSpyEx00sW41jFjx2mefrxVXxb
	Y5NbdiX1aAwxg+seH2SkOHuQLFz1Cow=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 0/9] Functional/integration testing
Date: Sun,  6 Sep 2026 19:49:42 +0300
Message-ID: <cover.1788712996.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add framework for writing tests simulating "real" environments where
BlueZ and other parts of the stack run on different virtual machine
hosts that communicate with each other.

*** v7 ***

* Bump to pytest-bluezenv==0.1.9 (better core dump / oops reporting)

* Add test/functional/test_adv_monitor.py (one crash POC test)

* Add test/functional/test_avrcp.py (one crash POC test)

  Note that current bluez master branch does not pass this one,
  it is fixed by
  https://patchwork.kernel.org/project/bluetooth/patch/20260901175315.1348621-1-luiz.dentz@gmail.com/

* Add test/functional/test_kernel_testers.py (runs tools/*-tester)

* Bump VMs to 400M memory, ASAN builds on Ubuntu need it

* Make tests fail on core dump / kernel bug

*** v6 ***

* Fix minor issues in documentation and shellcheck warnings.

* Bump to latest pytest-bluezenv==0.1.6

* NOTE: hci_uart is partly broken in current bluetooth-next / 7.1 kernel,
  which causes some of the tests here fail sporadically. Needs the following patch:

  https://lore.kernel.org/linux-bluetooth/6888691461070a011d31632e6dcbfd73016dcc6e.1781364475.git.pav@iki.fi/

*** v5 ***

https://github.com/pv/bluez/compare/func-test-v4-r..func-test-v5

* Factor out the pytest-bluezenv plugin, to be maintained separately.
  https://pypi.org/project/pytest-bluezenv/

  It could in principle be moved under the BlueZ organization, but
  there's no particular reason why it should be in bluez repository.

  Generally, it's better to have the pytest plugin separate so it's
  easier to reuse and can have its own version cycle.

* Pipewire tests are moved to pipewire repository where they probably
  belong to.

  They can be run easily vs. given BlueZ build dir.

  We are currently running them in Pipewire CI, but at frozen
  kernel/BlueZ version, so it is not testing BlueZ/kernel upstream
  development.

* No changes in the emulator/test-runner patches since v4

  They are stand-alone bug fixes / improvements, and make sense
  also separately from the rest.

*** v4 ***

https://github.com/pv/bluez/compare/func-test-v3-r..func-test-v4

* Use virtconsole for simpler HCI forwarding to the vm

* Fix typoed vm_module -> vm_once

* Skip tests for some pipewire versions

*** v3 ***

https://github.com/pv/bluez/compare/func-test-v2-r..func-test-v3

* fix configure.ac openpty() detection to match TOOLS conditional,
  to fix make distcheck

* properly retry virtio RPC connection if it fails initially

* properly restart VM if previous test hangs

* allow custom parent host side proxy objects, use them for pexpect

* improve --list with out-of-tree test files

* fix missing bus.set_exit_on_disconnect(False) for obex tests

* have --vm-timeout etc. change values also on VM host side

* use larger-memory VM instances for Pipewire, in case ASAN enabled

* set reasonable inside-VM ASAN_OPTION default values

* don't run btvirt under stdbuf, since not compatible with ASAN

*** v2 ***

https://github.com/pv/bluez/compare/func-test-v1-r..func-test-v2

* move unit/func_test -> test/functional & test/pytest_bluez

  The pytest_bluez plugin is in principle reusable for other projects,
  so we can eg. have more complete Pipewire integration tests that can
  live in Pipewire repository.

* openpty() is in -lutil on some platforms, detect this in autoconf

* more emulator adjustments:

  - fix SCO data packet support in btvirt
  - more complete Reset command

* improve logging: get timestamps from kernel, and reorder logs
  to timestamp order, so that lines from different hosts, btmon,
  and parent tester appear in right order regardless of whether
  VM console / btmon is lagging

  - this requires accurate clock sync in the VM, so enable KVM PTP in
    config and run chronyd inside the VMs
  - use virtio port instead of qemu console to export logs, since the
    console has fixed baud rate and is too slow

* add --btmon & export btsnoop dumps from VM hosts

* fix compatibility with older Python versions

* add parametrized_host_config()

* split Pipewire test to A2DP/BAP/HFP and really stream audio.
  These catch the 5.86 regression fixed in 066a164a524e498 and
  the 5.84 one in 6b0a08776a

* add support for tests that reuse tester environment, so they can run
  faster without needing Bluetoothd teardown/setup in between

* add HostPlugin.presetup (mainly for test skipping)

* deal with RPC virtio port buffer possibly containing unflushed
  commands from previous failed test

* add some Agent1 interface tests

* add basic Obex file transfer tests

* add support for logging in to a running test instance (for gdb etc)

* export any core dumps out from test environ

Some bells & whistles:

* add --kernel-build for kernel image build

* test suite Python code formatting checks

***

Implements:

- RPC communication with tester instances running each of the VM hosts.
  Tests run on parent host, which instructs VM hosts what to do.

- Extensible way to add stateful test-specific code inside the VM
  instances

- Logging control: output from different processes running inside the VM
  are separated and can be filtered.

- Test runner framework with Pytest (more convenient than Python/unittest)

- Automatic grouping of tests to minimize VM reboots

- Redirecting USB controllers to use for testing in addition to btvirt

- Fairly straightforward, ~1600 sloc for the framework

There is no requirement that the tests spawn VM instances, the test
runner can be used for any tests written in Python.

See doc/test-functional.rst for various examples.

Also test/functional/test_bluetoothctl_vm.py has some simple cases, and
test/functional/test_pipewire.py for a more complicated setup

    host0(qemu): Pipewire <-> BlueZ <-> kernel
    <-> btvirt
    host1(qemu): kernel <-> BlueZ <-> Pipewire

The framework allows easily passing any data and code between the parent
and VM hosts, so writing tests is straightforward.

Pauli Virtanen (9):
  doc: add functional/integration testing documentation
  test: add functional/integration testing framework
  build: add functional testing target
  test: functional: impose Python code formatting
  test: functional: add some Agent1 interface tests
  test: functional: add basic obex file transfer tests
  test: functional: add tests running the various kernel testers
  test: functional: add test for adv_monitor crash
  test: functional: add test for AVRCP crash

 Makefile.am                            |  10 +
 configure.ac                           |  22 ++
 doc/test-functional.rst                | 331 +++++++++++++++++++++++++
 test/functional/__init__.py            |   2 +
 test/functional/conftest.py            |  76 ++++++
 test/functional/requirements.txt       |   3 +
 test/functional/test_adv_monitor.py    | 123 +++++++++
 test/functional/test_agent.py          |  47 ++++
 test/functional/test_avrcp.py          | 281 +++++++++++++++++++++
 test/functional/test_bluetoothctl.py   | 161 ++++++++++++
 test/functional/test_btmgmt.py         |  34 +++
 test/functional/test_kernel_testers.py | 178 +++++++++++++
 test/functional/test_obex.py           | 275 ++++++++++++++++++++
 test/functional/test_tests.py          |  24 ++
 test/pytest.ini                        |  25 ++
 test/test-functional                   |  21 ++
 test/test-functional-attach            |   7 +
 17 files changed, 1620 insertions(+)
 create mode 100644 doc/test-functional.rst
 create mode 100644 test/functional/__init__.py
 create mode 100644 test/functional/conftest.py
 create mode 100644 test/functional/requirements.txt
 create mode 100644 test/functional/test_adv_monitor.py
 create mode 100644 test/functional/test_agent.py
 create mode 100644 test/functional/test_avrcp.py
 create mode 100644 test/functional/test_bluetoothctl.py
 create mode 100644 test/functional/test_btmgmt.py
 create mode 100644 test/functional/test_kernel_testers.py
 create mode 100644 test/functional/test_obex.py
 create mode 100644 test/functional/test_tests.py
 create mode 100644 test/pytest.ini
 create mode 100755 test/test-functional
 create mode 100755 test/test-functional-attach

-- 
2.55.0

