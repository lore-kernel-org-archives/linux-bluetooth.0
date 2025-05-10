Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731F1EB9E1
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 May 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746874654; cv=none; b=C01JTEjMY5e07OAhYPbwvyk87E9A6JHPBfl1ZB/4VGngzk+dD3BRxUMe/x67JMgw2SdOJrqzyAdFshhTEG7R5Lu6mJWBK5ny1MmzMvlp/pRPBk/TsaCQunZRWL3spFS/ZeNGfFUZmVRDXoVUB/D81Sj6AXZnjnGKi80kmgLtZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746874654; c=relaxed/simple;
	bh=hLDSkQ1Lmi032C0PXCUuHvfdFW47/gyQImJXywadTgk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AkxNPBBtg8otsQGbiYBp5ykStAxqC7v0JunsiMc6jvN2ij2pPkN6ifGf4p6HGbVvQDyrhRRlRl1qrxZqVqlekBYeslHRh+6ZQNCZqXyyj4pxIKS8JmsTueNX8FaXmv2qBFSv5YsEcmlulTr26P3prlnMQyFWR91Bd7YzHA5z9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfkfGpBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfkfGpBm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 073CDC4CEE2
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 May 2025 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746874654;
	bh=hLDSkQ1Lmi032C0PXCUuHvfdFW47/gyQImJXywadTgk=;
	h=From:To:Subject:Date:From;
	b=GfkfGpBmWYSnHhHhvAXo9C4uIIh+IHS5D1wFg4k3jbeRdzRf6mqfqkjL0VHNDrgj3
	 vGssBd7djlDxwzGw/noiyiDOTxwRgP8bgZRtig2ITe31gzYY0t6G7JarRbeHqedljI
	 gMoVhd9FDVCXHPL+MXa8cM0qn85XLKVrO0NgWnRKxH/ffLwQzYXaP0tljBAUokq5WH
	 H9BWHrqGDzStL87eajr4VgmkH4qwg6/B5TtFJ3RPuS22v2EP3dS/gHUSxI6dPY/Y+i
	 BQR+2m9ndEN3y7w6xbUMCMPFNmgot22TU5AFo1C959hBp2wfwBnRjx/OqnsGfY5zwB
	 zWNunAcu+/rMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E69E0C41613; Sat, 10 May 2025 10:57:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220104] New: AX200 Bluetooth scan not finding any device
Date: Sat, 10 May 2025 10:57:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steph@combo.cc
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220104-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220104

            Bug ID: 220104
           Summary: AX200 Bluetooth scan not finding any device
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: steph@combo.cc
        Regression: No

Similar to https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

Wifi works perfectly, Bluetooth is unable to find any device in range.

[   20.987218] Bluetooth: Core ver 2.22
[   20.987402] NET: Registered PF_BLUETOOTH protocol family
[   20.987404] Bluetooth: HCI device and connection manager initialized
[   20.987410] Bluetooth: HCI socket layer initialized
[   20.987412] Bluetooth: L2CAP socket layer initialized
[   20.987418] Bluetooth: SCO socket layer initialized
[   21.045572] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[   21.046582] Bluetooth: hci0: Device revision is 1
[   21.046584] Bluetooth: hci0: Secure boot is enabled
[   21.046584] Bluetooth: hci0: OTP lock is enabled
[   21.046585] Bluetooth: hci0: API lock is enabled
[   21.046585] Bluetooth: hci0: Debug lock is disabled
[   21.046586] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   21.084423] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[   21.084528] Bluetooth: hci0: Boot Address: 0x24800
[   21.084530] Bluetooth: hci0: Firmware Version: 132-3.24
[   22.707858] Bluetooth: hci0: Waiting for firmware download to complete
[   22.708555] Bluetooth: hci0: Firmware loaded in 1586062 usecs
[   22.708579] Bluetooth: hci0: Waiting for device to boot
[   22.723613] Bluetooth: hci0: Device booted in 14688 usecs
[   22.726204] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-20-1-3.ddc
[   22.727572] Bluetooth: hci0: Applying Intel DDC parameters completed
[   22.728584] Bluetooth: hci0: Firmware revision 0.3 build 132 week 3 2024
[   22.730608] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.
[   22.987705] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.987708] Bluetooth: BNEP filters: protocol multicast
[   22.987711] Bluetooth: BNEP socket layer initialized
[   22.988651] Bluetooth: MGMT ver 1.23
[   31.369502] Bluetooth: RFCOMM TTY layer initialized
[   31.369510] Bluetooth: RFCOMM socket layer initialized
[   31.369514] Bluetooth: RFCOMM ver 1.11

Linux tranquility 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri May  2
14:16:46 UTC 2025 x86_64 GNU/Linux

05:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)

Bus 001 Device 004: ID 8087:0029 Intel Corp. AX200 Bluetooth

-------

btmon during a scan:

Bluetooth monitor ver 5.81
btmon[4527]: =3D Note: Linux version 6.14.5-300.fc42.x86_64 (x86_64)=20=20=
=20=20=20=20=20=20=20=20=20=20=20
                             0.289254
btmon[4527]: =3D Note: Bluetooth subsystem version 2.22=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                             0.289256
=3D New Index: 2C:7B:A0:FD:5F:42 (Primary,USB,hci0)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                      [hci0] 0.289256
=3D Open Index: 2C:7B:A0:FD:5F:42=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
                      [hci0] 0.289256
=3D Index Info: 2C:7B:A0:FD:5F:42 (Intel Corp.)=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                      [hci0] 0.289257
bluetoothd[1533]: @ MGMT Open: bluetoothd (privileged) version 1.23=20=20=
=20=20=20=20=20=20=20=20=20=20
                    {0x0001} 0.289258
bluetoothd[1533]: @ MGMT Command: Start Discovery (0x0023) plen 1=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
             {0x0001} [hci0] 5.348230
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                   #1 [hci0] 5.348283
        Address: 31:AC:6B:25:AC:38 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                    #2 [hci0] 5.445399
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8=20=20=
=20=20=20=20=20=20=20=20=20=20
                   #3 [hci0] 5.445453
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 22.500 msec (0x0024)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                    #4 [hci0] 5.447397
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
                   #5 [hci0] 5.447435
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                    #6 [hci0] 5.449397
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
             {0x0001} [hci0] 5.449431
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
< HCI Command: Inquiry (0x01|0x0001) plen 5=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
                   #7 [hci0] 5.449439
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>                    #8 [hci0] 5.461352
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
             {0x0001} [hci0] 5.461399
      Start Discovery (0x0023) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
bluetoothd[1533]: @ MGMT Command: Stop Discovery (0x0024) plen 1=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
            {0x0001} [hci0] 15.547574
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                  #9 [hci0] 15.547595
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                  #10 [hci0] 15.643174
      Inquiry Cancel (0x01|0x0002) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
                 #11 [hci0] 15.643307
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                  #12 [hci0] 15.656176
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
            {0x0001} [hci0] 15.656251
      Stop Discovery (0x0024) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
            {0x0001} [hci0] 15.656256
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
