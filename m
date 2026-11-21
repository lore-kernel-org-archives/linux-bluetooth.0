Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278321;
	b=cv+6QROs//SFkcHhStuEryLkOXsYX91/VozDjVzooHK3/6MHlPwLCViDtwyi0jByqkSv
	 4xJMcTzXImtXr+TVZIQt+uG1SAJJLk+TzL5+UYZRbCvp6PG9A6q5f8h/UCg6Jn0HQubdG
	 uk8pbvHTS+za0uvpHBi9HO8ZNEWFiiZVKinv7WVcuWzUaHvDkA1spbpqHJcjxzUVMv6ou
	 Yij7AsKbY0NKGzVTS6ayoCK4vzsPU+pdgGg50x6sqoHo1YA4eStywdEK+H+TSxlG0+BxB
	 Iat+DJXfnhIA88Vcdw1Vq898KdWEXrcILHT6mweDpp6w2/ZUnrGCwyJVhgVtbs+A3UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278321;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=h+yGd6nqn5VgvzcKaAb7rroCev3f1YklQOGLYsxlTU0=;
	b=XSRERMam2mCwrzgRtoTAm3FJ9D8LbfPztloXHovk7Db9R0MofyOEGbz5Q6FhHEGusTOe
	 PqU7oTNxpUvb7MjavCZvtirdTkbPVXonbGuC11mgVlhtEVpVIoK3qRvjpl5gMSwx3ZHQi
	 Aro1pNV4Z8JFzIwEwUv1012LL0FExVfKBf7Kgq8nEVlW7bgVYqJJoXrlXkq7wuBrUqM46
	 Uksc2Z563+8ZmXQANJNkPv6JOqFDONwVXDnwrTQshp/myscViM9rw6rI9yXWMoY0TNeCf
	 IRIF7Qvl1PVFFgHxh1ydUksVhmkJC03Gy5PINrHioxBncMP301cQ9TONuSxip56u4Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BakD2e+S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95C606A32A
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BakD2e+S
Received: by smtp.kernel.org (Postfix) with ESMTPS id A24691F000C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795278320;
	bh=h+yGd6nqn5VgvzcKaAb7rroCev3f1YklQOGLYsxlTU0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=BakD2e+S16/qmvHWyjcq/r7ZhZuMbH+9FTrVolkao+wtrSDwfkgLOpKd/oSqyWa85
	 ooNvcmmpZqX1/MZSMwieJTB2Fauf4VNgB3nsJFgY6wPTTNucX54na0ncjesB0+vIlb
	 uAcmCez4cY1iaZQ0KUxU0jsbCZTn78pZz0ehAxa3E9X1zi3/NURhoFeU4FPbVPwwEM
	 bxLTI8ft+NQtinIoMJVHnME2kOvYGVToKPndEFM5Kpx7qTGaezP31HMp3paeKgZynY
	 0objf/ULR+4hd/pbLCiV53UP/IaaVSS3m9UxFqAWPoiddSp+yD8BDsXSyJyrQ5AJWN
	 wbws2zePQHAsg==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id 9EB59240040C; Sat, 21 Nov 2026 16:25:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222310] [Intel Panther Lake][btintel_pcie] Bluetooth A2DP
 playback stalls; HCI packet completion warnings
Date: Sat, 21 Nov 2026 16:25:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222310-62941-ufg95HoB03@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222310-62941@https.bugzilla.kernel.org/>
References: <bug-222310-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222310

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Updated the firmware, it hasn't helped:

```
Bluetooth: hci0: Device revision is 0
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is disabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Bootloader timestamp 2023.43 buildtype 1 build 11631
Bluetooth: hci0: Found device firmware: intel/ibt-00a0-01a1-iml.sfi
Bluetooth: hci0: Boot Address: 0xb02ff000
Bluetooth: hci0: Firmware Version: 110-44.26
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 55400 usecs
Bluetooth: hci0: Received gp1 mailbox interrupt
Bluetooth: hci0: Received gp1 mailbox interrupt
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 1691 usecs
Bluetooth: hci0: Waiting for device transition to d0
Bluetooth: hci0: Device moved to D0 in 4 usecs
Bluetooth: hci0: Received gp1 mailbox interrupt
Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0f
Bluetooth: hci0: Found device firmware: intel/ibt-00a0-01a1-pci.sfi
Bluetooth: hci0: Boot Address: 0x10000800
Bluetooth: hci0: Firmware Version: 110-44.26
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 691723 usecs
Bluetooth: hci0: Received gp1 mailbox interrupt
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 44313 usecs
Bluetooth: hci0: Waiting for device transition to d0
Bluetooth: hci0: Device moved to D0 in 37409 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-00a0-01a1-pci.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware timestamp 2026.44 buildtype 1 build 108142
Bluetooth: hci0: Firmware SHA1: 0x2cb3db13
Bluetooth: hci0: Fseq status: Success (0x00)
Bluetooth: hci0: Fseq executed: 00.87.00.04
Bluetooth: hci0: Fseq BT Top: 00.87.00.04
Bluetooth: MGMT ver 1.23
Bluetooth: hci0: offload codecs enable 1 changed 1
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
