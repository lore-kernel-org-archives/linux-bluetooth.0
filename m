Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539559E321
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892441; cv=pass; b=inflHEY9eLzaOFxV/L3MwMd4FtscSmEuYv4ZWQtG40amZJlh8dRmNJLioCB9w0ERChOrfprUV4Ka8oUiSvP7V0gmHTPtn4SyABR9XzeYNkB21HhbjbdOVxi7HzI7Rf1iLwdSYinzdcD94wZKgCh7mKuQbQx4qjuKysu6nZHajGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892441; c=relaxed/simple;
	bh=fm6ftbFeYCgfDJmTiEHs98yNx7GLhTuPdemxoNOzbf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umjTt5DIHZSIpgwModio4i1dhxKybEC6Qw2v8+1TF8r/Sjx4qQUWFPJ9gYDKg/vYB+4+Ok6KpHp/0QlvAoFr8/UIplNlaEjacbuyRD5PdGsJ4oUGSw6gglELyopvV0yk83YGk4Gf1rPBMsTjDpdU/iHCbWKyzcVNH/sLM6OGCas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dQtTQh26; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dQtTQh26"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::da01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hfXdV1NBYz49Q5P;
	Tue, 08 Sep 2026 21:33:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788892430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LiHGiA5K8Xm0pzNzIIK0PGSdy6k3oS0RqC2+8tOGQYA=;
	b=dQtTQh26pV6K3W/W1LdKyr+viI5X77mY8UYd8sup0ghvo8A8OE3ZHpQOczL6cBs2GkOY+j
	xa8G3t1+JknWr9gZDVhEH0s5QZ5Ltar8CHkIL+3pdVDmbbjh+D6Nh64Oq0/2ndRCAFJk4I
	JSApJ2ZIjAcY1YmWFar/wITPAilJZmjA6DSbTckewO5vkOc9AlW6FU3BbwOwN50GvKA0x0
	vYmQPyg2KTWLZPk/OLh2QXO4H339uzAt3xbGKvi8fU2x6JnutTFb9HPVofq5MswyddD1Q0
	UCJCJXOkWnSepAAfsvtPFD9TCjn/PWkKz2+kUmWYx7kMKhUYH2Nv0An2gDx33A==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788892430;
	b=bvU3UBr/ReYKQc/Gz9xwvROCJnjpckazwMW96YNANr2FZtcxNri2YexDS2RePLtIt3Hz3b
	qM29tUskgN4vsDxdVovyrUjNP9qPY/pi4jpVw+KH0T1RNkgmI4nxSsPDPZwUf8p0N6QZqJ
	BgiMAsZNDMpvlinuFvQQXAvTNIvwYog5707KDtKkVv/5rDdi5uThPftzaUUcIuzeRj6MAC
	vHO0Y6q0bHzpv3BnIK0vW5JB0qcdBE6TdBDhstMtzLNqxvh8nLh0zjMCxVb3lfSIdyiGie
	YXz9sD7xPvG6zAHm1D1hfXJAv5H9Zd+Zrldu/inmw4taN+8gMFw0uhZZomRmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788892430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LiHGiA5K8Xm0pzNzIIK0PGSdy6k3oS0RqC2+8tOGQYA=;
	b=QdeqQDo7zD55wITYD8+Og03oaSdbXaUEVFAqFWZc8/SRIlt1tae+eFtkIB/PhJjvcLXI9P
	bNKEG/StExggc+P1GT60W1MxUHX3bj5j4uigHGx2du/Mcf6v6s5BdQgvq/hscEU/HScbww
	oxSq3287VHVc02wwmPFf4Gj9pKqsMTu1wvj1cST0txEXzPC0XUCrQDddiimDASanFpQZk6
	D/M1PLJthF+N79rQH1u/1aaQS3vxpxVy2Rt0TmacaOc8EEqHjhD/WwRAkly11cf45pWtn7
	jbR6u/qylxhEqhEzgcqIzhvscjwnKuWq+OgT5TpIqeM7MRx7TkuGAMeBzafOeg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <6908a818b4833576f1bb3adabab08408fbd57f1a.camel@iki.fi>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Sep 2026 21:33:49 +0300
In-Reply-To: <CABBYNZLjfcz1SYo=0gAn6jz8hhOa2AKUs-OtTsUAz1YB=CbO-Q@mail.gmail.com>
References: <cover.1788712996.git.pav@iki.fi>
	 <CABBYNZLjfcz1SYo=0gAn6jz8hhOa2AKUs-OtTsUAz1YB=CbO-Q@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
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

