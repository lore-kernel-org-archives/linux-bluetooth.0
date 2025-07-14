Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37325FA10
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506449; cv=pass; b=hhaaDwZrf6dRs3Tz5UrN6wjZ16xaPFWMoB1PLp/Yj5puwszeRXyS7rANQ9oyVIoPqaWLX5PEim2Je040FpwGGUYALSMg9E537VAZ8WbjK46NVqiRp+GlqZUYdl0HvUWsUx0dMOOZprgjLLH3E1x2Qzd/JIwhcZ5mj5TyMTzIqyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506449; c=relaxed/simple;
	bh=mlb9riwRJGxmiq4APkZRYf8OKdwEDxf0wR8mnsSEumk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQxpNT1gv/5G2n/zrakLKbc6kkDefVTXMJ9++F7jTrK3GPxnVX8xgGX/orSBfUKQJDVjmRfjmVhQriudNggbVuINXq4ONPadund1ymc3/5NfchkeGsshRvXh8PTS70l3GnIi97wW/H1SUJKiWAerK84ZwgJqXojN1ICm8GJDmK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=StU2KCY2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="StU2KCY2"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgmGv6WYtz49PvR
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 18:20:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752506440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PfKg65hjqUiMG+ZlKUNwf1u4sMsYP7T3rPBgPr6768M=;
	b=StU2KCY2dI0qPX321e+Gyby3GNUn4PfiO8KUmvyottdJ4f9NvmNFQj6IXnYHTK4P9jrkkQ
	ELGhVt6s1yFBrmDh2I33zBQe5khKof738aHzUzVC035C+NlgzKQR//eQKZjQJBtg/BSRL/
	07ZShqWY17SPaokNavoP62GP26gBZbmqN9Krm8iQ9GuQjYl8aIuQ6GgKP6Vjjq31gK6myY
	6VV1Xo4IEgJkTqXPXWS+kxzLSlB1mPK0hEVyW91jixt6xuVO4ho4u7KyBCnBV3nPWJxlhb
	wU3/JuJKWJRNWNSDPGcceYk101DNnAO1WIqcA4iY7YaTgCdPL7EuSi57jEmvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752506440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PfKg65hjqUiMG+ZlKUNwf1u4sMsYP7T3rPBgPr6768M=;
	b=YfZtvwT6TS8KhFWQmmAhkAk3UUJXBldsn6/9E0bs/PKHMAQNqRVkRcOfPwg6yCDjBiFLlC
	iQ7QLNQTWWg74tXihGkC+GxVK2K8QylFPRTcndUzCi/iScI9dTRm6zUPjRCf/dpw+MD3Z1
	hOkQyg2M6j0Rd5XdI+rWjgbiVjqB+3jqyRxybaJ0Mo51NsWpKKfDvPITAt8ojc12UXP70g
	YYZj6rfndMo9haGjzppNDtTOopL19UBfFMBsoGCxkkuXaulLEcXEpQKnkhKKqAPQ9qSIZW
	8YqFAubkANQfAKNWOPhpoyIZG0vQHcgVLbx9GTllvMbOaPRlmpTGJ1khCzGE0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752506440; a=rsa-sha256;
	cv=none;
	b=BFje4BByhcK+q+YafDLC+5jPHOQYqe1Fq7gszBGiLaMbWvOe39dZKWqb2xq14gzbRfV2xK
	fw6mumLubjWz2vwm4rjFQ3ZCVSmQViygCupSpWCYJPwLmTBpX5uQJedYaHfbVrYA1XIzz/
	gKx+Xy6fdWsbcNpDbmBfBLn5FUid6c71ffmt5gVggD20WOh4rTSyaiGScSB1PS9bdgs3T+
	H/uiciWqPQXYDYbxIkeWW6DESk/oygJwfII2i65eRDb8fNTIO7VuZpHBO0ouoBgshiWSRC
	gSDF3pPJzMwvGuWmd5wfAeFfOB3BAVnjsAuOQn0/Fa6tylRB3v4R6DlOlcLWzw==
Message-ID: <bedffb635f1d612adb07e1c314176f5f18484652.camel@iki.fi>
Subject: Re: Bluetooth: ISO: add socket option to report packet seqnum via
 CMSG
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 14 Jul 2025 18:20:37 +0300
In-Reply-To: <68751613.170a0220.216844.5d68@mx.google.com>
References: 
	<474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
	 <68751613.170a0220.216844.5d68@mx.google.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ma, 2025-07-14 kello 07:37 -0700, bluez.test.bot@gmail.com kirjoitti:
> This is automated email and please do not reply to this email!
>=20
> Dear submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D982=
088
>=20
> ---Test result---
>=20
> Test Summary:
> CheckPatch                    PENDING   0.44 seconds
> GitLint                       PENDING   0.34 seconds
> SubjectPrefix                 PASS      0.07 seconds
> BuildKernel                   PASS      24.06 seconds
> CheckAllWarning               PASS      26.92 seconds
> CheckSparse                   WARNING   29.90 seconds
> BuildKernel32                 PASS      24.59 seconds
> TestRunnerSetup               PASS      482.03 seconds
> TestRunner_l2cap-tester       PASS      28.08 seconds
> TestRunner_iso-tester         FAIL      41.16 seconds
> TestRunner_bnep-tester        PASS      5.95 seconds
> TestRunner_mgmt-tester        FAIL      134.62 seconds
> TestRunner_rfcomm-tester      PASS      9.35 seconds
> TestRunner_sco-tester         PASS      14.66 seconds
> TestRunner_ioctl-tester       PASS      9.96 seconds
> TestRunner_mesh-tester        FAIL      11.50 seconds
> TestRunner_smp-tester         PASS      9.74 seconds
> TestRunner_userchan-tester    PASS      6.10 seconds
> IncrementalBuild              PENDING   0.59 seconds
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
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> net/bluetooth/af_bluetooth.c:248:25: warning: context imbalance in 'bt_ac=
cept_enqueue' - different lock contexts for basic blocknet/bluetooth/iso.c:=
2322:28: warning: incorrect type in assignment (different base types)net/bl=
uetooth/iso.c:2322:28:    expected unsigned short [usertype] snnet/bluetoot=
h/iso.c:2322:28:    got restricted __le16 [usertype] snnet/bluetooth/iso.c:=
2333:28: warning: incorrect type in assignment (different base types)net/bl=
uetooth/iso.c:2333:28:    expected unsigned short [usertype] snnet/bluetoot=
h/iso.c:2333:28:    got restricted __le16 [usertype] sn
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> Total: 130, Passed: 127 (97.7%), Failed: 2, Not Run: 1
>=20
> Failed Test Cases
> ISO Send - TX Timestamping                           Failed       0.233 s=
econds
> ISO Send - TX CMSG Timestamping                      Failed       0.236 s=
econds

These are false positives, they fail since the test is trying to use
BT_POLL_ERRQUEUE socket option which does not exist in kernel, but has
same value as the new BT_PTK_SEQNUM.

The following patch removes the references to the non-existing kernel
feature:

https://lore.kernel.org/linux-bluetooth/2ffec6539fe38318c713b48985aaddda967=
1f258.1752501450.git.pav@iki.fi/

> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4
>=20
> Failed Test Cases
> LL Privacy - Add Device 3 (AL is full)               Failed       0.228 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>=20
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.061 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.997 s=
econds
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
