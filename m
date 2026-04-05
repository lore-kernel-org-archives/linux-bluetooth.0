Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426E3451A6
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392817; cv=pass; b=tWKz0t47ObqXh25ErhABGaqSXadk4NA6QipEgJO+qamX3g1EOFUeOH43qm5XSNllqU0FV8BML8y0LIql2s37cQaGpfHFB47Cih5MFeCBYJ+Scmf/QgC9FUtmBX5xNpsOVdFMhutvAOF/Z3qLUteaz4NipdgIRcqXdxEAAX9IKqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392817; c=relaxed/simple;
	bh=gLoh64e7Fj0bndiZgFMROCuMpbBjM7S6+as/YrEbLYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdERGOCeN3TtOo39pzUQxAudbelFoEH8gJUXEXQEciJvJkoWBDERxnfeYRYFD96am15Lm8sgky0w0JnA8EKHFtmuA8V11DelRoyHKxMYbzx0x6P0hECg1B5zUOETAkzWn6AQwW3EDypUH2SDEDW9u7/ukYqj9ZYM4cb6DOKEjj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=j4XxezmO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="j4XxezmO"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9J0mMwzySb;
	Sun, 05 Apr 2026 15:40:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uukQYzMYHQDzTYqXQ8bxOTD5IcKlqgZs9K1vEN0mvUw=;
	b=j4XxezmO0xlLxHK+rtREbCRbo48JUgEX3xToULu5fRSHcwX5Rdncf+DR0Y8KdZDmuGsyMp
	z2S/+KX2Csv/LYcZT1qDy0R0g0xBwxAj/plhK0d0q9etaVe/lZNBOTcfcp6OCEBxSCOxfF
	unNtmVS9WccGkKgCn0eHtqqcGvO+KxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uukQYzMYHQDzTYqXQ8bxOTD5IcKlqgZs9K1vEN0mvUw=;
	b=t7pGrRzDxh5Qz6OVvrhXIXMZT5oqzRlRg2FsFrP6unaxFsJbuH+GObGkqWgDSfXKaSMQ0j
	E+VcwOQzi1mUhy2wxuvrCnB6UfArFfZNlu4TwE6Agk3Awnv/uZeSASWD4NFnRjWNmigGph
	/WjSaTUNISyFAIQUoV34o350mXuDIHc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392806;
	b=C/DQVoiSOrYm5ab+m2ESqkHhknzDUBInjYZ/4uGboZm3hRkbfaKSLqBB2tfOTjXNFt6StG
	GG/wssbLHnUhqpUbNi67cGN45imiZiVp+R2Gpt/OSFCvZPeOTtQB8ge9LUavI4VDZdZ8rd
	eY4YK3iT0DNnj2ss9JrkSgLwVNKrkL4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 00/20] Functional/integration testing
Date: Sun,  5 Apr 2026 15:39:41 +0300
Message-ID: <cover.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
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

***

Some examples:

$ test/test-functional --list -q

test/functional/lib/tests/test_rpc.py::test_basic
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hosts1-vm1]
test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
test/functional/test_pipewire.py::test_pipewire[hosts3-vm2]

$ test/test-functional -v --no-header
======================================= test session starts ========================================
collected 5 items

test/functional/lib/tests/test_rpc.py::test_basic PASSED                                      [ 20%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hosts1-vm1] SKIPPED    [ 40%]
test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1] SKIPPED (No kernel image)     [ 60%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2] SKIPPED (No k...) [ 80%]
test/functional/test_pipewire.py::test_pipewire[hosts3-vm2] SKIPPED (No kernel image)         [100%]

=================================== 1 passed, 4 skipped in 0.19s ===================================

$ test/test-functional --kernel=../linux
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items

test/functional/lib/tests/test_rpc.py .                                   [ 20%]
test/functional/test_bluetoothctl_vm.py .                                 [ 40%]
test/functional/test_btmgmt_vm.py .                                       [ 60%]
test/functional/test_bluetoothctl_vm.py .                                 [ 80%]
test/functional/test_pipewire.py .                                        [100%]

============================== 5 passed in 41.92s ==============================

$ test/test-functional --kernel=../linux -k test_btmgmt
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

test/functional/test_btmgmt_vm.py .                                       [100%]

======================= 1 passed, 4 deselected in 9.15s ========================

$ grep btmgmt test-functional.log
13:15:42 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__call__', <function run at 0x7f27b81ce140>, ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
13:15:42 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__call__', <function run at 0x7fd5e35a1010>, ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
13:15:42 INFO   host.0.0.run        :      $ /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info

