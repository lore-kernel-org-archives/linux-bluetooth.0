Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262F436366
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283103; cv=pass; b=GGZKSWPhAvLtGUXsS3MtqXVPOgXKAzL31r3tHOV7w625BZlbl1AaGpnfYYaBkelFbKBT+RzefHmop+/2ApuvQaP+x4aeDlCJlmPe8ny+u9NXF0UHC1DnZ17AOEEbgEynbRTrKXgCvpuUs0PUG1VA5M/qA+ea5j0Mf1P/w3YoGzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283103; c=relaxed/simple;
	bh=WliTB+EUByVWqj8RwuqrKRI/NftdWKOGGt9+gR2FloM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lochOwynsT1U3Nsc9ohweAkwFVRFB3igb0lMaqqIlrIvzrFCe030U7MxD4fg6vhZbudhR6mNckT0ZPaQHtInochjsbUu2YYQuJi1ZiJTTrdwVcUNlNE3nG2hZ2VgR5pnttMNzx4Fc7OKzDvKGzHyxtrHPUYiuXFr3ZgT6sNuM6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mAKQnxNq; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ChhCOTA4; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mAKQnxNq";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ChhCOTA4"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fNQ7523XPz49PvN
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 14:51:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772283089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zRG3T/rA5CH51RgALXKEZeLhzgl+jAx2kJMmRiSPajs=;
	b=mAKQnxNqSK8wkI6mnQYk35w6bBJJmp4+H/rT2XieDzAevPrDqqOiDKzfF9bpdug9Rz5cWf
	rUuJ/mxxAdv1JskASv1rRmDC9sgFDFpiBoyDjWyNa/WB0j87N3HsVMZyz3QkBjMfWr7Xwa
	2gQDULL9rJnKWGqXFMTzbUuxSykMDftBHAwm2ZomMElJY1ssPA1FiW7hQeRiTUdyNCkFjY
	jiehsll43868+prHvHOZ4MBgYaFraobcNC2WtU/bmH2Ewk5JPY7CTiOPYFzOF23PRPJoYg
	bhY83NKVWjzx92ZWj+ju5LW4a0OzXND6moxiaRzBAvgLF1MyKy/EnxteDqXKSQ==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ6w64PSzyQL;
	Sat, 28 Feb 2026 14:51:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zRG3T/rA5CH51RgALXKEZeLhzgl+jAx2kJMmRiSPajs=;
	b=ChhCOTA4rULxnKPepRfP4QoG9IFXp8OeGtx4VSfEAwnG1uA6nf8zaXisqF2kXDIyB8Sw7H
	JyQuBt9yZx4mGyk8pHwtVDRcoXGV46s47ywYnjE1KlLnVKaRc8N5WKu8k3Eg4TMljYmT78
	U4couNnW9FhpkfVp4P3B2jwcM4cIgG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zRG3T/rA5CH51RgALXKEZeLhzgl+jAx2kJMmRiSPajs=;
	b=kmuOOosbtWnQFSjd0kM9O8BfQdwOz7NjZby2BM6Ub6hHKk/MA1ktxyPzkhVAZ58jIQScqd
	XNkEomMK6YNDs4ptDcwqs1WjLkJdGf4qtqcT9Cq0FvBQ2bPMv/MH9FcTDrhb2RY1YY3H4c
	lqW7l5CSAVKnSq8n77MtT5ym0LdexjU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283081;
	b=JWvMIeMjHBhQx2Vrawgy/4A1IjmwovrU5Twid3aWNW57omeiWIu3O1x45zWBCU4UVOjtNf
	bvO+ohgXAQTpYIQ8M2R+W/loXhaprB97+VviLNCNhcOYgN2BEneJkUNlxkB3SXx9PLiSpR
	1It6kaBqwVZ8EmlY1mwnlDzbw0OiYNo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 00/11] Functional/integration testing
