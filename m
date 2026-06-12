Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2F364E84
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295200; cv=pass; b=ETH5jYzCuOYogW3mNtyF7BmQ421vd6FdQt1y7rAc7UHTjXWjoJka1YgMMyqu5ow0MUjeRg6kvmKMABBDyX0m+WXfN6d/GzmFwehDCt8ekdcew405OT7lNejVfaL8/07G/Qd1GRpkq9a1DhFx+q2+4BMdATabOsFWI/H9Bw90pnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295200; c=relaxed/simple;
	bh=mv2suXxwWHN3AytYG9nFhj1zhpnc9Qvy2NjUKvourxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuX34SI7A8uAAlgNYKdPSeXJg46NVYNp+Y4EK3vMNN8e2P+bdiZ3Oc7Uus0me7eBFA0NfAat7lMYC8gznWOIHGxLM3YV/EpWxgpZG3vvkhUb2TYDsspr4c6dRaeZZW7O3FvjN8gM+cI7yxCod2rRIYxYtkYKyR4g1Y07P9MQVco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzzsdMAc; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzzsdMAc"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dee6b76a73so14661767b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781295197; cv=none;
        d=google.com; s=arc-20240605;
        b=fRo6W5gjHsoXYntiDUuCoFRJFriHsWVdcAa1SLQBSDtW/Vi9d4UzCTtXr3VU6XjUTT
         kwSoJBgNC+iNNG2ERT8hJu1KG5zytB5PjcNnsbMuGAYPTCV5KIUCiAPrEozOx6yMV8jW
         wD1ac9vKiw403h3tIWBWeOSQGXnn8EiezWFMFNpB+G0MRZ3KqkgDKT5QwIqRR3JvbkzF
         YYZi1nDRlgzuYjOUkcgb7PWYX6TjExB8OiiYwhf3bjjSje91ldKx5Sho8F8ATwbCypzW
         wWf4EtnV3WzH907BrWnz3ZjKcNK0m2TK99nnKew5dVuDAzeM6gzVg9zKsFEyg4oKZnif
         KKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpCt+S6yj9lyeKqxynDuW2Kpmr9PKznwOheZwlTstZw=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=QQfBiaiyirt0mZmOaqYI0OU4a8mgZBeIcFaretO8hAItbV1/DthBQOTz/YgXe6KL8c
         ptDsIx2uRGX6u9YqTg4QV8Um/DeYHUvYjr5jDsDPCdfBfJwRCORBl+BN1xjqB5u+IFks
         bdtoJ6A6+rXliVIBv93G3PlwUFCqMzVM9zWCis6FUVXpngdoGy0Q2Vmhva/CZ5JjwlXd
         sxU5oCgT870NPnb8wjfMgG62KnQp7QVpOtqvEH+hk9tarY+bd4HnjnyT8IjuFciMcQ7D
         rpHmJKcH9kVz7wI1C9TluH/bxajzj/mcb4/12lOSVlBnSHkaKmb3AcyvoCkb8Yy8KcTf
         d1NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781295197; x=1781899997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpCt+S6yj9lyeKqxynDuW2Kpmr9PKznwOheZwlTstZw=;
        b=CzzsdMAcPo3yWn9jiUdRIY9OBNOCCHEo4s4Yzvu4d0BRE6fSv6mQtlY82ro/cil/+J
         tAwVR9uhM0Q5/1q5YsA+9OcG2uOnS5pjcbC15KRG5MP4VwyngV0yWUtxde1fKdM4w4lM
         ifb/SoDKUptzE43gkMQy+gjGU4EHzU64izrg4lbSMz9qpiY2xT3yEG3q84tN+nMbrvkK
         X6zshQZp6gkfB1PPfPlI4DoIkEKDHJ2HrPx8XH5kJDjPqiImCxgtqax7oQ/s603qbw8X
         QTrFRk92M2xPdg051TYLPp3N9NV11bejrvNsANzQ/KZj29Yo2aWxjtKU7T97q/iQh4c8
         UyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295197; x=1781899997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpCt+S6yj9lyeKqxynDuW2Kpmr9PKznwOheZwlTstZw=;
        b=UCCDgZcAx1+Nx8ZmtOvE6JsBDuTLM4Npn5zsc10NpUde8SRBcSeU+Ocg/EA6Ds9j2O
         S4JdZSisHwkPcoeKtm5AzEUneJ580cfi8XuPDzot6WKk7puU6vQ0wGAUB4PgMNcKJIEj
         UjBQ0QupZkravugza3g29gZGqpR9LZPlB4WY0NZylgkpPHjoaJ6LzhMGYWoHNVKuIt0O
         9do0uI5KNebbccZXiZD0M3wZGPiUycTd5M7ambPFMu95tKGN4K82p33MxsW7v5goCmi7
         hcwJTRZJGhXmrf2yXelMaODWv1Q5Uwz6jvqxKVSQUPDayUY2ulHkAjhiAu+B0aNJ0AP4
         WEZA==
