Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6E6FC3
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586741; cv=pass; b=hpmpgXrbxRsfrVuP8n2NZjDeBhGgptKHnhJY9jr5uEjZO/xLhSGXMZEW7k25vI3oO++Rc2/DODUXhIuKvbBV7GQxy/ihczrjxe3ciZ3elFhgjtogzXmffFWTuqnaiDkYnbDKdIbI05HHLsBeWDbfoQ5bG/QmYxJAqXmBLeY7o/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586741; c=relaxed/simple;
	bh=h3zsp7pq+RYjLhzTYFoAKmDlG3NOsbYtsXVDZpIoBMg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMzd2NEakKlz45B9gRtaMDFTGMtPyZdgCvPW+JBoEzV3Vb0gad5OmCr8zahuqEzWSJ6QATowv695tWu0NWqE46lkJYDMGWtBs4gWlvlbNYpK5TNXQQHkwKRXCCCk6OSwXGIilx4bqvH4nwYuiWDiIIaNRBg10o/HXjUuMR8TADY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=G25sLlrq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="G25sLlrq"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cf6kL3BdMz49Q7N
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 17:05:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1759586730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vp5ZW3PxZBTDqm3enM/mDCCJdMxRssxdOyzM/O/r/UQ=;
	b=G25sLlrq3Y8jxqSF1Apy7/8tI6KHSwLX6vbWrCgU1m+N81E5QKEMvZExBlHiYB8Lcwdhyf
	dcPZYWP0T25Ki3apYGJ4KRFZ/0hzapnQYpFz2FJJ+jTABTW38tD4LuEBolMbhf49LkIEYF
	PTn8ltghpeovHiYrf9yE9mN8eOqqeFPPuiKa0v7rg3NGGHB9RJkNPS6Mwd/pw4rKWik8MX
	mAWz3cd86skTknNcbAh6uCKQte35ekYN7VVP9lsgmnAR3ZSsmR5KXcHJ4/xtNXOD8qYqn+
	PKdkxl/1ALZ0UMQAu0aCPh96A1+zk1nUM5eL25Zts21cEsiUEcDXG8cBhD5uSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1759586730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vp5ZW3PxZBTDqm3enM/mDCCJdMxRssxdOyzM/O/r/UQ=;
	b=lprI02/oTbOymBvufgyrAgxZuCsqgHnjNHTHOwwD+l7FzCys3wdoPrTkcgGEEDDnvOFimB
	+KZf2VnK9DxFOLlmV5lNq1LzPRxB3Wn8THttjNULVc/G/ENfEhnkB8Y+hOMc/0j7QFlNiu
	EUioMm390B5TLSu++xKp4a55hwFph9kO2h7wchtmoUZEbhO86IuDEH7f4MDwZK8/6SajJe
	IgnrKvzUDo08zLNPQWFloI8L6EA2SYvd6phmDcBlavohCNdOTRcgtwxr+FTJAlJl8P+DMQ
	96SmX1zinw2T/AchWd2rTeNkSNrKl0UodlygCVyJfbp5wpgBdqar8TFJr4v6DQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1759586730; a=rsa-sha256;
	cv=none;
	b=e2wprVdMGFbhNCUU4Kwv+LrCpB+Tu2iPmiO+2nJv/1t+aWYO2K+TVWQzAUpIEZkj8YpHyg
	Xzjlsrqd7gNY2J6q1mBbIXz5rDhHzoOIqn21h6WeZh9w1rAfgONtf0kS2V7rVaYb84iL1y
	OfhQNq70SbLS+EFxTiUZ8BQ1Cptu/Ygx6HhXXiU2Ulk+JHLEl6ppOmhl3iL8pIlyvNX89p
	eGn4HAWmPitbbzAOjgrBqh1sNxPaL0QMkeAYIm6+DHi9m/XbbLXSecmpSKD7YrnbOXBYEW
	wdF5hR6CCR8hVcok+Gzi4DMKA05CeKOFCwR1RPLdELdYurHfYg8foLUyN5Dnrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <63943978b9c8a00bf6729123e088f6ba1678168c.camel@iki.fi>
Subject: Re: Bluetooth: MGMT: fix crash in set_mesh_sync and
 set_mesh_complete
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 04 Oct 2025 17:05:28 +0300
In-Reply-To: <68e02495.5e0a0220.1f2dca.4290@mx.google.com>
References: 
	<f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
	 <68e02495.5e0a0220.1f2dca.4290@mx.google.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2025-10-03 kello 12:31 -0700, bluez.test.bot@gmail.com kirjoitti:
