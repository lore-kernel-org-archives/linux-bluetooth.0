Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804E79FC
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jsg5LDu3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F27BC433C8
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702023802;
	bh=zz5TH5TEuWQSI32c29pxwfM8lK61Ug615HVIGVb1oGg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Jsg5LDu3/ke9E/I4Ev9GGJOZ/8kI4H5p3iX9dJjjZR2jhu8LifMQwLhcPFGXbAcGp
	 jfHegf7hDAQXOmxXkbqTI4H/BL0zYTgrHusERGsoBSUn38xWX1CwyUrkskCPnjfdVd
	 w9xsv4dSdSddd2dyhAOI/l3M28OwbOIYkDO/ONYyAtFynkHc691f/ubQLwNCu89lpe
	 FKQ58FAXe8l+9eTkHGipDCFHrhIi/kPOklr48tP78LmnSGYovE6VYiyBeHi5FlamG0
	 Fidc0B/1j0xtOF0HMWH+GjQrAfy1yJol7gBsCmC+cDT0O0HwrNz9WX63CGQ1mrlYUE
	 /A2jXjMK4kz6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 55818C4332E; Fri,  8 Dec 2023 08:23:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217805] Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0:
 Failed to send headers (or body or access otp area)
Date: Fri, 08 Dec 2023 08:23:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fanf42@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217805-62941-skn5Ofei0G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217805-62941@https.bugzilla.kernel.org/>
References: <bug-217805-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217805

--- Comment #3 from Fran=C3=A7ois Armand (fanf42@gmail.com) ---
More information on that subject:=20

- the bluetooth antenna was physically disconnect from the chipset, I
reconnected it.=20

- now, I'm able to have bluetooth from an old ubuntu 22.04 live usb key,=20
- I still don't have it from a modern linux 6.6.4 arch kernel

The main difference I noticed happened when the firmware is loaded:=20

- on ubuntu, where it works:=20

Dec 08 07:00:36 ubuntu kernel: usb 1-3: new high-speed USB device number 2
using xhci_hcd
...
Decrep 08 07:00:36 ubuntu kernel: usb 1-3.1: new full-speed USB device numb=
er 3
using xhci_hcd
Dec 08 07:00:36 ubuntu kernel: usb 1-3.1: New USB device found, idVendor=3D=
10ab,
idProduct=3D9309, bcdDevice=3D 0.01
Dec 08 07:00:36 ubuntu kernel: usb 1-3.1: New USB device strings: Mfr=3D0,
Product=3D0, SerialNumber=3D0
...
Dec 08 07:00:37 ubuntu kernel: thinkpad_acpi: radio switch found; radios are
enabled
...
Dec 08 07:00:37 ubuntu kernel: thinkpad_acpi: rfkill switch
tpacpi_bluetooth_sw: radio is unblocked
....


- on the newer kernel:
Dec 08 08:54:42 lalande21185 kernel: thinkpad_acpi: radio switch found; rad=
ios
are enabled
...

Dec 08 08:54:42 lalande21185 kernel: thinkpad_acpi: rfkill switch
tpacpi_bluetooth_sw: radio is unblocked

Dec 08 07:00:3Dec 08 08:56:14 lalande21185 kernel: usb 1-3.1: new full-speed
USB device number 5 using xhci_hcd
Dec 08 08:56:14 lalande21185 kernel: usb 1-3.1: New USB device found,
idVendor=3D10ab, idProduct=3D9309, bcdDevice=3D 0.01
Dec 08 08:56:14 lalande21185 kernel: usb 1-3.1: New USB device strings: Mfr=
=3D0,
Product=3D0, SerialNumber=3D0
Dec 08 08:56:15 lalande21185 kernel: Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00130201.bin
Dec 08 08:56:15 lalande21185 kernel: Bluetooth: hci0: QCA: patch rome 0x130=
201
build 0x65e2, firmware rome 0x130201 build 0x38e6
Dec 08 08:56:15 lalande21185 kernel: Bluetooth: hci0: Failed to send headers
(-71)
Dec 08 08:56:15 lalande21185 kernel: usb 1-3.1: USB disconnect, device numb=
er 5
8 ubuntu kernel: Bluetooth: hci0: using NVM file: qca/nvm_usb_00130201_gf.b=
in



Could it have something to do with the `thinkpad_acpi` module? The exact ro=
me
build is not the same too, which is expected I think for a newer kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