Date: Sat, 28 Feb 2026 14:51:06 +0200
Message-ID: <cover.1772282574.git.pav@iki.fi>
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

Also unit/func_test/test_bluetoothctl_vm.py has some simple cases, and
unit/func_test/test_pipewire.py for a more complicated setup

    host0(qemu): Pipewire <-> BlueZ <-> kernel
    <-> btvirt
    host1(qemu): kernel <-> BlueZ <-> Pipewire

The framework allows easily passing any data and code between the parent
and VM hosts, so writing tests is straightforward.

***

Some examples:

$ unit/test-functional --list -q

unit/func_test/lib/tests/test_rpc.py::test_basic
unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2]
unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hosts1-vm1]
unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
unit/func_test/test_pipewire.py::test_pipewire[hosts3-vm2]

$ unit/test-functional -v --no-header
======================================= test session starts ========================================
collected 5 items

unit/func_test/lib/tests/test_rpc.py::test_basic PASSED                                      [ 20%]
unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hosts1-vm1] SKIPPED    [ 40%]
unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1] SKIPPED (No kernel image)     [ 60%]
unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2] SKIPPED (No k...) [ 80%]
unit/func_test/test_pipewire.py::test_pipewire[hosts3-vm2] SKIPPED (No kernel image)         [100%]

=================================== 1 passed, 4 skipped in 0.19s ===================================

$ unit/test-functional --kernel=../linux
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items

unit/func_test/lib/tests/test_rpc.py .                                   [ 20%]
unit/func_test/test_bluetoothctl_vm.py .                                 [ 40%]
unit/func_test/test_btmgmt_vm.py .                                       [ 60%]
unit/func_test/test_bluetoothctl_vm.py .                                 [ 80%]
unit/func_test/test_pipewire.py .                                        [100%]

============================== 5 passed in 41.92s ==============================

$ unit/test-functional --kernel=../linux -k test_btmgmt
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

unit/func_test/test_btmgmt_vm.py .                                       [100%]

======================= 1 passed, 4 deselected in 9.15s ========================

$ grep btmgmt test-functional.log
13:15:42 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__call__', <function run at 0x7f27b81ce140>, ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
13:15:42 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__call__', <function run at 0x7fd5e35a1010>, ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
13:15:42 INFO   host.0.0.run        :      $ /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info

$ unit/test-functional --kernel=../linux -k test_btmgmt --log-cli-level=0
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
-------------------------------- live log setup --------------------------------
13:00:31 INFO   func_test.lib.env   :  Starting btvirt: /usr/bin/stdbuf -o L -e L /home/pauli/prj/external/bluez/build/emulator/btvirt --server=/tmp/bluez-func-test-8t6ychy8
13:00:31 OUT    btvirt              :  Bluetooth emulator ver 5.86
13:00:31 INFO   func_test.lib.env   :  Starting host: /home/pauli/prj/external/bluez/build/tools/test-runner --kernel=../linux/arch/x86/boot/bzImage -u/tmp/bluez-func-test-8t6ychy8/bt-server-bredrle -o -chardev -o socket,id=ser0,path=/tmp/bluez-func-test-8t6ychy8/bluez-func-test-rpc-0,server=on,wait=off -o -device -o virtio-serial -o -device -o virtserialport,chardev=ser0,name=bluez-func-test-rpc -H -- /usr/bin/python3 -P /home/pauli/prj/external/bluez/unit/func_test/lib/runner.py /dev/ttyS2
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

$ unit/test-functional --kernel=../linux -k test_bluetoothctl_pair --log-cli-level=0 --log-filter=*.bluetoothctl,rpc.* --force-usb
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2]
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

$ COLUMNS=80 unit/test-functional -k test_btmgmt --kernel=../linux --trace
============================= test session starts ==============================
platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
rootdir: /home/pauli/prj/external/bluez/unit
configfile: pytest.ini
plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
collected 5 items / 4 deselected / 1 selected

