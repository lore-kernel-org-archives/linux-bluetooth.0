Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE793D3339
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875857; cv=none; b=X4IliHlr8sVBkVdMzz+rIzNEpQT4AM9mh9wHvHc0fZjzwzrEvFcAzpZqUwb3aOTcbTcbljIWjOPUXRdOlPnRybjL1brehvQf3xTozENaNsJ8wuK9yvdkipCJgMePZwm++WeVQOU17qf0pGe86+lBqKdlm02lqUtVe1vEPL5wH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875857; c=relaxed/simple;
	bh=npWmrjSHaipGS6xDPAaHIF1ahS+6sxKNqm+oZv2Ey5E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNmZevS4n+ZeCDp4LpmbBtHzjEkqS7kDZMWpsOS7UHr0opD5FLJMhVCAzVA3XZ6mTZKWaRq/9l6fQUL02+9OZPrwtM1mZXjEn7eRxLIr/N5+o7u0imQTiJe/dbeByqSID11eti7cBK9yQ21MyA5BVVcr2ritVQQ1UBAKzGG8LIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFB563EC0B;
	Mon, 30 Mar 2026 13:04:06 +0000 (UTC)
Message-ID: <4f72230890ca17c2ebc306b681725eb6426be63e.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3 00/20] Functional/integration testing
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Mon, 30 Mar 2026 15:04:06 +0200
In-Reply-To: <C64768DD-F94A-4F4D-8ADB-515DA3E78298@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
	 <f10c6fd68d78b7b21f36a628eb0cb8f89f14ecea.camel@hadess.net>
	 <C64768DD-F94A-4F4D-8ADB-515DA3E78298@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGsTJ4a6sni5WRWlrVFFQDjV65ov5hK/XCAUFqQCGkPGnfsCv16gSk7FoJ5DtN3Wb96+vsYkuT3agwJrS62ToE8LEiD9gx5mAOGdl6D0dIrhwF7P5bulNE0n09O5r8puuNRPkDWPJjbWxd5b4orZ+4/eYtpipWK5ZdnLGSUylk/zwtjQHJIFjRnI6eKeeEWs217uF53/BxwU4hX8VLBGHnho25R5P/BHjPgfrK3anIz/dOc/lK/YptQ/OmXaqLl/KmG+itnwq41houBntn/DrBwpBCcid8HfylIvRFbEOvGwz4nMbIDyVHGoeRXUQkVd9J4l1Qx5xHLBUgJkSrt3oy4pi03HWaKP58BI1VqpNCIXjFsL2Gxdl7BoPeeUeGWaDTh5Qb/kbVmTqsztSSEfyaDyKjApN4MBEAXEbzV2rVTJFUjycZWoyU5lUHQSnh5SwRPLz71T2d6QGR71/j01yVKO6/67O7hhdFWgW8uxfceHOecMSiG4rlBUY2hv3UPv9Fy2fO8sqmZxcJGlyUmyo9WZgnCs1dr1FREHBjV9C/+1wxoNcgUm9VXagUxlGbybGGzBORtQeuAOphv8eWzyiZWhEee6NtZB7q9O1Zp259dyWc9hKDv4iQ/EtZHEiJ82a6NY/CaNHZcSId/dmxSPFnLh+cc86MotpL+TJ328l3nIQ

On Mon, 2026-03-30 at 12:48 +0000, Pauli Virtanen wrote:
> Hi,
>=20
> 30. maaliskuuta 2026 12.30.55 UTC Bastien Nocera <hadess@hadess.net>
> kirjoitti:
> > On Sun, 2026-03-22 at 23:29 +0200, Pauli Virtanen wrote:
> > > Add framework for writing tests simulating "real" environments
> > > where
> > > BlueZ and other parts of the stack run on different virtual
> > > machine
> > > hosts that communicate with each other.
> >=20
> > Not having gone through the changes in a great level of detail, it
> > looks fine to me.
> >=20
> > Is having some documentation that we could integrate into the
> > website
> > something you're planning post merge of this branch?
> >=20
> > Should probably have some explanations on how to deploy it on a
> > bare
> > metal machine, the dependencies for, say, Debian/Ubuntu/Fedora, and
> > maybe considerations for implementing the test suite on CI runners
> > (permissions, etc.).
>=20
> There is some documentation included in the series
>=20
> https://lore.kernel.org/linux-bluetooth/b8a81e4717298c521fa76ad2cc672d80a=
db066b2.1774214693.git.pav@iki.fi/
>=20
> With some setup instructions, but maybe not detailed enough.

