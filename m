Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA56FA8
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476069; cv=none; b=MMVv01fC60BskTgqZvEOQycF3c063D4XRKV9iTrPdbk1eZjRySML5/L1k+OgsX73GTVlJlkvxnN1nQCeh5OqnbeD5yw3+17hNXMaYFQnPbhTcH2FoSw4H1QIlpvX1zGX7Pi2cKzljbjDdV9wmAdiQToNRWLWaP8E59WoW5WAFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476069; c=relaxed/simple;
	bh=a+6kRVQPLE+lcsf8EHjdESEaI3NKdl2Dcv64aF619aY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6xGq/KfyQQjmLCPhlpt0sVV3lwFlo8iwP1+Z5mV3nxvdu8odcZqgUaoJQDBq+TP7xNCTeEj/BxMSQvjiT4ASIyHAMws+UFtyOasMufhDHYlIDRFoycIcLQpnKwizWR6h5u3xynuqFGPOrmOqkyA2gf/CitNqwypi2jitfBlsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uevEGYDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uevEGYDC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B7DC4AF08
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716476068;
	bh=a+6kRVQPLE+lcsf8EHjdESEaI3NKdl2Dcv64aF619aY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uevEGYDC3oK8g3hL7h7MEvW59h6koqxyY6AGLU1mcbkAFZMfG1GIUKoCLEBZhut6+
	 fW+zP8nIRV2lV99mrYEu4rjA4hJiU1zoOCK1WQ/wEBFZ63e6NhsQFr7mQtSBfFJte5
	 hcu26ykORO5TlCjtkI0tk/Fzn8k1RRVlH9EAsAkg0f+JxAguuzWI64CGCHtjSoRtQn
	 6aIfihyyvjkJ2Oc2hsYGT0d9IdcDOCEt2AN8+V0WAhuF+mZSRbIs6WJazNAchTkDo2
	 do2CC5mU19uQi/THCpIxL/aDNR5I6/aqZZj3AwRc4blBf9+OFVBNBD4sSetod82Hvr
	 YlVR1gm+tESNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0A93C53B7F; Thu, 23 May 2024 14:54:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Thu, 23 May 2024 14:54:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-3XxMJ5vLuS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #25 from Nickolas Gupton (nickolas@gupton.xyz) ---
kernel: 6.9.1=20
linux-firmware: 20240510

For me bluetooth still does not work on boot, the timeout error is no longer
shown in the logs but without running that reset script the journal will ju=
st
endlessly repeat these messages and the bluetooth will never work. I think =
the
'fix' that was put in for this simply hid the issue from the logs and wasn't
actually resolved.

$ lsusb | grep -i bluetooth
Bus 001 Device 007: ID 8087:0029 Intel Corp. AX200 Bluetooth

$ journalctl --since 2024-05-22 | grep -E -i bluetooth
May 23 07:21:03 andromeda kernel: Bluetooth: Core ver 2.22
May 23 07:21:03 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
May 23 07:21:03 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
May 23 07:21:03 andromeda kernel: Bluetooth: HCI socket layer initialized
May 23 07:21:03 andromeda kernel: Bluetooth: L2CAP socket layer initialized
May 23 07:21:03 andromeda kernel: Bluetooth: SCO socket layer initialized
May 23 07:21:03 andromeda systemd[1]: Reached target Bluetooth Support.
May 23 07:21:03 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
May 23 07:21:03 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
May 23 07:21:03 andromeda kernel: Bluetooth: hci0: Firmware Version: 132-3.=
24
May 23 07:21:03 andromeda kernel: Bluetooth: hci0: Firmware already loaded
May 23 07:21:03 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.
May 23 07:21:03 andromeda NetworkManager[789]: <info>  [1716466863.8963] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.46.0-2/libnm-device-plugin-bluetooth.so)
May 23 07:24:04 andromeda kernel: Bluetooth: Core ver 2.22
May 23 07:24:04 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
May 23 07:24:04 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
May 23 07:24:04 andromeda kernel: Bluetooth: HCI socket layer initialized
May 23 07:24:04 andromeda kernel: Bluetooth: L2CAP socket layer initialized
May 23 07:24:04 andromeda kernel: Bluetooth: SCO socket layer initialized
May 23 07:24:04 andromeda systemd[1]: Reached target Bluetooth Support.
May 23 07:24:04 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
May 23 07:24:04 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
May 23 07:24:04 andromeda kernel: Bluetooth: hci0: Firmware Version: 132-3.=
24
May 23 07:24:04 andromeda kernel: Bluetooth: hci0: Firmware already loaded
May 23 07:24:04 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.
May 23 07:24:05 andromeda NetworkManager[779]: <info>  [1716467045.0155] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.46.0-2/libnm-device-plugin-bluetooth.so)
May 23 07:28:33 andromeda kernel: Bluetooth: Core ver 2.22
May 23 07:28:33 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
May 23 07:28:33 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
May 23 07:28:33 andromeda kernel: Bluetooth: HCI socket layer initialized
May 23 07:28:33 andromeda kernel: Bluetooth: L2CAP socket layer initialized
May 23 07:28:33 andromeda kernel: Bluetooth: SCO socket layer initialized
May 23 07:28:33 andromeda systemd[1]: Reached target Bluetooth Support.
May 23 07:28:33 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
May 23 07:28:33 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
May 23 07:28:33 andromeda kernel: Bluetooth: hci0: Firmware Version: 132-3.=
24
May 23 07:28:33 andromeda kernel: Bluetooth: hci0: Firmware already loaded
May 23 07:28:33 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.
May 23 07:28:33 andromeda NetworkManager[779]: <info>  [1716467313.7052] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.46.0-2/libnm-device-plugin-bluetooth.so)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