> This is automated email and please do not reply to this email!
>=20
> Dear submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D100=
8357
>=20
> ---Test result---
>=20
> Test Summary:
> CheckPatch                    PENDING   0.41 seconds
> GitLint                       PENDING   0.33 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      24.57 seconds
> CheckAllWarning               PASS      27.18 seconds
> CheckSparse                   PASS      30.39 seconds
> BuildKernel32                 PASS      24.51 seconds
> TestRunnerSetup               PASS      486.03 seconds
> TestRunner_l2cap-tester       PASS      24.06 seconds
> TestRunner_iso-tester         PASS      57.49 seconds
> TestRunner_bnep-tester        PASS      6.16 seconds
> TestRunner_mgmt-tester        FAIL      125.14 seconds
> TestRunner_rfcomm-tester      PASS      9.23 seconds
> TestRunner_sco-tester         PASS      14.38 seconds
> TestRunner_ioctl-tester       PASS      10.19 seconds
> TestRunner_mesh-tester        FAIL      11.31 seconds
> TestRunner_smp-tester         PASS      8.46 seconds
> TestRunner_userchan-tester    PASS      6.41 seconds
> IncrementalBuild              PENDING   0.78 seconds
>=20
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>=20
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>=20
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4
>=20
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.108 s=
econds
> LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.162 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>=20
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    1.886 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.996 s=
econds

These mesh-tester failures appear to be older, see eg.
https://lore.kernel.org/linux-bluetooth/68c66f83.050a0220.1b1f43.486b@mx.go=
ogle.com/
Probably some other bug than this.

The reason why the test bot is currently not sending out email reports
for several of the patches seems to be because the bug fixed in this
patch causes mesh-tester to hang the kernel, and the bot worker times
out. See eg

https://github.com/BluezTestBot/bluetooth-next/actions/runs/18228972296/job=
/51907378892?pr=3D3102

2025-10-03 17:32:05,593:DEBUG   :> Oops: general protection fault, probably=
 for non-canonical address 0xfbd59c0000000021: 0000 [#1] KASAN NOPTI
2025-10-03 17:32:05,594:DEBUG   :> KASAN: maybe wild-memory-access in range=
 [0xdead000000000108-0xdead00000000010f]
2025-10-03 17:32:05,596:DEBUG   :> CPU: 0 UID: 0 PID: 45 Comm: kworker/u5:0=
 Not tainted 6.17.0-rc7-gd82d3cf940db #1 PREEMPT(none)=20
2025-10-03 17:32:05,596:DEBUG   :> Hardware name: QEMU Standard PC (Q35 + I=
CH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
2025-10-03 17:32:05,598:DEBUG   :> Workqueue: hci0 hci_cmd_sync_work
2025-10-03 17:32:05,598:DEBUG   :> RIP: 0010:mgmt_pending_remove+0x98/0x1b0
2025-10-03 17:32:05,599:DEBUG   :> Code: 89 f2 48 c1 ea 03 80 3c 02 00 0f 8=
5 11 01 00 00 49 8d 7c 24 08 48 8b 5d 08 48 b8 00 00 00 00 00 fc ff df 48 8=
9 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e3 00 00 00 48 89 da 49 89 5c 24 08 48=
 b8 00 00
2025-10-03 17:32:05,600:DEBUG   :> RSP: 0018:ffff888001d97a88 EFLAGS: 00000=
206
2025-10-03 17:32:05,600:DEBUG   :> RAX: dffffc0000000000 RBX: dead000000000=
122 RCX: ffffffff94e750e3
2025-10-03 17:32:05,600:DEBUG   :> RDX: 1bd5a00000000021 RSI: 0000000000000=
008 RDI: dead000000000108
2025-10-03 17:32:05,601:DEBUG   :> RBP: ffff88800245b000 R08: 0000000000000=
000 R09: ffffed10003b2f33
2025-10-03 17:32:05,601:DEBUG   :> R10: ffff888001d97a88 R11: ffff888001d97=
997 R12: dead000000000100
2025-10-03 17:32:05,601:DEBUG   :> R13: ffff88800245b018 R14: ffff88800245b=
008 R15: ffff88800218b200
2025-10-03 17:32:05,602:DEBUG   :> FS:  0000000000000000(0000) GS:000000000=
0000000(0000) knlGS:0000000000000000
2025-10-03 17:32:05,602:DEBUG   :> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
2025-10-03 17:32:05,602:DEBUG   :> CR2: 00007ffde0d53ff8 CR3: 0000000002598=
000 CR4: 00000000000006f0
2025-10-03 17:32:05,602:DEBUG   :> Call Trace:
2025-10-03 17:32:05,603:DEBUG   :>  <TASK>
2025-10-03 17:32:05,603:DEBUG   :>  set_mesh_complete+0xc5/0x1d0
2025-10-03 17:32:05,603:DEBUG   :>  ? __pfx_set_mesh_complete+0x10/0x10
2025-10-03 17:32:05,603:DEBUG   :>  hci_cmd_sync_work+0x243/0x3c0


> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
>=20
>=20
>=20
> ---
> Regards,
> Linux Bluetooth

--=20
Pauli Virtanen
