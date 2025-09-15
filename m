Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6E8287E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959756; cv=pass; b=SNdPAwFU9tx0ALY5roaW17ekYsbYxoF/Tfewi55gYssr+QeRl5GYrnLPCvEHBExCPZHr1YyPyTac/sxGWEVB+ISw3JzEvMT2TTl+MP8wvCLJEK51B2OL96pAKLCQw6D6N2uuS4EoxsRXn3dvz3dRJJ0xywnWs1k9GyWOlsCZ/Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959756; c=relaxed/simple;
	bh=NTJkmdCzJKYStxSetDC3OHiMdXd69trA0NuCW0g90+M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owM1S1Z6Jqewdr3tdCvPWQoa4UAdiU3gSUOHEd5OyxJD/peVYpBYEW/MhFv/WQpaN51HoqpAIvGHBPo6tn+UBYlfgdbl4jwKGSSabEZ9AEMGNnBZ36DKORWzMYyf0wA2NlaHN11UBUI+bYPCH94FIvZHqnef5qInl2nZunR+j+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LUIupcoU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LUIupcoU"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cQY2503PYz49PsJ;
	Mon, 15 Sep 2025 21:09:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1757959741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NfJG4GnL/1DVXqHiGumxyNFLMxI4myHY5loUBfs3JxY=;
	b=LUIupcoUnn2BsPWrA6H6APvrqdMzV0uHS+h9lamMqEUI8ssAf6lWSlQcu7H+NKcqGL+Rz6
	l6Iv7pRRBD3O3E1t5gfGIxTJ0ASAWwQs1e9W42F6wKRLFh/yO7c1Xfycg9T/b75CEU/o95
	Avkay9TQ382B00qSjz0PWZfTmgHwac1ypqWGLPSgSTqnTuLNA7DRT+SCT1gocavqav4sw4
	5AZs4GMpOyVyLoFuuNJiuTPBjXoHTBG0BHGwPb+BSjC/ErmrEzUzfSCnYtwW/DjcHJcaBJ
	R939rlWNQQk9dklVKRUBQlLI0kOn2QNDHLLwSedX4kqUYYBaLDR4d565UHQiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1757959741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NfJG4GnL/1DVXqHiGumxyNFLMxI4myHY5loUBfs3JxY=;
	b=firfucfK7HgLM7wp5ndWSUuAlEtFxVyl5TIf5ScLzI50Pb+uAeeHYRBaLgqOPX7IPt6KEx
	w97giDFSkA3qStf/T43m+AhscxeLdwQneGt7zTXauYGxF24lF7Uowk52CLJ03MfF4amWO5
	+cttPfYjPOZYQ2iv3KYAa2gXDM/h4l+hMlbAmEpRevTLPSOV7aiKSIIRb2VyS1Ga+ehDjE
	eHGq7XAtjwhgYI+eN88fHRwZ1D4jH0asfaXhAkwIrYd3b7fRHKxI/0IHmzsIUkBBSpfBzK
	UwWrepBvoQTvMtyvIu4+gXQvLKydTozC9nrwEEdQQ257i96q+u6GCylGY6/tgQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1757959741; a=rsa-sha256;
	cv=none;
	b=g/ArLRVvpSHecJi0LZ176BoWjVA8SRJ6fMtA7LguSWBFGeITGLIs0tT2OYnmL+awvZrdsm
	9cu3SMnu22PU93ZRT83zm3xQXc3qabbZ3j+L4cjkbOXkevneqlbtQqf7amPBxutk3HlRIX
	vAdO+NT9PjxbNdl4NQiwMc6jvjCVpD3JPzUg5lXaDi+AFJUrJpszBhIQrjQQ21yLRVJpOY
	jQkfNOA6v/7Q2HEmR++pHKyozuXdXhLD70m60jHPWw0IwF6uxr/HqwE8DMj48X6C/IvHb9
	hivOmqYxnyrADbLqAFtqkAzu4MVR9XGdZ37tNy8ZC5/lcHnhiIVDsuJlVj2j6w==
Message-ID: <4c0381e91d511b95d6f74eefadb9b3a6a2cb7ada.camel@iki.fi>
Subject: Re: [RFC,1/2] Bluetooth: hci_core: add lockdep check to
 hci_conn_hash lookups
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 15 Sep 2025 21:09:00 +0300
In-Reply-To: <CABBYNZKB81S-sghOxcw-KnJUa_VMt8vTckVcfJDFAwn1J=BdoQ@mail.gmail.com>
References: 
	<7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
	 <68c49f9f.050a0220.225601.db74@mx.google.com>
	 <CABBYNZKB81S-sghOxcw-KnJUa_VMt8vTckVcfJDFAwn1J=BdoQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
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

Hi,

