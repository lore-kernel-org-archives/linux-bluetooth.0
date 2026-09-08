Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8B57268F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889749; cv=pass; b=Gt/ZxwFewZJ+dbe4zDwK+FKwmFZkmKkEZXB3837NR2EKDoMr07EUbDofC/+rzTZycEgLj2RBweHb8MCeEqzTOpU+OryFPM70B+8y3dVaer2CCNl2D8YLlSWqBEvO1lZtOKlf+N03CFWW6eGBodY+W2D4wxXwpK/IOCQC3X4ijEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889749; c=relaxed/simple;
	bh=QvKcsJZMfzdiqp6rREAMJtehN3Dy1bxClR1B7gs9wIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOxAmg9sWjDg3oc1BE2Zh6xjwWVJZBa3jdxdE6ofYqKg5IpctNAX7t89irvXD/pxUPFdTjXO9E8De0tEO0z8pu5VCRn/IBEoRmOSAeEVCWh6nBhjKR46bSIthpLBwlAJMTlx40a8fS2YqRMebtY7dtQh31XyFeKLlKCTaQG/+lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC1U2vlj; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC1U2vlj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-855c26cf490so35907017b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 10:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788889746; cv=none;
        d=google.com; s=arc-20260327;
        b=c9EOkZYSNC7uyFvcKak5zBqKQgEfWIXlifyoGsY1txD9bt5wShGYUSaEvYOOYo2DU1
         k14TvPvDYLw3JmkvxLvxHlf/tm16CSdlrX2uOANH5Pn6O7Sx5ST9IVvn9V7cMTz3YAT5
         4QC6Ugh3p1TIovvtcXd7M6GVAyNnqIRmlgn4m8rsZs+IEHoH0rX+FPLsLeoqcqyxW32h
         T45wCehaatn7kZciaq/8jdUj0j5NKDi1Beb8mKK0GBYKghVzxX1txl3rUsg2L3VhmHI6
         g/p6d68AM7LhfC3XxHQW5Rgm1aScxqkJr6lfjWB4GlSMvqGSFbYtekMJw7xX8Wx/J33q
         TU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gjh+fudtnf3ic4pfKHp0I+Dx7mXz9NWOnEWBh++w5rk=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=HitUUYwrZ8Wk6ik2j05DQ5pNIkJZkFsnis2JWHr9HeJKdrk8fh0f2YJ7gb2fRF1aGM
         1uXiVN9ELMS++IxZQqKG9VFrp0h6m6ycNjCc6ZpftLcMBc646WsnyuFI8PwYfeNzYHq6
         oFYJuwatMhTXMmXwmEWsrXuvVliCwsnKqezkdShhzlVc6geiCms7FWWxpSL5m/bF9GZw
         RUQZ6XZBuMzLIORxRdBmttLlQtuuIBeh7uqGezPaogjaDL0LfO/eNo3tlNWJDtcAD5SJ
         leWMm3t55H2wPgf9wLa5bh8UeRlrbx2TutqAHK3YMGGNDUNjFmq6IMNQQzHjFuS4z7LJ
         a+zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889746; x=1789494546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gjh+fudtnf3ic4pfKHp0I+Dx7mXz9NWOnEWBh++w5rk=;
        b=LC1U2vljEKJrokqd41eaifgyG8AGQX6MKdWUwzw/CYyNf7PDXKI6FrihOACnHrnDdY
         UnVKf3c7FJf74/JD8P3R71UKmmvUi063qNYEZXCdWPkFPhmL1kblF10b7Xm2DU6mWKji
         gM3QjyEs90BYqEIZrqZJaoUOZ7PiCX9AVkQEyfaTO30MCuqRTKWDDTa96H7UWIaUH46c
         X0qdoXz2DfUMC9N44UudIbyZBOOIge4g/8DS77EpYu3d70iFLsX0k/CFNdUiHcHlxIDx
         uJRHHGvVCH0XfxAqy8lFLqZP3+bnHeN0ZK9zINeeanyAiROqvJ9ooqQn4kIJWBppa+yR
         EhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889746; x=1789494546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gjh+fudtnf3ic4pfKHp0I+Dx7mXz9NWOnEWBh++w5rk=;
        b=W2gUwPx4/oLR7nn1+HlwdJuASTV8tYQ057YWBG/69Q2xT13DAVyolXuv56BSHZFCrt
         UihDiuEKhUmtZER4oail7BmekBZHkvfTgjUAmaUFmW/bQLHj5/1wntS+iABgeD2Oaivl
         fChnX+svj4yCEN1Gex8K//NQ2hDT2NVwFbXGqX5Q4egDPztWMy9OrmktcPi4rzN5Ms4D
         7ZFcSkabSXU1M0ceLougfoFwtk8UgbpeAopLKutYfBwPxeYTLw9rji3F/NEoYlcIg5IA
         CzvnDz2G/ND4aUsS3ZcWvqVQn8HE3PT94CqbWJx8UtP11OTFJKZ7tVb57DYgH4x5pc/r
         4ePw==
