Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10102185BE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102880; cv=none; b=gXs84yxhftUR6Q9w5qjF3gU+8VXguwKFV4q9IEhCnB6EqtGOKZ3SV8xhlKvaf9J2hOTkJ7AcYbGd4gi7lkqPwJLdUkt1+mFnaDanvZvEr2n5kwmzYn79htOCqIV6WT3L30J8/lX1bVnqkhBosgyzJqKNHl3X+obE0H7zZMXQGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102880; c=relaxed/simple;
	bh=e5NxcCWmjv2WruSKwl14eFbLIo5cRmfOhpvUyP9MiIg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sn6Z3leUaCWJoWNbByXtPX9h+RL31cU7eMrpru4ZuTiIUXTcx5nQyMS5mopFiDYohNJ6gLVyGFCc1SDDDgJxJCJGFEvNmh/te8kau90iTufpn1pwZhairrvQkm9ixydlejJFEIRj+RFEkgXWLu9D6mZDXX3xC3Q3xDWkvsWqrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIqW/ch1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIqW/ch1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F47C4CEEA
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744102877;
	bh=e5NxcCWmjv2WruSKwl14eFbLIo5cRmfOhpvUyP9MiIg=;
	h=From:To:Subject:Date:From;
	b=rIqW/ch13VU3BF+ctv+orUdbeJRCXokYbHAgUABcwi/4pbBea+gsc2btAO4jMWEML
	 ES/hqsAdcwtT6wavXehNMfw45NDYdjt2p7wbwScPXrx0+ouUw/jmNI7oJsOJZO/mS+
	 FnSbaUgfREW0x2JyuhX/2lZuPxCfP24z3mxTpilxQKI9o7dy5S5iswLzm7ERqIeGhT
	 GNzTFO50S41j7yoyrl07isVUXtmo2AArAVV8hYwpSSvGsORvzksxvu1/4IjITb2YZH
	 VeXsBQ6WQGe4Hg8IKzu5P46EzUUuc3H0kxqqBMR6ffwUv3giOxvBkuaPj2W8cDTux/
	 8b/C0sMfSxZqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 395A7C53BC5; Tue,  8 Apr 2025 09:01:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219992] New: Linux logs warning `Bluetooth: hci0: SCO packet
 for unknown connection handle 3`
Date: Tue, 08 Apr 2025 09:01:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219992-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219992

            Bug ID: 219992
           Summary: Linux logs warning `Bluetooth: hci0: SCO packet for
                    unknown connection handle 3`
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

Using Linux 6.15-rc1 with Debian sid/unstable with *bluez* 5.79-2 and a JBL=
 GO
2 speaker, Linux logs the warnings below:

    [27836.585885] Bluetooth: hci0: SCO packet for unknown connection handl=
e 3
    [27836.585889] Bluetooth: hci0: SCO packet for unknown connection handl=
e 3
    [27836.585893] Bluetooth: hci0: SCO packet for unknown connection handl=
e 3

I haven=E2=80=99t seen this before, but I also do not use the box that ofte=
n.

Also, I cannot find out, if it=E2=80=99s related to the box shutting down to
inactivity.