X-Gm-Message-State: AOJu0Yw3PQZMxKhxgz1H0PkTtV476B9zRxGHr0Hf5s1ccqmV2puLbaMK
	I6004Ky+6U0UawMtXIn+Ok2ya3QcjcNVcHqV2/PoQ6puKJEFk85k61PxFfLGwqAqoxDfjonsxSQ
	321BlHiUwNZn82UpQlUpfaJiP2Bz9t4sc3G+n
X-Gm-Gg: Acq92OFZjUO+RmmmpuL6QCCnY7wHkDvb/BiLgHlDDUO7FrFHIVKmFfz5FQXQgtTDAsV
	rbFvmYCXB3d2PiKDP6RKXcS2cpulwLqXAEGJGYkHYqwCLf3NuhjTQVdRvrgo1Gj1rd50jQixTiz
	5zmjoai+g+7Qyu5xFiM6kVoWPw6KlsWov4QhtJn4/stMKmAbtAk8k2+7PZT2TWklfMBhoOBBxKy
	cDgQ1X8jaRdMaujneLEzWwm4q9dLBVmz6wScYTZp3ps0eWhI/E//olMGBfb6m3FLVE21yp0jSv3
	NfPrI9w8JcC+24Q0qksNQDwvE/aMcQFuJzgzDpOXrXSfpKgtmJAqnsBzbqiOhupDT9Sj1w==
