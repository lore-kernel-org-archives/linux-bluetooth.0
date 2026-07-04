Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868838E10C
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178380; cv=none; b=iOsdKzhBJu0F7BCp4HFvkBvACBX9zpUGMjOPrK5wyfFtN/Z3wD8oYyxocNsSHOl69oBPi8VtslbYBz0+XmJ2IKHZ0HtemvQtp1Lcmk8Bt3lvjWC9EIjx1b9yK5Vegg6hdiBXaK5UpwsIu+fQKCwBDRud2C/0y5a38WxfKkRmSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178380; c=relaxed/simple;
	bh=EIrMB7mC0tQvpxbIP13UJD7BH+seA6Ch4qu0ISemYRM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uT0fDsxZkVRDiJxw+H5SgmSl0A95j0apZ75UjTeKPCHXEXF9BynPuCkN7nZxz0w72Fiq4EuZIKuTQYuni/skUcRM3ozgp9i1Yd0oJx+6HkrO73Yw4NZbJ9uOlKFTmaDQtERDH8Fsi0r7z2y3pdfQ7Fxl/lxpyRZU5R52HAELET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7aQn4+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7aQn4+S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E29EBC19425
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783178379;
	bh=EIrMB7mC0tQvpxbIP13UJD7BH+seA6Ch4qu0ISemYRM=;
	h=From:To:Subject:Date:From;
	b=C7aQn4+S7+8379h7sHhhUNFf/m5lCsVv4gEQ/r3ZW/IJCe7ugt6kJAEVWkEtmoaPy
	 xJjlu30ZPAPjfzGM8Id1q3wHt8LOoXQTirxkkcHdsLj2XA/dM3CjHJ5+xAgfb0zAgy
	 qX0TH774ODIJ0O2mibBGCG5E4srG4dmUinvxU3ldxmS/mDzbrpgS0N1wz5YvzZEbu/
	 lkOCNcJCJmlEmLDhVqO39/jblNqDnXu2yF9o4TuZ5DS9WrEbgwu1bRnKrlYtdLIL6E
	 A4JoumtOwaFSve0AgqIKwdX6HFsaKF0Z+MfJg71UrobYKDcSpgsRqnnYOPpGUGW+l4
	 ky0k3HkCBx67g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2133C4160E; Sat,  4 Jul 2026 15:19:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MjBdIE5ldzogT3V0ZGF0ZWQgSW50ZWwgQlQgZmly?=
 =?UTF-8?B?bXdhcmUgaWJ0LWh3LTM3LjcuMTAtZnctMS4wLjEuMmQuZC5ic2VxIChwYXRj?=
 =?UTF-8?B?aCAweDI3KSBicmVha3MgYWxsIEhGUC9TQ08gYXVkaW8g4oCUIFdpbmRvd3Mg?=
 =?UTF-8?B?ZHJpdmVyIHNoaXBzIHdvcmtpbmcgcGF0Y2ggMHgyYg==?=
Date: Sat, 04 Jul 2026 15:19:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: dev@fluid8.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-221720-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221720

               URL: https://lore.kernel.org/linux-bluetooth/11453504-20db-
                    45d0-87e0-ce5582dcbab4@fluid8.de/T/#u
            Bug ID: 221720
           Summary: Outdated Intel BT firmware
                    ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq (patch 0x27) breaks
                    all HFP/SCO audio =E2=80=94 Windows driver ships workin=
g patch
                    0x2b
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.0.0
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: dev@fluid8.de
        Regression: No

## Summary

The legacy Intel Bluetooth firmware `intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bse=
q`
in linux-firmware carries RAM patch **0x27 (39)** and has not been updated
since 2014. With this patch level, the HFP/HSP microphone path (SCO/eSCO,
CVSD) of the affected controllers is completely unusable: the decoded audio
is a constant full-scale buzz unrelated to microphone input, and the kernel
log floods with `Bluetooth: hci0: corrupted SCO packet`.

Intel's own Windows driver package for the same hardware ships RAM patch
**0x2b (43)** for the same firmware variant. Loading that patch on Linux
(extracted from the Windows driver, converted 1:1 =E2=80=94 the embedded bl=
ob is
already in bseq format) **fully fixes HFP audio**: clean, intelligible
microphone audio and zero corrupted SCO packets, on both eSCO and basic SCO.