```
Apr 07 08:30:45.389947 abreu kernel: Linux version 6.15.0-rc1
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-19) 14.2.0, GNU =
ld
(GNU Binutils for Debian) 2.44) #19 SMP PREEMPT_DYNAMIC Mon Apr  7 08:17
:41 CEST 2025
[=E2=80=A6]
Apr 07 08:30:45.391407 abreu kernel: DMI: Dell Inc. XPS 13 9360/0596KF, BIOS
2.21.0 06/02/2022
[=E2=80=A6]
Apr 07 08:30:46.920819 abreu kernel: Bluetooth: Core ver 2.22
Apr 07 08:30:46.920859 abreu kernel: Bluetooth: HCI device and connection
manager initialized
Apr 07 08:30:46.920903 abreu kernel: Bluetooth: HCI socket layer initialized
Apr 07 08:30:46.920922 abreu kernel: Bluetooth: L2CAP socket layer initiali=
zed
Apr 07 08:30:46.920945 abreu kernel: Bluetooth: SCO socket layer initialized
Apr 07 08:30:47.008583 abreu kernel: Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000302.bin
Apr 07 08:30:47.008779 abreu kernel: Bluetooth: hci0: QCA: patch rome 0x302
build 0x3e8, firmware rome 0x302 build 0x111
[=E2=80=A6]
Apr 07 17:55:46.519507 abreu wireplumber[1450]: spa.bluez5.native: RFCOMM
receive command but modem not available: AT+CHLD=3D?
Apr 07 17:55:46.567877 abreu wireplumber[1450]: spa.bluez5.native: RFCOMM
receive command but modem not available: AT+BTRH?
Apr 07 17:55:46.743477 abreu wireplumber[1450]: spa.bluez5.native: RFCOMM
receive command but modem not available: AT+XEVENT=3D0,0
Apr 07 17:55:46.771757 abreu wireplumber[1450]: spa.bluez5.native: RFCOMM
receive command but modem not available: AT+NREC=3D0
Apr 07 17:55:48.735757 abreu gsd-media-keys[1713]: Unable to get default si=
nk
Apr 07 17:55:48.798996 abreu kernel: Bluetooth: hci0: SCO packet for unknown
connection handle 3
Apr 07 17:55:48.799164 abreu kernel: Bluetooth: hci0: SCO packet for unknown
connection handle 3
Apr 07 17:55:49.167305 abreu bluetoothd[99290]:
/org/bluez/hci0/dev_70_99_1C_BB_23_4E/sep1/fd1: fd(29) ready
Apr 07 17:55:49.183109 abreu bluetoothd[99290]:
profiles/audio/avctp.c:uinput_create() Can't open input device: No such fil=
e or
directory (2)
Apr 07 17:55:49.183121 abreu bluetoothd[99290]:
profiles/audio/avctp.c:init_uinput() AVRCP: failed to init uinput for JBL G=
O 2
[=E2=80=A6]
Apr 07 18:14:52.872325 abreu bluetoothd[99290]: Player unregistered:
sender=3D:1.64 path=3D/_1_109
[=E2=80=A6]
Apr 07 18:25:01.645509 abreu CRON[102993]: pam_unix(cron:session): session
closed for user root
Apr 07 18:25:52.495118 abreu kernel: Bluetooth: hci0: SCO packet for unknown
connection handle 3
Apr 07 18:25:52.495629 abreu kernel: usb 4-1.3: USB disconnect, device numb=
er 4
Apr 07 18:25:52.623048 abreu kernel: usb 3-1.3: USB disconnect, device numb=
er 4
Apr 07 18:25:52.954533 abreu kernel: usb 3-1.3.3: USB disconnect, device nu=
mber
6
Apr 07 18:25:52.955123 abreu kernel: usb 3-1.3.4: USB disconnect, device nu=
mber
7
Apr 07 18:30:03.815634 abreu bluetoothd[99290]:
src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free Vo=
ice
gateway: getpeername: Transport endpoint is not connected (107)
Apr 07 18:30:03.836632 abreu dbus-daemon[693]: [system] Rejected send messa=
ge,
0 matched rules; type=3D"method_return", sender=3D":1.71" (uid=3D5272 pid=
=3D1450
comm=3D"/usr/bin/wireplumber") interface=3D"(unset)" member=3D"(unset)" err=
or
name=3D"(unset)" requested_reply=3D"0" destination=3D":1.384" (uid=3D0 pid=
=3D99290
comm=3D"/usr/libexec/bluetooth/bluetoothd")
Apr 07 18:30:03.838911 abreu gsd-media-keys[1713]: Unable to get default si=
nk
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
