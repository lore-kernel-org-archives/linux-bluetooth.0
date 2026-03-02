Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6202D3EE5
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494650; cv=pass; b=d5mtIX7oFDsHdpbyZAeIuS9elzbBAtd2vKSMjkMNhY2ue08uRb6CANXIEX8dwIWO1I3+jXms6GOdLj/Vb17utX9PSHoHJBq/LIs+/eDic7NjlfVcqD27IjeEZ89T7ig2MXyW0H6AJCfFEAm5Q4fwUSLBT4VrXX0ZECKNAKp11IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494650; c=relaxed/simple;
	bh=Fb21J360IK6Qth0QjuIxzN+pnXcTH8HsC3/0Kn9T1eI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsdOTl9KejVZb30/40cchTQHZTuOmRI52aJoaLWiiwM1cryH1QuMu3JsLMSqI6ZXvCTiwpC8qFGWLcv1vE1dt0EthcTDoHF0KeeU38LPytW+vjdyxJh/BZjel2GrgwPsa/+yEmyPIziL6FrGKJE/nNfyfgDrz2R/DR1vROCH9aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ri269KQE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ri269KQE"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fPwMR4Yj1z49Pvh;
	Tue, 03 Mar 2026 01:37:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772494644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTDaZSB0kb3FGtxiJy3qGBuuw/ZFOr360jRiSNB357k=;
	b=ri269KQEIR/qVBjyJ4mrN9c8otYdtebKVSlSmhV7SVhaeR3vgTulhl83g+tQwQ/E4QATKR
	oY/fChh0jdEo7BSjKMlVtWYNAi22sQLAvOvIlyGUbwGuNNYgOxcZmL5cU27R79UJkGV78O
	96SX/LW9jkJys+pQlMU4UiVoDz+NpnZG3Xd+EZ9HI/LqtvyQaflHOHA58/gl4zapl4Esut
	4qH+0s47cuAwG1C8b6xIDlYtVmY6Bj8tCpFSSmcgS99f6bLYjkSDguSXl0qeR99tdsyWnL
	SrSShl34jSnsMXzORwMOx3aAqIJxQO6mMsFxlE5m83MDBab8fVciNi9cJEpIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1772494644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTDaZSB0kb3FGtxiJy3qGBuuw/ZFOr360jRiSNB357k=;
	b=Bce6mFL9eqn58elzVY8JUFm3z3Tcl4pNJGb8WVyofW7heXp4UIOMACwM/q5bof/Noo57GK
	p8O02Ng7yBBNb8cY0498MBK1mlAerjJt/RoSK/bawDU6/2fSlWuYjbF7zEIzUzUb3YYopd
	aosT0AZzN8YFtGWzTRdKNxcQ711AdlcPNQ/RMzdeB4/WmnZL0vxg1NPUIgA1lDZfigV0YA
	RR2/3NnNFrYmXDD5nE9O07CIdkjAofRn+/CEZUqh+JUb4F6Svi6zpZ9MExyIgNw3gJhCT7
	WO8OW4vs4ZQvLJYZ1PHCdJDjL42bxzQaan/2XD9iCxvt8OHPpmekhkXgrJJG9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1772494644;
	b=fvM96pfo/SQYqaT26skg0FxW3nVTz9FXrmaONXp3fkXMm/3RsnRcDyIyboZLljEFJpLsCJ
	v6EwyhQKw1fhxPlgXKpsjE5FOq03bhEwQZ+Pb8+RfMjUNr8YNKJakCI2pTYA/emIzWEUF1
	qIppCa+VJpBZid+h6XuQMPgDhYgFlRGyXT2qqQX1DZBoy6hBgQSmBK/lQyerNucfRaw8te
	IDPMzdLox8Zqk+n8/cU70oLAnCsa2V1Fvi5iQ3BoGMJs9XE3Bw5uqb2EKTXfl0VxqTCmru
	QiicVdz6jm47CwIbd9rS1cO61ir/2R5+CQZ7RFBaZ4S+z0C9EA0wJZgNlS8aHQ==
Message-ID: <65ef3e6907aed8d158156e94b4ce9600577c02b1.camel@iki.fi>
Subject: Re: [PATCH BlueZ 00/11] Functional/integration testing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 03 Mar 2026 01:37:21 +0200
In-Reply-To: <CABBYNZ+ski877E=t05=boS=Pc9qLp4FDM8xgQoc0E+Z=o48-Qg@mail.gmail.com>
References: <cover.1772282574.git.pav@iki.fi>
	 <CABBYNZ+ski877E=t05=boS=Pc9qLp4FDM8xgQoc0E+Z=o48-Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-03-02 kello 16:18 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sat, Feb 28, 2026 at 7:52=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add framework for writing tests simulating "real" environments where
