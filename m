Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246DFC0A
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365742; cv=pass; b=evwMlyk00OVJi2rSxNpl/xn/IZTm8Iqix87fkUHzvCEcKe4TXRTZ0RNHCZr7fMG3doVGQGHLhAK0sMSYCPKSzZltjqJit12581PAFFZJ+d3wh0lyEKgbAXHjjG7gQjo/IPXXNkicwi4rpsmD3jxNdsYtbC6eq04Ej+lVXj+I1n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365742; c=relaxed/simple;
	bh=WRD/C2UDvB+uXG1mn3ySBzDafSd1CWoP1i4QFzuOpfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8DrPPv6PH3lR99jye9JC/Ej2QJ+YWWe8I98DtkzK6Y5wgGb+ORDDqCCBMjCE9RDgIqjZBY5ONjJGfo9x9r/fVCoTlC5stPO2BagBQKUuLBV7U6o3ZXQ2A2uTdD9/Vpm/58udzh7W1BIFBcSigbDPNBGuzS1fjMknkppOWQ4X2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ms7MLQnT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ms7MLQnT"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd15P6tKHzyWH;
	Sat, 13 Jun 2026 18:48:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781365738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AmR/Zlg+NyMYp98UNsVLiCVNBSNMnsTkuO9tz8JY/DM=;
	b=Ms7MLQnTZRhfuXDXSptPlssqGSMEOKZZgRQRpjnw5LQtgSpSCnpZnH2NS39eOAD2+5Of/H
	CUySyT3aKz5nM67JGB/D5/0XYvg4ywwNlSpHCqzJ2nvkoAJQjh96YXP4PmW+U6iv9wCBkl
	ao0fTQHJRtgXL55O9mK5x0dCycNEH9M=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781365738;
	b=aGBruO6HZqh6sS1+yd8F4j4qdZzkwoagW9ovjAu8+oncRwVsaOc3ljaHVbDRSvZP6UTPJk
	g96r4xQdMogYLu6NiBnPb0mMgx21kTUv0cOPNcauto/PpX8TVA+WeGoOKVo5qbyzsoAAKr
	906ZQF4gP7+0BWusygH2mx0pTKdS+GA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781365738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AmR/Zlg+NyMYp98UNsVLiCVNBSNMnsTkuO9tz8JY/DM=;
	b=eYpXi3I9M6y4gJdpXx6wd4HFDGpwIUrW8nFHW9UaUFs1USTAYT6qGlStn4ERDCmQryw8c9
	1oL5ZxP3SkiJ+mM9/RcGh51T5BwIgIqJ1KCNQCu4VJGr28BIhwfn6+mQWRYZDcPXtksHDR
	/dtyxc10B0Y++D0LYwKS0SBIVb5iVPg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 0/6] Functional/integration testing
Date: Sat, 13 Jun 2026 18:48:46 +0300
Message-ID: <cover.1781365708.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
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

***

Some examples:

$ test/test-functional --list

test/functional/lib/tests/test_rpc.py::test_basic
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hosts1-vm1]
test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
test/functional/test_pipewire.py::test_pipewire[hosts3-vm2]

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

Pauli Virtanen (6):
  doc: add functional/integration testing documentation
  test: add functional/integration testing framework
  build: add functional testing target
  test: functional: impose Python code formatting
  test: functional: add some Agent1 interface tests
  test: functional: add basic obex file transfer tests

 Makefile.am                             |  10 +
 configure.ac                            |  22 ++
 doc/test-functional.rst                 | 313 ++++++++++++++++++++++++
 test/functional/__init__.py             |   2 +
 test/functional/conftest.py             |  48 ++++
 test/functional/requirements.txt        |   2 +
 test/functional/test_agent.py           |  46 ++++
 test/functional/test_bluetoothctl_vm.py | 152 ++++++++++++
 test/functional/test_btmgmt_vm.py       |  30 +++
 test/functional/test_obex.py            | 285 +++++++++++++++++++++
 test/functional/test_tests.py           |  23 ++
 test/pytest.ini                         |  17 ++
 test/test-functional                    |  21 ++
 test/test-functional-attach             |   7 +
 14 files changed, 978 insertions(+)
 create mode 100644 doc/test-functional.rst
 create mode 100644 test/functional/__init__.py
 create mode 100644 test/functional/conftest.py
 create mode 100644 test/functional/requirements.txt
 create mode 100644 test/functional/test_agent.py
 create mode 100644 test/functional/test_bluetoothctl_vm.py
 create mode 100644 test/functional/test_btmgmt_vm.py
 create mode 100644 test/functional/test_obex.py
 create mode 100644 test/functional/test_tests.py
 create mode 100644 test/pytest.ini
 create mode 100755 test/test-functional
 create mode 100755 test/test-functional-attach

-- 
2.54.0