$ test/test-functional --kernel=../linux -k test_btmgmt --log-cli-level=0
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
-------------------------------- live log setup --------------------------------
13:00:31 INFO   func_test.lib.env   :  Starting btvirt: /usr/bin/stdbuf -o L -e L /home/pauli/prj/external/bluez/build/emulator/btvirt --server=/tmp/bluez-func-test-8t6ychy8
13:00:31 OUT    btvirt              :  Bluetooth emulator ver 5.86
13:00:31 INFO   func_test.lib.env   :  Starting host: /home/pauli/prj/external/bluez/build/tools/test-runner --kernel=../linux/arch/x86/boot/bzImage -u/tmp/bluez-func-test-8t6ychy8/bt-server-bredrle -o -chardev -o socket,id=ser0,path=/tmp/bluez-func-test-8t6ychy8/bluez-func-test-rpc-0,server=on,wait=off -o -device -o virtio-serial -o -device -o virtserialport,chardev=ser0,name=bluez-func-test-rpc -H -- /usr/bin/python3 -P /home/pauli/prj/external/bluez/test/functional/lib/runner.py /dev/ttyS2
13:00:31 OUT    btvirt              :  Request for /tmp/bluez-func-test-8t6ychy8/bt-server-bredrle
13:00:32 OUT    host.0.0            :  early console in extract_kernel
13:00:32 OUT    host.0.0            :  input_data: 0x000000000425c2c4
...
13:00:39 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__call__', <function run at 0x7f7547472140>, ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
13:00:39 DEBUG  host.0.0.rpc        :  server: done
13:00:39 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__call__', <function run at 0x7f77dcc81010>, ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
13:00:39 INFO   host.0.0.run        :      $ /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info
13:00:40 OUT    host.0.0.run.out    :  hci0:	Primary controller
13:00:40 OUT    host.0.0.run.out    :  	addr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x000000
13:00:40 OUT    host.0.0.run.out    :  	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy static-addr phy-configuration cis-central cis-peripheral iso-broadcaster sync-receiver ll-privacy past-sender past-receiver
13:00:40 OUT    host.0.0.run.out    :  	current settings: br/edr
13:00:40 OUT    host.0.0.run.out    :  	name
13:00:40 OUT    host.0.0.run.out    :  	short name
13:00:40 INFO   host.0.0.run        :  (return code 0)
13:00:40 DEBUG  rpc.host.0.0        :  client-reply
PASSED                                                                   [100%]
13:00:40 OUT    host.0.0            :  qemu-system-x86_64: terminating on signal 15 from pid 149047 (python3)
======================= 1 passed, 4 deselected in 8.84s ========================

