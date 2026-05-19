Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1330566E
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156819; cv=none; b=k+OknedhmHSuvxIELFTe6DHLCF3IzD0lhtwSAQElt+OyE+GTM1wSZdPObNxZhOx6MEBk16RgpFpfm1U+26hBjBLD6iNfrYzEXQt2aL4DaM3J1Ozjn86ZgDMXyZAb9DvXa3/zQVKikofkkjUmCR/HRWqoQoq4oVL4o3rYD4WkqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156819; c=relaxed/simple;
	bh=lfyCqlWaPTzrIXrU1xk0UaTT4YFFVaoITU7oMtbfZm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSeMY4mm8HQ2TBCUPLNRXagzG/nf5YJQldN9CyNbsFtQDoR67CJeWW6A60xXtUH232ag/Qx1+aTnn43GVcYj9BQYOxNI6F/TAgb2wBCXXJ7Vnuew+uIoFMOIACLFrmOjOtLScM9hPJg2lIMgV1qPvVOuf3WCHhXp2qpplHTYZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaDGKQxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaDGKQxf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C9A7C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156819;
	bh=lfyCqlWaPTzrIXrU1xk0UaTT4YFFVaoITU7oMtbfZm8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FaDGKQxfH26EOmwqTdIIsp1KcgW6GAGqhk3ErQEdlBa6385GqbBgypEMxuf+NIL6H
	 YOn7Cbi8oMAAfJZwmlGGIVGlznRHrQ8yh/G4kY3mvuUID4LBZBD0BZU3k8rpXm8Df8
	 HJFKDF8MGdzr+faBCxVUL7tUlsdHxt3YLARVc8hb9u0oJQL2KI9d/4JoUgGeEceLW2
	 soLjAhJ0UU+R7+pmAeZNDl34reMe/lVDpr251VHNag6iJVF149agJaE/1tW3heCZ87
	 2pOOK3atS7p69uXzs1TPdmvqcdM3ikfNcj4yV8iz5ZvibGRePTDStBtcHnw3WHiJbf
	 JcTyw3Wj+YqlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3CF25C53BBF; Tue, 19 May 2026 02:13:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Tue, 19 May 2026 02:13:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameron@vanhouzen.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220237-62941-ltuYZBucpQ@https.bugzilla.kernel.org/>
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

Cameron VanHouzen (cameron@vanhouzen.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |cameron@vanhouzen.me

--- Comment #5 from Cameron VanHouzen (cameron@vanhouzen.me) ---
Device: ASRock B850 Riptide WiFi
BIOS: 3.26 (2025-05-16)
OS: NixOS Unstable (rev d233902339c02a9c334e7e593de68855ad26c4cb)
Kernel: 6.12.89 (also tested 7.0.8)
WiFi/BT chip: MediaTek MT7925 RZ717 (PCIe ID: 14c3:0717, USB BT ID: 0e8d:07=
17)

I also am experiencing this issue, and have attempted all of the same
workarounds as Jens N. with no luck either.

dmesg output:
Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260106153314
Bluetooth: hci0: Execution of wmt command timed out
Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
Bluetooth: hci0: Failed to set up firmware (-110)

The BT device appears in lsusb as 0e8d:0717 and hci0 is created, but firmwa=
re
never loads. The device responds to the initial WMT version query but the BT
MCU version is always 0x00000000 and all subsequent
WMT patch download commands time out.

WiFi timeline from dmesg for reference in case it helps:

mt7925e 0000:08:00.0: ASIC revision: 79250000
mt7925e 0000:08:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106153007a
mt7925e 0000:08:00.0: WM Firmware Version: ____000000, Build Time:
20260106153120
mt7925e 0000:08:00.0 wlp8s0: renamed from wlan0

Firmware files present in /lib/firmware/mediatek/mt7925/:
  BT_RAM_CODE_MT7925_1_1_hdr.bin
  WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
  WIFI_RAM_CODE_MT7925_1_1.bin
(linux-firmware version: 20260410)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
