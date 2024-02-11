Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7015A8
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Feb 2024 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707683539; cv=none; b=M4pqEdtZzF0saKTfU6fc2up8oWEAjdEHkeUy73IgogmPlnBGjzAsGKZg4LBXSQ985+7RTW24WMhrUxGs8/cbOW92qLbjHAKZEsgtlIoIGNXAh5HMEtq+yBrWeX98xaOgPTe59wDAa5n8IyMlRYgcuNDL3RDEYjniIlHDVDBk4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707683539; c=relaxed/simple;
	bh=aJ203YQ+VG5l8cj3cSrWU0XaKmmnOEmHEibMHWdisLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNDZ2BqBFRh8fTVeFh3U+cmK9DAz/hN2P8IkHSx+iicJFbiVGONdV/gUubngp3y4hNBSbkinfRPAxtrUVd8MQR2+4370dOalwj5LC2wmUNBvRrmFFdOc7hfpoSAdKd9ZU9QEgXFwoSvF7h6VZaNtDdUQ+m2ANil9aEGazQ+Jwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVyxopwG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVyxopwG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D66A8C433F1
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Feb 2024 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707683538;
	bh=aJ203YQ+VG5l8cj3cSrWU0XaKmmnOEmHEibMHWdisLs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZVyxopwGsRsQZ3Ny4KTQmipNyYaaiNBwUzl9QOoTal7+ABFffrm/bYUXld/IV9cdp
	 HoM0kAcYS+aovK3tGEduTGGUWDuc5zgk2oQHbJmoPY+rtH71gVuTwSFwK3Ak8A7up+
	 ejjeKktG7zUXwmMxmiu+wlWMFW5OdkeNe8PLJ7NnhwjbnyHkRf4P70zI1He6NkRvZW
	 Sc1r/UqQ0gWS6oVRC8KiUxYm04IShNZ6LaTtbRBCXht6ldMl183/njYhj5oZnaivDn
	 UDC1rLRrF/G1B1CxyPnB0czCPJSAFjnlKPL9pLRBzkCYNOBtv1U4dipWK2eYdUeIgQ
	 EMEjqqM6ZdOhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BFD6BC53BD0; Sun, 11 Feb 2024 20:32:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Sun, 11 Feb 2024 20:32:18 +0000
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
Message-ID: <bug-218416-62941-gDHP8vSEfD@https.bugzilla.kernel.org/>
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

--- Comment #5 from Nickolas Gupton (nickolas@gupton.xyz) ---
Bluetooth still does not work with 6.7.4, however the logs have changed from
the error that was shown before:

$ journalctl -b | grep -E -i bluetooth
Feb 11 14:27:14 andromeda kernel: Bluetooth: Core ver 2.22
Feb 11 14:27:14 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
Feb 11 14:27:14 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
Feb 11 14:27:14 andromeda kernel: Bluetooth: HCI socket layer initialized
Feb 11 14:27:14 andromeda kernel: Bluetooth: L2CAP socket layer initialized
Feb 11 14:27:14 andromeda kernel: Bluetooth: SCO socket layer initialized
Feb 11 14:27:14 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Feb 11 14:27:14 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
Feb 11 14:27:14 andromeda kernel: Bluetooth: hci0: Firmware Version:
255-255.255
Feb 11 14:27:15 andromeda systemd[1]: Reached target Bluetooth Support.
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: FW download error recove=
ry
failed (-19)
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: sending frame failed (-1=
9)
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Reading supported featur=
es
failed (-19)
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Error reading debug feat=
ures
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: sending frame failed (-1=
9)
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Failed to read MSFT
supported features (-19)
Feb 11 14:27:15 andromeda systemd[1]: Stopped target Bluetooth Support.
Feb 11 14:27:15 andromeda NetworkManager[781]: <info>  [1707683235.5366] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.44.2-3/libnm-device-plugin-bluetooth.so)
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Bootloader revision 0.3
build 0 week 24 2017
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Device revision is 1
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Secure boot is enabled
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: OTP lock is enabled
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: API lock is enabled
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Debug lock is disabled
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Minimum firmware build 1
week 10 2014
Feb 11 14:27:15 andromeda systemd[1]: Reached target Bluetooth Support.
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Boot Address: 0x24800
Feb 11 14:27:15 andromeda kernel: Bluetooth: hci0: Firmware Version:
255-255.255
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Waiting for firmware
download to complete
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Firmware loaded in 13862=
06
usecs
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Waiting for device to bo=
ot
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Device booted in 14608 u=
secs
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Malformed MSFT vendor ev=
ent:
0x02
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Found Intel DDC paramete=
rs:
intel/ibt-20-1-3.ddc
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Applying Intel DDC
parameters completed
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: Firmware revision 0.3 bu=
ild
249 week 27 2023
Feb 11 14:27:17 andromeda kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit
is set, but its usage is not supported.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
