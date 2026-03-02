Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F688282F0C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486339; cv=pass; b=TL+zcWo56gR5dLYKLlgSk/h0+hBM0dcQd+uTItG2rErpCo247ggaxrsNmYD2HaeXQEa9e74QI13hJ926K7NVKfwRTLFsJnyIJkxjrNLgpC905mK5cDlypAp7104iOQAKr1fp0kxD7aKVFEbVRjWcO6eKYt3W0YNKT/lQSqm61Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486339; c=relaxed/simple;
	bh=u3t/02EFaZrp2u0K57Qickde+/iV0zllxR1EMga0eKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0io4NasRoJA97vN4emdzEm/Ci0pQfwCPjPVwqIOPGq8x83cMDpJYMU/nYe5fbKaOIUbMYZbCYuoLOOi6FnTb4XSBzI4ERSZN6CntgwZSQT3BOyZBJ/tONmIJ5uKH7S2hcCRvVjc7IORq+gy7mjAR+BuGPFyzRwoQHsqfuQJsJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iytlqga6; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iytlqga6"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986c7b8076so50081017b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 13:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772486337; cv=none;
        d=google.com; s=arc-20240605;
        b=Vqbb9Is77V8lvCiEsWnChmK/FfXv4kJbRuSWjlGanqkEzBRwDn3X9G49B/6QrGxlz6
         jqwu9JIrFAU+lcfJ53o24Hvr3m77mKr+G8ROI3xQO37AeBgXkPuEuZbFBpIKuMr/OOrt
         3MqX5IzW+VxDtw6Q2UWcl3WkAyvwi83p8WqehDnlWrpyH3Kpf5690AB70xUjvLittzfK
         w90avPtVm1hPWHcHsQeBctyDl2kwS+97pev8SKgI+odvKxwSuDvO4pQaKmXjDdY60em8
         rx6by23uIa3Lv9KEYCgbCLb2+7i3S1qjhN/ETh8iMX+QbiWR2yrKbeUgZMh1TWtjsVZ4
         7g/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jv2bMz5Nsnn3NYKfenuIjInMOW/50Fv2afZnGAhQv5A=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=X4kmUqUKgOBOUYq2HWS4fgVQk5Oto3YfxxjRg9j8cgE8XQ/7gznX4JJT/UDu/fPTDv
         Pcs6bvTAET+sEREbc61oEMOQXLTiv1HI3g09kX1quhqBfd1/wIf4WXUHXdZZxmd++no1
         nrURR5kZfrb5wc8gSSQYRGjjgmtZF1LgJu8dFUzMblfx9KV9sakcL5lynHwAMsUbNdrp
         mp2l72F0XBkMALPsPtO6MVHH4zSUcRb6LAGr3+jnh3P596pVyCNsKNs2K1xlU1XFChV5
         kLKLhdQTToWDVMIYiXE2o7f9YB3IXEczpR9RG2Qqf3Ta1q3ya9cfxpbihtv8J1vFNdQ5
         TpVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772486337; x=1773091137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv2bMz5Nsnn3NYKfenuIjInMOW/50Fv2afZnGAhQv5A=;
        b=iytlqga6aUoD9KBD5YBKmq2BJbEH1ID73WBoha0ks1vFAi1zJhf+iJS94uhSiBNlrV
         2M6hROQbxZKTnL3DXCRGU+7Z/WUusGe0Hh/j1BHe5QGbrD9P+H6TbxM2Vt6Zzn+IwfnL
         iY65+tlnIbu2N5xJ1sR/urDElNEZ2yovgwMPXnf68RNuiTjmp5VRaYkmY6Yc/3dVxFxC
         LYZtbNS1r1tJq0FSw5Iiay1YhSTnoPYgqn4Ce4sPILOYvr4jS9jVSAioSV6I7jdO//U0
         alEb/HgJeqAHHiMUmhk0guUViZCxTtu7BuDvPgcqlYhPLTYFIc6HsNJ1jwp4q3hdtoNT
         Sjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772486337; x=1773091137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jv2bMz5Nsnn3NYKfenuIjInMOW/50Fv2afZnGAhQv5A=;
        b=vgsPLx2zf5tVqY4JIp/9LQosmgV8MLKnBERiRyaWN4ziUjwx6jxHmH+9A0V1v731cA
         U62Ubp9eRnaJbnNM3hv1gAreSW4FCMi5fM1kreiuPkIcI9jHOWVSfxk0TWW5ee8Q6Go+
         +JqPmirmop15/b4QLrO8kD4JGxWfNXVFSAyYJBZ5uGRN0Fw2rJGuoidHpDnew+YnR2V4
         Z8huWN1aRzGjCIw3/kp4T7H3whWnXEK3KEIFDZZwYDiVJ/8XqXkHepyUfGXMhvWDdpoF
         rm13GTb214zWWyxM1XfP4v4+V8DFg5bOSekkYIARmah6vlqeGyLta/oMYnj9K93t/Cuj
         GXhw==