Thanks, patch 11/20 never actually got to my mailbox, and I did receive
some warnings about bounces from the mailing-list, I wonder if that's
related :/

This is already very useful documentation, and we can always rework it
down the line as we use it, and folks run into questions.

Thanks

>=20
>=20
> >=20
> > >=20
> > > *** v3 ***
> > >=20
> > > https://github.com/pv/bluez/compare/func-test-v2-r..func-test-v3
> > >=20
> > > * fix configure.ac openpty() detection to match TOOLS
> > > conditional,
> > > =C2=A0 to fix make distcheck
> > >=20
> > > * properly retry virtio RPC connection if it fails initially
> > >=20
> > > * properly restart VM if previous test hangs
> > >=20
> > > * allow custom parent host side proxy objects, use them for
> > > pexpect
> > >=20
> > > * improve --list with out-of-tree test files
> > >=20
> > > * fix missing bus.set_exit_on_disconnect(False) for obex tests
> > >=20
> > > * have --vm-timeout etc. change values also on VM host side
> > >=20
> > > * use larger-memory VM instances for Pipewire, in case ASAN
> > > enabled
> > >=20
> > > * set reasonable inside-VM ASAN_OPTION default values
> > >=20
> > > * don't run btvirt under stdbuf, since not compatible with ASAN
> > >=20
> > > *** v2 ***
> > >=20
> > > https://github.com/pv/bluez/compare/func-test-v1-r..func-test-v2
> > >=20
> > > * move unit/func_test -> test/functional & test/pytest_bluez
> > >=20
> > > =C2=A0 The pytest_bluez plugin is in principle reusable for other
> > > projects,
> > > =C2=A0 so we can eg. have more complete Pipewire integration tests
> > > that
> > > can
> > > =C2=A0 live in Pipewire repository.
> > >=20
> > > * openpty() is in -lutil on some platforms, detect this in
> > > autoconf
> > >=20
> > > * more emulator adjustments:
> > >=20
> > > =C2=A0 - fix SCO data packet support in btvirt
> > > =C2=A0 - more complete Reset command
> > >=20
> > > * improve logging: get timestamps from kernel, and reorder logs
> > > =C2=A0 to timestamp order, so that lines from different hosts, btmon,
> > > =C2=A0 and parent tester appear in right order regardless of whether
> > > =C2=A0 VM console / btmon is lagging
> > >=20
> > > =C2=A0 - this requires accurate clock sync in the VM, so enable KVM
> > > PTP in
> > > =C2=A0=C2=A0=C2=A0 config and run chronyd inside the VMs
> > > =C2=A0 - use virtio port instead of qemu console to export logs, sinc=
e
> > > the
> > > =C2=A0=C2=A0=C2=A0 console has fixed baud rate and is too slow
> > >=20
> > > * add --btmon & export btsnoop dumps from VM hosts
> > >=20
> > > * fix compatibility with older Python versions
> > >=20
> > > * add parametrized_host_config()
> > >=20
> > > * split Pipewire test to A2DP/BAP/HFP and really stream audio.
> > > =C2=A0 These catch the 5.86 regression fixed in 066a164a524e498 and
> > > =C2=A0 the 5.84 one in 6b0a08776a
> > >=20
> > > * add support for tests that reuse tester environment, so they
> > > can
> > > run
> > > =C2=A0 faster without needing Bluetoothd teardown/setup in between
> > >=20
> > > * add HostPlugin.presetup (mainly for test skipping)
> > >=20
> > > * deal with RPC virtio port buffer possibly containing unflushed
> > > =C2=A0 commands from previous failed test
> > >=20
> > > * add some Agent1 interface tests
> > >=20
> > > * add basic Obex file transfer tests
> > >=20
> > > * add support for logging in to a running test instance (for gdb
> > > etc)
> > >=20
> > > * export any core dumps out from test environ
> > >=20
> > > Some bells & whistles:
> > >=20
> > > * add --kernel-build for kernel image build
> > >=20
> > > * test suite Python code formatting checks
> > >=20
> > > ***
> > >=20
> > > Implements:
> > >=20
> > > - RPC communication with tester instances running each of the VM
> > > hosts.
> > > =C2=A0 Tests run on parent host, which instructs VM hosts what to do.
> > >=20
> > > - Extensible way to add stateful test-specific code inside the VM
> > > =C2=A0 instances
> > >=20
> > > - Logging control: output from different processes running inside
> > > the
> > > VM
> > > =C2=A0 are separated and can be filtered.
> > >=20
> > > - Test runner framework with Pytest (more convenient than
> > > Python/unittest)
> > >=20
> > > - Automatic grouping of tests to minimize VM reboots
> > >=20
> > > - Redirecting USB controllers to use for testing in addition to
> > > btvirt
> > >=20
> > > - Fairly straightforward, ~1600 sloc for the framework
> > >=20
> > > There is no requirement that the tests spawn VM instances, the
> > > test
> > > runner can be used for any tests written in Python.
> > >=20
> > > See doc/test-functional.rst for various examples.
> > >=20
> > > Also test/functional/test_bluetoothctl_vm.py has some simple
> > > cases,
> > > and
> > > test/functional/test_pipewire.py for a more complicated setup
> > >=20
> > > =C2=A0=C2=A0=C2=A0 host0(qemu): Pipewire <-> BlueZ <-> kernel
> > > =C2=A0=C2=A0=C2=A0 <-> btvirt
> > > =C2=A0=C2=A0=C2=A0 host1(qemu): kernel <-> BlueZ <-> Pipewire
> > >=20
> > > The framework allows easily passing any data and code between the
> > > parent
> > > and VM hosts, so writing tests is straightforward.
> > >=20
> > > ***
> > >=20
> > > Some examples:
> > >=20
> > > $ test/test-functional --list -q
> > >=20
> > > test/functional/lib/tests/test_rpc.py::test_basic
> > > test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[h
> > > osts
> > > 0-vm2]
> > > test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script
> > > _sho
> > > w[hosts1-vm1]
> > > test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> > > test/functional/test_pipewire.py::test_pipewire[hosts3-vm2]
> > >=20
> > > $ test/test-functional -v --no-header
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test session starts
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > collected 5 items
> > >=20
> > > test/functional/lib/tests/test_rpc.py::test_basic
> > > PASSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [ 20%]
> > > test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script
> > > _sho
> > > w[hosts1-vm1] SKIPPED=C2=A0=C2=A0=C2=A0 [ 40%]
> > > test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> > > SKIPPED (No kernel image)=C2=A0=C2=A0=C2=A0=C2=A0 [ 60%]
> > > test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[h
> > > osts
> > > 0-vm2] SKIPPED (No k...) [ 80%]
> > > test/functional/test_pipewire.py::test_pipewire[hosts3-vm2]
> > > SKIPPED
> > > (No kernel image)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [10=
0%]
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 passed, 4 skipped in 0.19s
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > $ test/test-functional --kernel=3D../linux
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > > rootdir: /home/pauli/prj/external/bluez/unit
> > > configfile: pytest.ini
> > > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-
> > > 2.4.0,
> > > xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > > collected 5 items
> > >=20
> > > test/functional/lib/tests/test_rpc.py
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 20%]
> > > test/functional/test_bluetoothctl_vm.py
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 40%]
> > > test/functional/test_btmgmt_vm.py
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [ 60%]
> > > test/functional/test_bluetoothctl_vm.py
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 80%]
> > > test/functional/test_pipewire.py
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [100%]
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D 5 passed in 41.92s
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > $ test/test-functional --kernel=3D../linux -k test_btmgmt
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > > rootdir: /home/pauli/prj/external/bluez/unit
> > > configfile: pytest.ini
> > > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-
> > > 2.4.0,
> > > xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > > collected 5 items / 4 deselected / 1 selected
> > >=20
> > > test/functional/test_btmgmt_vm.py
> > > .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [100%]
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 1 passed, 4 deselected in 9.15s
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >=20
> > > $ grep btmgmt test-functional.log
> > > 13:15:42 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('call',
> > > '__call__', <function run at 0x7f27b81ce140>,
> > > ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index',
> > > '0',
> > > 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
> > > 13:15:42 INFO=C2=A0=C2=A0 host.0.0.rpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 server: call_plugin
> > > ('call',
> > > '__call__', <function run at 0x7fd5e35a1010>,
> > > ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index',
> > > '0',
> > > 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
> > > 13:15:42 INFO=C2=A0=C2=A0 host.0.0.run=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $
> > > /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info
> > >=20
> > > $ test/test-functional --kernel=3D../linux -k test_btmgmt --log-
> > > cli-
> > > level=3D0
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > > rootdir: /home/pauli/prj/external/bluez/unit
> > > configfile: pytest.ini
> > > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-
> > > 2.4.0,
> > > xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > > collected 5 items / 4 deselected / 1 selected
> > >=20
> > > test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> > > -------------------------------- live log setup -----------------
> > > ----
> > > -----------
> > > 13:00:31 INFO=C2=A0=C2=A0 func_test.lib.env=C2=A0=C2=A0 :=C2=A0 Start=
ing btvirt:
> > > /usr/bin/stdbuf -o L -e L
> > > /home/pauli/prj/external/bluez/build/emulator/btvirt --
> > > server=3D/tmp/bluez-func-test-8t6ychy8
> > > 13:00:31 OUT=C2=A0=C2=A0=C2=A0 btvirt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 Bluetooth emulator=
 ver
> > > 5.86
> > > 13:00:31 INFO=C2=A0=C2=A0 func_test.lib.env=C2=A0=C2=A0 :=C2=A0 Start=
ing host:
> > > /home/pauli/prj/external/bluez/build/tools/test-runner --
> > > kernel=3D../linux/arch/x86/boot/bzImage -u/tmp/bluez-func-test-
> > > 8t6ychy8/bt-server-bredrle -o -chardev -o
> > > socket,id=3Dser0,path=3D/tmp/bluez-func-test-8t6ychy8/bluez-func-
> > > test-
> > > rpc-0,server=3Don,wait=3Doff -o -device -o virtio-serial -o -device -
> > > o
> > > virtserialport,chardev=3Dser0,name=3Dbluez-func-test-rpc -H --
> > > /usr/bin/python3 -P
> > > /home/pauli/prj/external/bluez/test/functional/lib/runner.py
> > > /dev/ttyS2
> > > 13:00:31 OUT=C2=A0=C2=A0=C2=A0 btvirt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 Request for /tmp/b=
luez-
> > > func-
> > > test-8t6ychy8/bt-server-bredrle
> > > 13:00:32 OUT=C2=A0=C2=A0=C2=A0 host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 early console in
> > > extract_kernel
> > > 13:00:32 OUT=C2=A0=C2=A0=C2=A0 host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 input_data:
> > > 0x000000000425c2c4
> > > ...
> > > 13:00:39 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('call',
> > > '__call__', <function run at 0x7f7547472140>,
> > > ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index',
> > > '0',
> > > 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
> > > 13:00:39 DEBUG=C2=A0 host.0.0.rpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 server: done
> > > 13:00:39 INFO=C2=A0=C2=A0 host.0.0.rpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 server: call_plugin
> > > ('call',
> > > '__call__', <function run at 0x7f77dcc81010>,
> > > ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index',
> > > '0',
> > > 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
> > > 13:00:39 INFO=C2=A0=C2=A0 host.0.0.run=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $
> > > /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0.run.out=C2=A0=C2=A0=C2=A0 :=
=C2=A0 hci0:	Primary
> > > controller
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0.run.out=C2=A0=C2=A0=C2=A0 :=
=C2=A0=C2=A0	addr 00:AA:01:00:00:42
> > > version 11 manufacturer 1521 class 0x000000
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0.run.out=C2=A0=C2=A0=C2=A0 :=
=C2=A0=C2=A0	supported settings:
> > > powered
> > > connectable fast-connectable discoverable bondable link-security
> > > ssp
> > > br/edr le advertising secure-conn debug-keys privacy static-addr
> > > phy-
> > > configuration cis-central cis-peripheral iso-broadcaster sync-
> > > receiver ll-privacy past-sender past-receiver
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0.run.out=C2=A0=C2=A0=C2=A0 :=
=C2=A0=C2=A0	current settings: br/edr
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0.run.out=C2=A0=C2=A0=C2=A0 :=
=C2=A0=C2=A0	name
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0.run.out=C2=A0=C2=A0=C2=A0 :=
=C2=A0=C2=A0	short name
> > > 13:00:40 INFO=C2=A0=C2=A0 host.0.0.run=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 (return code 0)
> > > 13:00:40 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > PASSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0 [100%]
> > > 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 qemu-system-x86_64:
> > > terminating on signal 15 from pid 149047 (python3)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 1 passed, 4 deselected in 8.84s
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >=20
> > > $ test/test-functional --kernel=3D../linux -k
> > > test_bluetoothctl_pair --
> > > log-cli-level=3D0 --log-filter=3D*.bluetoothctl,rpc.* --force-usb
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > > rootdir: /home/pauli/prj/external/bluez/unit
> > > configfile: pytest.ini
> > > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-
> > > 2.4.0,
> > > xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > > collected 5 items / 4 deselected / 1 selected
> > >=20
> > > test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[h
> > > osts
> > > 0-vm2]
> > > -------------------------------- live log setup -----------------
> > > ----
> > > -----------
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Bdaddr object at 0x7f268712d160>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Call object at 0x7f268712d2b0>,) {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.DbusSystem object at
> > > 0x7f2687aa30e0>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Bluetoothd object at
> > > 0x7f2687aa3230>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Bluetoothctl object at
> > > 0x7f268712d010>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Bdaddr object at 0x7f26871542d0>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Call object at 0x7f2687154410>,) {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.DbusSystem object at
> > > 0x7f2687aa30e0>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Bluetoothd object at
> > > 0x7f2687aa3230>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: start_load
> > > (<func_test.lib.host_plugins.Bluetoothctl object at
> > > 0x7f2687154190>,)
> > > {}
> > > 13:03:20 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: wait_load () {}
> > > 13:03:21 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:21 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: wait_load () {}
> > > 13:03:21 DEBUG=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > -------------------------------- live log call ------------------
> > > ----
> > > -----------
> > > 13:03:21 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'send', 'show\n') {}
> > > 13:03:21 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:21 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'expect', 'Powered: yes') {}
> > > ...
> > > 13:03:23 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'send', 'pair 70:1a:b8:73:99:bb\n') {}
> > > 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 pair 70:1=
a:b8:73:99:bb
> > > 13:03:23 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:23 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'expect', 'Confirm passkey (\\d+).*:') {}
> > > 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [bluetoot=
hctl]> pair
> > > 70:1a:b8:73:99:bb
> > > 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 Attemptin=
g to pair with
> > > 70:1A:B8:73:99:BB
> > > 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [bluetoot=
hctl]> hci0
> > > device_flags_changed: 70:1A:B8:73:99:BB (BR/EDR)
> > > 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [bluetoot=
hctl]>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > supp:
> > > 0x00000007=C2=A0 curr: 0x00000000
> > > 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [bluetoot=
hctl]> hci0 type
> > > 7
> > > discovering off
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [bluetoot=
hctl]> hci0
> > > 70:1A:B8:73:99:BB type BR/EDR connected eir_len 12
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [bluetoot=
hctl]> [BlueZ
> > > 5.86]>
> > > [CHG] Device 70:1A:B8:73:99:BB Connected: yes
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> Request
> > > confirmation
> > > 13:03:25 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:25 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'expect', 'Confirm passkey 237345') {}
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.1.bluetoothctl:=C2=A0 [bluetoot=
hctl]> hci0
> > > 84:5C:F3:77:31:19 type BR/EDR connected eir_len 12
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.1.bluetoothctl:=C2=A0 [bluetoot=
hctl]> [NEW]
> > > Device
> > > 84:5C:F3:77:31:19 BlueZ 5.86
> > > 13:03:25 DEBUG=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:25 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'send', 'yes\n') {}
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.1.bluetoothctl:=C2=A0 [bluetoot=
hctl]> [BlueZ
> > > 5.86]>
> > > Request confirmation
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [agent]
> > > Confirm
> > > passkey 237345 (yes/no): yes
> > > 13:03:25 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:25 INFO=C2=A0=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'send', 'yes\n') {}
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.1.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [agent]
> > > Confirm
> > > passkey 237345 (yes/no): yes
> > > 13:03:25 DEBUG=C2=A0 rpc.host.0.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > 13:03:25 INFO=C2=A0=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client: call_plugin
> > > ('bluetoothctl', 'expect', 'Pairing successful') {}
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 yes
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> hci0
> > > new_link_key 70:1A:B8:73:99:BB type 0x08 pin_len 0 store_hint 1
> > > 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [CHG]
> > > Device
> > > 70:1A:B8:73:99:BB Bonded: yes
> > > 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [CHG]
> > > Device
> > > 70:1A:B8:73:99:BB AddressType: public
> > > 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [CHG]
> > > Device
> > > 70:1A:B8:73:99:BB UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
> > > 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [CHG]
> > > Device
> > > 70:1A:B8:73:99:BB UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
> > > 13:03:26 DEBUG=C2=A0 rpc.host.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 client-reply
> > > PASSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0 [100%]
> > > ------------------------------ live log teardown ----------------
> > > ----
> > > -----------
> > > 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host.0.0.bluetoothctl:=C2=A0 [BlueZ 5.=
86]> [CHG]
> > > Device
> > > 70:1A:B8:98:FF:qemu-system-x86_64: terminating on signal 15 from
> > > pid
> > > 149357 (python3)
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 1 passed, 4 deselected in 13.22s
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > $ test/test-functional -k test_btmgmt --kernel=3D../linux --trace
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > > rootdir: /home/pauli/prj/external/bluez/unit
> > > configfile: pytest.ini
> > > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-
> > > 2.4.0,
> > > xdist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > > collected 5 items / 4 deselected / 1 selected
> > >=20
> > > test/functional/test_btmgmt_vm.py
> > > > > > > > > > > > > > > > > > > > > > > PDB runcall (IO-capturing
> > > > > > > > > > > > > > > > > > > > > > > turned off)
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > >=20
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(19
> > > > )test_btmgmt_info()
> > > -> (host,) =3D hosts
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(21
> > > > )test_btmgmt_info()
> > > -> result =3D host.call(
> > > (Pdb) p host.bdaddr
> > > '00:aa:01:00:00:42'
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(22
> > > > )test_btmgmt_info()
> > > -> run,
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(23
> > > > )test_btmgmt_info()
> > > -> [btmgmt, "--index", "0", "info"],
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(24
> > > > )test_btmgmt_info()
> > > -> stdout=3Dsubprocess.PIPE,
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(25
> > > > )test_btmgmt_info()
> > > -> stdin=3Dsubprocess.DEVNULL,
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(26
> > > > )test_btmgmt_info()
> > > -> encoding=3D"utf-8",
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(21
> > > > )test_btmgmt_info()
> > > -> result =3D host.call(
> > > (Pdb) n
> > > > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.p
> > > > y(28
> > > > )test_btmgmt_info()
> > > -> assert result.returncode =3D=3D 0
> > > (Pdb) p result
> > > CompletedProcess(args=3D['/home/pauli/prj/external/bluez/build/tool
> > > s/bt
> > > mgmt', '--index', '0', 'info'], returncode=3D0,
> > > stdout=3D'hci0:\tPrimary
> > > controller\n\taddr 00:AA:01:00:00:42 version 11 manufacturer 1521
> > > class 0x000000\n\tsupported settings: powered connectable fast-
> > > connectable discoverable bondable link-security ssp br/edr le
> > > advertising secure-conn debug-keys privacy static-addr phy-
> > > configuration cis-central cis-peripheral iso-broadcaster sync-
> > > receiver ll-privacy past-sender past-receiver \n\tcurrent
> > > settings:
> > > br/edr \n\tname \n\tshort name \n')
> > > (Pdb) print(result.stdout)
> > > hci0:	Primary controller
> > > 	addr 00:AA:01:00:00:42 version 11 manufacturer 1521
> > > class
> > > 0x000000
> > > 	supported settings: powered connectable fast-connectable
> > > discoverable bondable link-security ssp br/edr le advertising
> > > secure-
> > > conn debug-keys privacy static-addr phy-configuration cis-central
> > > cis-peripheral iso-broadcaster sync-receiver ll-privacy past-
> > > sender
> > > past-receiver
> > > 	current settings: br/edr
> > > 	name
> > > 	short name
> > > (Pdb) q
> > >=20
> > > !!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Quitting debugger
> > > !!!!!!!!!!!!!!!!!!!
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 4 deselected in 75.91s (0:01:15)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > ***
> > >=20
> > > Pauli Virtanen (20):
> > > =C2=A0 emulator: btvirt: check pkt lengths, don't get stuck on
> > > malformed
> > > =C2=A0 emulator: btvirt: allow specifying where server unix sockets
> > > are
> > > made
> > > =C2=A0 emulator: btvirt: support SCO data packets
> > > =C2=A0 emulator: btdev: clear more state on Reset
> > > =C2=A0 test-runner: enable path argument for --unix
> > > =C2=A0 test-runner: Add -o/--option option
> > > =C2=A0 test-runner: allow source tree root for -k
> > > =C2=A0 doc: enable CONFIG_VIRTIO_CONSOLE in tester config
> > > =C2=A0 test-runner: use virtio-serial for implementing -u device
> > > forwarding
> > > =C2=A0 doc: enable KVM paravirtualization & clock support in tester
> > > kernel
> > > =C2=A0=C2=A0=C2=A0 config
> > > =C2=A0 doc: add functional/integration testing documentation
> > > =C2=A0 test: add functional/integration testing framework
> > > =C2=A0 test: functional: add Pipewire-using audio streaming tests
> > > =C2=A0 test: functional: add --btmon option to start btmon
> > > =C2=A0 build: add functional testing target
> > > =C2=A0 test: functional: impose Python code formatting
> > > =C2=A0 test: functional: add option for building kernel image first
> > > =C2=A0 test: functional: add custom Agent1 implementation for testing
> > > =C2=A0 test: functional: warn on kernel warning/bug messages
> > > =C2=A0 test: functional: add basic obex file transfer tests
> > >=20
> > > =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > > =C2=A0Makefile.tools=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 +
> > > =C2=A0doc/ci.config=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > > =C2=A0doc/test-functional.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 949
> > > ++++++++++++++++++++++++
> > > =C2=A0doc/test-runner.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 17 +
> > > =C2=A0doc/tester.config=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > > =C2=A0emulator/btdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 117 +--
> > > =C2=A0emulator/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 +-
> > > =C2=A0emulator/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 21 +
> > > =C2=A0test/functional/__init__.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0test/functional/requirements.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > > =C2=A0test/functional/test_agent.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 46 ++
> > > =C2=A0test/functional/test_bluetoothctl_vm.py | 152 ++++
> > > =C2=A0test/functional/test_btmgmt_vm.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 30 +
> > > =C2=A0test/functional/test_obex.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 285 +++++++
> > > =C2=A0test/functional/test_pipewire.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 539 ++++++++++++++
> > > =C2=A0test/functional/test_tests.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +
> > > =C2=A0test/pytest.ini=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
> > > =C2=A0test/pytest_bluez/__init__.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +
> > > =C2=A0test/pytest_bluez/agent.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=EF=BF=BD