Since firmware submissions must come from the vendor, this is a request for
Intel to submit their final patch level for the ibt-hw-37.7.x legacy
(Wilkins Peak) firmware files to linux-firmware.

## Hardware

- Intel Dual Band Wireless-AC 3160 combo card
- BT controller: USB `8087:07dc`, "Legacy ROM 2.5 revision 0.0 build 1 week=
 45
2013"
- Loaded firmware file: `intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq`
- Distro/kernel: Ubuntu, kernel 7.0.0-27-generic, linux-firmware 20260319
- Headset used for testing: Jabra Evolve 65 (BT), PipeWire/WirePlumber 0.5.=
x,
native HFP backend, CVSD

## Symptom with current linux-firmware (patch 0x27)

- HFP microphone capture is a constant full-scale roar: peak =3D 32768,
   RMS =E2=89=88 29400, RMS envelope flat at maximum for the whole capture,
   completely uncorrelated with speech. (Typical CVSD delta-decoder railing
   on a desynchronized/garbage bitstream.)
- Kernel log: thousands of `corrupted SCO packet` messages per 10 s capture
   (btusb SCO reassembly desyncs on the controller's bursty/corrupted
   eSCO-over-USB stream).
- Independent of: eSCO vs. basic SCO (tested via forced HV3), xHCI vs. EHCI
   routing, alt-setting, autosuspend. A2DP is unaffected.
- Long-standing reports of the same symptom on this chip family, e.g.
   Ubuntu bug #1310558 (2014, fixed back then by a firmware patch update),
   Linux Mint discussion #662 (2024, kernel 6.8, unresolved).

## Fix: patch 0x2b from Intel's Windows driver

Source (publicly available from Intel): `BT_21.10.1_64_Win8.1.exe`.
The package embeds the RAM patch for each firmware variant inside the
driver binaries, already in bseq format (identical HCI cmd/event record
stream as consumed by btintel's legacy patching):

- Header for fw variant 1.0.1.2d in linux-firmware:
   `018efc0a 00010008 0004012d 0d27` =E2=86=92 patch **0x27**
- Header in the Windows driver (identical blob in all driver builds
   20.91.3.1 =E2=80=A6 20.100.5.1 contained in the package):
   `018efc0a 00010008 0004012d 0d2b` =E2=86=92 patch **0x2b**
- Extracted blob: 22627 bytes, 191 well-formed cmd/event records,
   same first command (0xfc8e) and same final command (0xfc60) as the
   linux-firmware file; sha256 `7a0ca9155e0ec489=E2=80=A6` (full hash on re=
quest)

Result after installing this blob as
`/lib/firmware/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq` and cold-booting
(the controller keeps the old RAM patch across warm reloads;
`Intel BT fw patch 0x2b completed & activated` confirmed in dmesg):

- eSCO (stock kernel, CVSD): clean intelligible microphone audio,
   0% clipping, speech-correlated RMS envelope, **0 corrupted SCO packets**
   during 15 s capture (previously ~2600 per 10 s). Some later runs show a
   small residue (~18 per 15 s) with no audible impact.
- Same result with basic SCO.
- Bonus: the USB autosuspend instability we saw with 0x27 (controller
   drops off the bus under SCO load) is also gone with 0x2b =E2=80=94 verif=
ied
   with default runtime-PM settings including a real suspend/resume cycle.

## Comparison of all 37.7.10 variants

| linux-firmware file | patch in linux-firmware | patch in Windows driver |
|---|---|---|
| fw-1.0.1.2d.d.bseq | 0x27 | **0x2b** |
| fw-1.80.1.2d.d.bseq | 0x2a | **0x2b** |
| fw-1.0.2.3.d.bseq | 0x56 | 0x57 |
| fw-1.80.2.3.d.bseq | 0x57 | 0x57 (current) |

The `.2d` variants are the outdated ones; `1.80.2.3` already matches the
final Windows level.

## Request

Could Intel please submit the final patch level (0x2b) for the
`ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq` (and `fw-1.80.1.2d.d.bseq`) files =E2=
=80=94
and generally the last released patch levels for the 37.7.x legacy family =
=E2=80=94
to linux-firmware? The blobs already exist in bseq format inside Intel's
Windows driver packages; only a licensed re-release is needed.

I can provide full captures (WAV), btmon/usbmon traces, exact extraction
offsets, and full hashes on request.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