> > BlueZ and other parts of the stack run on different virtual machine
> > hosts that communicate with each other.
> >=20
> > Implements:
> >=20
> > - RPC communication with tester instances running each of the VM hosts.
> >   Tests run on parent host, which instructs VM hosts what to do.
> >=20
> > - Extensible way to add stateful test-specific code inside the VM
> >   instances
> >=20
> > - Logging control: output from different processes running inside the V=
M
> >   are separated and can be filtered.
> >=20
> > - Test runner framework with Pytest (more convenient than Python/unitte=
st)
> >=20
> > - Automatic grouping of tests to minimize VM reboots
> >=20
> > - Redirecting USB controllers to use for testing in addition to btvirt
> >=20
> > - Fairly straightforward, ~1600 sloc for the framework
> >=20
> > There is no requirement that the tests spawn VM instances, the test
> > runner can be used for any tests written in Python.
> >=20
> > See doc/test-functional.rst for various examples.
> >=20
> > Also unit/func_test/test_bluetoothctl_vm.py has some simple cases, and
> > unit/func_test/test_pipewire.py for a more complicated setup
> >=20
> >     host0(qemu): Pipewire <-> BlueZ <-> kernel
> >     <-> btvirt
> >     host1(qemu): kernel <-> BlueZ <-> Pipewire
> >=20
> > The framework allows easily passing any data and code between the paren=
t
> > and VM hosts, so writing tests is straightforward.
> >=20
> > ***
> >=20
> > Some examples:
> >=20
> > $ unit/test-functional --list -q
> >=20
> > unit/func_test/lib/tests/test_rpc.py::test_basic
> > unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-v=
m2]
> > unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[h=
osts1-vm1]
> > unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> > unit/func_test/test_pipewire.py::test_pipewire[hosts3-vm2]
> >=20
> > $ unit/test-functional -v --no-header
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test session starts =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > collected 5 items
> >=20
> > unit/func_test/lib/tests/test_rpc.py::test_basic PASSED                =
                      [ 20%]
> > unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[h=
osts1-vm1] SKIPPED    [ 40%]
> > unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1] SKIPPED =
(No kernel image)     [ 60%]
> > unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-v=
m2] SKIPPED (No k...) [ 80%]
> > unit/func_test/test_pipewire.py::test_pipewire[hosts3-vm2] SKIPPED (No =
kernel image)         [100%]
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 passed, 4 skipped in 0.19s =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >=20
> > $ unit/test-functional --kernel=3D../linux
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > rootdir: /home/pauli/prj/external/bluez/unit
> > configfile: pytest.ini
> > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xd=
ist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > collected 5 items
> >=20
> > unit/func_test/lib/tests/test_rpc.py .                                 =
  [ 20%]
> > unit/func_test/test_bluetoothctl_vm.py .                               =
  [ 40%]
> > unit/func_test/test_btmgmt_vm.py .                                     =
  [ 60%]
> > unit/func_test/test_bluetoothctl_vm.py .                               =
  [ 80%]
> > unit/func_test/test_pipewire.py .                                      =
  [100%]
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D 5 passed in 41.92s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > $ unit/test-functional --kernel=3D../linux -k test_btmgmt
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > rootdir: /home/pauli/prj/external/bluez/unit
> > configfile: pytest.ini
> > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xd=
ist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > collected 5 items / 4 deselected / 1 selected
> >=20
> > unit/func_test/test_btmgmt_vm.py .                                     =
  [100%]
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1=
 passed, 4 deselected in 9.15s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > $ grep btmgmt test-functional.log
> > 13:15:42 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__=
call__', <function run at 0x7f27b81ce140>, ['/home/pauli/prj/external/bluez=
/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, =
'encoding': 'utf-8'}
> > 13:15:42 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__=
call__', <function run at 0x7fd5e35a1010>, ['/home/pauli/prj/external/bluez=
/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, =
'encoding': 'utf-8'}
> > 13:15:42 INFO   host.0.0.run        :      $ /home/pauli/prj/external/b=
luez/build/tools/btmgmt --index 0 info
> >=20
> > $ unit/test-functional --kernel=3D../linux -k test_btmgmt --log-cli-lev=
el=3D0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > rootdir: /home/pauli/prj/external/bluez/unit
> > configfile: pytest.ini
> > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xd=
ist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > collected 5 items / 4 deselected / 1 selected
> >=20
> > unit/func_test/test_btmgmt_vm.py::test_btmgmt_info[hosts2-vm1]
> > -------------------------------- live log setup -----------------------=
---------
> > 13:00:31 INFO   func_test.lib.env   :  Starting btvirt: /usr/bin/stdbuf=
 -o L -e L /home/pauli/prj/external/bluez/build/emulator/btvirt --server=3D=