X-Received: by 2002:a05:690c:2501:b0:7b2:513b:34d7 with SMTP id
 00721157ae682-7f7b7d30875mr41902757b3.29.1781295197166; Fri, 12 Jun 2026
 13:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778688966.git.pav@iki.fi>
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jun 2026 17:13:06 -0300
X-Gm-Features: AVVi8CctmeEA7qbfREqGHizRmHKd5RNMi8PjM0nzSkVn8qXpSj12qaygil2flTc
Message-ID: <CABBYNZLBeuYHTNaBAkX_KC06rrQMMZn_Ks0sz2KQPTLpga5Lrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 00/16] Functional/integration testing
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, May 13, 2026 at 1:35=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add framework for writing tests simulating "real" environments where
> BlueZ and other parts of the stack run on different virtual machine
> hosts that communicate with each other.
>
> *** v5 ***
>
> https://github.com/pv/bluez/compare/func-test-v4-r..func-test-v5
>
> * Factor out the pytest-bluezenv plugin, to be maintained separately.
>   https://pypi.org/project/pytest-bluezenv/
>
>   It could in principle be moved under the BlueZ organization, but
>   there's no particular reason why it should be in bluez repository.
>
>   Generally, it's better to have the pytest plugin separate so it's
>   easier to reuse and can have its own version cycle.
>
> * Pipewire tests are moved to pipewire repository where they probably
>   belong to.
>
>   They can be run easily vs. given BlueZ build dir.
>
>   We are currently running them in Pipewire CI, but at frozen
>   kernel/BlueZ version, so it is not testing BlueZ/kernel upstream
>   development.
>
> * No changes in the emulator/test-runner patches since v4
>
>   They are stand-alone bug fixes / improvements, and make sense
>   also separately from the rest.
>
> *** v4 ***
>
> https://github.com/pv/bluez/compare/func-test-v3-r..func-test-v4
>
> * Use virtconsole for simpler HCI forwarding to the vm
>
> * Fix typoed vm_module -> vm_once
>
> * Skip tests for some pipewire versions
>
> *** v3 ***
>
> https://github.com/pv/bluez/compare/func-test-v2-r..func-test-v3
>
> * fix configure.ac openpty() detection to match TOOLS conditional,
>   to fix make distcheck
>
> * properly retry virtio RPC connection if it fails initially
>
> * properly restart VM if previous test hangs
>
> * allow custom parent host side proxy objects, use them for pexpect
>
> * improve --list with out-of-tree test files
>
> * fix missing bus.set_exit_on_disconnect(False) for obex tests
>
> * have --vm-timeout etc. change values also on VM host side
>
> * use larger-memory VM instances for Pipewire, in case ASAN enabled
>
> * set reasonable inside-VM ASAN_OPTION default values
>
> * don't run btvirt under stdbuf, since not compatible with ASAN
>
> *** v2 ***
>
> https://github.com/pv/bluez/compare/func-test-v1-r..func-test-v2
>
> * move unit/func_test -> test/functional & test/pytest_bluez
>
>   The pytest_bluez plugin is in principle reusable for other projects,
>   so we can eg. have more complete Pipewire integration tests that can
>   live in Pipewire repository.
>
> * openpty() is in -lutil on some platforms, detect this in autoconf
>
> * more emulator adjustments:
>
>   - fix SCO data packet support in btvirt
>   - more complete Reset command
>
> * improve logging: get timestamps from kernel, and reorder logs
>   to timestamp order, so that lines from different hosts, btmon,
>   and parent tester appear in right order regardless of whether
>   VM console / btmon is lagging
>
>   - this requires accurate clock sync in the VM, so enable KVM PTP in
>     config and run chronyd inside the VMs
>   - use virtio port instead of qemu console to export logs, since the
>     console has fixed baud rate and is too slow
>
> * add --btmon & export btsnoop dumps from VM hosts
>
> * fix compatibility with older Python versions
>
> * add parametrized_host_config()
>
> * split Pipewire test to A2DP/BAP/HFP and really stream audio.
>   These catch the 5.86 regression fixed in 066a164a524e498 and
>   the 5.84 one in 6b0a08776a
>
> * add support for tests that reuse tester environment, so they can run
>   faster without needing Bluetoothd teardown/setup in between
>
> * add HostPlugin.presetup (mainly for test skipping)
>
> * deal with RPC virtio port buffer possibly containing unflushed
>   commands from previous failed test
>
> * add some Agent1 interface tests
>
> * add basic Obex file transfer tests
>
> * add support for logging in to a running test instance (for gdb etc)
>
> * export any core dumps out from test environ
>
> Some bells & whistles:
>
> * add --kernel-build for kernel image build
>
> * test suite Python code formatting checks
>
> ***
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
> Also test/functional/test_bluetoothctl_vm.py has some simple cases, and
> test/functional/test_pipewire.py for a more complicated setup
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
> $ test/test-functional --list -q
>
> test/functional/lib/tests/test_rpc.py::test_basic
> test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm=
2]
> test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[ho=
sts1-vm1]
> test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> test/functional/test_pipewire.py::test_pipewire[hosts3-vm2]
>
> $ test/test-functional -v --no-header
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> collected 5 items
>
> test/functional/lib/tests/test_rpc.py::test_basic PASSED                 =
                     [ 20%]
> test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[ho=
sts1-vm1] SKIPPED    [ 40%]
> test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1] SKIPPED (=
No kernel image)     [ 60%]
> test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm=
2] SKIPPED (No k...) [ 80%]
> test/functional/test_pipewire.py::test_pipewire[hosts3-vm2] SKIPPED (No k=
ernel image)         [100%]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 passed, 4 skipped in 0.19s =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> $ test/test-functional --kernel=3D../linux
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
> test/functional/lib/tests/test_rpc.py .                                  =
 [ 20%]
> test/functional/test_bluetoothctl_vm.py .                                =
 [ 40%]
> test/functional/test_btmgmt_vm.py .                                      =
 [ 60%]
> test/functional/test_bluetoothctl_vm.py .                                =
 [ 80%]
