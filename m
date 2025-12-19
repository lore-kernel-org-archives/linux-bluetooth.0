Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659A382BD1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160307; cv=none; b=uQ+d4rBct/0QPf61XqJQwGmEbHsMBR6CS3vX0p9dxSMubt+Hnd0yG3CycM6cBIFXg+LJ5uFML1ZG4YKOUgQy3RSExj+2jnwIyyucdK1QBI9iVnit3E8c18cDhIKWfCPdOv8i9Ve3Ven/4X/IV3hIN/GK/vMji4lMJQUDuzt7EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160307; c=relaxed/simple;
	bh=Izc47ZPBWyFpRFM0hyZ/jYV39U4vJINmEwTf0D6sdOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhFf0lyzaAY8kNd+nELE2KTrgbwpyQSOdUqgqW9/6Ss1IXfaShI5vqBHs1Gsxwn2CWpHFN7Q6mnccm7VUmQFz61vZR415y9w2HmMbg5GYhwqutq0tsO2t/RWrZJi4XG11+KUEzTmhIba9lOas9OwAqboXoBag59FQCTSXkU5Bg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO7M3wmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO7M3wmy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78018C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766160303;
	bh=Izc47ZPBWyFpRFM0hyZ/jYV39U4vJINmEwTf0D6sdOM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nO7M3wmy2SYVSUYr2/Vpvp/ARW5xBH38oH9LFCUYSOx1z1PVPLLitqoqqtSG2m2yF
	 nzEQ3/ZKFl/pTL5O/KWqF4oGGIwIkIHCt0M/Oc166udqL0MLttPRCuPToOh+RW/HYK
	 G0P/dCb/VJBUzyDVOXHgDIXab6Ix6vRb7blNerKkEFqJs4LiTmfu2lWjMFeoWrwU/e
	 LradyOVmqX62T2O38y2pDkpneVWJjWJWM16/vLpEZJ8aI8rv5iybE0QsvlnA/Vh5PH
	 tnCq9sxB84i6Wv/XC3ahqZp9VWxGIfo8GlxtyZ6AD3YWxEKT1r4+FQAG+1m9bQ+q7H
	 QixUBQ4U4SyFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7022CC41613; Fri, 19 Dec 2025 16:05:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 19 Dec 2025 16:05:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-zxyqFx3ZQW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

cheako+kernel_org@mikemestnik.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |cheako+kernel_org@mikemestn
                   |                            |ik.net

--- Comment #24 from cheako+kernel_org@mikemestnik.net ---
My testing shows that cold/worm boot is a red herring, the issue is random =
and
if you do it one way enough times you may well find you can get *both* stat=
es.

@Mario what were you thinking for DD?  For me this happens while going
multiuser, so I really would like kernel cmdline or `/etc`/`initramfs` sett=
ing
and not echoing things on a prompt.

I added this to `~/.config/autostart/xmessage.desktop`
```desktop
[Desktop Entry]
Type=3DApplication
Exec=3Dsh -c 'sudo dmesg|grep hci0|xmessage -file -'
Hidden=3Dfalse
X-GNOME-Autostart-enabled=3Dtrue
Name[en_US]=3Dxmessage
Name=3Dxmessage
Comment[en_US]=3Dxmessage preformance monitoring
Comment=3Dxmessage preformance monitoring
```

I get either no hci0 logs, xmsg is empty, or this:
```dmsg
[    9.536622] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[    9.540760] Bluetooth: hci0: Device revision is 1
[    9.540766] Bluetooth: hci0: Secure boot is enabled
[    9.540769] Bluetooth: hci0: OTP lock is enabled
[    9.540771] Bluetooth: hci0: API lock is enabled
[    9.540773] Bluetooth: hci0: Debug lock is disabled
[    9.540775] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    9.544653] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    9.544681] Bluetooth: hci0: Boot Address: 0x24800
[    9.544684] Bluetooth: hci0: Firmware Version: 193-33.24
[   10.058240] Bluetooth: hci0: Failed to send firmware data (-19)
[   10.058266] Bluetooth: hci0: sending frame failed (-19)
[   10.058276] Bluetooth: hci0: FW download error recovery failed (-19)
[   10.058313] Bluetooth: hci0: sending frame failed (-19)
[   10.058319] Bluetooth: hci0: Reading supported features failed (-19)
[   10.058322] Bluetooth: hci0: Error reading debug features
[   10.058328] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.
[   10.058342] Bluetooth: hci0: sending frame failed (-19)
[   10.058349] Bluetooth: hci0: Failed to read MSFT supported features (-19)
```

I had been using BT for a few months, so suddenly loosing it after a kernel
upgrade really sucks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