/tmp/bluez-func-test-8t6ychy8
> > 13:00:31 OUT    btvirt              :  Bluetooth emulator ver 5.86
> > 13:00:31 INFO   func_test.lib.env   :  Starting host: /home/pauli/prj/e=
xternal/bluez/build/tools/test-runner --kernel=3D../linux/arch/x86/boot/bzI=
mage -u/tmp/bluez-func-test-8t6ychy8/bt-server-bredrle -o -chardev -o socke=
t,id=3Dser0,path=3D/tmp/bluez-func-test-8t6ychy8/bluez-func-test-rpc-0,serv=
er=3Don,wait=3Doff -o -device -o virtio-serial -o -device -o virtserialport=
,chardev=3Dser0,name=3Dbluez-func-test-rpc -H -- /usr/bin/python3 -P /home/=
pauli/prj/external/bluez/unit/func_test/lib/runner.py /dev/ttyS2
> > 13:00:31 OUT    btvirt              :  Request for /tmp/bluez-func-test=
-8t6ychy8/bt-server-bredrle
> > 13:00:32 OUT    host.0.0            :  early console in extract_kernel
> > 13:00:32 OUT    host.0.0            :  input_data: 0x000000000425c2c4
> > ...
> > 13:00:39 INFO   rpc.host.0.0        :  client: call_plugin ('call', '__=
call__', <function run at 0x7f7547472140>, ['/home/pauli/prj/external/bluez=
/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, =
'encoding': 'utf-8'}
> > 13:00:39 DEBUG  host.0.0.rpc        :  server: done
> > 13:00:39 INFO   host.0.0.rpc        :  server: call_plugin ('call', '__=
call__', <function run at 0x7f77dcc81010>, ['/home/pauli/prj/external/bluez=
/build/tools/btmgmt', '--index', '0', 'info']) {'stdout': -1, 'stdin': -3, =
'encoding': 'utf-8'}
> > 13:00:39 INFO   host.0.0.run        :      $ /home/pauli/prj/external/b=
luez/build/tools/btmgmt --index 0 info
> > 13:00:40 OUT    host.0.0.run.out    :  hci0:    Primary controller
> > 13:00:40 OUT    host.0.0.run.out    :   addr 00:AA:01:00:00:42 version =
11 manufacturer 1521 class 0x000000
> > 13:00:40 OUT    host.0.0.run.out    :   supported settings: powered con=
nectable fast-connectable discoverable bondable link-security ssp br/edr le=
 advertising secure-conn debug-keys privacy static-addr phy-configuration c=
is-central cis-peripheral iso-broadcaster sync-receiver ll-privacy past-sen=
der past-receiver
> > 13:00:40 OUT    host.0.0.run.out    :   current settings: br/edr
> > 13:00:40 OUT    host.0.0.run.out    :   name
> > 13:00:40 OUT    host.0.0.run.out    :   short name
> > 13:00:40 INFO   host.0.0.run        :  (return code 0)
> > 13:00:40 DEBUG  rpc.host.0.0        :  client-reply
> > PASSED                                                                 =
  [100%]
> > 13:00:40 OUT    host.0.0            :  qemu-system-x86_64: terminating =
on signal 15 from pid 149047 (python3)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1=
 passed, 4 deselected in 8.84s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > $ unit/test-functional --kernel=3D../linux -k test_bluetoothctl_pair --=
