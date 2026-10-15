Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB214EDCC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100110; cv=none; b=O5VeGexkjkc0kb//X0Qm8MpkXg9cRb6SQIsm/oeV7Li6iCco6va7Dxpr4GAbffAa10STqXFk7GVSRubOplZtGVfYrhBgxmDgm8vva83dE49rXhrGYXs1AatHnMyqFPAZ/gmh1yWz8Tfycfd7JNUqjGrXQPW8l+bhZrdG5nPnW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100110; c=relaxed/simple;
	bh=Sa2P/GAVl3Z7npbWGUbuquGJgLvjGNmEXMT1e41sbr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wpf/6ZDlQhK7SUSJChg3vLMw9LHK7hEmYjfsjEocb7zA6WwpeP0BY5vfs+6hrMRtXrk/vRSYlYAJtUCsFXg0BlgEnjovndwdyWPsOIw6YNfwGDLFMc9zLP2UvfJZ9n6nCCebnjVxaxWC03KlU8D2ojoV5vyi0tehoNskqTm+104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+/z77Du; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+/z77Du"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B317C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792100108;
	bh=Sa2P/GAVl3Z7npbWGUbuquGJgLvjGNmEXMT1e41sbr0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N+/z77DuDk5KIe6Ye1tRR4OK1jBEKu3l++73XTlGxfDe1FX2blLPeph2FFbQd4Fxl
	 +JApTdCTYoUQ/Pn3aWMslpf67j3ZzXSoM2GlyjD/56CjiPRwxZX+6RPRqwls9mBFxv
	 0YbcROhysnGG2YqKm5QoAUf+5HVYc37hxuFTK+kc4jdt0qtwVnMWCqz64zg2TiKBJL
	 pSwzVJ7qRVXPzNCDIkoWW+3RunUnZGrvv1YjGA1bzdiUEYLT9qyZiJWhwTVZTKUYDJ
	 cvANSA3niz5CEeqEphzDz9itXwkMCeHHzQTf0+sJguvjVDGIh1NjYgm/6r8HgeSgvq
	 beSRngG0sNbzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3EDCEC53BC5; Thu, 15 Oct 2026 21:35:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219571] Previous handle short-transfer fix for fake CSR
 controllers does not account for other fake devices
Date: Thu, 15 Oct 2026 21:35:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luzemario@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219571-62941-evTt33Fga6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219571-62941@https.bugzilla.kernel.org/>
References: <bug-219571-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219571

Luzemario (luzemario@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luzemario@gmail.com

--- Comment #2 from Luzemario (luzemario@gmail.com) ---
My device has the same product description, but appears to the system as a
different product code. And fails.

[  444.694776] usb 4-2: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D25.20
[  444.694792] usb 4-2: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[  444.694799] usb 4-2: Product: CSR8510 A10
[  445.284957] usbcore: registered new interface driver btusb
[  445.286700] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D6 rev=
=3D3120
[  445.286711] Bluetooth: hci0: LMP ver=3D6 subver=3D22bb; manufacturer=3D10
[  445.286714] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[  450.486604] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[  450.486705] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[  450.486712] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[  450.486717] Bluetooth: hci0: HCI Set Event Filter command not supported.
[  452.500066] Bluetooth: hci0: Opcode 0x0c03 failed: -110

It enters a broken state when the force-suspend command is issued, then
timeouts the reset command afterwards.

Linux desk 6.12.111+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.111-1
(2026-09-28) x86_64 GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