X-Gm-Message-State: AFuF++nTZZphmDlyWwUa1HFVcJuUJL+qgsH0+im8wgPCWd5QQ8umv+FD
	HYAekLStT1DmlMK3NjcUqApRGRTMn2DrfkPLN/FVQQcc3kbZS9eDSYw5MDif/YNFCFI3QEo2oO+
	KnhJBcURvxIgk54ZqpMYW9R5qOaUAiAeiNNpzvIywJg==
X-Gm-Gg: AYBFou1sO3PqKUcAQf10yyjTNihdHCTSq1bCBmdJ694Jf7GPLi2Ous/2ugaUOmQIvbk
	NSyRxERU5WN9J/iUgGrhunnGup9IH46VPKwBxQYGA069pymiiHWHjgUx2FdiewDu8Sf/DFJQc6J
	QbK+f/UtxOls7nSgFF67oa4npBXTDDpXhvR1ZNWDlRnthxFawSIa8fISrU1XwxzzNISkm4PTTVg
	bIDabCHP13ts/kZuwmgVjJ01lN4tHc9AIjK0JuPeUnM8p2llyr5mTp3vEOCqzeJFuoqMv6nQp7/
	Gw8zt3zq3dsw876uXKYEeQUcjmNMTdiS3/prCLtG4L2cqCOyaY7GriMFAlNk7A8X7zRMA7XtYPg
	ZbYOj//wGRhoYEwrpF2d6xp7+Ch1j5+0=
