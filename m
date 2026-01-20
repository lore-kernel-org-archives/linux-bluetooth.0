Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB353E9F8F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948538; cv=none; b=oDZJzqnC3eeJk2NvkhtdVvzjbypUfuerxza808sU6em6OTR94P0Q15G9fOnihkX6pOwtuexDgeo+p+jK1y6aUy/uQueF30X+ZRzKSRDT7IlF7K8AQ4NQ2maxYORL1mO4Jpgx3JzfQt0BOJad662mZOQkUGoBbk2HrINb8DUfT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948538; c=relaxed/simple;
	bh=+aFp34IhC8Eep6BdhtnpWwkGm2j4IZkfEZzm0DpxHVI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gh+fJYF+5jeINhQNuW9NYt2sxH4DE8PMY3TLjeRXjxMyJDah0wTTPRQrLYdgp6rYl6U4o9KBFlb76E5AXV8C/MKmzA2XVQZ3pGTSoMHVz77fIeZOE/YIw15S1ddRZTYtPG9Q0RpQbtB+OV2W4z2XPT8o0pL78TD8EVW0ffAoDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlPNAolV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlPNAolV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F348C19425
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768948537;
	bh=+aFp34IhC8Eep6BdhtnpWwkGm2j4IZkfEZzm0DpxHVI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SlPNAolV5PiuOZovmydq6DafkROMLZLFBuikwBJfUtA8zM0aNAxRH715PPQtrFJYw
	 JdO661SFvi7KcH92rcF3k/tqiuPgKQSSE8E6ZozoT7OW/x0pmY0Lgy+pEdDyTpwNwp
	 55hLrxDkwUtJtqS83pgFlk/TD9xPp1qt3yl/dCiq6UDmLU+/mnf+CSZ/Z1YFsmPDhP
	 6CesXqCCqxIK3kOiuSThGdXcBHpa9e751G7Z8gVMN17+s0NMGlLCS1M7saHkM0fE9E
	 RY4WgM/4skiS4Jx8l2ZbFANdDvLkiU0OVT3XEMy1VZEqk8OEy8Dnx6E5TWrL/iIupR
	 ACCB0F813YMVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 74439C41612; Tue, 20 Jan 2026 22:35:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220986] MediaTek MT7925 Bluetooth adapter (USB 13d3:3596) fails
 to initialize - reports as unsupported hardware variant 0x7902
Date: Tue, 20 Jan 2026 22:35:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aamolodc@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220986-62941-9impvx8YKg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220986-62941@https.bugzilla.kernel.org/>
References: <bug-220986-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220986

--- Comment #3 from Alex (aamolodc@gmail.com) ---
additional context:

## What I've Tested (2026-01-21)

**1. Applied the USB ID blacklist fixes:**
- Installed libmtp-1.1.22-2.fc43.x86_64 (includes 13d3:3596 blacklist)
- Installed libgphoto2-2.5.33-1.fc43.x86_64 (includes 13d3:3596 blacklist)

**2. Performed full cold boot:**
- Shut down completely (not reboot)
- Unplugged power cable for 30+ seconds to clear hardware state
- Booted directly to Linux (did not boot Windows first)

**3. Verified Windows functionality:**
- Rebooted to Windows 11
- Bluetooth works perfectly (can pair devices, transfer files, etc.)
- This confirms the hardware itself is not defective

**4. Returned to Linux:**
- Bluetooth still fails with the same error

## Current Behavior in Linux

Bluetooth fails immediately at boot, before any desktop environment loads:

```
[   19.247336] Bluetooth: hci0: Opcode 0x0c03 failed: -110
```

Technical details:
- USB device is detected: `Bus 001 Device 003: ID 13d3:3596 IMC Networks
Wireless_Device`
- btusb driver binds to the device correctly
- hci0 device is created in `/sys/class/bluetooth/`
- Firmware file exists:
`/lib/firmware/mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin`
- **Problem:** HCI_Reset command times out (error -110 =3D ETIMEDOUT)
- The chip does not respond to any HCI commands from the Linux driver
- Firmware loading is never attempted because the driver fails before that
stage

## Why This Is Different From Bug #220682

**Bug #220682 (USB ID 0489:e111):**
- Bluetooth worked after boot
- Failed only after user logged into GNOME desktop
- Caused by libmtp/libgphoto2 probing the device during desktop startup
- **Fixed** by blacklisting the USB ID in libmtp/libgphoto2

**This bug #220986 (USB ID 13d3:3596):**
- Bluetooth never works, not even for a moment
- Fails at boot time, before any desktop environment starts
- Fails even with libmtp/libgphoto2 blacklists applied
- **Not fixed** by the package updates

## Root Cause

There are TWO separate issues affecting USB ID 13d3:3596:

1. **USB ID conflict** (shared with bug #220682) - RESOLVED by package upda=
tes
2. **Kernel driver initialization failure** (unique to this bug) - UNRESOLV=
ED

The btusb driver cannot communicate with the MT7925 chip at the hardware le=
vel.
Since the same hardware works perfectly in Windows, this indicates the Linux
driver is missing vendor-specific initialization code or using an incorrect
initialization sequence for this particular chip variant.

## Why Hardware Defect Is Ruled Out

- Device works perfectly in Windows 11 (Bluetooth pairs, connects, transfers
data)
- WiFi portion of the same combo card works in Linux (mt7925 driver)
- USB device is detected and enumerated correctly in Linux
- This is a software/driver issue, not hardware

## Request

Please reopen this bug as a kernel driver issue. The libmtp/libgphoto2 fixes
from bug #220682 are necessary but not sufficient to make this device work.

**System Information:**
- OS: Fedora Linux 43 (Workstation Edition)
- Kernel: 6.18.5-200.fc43.x86_64
- Hardware: MediaTek MT7925 Bluetooth/WiFi combo (Filogic 310)
- USB ID: 13d3:3596 (IMC Networks)
- Subsystem: AzureWave 6040
- Motherboard: ASUS TUF GAMING B650M-E WIFI

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
