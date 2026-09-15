Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268133DEF7
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489716; cv=pass; b=PrfPLRuOKW/li2eoXNytF+MqV1fMk/XaCbxVobCcByBmvh/MW0Y43cFdVm7h71WWrxCsczqU6kpwAE9wGV3mPxoq/4Mpu4BPAU4JlmVpXW/ne8tzEqtXXaRSIa1+sUxeg1IsuTCmFsviPrihs1oOrRJe3HW4aStfXEu0HMIaMuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489716; c=relaxed/simple;
	bh=gYJ5TVmuuWYFT+TPe+pmCX1hZo0PEQrcplyi4AwB0DI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/ER6IIOzJycmWQumomdxcMdzPvbgkgoffUbAY9dFexi1VB/XXbkZEQJS88Uz3Ah4KVWY0K8XbT1yLRxad/PD5gorg7TAN7K7qD2OBY7Y1o3CiwEkwuMNwEvG0zCAYIf2zFs0udK/OXzjEIZ+qGVtk30EI/i7/uxAkgcu0kvIW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pWnHm91F; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pWnHm91F"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:9::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hknWb6Y9Lz49Q5S;
	Tue, 15 Sep 2026 19:28:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789489708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nsh7qfklsYySTxX24+8L9AUvQZD9ToZOpBJlnw2b/ZM=;
	b=pWnHm91F7qPAl0RrMor954GhjD2OmLIE7UJOLQMXvYPjXuRH7LV2MxpMx6HElc2Hk4gpKh
	EIfHwEZ4KjtF5/YVHPD38HQm45Tz3kPjW7PCsSDRiSRPU5/WQMgJ5P32vPvWBUmAYHwJfS
	loXjR7BSjzv0ToTvyEYZPX4k/P1wN7eA4H5qzFD1crg7ixQebFJb96TexJ801rJku/EQrJ
	fQvRG7VunSUimba5c1PAFcqETxnozk5vg01f9b9rAaboh+9iTLPcPBQluqJJj3U9nTK2KE
	xq0wOSm+0JpDLuDeU7kx0ifT0N4AMrLgmr7H2Ya0C2bOBPseG03KwTPhE2APbA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789489708;
	b=dgs3/7wRLzodAOoSI7BB8Ac4u+/WjGOVeSHPmaZvfn4s0ce+7SNYWwfhiMZODenLA+S09A
	MdRcdMuyIrWBkV5IX5hipSUZYQfPaqWbs2NuClf+eJ/Dsd0+wEP3vRxah7IgxwFS3dDJD/
	ueMzmGROGuU3c+2skmpJgAER+DXbrF2qo3gVU30dZeFwF8FG8FGdraYbXDSkP263wG1wcP
	x2lbmehBTMiMehbHjM26RMdHfzRANgfrYUlJpAEhjn3h/FNBwQIV4jwUhNz1HR6Wcc2QZs
	BtCM0LydZ1wTRRdxkQ/Hr50vhluwSyt8D+skb98LMe2+QwGYIlVMcIDzAUAbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789489708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nsh7qfklsYySTxX24+8L9AUvQZD9ToZOpBJlnw2b/ZM=;
	b=uMqOO5pnFUS7+VE82dDKCWBws15Pewx5QxT2RigxttJm00HibZK7tH1+hvJYmJyUudocij
	oWaG4k7/taAtBh1833eQRBYzndYHWb44tiVA5dMVoddDCpmQxJnswGIc6vu+jhpG81/U66
	PweWubZ/xhBoiEtSR/Q4usAG7nOlbfWvnG/HFN78se0U7q+uhl9DzymkSFc1ZThLRNg3TV
	MsrrHg+YUg7UG73YMNfs2ff2gJ8iD7ePdPrdtz5sZ6sVuH6x0vIrUvAjrkypbStwNMfJlh
	dCtAsEXbUQXqehzPVD8//Tx0To7Wmf67jrpBU6vgmjEiGtLPtE+wNAPPr+xQuQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <bff27212d35947f436e6568d043ec06a9fefccc8.camel@iki.fi>