log-cli-level=3D0 --log-filter=3D*.bluetoothctl,rpc.* --force-usb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > rootdir: /home/pauli/prj/external/bluez/unit
> > configfile: pytest.ini
> > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xd=
ist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > collected 5 items / 4 deselected / 1 selected
> >=20
> > unit/func_test/test_bluetoothctl_vm.py::test_bluetoothctl_pair[hosts0-v=
m2]
> > -------------------------------- live log setup -----------------------=
---------
> > 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.l=
ib.host_plugins.Bdaddr object at 0x7f268712d160>,) {}
> > 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.l=
ib.host_plugins.Call object at 0x7f268712d2b0>,) {}
> > 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.l=
ib.host_plugins.DbusSystem object at 0x7f2687aa30e0>,) {}
> > 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.l=
ib.host_plugins.Bluetoothd object at 0x7f2687aa3230>,) {}
> > 13:03:20 INFO   rpc.host.0.0        :  client: start_load (<func_test.l=
ib.host_plugins.Bluetoothctl object at 0x7f268712d010>,) {}
> > 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.l=
ib.host_plugins.Bdaddr object at 0x7f26871542d0>,) {}
> > 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.l=
ib.host_plugins.Call object at 0x7f2687154410>,) {}
> > 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.l=
ib.host_plugins.DbusSystem object at 0x7f2687aa30e0>,) {}
> > 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.l=
ib.host_plugins.Bluetoothd object at 0x7f2687aa3230>,) {}
> > 13:03:20 INFO   rpc.host.0.1        :  client: start_load (<func_test.l=
ib.host_plugins.Bluetoothctl object at 0x7f2687154190>,) {}
> > 13:03:20 INFO   rpc.host.0.0        :  client: wait_load () {}
> > 13:03:21 DEBUG  rpc.host.0.0        :  client-reply
> > 13:03:21 INFO   rpc.host.0.1        :  client: wait_load () {}
> > 13:03:21 DEBUG  rpc.host.0.1        :  client-reply
> > -------------------------------- live log call ------------------------=
---------
> > 13:03:21 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothc=
tl', 'send', 'show\n') {}
> > 13:03:21 DEBUG  rpc.host.0.0        :  client-reply
> > 13:03:21 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothc=
tl', 'expect', 'Powered: yes') {}
> > ...
> > 13:03:23 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothc=
tl', 'send', 'pair 70:1a:b8:73:99:bb\n') {}
> > 13:03:23 OUT    host.0.0.bluetoothctl:  pair 70:1a:b8:73:99:bb
> > 13:03:23 DEBUG  rpc.host.0.0        :  client-reply
> > 13:03:23 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothc=
tl', 'expect', 'Confirm passkey (\\d+).*:') {}
> > 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> pair 70:1a:b8:7=
3:99:bb
> > 13:03:23 OUT    host.0.0.bluetoothctl:  Attempting to pair with 70:1A:B=
8:73:99:BB
> > 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 device_fla=
gs_changed: 70:1A:B8:73:99:BB (BR/EDR)
> > 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]>      supp: 0x00=
000007  curr: 0x00000000
> > 13:03:23 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 type 7 dis=
covering off
> > 13:03:25 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> hci0 70:1A:B8:7=
3:99:BB type BR/EDR connected eir_len 12
> > 13:03:25 OUT    host.0.0.bluetoothctl:  [bluetoothctl]> [BlueZ 5.86]> [=
CHG] Device 70:1A:B8:73:99:BB Connected: yes
> > 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> Request confirmat=
ion
> > 13:03:25 DEBUG  rpc.host.0.0        :  client-reply
> > 13:03:25 INFO   rpc.host.0.1        :  client: call_plugin ('bluetoothc=
tl', 'expect', 'Confirm passkey 237345') {}
> > 13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> hci0 84:5C:F3:7=
7:31:19 type BR/EDR connected eir_len 12
> > 13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> [NEW] Device 84=
:5C:F3:77:31:19 BlueZ 5.86
> > 13:03:25 DEBUG  rpc.host.0.1        :  client-reply
> > 13:03:25 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothc=
tl', 'send', 'yes\n') {}
> > 13:03:25 OUT    host.0.1.bluetoothctl:  [bluetoothctl]> [BlueZ 5.86]> R=
equest confirmation
> > 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [agent] Confirm p=
asskey 237345 (yes/no): yes
> > 13:03:25 DEBUG  rpc.host.0.0        :  client-reply
> > 13:03:25 INFO   rpc.host.0.1        :  client: call_plugin ('bluetoothc=
tl', 'send', 'yes\n') {}
> > 13:03:25 OUT    host.0.1.bluetoothctl:  [BlueZ 5.86]> [agent] Confirm p=
asskey 237345 (yes/no): yes
> > 13:03:25 DEBUG  rpc.host.0.1        :  client-reply
> > 13:03:25 INFO   rpc.host.0.0        :  client: call_plugin ('bluetoothc=
tl', 'expect', 'Pairing successful') {}
> > 13:03:25 OUT    host.0.0.bluetoothctl:  yes
> > 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> hci0 new_link_key=
 70:1A:B8:73:99:BB type 0x08 pin_len 0 store_hint 1
> > 13:03:25 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1=
A:B8:73:99:BB Bonded: yes
> > 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1=
A:B8:73:99:BB AddressType: public
> > 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1=
A:B8:73:99:BB UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
> > 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1=
A:B8:73:99:BB UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
> > 13:03:26 DEBUG  rpc.host.0.0        :  client-reply
> > PASSED                                                                 =
  [100%]
> > ------------------------------ live log teardown ----------------------=
---------
> > 13:03:26 OUT    host.0.0.bluetoothctl:  [BlueZ 5.86]> [CHG] Device 70:1=
A:B8:98:FF:qemu-system-x86_64: terminating on signal 15 from pid 149357 (py=
thon3)
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1=
 passed, 4 deselected in 13.22s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > $ COLUMNS=3D80 unit/test-functional -k test_btmgmt --kernel=3D../linux =
--trace
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > platform linux -- Python 3.14.3, pytest-8.3.5, pluggy-1.6.0
> > rootdir: /home/pauli/prj/external/bluez/unit
> > configfile: pytest.ini
> > plugins: cov-5.0.0, forked-1.6.0, rerunfailures-15.0, timeout-2.4.0, xd=
ist-3.7.0, hypothesis-6.123.0, flaky-3.8.1, anyio-4.12.1
> > collected 5 items / 4 deselected / 1 selected
> >=20
> > unit/func_test/test_btmgmt_vm.py
> > > > > > > > > > > > > > > > > > > > > > PDB runcall (IO-capturing turne=
d off) >>>>>>>>>>>>>>>>>>>>>
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(19)te=
st_btmgmt_info()
> > -> (host,) =3D hosts
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(21)te=
st_btmgmt_info()
> > -> result =3D host.call(
> > (Pdb) p host.bdaddr
> > '00:aa:01:00:00:42'
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(22)te=
st_btmgmt_info()
> > -> run,
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(23)te=
st_btmgmt_info()
> > -> [btmgmt, "--index", "0", "info"],
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(24)te=
st_btmgmt_info()
> > -> stdout=3Dsubprocess.PIPE,
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(25)te=
st_btmgmt_info()
> > -> stdin=3Dsubprocess.DEVNULL,
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(26)te=
st_btmgmt_info()
> > -> encoding=3D"utf-8",
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(21)te=
st_btmgmt_info()
> > -> result =3D host.call(
> > (Pdb) n
> > > /home/pauli/prj/external/bluez/unit/func_test/test_btmgmt_vm.py(28)te=
st_btmgmt_info()
> > -> assert result.returncode =3D=3D 0
> > (Pdb) p result
> > CompletedProcess(args=3D['/home/pauli/prj/external/bluez/build/tools/bt=
mgmt', '--index', '0', 'info'], returncode=3D0, stdout=3D'hci0:\tPrimary co=
ntroller\n\taddr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x000=
000\n\tsupported settings: powered connectable fast-connectable discoverabl=
e bondable link-security ssp br/edr le advertising secure-conn debug-keys p=
rivacy static-addr phy-configuration cis-central cis-peripheral iso-broadca=
ster sync-receiver ll-privacy past-sender past-receiver \n\tcurrent setting=
s: br/edr \n\tname \n\tshort name \n')
> > (Pdb) print(result.stdout)
> > hci0:   Primary controller
> >         addr 00:AA:01:00:00:42 version 11 manufacturer 1521 class 0x000=
000
> >         supported settings: powered connectable fast-connectable discov=
erable bondable link-security ssp br/edr le advertising secure-conn debug-k=
eys privacy static-addr phy-configuration cis-central cis-peripheral iso-br=
oadcaster sync-receiver ll-privacy past-sender past-receiver
> >         current settings: br/edr
> >         name
> >         short name
> > (Pdb) q
> >=20
> > !!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Quitting debugger !!!!!!!!!!=
!!!!!!!!!
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 4=
 deselected in 75.91s (0:01:15) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > ***
> >=20
> > Pauli Virtanen (11):
> >   emulator: btvirt: check pkt lengths, don't get stuck on malformed
> >   emulator: btvirt: allow specifying where server unix sockets are made
> >   test-runner: enable path argument for --unix
> >   test-runner: Add -o/--option option
> >   test-runner: allow source tree root for -k
> >   doc: enable CONFIG_VIRTIO_CONSOLE in tester config
> >   test-runner: use virtio-serial for implementing -u device forwarding
> >   doc: add functional/integration testing documentation
> >   unit: add functional/integration testing framework
> >   unit: func_test: add Pipewire-using smoke tests
> >   build: add functional testing target
> >=20
> >  Makefile.am                            |   7 +
> >  configure.ac                           |  17 +
> >  doc/ci.config                          |   1 +
> >  doc/test-functional.rst                | 374 +++++++++++++++++++
> >  doc/test-runner.rst                    |   1 +
> >  doc/tester.config                      |   1 +
> >  emulator/main.c                        |  37 +-
> >  emulator/server.c                      |   9 +
> >  tools/test-runner.c                    | 376 ++++++++++++++-----
> >  unit/func_test/__init__.py             |   0
> >  unit/func_test/conftest.py             | 277 ++++++++++++++
> >  unit/func_test/lib/__init__.py         |   5 +
> >  unit/func_test/lib/env.py              | 484 +++++++++++++++++++++++++
> >  unit/func_test/lib/host_plugins.py     | 269 ++++++++++++++
> >  unit/func_test/lib/rpc.py              | 293 +++++++++++++++
> >  unit/func_test/lib/runner.py           |  10 +
> >  unit/func_test/lib/tests/__init__.py   |   0
> >  unit/func_test/lib/tests/test_rpc.py   |  49 +++
> >  unit/func_test/lib/utils.py            | 266 ++++++++++++++
> >  unit/func_test/requirements.txt        |   3 +
> >  unit/func_test/test_bluetoothctl_vm.py |  76 ++++
> >  unit/func_test/test_btmgmt_vm.py       |  29 ++
> >  unit/func_test/test_pipewire.py        | 137 +++++++
> >  unit/pytest.ini                        |   7 +
> >  unit/test-functional                   |   8 +
> >  25 files changed, 2631 insertions(+), 105 deletions(-)
> >  create mode 100644 doc/test-functional.rst
> >  create mode 100644 unit/func_test/__init__.py
> >  create mode 100644 unit/func_test/conftest.py
> >  create mode 100644 unit/func_test/lib/__init__.py
> >  create mode 100644 unit/func_test/lib/env.py
> >  create mode 100644 unit/func_test/lib/host_plugins.py
> >  create mode 100644 unit/func_test/lib/rpc.py
> >  create mode 100644 unit/func_test/lib/runner.py
> >  create mode 100644 unit/func_test/lib/tests/__init__.py
> >  create mode 100644 unit/func_test/lib/tests/test_rpc.py
> >  create mode 100644 unit/func_test/lib/utils.py
> >  create mode 100644 unit/func_test/requirements.txt
> >  create mode 100644 unit/func_test/test_bluetoothctl_vm.py
> >  create mode 100644 unit/func_test/test_btmgmt_vm.py
> >  create mode 100644 unit/func_test/test_pipewire.py
> >  create mode 100644 unit/pytest.ini
> >  create mode 100755 unit/test-functional
> >=20
> > --
> > 2.53.0
>=20
> Looks like a fairly solid start, that said I wouldn't mix these with
> unit test, that is more of a unit/whitebox style testing not really
> meant for end-to-end testing, Id probably have this under
> test/functional or test/pytest,=C2=A0

Ok.

> anyway we could possibly remove the
> existing python tests and just convert them, or perhaps move them to
> examples since they are just demostrating how to use our D-Bus APIs
> using python rather than testing a specific use-case, etc.

Most of these appear example test clients, and don't have the server
side. I guess there's some value in keeping them, and just put the
automated test suite to subfolder there.

> Regarding pytest, Im not really an expert in the python testing
> frameworks so I will probably need to do some digging to see what are
> the options and there might be companies that already emply similar
> testing environment so I guess it is a good chance to make an attempt
> to convince more people to contribute upstream so we can consolidate
> in a single framework for end-to-end testing.

Pytest is=C2=A0a generic test framework; I'd say there are only two relevan=
t
choices for these in Python. It is widely used eg. by big parts of the
Python machine learning / scientific stack (Pytorch, numpy, etc) and
other projects, should be safe choice.

For specifically this kind of end-to-end or integration testing=C2=A0with
multiple VM images + controller redirection, which are the custom parts
here, it seemed not so easy to find something open source that's
immediately relevant.=20

There are things for embedded / hardware testing (openhtf, pytest-
embedded) but not clear those are immediately helpful here. There are
of course applications for controlling fleets of VM/Docker images (eg.
Ansible), but these are typically via network and probably need less
spartan VM environment.

--=20
Pauli Virtanen
