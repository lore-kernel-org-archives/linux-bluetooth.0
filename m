Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A8231836
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210565; cv=pass; b=kZ1xJI120y/5Ic9sbZd5HD3HcXXKXfJ98xFRXyE0FwD4XHjuNzpggmNF5FWbg0UGUDdQlfdUGewH4RKzyJdrODOOjSgYpWCFul0QnrX5LdER1WiGvCjqZP6/xI5CSfwEyLjhwvk1QA9W+1p+OdVoUxqBW5xY6TkST5E3f4u5rmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210565; c=relaxed/simple;
	bh=NbQFu4D0vOwmmjVPj/EORtdnr2y4arcd3SYd04Ua86Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UKra6Ztv7KMsN6V0hE30KN+SNwRF+rUsvAfrPOmGn4PE/tR9CxIQ8KLwl2DfVmWQpz5iKukDDOuhxCH4exXWQgsnKKL05N9XgIHXKCQPUWnjOYr8/93O7ZjNemQL+oXJqA+S5aFQ/TEufj1EWugwztMKakmiINoC2gmuCNKc9A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NmYlIK3Z; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NmYlIK3Z"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dQ6Xj4rx3z49PvY;
	Mon, 08 Dec 2025 18:15:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1765210550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8XhOHZp4bCOveklCHTePWODSbrEASmnB6ub0M0TGfDE=;
	b=NmYlIK3ZoJ2fjX3drQxQHo0iW1ad3+q6HWVOnbxDqznLHBgah2QxH0Fu1qRKPvA+Yp7WLb
	YCdlDTsVF7UjxVrKl4mlhlJMrPdbwhJjgMtWvuIKUTCDbE+7hi2maX6gvLY7kE+8DS36nO
	vsz2wqCUO2PIzvWJ4fG3w9U4v9iz42/qkmyY5soR5ac1aY5C0XDqMihhi40m7I1LgL+mrb
	S2PQucICIXvkYVgra8kyPPcmzjGptwvf+7iZ6p54CZUo/yCXaayQ7zDBMPhtLYnxkx34Bt
	gNiAZHTLVRpXN6YE4VJ4zIyvlIJSxxGsXl/wEEBSy0KV6QoMWpR2EVFnZlKzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1765210550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8XhOHZp4bCOveklCHTePWODSbrEASmnB6ub0M0TGfDE=;
	b=JnRq16a3lKN0bi7OODhAyo38Wc3EmLLbQYoUkaiLzgeZBcWFJQObGpe7dFIFoZtS+cCSTj
	0kLGNcx09PRpD7miPhmtlQSCc9Uhqotp45E6qyPSL2OjJw78GejkMp/e3uysuzzpPTIQkb
	q13J/5h8jw7F1ATWzU38KTIsb9mf7lJwGvPKVDsvlpHJRU3GHJYYqBJ+V/ITfg8umDgSe9
	zeRLbM+RAniX0cMHtkcm8TphaYLSnDwBMJtgNNjf8ALYG5kVqG77kTEmB0VfFkvk/MtxBL
	1PFdl9qV0f6Qq9tYMCemmktbTlG5nyKYhZr5XsbSv1LIRGFVDQJyS5raUvH7Ew==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1765210550;
	b=DMYVWt+ZprcWPRx9gFZGuPCszL8Tvu9O5twnCMy7CODEqzHzfEXCfZo+4RyYLjaDfMH6W1
	jDy9T51aVlZVoNfA2la4+uW5tOxKGzOXc8oQ/DBGP/iCzRO1s+Ifmbmqz1yIGBcLln6opr
	PBTPVY1605paiEajQ1DA/QPCWhe1SczXKxN1522EVQ9mqfXWUi8V+Se2iBtEVcV1pg+WY5
	Wzge9fLY9t2aPmwOHCp/7es8PKfM3N36MPCtIxmGcCnM6TLBhqvLkN8Cmo+oUW+1NYDJ6S
	lTeMKmlkR/9Mo4UOwu6R40Y6FYoB+iECSx+iVZMtmYv/rOI7GcaaeZfAjID3XQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <9c08ba32021d20eed11c50ee5790c2ede5133f12.camel@iki.fi>
Subject: Re: [RESEND] Bluetooth: sco: Serialize state check in
 sco_sock_connect to fix UAF
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: zzzccc427@gmail.com
Date: Mon, 08 Dec 2025 18:15:48 +0200
In-Reply-To: <CABBYNZ+2PxLJvbW+HuoGMcjFBh+=riMRKBXisRrZMvQRMfC+xA@mail.gmail.com>
References: <20251208095508.3481977-1-zzzccc427@gmail.com>
	 <6936ab2d.0c0a0220.11bcee.8d68@mx.google.com>
	 <CABBYNZ+2PxLJvbW+HuoGMcjFBh+=riMRKBXisRrZMvQRMfC+xA@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-12-08 kello 10:41 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi,
>=20
> On Mon, Dec 8, 2025 at 5:40=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
> >=20
> > This is automated email and please do not reply to this email!
> >=20
> > Dear submitter,
> >=20
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D1=
031328
> >=20
> > ---Test result---
> >=20
> > Test Summary:
> > CheckPatch                    PENDING   0.32 seconds
> > GitLint                       PENDING   0.24 seconds
> > SubjectPrefix                 PASS      0.11 seconds
> > BuildKernel                   PASS      25.46 seconds
> > CheckAllWarning               PASS      28.37 seconds
> > CheckSparse                   WARNING   31.94 seconds
> > BuildKernel32                 PASS      25.61 seconds
> > TestRunnerSetup               PASS      558.74 seconds
> > TestRunner_l2cap-tester       PASS      24.64 seconds
> > TestRunner_iso-tester         PASS      88.68 seconds
> > TestRunner_bnep-tester        PASS      6.29 seconds
> > TestRunner_mgmt-tester        FAIL      125.65 seconds
> > TestRunner_rfcomm-tester      PASS      9.38 seconds
> > TestRunner_sco-tester         FAIL      14.61 seconds
> > TestRunner_ioctl-tester       PASS      10.26 seconds
> > TestRunner_mesh-tester        FAIL      11.58 seconds
> > TestRunner_smp-tester         PASS      8.61 seconds
> > TestRunner_userchan-tester    PASS      6.69 seconds
> > IncrementalBuild              PENDING   0.70 seconds
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
> > Test: CheckSparse - WARNING
> > Desc: Run sparse tool with linux kernel
> > Output:
> > net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci=
_core.h:153:35: warning: array of flexible structures
> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
> >=20
> > Failed Test Cases
> > Read Exp Feature - Success                           Failed       0.111=
 seconds
> > ##############################
> > Test: TestRunner_sco-tester - FAIL
> > Desc: Run sco-tester with test-runner
> > Output:
> > WARNING: possible circular locking dependency detected
> > BUG: sleeping function called from invalid context at net/core/sock.c:3=
782
>=20
> The above seems new to me, might need to check with the likes of
> sco-tester if you didn't already.

These ones are from the newly added SCO Listen tests.

They're a pre-existing issue, the code lockdep is not happy about is
how conn->lock is used in sco_conn_ready() and this appears to date
back a long time.

> > Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
> > ##############################
> > Test: TestRunner_mesh-tester - FAIL
> > Desc: Run mesh-tester with test-runner
> > Output:
> > Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> >=20
> > Failed Test Cases
> > Mesh - Send cancel - 1                               Timed out    1.792=
 seconds
> > Mesh - Send cancel - 2                               Timed out    1.997=
 seconds
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
