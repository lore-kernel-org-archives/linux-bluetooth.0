Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7634C9A3
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836185; cv=none; b=a0D9hYMiyDZ8teQZIGfWPervtecA8Xb29scwRFkMbfEVjWvYD8zEoAnVEQiokORTCGIM6kJPba/gJ4DXHFv7Afq8hjBlZ1eALgJhp/gWYrUJEuV02Bvvrg3WtDu19f8r7/BWAglLCy0PZ5Gbn/SVIEyERrsGWHA/ksv/QjNzhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836185; c=relaxed/simple;
	bh=AY5hoYnqhAWpsABOAbtb1aTyA7L8FjdplsClX3diQsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVQrUPfDU91w1rYQf5vfHsc8EMEC7hQ2DGrWjeydmpFLpNtnbUPBVNRarnEsROVDM8hmdAFJ3Sf6V1LZheEGZjxoB/E38IqTm2wvRD3/qsrQqIWUZWi9ifL6VXkZTjIJbsDikqGeLXDYigaRl3YtyygELLOhOr2vE3z6hGrwzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEP4tW+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEP4tW+b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED2C4C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836185;
	bh=AY5hoYnqhAWpsABOAbtb1aTyA7L8FjdplsClX3diQsE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AEP4tW+bG7NaFMgp874d7tnZ0VjxjXvMzyFUw9dsW0b8fEOA6HTBqPgY+loBoNbCd
	 3h64wQLB3a2qWHzhhsOfWAeMowRCew1NQPRLUKSrbsFrfFugfjMmk+zPZSVo/kgPpb
	 CLexa8Mp1h1ja9nletvlv+bq5iUADwNPK4J7/iGrgcK6at1Qngz8rrXQ0eWuHEGBsq
	 znilObCb2P7h2E/2dNup0dtlntetObUbZjvj45ESMnEIrc11KP+3dUyTKuDmoM8xSk
	 jrrZ2eswO6p4mO+PuqypEz1uYX5KIX2R3QoV/BiEQvMbee/+OPE0CfkeRn5RQnG+Ot
	 OtDUZiOEVWP0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D773CC4160E; Sun,  3 May 2026 19:23:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Sun, 03 May 2026 19:23:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jens.nitschke@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220237-62941-DnC8nTj8bg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220237-62941@https.bugzilla.kernel.org/>
References: <bug-220237-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

jens.nitschke@mailbox.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jens.nitschke@mailbox.org

--- Comment #4 from jens.nitschke@mailbox.org ---
Device: HP OmniBook X Flip 14-fk0178ng
BIOS: F.10 (2025-10-22)
OS: CachyOS (Arch-based)
Kernel: 7.0.3-1-cachyos
WiFi/BT chip: MediaTek MT7925 (PCIe ID: 14c3:7925, Subsystem: 8c38)
I can confirm this issue on my device. The Bluetooth USB interface never
enumerates successfully. WiFi works fine via mt7925e driver.
Key symptoms from dmesg:

usb 3-5: device descriptor read/64, error -110
xhci_hcd 0000:65:00.0: Timeout while waiting for setup device command
usb 3-5: device not accepting address, error -62

The BT device never appears in lsusb or rfkill. No hci0 interface is create=
d.
Workarounds that had no effect:

pcie_aspm=3Doff
usbcore.autosuspend=3D-1
xhci_hcd.quirks=3D0x80000
Early loading of mt7925e via initramfs
linux-firmware up to date, firmware files present in
/lib/firmware/mediatek/mt7925/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