X-Gm-Message-State: AOJu0Yz9uyVo4gRwGAcNq2ZgbcdfhdLiIrXwN0c2Y5KKF7mzHu/fWbfh
	pnApd+B2I+m3/U1pPwdG1Ai1n8ZHhf/A9OIYlUgeGaUeaSyS+A3/cFb9JdU9qcarWWiTtG6+Yz5
	2BHsZUmOk9mGvs4oShuvDd5+HlXDNDtk=
X-Gm-Gg: ATEYQzxw9F3vYXqZ7BdfzIJyHNemNYOONt03gLlirjy36chYJhrRoGckhdpz/sCau1V
	jqGz7pCCbOv8icwKmEl+qIUAfKeMhJ3ezh1MtLuhjQx1feRZ2GHM1u+LOu3F6oii5qlSS/dqD4F
	uakUBOMDkdWbKcM0vaVN6PGx5vQycvs5P6ZsD53Tfr6uD92MA6HuOL/kCxOloV+PK4KDXYqXFbk
	efvjTpjIap0V+WuA9IR6oOOb1H4R5aR7Js94MoLhhsB9e7ZKwFc1ODJ8U/VmBLx1XQ5Yt1TOF2T
	OFuN68wD4pHBv2XXQhgY2VcfV6EX4WOCJTEN2zQABZaSazzTrgph1xaueWL4wclcYAiy19KnmAJ
	YKAO5
X-Received: by 2002:a05:690c:4a0b:b0:797:d45d:6fee with SMTP id
 00721157ae682-798855e5c6dmr123984927b3.55.1772486336306; Mon, 02 Mar 2026
 13:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772282574.git.pav@iki.fi>
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Mar 2026 16:18:43 -0500
X-Gm-Features: AaiRm53ecssf8lY6Nbs-aU1OqIZmQuMPdwBZ832NZ6CP4gVI7FURs2g5M7dIo00
Message-ID: <CABBYNZ+ski877E=t05=boS=Pc9qLp4FDM8xgQoc0E+Z=o48-Qg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/11] Functional/integration testing
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Feb 28, 2026 at 7:52=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add framework for writing tests simulating "real" environments where
> BlueZ and other parts of the stack run on different virtual machine
> hosts that communicate with each other.
>
> Implements:
>
> - RPC communication with tester instances running each of the VM hosts.
>   Tests run on parent host, which instructs VM hosts what to do.
>
> - Extensible way to add stateful test-specific code inside the VM
>   instances
>
> - Logging control: output from different processes running inside the VM
>   are separated and can be filtered.
>
> - Test runner framework with Pytest (more convenient than Python/unittest=
)
>
> - Automatic grouping of tests to minimize VM reboots
>
> - Redirecting USB controllers to use for testing in addition to btvirt
>
> - Fairly straightforward, ~1600 sloc for the framework
>
> There is no requirement that the tests spawn VM instances, the test
> runner can be used for any tests written in Python.
>
> See doc/test-functional.rst for various examples.
>
> Also unit/func_test/test_bluetoothctl_vm.py has some simple cases, and
> unit/func_test/test_pipewire.py for a more complicated setup
>
>     host0(qemu): Pipewire <-> BlueZ <-> kernel
>     <-> btvirt
>     host1(qemu): kernel <-> BlueZ <-> Pipewire
>
> The framework allows easily passing any data and code between the parent
> and VM hosts, so writing tests is straightforward.
>
> ***
>
> Some examples:
>
> $ unit/test-functional --list -q
>
> unit/func_test/lib/tests/test_rpc.py::test_basic
> unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2=
]
> unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hos=
ts1-vm1]
> unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> unit/func_test/test_pipewire.py::test_pipewire[hosts3-vm2]
>
> $ unit/test-functional -v --no-header
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> collected 5 items
>
> unit/func_test/lib/tests/test_rpc.py::test_basic PASSED                  =
                    [ 20%]
> unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[hos=
ts1-vm1] SKIPPED    [ 40%]
> unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1] SKIPPED (N=
o kernel image)     [ 60%]
> unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2=
] SKIPPED (No k...) [ 80%]
> unit/func_test/test_pipewire.py::test_pipewire[hosts3-vm2] SKIPPED (No ke=
rnel image)         [100%]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 passed, 4 skipped in 0.19s =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> $ unit/test-functional --kernel=3D../linux
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> rootdir: /home/pauli/prj/external/bluez/unit
> configfile: pytest.ini
> plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdis=
t-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> collected 5 items
>
> unit/func_test/lib/tests/test_rpc.py .                                   =
[ 20%]
> unit/func_test/test_bluetoothctl_vm.py .                                 =
[ 40%]
> unit/func_test/test_btmgmt_vm.py .                                       =
[ 60%]
> unit/func_test/test_bluetoothctl_vm.py .                                 =
[ 80%]
> unit/func_test/test_pipewire.py .                                        =
[100%]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D 5 passed in 41.92s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ unit/test-functional --kernel=3D../linux -k test_btmgmt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> rootdir: /home/pauli/prj/external/bluez/unit
> configfile: pytest.ini
> plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdis=
t-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> collected 5 items / 4 deselected / 1 selected
>
> unit/func_test/test_btmgmt_vm.py .                                       =
[100%]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 p=
assed, 4 deselected in 9.15s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ grep btmgmt test-functional.log
> 13:15:42 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__ca=
ll__', <function run at 0x7f27b81ce140>, ['/home/pauli/prj/external/bluez/b=
uild/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'e=
ncoding': 'utf-8'}
> 13:15:42 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__ca=
ll__', <function run at 0x7fd5e35a1010>, ['/home/pauli/prj/external/bluez/b=
uild/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'e=
ncoding': 'utf-8'}
> 13:15:42 INFO   host.0.0.run        :      $ /home/pauli/prj/external/blu=
ez/build/tools/btmgmt --index 0 info
>
> $ unit/test-functional --kernel=3D../linux -k test_btmgmt --log-cli-level=
=3D0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> rootdir: /home/pauli/prj/external/bluez/unit
> configfile: pytest.ini
> plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdis=
t-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> collected 5 items / 4 deselected / 1 selected
>
> unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> -------------------------------- live log setup -------------------------=
-------
> 13:00:31 INFO   func_test.lib.env   :  Starting btvirt: /usr/bin/stdbuf -=
o L -e L /home/pauli/prj/external/bluez/build/emulator/btvirt --server=3D/t=
mp/bluez-func-test-8t6ychy8
> 13:00:31 OUT    btvirt              :  Bluetooth emulator ver 5.86
> 13:00:31 INFO   func_test.lib.env   :  Starting host: /home/pauli/prj/ext=
ernal/bluez/build/tools/test-runner --kernel=3D../linux/arch/x86/boot/bzIma=
ge -u/tmp/bluez-func-test-8t6ychy8/bt-server-bredrle -o -chardev -o socket,=
id=3Dser0,path=3D/tmp/bluez-func-test-8t6ychy8/bluez-func-test-rpc-0,server=
=3Don,wait=3Doff -o -device -o virtio-serial -o -device -o virtserialport,c=
hardev=3Dser0,name=3Dbluez-func-test-rpc -H -- /usr/bin/python3 -P /home/pa=
uli/prj/external/bluez/unit/func_test/lib/runner.py /dev/ttyS2
> 13:00:31 OUT    btvirt              :  Request for /tmp/bluez-func-test-8=
t6ychy8/bt-server-bredrle
> 13:00:32 OUT    host.0.0            :  early console in extract_kernel
> 13:00:32 OUT    host.0.0            :  input_data: 0x000000000425c2c4
> ...
> 13:00:39 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__ca=
ll__', <function run at 0x7f7547472140>, ['/home/pauli/prj/external/bluez/b=
uild/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'e=
ncoding': 'utf-8'}
> 13:00:39 DEBUG  host.0.0.rpc        :  server: done
> 13:00:39 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__ca=
ll__', <function run at 0x7f77dcc81010>, ['/home/pauli/prj/external/bluez/b=
uild/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, 'e=
ncoding': 'utf-8'}
> 13:00:39 INFO   host.0.0.run        :      $ /home/pauli/prj/external/blu=
ez/build/tools/btmgmt --index 0 info
> 13:00:40 OUT    host.0.0.run.out    :  hci0:    Primary controller
> 13:00:40 OUT    host.0.0.run.out    :   addr 00:AA:01:00:00:42 version 11=
 manufacturer 1521 class 0x000000
