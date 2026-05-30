Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0832D5408
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780177125; cv=none; b=mM+ohSeDDL54xRm0JdbPpFWOgT3QK0l4QpIR36g9Nnx5/QH0m1hMTQ4kVj4GHUnt/sBGkhDI/FSdvuCpNIESAoh4JGBeEqLcbfz51L0Ki3lhiCVrY+IIIs7XD7bRbpp0WPspPw5mx83Cwa088x0rHfLF4ljHeXUhd3Mhw4aXj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780177125; c=relaxed/simple;
	bh=xigOy34CuWt1yPhZAaxndGtKiUaWVQglbZX2Qnj822M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0/PkrsX8GG/x1hntPvWy4ahxOPS+FOduFXteRfYwfMoyqbZMbDoBJl/JsGmUhaErNoR5NmDt6iwOn/R1QKcN6a7hMXGHHVl8jmecIVoaKyswOotC7DcrXntzA+AxfwWB7IN7RfWTrsTo4t8GLneucYCFHezwi1HBSCU1orRCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEFKFrm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEFKFrm7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A79E1C19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 21:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780177124;
	bh=xigOy34CuWt1yPhZAaxndGtKiUaWVQglbZX2Qnj822M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VEFKFrm7v5RRpKdWL2nvaZzD2WZbCN1bG0hzqs63x/MEUiPPtZSdA2fR+ftqgKkDf
	 Y/k/8kc7ZQUGblWw7B06GdJQo6c1UiNdO7w5jnAxdBLGHFcxlmwCbDJ3yjlBEbF/MX
	 0oKQyTe574jKvkb4XHGMFzDgJyXVcDcs5+VvJa8KJhNbuE96ChlGwVHZv5ojXPuQX/
	 cHfN4prIlIsrJzD+HqcNI4D/B1eFUwnpgdFHFfag9de9nvYlOilkMD0eGnzr03m3Qx
	 VGfuhzEWj+ii29fUr1MVTHlStUzCks9mrdFP+ygMgLNa0uw50nsmfd2yAOnLZ3hw3P
	 g3lMbTkOOLWig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 88094C3279F; Sat, 30 May 2026 21:38:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 21:38:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221598-62941-lfsHy6DFAb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #7 from Alexander Paderin (apocarteres@gmail.com) ---
Additional update after isolating user-space HCI traffic:

I found a strong practical mitigation/confounder: stopping/removing Blueman
significantly improves the HFP/mSBC microphone quality on this machine.

Before this test, Blueman UI processes were running:

- `blueman-manager`
- `blueman-applet`
- `blueman-tray`

The bad traces with Blueman running contained frequent HCI control traffic,
especially:

- `Read RSSI` (`0x1405`)
- `Read Transmit Power Level` (`0x0c2d`)

After stopping/removing Blueman, the same headset/machine produced much cle=
aner
captures. The subjective microphone stutter also became noticeably better.

Summary of RX mSBC/H2 continuity results:

| run | extra HCI polling | RX H2 markers | bad seq | bad seq/k | bad dist |
bad dist/k |
|---|---:|---:|---:|---:|---:|---:|
| old control | yes | 3486 | 21 | 6.02 | 23 | 6.60 |
| no-Blueman control 1 | no | 4301 | 6 | 1.39 | 15 | 3.49 |
| no-Blueman control 2 | no | 4312 | 6 | 1.39 | 6 | 1.39 |
| bad noisy watch-only run | yes | 3949 | 454 | 114.97 | 425 | 107.62 |
| bad noisy raw-open repeat | yes | 4812 | 453 | 94.14 | 385 | 80.01 |

TX remained clean in all runs (`bad_sequence=3D0`, `bad_distance=3D0`).

Important caveat: I then tried to reproduce the issue without Blueman by
injecting the same polling manually after eSCO setup. The stress script sen=
t 25
pairs of:

- `Read RSSI` (`0x1405`)
- `Read Transmit Power Level` (`0x0c2d`)

That did not reproduce the catastrophic bad runs:

| run | polling | RX H2 markers | bad seq | bad seq/k | bad dist | bad dist=
/k |
|---|---:|---:|---:|---:|---:|---:|
| no-Blueman control 2 | no | 4312 | 6 | 1.39 | 6 | 1.39 |
| artificial HCI polling stress | 25 RSSI + 25 TX-power reads | 3778 | 16 |
4.24 | 13 | 3.44 |

So `Read RSSI` / `Read Transmit Power Level` alone is not proven to be the
direct root cause. The stronger conclusion is:

- Removing Blueman is a real practical mitigation on this RTL8821C/0bda:c821
system.
- Extra user-space HCI management/control traffic is a strong confounder and
can correlate with much worse RX mSBC continuity.
- The underlying failure still appears to be RX-only H2/mSBC continuity los=
s:
host TX stays clean, eSCO setup parameters remain normal, and RX still has =
some
breaks even in the clean no-Blueman baseline.

Relevant local captures/reports:

- `captures/sco-control-test-20260531-002158.snoop`
- `captures/sco-control-test-20260531-002431.snoop`
- `captures/hci-poll-stress-test-20260531-003222.snoop`
- `reports/control-no-blueman-20260531-002158-findings.md`
- `reports/control-no-blueman-repeat-20260531-002431-findings.md`
- `reports/hci-poll-stress-20260531-003222-findings.md`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