$ test/test-functional --kernel=../linux -k test_bluetoothctl_pair --log-cli-level=0 --log-filter=*.bluetoothctl,rpc.* --force-usb
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2]
-------------------------------- live log setup --------------------------------
13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib.host_plugins.Bdaddr object at 0x7f268712d160>,) {}
13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib.host_plugins.Call object at 0x7f268712d2b0>,) {}
13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib.host_plugins.DbusSystem object at 0x7f2687aa30e0>,) {}
13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib.host_plugins.Bluetoothd object at 0x7f2687aa3230>,) {}
13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib.host_plugins.Bluetoothctl object at 0x7f268712d010>,) {}
13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib.host_plugins.Bdaddr object at 0x7f26871542d0>,) {}
13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib.host_plugins.Call object at 0x7f2687154410>,) {}
13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib.host_plugins.DbusSystem object at 0x7f2687aa30e0>,) {}
13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib.host_plugins.Bluetoothd object at 0x7f2687aa3230>,) {}
13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib.host_plugins.Bluetoothctl object at 0x7f2687154190>,) {}
13:03:20 INFO   rpc.host.0.0        :  client: wait_load () {}
13:03:21 DEBUG  rpc.host.0.0        :  client-reply
13:03:21 INFO   rpc.host.0.1        :  client: wait_load () {}
13:03:21 DEBUG  rpc.host.0.1        :  client-reply
-------------------------------- live log call ---------------------------------
13:03:21 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl', 'send', 'show\n') {}
13:03:21 DEBUG  rpc.host.0.0        :  client-reply
13:03:21 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl', 'expect', 'Powered: yes') {}
...
13:03:23 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl', 'send', 'pair 70:1a:b8:73:99:bb\n') {}
13:03:23 OUT    host.0.0.bluetoothctl:  pair 70:1a:b8:73:99:bb
13:03:23 DEBUG  rpc.host.0.0        :  client-reply
13:03:23 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl', 'expect', 'Confirm passkey (\\d+).*:') {}
13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> pair 70:1a:b8:73:99:bb
13:03:23 OUT    host.0.0.bluetoothctl:  Attempting to pair with 70:1A:B8:73:99:BB
13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 device_flags_changed: 70:1A:B8:73:99:BB (BR/EDR)
13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]>      supp: 0x00000007  curr: 0x00000000
13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 type 7 discovering off
13:03:25 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 70:1A:B8:73:99:BB type BR/EDR connected eir_len 12
13:03:25 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> [BlueZ 5.86]> [CHG] Device 70:1A:B8:73:99:BB Connected: yes
13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> Request confirmation
13:03:25 DEBUG  rpc.host.0.0        :  client-reply
13:03:25 INFO   rpc.host.0.1        :  client: call_plugin ('bluetoothctl', 'expect', 'Confirm passkey 237345') {}
13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> hci0 84:5C:F3:77:31:19 type BR/EDR connected eir_len 12
13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> [NEW] Device 84:5C:F3:77:31:19 BlueZ 5.86
13:03:25 DEBUG  rpc.host.0.1        :  client-reply
13:03:25 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl', 'send', 'yes\n') {}
13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> [BlueZ 5.86]> Request confirmation
13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [agent] Confirm passkey 237345 (yes/no): yes
13:03:25 DEBUG  rpc.host.0.0        :  client-reply
13:03:25 INFO   rpc.host.0.1        :  client: call_plugin ('bluetoothctl', 'send', 'yes\n') {}
13:03:25 OUT    host.0.1.bluetoothctl:  [BlueZ 5.86]> [agent] Confirm passkey 237345 (yes/no): yes
13:03:25 DEBUG  rpc.host.0.1        :  client-reply
13:03:25 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl', 'expect', 'Pairing successful') {}
13:03:25 OUT    host.0.0.bluetoothctl:  yes
13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> hci0 new_link_key 70:1A:B8:73:99:BB type 0x08 pin_len 0 store_hint 1
13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:B8:73:99:BB Bonded: yes
13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:B8:73:99:BB AddressType: public
13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:B8:73:99:BB UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:B8:73:99:BB UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
13:03:26 DEBUG  rpc.host.0.0        :  client-reply
PASSED                                                                   [100%]
------------------------------ live log teardown -------------------------------
13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:B8:98:FF:qemu-system-x86_64: terminating on signal 15 from pid 149357 (python3)

======================= 1 passed, 4 deselected in 13.22s =======================

$ test/test-functional -k test_btmgmt --kernel=../linux --trace
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

