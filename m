Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DC3D16F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874935; cv=pass; b=Gm0pHjoXQaXzwWCJkGDOxebRIekq5owaMwpWah54LoXtbIpf1qZhQre7YrTq9ptoDCizb/I7mxiHtPaCN807CW++3tZG9jyrZBAZRmxHzwCvFPCgqLlPtgh9+7akbv2WDvd7rlZxoVAVXTAIvsYA2e693+Prb3e5OBuB1/4ezFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874935; c=relaxed/simple;
	bh=aPp/9buowbZdhQG5aPl9z5FMa1tzZh5ZymfIxxDsrtE=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NdPxzL3mmhKVPlQdtlUsURji7seszjJFHpIW9cgvKawkVc/P3syog0J8Ylizc4H5AjrDwjd1a0WZFHGwn+TbAfqhq0rdPopuwm7m4eXw/qU9/BnoujmORO9U53Gb+2UM9b/tv3qyMKauuSY8PaYnxB6cRrMnEH9Rtmn8RqldIBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=k5P6q54+; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="k5P6q54+"
Received: from ehlo.thunderbird.net (unknown [143.244.47.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkrf244nbzyRb;
	Mon, 30 Mar 2026 15:48:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774874923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD5L9z/D4wbRh4R7Y1XvIqW2tYkYqXOzPsVe3AFUE7o=;
	b=k5P6q54+K9Sk/3H3NXqjRtI3LprdzriFcqnllYeFTdiKHwEbo5EFu8oZBSyqAnmb8KC5Re
	9h1txwsmR8Xq2xQhdscbxyrEclCTXzQSAm5Gnvijj1XPL3tdqa19UhL3zEW9TZvg5zaLQP
	RFOcvnd3dqp4vKiHuBDYfA2UbuZ94rI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774874923;
	b=Eyqq4T37KHw/Agn7Hq/93ix1Z2/Fo4GyRIYQ0v44PQMiRu1iLOqgNA9v9HqVg1luSl9nJl
	TuLdMxHf+aunWVmo0yhbW63RCdxo5dW7x8dKVrEYyEJ4SJcRjD/X9eaBllf5JcXiIPxt6e
	7QDmwSzGRAPzRESn/+47XUOHhoiwaxg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774874923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD5L9z/D4wbRh4R7Y1XvIqW2tYkYqXOzPsVe3AFUE7o=;
	b=mlpJPo9srpcqkNVeWWbNEAAtRuLlUpRKg1y7afTqgxFlNgjvXfdsVp5gFSkLOX17nTPwb+
	3ZQ6Fqz6kmUMJQo/1C1zmXqz7qCXpGzyjC/dCIhwYFW6IX0QYIfEteEWgnQ2OECAG+3iIp
	l7tTO8d3fshqOB05ltoXgUYqR0fBt7k=
Date: Mon, 30 Mar 2026 12:48:36 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 00/20] Functional/integration testing
In-Reply-To: <f10c6fd68d78b7b21f36a628eb0cb8f89f14ecea.camel@hadess.net>
References: <cover.1774214693.git.pav@iki.fi> <f10c6fd68d78b7b21f36a628eb0cb8f89f14ecea.camel@hadess.net>
Message-ID: <C64768DD-F94A-4F4D-8ADB-515DA3E78298@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

30=2E maaliskuuta 2026 12=2E30=2E55 UTC Bastien Nocera <hadess@hadess=2Ene=
t> kirjoitti:
>On Sun, 2026-03-22 at 23:29 +0200, Pauli Virtanen wrote:
>> Add framework for writing tests simulating "real" environments where
>> BlueZ and other parts of the stack run on different virtual machine
>> hosts that communicate with each other=2E
>
>Not having gone through the changes in a great level of detail, it
>looks fine to me=2E
>
>Is having some documentation that we could integrate into the website
>something you're planning post merge of this branch?
>
>Should probably have some explanations on how to deploy it on a bare
>metal machine, the dependencies for, say, Debian/Ubuntu/Fedora, and
>maybe considerations for implementing the test suite on CI runners
>(permissions, etc=2E)=2E

There is some documentation included in the series

https://lore=2Ekernel=2Eorg/linux-bluetooth/b8a81e4717298c521fa76ad2cc672d=
80adb066b2=2E1774214693=2Egit=2Epav@iki=2Efi/

With some setup instructions, but maybe not detailed enough=2E


>
>>=20
>> *** v3 ***
>>=20
>> https://github=2Ecom/pv/bluez/compare/func-test-v2-r=2E=2Efunc-test-v3
>>=20
>> * fix configure=2Eac openpty() detection to match TOOLS conditional,
>> =C2=A0 to fix make distcheck
>>=20
>> * properly retry virtio RPC connection if it fails initially
>>=20
>> * properly restart VM if previous test hangs
>>=20
>> * allow custom parent host side proxy objects, use them for pexpect
>>=20
>> * improve --list with out-of-tree test files
>>=20
>> * fix missing bus=2Eset_exit_on_disconnect(False) for obex tests
>>=20
>> * have --vm-timeout etc=2E change values also on VM host side
>>=20
>> * use larger-memory VM instances for Pipewire, in case ASAN enabled
>>=20
>> * set reasonable inside-VM ASAN_OPTION default values
>>=20
>> * don't run btvirt under stdbuf, since not compatible with ASAN
>>=20
>> *** v2 ***
>>=20
>> https://github=2Ecom/pv/bluez/compare/func-test-v1-r=2E=2Efunc-test-v2
>>=20
>> * move unit/func_test -> test/functional & test/pytest_bluez
>>=20
>> =C2=A0 The pytest_bluez plugin is in principle reusable for other
>> projects,
>> =C2=A0 so we can eg=2E have more complete Pipewire integration tests th=
at
>> can
>> =C2=A0 live in Pipewire repository=2E
>>=20
>> * openpty() is in -lutil on some platforms, detect this in autoconf
>>=20
>> * more emulator adjustments:
>>=20
>> =C2=A0 - fix SCO data packet support in btvirt
>> =C2=A0 - more complete Reset command
>>=20
>> * improve logging: get timestamps from kernel, and reorder logs
>> =C2=A0 to timestamp order, so that lines from different hosts, btmon,
>> =C2=A0 and parent tester appear in right order regardless of whether
>> =C2=A0 VM console / btmon is lagging
>>=20
>> =C2=A0 - this requires accurate clock sync in the VM, so enable KVM PTP=
 in
>> =C2=A0=C2=A0=C2=A0 config and run chronyd inside the VMs
>> =C2=A0 - use virtio port instead of qemu console to export logs, since =
the
>> =C2=A0=C2=A0=C2=A0 console has fixed baud rate and is too slow
>>=20
>> * add --btmon & export btsnoop dumps from VM hosts
>>=20
>> * fix compatibility with older Python versions
>>=20
>> * add parametrized_host_config()
>>=20
>> * split Pipewire test to A2DP/BAP/HFP and really stream audio=2E
>> =C2=A0 These catch the 5=2E86 regression fixed in 066a164a524e498 and
>> =C2=A0 the 5=2E84 one in 6b0a08776a
>>=20
>> * add support for tests that reuse tester environment, so they can
>> run
>> =C2=A0 faster without needing Bluetoothd teardown/setup in between
>>=20
>> * add HostPlugin=2Epresetup (mainly for test skipping)
>>=20
>> * deal with RPC virtio port buffer possibly containing unflushed
>> =C2=A0 commands from previous failed test
>>=20
>> * add some Agent1 interface tests
>>=20
>> * add basic Obex file transfer tests
>>=20
>> * add support for logging in to a running test instance (for gdb etc)
>>=20
>> * export any core dumps out from test environ
>>=20
>> Some bells & whistles:
>>=20
>> * add --kernel-build for kernel image build
>>=20
>> * test suite Python code formatting checks
>>=20
>> ***
>>=20
>> Implements:
>>=20
>> - RPC communication with tester instances running each of the VM
>> hosts=2E
>> =C2=A0 Tests run on parent host, which instructs VM hosts what to do=2E
>>=20
>> - Extensible way to add stateful test-specific code inside the VM
>> =C2=A0 instances
>>=20
>> - Logging control: output from different processes running inside the
>> VM
>> =C2=A0 are separated and can be filtered=2E
>>=20
>> - Test runner framework with Pytest (more convenient than
>> Python/unittest)
>>=20
>> - Automatic grouping of tests to minimize VM reboots
>>=20
>> - Redirecting USB controllers to use for testing in addition to
>> btvirt
>>=20
>> - Fairly straightforward, ~1600 sloc for the framework
>>=20
>> There is no requirement that the tests spawn VM instances, the test
>> runner can be used for any tests written in Python=2E
>>=20
>> See doc/test-functional=2Erst for various examples=2E
>>=20
>> Also test/functional/test_bluetoothctl_vm=2Epy has some simple cases,
>> and
>> test/functional/test_pipewire=2Epy for a more complicated setup
>>=20
>> =C2=A0=C2=A0=C2=A0 host0(qemu): Pipewire <-> BlueZ <-> kernel
>> =C2=A0=C2=A0=C2=A0 <-> btvirt
>> =C2=A0=C2=A0=C2=A0 host1(qemu): kernel <-> BlueZ <-> Pipewire
>>=20
>> The framework allows easily passing any data and code between the
>> parent
>> and VM hosts, so writing tests is straightforward=2E
>>=20
>> ***
>>=20
>> Some examples:
>>=20
>> $ test/test-functional --list -q
>>=20
>> test/functional/lib/tests/test_rpc=2Epy::test_basic
>> test/functional/test_bluetoothctl_vm=2Epy::test_bluetoothctl_pair[hosts
>> 0-vm2]
>> test/functional/test_bluetoothctl_vm=2Epy::test_bluetoothctl_script_sho
>> w[hosts1-vm1]
>> test/functional/test_btmgmt_vm=2Epy::test_btmgmt_info[hosts2-vm1]
>> test/functional/test_pipewire=2Epy::test_pipewire[hosts3-vm2]
>>=20
>> $ test/test-functional -v --no-header
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test session starts
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> collected 5 items
>>=20
>> test/functional/lib/tests/test_rpc=2Epy::test_basic
>> PASSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [ 20%]
>> test/functional/test_bluetoothctl_vm=2Epy::test_bluetoothctl_script_sho
>> w[hosts1-vm1] SKIPPED=C2=A0=C2=A0=C2=A0 [ 40%]
>> test/functional/test_btmgmt_vm=2Epy::test_btmgmt_info[hosts2-vm1]
>> SKIPPED (No kernel image)=C2=A0=C2=A0=C2=A0=C2=A0 [ 60%]
>> test/functional/test_bluetoothctl_vm=2Epy::test_bluetoothctl_pair[hosts
>> 0-vm2] SKIPPED (No k=2E=2E=2E) [ 80%]
>> test/functional/test_pipewire=2Epy::test_pipewire[hosts3-vm2] SKIPPED
>> (No kernel image)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [100%=
]
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 passed, 4 skipped in 0=2E19s
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> $ test/test-functional --kernel=3D=2E=2E/linux
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> platform linux -- Python 3=2E14=2E3, pytest-8=2E3=2E5, pluggy-1=2E6=2E0
>> rootdir: /home/pauli/prj/external/bluez/unit
>> configfile: pytest=2Eini
>> plugins: cov-5=2E0=2E0, forked-1=2E6=2E0, rerunfailures-15=2E0, timeout=
-2=2E4=2E0,
>> xdist-3=2E7=2E0, hypothesis-6=2E123=2E0, flaky-3=2E8=2E1, anyio-4=2E12=
=2E1
>> collected 5 items
>>=20
>> test/functional/lib/tests/test_rpc=2Epy
>> =2E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 20%]
>> test/functional/test_bluetoothctl_vm=2Epy
>> =2E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 40%]
>> test/functional/test_btmgmt_vm=2Epy
>> =2E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [ 60%]
>> test/functional/test_bluetoothctl_vm=2Epy
>> =2E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ 80%]
>> test/functional/test_pipewire=2Epy
>> =2E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [100%]
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D 5 passed in 41=2E92s
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>=20
>> $ test/test-functional --kernel=3D=2E=2E/linux -k test_btmgmt
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> platform linux -- Python 3=2E14=2E3, pytest-8=2E3=2E5, pluggy-1=2E6=2E0
>> rootdir: /home/pauli/prj/external/bluez/unit
>> configfile: pytest=2Eini
>> plugins: cov-5=2E0=2E0, forked-1=2E6=2E0, rerunfailures-15=2E0, timeout=
-2=2E4=2E0,
>> xdist-3=2E7=2E0, hypothesis-6=2E123=2E0, flaky-3=2E8=2E1, anyio-4=2E12=
=2E1
>> collected 5 items / 4 deselected / 1 selected
>>=20
>> test/functional/test_btmgmt_vm=2Epy
>> =2E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [100%]
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1=
 passed, 4 deselected in 9=2E15s
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>=20
>> $ grep btmgmt test-functional=2Elog
>> 13:15:42 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin ('call',
>> '__call__', <function run at 0x7f27b81ce140>,
>> ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0',
>> 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
>> 13:15:42 INFO=C2=A0=C2=A0 host=2E0=2E0=2Erpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 server: call_plugin ('call',
>> '__call__', <function run at 0x7fd5e35a1010>,
>> ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0',
>> 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
>> 13:15:42 INFO=C2=A0=C2=A0 host=2E0=2E0=2Erun=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $
>> /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info
>>=20
>> $ test/test-functional --kernel=3D=2E=2E/linux -k test_btmgmt --log-cli=
-
>> level=3D0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> platform linux -- Python 3=2E14=2E3, pytest-8=2E3=2E5, pluggy-1=2E6=2E0
>> rootdir: /home/pauli/prj/external/bluez/unit
>> configfile: pytest=2Eini
>> plugins: cov-5=2E0=2E0, forked-1=2E6=2E0, rerunfailures-15=2E0, timeout=
-2=2E4=2E0,
>> xdist-3=2E7=2E0, hypothesis-6=2E123=2E0, flaky-3=2E8=2E1, anyio-4=2E12=
=2E1
>> collected 5 items / 4 deselected / 1 selected
>>=20
>> test/functional/test_btmgmt_vm=2Epy::test_btmgmt_info[hosts2-vm1]
>> -------------------------------- live log setup ---------------------
>> -----------
>> 13:00:31 INFO=C2=A0=C2=A0 func_test=2Elib=2Eenv=C2=A0=C2=A0 :=C2=A0 Sta=
rting btvirt:
>> /usr/bin/stdbuf -o L -e L
>> /home/pauli/prj/external/bluez/build/emulator/btvirt --
>> server=3D/tmp/bluez-func-test-8t6ychy8
>> 13:00:31 OUT=C2=A0=C2=A0=C2=A0 btvirt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 Bluetooth emulator ve=
r 5=2E86
>> 13:00:31 INFO=C2=A0=C2=A0 func_test=2Elib=2Eenv=C2=A0=C2=A0 :=C2=A0 Sta=
rting host:
>> /home/pauli/prj/external/bluez/build/tools/test-runner --
>> kernel=3D=2E=2E/linux/arch/x86/boot/bzImage -u/tmp/bluez-func-test-
>> 8t6ychy8/bt-server-bredrle -o -chardev -o
>> socket,id=3Dser0,path=3D/tmp/bluez-func-test-8t6ychy8/bluez-func-test-
>> rpc-0,server=3Don,wait=3Doff -o -device -o virtio-serial -o -device -o
>> virtserialport,chardev=3Dser0,name=3Dbluez-func-test-rpc -H --
>> /usr/bin/python3 -P
>> /home/pauli/prj/external/bluez/test/functional/lib/runner=2Epy
>> /dev/ttyS2
>> 13:00:31 OUT=C2=A0=C2=A0=C2=A0 btvirt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 Request for /tmp/blue=
z-func-
>> test-8t6ychy8/bt-server-bredrle
>> 13:00:32 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 early console in
>> extract_kernel
>> 13:00:32 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 input_data: 0x000000000425c=
2c4
>> =2E=2E=2E
>> 13:00:39 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin ('call',
>> '__call__', <function run at 0x7f7547472140>,
>> ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0',
>> 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
>> 13:00:39 DEBUG=C2=A0 host=2E0=2E0=2Erpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 server: done
>> 13:00:39 INFO=C2=A0=C2=A0 host=2E0=2E0=2Erpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 server: call_plugin ('call',
>> '__call__', <function run at 0x7f77dcc81010>,
>> ['/home/pauli/prj/external/bluez/build/tools/btmgmt', '--index', '0',
>> 'info']) {'stdout': -1, 'stdin': -3, 'encoding': 'utf-8'}
>> 13:00:39 INFO=C2=A0=C2=A0 host=2E0=2E0=2Erun=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $
>> /home/pauli/prj/external/bluez/build/tools/btmgmt --index 0 info
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Erun=2Eout=C2=A0=C2=A0=C2=
=A0 :=C2=A0 hci0:	Primary controller
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Erun=2Eout=C2=A0=C2=A0=C2=
=A0 :=C2=A0=C2=A0	addr 00:AA:01:00:00:42
>> version 11 manufacturer 1521 class 0x000000
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Erun=2Eout=C2=A0=C2=A0=C2=
=A0 :=C2=A0=C2=A0	supported settings: powered
>> connectable fast-connectable discoverable bondable link-security ssp
>> br/edr le advertising secure-conn debug-keys privacy static-addr phy-
>> configuration cis-central cis-peripheral iso-broadcaster sync-
>> receiver ll-privacy past-sender past-receiver
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Erun=2Eout=C2=A0=C2=A0=C2=
=A0 :=C2=A0=C2=A0	current settings: br/edr
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Erun=2Eout=C2=A0=C2=A0=C2=
=A0 :=C2=A0=C2=A0	name
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Erun=2Eout=C2=A0=C2=A0=C2=
=A0 :=C2=A0=C2=A0	short name
>> 13:00:40 INFO=C2=A0=C2=A0 host=2E0=2E0=2Erun=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 (return code 0)
>> 13:00:40 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> PASSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0 [100%]
>> 13:00:40 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=C2=A0 qemu-system-x86_64:
>> terminating on signal 15 from pid 149047 (python3)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1=
 passed, 4 deselected in 8=2E84s
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>=20
>> $ test/test-functional --kernel=3D=2E=2E/linux -k test_bluetoothctl_pai=
r --
>> log-cli-level=3D0 --log-filter=3D*=2Ebluetoothctl,rpc=2E* --force-usb
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> platform linux -- Python 3=2E14=2E3, pytest-8=2E3=2E5, pluggy-1=2E6=2E0
>> rootdir: /home/pauli/prj/external/bluez/unit
>> configfile: pytest=2Eini
>> plugins: cov-5=2E0=2E0, forked-1=2E6=2E0, rerunfailures-15=2E0, timeout=
-2=2E4=2E0,
>> xdist-3=2E7=2E0, hypothesis-6=2E123=2E0, flaky-3=2E8=2E1, anyio-4=2E12=
=2E1
>> collected 5 items / 4 deselected / 1 selected
>>=20
>> test/functional/test_bluetoothctl_vm=2Epy::test_bluetoothctl_pair[hosts
>> 0-vm2]
>> -------------------------------- live log setup ---------------------
>> -----------
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EBdaddr object at 0x7f268712d160>,) {=
}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2ECall object at 0x7f268712d2b0>,) {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EDbusSystem object at 0x7f2687aa30e0>=
,)
>> {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EBluetoothd object at 0x7f2687aa3230>=
,)
>> {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EBluetoothctl object at 0x7f268712d01=
0>,)
>> {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EBdaddr object at 0x7f26871542d0>,) {=
}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2ECall object at 0x7f2687154410>,) {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EDbusSystem object at 0x7f2687aa30e0>=
,)
>> {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EBluetoothd object at 0x7f2687aa3230>=
,)
>> {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: start_load
>> (<func_test=2Elib=2Ehost_plugins=2EBluetoothctl object at 0x7f268715419=
0>,)
>> {}
>> 13:03:20 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: wait_load () {}
>> 13:03:21 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:21 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: wait_load () {}
>> 13:03:21 DEBUG=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> -------------------------------- live log call ----------------------
>> -----------
>> 13:03:21 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'send', 'show\n') {}
>> 13:03:21 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:21 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'expect', 'Powered: yes') {}
>> =2E=2E=2E
>> 13:03:23 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'send', 'pair 70:1a:b8:73:99:bb\n') {}
>> 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 pair =
70:1a:b8:73:99:bb
>> 13:03:23 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:23 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'expect', 'Confirm passkey (\\d+)=2E*:') {}
>> 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> pair
>> 70:1a:b8:73:99:bb
>> 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 Attem=
pting to pair with
>> 70:1A:B8:73:99:BB
>> 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> hci0
>> device_flags_changed: 70:1A:B8:73:99:BB (BR/EDR)
>> 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [blue=
toothctl]>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supp:
>> 0x00000007=C2=A0 curr: 0x00000000
>> 13:03:23 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> hci0 type 7
>> discovering off
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> hci0
>> 70:1A:B8:73:99:BB type BR/EDR connected eir_len 12
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> [BlueZ 5=2E86]>
>> [CHG] Device 70:1A:B8:73:99:BB Connected: yes
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> Request
>> confirmation
>> 13:03:25 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:25 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'expect', 'Confirm passkey 237345') {}
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E1=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> hci0
>> 84:5C:F3:77:31:19 type BR/EDR connected eir_len 12
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E1=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> [NEW] Device
>> 84:5C:F3:77:31:19 BlueZ 5=2E86
>> 13:03:25 DEBUG=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:25 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'send', 'yes\n') {}
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E1=2Ebluetoothctl:=C2=A0 [blue=
toothctl]> [BlueZ 5=2E86]>
>> Request confirmation
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [agent] Confirm
>> passkey 237345 (yes/no): yes
>> 13:03:25 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:25 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'send', 'yes\n') {}
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E1=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [agent] Confirm
>> passkey 237345 (yes/no): yes
>> 13:03:25 DEBUG=C2=A0 rpc=2Ehost=2E0=2E1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> 13:03:25 INFO=C2=A0=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :=C2=A0 client: call_plugin
>> ('bluetoothctl', 'expect', 'Pairing successful') {}
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 yes
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> hci0
>> new_link_key 70:1A:B8:73:99:BB type 0x08 pin_len 0 store_hint 1
>> 13:03:25 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [CHG] Device
>> 70:1A:B8:73:99:BB Bonded: yes
>> 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [CHG] Device
>> 70:1A:B8:73:99:BB AddressType: public
>> 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [CHG] Device
>> 70:1A:B8:73:99:BB UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
>> 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [CHG] Device
>> 70:1A:B8:73:99:BB UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
>> 13:03:26 DEBUG=C2=A0 rpc=2Ehost=2E0=2E0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 :=C2=A0 client-reply
>> PASSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0 [100%]
>> ------------------------------ live log teardown --------------------
>> -----------
>> 13:03:26 OUT=C2=A0=C2=A0=C2=A0 host=2E0=2E0=2Ebluetoothctl:=C2=A0 [Blue=
Z 5=2E86]> [CHG] Device
>> 70:1A:B8:98:FF:qemu-system-x86_64: terminating on signal 15 from pid
>> 149357 (python3)
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1=
 passed, 4 deselected in 13=2E22s
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> $ test/test-functional -k test_btmgmt --kernel=3D=2E=2E/linux --trace
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> platform linux -- Python 3=2E14=2E3, pytest-8=2E3=2E5, pluggy-1=2E6=2E0
>> rootdir: /home/pauli/prj/external/bluez/unit
>> configfile: pytest=2Eini
>> plugins: cov-5=2E0=2E0, forked-1=2E6=2E0, rerunfailures-15=2E0, timeout=
-2=2E4=2E0,
>> xdist-3=2E7=2E0, hypothesis-6=2E123=2E0, flaky-3=2E8=2E1, anyio-4=2E12=
=2E1
>> collected 5 items / 4 deselected / 1 selected
>>=20
>> test/functional/test_btmgmt_vm=2Epy
>> > > > > > > > > > > > > > > > > > > > > PDB runcall (IO-capturing
>> > > > > > > > > > > > > > > > > > > > > turned off)
>> > > > > > > > > > > > > > > > > > > > > >>>>>>>>>>>>>>>>>>>>>
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(19
>> > )test_btmgmt_info()
>> -> (host,) =3D hosts
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(21
>> > )test_btmgmt_info()
>> -> result =3D host=2Ecall(
>> (Pdb) p host=2Ebdaddr
>> '00:aa:01:00:00:42'
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(22
>> > )test_btmgmt_info()
>> -> run,
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(23
>> > )test_btmgmt_info()
>> -> [btmgmt, "--index", "0", "info"],
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(24
>> > )test_btmgmt_info()
>> -> stdout=3Dsubprocess=2EPIPE,
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(25
>> > )test_btmgmt_info()
>> -> stdin=3Dsubprocess=2EDEVNULL,
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(26
>> > )test_btmgmt_info()
>> -> encoding=3D"utf-8",
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(21
>> > )test_btmgmt_info()
>> -> result =3D host=2Ecall(
>> (Pdb) n
>> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm=2Epy(28
>> > )test_btmgmt_info()
>> -> assert result=2Ereturncode =3D=3D 0
>> (Pdb) p result
>> CompletedProcess(args=3D['/home/pauli/prj/external/bluez/build/tools/bt
>> mgmt', '--index', '0', 'info'], returncode=3D0, stdout=3D'hci0:\tPrimar=
y
>> controller\n\taddr 00:AA:01:00:00:42 version 11 manufacturer 1521
>> class 0x000000\n\tsupported settings: powered connectable fast-
>> connectable discoverable bondable link-security ssp br/edr le
>> advertising secure-conn debug-keys privacy static-addr phy-
>> configuration cis-central cis-peripheral iso-broadcaster sync-
>> receiver ll-privacy past-sender past-receiver \n\tcurrent settings:
>> br/edr \n\tname \n\tshort name \n')
>> (Pdb) print(result=2Estdout)
>> hci0:	Primary controller
>> 	addr 00:AA:01:00:00:42 version 11 manufacturer 1521 class
>> 0x000000
>> 	supported settings: powered connectable fast-connectable
>> discoverable bondable link-security ssp br/edr le advertising secure-
>> conn debug-keys privacy static-addr phy-configuration cis-central
>> cis-peripheral iso-broadcaster sync-receiver ll-privacy past-sender
>> past-receiver
>> 	current settings: br/edr
>> 	name
>> 	short name
>> (Pdb) q
>>=20
>> !!!!!!!!!!!!!!!!!!! _pytest=2Eoutcomes=2EExit: Quitting debugger
>> !!!!!!!!!!!!!!!!!!!
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 4=
 deselected in 75=2E91s (0:01:15)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> ***
>>=20
>> Pauli Virtanen (20):
>> =C2=A0 emulator: btvirt: check pkt lengths, don't get stuck on malforme=
d
>> =C2=A0 emulator: btvirt: allow specifying where server unix sockets are
>> made
>> =C2=A0 emulator: btvirt: support SCO data packets
>> =C2=A0 emulator: btdev: clear more state on Reset
>> =C2=A0 test-runner: enable path argument for --unix
>> =C2=A0 test-runner: Add -o/--option option
>> =C2=A0 test-runner: allow source tree root for -k
>> =C2=A0 doc: enable CONFIG_VIRTIO_CONSOLE in tester config
>> =C2=A0 test-runner: use virtio-serial for implementing -u device
>> forwarding
>> =C2=A0 doc: enable KVM paravirtualization & clock support in tester ker=
nel
>> =C2=A0=C2=A0=C2=A0 config
>> =C2=A0 doc: add functional/integration testing documentation
>> =C2=A0 test: add functional/integration testing framework
>> =C2=A0 test: functional: add Pipewire-using audio streaming tests
>> =C2=A0 test: functional: add --btmon option to start btmon
>> =C2=A0 build: add functional testing target
>> =C2=A0 test: functional: impose Python code formatting
>> =C2=A0 test: functional: add option for building kernel image first
>> =C2=A0 test: functional: add custom Agent1 implementation for testing
>> =C2=A0 test: functional: warn on kernel warning/bug messages
>> =C2=A0 test: functional: add basic obex file transfer tests
>>=20
>> =C2=A0Makefile=2Eam=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
>> =C2=A0Makefile=2Etools=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>> =C2=A0configure=2Eac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 +
>> =C2=A0doc/ci=2Econfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
>> =C2=A0doc/test-functional=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 949
>> ++++++++++++++++++++++++
>> =C2=A0doc/test-runner=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 17 +
>> =C2=A0doc/tester=2Econfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
>> =C2=A0emulator/btdev=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 117 +--
>> =C2=A0emulator/main=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 +-
>> =C2=A0emulator/server=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 21 +
>> =C2=A0test/functional/__init__=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>> =C2=A0test/functional/requirements=2Etxt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>> =C2=A0test/functional/test_agent=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 46 ++
>> =C2=A0test/functional/test_bluetoothctl_vm=2Epy | 152 ++++
>> =C2=A0test/functional/test_btmgmt_vm=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 30 +
>> =C2=A0test/functional/test_obex=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 285 +++++++
>> =C2=A0test/functional/test_pipewire=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 539 ++++++++++++++
>> =C2=A0test/functional/test_tests=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +
>> =C2=A0test/pytest=2Eini=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
>> =C2=A0test/pytest_bluez/__init__=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +
>> =C2=A0test/pytest_bluez/agent=2Epy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=EF=BF=BD
