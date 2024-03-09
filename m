Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91615BE
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Mar 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710003171; cv=none; b=mF3uCo+M5AHIhWlxKn4UVYR2Kgu6pId9KZkDIObJ3MraZ5O2tJAOMcgMtGgAjBL7tXsuzsN5jhw7GgMD6Ecn3X95vgMS300zEM6GYWg7GkbNIwdUMee6yaxQLzpPNxVv4WIeMZOHnbiG+5iaAYstIVhQ6yRaC59kjNH6RyshY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710003171; c=relaxed/simple;
	bh=Xa9il/5rjA4KJ4eakmeIpKx7/N8tnSnBLOSC3YEMkaw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+Llv1RGnF/nRgYwmYrl5ydz8b2HE1VtWFwXFdlWKmz8JGLhUQazssTIdNrfk5CDi98f49v+P+rR1utQaY4HbCyIFEHt/tXf2IhvAABtbLoWjQOTFNY+7OtgHVqdAg74FWiwg0vAh0d7zwfXKcu6bhPRkkyBMYxVE/dpPL0k2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr19BDxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr19BDxE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 656D8C43390
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Mar 2024 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710003171;
	bh=Xa9il/5rjA4KJ4eakmeIpKx7/N8tnSnBLOSC3YEMkaw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Lr19BDxE2aeY3ebve1KEhz1ZwiICpBWLkRMq4HBk1yNsoSU9earQh02JktqKdZFd1
	 QEMnix33olgLRZH4xTIWgMzdIDJPIYbLnp+L3i6hRewPTcxaTFcN+bMyU3m/5Y/sGB
	 +CyDll6CIsB1OOaxfX2L/z6B6HE+UggZ9A4G4WDSSyXpo+o5nua7VE/v55SHr6OGvI
	 AJvnEm+HU8X54qPlpcgyQcqgV+Mblv90odM+REp9te37keA64a2a8CYCcMhhBMwD6c
	 L0YNtswXh9b5lPEEPntRmGo/5wLQ81+L1H1WFfOxVethwTuR3IscPTaaTX0byz8It9
	 43B03LIht4RBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4BD16C53BD1; Sat,  9 Mar 2024 16:52:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Sat, 09 Mar 2024 16:52:51 +0000
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
Message-ID: <bug-218416-62941-WeQvpoWLTz@https.bugzilla.kernel.org/>
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

--- Comment #7 from Nickolas Gupton (nickolas@gupton.xyz) ---
Bluetooth is still not working on boot with kernel 6.7.9 with linux-firmware
20240220

$ lsusb | grep -i bluetooth
Bus 001 Device 008: ID 8087:0029 Intel Corp. AX200 Bluetooth

$ journalctl -b | grep -E -i bluetooth
Mar 09 10:41:19 andromeda kernel: Bluetooth: Core ver 2.22
Mar 09 10:41:19 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
Mar 09 10:41:19 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
Mar 09 10:41:19 andromeda kernel: Bluetooth: HCI socket layer initialized
Mar 09 10:41:19 andromeda kernel: Bluetooth: L2CAP socket layer initialized
Mar 09 10:41:19 andromeda kernel: Bluetooth: SCO socket layer initialized
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Firmware Version:
255-255.255
Mar 09 10:41:20 andromeda systemd[1]: Reached target Bluetooth Support.
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: FW download error recove=
ry
failed (-19)
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: sending frame failed (-1=
9)
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Reading supported featur=
es
failed (-19)
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Error reading debug feat=
ures
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: sending frame failed (-1=
9)
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Failed to read MSFT
supported features (-19)
Mar 09 10:41:20 andromeda systemd[1]: Stopped target Bluetooth Support.
Mar 09 10:41:20 andromeda NetworkManager[795]: <info>  [1710002480.4767] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.46.0-2/libnm-device-plugin-bluetooth.so)
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Bootloader revision 0.3
build 0 week 24 2017
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Device revision is 1
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Secure boot is enabled
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: OTP lock is enabled
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: API lock is enabled
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Debug lock is disabled
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Minimum firmware build 1
week 10 2014
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
Mar 09 10:41:20 andromeda kernel: Bluetooth: hci0: Firmware Version:
255-255.255
Mar 09 10:41:20 andromeda systemd[1]: Reached target Bluetooth Support.
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Waiting for firmware
download to complete
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Firmware loaded in 13933=
26
usecs
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Waiting for device to bo=
ot
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Device booted in 14610 u=
secs
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Malformed MSFT vendor ev=
ent:
0x02
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Found Intel DDC paramete=
rs:
intel/ibt-20-1-3.ddc
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Applying Intel DDC
parameters completed
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: Firmware revision 0.3 bu=
ild
249 week 27 2023
Mar 09 10:41:22 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.


However, if I run this script (may take 2-3 runs sometimes) it will work:

$ cat reset_bluetooth.sh=20
modprobe -r btusb
modprobe -r btintel
sleep 2
modprobe btintel
modprobe btusb
sleep 1
systemctl restart bluetooth

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
