Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C645BF6
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604291; cv=none; b=if17PurO2oVNcuXJRlCJeR03Uqgqc7D8LgTGBMUdUzMwDMZl7Md51qOKt4UkwvwEmvFp+vtLVPO+yNjEyS3XmEAGLtejyS31oIHEiBSOqRKmJ0IH6OD1IfHXHSkT/q9Z1LffvTW2gFl3ZZ6rMc9+NXxVXNoB8cngUPRRy9A7J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604291; c=relaxed/simple;
	bh=aiVPSswc/TQmL2rCQf7rgqmBzYOLeNU0nu0Lq2gPWk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AvRscSxFo0JYsvxhs0x7sAHLiLSmhKGZxDZcI0T4kzkoQ1ADU6KOl7h19TbeaNzuDD/NksCwVKWD/8jaysHhYi1VacpMnUkmvnJqxuFd++MD9AbbVcXlIpFQoilCRcdUQGvj1PNkpR+OAv5tCfmvsN7yZeMN4z+wnlrR0pSJHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDa7b9T3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDa7b9T3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86278C43394
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604289;
	bh=aiVPSswc/TQmL2rCQf7rgqmBzYOLeNU0nu0Lq2gPWk8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nDa7b9T3rgG6ejHezhBWA03uqPLgFKiea1I/AyexGRfbADUb9fPKbn/qg1p5ebzMr
	 m9dStZ1+OcE0qpU79G75jNm8ch9ZU76+1i8wAHX4vjpMK3x/dx+SYUbPbo0IkLR5rd
	 YEZVf6hAaAGyK3V6zH6ScaZL8umhqojI93nPMSWzqjYEQhgX+USViUjkhTLLoXryZj
	 gjEaOYBS/LG2AZG8aBEO5ATzGzT7aq6BMmeMAIqaDs0c78veILahCAc4/gs+jvOITP
	 COdYTa+u0g151diCLob6pYuDopGQe4gvKAXxyODNIEcxPDUjmHUt501z1rRoOrj4ox
	 0NkfJpj1Xw6nQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 71927C53BD4; Thu, 22 Feb 2024 12:18:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date: Thu, 22 Feb 2024 12:18:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-86931-62941-iQ7HRfTFNP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D86931

--- Comment #11 from Christian Kujau (kernel@nerdbynature.de) ---
Happens here with an Apple Magic Mouse A1296:

kernel: magicmouse 0005:05AC:030D.000D: unknown main item tag 0x0
kernel: input: Maus as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:512/0=
005:05AC:030D.000D/input/input34
kernel: magicmouse 0005:05AC:030D.000D: input,hidraw4: BLUETOOTH HID v3.06
Mouse [Maus] on e4:70:b8:3f:cc:93

$ hwinfo --bluetooth
09: USB 00.0: 11500 Bluetooth Device=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  [Created at usb.122]
  Unique ID: X7GA.GS0ueMFUyi1
  Parent ID: k4bc.2DFUsyrieMD
  SysFS ID: /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0
  SysFS BusID: 1-7:1.0
  Hardware Class: bluetooth
  Model: "Intel Bluetooth wireless interface"
  Hotplug: USB
  Vendor: usb 0x8087 "Intel Corp."
  Device: usb 0x0a2b "Bluetooth wireless interface"
  Revision: "0.10"
  Driver: "btusb"
  Driver Modules: "btusb"
  Speed: 12 Mbps
  Module Alias: "usb:v8087p0A2Bd0010dcE0dsc01dp01icE0isc01ip01in00"
  Driver Info #0:
    Driver Status: btusb is active
    Driver Activation Cmd: "modprobe btusb"
  Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown
  Attached to: #14 (Hub)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
