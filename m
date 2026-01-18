Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC42D73B5
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768731103; cv=none; b=oDWG0H74w5KrSf/phr13jOcaWy94Iixy1NltBWXJ4PKRttZmR49rfOpY/j61VUBuAKhsPtA6TNVSU4NKOqBgFX75V6Y8GD0DXyqxOburIpsuoimjdugjIWlNTsLYYDw+fwNQJxLNjAxZad/nCt9QxSGBa77Vvszw5pN/rX6Qjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768731103; c=relaxed/simple;
	bh=QRJDVO7ul0pMJI9rkaq0mvjAsTvDV8JJ1Mowtb5IoM0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CLzcH/B6H0jOkYgmFlM/gW+I/FGebctd+RohjudKbQ/BRCGorRn5w07pCxRAk71tK2EGhfLUb2ZsAqBeS32YmYGkTNBAqBnU98GqTMl5aJiJwQfhPWy6rBtyGSsW3PiAvU+ETF+X49U9+B5t6LYOqsxNZ2iScLCjahr4erZrFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8yHkOTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8yHkOTB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 457CCC19425
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768731103;
	bh=QRJDVO7ul0pMJI9rkaq0mvjAsTvDV8JJ1Mowtb5IoM0=;
	h=From:To:Subject:Date:From;
	b=M8yHkOTBV62LebYnnVIFo9bdnrxhCHmHwgqKeZdJ04I58eYRi3MksEMuIVuF46gCS
	 brjoD/z4ojBw9CsJyawYAMAykhZ+dClKWEzjI5R9maCXMwm2jp70no1eJD0pdmoew8
	 e1wDZ48OnWO9o2Hjo3wJA2vD2mO71FEJn8voN4dLTGzDXe51giEog0m6epV6+kOvl0
	 Xeb5PCRk4jeFRxcjKTaOTpLj8fv6gvyxdPpdutmkHfbF9yG1jbRTIXEJDGABsIEeju
	 tfxGqnBQHCtK9MH1RLnl4ts7MjNCobszvSWibhR5Ue/xkOyNuKPqzl1qUYZiWxeYW4
	 roOPz0beOmdVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3337DC4160E; Sun, 18 Jan 2026 10:11:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220990] New: hci_uart_bcm: BCM43341 on Intel Atom (serdev)
 fails init (MTU 0:0, DOWN RAW)
Date: Sun, 18 Jan 2026 10:11:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@emircanerkul.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220990-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220990

            Bug ID: 220990
           Summary: hci_uart_bcm: BCM43341 on Intel Atom (serdev) fails
                    init (MTU 0:0, DOWN RAW)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bugzilla@emircanerkul.com
        Regression: No

Created attachment 309211
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309211&action=3Dedit
fix for llm models

I applied solution in https://bugzilla.kernel.org/show_bug.cgi?id=3D100461

But now it do not detect my devices.

=E2=9D=AF bluetoothctl=20=20=20=20=20=20=20=20=20=20=20=20=20=20
hci0 new_settings: powered bondable ssp br/edr le secure-conn=20
Agent registered
[CHG] Controller CD:74:2E:6E:CD:FA Pairable: yes
[bluetoothctl]> power on
Changing power on succeeded
[bluetoothctl]> discover on
Invalid command in menu main: discover

Use "help" for a list of available commands in a menu.
Use "menu <submenu>" if you want to enter any submenu.
Use "back" if you want to return to menu main.
[bluetoothctl]> he
[bluetoothctl]> scan on
SetDiscoveryFilter success
hci0 type 7 discovering on
Discovery started
[CHG] Controller CD:74:2E:6E:CD:FA Discovering: yes
hci0 type 7 discovering off
hci0 type 7 discovering on
hci0 type 7 discovering off
hci0 type 7 discovering on
hci0 type 7 discovering off

--- ISSUE SOVED WITH 100461 ---

1. Hardware Description
Device: Intel StickPC (Atom x5-Z8300 "Cherry Trail" / "Bay Trail" platform)
Bluetooth/WiFi Chip: Broadcom BCM43341B0 (Combo Chip)
ACPI ID: BCM2E95
Interface: Intel HS-UART connected via serdev (serial0-0)
Connection: UART (not USB)


2. System Information
OS: Debian 13 (Trixie)
Kernel: 6.12.63+deb13-amd64 (Upstream 6.12 series)
BlueZ Version: 5.82
Firmware: BCM43341B0.hcd (Size: 41,333 bytes).
Verified identical to working Windows 10 driver firmware.


3. Issue Description
The Bluetooth controller is detected, and the hci_uart_bcm driver successfu=
lly
loads the specific firmware patch (build 0176). However, immediately after
firmware loading, the device remains in a DOWN RAW state with MTU 0:0.
Attempting to bring the device up fails with "Operation not supported". The
device never registers with the BlueZ management layer (btmgmt info is empt=
y).
It appears the HCI_QUIRK_RAW_DEVICE flag (set by hci_serdev.c during setup)=
 is
never cleared, or the bcm_setup function completes but the driver fails to
transition the device to a fully operational state.


4. Steps to Reproduce
Boot minimal Debian 13 with Kernel 6.12 on Intel Atom Z8300 device with
BCM43341.
Ensure correct firmware BCM43341B0.hcd is in /lib/firmware/brcm/.
Check hciconfig -a.


5. Logs & Output
hciconfig -a
hci0:   Type: Primary  Bus: UART
        BD Address: 43:34:1B:00:1F:AC  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN RAW=20
        RX bytes:2220 acl:0 sco:0 events:238 errors:0
        TX bytes:41654 acl:0 sco:0 commands:238 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1=20
        Link policy:=20
        Link mode: PERIPHERAL ACCEPT
(Note: Address is the default Broadcom address, indicating configuration di=
dn't
finish)
dmesg (Filtered)
[   10.438792] hci_uart_bcm serial0-0: supply vbat not found, using dummy
regulator
[   10.438896] hci_uart_bcm serial0-0: supply vddio not found, using dummy
regulator
...
[   10.888224] Bluetooth: hci0: BCM: chip id 82
[   10.902831] Bluetooth: hci0: BCM43341B0
[   10.902851] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0000
[   10.929324] Bluetooth: hci0: BCM43341B0 'brcm/BCM43341B0.hcd' Patch
...
[   11.551231] Bluetooth: hci0: BCM43341B0 37.4 MHz Class 1 WLBGA iTR
[   11.551245] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0176
[   11.552167] Bluetooth: hci0: BCM: Using default device address
(43:34:1b:00:1f:ac)
(Note: Firmware loads successfully - build number changes from 0000 to 0176.
But then it stops.)
btmgmt info
Index list with 0 items
Attempting to bring up
# hciconfig hci0 up
Can't init device hci0: Operation not supported (95)


6. What Was Tried (Workarounds)
Windows Firmware: Replaced Linux firmware with verified working Windows 10
driver (BCM43341B0_002.001.014.0122.0176.hcd). Result: Identical behavior.
Firmware load OK, Init fail.
Kernel Parameters: Added intel_idle.max_cstate=3D1 to prevent BayTrail deep=
 sleep
issues. Result: No change.
btattach: Attempted manual btattach but failed because serdev framework cla=
ims
the UART (serial0-0) and does not expose a /dev/ttyS* node to userspace even
after unbinding the driver.


7. Suspected Root Cause
Regression in drivers/bluetooth/hci_bcm.c or hci_serdev.c on Kernel 6.12
regarding the handling of HCI_QUIRK_RAW_DEVICE for ACPI-enumerated BCM devi=
ces.
The setup phase (firmware load) works, but the transition to operational mo=
de
is missing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
