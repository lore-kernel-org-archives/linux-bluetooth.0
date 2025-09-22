Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40247179A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538057; cv=none; b=DDpT11gFouW/U5N8kvq4hoe+dzUSKkLESCryKXWfaBHx6JLxviZco5GpYC5y8iWv7fmgfal6YQeDAPW3Hza0Hv5IW3KnvIBrc3KfFOeVxqov64xKjrifxxNC/WomuQm9Lt+UstkB4kMqPjRLjAgdnaHjWR95Fx9gSZm3aAoMTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538057; c=relaxed/simple;
	bh=a/CpA7+13avu23keQrM+KAcPC62vuJvA2K9oXRZvugY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lTXviJtx3Av5Tf/Jjx/IHkznD3U8S1O7P3pMXEjs2Uzc+VfXJg+0raxMuOFCtT4KrVXaoqh52BnIht3RUbCqSmljt0ih1lbNo6GJzIr9/kCEKsa+I4hSzUwDUnTh02h7vVEBlzoD7Ccdv/kvyr5RiMsvIZIHJnJU8OCPJ0lSD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTiDsZJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTiDsZJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16569C4CEF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758538057;
	bh=a/CpA7+13avu23keQrM+KAcPC62vuJvA2K9oXRZvugY=;
	h=From:To:Subject:Date:From;
	b=aTiDsZJ2uyshjHoJXf8JPuP5zGuvR1blAB9InC1pe1lAPJdXxFeKUxU0w0PVLHzMk
	 a4ZtzQFoQuT7zr0XsyNqNhLZjqc904Yu0gTh7aIU1cPRcAfFjRh+lzgCenZ+oCNt6u
	 1XqXVSgcQt6M9fijjhZS5Tb4vGMLyuqBL99RhAKgGrehCo2rFaSZaPxGKAox4rqmaZ
	 F9xR3ZytMj2CQoC+vs/xHoQQmuZrYqELr42ZMdKqVt/mz+by36Sny4QN0Pwm7mo8ZX
	 2r2dyiRmGju8NAui7KJ968GdZuGwgNj9bs049EwrocKeXQkwcZAij6CTPls82GLMqc
	 Z2F9DF0IUFcBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 04B18C433E1; Mon, 22 Sep 2025 10:47:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220593] New: Bluetooth hardware error 0x0c causes Sony
 WH-1000XM5 disconnection and reconnect with SCO packet errors
Date: Mon, 22 Sep 2025 10:47:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tom.kernel@bocek.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220593-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220593

            Bug ID: 220593
           Summary: Bluetooth hardware error 0x0c causes Sony WH-1000XM5
                    disconnection and reconnect with SCO packet errors
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: tom.kernel@bocek.ch
        Regression: No

Running Arch Linux 6.16.8-arch1-1 kernel with Sony WH-1000XM5 headphones.

Bluetooth hardware error 0x0c causes Sony WH-1000XM5 disconnection and
reconnect with SCO packet errors.

Intel Bluetooth controller (idVendor=3D8087, idProduct=3D0aaa) experiences =
hardware
failure during active connection, requiring USB reset and firmware reload.

Kernel log:

[ 1949.394632] input: WH-1000XM5 (AVRCP) as /devices/virtual/input/input34
[ 2062.687478] Bluetooth: hci1: Hardware error 0x0c
[ 2064.717922] Bluetooth: hci1: command 0x0c03 tx timeout
[ 2064.717934] Bluetooth: hci1: Initiating acpi reset method
[ 2064.717938] Bluetooth: hci1: Reset after hardware error failed (-110)
[ 2064.720935] usb usb1-port10: disabled by hub (EMI?), re-enabling...
[ 2064.720945] usb 1-10: USB disconnect, device number 13
[ 2065.328888] usb 1-10: new full-speed USB device number 14 using xhci_hcd
[ 2065.454060] usb 1-10: New USB device found, idVendor=3D8087, idProduct=
=3D0aaa,
bcdDevice=3D 0.02
[ 2067.155625] Bluetooth: MGMT ver 1.23
[ 2105.762182] input: WH-1000XM5 (AVRCP) as /devices/virtual/input/input35
[ 3548.063386] Bluetooth: hci2: SCO packet for unknown connection handle 257

linux-firmware 20250917-1
Controller: Intel Bluetooth (8087:0aaa)
kernel: 6.16.8

See here: https://github.com/StarLabsLtd/firmware/issues/313

Best regards,

Thomas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
