Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61241272814
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061898; cv=none; b=FhWyGh4WwDvGdVswDknFUeLR7czc90AnbeS6CeKkCxWIoHYHyZogfSYalSps8Mz4DvE+kx2BdH5Ib60ZrLR40XP6m1FSy/NltRo2TakA179eCL39uelXlzUjF85jTCTExtBFwa94dV92zQyPxpP6oBQ8P2ZK5vN5qceH8EevENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061898; c=relaxed/simple;
	bh=kmYh3o565weDwTulLHhn8uherYszrIdIF/xrfPKWT3g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cehbDjP1I510jDoUbUzBZmrxhurqkoWSF9oBs9uDC9Hnc2AIrMhmYsDqOrrSvZykAEeqZs2nrBHCTHwFz+JhNdsAJ6qn5wPT7S6wrp0a4epBv0mljMxm2bSsMqU7xCeRcx84X+tjrVvkxYie6l8v54ykJ2K6a8W2G7iWyOhk/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMXy1qQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMXy1qQq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8188C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754061897;
	bh=kmYh3o565weDwTulLHhn8uherYszrIdIF/xrfPKWT3g=;
	h=From:To:Subject:Date:From;
	b=BMXy1qQqhusNUlAmA8IcfpLHRaHSdxNOzTPVCwdZPFG44HlDyYc1E6c6wiR3VTdRN
	 y/I8SW7/s6/5PiHNRZnNiR45URIoD+1hU+PtQxSP2Q/onLlFg7WUb66PJg+icIM/M6
	 jDp5sUS1vXDUFcnH+D0/45mE5NZ9CJVZMTGk12ltT5PDigOj8DitiOMZN2ZFtvinJG
	 uigKaAxYfQ/u3BsGV65tJJp87KaWn/RwJL7za6/iMKZ2lgv3OIL6uBU3v4Sk0kqHbS
	 VZrEcI1WOzktsPET8nhzGGO/bNl3hagP71htq8WyHfd2DQEiADBnqdcplHZxp4waaP
	 JD6aj52uAS6Wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97045C433E1; Fri,  1 Aug 2025 15:24:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220391] New: Headset is disconnected immediately
Date: Fri, 01 Aug 2025 15:24:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: antti.garding.oss@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220391-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220391

            Bug ID: 220391
           Summary: Headset is disconnected immediately
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: antti.garding.oss@gmail.com
        Regression: No

Created attachment 308433
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308433&action=3Dedit
Output of dmesg after a boot-up and an attempt to connect the headset and
output of btmon

A little foreword as this is not an issue with the upstream kernel... I ask=
ed
about this issue on the linux-bluetooth mailing list and was told to create=
 a
bug report here in order to share logs. What follows in this report is what=
 I
originally wrote on that mailing list.

I am having a issue using my Bluetooth headset (Sony WH-1000XM3) in
Linux. When I turn it on, the headset is immediately connected, but
after that, it is also immediately disconnected. This
connect-disconnect is automatically repeated three times with some
seconds between the occasions.

My environment is a Lenovo Thinkpad E14 Gen 4 laptop running Xubuntu
22.04. The computer has an integrated WLAN + Bluetooth adapter based
on Intex AX201, connected on USB bus. WLAN works fine and also the
Bluetooth works when running Windows. I have read on Intel=E2=80=99s forum
that the driver for the chip should have been ok since kernel version
5.10. My distribution comes with 6.8 so this issue shouldn=E2=80=99t be abo=
ut
that.

Log time ago, I managed to pair the headset and it is still listed as
a paired device. Trying to unpair it in the bluetoothctl console
results in error message saying the device doesn=E2=80=99t exist.

Here is what happens in bluetoothctl console when I try to connect the
headset manually:

[bluetooth]# connect 38:18:4C:D4:C2:94
Attempting to connect to 38:18:4C:D4:C2:94
[CHG] Device 38:18:4C:D4:C2:94 Connected: yes
Failed to connect: org.bluez.Error.Failed br-connection-canceled
[CHG] Device 38:18:4C:D4:C2:94 Connected: no
[CHG] Device 38:18:4C:D4:C2:94 Connected: yes
[CHG] Device 38:18:4C:D4:C2:94 Connected: no
[CHG] Device 38:18:4C:D4:C2:94 Connected: yes
[CHG] Device 38:18:4C:D4:C2:94 Connected: no

Here are some log prints related to Bluetooth in general:

sudo dmesg | grep -i blue
[    2.899284] Bluetooth: Core ver 2.22
[    2.899534] NET: Registered PF_BLUETOOTH protocol family
[    2.899535] Bluetooth: HCI device and connection manager initialized
[    2.899574] Bluetooth: HCI socket layer initialized
[    2.899593] Bluetooth: L2CAP socket layer initialized
[    2.899601] Bluetooth: SCO socket layer initialized
[    2.951909] Bluetooth: hci0: Device revision is 2
[    2.951914] Bluetooth: hci0: Secure boot is enabled
[    2.951915] Bluetooth: hci0: OTP lock is enabled
[    2.951916] Bluetooth: hci0: API lock is enabled
[    2.951917] Bluetooth: hci0: Debug lock is disabled
[    2.951918] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    2.951920] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype
1 build 38
[    2.952008] Bluetooth: hci0: DSM reset method type: 0x00
[    2.960708] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4150.=
sfi
[    2.960752] Bluetooth: hci0: Boot Address: 0x100800
[    2.960754] Bluetooth: hci0: Firmware Version: 107-51.22
[    3.272512] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio
is blocked
[    4.012759] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.012763] Bluetooth: BNEP filters: protocol multicast
[    4.012770] Bluetooth: BNEP socket layer initialized
[    4.684563] Bluetooth: hci0: Waiting for firmware download to complete
[    4.684902] Bluetooth: hci0: Firmware loaded in 1683777 usecs
[    4.685041] Bluetooth: hci0: Waiting for device to boot
[    4.700965] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    4.701034] Bluetooth: hci0: Device booted in 15702 usecs
[    4.701904] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-4150.ddc
[    4.704071] Bluetooth: hci0: Applying Intel DDC parameters completed
[    4.707146] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1
build 56683
[    4.707151] Bluetooth: hci0: Firmware SHA1: 0xe2305c5c
[    4.776168] Bluetooth: MGMT ver 1.22
[    6.448715] Bluetooth: RFCOMM TTY layer initialized
[    6.448724] Bluetooth: RFCOMM socket layer initialized
[    6.448727] Bluetooth: RFCOMM ver 1.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
