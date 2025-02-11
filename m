Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B328F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233451; cv=none; b=HuSg9Ak5SSh3vgEzCI7lTSGIcQsURnaIqsMoHmUYtoVu7txEEDJ9LI1zxeQALMmmmFZJJF/Vv59735eONaB9GzvuvVBh3PE80Lpa53TbQEQbCh8fJWWBOEHpvQcgEWbGCLEH6DvHTRUs5v45JzHBrBMgxDo18Pwey+ye1/UY/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233451; c=relaxed/simple;
	bh=3ABs4tCkh1lyS3kC0u2slUZ0+lE8bBKAc0BczovVF7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/D5q+SmySUoBmhUJ2yiXiWGeSSU5ij8gVgglnFHxyR2oUrcQY8Svy1Bfqf04kPUbclGoXpzzoh0oJ2z7P25jyEubZqf2ampouFLP6kTcgz0uaSnjXPwX/sq6mkBouZURm4ay7TsSVHyd6kiCSHrh1oAIZvH3qG8zs+GpTc8LJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKdrqVMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKdrqVMI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AB2BC4CEE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233449;
	bh=3ABs4tCkh1lyS3kC0u2slUZ0+lE8bBKAc0BczovVF7I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JKdrqVMI7pSb2RYJGyeaJlCZ6wZ3jH/Kwu/WU7Iy2r4oFSEgpByNrfxBfraflpstz
	 Rvt43VdmuaAgXtOJXaqS0sdSmFquFqblMy2i6OC3l7SiYOtozW2CLBL4e+NmXLbrSO
	 vPIpsLpysZjGpLQRHpO7lUp0NI39sVk0mxFH8G2+sWCUQG9jC/pRGAXUR5mcIV9a7l
	 GWWXnLApjYyVDWx/aakmgc8lb33XxklInuAy6kbQnGNGCqbix87LLNkDrSr23BNCZB
	 CyAZAZRPg2aJyXK/0DcodbJOGr3k2QW9t3Y+13IjkkOzEv8w7jbxcmxMclH4kQh1+j
	 qosfULFJHt2oQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82946C41606; Tue, 11 Feb 2025 00:24:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date: Tue, 11 Feb 2025 00:24:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217023-62941-JrrS2ibkBP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

--- Comment #13 from alexknoptech@protonmail.com ---
Seeing this fixed as of kernel 6.12.11


[   11.349625] Bluetooth: hci0: Device revision is 0
[   11.349629] Bluetooth: hci0: Secure boot is enabled
[   11.349631] Bluetooth: hci0: OTP lock is enabled
[   11.349633] Bluetooth: hci0: API lock is enabled
[   11.349634] Bluetooth: hci0: Debug lock is disabled
[   11.349635] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   11.349637] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[   11.349703] Bluetooth: hci0: DSM reset method type: 0x00
[   11.395507] Bluetooth: hci0: Found device firmware: intel/ibt-0040-0041.=
sfi
[   11.395532] Bluetooth: hci0: Boot Address: 0x100800
[   11.395535] Bluetooth: hci0: Firmware Version: 91-33.24
[   12.733845] Bluetooth: hci0: Waiting for firmware download to complete
[   12.733847] Bluetooth: hci0: Firmware loaded in 1306968 usecs
[   12.733908] Bluetooth: hci0: Waiting for device to boot
[   12.749759] Bluetooth: hci0: Device booted in 15525 usecs
>>>Typically seen here<<<<
[   12.759485] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-0041.ddc
[   12.761879] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.764880] Bluetooth: hci0: Firmware timestamp 2024.33 buildtype 1 build
81755
[   12.764882] Bluetooth: hci0: Firmware SHA1: 0xd028ffe4
[   12.768860] Bluetooth: hci0: Fseq status: Success (0x00)
[   12.768862] Bluetooth: hci0: Fseq executed: 00.00.02.41
[   12.768863] Bluetooth: hci0: Fseq BT Top: 00.00.02.41

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
