Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB830AD1A
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592250; cv=none; b=dYCkUcz6QikFj83mAWrnNS36hWIRj5N4qQp6LtfAdFtgvzy575O7+C378ll3OLWDDEsP17jfcdBBEYq10QE+Lgw7DMD5HBQvmL/HhYll6TcThJC7Tak7L+VIn4l+89BkHtC/fG0M+9a97buufYd5aD9MWDhRCt9IPEIbURVdY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592250; c=relaxed/simple;
	bh=h1cvaT160iXcCfhFF1/NWTWT4UpWr21dkt1sDe+vPkk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qiAVxeLNcDtZdq+X0pAtcs5qBiFDl5rgmN2bJ/0/qYWfp8xMXmqPhci0KvBWt0kQt3B7EAi/8+Z7hmlSLpyHe9jgbnZq9ixNwEh9Ol9ah9wP4iamqFXr43g8GD1homrDKSF317D2SgbnE/aoDKnvproHNw7Y8jJUIVoxw6lMEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA6JkJQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA6JkJQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B5B2C19425
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 03:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786592249;
	bh=h1cvaT160iXcCfhFF1/NWTWT4UpWr21dkt1sDe+vPkk=;
	h=From:To:Subject:Date:From;
	b=oA6JkJQ7V67/b7h8ufPT47REK2CUkToqow35HIr0IRDcxJz7NW/HCTDxThZ5l6V07
	 aEwLbOHiW+HnahjG8IfCeuPPa5c3bTp1P7+q9rUWXBcTyEQv7eFHNbxZ+xls5xVP4U
	 da86ubbhr4FS58MMZwIaaXuprDVEpCBrphRh/6467a0vYvEHqhS1sx/IHq6GcUNg5O
	 cQ/jks3xR8ENN7aeAgDGT4GrN+8zFrfdMUcNK2Gl1FDmjLeba2dV1e6L8RHJZPfB10
	 XOoGyx0CFd9PQ5mb15SVMCkkZoYVZ7CqyGX4WEKD/jAJ5o/QEfS2yASMTWskwz73l7
	 c0j77ptS995lA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 71404C4160E; Thu, 13 Aug 2026 03:37:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221876] New: btusb misidentifies Realtek 13d3:3556 as Broadcom
 (IMC Networks wildcard match)
Date: Thu, 13 Aug 2026 03:37:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alejodelarco@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221876-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221876

            Bug ID: 221876
           Summary: btusb misidentifies Realtek 13d3:3556 as Broadcom (IMC
                    Networks wildcard match)
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: alejodelarco@gmail.com
        Regression: No

# Bug Report: btusb misidentifies Realtek 13d3:3556 as Broadcom (IMC Networ=
ks
wildcard match)

## Summary
The `btusb` driver's generic IMC Networks match rule
(`USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01)` =E2=86=92
`BTUSB_BCM_PATCHRAM`) catches a Realtek-based IMC Networks Bluetooth adapter
(`13d3:3556`) that has no specific entry in the Realtek ID table. As a resu=
lt,
no vendor firmware is loaded and no Realtek-specific quirks are applied. The
adapter operates in a degraded/generic mode, causing consistent BR/EDR pair=
ing
and connection failures (`br-connection-key-missing`) even though the link =
key
is present in BlueZ's storage and correctly reloaded into the kernel.

## System information
- Kernel: `7.1.5-ogc5.1.fc44.x86_64`
- Distro: Bazzite (Kinoite-based), VERSION=3D"44.20260801.0 (Kinoite)"
- BlueZ: bluetoothctl 5.87 / bluetoothd 5.87
- Bluetooth adapter: `lsusb` reports `13d3:3556 IMC Networks Bluetooth Radi=
o`,
USB descriptor Manufacturer string: "Realtek"
- Same symptom previously reproduced on Nobara and Linux Mint (different ke=
rnel
versions), so this is not distro-specific.

## Expected behavior
The Realtek chip should be recognized by `btusb`/`btrtl`, load the correct =
RTL
firmware/config, and complete BR/EDR pairing and reconnection normally.

## Actual behavior
- Pairing (`bluetoothctl pair`) with a Sonos Ace headset completes and repo=
rts
`Paired: yes` / `Bonded: yes`.
- The resulting link key is correctly written to
`/var/lib/bluetooth/<adapter>/<device>/info` under `[LinkKey]`.
- Any subsequent `connect` attempt fails immediately with:
  ```
  Failed to connect: org.bluez.Error.Failed br-connection-key-missing
  ```
- This happens consistently even after:
  - Restarting `bluetooth.service`
  - Power-cycling the adapter (`power off` / `power on`) =E2=80=94 this cha=
nges the
error to `le-connection-abort-by-local`, suggesting a bearer-selection issu=
e as
well
  - Forcing `bearer bredr` (with `bluetoothd --experimental`)
  - Enabling `link-security` explicitly via `btmgmt`
  - A pairing done purely over BR/EDR (`scan bredr`, avoiding any LE bondin=
g)
- No combination of BlueZ-level configuration resolves the issue, pointing =
to a
driver/firmware-level problem rather than a BlueZ configuration problem.

## Evidence pointing to root cause
`sudo journalctl -k -b` shows no line of the form `RTL: examining hci_ver=
=3D...`
(which `btrtl` normally logs when it takes over a Realtek device), and no
Broadcom patchram firmware load messages either. Only the generic registrat=
ion
is seen:
```
usbcore: registered new interface driver btusb
Bluetooth: hci0: Ignoring error of Inquiry Cancel command
```
`lsmod` confirms `btrtl` is loaded as a module but appears unused for this
device (no firmware-load log entries reference it).

The current upstream `btusb.c` ID table contains a wildcard entry:
```c
/* IMC Networks - Broadcom based */
{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
  .driver_info =3D BTUSB_BCM_PATCHRAM },
```
This matches *any* IMC Networks (`13d3`) device with USB interface
class/subclass/protocol `ff/01/01` that isn't already claimed by a more
specific `USB_DEVICE()` entry earlier in the table. Since `13d3:3556` has no
specific Realtek entry, it falls through to this Broadcom-oriented rule, ev=
en
though the chip identifies itself as Realtek in its USB manufacturer string.
This causes `btusb` to initialize it via the Broadcom patchram path instead=
 of
`btrtl`, so no Realtek firmware/config is ever loaded.

## Steps to reproduce
1. Attach a device with USB ID `13d3:3556` (IMC Networks Bluetooth Radio,
Realtek-based).
2. `lsmod | grep -i bt` =E2=80=94 confirm `btrtl` is loaded but `journalctl=
 -k -b |
grep -i RTL` shows no `RTL: examining...` line for this device.
3. Pair a BR/EDR audio device (tested with Sonos Ace headphones).
4. Disconnect and attempt to reconnect =E2=80=94 observe `br-connection-key=
-missing`
despite a valid stored link key.

## Suggested fix
Add an explicit `USB_DEVICE(0x13d3, 0x3556)` entry to the Realtek ID table =
in
`btusb.c` (mapped to the appropriate `BTUSB_REALTEK` driver_info / RTL conf=
ig),
so it's matched before the generic IMC Networks Broadcom wildcard rule.

## Additional notes
Happy to provide `btmon` captures, `btmgmt info` output, and full `journalc=
tl
-k -b` logs on request.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