Subject: Re: [BlueZ,v1,1/2] doc: test-runner: document the virtual machine
 architecture
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 15 Sep 2026 19:28:27 +0300
In-Reply-To: <CABBYNZKN656TzoAKcv9V6UfQiJBYDHWf8QjvQzPLhgc5b0vVJg@mail.gmail.com>
References: <20260914175136.613532-1-luiz.dentz@gmail.com>
	 <6aa883ab.1ce3d5fb.ae9c9.b59a@mx.google.com>
	 <CABBYNZKN656TzoAKcv9V6UfQiJBYDHWf8QjvQzPLhgc5b0vVJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2026-09-15 kello 11:56 -0400, Luiz Augusto von Dentz kirjoitti:
> On Mon, Sep 14, 2026 at 7:30=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
> > This is automated email and please do not reply to this email!
> >=20
> > Dear submitter,
> >=20
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/series/1164802/
> >=20
> > ---Test result---
> >=20
> > Test Summary:
> > CheckPatch                    PASS      0.52 seconds
> > GitLint                       PASS      0.41 seconds
> > BuildEll                      PASS      19.42 seconds
> > BluezMake                     PASS      371.20 seconds
> > MakeCheck                     PASS      14.23 seconds
> > MakeDistcheck                 PASS      139.01 seconds
> > CheckValgrind                 PASS      232.65 seconds
> > CheckSmatch                   PASS      290.59 seconds
> > bluezmakeextell               PASS      95.03 seconds
> > TestFunctional                FAIL      1057.13 seconds
> > IncrementalBuild              PASS      389.26 seconds
> > ScanBuild                     PASS      1125.63 seconds
> >=20
> > Details
> > ##############################
> > Test: TestFunctional - FAIL
> > Desc: Run test-functional
> > Output:
> > FAIL functional.test_kernel_testers::test_kernel_selftest[hosts11-vm1-n=
oc]: failed on setup with "ConnectionResetError: [Errno 104] Connection res=
et by peer"
> > FAIL functional.test_adv_monitor::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[=
hosts1-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connec=
tion reset by peer"
> > FAIL functional.test_btmgmt::test_btmgmt_info[hosts10-vm1]: failed on s=
etup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish conn=
ection"
> > FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts7-vm1]: =
failed on setup with "ConnectionResetError: [Errno 104] Connection reset by=
 peer"
> > FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts7-vm1]: =
failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to est=
ablish connection"
> > FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts7=
-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection r=
eset by peer"
> > FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts7=
-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed=
 to establish connection"
> > FAIL functional.test_a2dp::test_a2dp_transport_created[hosts0-vm2]: fai=
led on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_a2dp::test_a2dp_transport_acquire[hosts0-vm2]: fai=
led on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_obex::test_obex_ftp_list[hosts12-vm2]: failed on s=
etup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_obex::test_obex_ftp_get[hosts12-vm2]: failed on se=
tup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_obex::test_obexctl_list[hosts12-vm2]: failed on se=
tup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_agent::test_agent_pair_bredr[accept-hosts2-vm2]: f=
ailed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_agent::test_agent_pair_bredr[reject-hosts2-vm2]: f=
ailed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_avrcp::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts3-vm2]:=
 failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bap_unicast_transport_created[hosts4-vm2=
]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2=
]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-host=
s5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-host=
s5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-host=
s5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-host=
s5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bap::test_bass_past_transport_acquire[hosts6-vm2]:=
 failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts8-=
vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> > FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts9-vm2=
]: failed on setup with "RuntimeError: Process exited unexpectedly"
> >=20
> >=20
> > https://github.com/bluez/bluez/pull/2528
>=20
> Any idea how to fix the errors above? Locally they seem to work just
> fine, so perhaps this is something related to the CI environment.

The runner does not appear to pass /dev/kvm to the Docker image:

2026-09-15 01:29:28,720:DEBUG :> 2026-09-15 01:26:20.908511 OUT host.0.0 : =
qemu-system-x86_64: failed to initialize kvm: No such file or directory
2026-09-15 01:29:28,720:DEBUG :> 2026-09-15 01:26:20.909088 OUT host.0.0 : =
qemu-system-x86_64: falling back to tcg

Didn't figure out yet how to do, GPT suggests it's

https://github.com/pv/bluez-action-ci/commit/452d3471ab4bdb5ef2020ac24cd9e7=
ae87ea550d

I'll try to test if that works now.

--=20
Pauli Virtanen