ma, 2025-09-15 kello 09:39 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Fri, Sep 12, 2025 at 6:33=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
> >=20
> > This is automated email and please do not reply to this email!
> >=20
> > Dear submitter,
> >=20
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D1=
001955
> >=20
> > ---Test result---
> >=20
> > Test Summary:
> > CheckPatch                    PENDING   0.28 seconds
> > GitLint                       PENDING   0.25 seconds
> > SubjectPrefix                 PASS      0.22 seconds
> > BuildKernel                   PASS      24.45 seconds
> > CheckAllWarning               PASS      27.25 seconds
> > CheckSparse                   PASS      30.74 seconds
> > BuildKernel32                 PASS      24.44 seconds
> > TestRunnerSetup               PASS      486.11 seconds
> > TestRunner_l2cap-tester       FAIL      25.68 seconds
> > TestRunner_iso-tester         FAIL      38.99 seconds
> > TestRunner_bnep-tester        PASS      6.18 seconds
> > TestRunner_mgmt-tester        FAIL      129.91 seconds
> > TestRunner_rfcomm-tester      FAIL      9.69 seconds
> > TestRunner_sco-tester         FAIL      15.34 seconds
> > TestRunner_ioctl-tester       FAIL      10.41 seconds
> > TestRunner_mesh-tester        FAIL      11.39 seconds
> > TestRunner_smp-tester         FAIL      8.84 seconds
> > TestRunner_userchan-tester    PASS      6.20 seconds
> > IncrementalBuild              PENDING   0.57 seconds
> >=20
> > Details
> > ##############################
> > Test: CheckPatch - PENDING
> > Desc: Run checkpatch.pl script
> > Output:
> >=20
> > ##############################
> > Test: GitLint - PENDING
> > Desc: Run gitlint
> > Output:
> >=20
> > ##############################
> > Test: TestRunner_l2cap-tester - FAIL
> > Desc: Run l2cap-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > Total: 68, Passed: 68 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: TestRunner_iso-tester - FAIL
> > Desc: Run iso-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > Total: 135, Passed: 135 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4
> >=20
> > Failed Test Cases
> > Read Exp Feature - Success                           Failed       0.104=
 seconds
> > LL Privacy - Add Device 3 (AL is full)               Failed       0.224=
 seconds
> > LL Privacy - Set Flags 4 (RL is full)                Failed       0.270=
 seconds
> > ##############################
> > Test: TestRunner_rfcomm-tester - FAIL
> > Desc: Run rfcomm-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > Total: 11, Passed: 11 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: TestRunner_sco-tester - FAIL
> > Desc: Run sco-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > Total: 24, Passed: 24 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: TestRunner_ioctl-tester - FAIL
> > Desc: Run ioctl-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > Total: 28, Passed: 28 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: TestRunner_mesh-tester - FAIL
> > Desc: Run mesh-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> >=20
> > Failed Test Cases
> > Mesh - Send cancel - 1                               Timed out    2.012=
 seconds
> > Mesh - Send cancel - 2                               Timed out    1.996=
 seconds
> > ##############################
> > Test: TestRunner_smp-tester - FAIL
> > Desc: Run smp-tester with test-runner
> > Output:
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
> > WARNING: suspicious RCU usage
>=20
> Hmm, it would have been better that this prints the function name as
> well, but it doesn't seem it prints the message from
> HCI_CONN_HASH_LOCKDEP_CHECK for some reason or perhaps we are missing
> some config option?

The splat itself does contain the location and the backtrace, see
example below.

The test bot only includes the line with "WARNING:" in the summary,
you'd have to go to github to see the full log. Maybe we could change
it to include more lines for context for BUG/WARNING/GFP.

RCU_LOCKDEP_WARN() has some additional rcu-specific checks, but
probably they're not so important here as we're not in early boot and
WARN_ON_ONCE() might also be OK.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.16.0-rc6-01737-gb9b65e1e560f #653 Not tainted
-----------------------------
./include/net/bluetooth/hci_core.h:1236 wrong hci_conn* locking!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
2 locks held by kworker/u5:0/86:
 #0: ffff888002365940 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
process_one_work+0xc3b/0x13c0
 #1: ffff888002297d98 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_one_work+0x78b/0x13c0

stack backtrace:
CPU: 0 UID: 0 PID: 86 Comm: kworker/u5:0 Not tainted 6.16.0-rc6-01737-
gb9b65e1e560f #653 PREEMPT(none)=20
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42
04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x3a/0x60
 lockdep_rcu_suspicious.cold+0x55/0x93
 hci_num_comp_pkts_evt+0x484/0xaf0
 hci_event_packet+0x7ba/0xee0
 ...



>=20
> > Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: IncrementalBuild - PENDING
> > Desc: Incremental build with the patches in the series
> > Output:
> >=20
> >=20
> >=20
> > ---
> > Regards,
> > Linux Bluetooth
> >=20
>=20

--=20
Pauli Virtanen