unit/func_test/test_btmgmt_vm.py
>>>>>>>>>>>>>>>>>>>> PDB runcall (IO-capturing turned off) >>>>>>>>>>>>>>>>>>>>>
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(19)test_btmgmt_info()
-> (host,) = hosts
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(21)test_btmgmt_info()
-> result = host.call(
(Pdb) p host.bdaddr
'00:aa:01:00:00:42'
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(22)test_btmgmt_info()
-> run,
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(23)test_btmgmt_info()
-> [btmgmt, "--index", "0", "info"],
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(24)test_btmgmt_info()
-> stdout=subprocess.PIPE,
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(25)test_btmgmt_info()
-> stdin=subprocess.DEVNULL,
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(26)test_btmgmt_info()
-> encoding="utf-8",
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(21)test_btmgmt_info()
-> result = host.call(
(Pdb) n
> /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(28)test_btmgmt_info()
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

Pauli Virtanen (11):
  emulator: btvirt: check pkt lengths, don't get stuck on malformed
  emulator: btvirt: allow specifying where server unix sockets are made
  test-runner: enable path argument for --unix
  test-runner: Add -o/--option option
  test-runner: allow source tree root for -k
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config
  test-runner: use virtio-serial for implementing -u device forwarding
  doc: add functional/integration testing documentation
  unit: add functional/integration testing framework
  unit: func_test: add Pipewire-using smoke tests
  build: add functional testing target

 Makefile.am                            |   7 +
 configure.ac                           |  17 +
 doc/ci.config                          |   1 +
 doc/test-functional.rst                | 374 +++++++++++++++++++
 doc/test-runner.rst                    |   1 +
 doc/tester.config                      |   1 +
 emulator/main.c                        |  37 +-
 emulator/server.c                      |   9 +
 tools/test-runner.c                    | 376 ++++++++++++++-----
 unit/func_test/__init__.py             |   0
 unit/func_test/conftest.py             | 277 ++++++++++++++
 unit/func_test/lib/__init__.py         |   5 +
 unit/func_test/lib/env.py              | 484 +++++++++++++++++++++++++
 unit/func_test/lib/host_plugins.py     | 269 ++++++++++++++
 unit/func_test/lib/rpc.py              | 293 +++++++++++++++
 unit/func_test/lib/runner.py           |  10 +
 unit/func_test/lib/tests/__init__.py   |   0
 unit/func_test/lib/tests/test_rpc.py   |  49 +++
 unit/func_test/lib/utils.py            | 266 ++++++++++++++
 unit/func_test/requirements.txt        |   3 +
 unit/func_test/test_bluetoothctl_vm.py |  76 ++++
 unit/func_test/test_btmgmt_vm.py       |  29 ++
 unit/func_test/test_pipewire.py        | 137 +++++++
 unit/pytest.ini                        |   7 +
 unit/test-functional                   |   8 +
 25 files changed, 2631 insertions(+), 105 deletions(-)
 create mode 100644 doc/test-functional.rst
 create mode 100644 unit/func_test/__init__.py
 create mode 100644 unit/func_test/conftest.py
 create mode 100644 unit/func_test/lib/__init__.py
 create mode 100644 unit/func_test/lib/env.py
 create mode 100644 unit/func_test/lib/host_plugins.py
 create mode 100644 unit/func_test/lib/rpc.py
 create mode 100644 unit/func_test/lib/runner.py
 create mode 100644 unit/func_test/lib/tests/__init__.py
 create mode 100644 unit/func_test/lib/tests/test_rpc.py
 create mode 100644 unit/func_test/lib/utils.py
 create mode 100644 unit/func_test/requirements.txt
 create mode 100644 unit/func_test/test_bluetoothctl_vm.py
 create mode 100644 unit/func_test/test_btmgmt_vm.py
 create mode 100644 unit/func_test/test_pipewire.py
 create mode 100644 unit/pytest.ini
 create mode 100755 unit/test-functional

-- 
2.53.0