> 13:00:40 OUT    host.0.0.run.out    :   supported settings: powered conne=
ctable fast-connectable discoverable bondable link-security ssp br/edr le a=
dvertising secure-conn debug-keys privacy static-addr phy-configuration cis=
-central cis-peripheral iso-broadcaster sync-receiver ll-privacy past-sende=
r past-receiver
> 13:00:40 OUT    host.0.0.run.out    :   current settings: br/edr
> 13:00:40 OUT    host.0.0.run.out    :   name
> 13:00:40 OUT    host.0.0.run.out    :   short name
> 13:00:40 INFO   host.0.0.run        :  (return code 0)
> 13:00:40 DEBUG  rpc.host.0.0        :  client-reply
> PASSED                                                                   =
[100%]
> 13:00:40 OUT    host.0.0            :  qemu-system-x86_64: terminating on=
 signal 15 from pid 149047 (python3)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 p=
assed, 4 deselected in 8.84s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ unit/test-functional --kernel=3D../linux -k test_bluetoothctl_pair --lo=
g-cli-level=3D0 --log-filter=3D*.bluetoothctl,rpc.* --force-usb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> rootdir: /home/pauli/prj/external/bluez/unit
> configfile: pytest.ini
> plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdis=
t-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> collected 5 items / 4 deselected / 1 selected
>
> unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm2=
]
> -------------------------------- live log setup -------------------------=
-------
> 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib=
.host_plugins.Bdaddr object at 0x7f268712d160>,) {}
> 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib=
.host_plugins.Call object at 0x7f268712d2b0>,) {}
> 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib=
.host_plugins.DbusSystem object at 0x7f2687aa30e0>,) {}
> 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib=
.host_plugins.Bluetoothd object at 0x7f2687aa3230>,) {}
> 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.lib=
.host_plugins.Bluetoothctl object at 0x7f268712d010>,) {}
> 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib=
.host_plugins.Bdaddr object at 0x7f26871542d0>,) {}
> 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib=
.host_plugins.Call object at 0x7f2687154410>,) {}
> 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib=
.host_plugins.DbusSystem object at 0x7f2687aa30e0>,) {}
> 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib=
.host_plugins.Bluetoothd object at 0x7f2687aa3230>,) {}
> 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.lib=
.host_plugins.Bluetoothctl object at 0x7f2687154190>,) {}
> 13:03:20 INFO   rpc.host.0.0        :  client: wait_load () {}
> 13:03:21 DEBUG  rpc.host.0.0        :  client-reply
> 13:03:21 INFO   rpc.host.0.1        :  client: wait_load () {}
> 13:03:21 DEBUG  rpc.host.0.1        :  client-reply
> -------------------------------- live log call --------------------------=
-------
> 13:03:21 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl=
', 'send', 'show\n') {}
> 13:03:21 DEBUG  rpc.host.0.0        :  client-reply
> 13:03:21 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl=
', 'expect', 'Powered: yes') {}
> ...
> 13:03:23 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl=
', 'send', 'pair 70:1a:b8:73:99:bb\n') {}
> 13:03:23 OUT    host.0.0.bluetoothctl:  pair 70:1a:b8:73:99:bb
> 13:03:23 DEBUG  rpc.host.0.0        :  client-reply
> 13:03:23 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl=
', 'expect', 'Confirm passkey (\\d+).*:') {}
> 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> pair 70:1a:b8:73:=
99:bb
> 13:03:23 OUT    host.0.0.bluetoothctl:  Attempting to pair with 70:1A:B8:=
73:99:BB
> 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 device_flags=
_changed: 70:1A:B8:73:99:BB (BR/EDR)
> 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]>      supp: 0x0000=
0007  curr: 0x00000000
> 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 type 7 disco=
vering off
> 13:03:25 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 70:1A:B8:73:=
99:BB type BR/EDR connected eir_len 12
> 13:03:25 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> [BlueZ 5.86]> [CH=
G] Device 70:1A:B8:73:99:BB Connected: yes
> 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> Request confirmatio=
n
> 13:03:25 DEBUG  rpc.host.0.0        :  client-reply
> 13:03:25 INFO   rpc.host.0.1        :  client: call_plugin ('bluetoothctl=
', 'expect', 'Confirm passkey 237345') {}
> 13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> hci0 84:5C:F3:77:=
31:19 type BR/EDR connected eir_len 12
> 13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> [NEW] Device 84:5=
C:F3:77:31:19 BlueZ 5.86
> 13:03:25 DEBUG  rpc.host.0.1        :  client-reply
> 13:03:25 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl=
', 'send', 'yes\n') {}
> 13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> [BlueZ 5.86]> Req=
uest confirmation
> 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [agent] Confirm pas=
skey 237345 (yes/no): yes
> 13:03:25 DEBUG  rpc.host.0.0        :  client-reply
> 13:03:25 INFO   rpc.host.0.1        :  client: call_plugin ('bluetoothctl=
', 'send', 'yes\n') {}
> 13:03:25 OUT    host.0.1.bluetoothctl:  [BlueZ 5.86]> [agent] Confirm pas=
skey 237345 (yes/no): yes
> 13:03:25 DEBUG  rpc.host.0.1        :  client-reply
> 13:03:25 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothctl=
', 'expect', 'Pairing successful') {}
> 13:03:25 OUT    host.0.0.bluetoothctl:  yes
> 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> hci0 new_link_key 7=
0:1A:B8:73:99:BB type 0x08 pin_len 0 store_hint 1
> 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:=
B8:73:99:BB Bonded: yes
> 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:=
B8:73:99:BB AddressType: public
> 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:=
B8:73:99:BB UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
> 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:=
B8:73:99:BB UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
> 13:03:26 DEBUG  rpc.host.0.0        :  client-reply
> PASSED                                                                   =
[100%]
> ------------------------------ live log teardown ------------------------=
-------
> 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1A:=
B8:98:FF:qemu-system-x86_64: terminating on signal 15 from pid 149357 (pyth=
on3)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 p=
assed, 4 deselected in 13.22s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ COLUMNS=3D80 unit/test-functional -k test_btmgmt --kernel=3D../linux --=
trace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> rootdir: /home/pauli/prj/external/bluez/unit
> configfile: pytest.ini
> plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xdis=
t-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> collected 5 items / 4 deselected / 1 selected
>
> unit/func_test/test_btmgmt_vm.py
> >>>>>>>>>>>>>>>>>>>> PDB runcall (IO-capturing turned off) >>>>>>>>>>>>>>=
>>>>>>>
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(19)test=
_btmgmt_info()
> -> (host,) =3D hosts
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(21)test=
_btmgmt_info()
> -> result =3D host.call(
> (Pdb) p host.bdaddr
> '00:aa:01:00:00:42'
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(22)test=
_btmgmt_info()
> -> run,
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(23)test=
_btmgmt_info()
> -> [btmgmt, "--index", "0", "info"],
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(24)test=
_btmgmt_info()
> -> stdout=3Dsubprocess.PIPE,
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(25)test=
_btmgmt_info()
> -> stdin=3Dsubprocess.DEVNULL,
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(26)test=
_btmgmt_info()
> -> encoding=3D"utf-8",
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(21)test=
_btmgmt_info()
> -> result =3D host.call(
> (Pdb) n
> > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(28)test=
_btmgmt_info()
> -> assert result.returncode =3D=3D 0
> (Pdb) p result
> CompletedProcess(args=3D['/home/pauli/prj/external/bluez/build/tools/btmg=
mt', '--index', '0', 'info'], returncode=3D0, stdout=3D'hci0:\tPrimary cont=
roller\n\taddr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x00000=
0\n\tsupported settings: powered connectable fast-connectable discoverable =
bondable link-security ssp br/edr le advertising secure-conn debug-keys pri=
vacy static-addr phy-configuration cis-central cis-peripheral iso-broadcast=
er sync-receiver ll-privacy past-sender past-receiver \n\tcurrent settings:=
 br/edr \n\tname \n\tshort name \n')
> (Pdb) print(result.stdout)
> hci0:   Primary controller
>         addr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x00000=
0
>         supported settings: powered connectable fast-connectable discover=
able bondable link-security ssp br/edr le advertising secure-conn debug-key=
s privacy static-addr phy-configuration cis-central cis-peripheral iso-broa=
dcaster sync-receiver ll-privacy past-sender past-receiver
>         current settings: br/edr
>         name
>         short name
> (Pdb) q
>
> !!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Quitting debugger !!!!!!!!!!!!=
!!!!!!!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 4 d=
eselected in 75.91s (0:01:15) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> ***
>
> Pauli Virtanen (11):
>   emulator: btvirt: check pkt lengths, don't get stuck on malformed
>   emulator: btvirt: allow specifying where server unix sockets are made
>   test-runner: enable path argument for --unix
>   test-runner: Add -o/--option option
>   test-runner: allow source tree root for -k
>   doc: enable CONFIG_VIRTIO_CONSOLE in tester config
>   test-runner: use virtio-serial for implementing -u device forwarding
>   doc: add functional/integration testing documentation
>   unit: add functional/integration testing framework
>   unit: func_test: add Pipewire-using smoke tests
>   build: add functional testing target
>
>  Makefile.am                            |   7 +
>  configure.ac                           |  17 +
>  doc/ci.config                          |   1 +
>  doc/test-functional.rst                | 374 +++++++++++++++++++
>  doc/test-runner.rst                    |   1 +
>  doc/tester.config                      |   1 +
>  emulator/main.c                        |  37 +-
>  emulator/server.c                      |   9 +
>  tools/test-runner.c                    | 376 ++++++++++++++-----
>  unit/func_test/__init__.py             |   0
>  unit/func_test/conftest.py             | 277 ++++++++++++++
>  unit/func_test/lib/__init__.py         |   5 +
>  unit/func_test/lib/env.py              | 484 +++++++++++++++++++++++++
>  unit/func_test/lib/host_plugins.py     | 269 ++++++++++++++
>  unit/func_test/lib/rpc.py              | 293 +++++++++++++++
>  unit/func_test/lib/runner.py           |  10 +
>  unit/func_test/lib/tests/__init__.py   |   0
>  unit/func_test/lib/tests/test_rpc.py   |  49 +++
>  unit/func_test/lib/utils.py            | 266 ++++++++++++++
>  unit/func_test/requirements.txt        |   3 +
>  unit/func_test/test_bluetoothctl_vm.py |  76 ++++
>  unit/func_test/test_btmgmt_vm.py       |  29 ++
>  unit/func_test/test_pipewire.py        | 137 +++++++
>  unit/pytest.ini                        |   7 +
>  unit/test-functional                   |   8 +
>  25 files changed, 2631 insertions(+), 105 deletions(-)
>  create mode 100644 doc/test-functional.rst
>  create mode 100644 unit/func_test/__init__.py
>  create mode 100644 unit/func_test/conftest.py
>  create mode 100644 unit/func_test/lib/__init__.py
>  create mode 100644 unit/func_test/lib/env.py
>  create mode 100644 unit/func_test/lib/host_plugins.py
>  create mode 100644 unit/func_test/lib/rpc.py
>  create mode 100644 unit/func_test/lib/runner.py
>  create mode 100644 unit/func_test/lib/tests/__init__.py
>  create mode 100644 unit/func_test/lib/tests/test_rpc.py
>  create mode 100644 unit/func_test/lib/utils.py
>  create mode 100644 unit/func_test/requirements.txt
>  create mode 100644 unit/func_test/test_bluetoothctl_vm.py
>  create mode 100644 unit/func_test/test_btmgmt_vm.py
>  create mode 100644 unit/func_test/test_pipewire.py
>  create mode 100644 unit/pytest.ini
>  create mode 100755 unit/test-functional
>
> --
> 2.53.0

Looks like a fairly solid start, that said I wouldn't mix these with
unit test, that is more of a unit/whitebox style testing not really
meant for end-to-end testing, Id probably have this under
test/functional or test/pytest, anyway we could possibly remove the
existing python tests and just convert them, or perhaps move them to
examples since they are just demostrating how to use our D-Bus APIs
using python rather than testing a specific use-case, etc.

Regarding pytest, Im not really an expert in the python testing
frameworks so I will probably need to do some digging to see what are
the options and there might be companies that already emply similar
testing environment so I guess it is a good chance to make an attempt
to convince more people to contribute upstream so we can consolidate
in a single framework for end-to-end testing.

--=20
Luiz Augusto von Dentz