ti, 2026-09-08 kello 13:48 -0400, Luiz Augusto von Dentz kirjoitti:
[clip]
> It took me some time to figure out how to pass the kernel to
> bootstrap-configure/configure, perhaps we should update the
> documentation regarding make check-functional and make check:
>=20
>  > bootstrap-configure --enable-functional-testing=3D/pathto/bzImage
>=20
> After this, there still seem to be some errors, I guess the kernel
> testers we should consider the tests unstable until we fix them all or
> perhaps we should skip them for make check[-functional] because they
> are really kernel testers not bluetoothd, but it also fails with the
> new AVRCP test:

We can skip kernel testers for check-functional.

The kernel testers currently pick up the rfcomm cyclic locking bug, so
that is a real failure.

Something is wrong with the l2cap-tester LL Privacy tests, they are
flaky also on bluez testbot.

Don't know what the 6lowpan-tester failure is below, haven't seen that
fail here.

The AVRCP failure is expected as noted in the cover letter since it
tests this which is not merged:
https://lore.kernel.org/linux-bluetooth/20260901175315.1348621-1-luiz.dentz=
@gmail.com/

> test/functional/test_tests.py::test_formatting PASSED
>=20
>           [  3%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-mgmt-tester]
> XFAIL (Read Exp Feature - Success)                               [
> 7%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-smp-tester]
> PASSED                                                            [
> 11%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-l2cap-tester]
> PASSED                                                          [ 14%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-rfcomm-tester]
> PASSED                                                         [ 18%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-rfcomm-tester]
> ERROR                                                          [ 18%]

This is probably the cyclic locking error.

> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-sco-tester]
> PASSED                                                            [
> 22%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-iso-tester]
> PASSED                                                            [
> 25%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-mesh-tester]
> XFAIL (Mesh - Send cancel - 1, Mesh - Send cancel - 2)           [
> 29%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-ioctl-tester]
> PASSED                                                          [ 33%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-bnep-tester]
> PASSED                                                           [
> 37%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-userchan-tester]
> PASSED                                                       [ 40%]
> test/functional/test_kernel_testers.py::test_kernel_tester[hosts7-vm1-noc=
-6lowpan-tester]
> FAILED                                                        [ 44%]

I haven't seen failures in 6lowpan-tester

> test/functional/test_kernel_testers.py::test_kernel_selftest[hosts7-vm1-n=
oc]
> SKIPPED (CONFIG_BT_SELFTEST not enabled)
>     [ 48%]
> test/functional/test_adv_monitor.py::test_adv_monitor_GHSA_hhgc_hfgf_8m4x=
[hosts0-vm1]
> PASSED                                                            [
> 51%]
> test/functional/test_bluetoothctl.py::test_bluetoothctl_show[hosts3-vm1]
> PASSED
>         [ 55%]
> test/functional/test_bluetoothctl.py::test_bluetoothctl_list[hosts3-vm1]
> PASSED
>         [ 59%]
> test/functional/test_bluetoothctl.py::test_bluetoothctl_script_show[hosts=
3-vm1]
> PASSED
>  [ 62%]
> test/functional/test_bluetoothctl.py::test_bluetoothctl_script_list[hosts=
3-vm1]
> PASSED
>  [ 66%]
> test/functional/test_btmgmt.py::test_btmgmt_info[hosts6-vm1] PASSED
>=20
>           [ 70%]
> test/functional/test_agent.py::test_agent_pair_bredr[accept-hosts1-vm2]
> PASSED
>          [ 74%]
> test/functional/test_agent.py::test_agent_pair_bredr[reject-hosts1-vm2]
> PASSED
>          [ 77%]
> test/functional/test_avrcp.py::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts2-vm2]
> FAILED
>        [ 81%]
> test/functional/test_avrcp.py::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts2-vm2]
> ERROR
>        [ 81%]

This one is=20
https://lore.kernel.org/linux-bluetooth/20260901175315.1348621-1-luiz.dentz=
@gmail.com/

> test/functional/test_bluetoothctl.py::test_bluetoothctl_pair_bredr[hosts4=
-vm2]
> PASSED
>   [ 85%]
> test/functional/test_bluetoothctl.py::test_bluetoothctl_pair_le[hosts5-vm=
2]
> PASSED
>      [ 88%]
> test/functional/test_obex.py::test_obex_ftp_list[hosts8-vm2] PASSED
>=20
>           [ 92%]
> test/functional/test_obex.py::test_obex_ftp_get[hosts8-vm2] PASSED
>=20
>           [ 96%]
> test/functional/test_obex.py::test_obexctl_list[hosts8-vm2] PASSED
>=20
>           [100%]
>=20
>=20

--=20
Pauli Virtanen
