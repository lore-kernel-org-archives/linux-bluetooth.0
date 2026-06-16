Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0A2BE655
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649568; cv=none; b=iKwZtXiC6X5w/aAPaaURHq/2IUi+kbAzCw/NEiKTMj3p7U6KFj7hHOXdLJpVUj5TwNlKEufHXoN5YW0RHiVR/Jc0+RU9o5YP6CFAwQamV3mHkPsGym3ynbGA8zJduSS51nlkWfiE+4SwcJ3oYOcSfL7wmkLV7/FQh8geZgmpj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649568; c=relaxed/simple;
	bh=S6jbjryBJcpblXFcCwNiDGCbPIldY3Amaw0u7qFQyms=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=orTh3Y6noi2S1ukcf9G1he0TpcYNLPM3wlyiZmxh4ZBEgcHWXypReVn3AEsQ5+4oBajpl7qMctbhYavs3ydU/2CvfvNGlAtx5uAhqjpizieehY+prh3qlu8jWMl6lCtgmC2SJdJ+G8de2Tv5o6B9pCRe9YZqs5aCyPoj72DG1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmTm5CaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmTm5CaO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F918C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781649568;
	bh=S6jbjryBJcpblXFcCwNiDGCbPIldY3Amaw0u7qFQyms=;
	h=From:To:Subject:Date:From;
	b=EmTm5CaOH2eNbsy1nY/P8qSkhmr5yChHWbZLGsTy4YCwuyg6218C8aQcqXX5ZqvuK
	 VeuhMNP6NxUtCExas+wrA9mDVqNCs1/z0uu6xCX9V+zj+gMBLrYAyWkYTCgP6TnC60
	 jbJOjtdeiylI2s541ZTKWLaqSvufVuJtWyHCovwe/o/+FhkpbrPXM0rRLL9oKATXAH
	 oXGXfSv46prwiCTxNrqLzKSR+VSP6IKwLkTOvVlcihpFmE0/rGO5cCBYiBtTiuPcH+
	 Fx7J1LyM+MlOsPiUlrogAjRuJQYTWANlyTbj3kQWDkkhGJAYCvIqk5j+klCJD8E4aI
	 QCivBXMu3L/SA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 540BCC41613; Tue, 16 Jun 2026 22:39:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221660] New: btmtk (MT7921K / RZ608): BR/EDR outgoing
 connection always fails with Page Timeout (0x04); scan/receive works, same
 device pairs fine on Windows
Date: Tue, 16 Jun 2026 22:39:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bynxmusic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-221660-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221660

            Bug ID: 221660
           Summary: btmtk (MT7921K / RZ608): BR/EDR outgoing connection
                    always fails with Page Timeout (0x04); scan/receive
                    works, same device pairs fine on Windows
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.0.12-arch1-1
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bynxmusic@gmail.com
        Regression: No

Created attachment 310333
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310333&action=3Dedit
btmon HCI trace (binary + decoded) of the Page Timeout + system info

btmtk (MT7921K / RZ608): every BR/EDR outgoing connection fails with Page
Timeout (0x04). Scan/receive works, and the same device pairs fine on Windo=
ws.

HARDWARE
  WiFi+BT combo: MediaTek MT7921K (RZ608) Wi-Fi 6E, PCI 14c3:0608, driver
mt7921e
  Bluetooth function: USB 0e8d:0608 (MediaTek Inc. Wireless_Device), btusb +
btmtk
  Motherboard onboard radio, AMD desktop platform

SOFTWARE
  Kernel: 7.0.12-arch1-1 (x86_64), Arch Linux (rolling)
  linux-firmware: 20260519-1 ; linux-firmware-mediatek: 20260519-1
  BlueZ: 5.86
  BT controller firmware: HW/SW Version 0x008a008a, Build Time 202602241112=
43
  BT firmware blob loads OK: mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin

WHAT WORKS
  Controller initializes cleanly every boot ("hci0: Device setup in ~160000
  usecs", AOSP extensions v1.00). Inquiry/scan works: remote devices (a
  Skullcandy Crusher Evo headset and a Samsung TV) are reliably discovered =
with
  RSSI, so the RX path is fine.

THE BUG
  Every outgoing connection (page) to any BR/EDR device times out. HCI Crea=
te
  Connection is issued and accepted (Command Status: Success), but roughly =
7.7
s
  later the controller returns Connect Complete with Status: Page Timeout
(0x04).
  BlueZ reports org.bluez.Error.ConnectionAttemptFailed. The remote device
never
  registers a connection. The same headset on the same PC pairs and works
  perfectly under Windows, so this is not dead hardware or a peripheral iss=
ue;
  it is the btmtk/MT7921K outgoing-connection path on Linux.

KEY HCI TRACE (btmon), captured with the WiFi driver (mt7921e) UNLOADED, i.=
e.
WiFi/BT coexistence ruled out:

  < HCI Command: Create Connection (0x01|0x0005) plen 13   #9  [hci0] 14.20=
8614
          Address: 88:08:94:13:8F:94 (Skullcandy)
          Packet type: 0xcc18 (DM1/DH1/DM3/DH3 ...)
  > HCI Event: Command Status (0x0f) plen 4               #10 [hci0] 14.209=
664
        Create Connection (0x01|0x0005) ncmd 1
          Status: Success (0x00)
  > HCI Event: Connect Complete (0x03) plen 11            #11 [hci0] 21.899=
975
          Status: Page Timeout (0x04)
          Handle: 0
          Address: 88:08:94:13:8F:94 (Skullcandy)
          Link type: ACL (0x01)

  Also seen intermittently in dmesg during attempts:
  Bluetooth: hci0: ACL packet for unknown connection handle 3837

STEPS TO REPRODUCE
  1. Boot with MT7921K onboard Bluetooth.
  2. Put any BR/EDR device (e.g. a freshly factory-reset BT headset) in pai=
ring
     mode.
  3. In bluetoothctl: scan on (device IS discovered), then pair <MAC>.
  4. Pairing fails with org.bluez.Error.ConnectionAttemptFailed; btmon shows
     Connect Complete: Page Timeout (0x04).

EXPECTED vs ACTUAL
  Expected: Create Connection succeeds and pairing/bonding proceeds (as on
  Windows).
  Actual: every Create Connection ends in Page Timeout; no outgoing connect=
ion
  ever completes.

ALREADY RULED OUT
  - USB autosuspend: disabled via options btusb enable_autosuspend=3D0 (con=
firmed
    power/control=3Don). No change.
  - WiFi/BT coexistence: Page Timeout persists even with mt7921e fully unlo=
aded
    (modprobe -r mt7921e); the trace above is from that state. Also tested =
with
    rfkill block wifi. No change.
  - LE vs BR/EDR bearer: tested with and without Experimental, and with
    ControllerMode =3D bredr. No change.
  - Stale/half state: reproduced after a fresh cold boot (controller not
wedged).
  - Remote device: Crusher Evo factory-reset; nothing else paired to it
    (phone/TV BT off); works on Windows.

ATTACHMENTS
  - bt-hci-trace.btsnoop: full binary btmon capture of one failed pairing.
  - bt-bugreport.txt: full system diagnostic bundle (versions, lspci/lsusb,
dmesg).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