X-Received: by 2002:a05:690c:d8a:b0:81e:fe1c:2de8 with SMTP id
 00721157ae682-8712259efb1mr128529567b3.3.1788889745929; Tue, 08 Sep 2026
 10:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788712996.git.pav@iki.fi>
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 13:48:54 -0400
X-Gm-Features: AcwNN1UtODTar-a3eWw6OlvRSvZyKgFs8TmE_7j3gsFcGFLMm4v6-5DOATAIiMQ
Message-ID: <CABBYNZLjfcz1SYo=0gAn6jz8hhOa2AKUs-OtTsUAz1YB=CbO-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Sep 6, 2026 at 12:50=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add framework for writing tests simulating "real" environments where
> BlueZ and other parts of the stack run on different virtual machine
> hosts that communicate with each other.
>
> *** v7 ***
>
> * Bump to pytest-bluezenv=3D=3D0.1.9 (better core dump / oops reporting)
>
> * Add test/functional/test_adv_monitor.py (one crash POC test)
>
> * Add test/functional/test_avrcp.py (one crash POC test)
>
>   Note that current bluez master branch does not pass this one,
>   it is fixed by
>   https://patchwork.kernel.org/project/bluetooth/patch/20260901175315.134=
8621-1-luiz.dentz@gmail.com/
>
> * Add test/functional/test_kernel_testers.py (runs tools/*-tester)
>
> * Bump VMs to 400M memory, ASAN builds on Ubuntu need it
>
> * Make tests fail on core dump / kernel bug
>
> *** v6 ***
>
> * Fix minor issues in documentation and shellcheck warnings.
>
> * Bump to latest pytest-bluezenv=3D=3D0.1.6
>
> * NOTE: hci_uart is partly broken in current bluetooth-next / 7.1 kernel,
>   which causes some of the tests here fail sporadically. Needs the follow=
ing patch:
>
>   https://lore.kernel.org/linux-bluetooth/6888691461070a011d31632e6dcbfd7=
3016dcc6e.1781364475.git.pav@iki.fi/
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
> Pauli Virtanen (9):
>   doc: add functional/integration testing documentation
>   test: add functional/integration testing framework
>   build: add functional testing target
>   test: functional: impose Python code formatting
>   test: functional: add some Agent1 interface tests
>   test: functional: add basic obex file transfer tests
>   test: functional: add tests running the various kernel testers
>   test: functional: add test for adv_monitor crash
>   test: functional: add test for AVRCP crash
>
>  Makefile.am                            |  10 +
>  configure.ac                           |  22 ++
>  doc/test-functional.rst                | 331 +++++++++++++++++++++++++
>  test/functional/__init__.py            |   2 +
>  test/functional/conftest.py            |  76 ++++++
>  test/functional/requirements.txt       |   3 +
>  test/functional/test_adv_monitor.py    | 123 +++++++++
>  test/functional/test_agent.py          |  47 ++++
>  test/functional/test_avrcp.py          | 281 +++++++++++++++++++++
>  test/functional/test_bluetoothctl.py   | 161 ++++++++++++
>  test/functional/test_btmgmt.py         |  34 +++
>  test/functional/test_kernel_testers.py | 178 +++++++++++++
>  test/functional/test_obex.py           | 275 ++++++++++++++++++++
>  test/functional/test_tests.py          |  24 ++
>  test/pytest.ini                        |  25 ++
>  test/test-functional                   |  21 ++
>  test/test-functional-attach            |   7 +
>  17 files changed, 1620 insertions(+)
>  create mode 100644 doc/test-functional.rst
>  create mode 100644 test/functional/__init__.py
>  create mode 100644 test/functional/conftest.py
>  create mode 100644 test/functional/requirements.txt
>  create mode 100644 test/functional/test_adv_monitor.py
>  create mode 100644 test/functional/test_agent.py
>  create mode 100644 test/functional/test_avrcp.py
>  create mode 100644 test/functional/test_bluetoothctl.py
>  create mode 100644 test/functional/test_btmgmt.py
>  create mode 100644 test/functional/test_kernel_testers.py
>  create mode 100644 test/functional/test_obex.py
>  create mode 100644 test/functional/test_tests.py
>  create mode 100644 test/pytest.ini
>  create mode 100755 test/test-functional
>  create mode 100755 test/test-functional-attach
>
> --
> 2.55.0

It took me some time to figure out how to pass the kernel to
bootstrap-configure/configure, perhaps we should update the
documentation regarding make check-functional and make check:

 > bootstrap-configure --enable-functional-testing=3D/pathto/bzImage

After this, there still seem to be some errors, I guess the kernel
testers we should consider the tests unstable until we fix them all or
perhaps we should skip them for make check[-functional] because they
are really kernel testers not bluetoothd, but it also fails with the
new AVRCP test:

test/functional/test_tests.py::test_formatting PASSED

          [  3%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-m=
gmt-tester]
XFAIL (Read Exp Feature - Success)                               [
7%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-s=
mp-tester]
PASSED                                                            [
11%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-l=
2cap-tester]
PASSED                                                          [ 14%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-r=
fcomm-tester]
PASSED                                                         [ 18%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-r=
fcomm-tester]
ERROR                                                          [ 18%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-s=
co-tester]
PASSED                                                            [
22%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-i=
so-tester]
PASSED                                                            [
25%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-m=
esh-tester]
XFAIL (Mesh - Send cancel - 1, Mesh - Send cancel - 2)           [
29%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-i=
octl-tester]
PASSED                                                          [ 33%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-b=
nep-tester]
PASSED                                                           [
37%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-u=
serchan-tester]
PASSED                                                       [ 40%]
test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc-6=
lowpan-tester]
FAILED                                                        [ 44%]
test/functional/test_kernel_testers.py::test_kernel_selftest[hosts7-vm1-noc=
]
SKIPPED (CONFIG_BT_SELFTEST not enabled)
    [ 48%]
test/functional/test_adv_monitor.py::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[h=
osts0-vm1]
PASSED                                                            [
51%]
test/functional/test_bluetoothctl.py::test_bluetoothctl_show[hosts3-vm1]
PASSED
        [ 55%]
test/functional/test_bluetoothctl.py::test_bluetoothctl_list[hosts3-vm1]
PASSED
        [ 59%]
test/functional/test_bluetoothctl.py::test_bluetoothctl_script_show[hosts3-=
vm1]
PASSED
 [ 62%]
test/functional/test_bluetoothctl.py::test_bluetoothctl_script_list[hosts3-=
vm1]
PASSED
 [ 66%]
test/functional/test_btmgmt.py::test_btmgmt_info[hosts6-vm1] PASSED

          [ 70%]
test/functional/test_agent.py::test_agent_pair_bredr[accept-hosts1-vm2]
PASSED
         [ 74%]
test/functional/test_agent.py::test_agent_pair_bredr[reject-hosts1-vm2]
PASSED
         [ 77%]
test/functional/test_avrcp.py::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts2-vm2]
FAILED
       [ 81%]
test/functional/test_avrcp.py::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts2-vm2]
ERROR
       [ 81%]
test/functional/test_bluetoothctl.py::test_bluetoothctl_pair_bredr[hosts4-v=
m2]
PASSED
  [ 85%]
test/functional/test_bluetoothctl.py::test_bluetoothctl_pair_le[hosts5-vm2]
PASSED
     [ 88%]
test/functional/test_obex.py::test_obex_ftp_list[hosts8-vm2] PASSED

          [ 92%]
test/functional/test_obex.py::test_obex_ftp_get[hosts8-vm2] PASSED

          [ 96%]
test/functional/test_obex.py::test_obexctl_list[hosts8-vm2] PASSED

          [100%]



--=20
Luiz Augusto von Dentz