> test/functional/test_pipewire.py .                                       =
 [100%]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D 5 passed in 41.92s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ test/test-functional --kernel=3D../linux -k test_btmgmt
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
> test/functional/test_btmgmt_vm.py .                                      =
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
> $ test/test-functional --kernel=3D../linux -k test_btmgmt --log-cli-level=
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
> test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
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
uli/prj/external/bluez/test/functional/lib/runner.py /dev/ttyS2
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
> $ test/test-functional --kernel=3D../linux -k test_bluetoothctl_pair --lo=
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
> test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-vm=
2]
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
> $ test/test-functional -k test_btmgmt --kernel=3D../linux --trace
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
> test/functional/test_btmgmt_vm.py
> >>>>>>>>>>>>>>>>>>>> PDB runcall (IO-capturing turned off) >>>>>>>>>>>>>>=
>>>>>>>
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(19)tes=
t_btmgmt_info()
> -> (host,) =3D hosts
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(21)tes=
t_btmgmt_info()
> -> result =3D host.call(
> (Pdb) p host.bdaddr
> '00:aa:01:00:00:42'
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(22)tes=
t_btmgmt_info()
> -> run,
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(23)tes=
t_btmgmt_info()
> -> [btmgmt, "--index", "0", "info"],
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(24)tes=
t_btmgmt_info()
> -> stdout=3Dsubprocess.PIPE,
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(25)tes=
t_btmgmt_info()
> -> stdin=3Dsubprocess.DEVNULL,
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(26)tes=
t_btmgmt_info()
> -> encoding=3D"utf-8",
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(21)tes=
t_btmgmt_info()
> -> result =3D host.call(
> (Pdb) n
> > /home/pauli/prj/external/bluez/test/functional/test_btmgmt_vm.py(28)tes=
t_btmgmt_info()
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
> Pauli Virtanen (16):
>   emulator: btvirt: check pkt lengths, don't get stuck on malformed
>   emulator: btvirt: allow specifying where server unix sockets are made
>   emulator: btvirt: support SCO data packets
>   emulator: btdev: clear more state on Reset
>   test-runner: enable path argument for --unix
>   test-runner: Add -o/--option option
>   test-runner: allow source tree root for -k
>   test-runner: use virtio-serial for implementing -u device forwarding
>   doc: enable CONFIG_VIRTIO_CONSOLE in tester config
>   doc: enable KVM paravirtualization & clock support in tester kernel
>     config
>   doc: add functional/integration testing documentation
>   test: add functional/integration testing framework
>   build: add functional testing target
>   test: functional: impose Python code formatting
>   test: functional: add some Agent1 interface tests
>   test: functional: add basic obex file transfer tests
>
>  Makefile.am                             |  10 +
>  configure.ac                            |  22 ++
>  doc/ci.config                           |   9 +
>  doc/test-functional.rst                 | 299 ++++++++++++++++++++++++
>  doc/test-runner.rst                     |  17 ++
>  doc/tester.config                       |   9 +
>  emulator/btdev.c                        | 117 ++++++----
>  emulator/main.c                         |  37 +--
>  emulator/server.c                       |  21 ++
>  test/functional/__init__.py             |   2 +
>  test/functional/conftest.py             |  48 ++++
>  test/functional/requirements.txt        |   2 +
>  test/functional/test_agent.py           |  46 ++++
>  test/functional/test_bluetoothctl_vm.py | 152 ++++++++++++
>  test/functional/test_btmgmt_vm.py       |  30 +++
>  test/functional/test_obex.py            | 285 ++++++++++++++++++++++
>  test/functional/test_tests.py           |  23 ++
>  test/pytest.ini                         |  17 ++
>  test/test-functional                    |  21 ++
>  test/test-functional-attach             |   7 +
>  tools/test-runner.c                     |  89 ++++---
>  21 files changed, 1177 insertions(+), 86 deletions(-)
>  create mode 100644 doc/test-functional.rst
>  create mode 100644 test/functional/__init__.py
>  create mode 100644 test/functional/conftest.py
>  create mode 100644 test/functional/requirements.txt
>  create mode 100644 test/functional/test_agent.py
>  create mode 100644 test/functional/test_bluetoothctl_vm.py
>  create mode 100644 test/functional/test_btmgmt_vm.py
>  create mode 100644 test/functional/test_obex.py
>  create mode 100644 test/functional/test_tests.py
>  create mode 100644 test/pytest.ini
>  create mode 100755 test/test-functional
>  create mode 100755 test/test-functional-attach
>
> --
> 2.54.0

Do you mind resending the remaining changes? I'd like to see how it
works; it seems you've already integrated with things like `make
check`, right?

--=20
Luiz Augusto von Dentz
