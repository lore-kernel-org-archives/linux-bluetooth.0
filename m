Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020B23A6
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174484; cv=none; b=E3IliZ8yn8ytGV1dJ0aLzNKCbHiTic+zDdQe3yA3O11dv+xBCPWvgonP6dgrti/Rga7V1YycPm46lH5x+NosH5uabZaPfs+uP2GGiUYG+QT/Ng1aX4KcKBwHjtvFuGn6TmupWZPZgXxMiUTS3D7EoidWiH73kqW5dUe72B/RaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174484; c=relaxed/simple;
	bh=Vs+bZSBbs/3ZmO3dGxeeN+FAC1E/NoAUDWfKy8h5GAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtmdOB8agQI9mHguOMYNR09evlTofeA+x/flKmz/0u5ISeECIQwHsTfIOcnF3KBJ/TyeVrcyyjK1473ja1e6ILX+/fnbCHlDtG2J6f1n0Req/1urd0Y+kILX87Qx2TmmgC8+xI11vGQqgmyobNT4nnf5kF4R/zd4JKctHWc9NU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK6kAF2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK6kAF2D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59DDFC4CEE1
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736174484;
	bh=Vs+bZSBbs/3ZmO3dGxeeN+FAC1E/NoAUDWfKy8h5GAQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TK6kAF2DasLbLradoZKXR1e1jAlGw6SSjxldMkPVt29g00BYZX05C9q0BduU00Lql
	 PTFEJf/VTs/gIzdg50CJ49JdRPCNg8GjpaJPdrKBu9L4Xlpwn9YKXmcaiF9M7ntmIh
	 tosIX6iG68anE3+7gcvmvB8XvJ3VNn+k168IMy9vutwXncVQrlTySWRhH9oibv8xeD
	 BawornUbWkJoSKWMU5yvoLSun5frMs/7qBm6nauBDXcgbefTbmatKxFFfrgM96MQoQ
	 JZQ8xU9WQqduo0R+tDqmlolKtCUYucpB6lUFZTYoMdJ+mXkTpRiyMR2erj5TUUqE4v
	 H7WAOxBSfeRoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50469C41616; Mon,  6 Jan 2025 14:41:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 06 Jan 2025 14:41:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olivier@croquette.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-021lkx32IH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #11 from Olivier Croquette (olivier@croquette.de) ---
I just tested with 6.12.8 and was able to resume from suspend 3 times in a =
row.
That looks good. However it took a long time to get the BT devices to work
again. From dmesg:

[  263.253098] PM: suspend exit
[  263.340683] pci_bus 0000:03: Allocating resources
[  263.348625] pci_bus 0000:03: Allocating resources
[  263.365801] r8169 0000:0b:00.0 enp11s0: Link is Down
[  263.386884] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20241106163512
[  263.395274] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-b00:00: attached PHY
driver (mii_bus:phy_addr=3Dr8169-0-b00:00, irq=3DMAC)
[  263.575549] r8169 0000:0b:00.0 enp11s0: Link is Down
[  266.524999] r8169 0000:0b:00.0 enp11s0: Link is Up - 1Gbps/Full - flow
control rx/tx
[  284.169397] Bluetooth: hci0: Device setup in 20437679 usecs
[  284.169402] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[  284.444262] Bluetooth: hci0: AOSP extensions version v1.00
[  284.444270] Bluetooth: hci0: AOSP quality report is supported
[  284.444433] Bluetooth: MGMT ver 1.23
[  292.361312] input: Logitech Wireless Mouse MX Master 3 as
/devices/virtual/misc/uhid/.../input/input24
[  292.361454] logitech-hidpp-device input,hidraw4: BLUETOOTH HID v0.15
Keyboard [Logitech Wireless Mouse MX Master 3]
[  292.387566] logitech-hidpp-device: HID++ 4.5 device connected.


So it takes around 20 seconds to setup hci0, and 8 more seconds to find the
mouse (maybe because it was in sleep mode too though).

When I resume I see a black screen for a long time, maybe the 20 seconds.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
