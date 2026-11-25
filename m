Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589075;
	b=kcLyybgMgwfshfUApqX5fTnkjtov8d2t/q+lB4DjLH/AQCBSfxCgHBMczOd9xBJennJY
	 oZ/DLlm4xBQr5f83UypbN7/Q0j+j/LSY783hkUdV/ve3NC4Vlrt8fjB57HcdP/zEBrlbd
	 SyFNkC4HPONbsTSAs2kgwDB3ACjZOh5KmLxb7N311VonAANiSyuXri9jc9qVY5x1Yktdt
	 3ARiy388vRBjzr1MYHi/zqcZAdddzTslXLbLFtubDAXqVVFaH+/ROlsEEgX3aij1YQ4rg
	 VDbkstJCo8+ZP5E7zH8znrTh0hjIBDVhJ5qGAdVHR8cmydI9cMLVfPWO2pr71DirmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589075;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=lcY5bKa9gz2QZmwpaknzwa5cYgQlwbTX5eC/BbhyFq8=;
	b=DnZu/w8VWLcEA+6GYmwc713XOD6gLyqshtqLmX/8kaWQwX7hZLZ5acrKjSYdZUTRoa9N
	 iIepMcRZ4ICXelzGZu4v22S9YxzPJdTr7047zQJ67g1nZx8K27zCcG9R13fvd+ySvyNZX
	 bUG8/TxxUT7w+5+zdzl+CIfgyN0hpuPdQtT4bGCRCh/rxtZmp68EYWpEX49bxRCnfZoZW
	 RQAn0EPW6EB00knwA7BA2QPhAj6BUL1VGkIwMYNT810ms2zlF656dn5DpzVXIFZP8z9yd
	 6Osc141W9tt7fGgeaseYO//hRroetoC6ep8Ed2ayDl1agoth+f9zz4h0yb/kXIRNelg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgTVIZmf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CD606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgTVIZmf
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6406E1F000C4
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589074;
	bh=lcY5bKa9gz2QZmwpaknzwa5cYgQlwbTX5eC/BbhyFq8=;
	h=From:To:Subject:Date;
	b=NgTVIZmf30yZ0DEj3G8Q1c8snwm3hr+1qoo9Ixd6RIu97Fswz+pNtq39mZxNzwir7
	 ICPskaDzV/o56aGjrVw0xTO9EeR+WFOioo6csauJWIl8Eq68q/thc9A089THpiHR0c
	 RA9pPHt+nj8uBhBAtBuLftx3aLitsMVPtLUGfD+njN/DxKLzhKbRLqEADt31hZS4dQ
	 Guepuy+Jg6P/TjPsazUub0qrE84y7Beh3hyviZ1/kGv2zmYJOt8xH91XqSeeZ2KUze
	 2I/lhd++x9WOLbbZOD7QEgr16T1Y8oAA4TW6KS3UUGAP1IB2p2AN26VX0WhWBgMNet
	 hRpn32ddVk4ig==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id 60DDB240040C; Wed, 25 Nov 2026 06:44:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222326] New: Bluetooth: btusb/btmtk: add USB ID 13d3:3589 for
 MediaTek MT7927 / MT6639 (SAPPHIRE NITRO+ X870EA)
Date: Wed, 25 Nov 2026 06:44:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: smak.nsk@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-222326-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222326

            Bug ID: 222326
           Summary: Bluetooth: btusb/btmtk: add USB ID 13d3:3589 for
                    MediaTek MT7927 / MT6639 (SAPPHIRE NITRO+ X870EA)
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.3.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: smak.nsk@gmail.com
        Regression: No

MediaTek MT7927 / MT6639 (AMD RZ738) combo Wi-Fi 7 + Bluetooth 5.4 adapter =
on
SAPPHIRE NITRO+ X870EA PhantomLink PE uses USB VID/PID 13d3:3589 for Blueto=
oth.

- Motherboard: SAPPHIRE NITRO+ X870EA PhantomLink PE (BIOS 5.41, 09/30/2026)
- PCIe Wi-Fi: 0a:00.0 [14c3:6639] (works with mt7925e)
- USB Bluetooth: 13d3:3589 (IMC Networks / MediaTek Inc. Wireless_Device,
bcdDevice=3D1.00, class e0:01:01)

Checked mainline torvalds/linux (v7.4-rc4) and bluetooth-next: 13d3:3588 is
listed in drivers/bluetooth/btusb_main.c (btusb.c in 7.3) and
drivers/bluetooth/btmtk.c (btmtk_mt6639_devs[]), but 13d3:3589 is missing f=
rom
both.

Without this VID/PID, btusb binds as a generic USB Bluetooth device and fai=
ls
HCI reset:

  usb 11-1: New USB device found, idVendor=3D13d3, idProduct=3D3589, bcdDev=
ice=3D
1.00
  usb 11-1: Product: Wireless_Device
  usb 11-1: Manufacturer: MediaTek Inc.
  Bluetooth: hci0: status 0x0c
  Bluetooth: hci0: Opcode 0x0c03 failed: -16

Windows driver confirmation (SAPPHIRE official
MTK_WHQL_BT_V1.1148.0.639/mtkbtfilter.inf from
https://www.sapphiretech.com/en/consumer/mb_nitro_x870ea-ple-polar#Download=
):

  %Generic.DeviceDescRZ738% =3D MTKBT_T0_2, USB\VID_13D3&PID_3589&MI_00

Proposed additions:

1. drivers/bluetooth/btusb_main.c (drivers/bluetooth/btusb.c in 7.3), along=
side
0x13d3/0x3588:
   { USB_DEVICE(0x13d3, 0x3589), .driver_info =3D BTUSB_MEDIATEK |
                                                BTUSB_WIDEBAND_SPEECH },

2. drivers/bluetooth/btmtk.c (btmtk_mt6639_devs[]), alongside 0x13d3/0x3588:
   { 0x13d3, 0x3589 }, /* SAPPHIRE NITRO+ X870EA PhantomLink PE */

Verification on real hardware:
Tested locally on 7.3.5 by adding 13d3:3589 to btusb and btmtk and providing
mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin (extracted from vendor
mtkbt_v2.dat, build 20261021201254, 573205 bytes):

  usbcore: registered new interface driver btusb
  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20261021201254
  Bluetooth: hci0: Device setup in 1883518 usecs
  Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.
  Bluetooth: hci0: AOSP extensions version v1.00
  Bluetooth: MGMT ver 1.23

bluetoothctl show:
  Controller F0:68:E3:A8:A4:E7 (public)
  Manufacturer: 0x0046 (70)
  Version: 0x0d (13)
  Powered: yes

bluetoothctl scan on immediately discovered nearby Bluetooth devices (13
devices in 3s).

Note: upstream linux-firmware currently only ships the Wi-Fi blobs in
mediatek/mt7927/ and does not yet include BT_RAM_CODE_MT6639_2_1_hdr.bin.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
