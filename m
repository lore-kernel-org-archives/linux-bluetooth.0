Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169321;
	b=guvN+m41yVQRngVhlSK+H5ypkqW4CcVWv3yiMiOsuNZ2IpZtIvgZFouwtVpXKMTJvtfn
	 TzCKHfUk4piBQqSQeT2EAsCeM6vi1ALdTlllqWkBSy3UrRqUhdzOZu9lejK68sDfpUw3W
	 fh6ZoV/W8c93TV6jrAbpF1uZ0aFhm0SyJwAZYMk8C6Ed+IB9VlA3ZkCVc13Ytcv8ESVNY
	 dY1M2M1BkY1aYVTEtLnb1eB4E3kO8u1LpZg9Oocc49/fD/IO58A5EmLlkBOme2TKbKTQK
	 j5SfszDCzNEcdfrHjfWG+ATHOrr2ho30fphwUknflJsfus4Keb111qqc16FTIF9FZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169321;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=CIpQDS/QI0NldxD0b0RG6RntnMFcBoGBcDWZDdh2VpQ=;
	b=OoPpn3so8FQRbMjeiajg5HRIqEryTjeq3UaXWLKEAXs4qem/t08sK2ch+bIMPkxCzDNH
	 u8VGEE34PtWSN4Y6TQtHRb0aLOa4WoXMXySlUYR/g/nOljkC0sAdyhcGH++QmsdzZ43cZ
	 scFiD8Ase8PCWigVPbKW1Mje4pb9gWyGbP3cttcZUBYrEZA/OKREl8IJakOshPrj+gGz3
	 ZB8FuhnbFbSWmcR9mbO4BJu9haJmdl79Tjtp911ozrrd6OmZnG+bdNsX3ffY5I+2i10Ra
	 KIAusfDXCTt46hE2DfmdgDFTxrSMZ09RMk9oWVxz+0E9HnAMYN+Msh45K3pxcEuLNVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpZ+AKby;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9038606D83F
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpZ+AKby
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87CB61F00930
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169320;
	bh=CIpQDS/QI0NldxD0b0RG6RntnMFcBoGBcDWZDdh2VpQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QpZ+AKbyxN7wfjaxbDAbHH2+KpnLUjGRAK0A/tqAJ0u8c9MvcudLqTkN8L86oV1lo
	 6C4Fo1pHb749tsDGdqVKbIC/g42Tw4XZ+3PpqUM2SD2+RRNIEkloIeHq29/mAe681q
	 QtM2qPSvIsVubNb/UmiOCRRF7wOZKMwvsK0ltCUAsLbMLdM0JfFLmw6ikC48HL+ZIP
	 p20qw7xwtCzGqzTgbS9dM/e+WzxjzHhfuVL6iod5/01g87+EULWkIju2MDL2ep70UV
	 P7MitzNUajIOpfsiuh6R14nYl7LnrqxLGbjiBkFxtnXbphkIok7RpEeYc8m+PPh9fL
	 WrMbwn5G5nVmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80A55C41612; Sun,  8 Nov 2026 20:22:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 210141] Bluetooth device driven by rtw_8822ce is lost after
 suspend to RAM
Date: Sun, 08 Nov 2026 20:22:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: bgnytyt65@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210141-62941-cRPY9b5klg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210141-62941@https.bugzilla.kernel.org/>
References: <bug-210141-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D210141

pseudo-mors (bgnytyt65@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bgnytyt65@gmail.com

--- Comment #5 from pseudo-mors (bgnytyt65@gmail.com) ---
Root cause found + workaround (HP 15s-fq1xxx, Realtek RTL8821CE, BT 0bda:b0=
0a).

Tested on: HP 15s-fq1120ur (SKU 286V9EA), DMI board 86C9, BIOS F.30, kernel
7.2.11.

Cause: this is a BIOS problem, not a btusb/firmware/USB problem. The Blueto=
oth
half of the M.2 card has its own enable line (W_DISABLE2# / BT_EN), driven =
by a
PCH GPIO pad. In the DSDT the BIOS sets this pad to 1 in only two places:
  - at boot, in \_SB.WLBT._STA (HPQ6001): SGOV (0x06010012, One)
  - on the airplane-mode key (EC query handler)
Nothing sets it on resume from S3. After S3 the pad comes back as 0, the
Bluetooth function stays powered off and drops off USB ("usb 1-10: USB
disconnect" right after "Waking up from system sleep state S3"). Wi-Fi is on
PCIe and on a different pad, so it comes back fine. This also explains why
hibernation "fixes" it: resume from S4 goes through a full BIOS boot.

Proof: after a broken resume, \_SB.GGOV 0x06010012 returns 0x0. Setting it =
to 1
brings the adapter back on USB within 1 second, no reboot. USB/xHCI resets,=
 PCI
remove/rescan, secondary bus reset, link disable, driver reloads and
btusb/rtw88 options all fail because none of them touch that line.

Workaround (acpi_call + systemd-sleep hook), with raw commands and a long
warning first:
https://github.com/k0kfjjfkdjf/hp-laptop-15s-fq1xxx-fq1120ur-icelake-realte=
k-rtl8821c-rtl8821ce-bluetooth-after-suspend-fix#warning

PLEASE read the warning before trying it. The pad number comes from this
specific DSDT. On other models (14-dq1xxx, 17-by0xxx, ...) it may be a
different pin, and writing to a wrong GPIO pad is not safe. Check board/BIOS
first, read the pin before writing, and only continue if it reads exactly
0x0 or 0x1. The README explains how to find the right pad in your own DSDT
(look for the SGOV call in \_SB.WLBT._STA).

A proper kernel fix would probably be for hp-wmi (or a DMI quirk) to restore
the
Bluetooth enable state on resume, similar to what toshiba_bluetooth does for
Toshiba.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