test/functional/test_btmgmt_vm.py
>>>>>>>>>>>>>>>>>>>> PDB runcall (IO-capturing turned off) >>>>>>>>>>>>>>>>>>>>>
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(19)test_btmgmt_info()
-> (host,) = hosts
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(21)test_btmgmt_info()
-> result = host.call(
(Pdb) p host.bdaddr
'00:aa:01:00:00:42'
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(22)test_btmgmt_info()
-> run,
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(23)test_btmgmt_info()
-> [btmgmt, "--index", "0", "info"],
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(24)test_btmgmt_info()
-> stdout=subprocess.PIPE,
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(25)test_btmgmt_info()
-> stdin=subprocess.DEVNULL,
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(26)test_btmgmt_info()
-> encoding="utf-8",
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(21)test_btmgmt_info()
-> result = host.call(
(Pdb) n
> /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(28)test_btmgmt_info()
-> assert result.returncode == 0
(Pdb) p result
CompletedProcess(args=['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info'], returncode=0, stdout='hci0:\tPrimary controller\n\taddr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x000000\n\tsupported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy static-addr phy-configuration cis-central cis-peripheral iso-broadcaster sync-receiver ll-privacy past-sender past-receiver \n\tcurrent settings: br/edr \n\tname \n\tshort name \n')
(Pdb) print(result.stdout)
hci0:	Primary controller
	addr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x000000
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy static-addr phy-configuration cis-central cis-peripheral iso-broadcaster sync-receiver ll-privacy past-sender past-receiver
	current settings: br/edr
	name
	short name
(Pdb) q

!!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Quitting debugger !!!!!!!!!!!!!!!!!!!
======================= 4 deselected in 75.91s (0:01:15) =======================

***

Pauli Virtanen (20):
  emulator: btvirt: check pkt lengths, don't get stuck on malformed
  emulator: btvirt: allow specifying where server unix sockets are made
  emulator: btvirt: support SCO data packets
  emulator: btdev: clear more state on Reset
  test-runner: enable path argument for --unix
  test-runner: Add -o/--option option
  test-runner: allow source tree root for -k
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config
  test-runner: use virtio-serial for implementing -u device forwarding
  doc: enable KVM paravirtualization & clock support in tester kernel
    config
  doc: add functional/integration testing documentation
  test: add functional/integration testing framework
  test: functional: add Pipewire-using audio streaming tests
  test: functional: add --btmon option to start btmon
  build: add functional testing target
  test: functional: impose Python code formatting
  test: functional: add option for building kernel image first
  test: functional: add custom Agent1 implementation for testing
  test: functional: warn on kernel warning/bug messages
  test: functional: add basic obex file transfer tests

 Makefile.am                             |   9 +
 configure.ac                            |  22 +
 doc/ci.config                           |   9 +
 doc/test-functional.rst                 | 949 ++++++++++++++++++++++++
 doc/test-runner.rst                     |  17 +
 doc/tester.config                       |   9 +
 emulator/btdev.c                        | 117 +--
 emulator/main.c                         |  37 +-
 emulator/server.c                       |  21 +
 test/functional/__init__.py             |   2 +
 test/functional/requirements.txt        |   4 +
 test/functional/test_agent.py           |  46 ++
 test/functional/test_bluetoothctl_vm.py | 152 ++++
 test/functional/test_btmgmt_vm.py       |  30 +
 test/functional/test_obex.py            | 285 +++++++
 test/functional/test_pipewire.py        | 554 ++++++++++++++
 test/functional/test_tests.py           |  23 +
 test/pytest.ini                         |  18 +
 test/pytest_bluez/__init__.py           |  12 +
 test/pytest_bluez/agent.py              | 371 +++++++++
 test/pytest_bluez/btmon.py              | 116 +++
 test/pytest_bluez/build_kernel.py       |  43 ++
 test/pytest_bluez/env.py                | 803 ++++++++++++++++++++
 test/pytest_bluez/host_plugins.py       | 627 ++++++++++++++++
 test/pytest_bluez/plugin.py             | 637 ++++++++++++++++
 test/pytest_bluez/rpc.py                | 385 ++++++++++
 test/pytest_bluez/runner.py             |  20 +
 test/pytest_bluez/tests/__init__.py     |   2 +
 test/pytest_bluez/tests/test_rpc.py     |  62 ++
 test/pytest_bluez/tests/test_utils.py   |  16 +
 test/pytest_bluez/utils.py              | 710 ++++++++++++++++++
 test/test-functional                    |   7 +
 test/test-functional-attach             |  52 ++
 tools/test-runner.c                     |  89 ++-
 34 files changed, 6170 insertions(+), 86 deletions(-)
 create mode 100644 doc/test-functional.rst
 create mode 100644 test/functional/__init__.py
 create mode 100644 test/functional/requirements.txt
 create mode 100644 test/functional/test_agent.py
 create mode 100644 test/functional/test_bluetoothctl_vm.py
 create mode 100644 test/functional/test_btmgmt_vm.py
 create mode 100644 test/functional/test_obex.py
 create mode 100644 test/functional/test_pipewire.py
 create mode 100644 test/functional/test_tests.py
 create mode 100644 test/pytest.ini
 create mode 100644 test/pytest_bluez/__init__.py
 create mode 100644 test/pytest_bluez/agent.py
 create mode 100644 test/pytest_bluez/btmon.py
 create mode 100644 test/pytest_bluez/build_kernel.py
 create mode 100644 test/pytest_bluez/env.py
 create mode 100644 test/pytest_bluez/host_plugins.py
 create mode 100644 test/pytest_bluez/plugin.py
 create mode 100644 test/pytest_bluez/rpc.py
 create mode 100644 test/pytest_bluez/runner.py
 create mode 100644 test/pytest_bluez/tests/__init__.py
 create mode 100644 test/pytest_bluez/tests/test_rpc.py
 create mode 100644 test/pytest_bluez/tests/test_utils.py
 create mode 100644 test/pytest_bluez/utils.py
 create mode 100755 test/test-functional
 create mode 100755 test/test-functional-attach

-- 
2.53.0

