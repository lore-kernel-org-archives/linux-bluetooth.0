Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E012DDA2
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564565; cv=none; b=f5Iv/AbOwCcUScfctgJ6rW9VQc0ZHL/KjggxRTdqBytv6ngERla5iyFGnVymKjnsv4ihXlpbH167LnPW7JKM8DOkgRaF+At43FXMqnWxU6KbJ6sPJeJNoKaA4/rIxFi+xFny2mf0+XjdpXfcrQupA9hycZektjex+csnzIaqjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564565; c=relaxed/simple;
	bh=T3oIP70RoXSFPAUt07dLzUoauBiojOZpZ91rtwcAbq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N94a+uQUz9uY8chvOP7DDEsFJny01z5ubCi3UGi/LB8wxSBu4dBGleUt4LkNVWeSyxP2KUl/V630hgejLz61GjqTHrASZi9Ee4NXo2X/bIE+QRU+cx68XOFXX1ShX3irf3YmmZTaWyIYtCjrrporoQXov2ctMkmXw+z/3IUzaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8fuKiSY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8fuKiSY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A300C4AF08
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716564565;
	bh=T3oIP70RoXSFPAUt07dLzUoauBiojOZpZ91rtwcAbq4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H8fuKiSYvKA2quXDu/HQuRQQIMrQHsqFEFyvHVyzemiTM3OB3hNs8PJ5S9f9B4mtZ
	 zx0ZZZ6hikgBpcliOlIUGFolBKuU0mB9UHFcY8iyzWMcR5V4AJMX4rftJnycIbUxt/
	 ICXEEldMPhoRdHLBq//Az2GkiTd+qKLBU7H6PKkAI4lPMvnIhaN6mUi00JYciR5K1n
	 EpKjLsvnR+rCdDeFZym1WhmIbJINvRy3Ry/APNvANiBypFJ0OI0zbAv7IoG2lh0rHC
	 441CN0Ugh0oFIBDvtwVYQB2OpcBqeuidTKEfz+n5RW4u8jKntjPYFiIGtvF4IUHs8R
	 oNjHF81WlgXhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 33CA2C53B73; Fri, 24 May 2024 15:29:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 15:29:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dustin@falgout.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-99nVbndxQK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #27 from Dustin (dustin@falgout.us) ---
This is a regression. It has been broken since 6.5. It worked fine in prior
kernel versions.

dmesg:
```
[88870.532674] iwlwifi 0000:0f:00.0: WRT: Invalid buffer destination
[88870.672880] iwlwifi 0000:0f:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[88870.672897] iwlwifi 0000:0f:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[88870.672910] iwlwifi 0000:0f:00.0: WFPM_AUTH_KEY_0: 0x90
[88870.672921] iwlwifi 0000:0f:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[88870.698472] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[88870.698512] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[88871.304617] audit: type=3D1400 audit(1716388650.420:36): apparmor=3D"DEN=
IED"
operation=3D"capable" class=3D"cap" profile=3D"/usr/sbin/cupsd" pid=3D130211
comm=3D"cupsd" capability=3D12  capname=3D"net_admin"
[88871.626870] usb 3-1.1: new full-speed USB device number 9 using xhci_hcd
[88871.805974] usb 3-1.1: New USB device found, idVendor=3D18d1, idProduct=
=3D9470,
bcdDevice=3D 0.01
[88871.805977] usb 3-1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[88871.805979] usb 3-1.1: Product: Titan Security Key v2
[88871.805980] usb 3-1.1: Manufacturer: Google
[88871.805981] usb 3-1.1: SerialNumber: 2
[88871.895114] hid-generic 0003:18D1:9470.000C: hiddev3,hidraw5: USB HID v1=
.11
Device [Google Titan Security Key v2] on usb-0000:13:00.3-1.1/input0
[88873.707802] wlp15s0: authenticate with 68:7f:f0:00:75:00
[88873.711729] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[88873.758100] wlp15s0: authenticate with 68:7f:f0:00:75:00
[88873.758108] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[88873.759975] wlp15s0: authenticated
[88873.762841] wlp15s0: associate with 68:7f:f0:00:75:00 (try 1/3)
[88873.767689] wlp15s0: RX AssocResp from 68:7f:f0:00:75:00 (capab=3D0x1011
status=3D0 aid=3D29)
[88873.772354] wlp15s0: associated
[88873.839960] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised =
by
68:7f:f0:00:75:00
[90310.593408] Bluetooth: hci0: Hardware error 0x0c
[90310.622241] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[90810.448474] wlp15s0: disconnect from AP 68:7f:f0:00:75:00 for new auth to
68:7f:f0:00:74:ff
[90810.556380] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[90810.559334] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[90810.604710] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[90810.604716] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[90810.606524] wlp15s0: authenticated
[90810.607829] wlp15s0: associate with 68:7f:f0:00:74:ff (try 1/3)
[90810.612780] wlp15s0: RX ReassocResp from 68:7f:f0:00:74:ff (capab=3D0x10=
11
status=3D0 aid=3D31)
[90810.618033] wlp15s0: associated
[90810.799009] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised =
by
68:7f:f0:00:74:ff
[91268.883979] wlp15s0: disconnect from AP 68:7f:f0:00:74:ff for new auth to
68:7f:f0:00:75:00
[91268.957741] wlp15s0: authenticate with 68:7f:f0:00:75:00
[91268.960512] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[91269.000877] wlp15s0: authenticated
[91269.003228] wlp15s0: associate with 68:7f:f0:00:75:00 (try 1/3)
[91269.017600] wlp15s0: RX ReassocResp from 68:7f:f0:00:75:00 (capab=3D0x10=
11
status=3D0 aid=3D20)
[91269.022231] wlp15s0: associated
[91269.028341] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised =
by
68:7f:f0:00:75:00
[91546.454078] Bluetooth: hci0: Hardware error 0x0c
[91546.482974] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[93125.536286] Bluetooth: hci0: Hardware error 0x0c
[93125.565113] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[93450.737090] Bluetooth: hci0: Hardware error 0x0c
[93450.765934] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[93817.574022] Bluetooth: hci0: Hardware error 0x0c
[93817.602865] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[94390.961485] Bluetooth: hci0: Hardware error 0x0c
[94390.990308] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[95249.775745] input: Aeropex by AfterShokz (AVRCP) as
/devices/virtual/input/input17
[95652.176339] usb 2-4.1: current rate 16000 is different from the runtime =
rate
48000
[95893.488409] Bluetooth: hci0: Hardware error 0x0c
[95893.517269] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[95927.828934] input: Aeropex by AfterShokz (AVRCP) as
/devices/virtual/input/input18
[97938.322407] Bluetooth: hci0: Hardware error 0x0c
[97938.351273] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[97961.145815] input: Aeropex by AfterShokz (AVRCP) as
/devices/virtual/input/input19
[98398.282029] Bluetooth: hci0: Hardware error 0x0c
[98398.310866] Bluetooth: hci0: Retrieving Intel exception info failed (-16)
[100767.745384] Bluetooth: hci0: Hardware error 0x0c
[100767.774181] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[103333.287732] Bluetooth: hci0: Hardware error 0x0c
[103333.316590] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[103341.411753] Bluetooth: hci0: Hardware error 0x0c
[103341.440606] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[105266.379714] Bluetooth: hci0: Hardware error 0x0c
[105266.408621] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[106003.531592] Bluetooth: hci0: Hardware error 0x0c
[106003.560438] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[108346.230495] Bluetooth: hci0: Hardware error 0x0c
[108346.259336] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[108791.417617] Bluetooth: hci0: Hardware error 0x0c
[108791.446455] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[109008.534180] Bluetooth: hci0: Hardware error 0x0c
[109008.563027] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[111617.526748] Bluetooth: hci0: Hardware error 0x0c
[111617.555598] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[115482.826860] Bluetooth: hci0: Hardware error 0x0c
[115482.855717] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[115807.771740] Bluetooth: hci0: Hardware error 0x0c
[115807.800569] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[116491.387487] Bluetooth: hci0: Hardware error 0x0c
[116491.416328] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[116721.221113] Bluetooth: hci0: Hardware error 0x0c
[116721.249968] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[116833.759399] Bluetooth: hci0: Hardware error 0x0c
[116833.788235] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[117123.023176] Bluetooth: hci0: Hardware error 0x0c
[117123.052009] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[117726.380781] Bluetooth: hci0: Hardware error 0x0c
[117726.409617] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[118301.374381] Bluetooth: hci0: Hardware error 0x0c
[118301.403203] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[119143.135347] wlp15s0: deauthenticating from 68:7f:f0:00:75:00 by local
choice (Reason: 3=3DDEAUTH_LEAVING)
[119143.549669] PM: suspend entry (deep)
[119144.066184] Filesystems sync: 0.516 seconds
[119144.089948] Freezing user space processes
[119144.099250] Freezing user space processes completed (elapsed 0.009 seco=
nds)
[119144.099254] OOM killer disabled.
[119144.099255] Freezing remaining freezable tasks
[119144.100571] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[119144.100598] printk: Suspending console(s) (use no_console_suspend to de=
bug)
[119144.101774] serial 00:04: disabled
[119144.149312] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[119144.149356] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
[119144.150213] ata3.00: Entering standby power mode
[119144.150236] ata1.00: Entering standby power mode
[119144.615240] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[119144.615243] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[119144.615304] amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
[119145.189337] ACPI: PM: Preparing to enter system sleep state S3
[119145.529246] ACPI: PM: Saving platform NVS memory
[119145.529715] Disabling non-boot CPUs ...
[119145.532010] smpboot: CPU 1 is now offline
[119145.536461] smpboot: CPU 2 is now offline
[119145.539443] smpboot: CPU 3 is now offline
[119145.542236] smpboot: CPU 4 is now offline
[119145.544993] smpboot: CPU 5 is now offline
[119145.547300] smpboot: CPU 6 is now offline
[119145.551071] smpboot: CPU 7 is now offline
[119145.554737] smpboot: CPU 8 is now offline
[119145.558306] smpboot: CPU 9 is now offline
[119145.561958] smpboot: CPU 10 is now offline
[119145.565455] smpboot: CPU 11 is now offline
[119145.569175] smpboot: CPU 12 is now offline
[119145.570975] Spectre V2 : Update user space SMT mitigation: STIBP off
[119145.572533] smpboot: CPU 13 is now offline
[119145.575845] smpboot: CPU 14 is now offline
[119145.578904] smpboot: CPU 15 is now offline
[119145.582013] smpboot: CPU 16 is now offline
[119145.585216] smpboot: CPU 17 is now offline
[119145.588294] smpboot: CPU 18 is now offline
[119145.590955] smpboot: CPU 19 is now offline
[119145.593465] smpboot: CPU 20 is now offline
[119145.595730] smpboot: CPU 21 is now offline
[119145.598272] smpboot: CPU 22 is now offline
[119145.600594] smpboot: CPU 23 is now offline
[119145.601765] ACPI: PM: Low-level resume complete
[119145.601787] ACPI: PM: Restoring platform NVS memory
[119145.630414] AMD-Vi: Virtual APIC enabled
[119145.630574] AMD-Vi: Virtual APIC enabled
[119145.630585] LVT offset 0 assigned for vector 0x400
[119145.631173] Enabling non-boot CPUs ...
[119145.631198] smpboot: Booting Node 0 Processor 1 APIC 0x2
[119145.633770] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[119145.634090] CPU1 is up
[119145.634102] smpboot: Booting Node 0 Processor 2 APIC 0x4
[119145.636428] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[119145.636625] CPU2 is up
[119145.636648] smpboot: Booting Node 0 Processor 3 APIC 0x6
[119145.638966] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[119145.639158] CPU3 is up
[119145.639171] smpboot: Booting Node 0 Processor 4 APIC 0x8
[119145.641484] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[119145.641689] CPU4 is up
[119145.641709] smpboot: Booting Node 0 Processor 5 APIC 0xa
[119145.644017] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[119145.644235] CPU5 is up
[119145.644254] smpboot: Booting Node 0 Processor 6 APIC 0x10
[119145.646628] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[119145.646946] CPU6 is up
[119145.646967] smpboot: Booting Node 0 Processor 7 APIC 0x12
[119145.649324] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[119145.649568] CPU7 is up
[119145.649589] smpboot: Booting Node 0 Processor 8 APIC 0x14
[119145.651937] ACPI: \_SB_.PLTF.C010: Found 3 idle states
[119145.652209] CPU8 is up
[119145.652226] smpboot: Booting Node 0 Processor 9 APIC 0x16
[119145.654582] ACPI: \_SB_.PLTF.C012: Found 3 idle states
[119145.654863] CPU9 is up
[119145.654884] smpboot: Booting Node 0 Processor 10 APIC 0x18
[119145.657233] ACPI: \_SB_.PLTF.C014: Found 3 idle states
[119145.657528] CPU10 is up
[119145.657547] smpboot: Booting Node 0 Processor 11 APIC 0x1a
[119145.659894] ACPI: \_SB_.PLTF.C016: Found 3 idle states
[119145.660183] CPU11 is up
[119145.660199] smpboot: Booting Node 0 Processor 12 APIC 0x1
[119145.662502] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[119145.662923] Spectre V2 : Update user space SMT mitigation: STIBP always=
-on
[119145.662927] CPU12 is up
[119145.662942] smpboot: Booting Node 0 Processor 13 APIC 0x3
[119145.665076] Spurious APIC interrupt (vector 0xFF) on CPU#13, should nev=
er
happen.
[119145.665275] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[119145.665594] CPU13 is up
[119145.665610] smpboot: Booting Node 0 Processor 14 APIC 0x5
[119145.667726] Spurious APIC interrupt (vector 0xFF) on CPU#14, should nev=
er
happen.
[119145.667926] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[119145.668248] CPU14 is up
[119145.668262] smpboot: Booting Node 0 Processor 15 APIC 0x7
[119145.670377] Spurious APIC interrupt (vector 0xFF) on CPU#15, should nev=
er
happen.
[119145.670591] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[119145.670912] CPU15 is up
[119145.670928] smpboot: Booting Node 0 Processor 16 APIC 0x9
[119145.673047] Spurious APIC interrupt (vector 0xFF) on CPU#16, should nev=
er
happen.
[119145.673256] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[119145.673609] CPU16 is up
[119145.673626] smpboot: Booting Node 0 Processor 17 APIC 0xb
[119145.675748] Spurious APIC interrupt (vector 0xFF) on CPU#17, should nev=
er
happen.
[119145.675955] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[119145.676322] CPU17 is up
[119145.676342] smpboot: Booting Node 0 Processor 18 APIC 0x11
[119145.678477] Spurious APIC interrupt (vector 0xFF) on CPU#18, should nev=
er
happen.
[119145.678695] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[119145.679121] CPU18 is up
[119145.679137] smpboot: Booting Node 0 Processor 19 APIC 0x13
[119145.681251] Spurious APIC interrupt (vector 0xFF) on CPU#19, should nev=
er
happen.
[119145.681463] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[119145.681849] CPU19 is up
[119145.681870] smpboot: Booting Node 0 Processor 20 APIC 0x15
[119145.684007] Spurious APIC interrupt (vector 0xFF) on CPU#20, should nev=
er
happen.
[119145.684232] ACPI: \_SB_.PLTF.C011: Found 3 idle states
[119145.684652] CPU20 is up
[119145.684674] smpboot: Booting Node 0 Processor 21 APIC 0x17
[119145.686813] Spurious APIC interrupt (vector 0xFF) on CPU#21, should nev=
er
happen.
[119145.687038] ACPI: \_SB_.PLTF.C013: Found 3 idle states
[119145.687476] CPU21 is up
[119145.687490] smpboot: Booting Node 0 Processor 22 APIC 0x19
[119145.689612] Spurious APIC interrupt (vector 0xFF) on CPU#22, should nev=
er
happen.
[119145.689843] ACPI: \_SB_.PLTF.C015: Found 3 idle states
[119145.690322] CPU22 is up
[119145.690344] smpboot: Booting Node 0 Processor 23 APIC 0x1b
[119145.692488] Spurious APIC interrupt (vector 0xFF) on CPU#23, should nev=
er
happen.
[119145.692730] ACPI: \_SB_.PLTF.C017: Found 3 idle states
[119145.693200] CPU23 is up
[119145.695865] ACPI: PM: Waking up from system sleep state S3
[119145.990743] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC000=
00).
[119145.990774] [drm] PSP is resuming...
[119145.991390] [drm] PCIE GART of 512M enabled (table at 0x000000800130000=
0).
[119145.991430] [drm] PSP is resuming...
[119145.991677] serial 00:04: activated
[119145.992677] xhci_hcd 0000:10:00.0: xHC error in resume, USBSTS 0x401,
Reinit
[119145.992680] usb usb1: root hub lost power or was reset
[119145.992682] usb usb2: root hub lost power or was reset
[119146.012190] [drm] reserve 0xa00000 from 0xf41e000000 for PSP TMR
[119146.019583] nvme nvme1: 24/0/0 default/read/poll queues
[119146.029456] nvme nvme0: 24/0/0 default/read/poll queues
[119146.066897] [drm] reserve 0xa00000 from 0x80fd000000 for PSP TMR
[119146.076594] amdgpu 0000:13:00.0: amdgpu: RAS: optional ras ta ucode is =
not
available
[119146.082360] amdgpu 0000:13:00.0: amdgpu: RAP: optional rap ta ucode is =
not
available
[119146.082361] amdgpu 0000:13:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[119146.082363] amdgpu 0000:13:00.0: amdgpu: SMU is resuming...
[119146.082365] amdgpu 0000:13:00.0: amdgpu: smu driver if version =3D
0x00000004, smu fw if version =3D 0x00000005, smu fw program =3D 0, smu fw =
version
=3D 0x00544fdf (84.79.223)
[119146.082367] amdgpu 0000:13:00.0: amdgpu: SMU driver if version not matc=
hed
[119146.084096] amdgpu 0000:13:00.0: amdgpu: SMU is resumed successfully!
[119146.084760] [drm] DMUB hardware initialized: version=3D0x05000500
[119146.085450] [drm] kiq ring mec 2 pipe 1 q 0
[119146.087448] [drm] VCN decode and encode initialized successfully(under =
DPG
Mode).
[119146.087488] [drm] JPEG decode initialized successfully.
[119146.087496] amdgpu 0000:13:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng=
 0
on hub 0
[119146.087498] amdgpu 0000:13:00.0: amdgpu: ring comp_1.0.0 uses VM inv en=
g 1
on hub 0
[119146.087499] amdgpu 0000:13:00.0: amdgpu: ring comp_1.1.0 uses VM inv en=
g 4
on hub 0
[119146.087500] amdgpu 0000:13:00.0: amdgpu: ring comp_1.2.0 uses VM inv en=
g 5
on hub 0
[119146.087501] amdgpu 0000:13:00.0: amdgpu: ring comp_1.3.0 uses VM inv en=
g 6
on hub 0
[119146.087501] amdgpu 0000:13:00.0: amdgpu: ring comp_1.0.1 uses VM inv en=
g 7
on hub 0
[119146.087502] amdgpu 0000:13:00.0: amdgpu: ring comp_1.1.1 uses VM inv en=
g 8
on hub 0
[119146.087503] amdgpu 0000:13:00.0: amdgpu: ring comp_1.2.1 uses VM inv en=
g 9
on hub 0
[119146.087504] amdgpu 0000:13:00.0: amdgpu: ring comp_1.3.1 uses VM inv en=
g 10
on hub 0
[119146.087505] amdgpu 0000:13:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv e=
ng
11 on hub 0
[119146.087505] amdgpu 0000:13:00.0: amdgpu: ring sdma0 uses VM inv eng 12 =
on
hub 0
[119146.087506] amdgpu 0000:13:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng=
 0
on hub 8
[119146.087507] amdgpu 0000:13:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv e=
ng 1
on hub 8
[119146.087508] amdgpu 0000:13:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv e=
ng 4
on hub 8
[119146.087509] amdgpu 0000:13:00.0: amdgpu: ring jpeg_dec uses VM inv eng =
5 on
hub 8
[119146.089772] amdgpu 0000:13:00.0: [drm] Cannot find any crtc or sizes
[119146.157143] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is =
not
available
[119146.171828] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[119146.171831] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[119146.171833] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D
0x0000000d, smu fw if version =3D 0x0000000f, smu fw program =3D 0, version=
 =3D
0x00491a00 (73.26.0)
[119146.171836] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matc=
hed
[119146.171864] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[119146.214380] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[119146.215442] [drm] DMUB hardware initialized: version=3D0x0202000C
[119146.305831] ata2: SATA link down (SStatus 0 SControl 300)
[119146.305962] ata4: SATA link down (SStatus 0 SControl 300)
[119146.346523] usb 1-7: reset full-speed USB device number 6 using xhci_hcd
[119146.466520] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[119146.466530] ata1.00: Entering active power mode
[119146.466547] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[119146.466558] ata3.00: Entering active power mode
[119146.468082] ata3.00: configured for UDMA/133
[119146.503427] ata1.00: configured for UDMA/133
[119146.545607] [drm] kiq ring mec 2 pipe 1 q 0
[119146.548940] [drm] VCN decode and encode initialized successfully(under =
DPG
Mode).
[119146.548957] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng=
 0
on hub 0
[119146.548959] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv en=
g 1
on hub 0
[119146.548960] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv en=
g 4
on hub 0
[119146.548961] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv en=
g 5
on hub 0
[119146.548962] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv en=
g 6
on hub 0
[119146.548963] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv en=
g 7
on hub 0
[119146.548963] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv en=
g 8
on hub 0
[119146.548964] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv en=
g 9
on hub 0
[119146.548965] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv en=
g 10
on hub 0
[119146.548966] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv e=
ng
11 on hub 0
[119146.548967] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 =
on
hub 0
[119146.548968] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng=
 0
on hub 8
[119146.775245] usb 1-3: reset full-speed USB device number 3 using xhci_hcd
[119147.199089] usb 1-2: reset full-speed USB device number 2 using xhci_hcd
[119147.554710] usb 1-4: reset high-speed USB device number 4 using xhci_hcd
[119147.846666] usb 1-10: reset high-speed USB device number 7 using xhci_h=
cd
[119148.258836] usb 1-6: reset full-speed USB device number 5 using xhci_hcd
[119148.624016] usb 2-4: reset SuperSpeed USB device number 2 using xhci_hcd
[119148.979540] usb 2-4.1: reset SuperSpeed USB device number 3 using xhci_=
hcd
[119149.011222] OOM killer enabled.
[119149.011224] Restarting tasks ...
[119149.016632] Bluetooth: hci0: Firmware timestamp 2022.5 buildtype 1 build
38020
[119149.017229] done.
[119149.017296] random: crng reseeded on system resumption
[119149.017647] thermal thermal_zone1: failed to read out thermal zone (-61)
[119149.017652] PM: suspend exit
[119149.020747] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041=
.sfi
[119149.020758] Bluetooth: hci0: Boot Address: 0x100800
[119149.020760] Bluetooth: hci0: Firmware Version: 132-5.22
[119149.020761] Bluetooth: hci0: Firmware already loaded
[119149.226337] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-e00:00: attached PHY
driver (mii_bus:phy_addr=3Dr8169-0-e00:00, irq=3DMAC)
[119149.292012] usb 3-1.1: USB disconnect, device number 9
[119149.305529] Bluetooth: MGMT ver 1.22
[119149.438305] r8169 0000:0e:00.0 enp14s0: Link is Down
[119149.484014] iwlwifi 0000:0f:00.0: WRT: Invalid buffer destination
[119149.624319] iwlwifi 0000:0f:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[119149.624336] iwlwifi 0000:0f:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[119149.624354] iwlwifi 0000:0f:00.0: WFPM_AUTH_KEY_0: 0x90
[119149.624366] iwlwifi 0000:0f:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[119149.662217] usb 3-1.1: new full-speed USB device number 10 using xhci_h=
cd
[119149.700490] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[119149.700538] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[119149.836781] usb 3-1.1: New USB device found, idVendor=3D18d1, idProduct=
=3D9470,
bcdDevice=3D 0.01
[119149.836787] usb 3-1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[119149.836789] usb 3-1.1: Product: Titan Security Key v2
[119149.836791] usb 3-1.1: Manufacturer: Google
[119149.836792] usb 3-1.1: SerialNumber: 2
[119149.941978] hid-generic 0003:18D1:9470.000D: hiddev3,hidraw5: USB HID v=
1.11
Device [Google Titan Security Key v2] on usb-0000:13:00.3-1.1/input0
[119150.900516] audit: type=3D1400 audit(1716477597.264:37): apparmor=3D"DE=
NIED"
operation=3D"capable" class=3D"cap" profile=3D"/usr/sbin/cupsd" pid=3D169110
comm=3D"cupsd" capability=3D12  capname=3D"net_admin"
[119152.887950] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[119152.891928] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[119152.936313] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[119152.936317] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[119152.937855] wlp15s0: authenticated
[119152.938178] wlp15s0: associate with 68:7f:f0:00:74:ff (try 1/3)
[119152.943414] wlp15s0: RX AssocResp from 68:7f:f0:00:74:ff (capab=3D0x1011
status=3D0 aid=3D28)
[119152.948744] wlp15s0: associated
[119153.045300] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised=
 by
68:7f:f0:00:74:ff
[119969.309895] Bluetooth: hci0: Hardware error 0x0c
[119969.338670] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[120815.442243] Bluetooth: hci0: Hardware error 0x0c
[120815.471087] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[121110.620282] Bluetooth: hci0: Hardware error 0x0c
[121110.649114] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[122110.363149] Bluetooth: hci0: Hardware error 0x0c
[122110.391988] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[122400.714900] Bluetooth: hci0: Hardware error 0x0c
[122400.743744] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[122806.577935] Bluetooth: hci0: Hardware error 0x0c
[122806.606781] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[124135.739119] Bluetooth: hci0: Hardware error 0x0c
[124135.767950] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[125181.467711] Bluetooth: hci0: Hardware error 0x0c
[125181.496541] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[125819.515014] wlp15s0: disconnect from AP 68:7f:f0:00:74:ff for new auth =
to
68:7f:f0:00:75:00
[125819.570592] wlp15s0: authenticate with 68:7f:f0:00:75:00
[125819.573529] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[125819.618654] wlp15s0: authenticate with 68:7f:f0:00:75:00
[125819.618661] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[125819.620543] wlp15s0: authenticated
[125819.626052] wlp15s0: associate with 68:7f:f0:00:75:00 (try 1/3)
[125819.631590] wlp15s0: RX ReassocResp from 68:7f:f0:00:75:00 (capab=3D0x1=
011
status=3D0 aid=3D10)
[125819.636089] wlp15s0: associated
[125819.670561] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised=
 by
68:7f:f0:00:75:00
[126580.707255] Bluetooth: hci0: Hardware error 0x0c
[126580.736036] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[127985.442812] Bluetooth: hci0: Hardware error 0x0c
[127985.471641] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[129906.556864] Bluetooth: hci0: Hardware error 0x0c
[129906.585694] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[130550.774519] Bluetooth: hci0: Hardware error 0x0c
[130550.803354] Bluetooth: hci0: Retrieving Intel exception info failed (-1=
6)
[145852.669134] wlp15s0: deauthenticating from 68:7f:f0:00:75:00 by local
choice (Reason: 3=3DDEAUTH_LEAVING)
[145853.298960] PM: suspend entry (deep)
[145855.434355] Filesystems sync: 2.135 seconds
[145857.465558] Bluetooth: hci0: Opcode 0x0c1a failed: -110
[145857.465585] Bluetooth: hci0: command 0x0c1a tx timeout
[145859.481635] Bluetooth: hci0: Opcode 0x2042 failed: -110
[145859.481638] Bluetooth: hci0: command 0x2042 tx timeout
[145859.481643] Bluetooth: hci0: Unable to disable scanning: -110
[145861.497574] Bluetooth: hci0: Opcode 0x0c1a failed: -110
[145861.497579] Bluetooth: hci0: command 0x0c1a tx timeout
[145863.513472] Bluetooth: hci0: Opcode 0x2042 failed: -110
[145863.513481] Bluetooth: hci0: Unable to disable scanning: -110
[145863.513484] Bluetooth: hci0: disable scanning failed: -110
[145863.513484] Bluetooth: hci0: command 0x2042 tx timeout
[145863.513486] Bluetooth: hci0: start background scanning failed: -110
[145863.513707] Freezing user space processes
[145863.522766] Freezing user space processes completed (elapsed 0.009 seco=
nds)
[145863.522770] OOM killer disabled.
[145863.522771] Freezing remaining freezable tasks
[145863.524092] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[145863.524119] printk: Suspending console(s) (use no_console_suspend to de=
bug)
[145863.525510] serial 00:04: disabled
[145863.557238] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[145863.558159] ata1.00: Entering standby power mode
[145863.561235] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
[145863.562027] ata3.00: Entering standby power mode
[145863.972594] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[145863.972599] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[145863.972653] amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
[145864.554852] ACPI: PM: Preparing to enter system sleep state S3
[145864.893739] ACPI: PM: Saving platform NVS memory
[145864.894211] Disabling non-boot CPUs ...
[145864.896611] smpboot: CPU 1 is now offline
[145864.900980] smpboot: CPU 2 is now offline
[145864.903865] smpboot: CPU 3 is now offline
[145864.906648] smpboot: CPU 4 is now offline
[145864.909284] smpboot: CPU 5 is now offline
[145864.911928] smpboot: CPU 6 is now offline
[145864.915532] smpboot: CPU 7 is now offline
[145864.919113] smpboot: CPU 8 is now offline
[145864.922742] smpboot: CPU 9 is now offline
[145864.926414] smpboot: CPU 10 is now offline
[145864.930082] smpboot: CPU 11 is now offline
[145864.933981] smpboot: CPU 12 is now offline
[145864.935615] Spectre V2 : Update user space SMT mitigation: STIBP off
[145864.937295] smpboot: CPU 13 is now offline
[145864.939864] smpboot: CPU 14 is now offline
[145864.942328] smpboot: CPU 15 is now offline
[145864.944797] smpboot: CPU 16 is now offline
[145864.947090] smpboot: CPU 17 is now offline
[145864.949334] smpboot: CPU 18 is now offline
[145864.952490] smpboot: CPU 19 is now offline
[145864.955785] smpboot: CPU 20 is now offline
[145864.959384] smpboot: CPU 21 is now offline
[145864.961876] smpboot: CPU 22 is now offline
[145864.964979] smpboot: CPU 23 is now offline
[145864.966365] ACPI: PM: Low-level resume complete
[145864.966386] ACPI: PM: Restoring platform NVS memory
[145864.998883] AMD-Vi: Virtual APIC enabled
[145865.005071] AMD-Vi: Virtual APIC enabled
[145865.005083] LVT offset 0 assigned for vector 0x400
[145865.005823] Enabling non-boot CPUs ...
[145865.005848] smpboot: Booting Node 0 Processor 1 APIC 0x2
[145865.008419] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[145865.008739] CPU1 is up
[145865.008753] smpboot: Booting Node 0 Processor 2 APIC 0x4
[145865.011064] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[145865.011267] CPU2 is up
[145865.011281] smpboot: Booting Node 0 Processor 3 APIC 0x6
[145865.013588] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[145865.013768] CPU3 is up
[145865.013782] smpboot: Booting Node 0 Processor 4 APIC 0x8
[145865.016088] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[145865.016291] CPU4 is up
[145865.016303] smpboot: Booting Node 0 Processor 5 APIC 0xa
[145865.018607] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[145865.018817] CPU5 is up
[145865.018831] smpboot: Booting Node 0 Processor 6 APIC 0x10
[145865.021201] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[145865.021514] CPU6 is up
[145865.021528] smpboot: Booting Node 0 Processor 7 APIC 0x12
[145865.023880] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[145865.024124] CPU7 is up
[145865.024138] smpboot: Booting Node 0 Processor 8 APIC 0x14
[145865.026481] ACPI: \_SB_.PLTF.C010: Found 3 idle states
[145865.026747] CPU8 is up
[145865.026763] smpboot: Booting Node 0 Processor 9 APIC 0x16
[145865.029113] ACPI: \_SB_.PLTF.C012: Found 3 idle states
[145865.029392] CPU9 is up
[145865.029407] smpboot: Booting Node 0 Processor 10 APIC 0x18
[145865.031744] ACPI: \_SB_.PLTF.C014: Found 3 idle states
[145865.032032] CPU10 is up
[145865.032048] smpboot: Booting Node 0 Processor 11 APIC 0x1a
[145865.034388] ACPI: \_SB_.PLTF.C016: Found 3 idle states
[145865.034671] CPU11 is up
[145865.034687] smpboot: Booting Node 0 Processor 12 APIC 0x1
[145865.037017] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[145865.037422] Spectre V2 : Update user space SMT mitigation: STIBP always=
-on
[145865.037426] CPU12 is up
[145865.037441] smpboot: Booting Node 0 Processor 13 APIC 0x3
[145865.039554] Spurious APIC interrupt (vector 0xFF) on CPU#13, should nev=
er
happen.
[145865.039754] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[145865.040072] CPU13 is up
[145865.040086] smpboot: Booting Node 0 Processor 14 APIC 0x5
[145865.042201] Spurious APIC interrupt (vector 0xFF) on CPU#14, should nev=
er
happen.
[145865.042400] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[145865.042721] CPU14 is up
[145865.042734] smpboot: Booting Node 0 Processor 15 APIC 0x7
[145865.044852] Spurious APIC interrupt (vector 0xFF) on CPU#15, should nev=
er
happen.
[145865.045054] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[145865.045372] CPU15 is up
[145865.045385] smpboot: Booting Node 0 Processor 16 APIC 0x9
[145865.047482] Spurious APIC interrupt (vector 0xFF) on CPU#16, should nev=
er
happen.
[145865.047707] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[145865.048052] CPU16 is up
[145865.048065] smpboot: Booting Node 0 Processor 17 APIC 0xb
[145865.050189] Spurious APIC interrupt (vector 0xFF) on CPU#17, should nev=
er
happen.
[145865.050402] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[145865.050771] CPU17 is up
[145865.050784] smpboot: Booting Node 0 Processor 18 APIC 0x11
[145865.052917] Spurious APIC interrupt (vector 0xFF) on CPU#18, should nev=
er
happen.
[145865.053129] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[145865.053543] CPU18 is up
[145865.053557] smpboot: Booting Node 0 Processor 19 APIC 0x13
[145865.055693] Spurious APIC interrupt (vector 0xFF) on CPU#19, should nev=
er
happen.
[145865.055903] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[145865.056286] CPU19 is up
[145865.056301] smpboot: Booting Node 0 Processor 20 APIC 0x15
[145865.058438] Spurious APIC interrupt (vector 0xFF) on CPU#20, should nev=
er
happen.
[145865.058651] ACPI: \_SB_.PLTF.C011: Found 3 idle states
[145865.059076] CPU20 is up
[145865.059091] smpboot: Booting Node 0 Processor 21 APIC 0x17
[145865.061229] Spurious APIC interrupt (vector 0xFF) on CPU#21, should nev=
er
happen.
[145865.061455] ACPI: \_SB_.PLTF.C013: Found 3 idle states
[145865.061899] CPU21 is up
[145865.061913] smpboot: Booting Node 0 Processor 22 APIC 0x19
[145865.064057] Spurious APIC interrupt (vector 0xFF) on CPU#22, should nev=
er
happen.
[145865.064282] ACPI: \_SB_.PLTF.C015: Found 3 idle states
[145865.064754] CPU22 is up
[145865.064771] smpboot: Booting Node 0 Processor 23 APIC 0x1b
[145865.066918] Spurious APIC interrupt (vector 0xFF) on CPU#23, should nev=
er
happen.
[145865.067161] ACPI: \_SB_.PLTF.C017: Found 3 idle states
[145865.067632] CPU23 is up
[145865.070344] ACPI: PM: Waking up from system sleep state S3
[145865.363971] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC000=
00).
[145865.364016] [drm] PSP is resuming...
[145865.365479] serial 00:04: activated
[145865.367003] xhci_hcd 0000:10:00.0: xHC error in resume, USBSTS 0x401,
Reinit
[145865.367006] usb usb1: root hub lost power or was reset
[145865.367007] usb usb2: root hub lost power or was reset
[145865.367096] [drm] PCIE GART of 512M enabled (table at 0x000000800130000=
0).
[145865.367114] [drm] PSP is resuming...
[145865.385456] [drm] reserve 0xa00000 from 0xf41e000000 for PSP TMR
[145865.391436] nvme nvme1: 24/0/0 default/read/poll queues
[145865.397935] nvme nvme0: 24/0/0 default/read/poll queues
[145865.442405] [drm] reserve 0xa00000 from 0x80fd000000 for PSP TMR
[145865.450366] amdgpu 0000:13:00.0: amdgpu: RAS: optional ras ta ucode is =
not
available
[145865.456207] amdgpu 0000:13:00.0: amdgpu: RAP: optional rap ta ucode is =
not
available
[145865.456208] amdgpu 0000:13:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[145865.456210] amdgpu 0000:13:00.0: amdgpu: SMU is resuming...
[145865.456216] amdgpu 0000:13:00.0: amdgpu: smu driver if version =3D
0x00000004, smu fw if version =3D 0x00000005, smu fw program =3D 0, smu fw =
version
=3D 0x00544fdf (84.79.223)
[145865.456219] amdgpu 0000:13:00.0: amdgpu: SMU driver if version not matc=
hed
[145865.458112] amdgpu 0000:13:00.0: amdgpu: SMU is resumed successfully!
[145865.458772] [drm] DMUB hardware initialized: version=3D0x05000500
[145865.459969] [drm] kiq ring mec 2 pipe 1 q 0
[145865.462183] [drm] VCN decode and encode initialized successfully(under =
DPG
Mode).
[145865.462718] [drm] JPEG decode initialized successfully.
[145865.462727] amdgpu 0000:13:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng=
 0
on hub 0
[145865.462729] amdgpu 0000:13:00.0: amdgpu: ring comp_1.0.0 uses VM inv en=
g 1
on hub 0
[145865.462730] amdgpu 0000:13:00.0: amdgpu: ring comp_1.1.0 uses VM inv en=
g 4
on hub 0
[145865.462731] amdgpu 0000:13:00.0: amdgpu: ring comp_1.2.0 uses VM inv en=
g 5
on hub 0
[145865.462731] amdgpu 0000:13:00.0: amdgpu: ring comp_1.3.0 uses VM inv en=
g 6
on hub 0
[145865.462732] amdgpu 0000:13:00.0: amdgpu: ring comp_1.0.1 uses VM inv en=
g 7
on hub 0
[145865.462733] amdgpu 0000:13:00.0: amdgpu: ring comp_1.1.1 uses VM inv en=
g 8
on hub 0
[145865.462734] amdgpu 0000:13:00.0: amdgpu: ring comp_1.2.1 uses VM inv en=
g 9
on hub 0
[145865.462734] amdgpu 0000:13:00.0: amdgpu: ring comp_1.3.1 uses VM inv en=
g 10
on hub 0
[145865.462735] amdgpu 0000:13:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv e=
ng
11 on hub 0
[145865.462736] amdgpu 0000:13:00.0: amdgpu: ring sdma0 uses VM inv eng 12 =
on
hub 0
[145865.462737] amdgpu 0000:13:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng=
 0
on hub 8
[145865.462738] amdgpu 0000:13:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv e=
ng 1
on hub 8
[145865.462739] amdgpu 0000:13:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv e=
ng 4
on hub 8
[145865.462740] amdgpu 0000:13:00.0: amdgpu: ring jpeg_dec uses VM inv eng =
5 on
hub 8
[145865.466203] amdgpu 0000:13:00.0: [drm] Cannot find any crtc or sizes
[145865.534086] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is =
not
available
[145865.548872] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[145865.548874] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[145865.548877] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D
0x0000000d, smu fw if version =3D 0x0000000f, smu fw program =3D 0, version=
 =3D
0x00491a00 (73.26.0)
[145865.548879] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matc=
hed
[145865.548907] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[145865.590946] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[145865.592006] [drm] DMUB hardware initialized: version=3D0x0202000C
[145865.679682] ata4: SATA link down (SStatus 0 SControl 300)
[145865.679797] ata2: SATA link down (SStatus 0 SControl 300)
[145865.732697] usb 1-4: reset high-speed USB device number 4 using xhci_hcd
[145865.840816] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[145865.840823] ata1.00: Entering active power mode
[145865.840833] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[145865.840840] ata3.00: Entering active power mode
[145865.842376] ata3.00: configured for UDMA/133
[145865.877430] ata1.00: configured for UDMA/133
[145865.919559] [drm] kiq ring mec 2 pipe 1 q 0
[145865.922908] [drm] VCN decode and encode initialized successfully(under =
DPG
Mode).
[145865.922924] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng=
 0
on hub 0
[145865.922926] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv en=
g 1
on hub 0
[145865.922927] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv en=
g 4
on hub 0
[145865.922928] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv en=
g 5
on hub 0
[145865.922928] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv en=
g 6
on hub 0
[145865.922929] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv en=
g 7
on hub 0
[145865.922930] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv en=
g 8
on hub 0
[145865.922931] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv en=
g 9
on hub 0
[145865.922932] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv en=
g 10
on hub 0
[145865.922933] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv e=
ng
11 on hub 0
[145865.922934] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 =
on
hub 0
[145865.922934] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng=
 0
on hub 8
[145866.024853] usb 1-10: reset high-speed USB device number 7 using xhci_h=
cd
[145866.436996] usb 1-7: reset full-speed USB device number 6 using xhci_hcd
[145866.796883] usb 1-6: reset full-speed USB device number 5 using xhci_hcd
[145867.296840] usb 1-3: reset full-speed USB device number 3 using xhci_hcd
[145867.652749] usb 1-2: reset full-speed USB device number 2 using xhci_hcd
[145868.010302] usb 2-4: reset SuperSpeed USB device number 2 using xhci_hcd
[145868.362027] usb 2-4.1: reset SuperSpeed USB device number 3 using xhci_=
hcd
[145868.392153] OOM killer enabled.
[145868.392154] Restarting tasks ...
[145868.396280] usb 3-1.1: USB disconnect, device number 10
[145868.398117] done.
[145868.398186] random: crng reseeded on system resumption
[145868.398483] thermal thermal_zone1: failed to read out thermal zone (-61)
[145868.398489] PM: suspend exit
[145868.584283] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-e00:00: attached PHY
driver (mii_bus:phy_addr=3Dr8169-0-e00:00, irq=3DMAC)
[145868.724456] usb 3-1.1: new full-speed USB device number 11 using xhci_h=
cd
[145868.792377] r8169 0000:0e:00.0 enp14s0: Link is Down
[145868.816654] iwlwifi 0000:0f:00.0: WRT: Invalid buffer destination
[145868.902963] usb 3-1.1: New USB device found, idVendor=3D18d1, idProduct=
=3D9470,
bcdDevice=3D 0.01
[145868.902970] usb 3-1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[145868.902972] usb 3-1.1: Product: Titan Security Key v2
[145868.902974] usb 3-1.1: Manufacturer: Google
[145868.902976] usb 3-1.1: SerialNumber: 2
[145868.956956] iwlwifi 0000:0f:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[145868.956973] iwlwifi 0000:0f:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[145868.956985] iwlwifi 0000:0f:00.0: WFPM_AUTH_KEY_0: 0x90
[145868.957003] iwlwifi 0000:0f:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[145868.995154] hid-generic 0003:18D1:9470.000E: hiddev3,hidraw5: USB HID v=
1.11
Device [Google Titan Security Key v2] on usb-0000:13:00.3-1.1/input0
[145870.400184] Bluetooth: hci0: command 0xfc05 tx timeout
[145870.400186] Bluetooth: hci0: Reading Intel version command failed (-110)
[145872.137980] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[145872.141974] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[145872.187802] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[145872.187807] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[145872.189423] wlp15s0: authenticated
[145872.192260] wlp15s0: associate with 68:7f:f0:00:74:ff (try 1/3)
[145872.196950] wlp15s0: RX AssocResp from 68:7f:f0:00:74:ff (capab=3D0x1011
status=3D0 aid=3D11)
[145872.201545] wlp15s0: associated
[145872.277453] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised=
 by
68:7f:f0:00:74:ff
[146087.750408] wlp15s0: disconnect from AP 68:7f:f0:00:74:ff for new auth =
to
68:7f:f0:00:75:00
[146087.862444] wlp15s0: authenticate with 68:7f:f0:00:75:00
[146087.865472] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[146087.910977] wlp15s0: authenticate with 68:7f:f0:00:75:00
[146087.910982] wlp15s0: send auth to 68:7f:f0:00:75:00 (try 1/3)
[146087.912359] wlp15s0: authenticated
[146087.917849] wlp15s0: associate with 68:7f:f0:00:75:00 (try 1/3)
[146088.025836] wlp15s0: associate with 68:7f:f0:00:75:00 (try 2/3)
[146088.133827] wlp15s0: associate with 68:7f:f0:00:75:00 (try 3/3)
[146088.237836] wlp15s0: association with 68:7f:f0:00:75:00 timed out
[146088.482522] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[146088.486045] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[146088.521911] wlp15s0: authenticated
[146088.525862] wlp15s0: associate with 68:7f:f0:00:74:ff (try 1/3)
[146088.527379] wlp15s0: RX AssocResp from 68:7f:f0:00:74:ff (capab=3D0x1011
status=3D30 aid=3D11)
[146088.527384] wlp15s0: 68:7f:f0:00:74:ff rejected association temporarily;
comeback duration 292 TU (299 ms)
[146088.527553] iwlwifi 0000:0f:00.0: Unhandled alg: 0x707
[146088.829816] wlp15s0: associate with 68:7f:f0:00:74:ff (try 2/3)
[146088.949803] wlp15s0: associate with 68:7f:f0:00:74:ff (try 3/3)
[146089.053974] wlp15s0: association with 68:7f:f0:00:74:ff timed out
[146089.691292] wlp15s0: authenticate with 68:7f:f0:00:75:01
[146089.691308] wlp15s0: 80 MHz not supported, disabling VHT
[146089.694380] wlp15s0: send auth to 68:7f:f0:00:75:01 (try 1/3)
[146089.738759] wlp15s0: authenticate with 68:7f:f0:00:75:01
[146089.738763] wlp15s0: send auth to 68:7f:f0:00:75:01 (try 1/3)
[146089.741258] wlp15s0: authenticated
[146089.741777] wlp15s0: associate with 68:7f:f0:00:75:01 (try 1/3)
[146089.748880] wlp15s0: RX AssocResp from 68:7f:f0:00:75:01 (capab=3D0x1431
status=3D0 aid=3D43)
[146089.755406] wlp15s0: associated
[146089.825778] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised=
 by
68:7f:f0:00:75:01
[149091.410380] iwlwifi 0000:0f:00.0: Unhandled alg: 0x703
[149179.529466] wlp15s0: deauthenticating from 68:7f:f0:00:75:01 by local
choice (Reason: 3=3DDEAUTH_LEAVING)
[149179.911595] PM: suspend entry (deep)
[149183.853348] Filesystems sync: 3.941 seconds
[149183.856089] Freezing user space processes
[149183.858844] Freezing user space processes completed (elapsed 0.002 seco=
nds)
[149183.858847] OOM killer disabled.
[149183.858848] Freezing remaining freezable tasks
[149183.860090] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[149183.860117] printk: Suspending console(s) (use no_console_suspend to de=
bug)
[149183.861305] serial 00:04: disabled
[149183.908278] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[149183.910460] ata1.00: Entering standby power mode
[149183.916562] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
[149183.917396] ata3.00: Entering standby power mode
[149184.326448] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[149184.326451] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[149184.326510] amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
[149184.908242] ACPI: PM: Preparing to enter system sleep state S3
[149185.248528] ACPI: PM: Saving platform NVS memory
[149185.249283] Disabling non-boot CPUs ...
[149185.251387] smpboot: CPU 1 is now offline
[149185.254559] smpboot: CPU 2 is now offline
[149185.257913] smpboot: CPU 3 is now offline
[149185.261367] smpboot: CPU 4 is now offline
[149185.264968] smpboot: CPU 5 is now offline
[149185.268391] smpboot: CPU 6 is now offline
[149185.271700] smpboot: CPU 7 is now offline
[149185.274820] smpboot: CPU 8 is now offline
[149185.278116] smpboot: CPU 9 is now offline
[149185.281419] smpboot: CPU 10 is now offline
[149185.284437] smpboot: CPU 11 is now offline
[149185.287676] smpboot: CPU 12 is now offline
[149185.288851] Spectre V2 : Update user space SMT mitigation: STIBP off
[149185.290401] smpboot: CPU 13 is now offline
[149185.292721] smpboot: CPU 14 is now offline
[149185.294954] smpboot: CPU 15 is now offline
[149185.297243] smpboot: CPU 16 is now offline
[149185.300086] smpboot: CPU 17 is now offline
[149185.302804] smpboot: CPU 18 is now offline
[149185.305190] smpboot: CPU 19 is now offline
[149185.307342] smpboot: CPU 20 is now offline
[149185.309776] smpboot: CPU 21 is now offline
[149185.311915] smpboot: CPU 22 is now offline
[149185.314139] smpboot: CPU 23 is now offline
[149185.315061] ACPI: PM: Low-level resume complete
[149185.315083] ACPI: PM: Restoring platform NVS memory
[149185.346774] AMD-Vi: Virtual APIC enabled
[149185.352012] AMD-Vi: Virtual APIC enabled
[149185.352023] LVT offset 0 assigned for vector 0x400
[149185.352594] Enabling non-boot CPUs ...
[149185.352621] smpboot: Booting Node 0 Processor 1 APIC 0x2
[149185.355632] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[149185.355944] CPU1 is up
[149185.355958] smpboot: Booting Node 0 Processor 2 APIC 0x4
[149185.358268] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[149185.358470] CPU2 is up
[149185.358483] smpboot: Booting Node 0 Processor 3 APIC 0x6
[149185.360790] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[149185.360978] CPU3 is up
[149185.360992] smpboot: Booting Node 0 Processor 4 APIC 0x8
[149185.363297] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[149185.363503] CPU4 is up
[149185.363516] smpboot: Booting Node 0 Processor 5 APIC 0xa
[149185.365823] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[149185.366037] CPU5 is up
[149185.366050] smpboot: Booting Node 0 Processor 6 APIC 0x10
[149185.368420] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[149185.368736] CPU6 is up
[149185.368750] smpboot: Booting Node 0 Processor 7 APIC 0x12
[149185.371131] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[149185.371373] CPU7 is up
[149185.371389] smpboot: Booting Node 0 Processor 8 APIC 0x14
[149185.373742] ACPI: \_SB_.PLTF.C010: Found 3 idle states
[149185.374013] CPU8 is up
[149185.374027] smpboot: Booting Node 0 Processor 9 APIC 0x16
[149185.376370] ACPI: \_SB_.PLTF.C012: Found 3 idle states
[149185.376649] CPU9 is up
[149185.376664] smpboot: Booting Node 0 Processor 10 APIC 0x18
[149185.379003] ACPI: \_SB_.PLTF.C014: Found 3 idle states
[149185.379292] CPU10 is up
[149185.379306] smpboot: Booting Node 0 Processor 11 APIC 0x1a
[149185.381642] ACPI: \_SB_.PLTF.C016: Found 3 idle states
[149185.381936] CPU11 is up
[149185.381951] smpboot: Booting Node 0 Processor 12 APIC 0x1
[149185.384275] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[149185.384681] Spectre V2 : Update user space SMT mitigation: STIBP always=
-on
[149185.384686] CPU12 is up
[149185.384701] smpboot: Booting Node 0 Processor 13 APIC 0x3
[149185.386816] Spurious APIC interrupt (vector 0xFF) on CPU#13, should nev=
er
happen.
[149185.387013] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[149185.387337] CPU13 is up
[149185.387350] smpboot: Booting Node 0 Processor 14 APIC 0x5
[149185.389466] Spurious APIC interrupt (vector 0xFF) on CPU#14, should nev=
er
happen.
[149185.389658] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[149185.389982] CPU14 is up
[149185.389994] smpboot: Booting Node 0 Processor 15 APIC 0x7
[149185.392112] Spurious APIC interrupt (vector 0xFF) on CPU#15, should nev=
er
happen.
[149185.392312] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[149185.392631] CPU15 is up
[149185.392644] smpboot: Booting Node 0 Processor 16 APIC 0x9
[149185.394761] Spurious APIC interrupt (vector 0xFF) on CPU#16, should nev=
er
happen.
[149185.394966] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[149185.395315] CPU16 is up
[149185.395328] smpboot: Booting Node 0 Processor 17 APIC 0xb
[149185.397434] Spurious APIC interrupt (vector 0xFF) on CPU#17, should nev=
er
happen.
[149185.397649] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[149185.398026] CPU17 is up
[149185.398039] smpboot: Booting Node 0 Processor 18 APIC 0x11
[149185.400170] Spurious APIC interrupt (vector 0xFF) on CPU#18, should nev=
er
happen.
[149185.400383] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[149185.400806] CPU18 is up
[149185.400820] smpboot: Booting Node 0 Processor 19 APIC 0x13
[149185.402954] Spurious APIC interrupt (vector 0xFF) on CPU#19, should nev=
er
happen.
[149185.403172] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[149185.403560] CPU19 is up
[149185.403574] smpboot: Booting Node 0 Processor 20 APIC 0x15
[149185.405713] Spurious APIC interrupt (vector 0xFF) on CPU#20, should nev=
er
happen.
[149185.405936] ACPI: \_SB_.PLTF.C011: Found 3 idle states
[149185.406371] CPU20 is up
[149185.406385] smpboot: Booting Node 0 Processor 21 APIC 0x17
[149185.408504] Spurious APIC interrupt (vector 0xFF) on CPU#21, should nev=
er
happen.
[149185.408726] ACPI: \_SB_.PLTF.C013: Found 3 idle states
[149185.409169] CPU21 is up
[149185.409182] smpboot: Booting Node 0 Processor 22 APIC 0x19
[149185.411327] Spurious APIC interrupt (vector 0xFF) on CPU#22, should nev=
er
happen.
[149185.411556] ACPI: \_SB_.PLTF.C015: Found 3 idle states
[149185.412023] CPU22 is up
[149185.412037] smpboot: Booting Node 0 Processor 23 APIC 0x1b
[149185.414185] Spurious APIC interrupt (vector 0xFF) on CPU#23, should nev=
er
happen.
[149185.414424] ACPI: \_SB_.PLTF.C017: Found 3 idle states
[149185.414892] CPU23 is up
[149185.417561] ACPI: PM: Waking up from system sleep state S3
[149185.709144] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC000=
00).
[149185.709184] [drm] PSP is resuming...
[149185.711294] serial 00:04: activated
[149185.712048] xhci_hcd 0000:10:00.0: xHC error in resume, USBSTS 0x401,
Reinit
[149185.712053] usb usb1: root hub lost power or was reset
[149185.712055] usb usb2: root hub lost power or was reset
[149185.712377] [drm] PCIE GART of 512M enabled (table at 0x000000800130000=
0).
[149185.712397] [drm] PSP is resuming...
[149185.730571] [drm] reserve 0xa00000 from 0xf41e000000 for PSP TMR
[149185.738192] nvme nvme1: 24/0/0 default/read/poll queues
[149185.743545] nvme nvme0: 24/0/0 default/read/poll queues
[149185.787680] [drm] reserve 0xa00000 from 0x80fd000000 for PSP TMR
[149185.794772] amdgpu 0000:13:00.0: amdgpu: RAS: optional ras ta ucode is =
not
available
[149185.800508] amdgpu 0000:13:00.0: amdgpu: RAP: optional rap ta ucode is =
not
available
[149185.800509] amdgpu 0000:13:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[149185.800511] amdgpu 0000:13:00.0: amdgpu: SMU is resuming...
[149185.800514] amdgpu 0000:13:00.0: amdgpu: smu driver if version =3D
0x00000004, smu fw if version =3D 0x00000005, smu fw program =3D 0, smu fw =
version
=3D 0x00544fdf (84.79.223)
[149185.800516] amdgpu 0000:13:00.0: amdgpu: SMU driver if version not matc=
hed
[149185.802406] amdgpu 0000:13:00.0: amdgpu: SMU is resumed successfully!
[149185.803069] [drm] DMUB hardware initialized: version=3D0x05000500
[149185.803759] [drm] kiq ring mec 2 pipe 1 q 0
[149185.806134] [drm] VCN decode and encode initialized successfully(under =
DPG
Mode).
[149185.806630] [drm] JPEG decode initialized successfully.
[149185.806638] amdgpu 0000:13:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng=
 0
on hub 0
[149185.806640] amdgpu 0000:13:00.0: amdgpu: ring comp_1.0.0 uses VM inv en=
g 1
on hub 0
[149185.806641] amdgpu 0000:13:00.0: amdgpu: ring comp_1.1.0 uses VM inv en=
g 4
on hub 0
[149185.806642] amdgpu 0000:13:00.0: amdgpu: ring comp_1.2.0 uses VM inv en=
g 5
on hub 0
[149185.806643] amdgpu 0000:13:00.0: amdgpu: ring comp_1.3.0 uses VM inv en=
g 6
on hub 0
[149185.806644] amdgpu 0000:13:00.0: amdgpu: ring comp_1.0.1 uses VM inv en=
g 7
on hub 0
[149185.806644] amdgpu 0000:13:00.0: amdgpu: ring comp_1.1.1 uses VM inv en=
g 8
on hub 0
[149185.806645] amdgpu 0000:13:00.0: amdgpu: ring comp_1.2.1 uses VM inv en=
g 9
on hub 0
[149185.806646] amdgpu 0000:13:00.0: amdgpu: ring comp_1.3.1 uses VM inv en=
g 10
on hub 0
[149185.806647] amdgpu 0000:13:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv e=
ng
11 on hub 0
[149185.806648] amdgpu 0000:13:00.0: amdgpu: ring sdma0 uses VM inv eng 12 =
on
hub 0
[149185.806649] amdgpu 0000:13:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng=
 0
on hub 8
[149185.806649] amdgpu 0000:13:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv e=
ng 1
on hub 8
[149185.806650] amdgpu 0000:13:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv e=
ng 4
on hub 8
[149185.806651] amdgpu 0000:13:00.0: amdgpu: ring jpeg_dec uses VM inv eng =
5 on
hub 8
[149185.809093] amdgpu 0000:13:00.0: [drm] Cannot find any crtc or sizes
[149185.878177] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is =
not
available
[149185.892862] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
ucode is not available
[149185.892864] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[149185.892867] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D
0x0000000d, smu fw if version =3D 0x0000000f, smu fw program =3D 0, version=
 =3D
0x00491a00 (73.26.0)
[149185.892869] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matc=
hed
[149185.892898] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[149185.935257] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[149185.936320] [drm] DMUB hardware initialized: version=3D0x0202000C
[149186.025471] ata2: SATA link down (SStatus 0 SControl 300)
[149186.025507] ata4: SATA link down (SStatus 0 SControl 300)
[149186.065903] usb 1-4: reset high-speed USB device number 4 using xhci_hcd
[149186.185908] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[149186.185915] ata3.00: Entering active power mode
[149186.185925] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[149186.185932] ata1.00: Entering active power mode
[149186.187298] ata3.00: configured for UDMA/133
[149186.222180] ata1.00: configured for UDMA/133
[149186.264719] [drm] kiq ring mec 2 pipe 1 q 0
[149186.268726] [drm] VCN decode and encode initialized successfully(under =
DPG
Mode).
[149186.268743] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng=
 0
on hub 0
[149186.268745] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv en=
g 1
on hub 0
[149186.268746] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv en=
g 4
on hub 0
[149186.268747] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv en=
g 5
on hub 0
[149186.268747] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv en=
g 6
on hub 0
[149186.268748] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv en=
g 7
on hub 0
[149186.268749] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv en=
g 8
on hub 0
[149186.268750] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv en=
g 9
on hub 0
[149186.268751] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv en=
g 10
on hub 0
[149186.268752] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv e=
ng
11 on hub 0
[149186.268753] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 =
on
hub 0
[149186.268754] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng=
 0
on hub 8
[149186.422419] usb 1-10: reset high-speed USB device number 7 using xhci_h=
cd
[149186.834049] usb 1-2: reset full-speed USB device number 2 using xhci_hcd
[149187.190425] usb 1-6: reset full-speed USB device number 5 using xhci_hcd
[149187.622508] usb 1-7: reset full-speed USB device number 6 using xhci_hcd
[149187.982476] usb 1-3: reset full-speed USB device number 3 using xhci_hcd
[149188.339631] usb 2-4: reset SuperSpeed USB device number 2 using xhci_hcd
[149188.695128] usb 2-4.1: reset SuperSpeed USB device number 3 using xhci_=
hcd
[149188.726267] OOM killer enabled.
[149188.726269] Restarting tasks ...
[149188.727151] usb 3-1.1: USB disconnect, device number 11
[149188.733287] done.
[149188.733357] random: crng reseeded on system resumption
[149188.733641] thermal thermal_zone1: failed to read out thermal zone (-61)
[149188.733647] PM: suspend exit
[149188.853588] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-e00:00: attached PHY
driver (mii_bus:phy_addr=3Dr8169-0-e00:00, irq=3DMAC)
[149189.041548] usb 3-1.1: new full-speed USB device number 12 using xhci_h=
cd
[149189.057671] r8169 0000:0e:00.0 enp14s0: Link is Down
[149189.078963] iwlwifi 0000:0f:00.0: WRT: Invalid buffer destination
[149189.219127] iwlwifi 0000:0f:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[149189.219144] iwlwifi 0000:0f:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[149189.219156] iwlwifi 0000:0f:00.0: WFPM_AUTH_KEY_0: 0x90
[149189.219173] iwlwifi 0000:0f:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[149189.224292] usb 3-1.1: New USB device found, idVendor=3D18d1, idProduct=
=3D9470,
bcdDevice=3D 0.01
[149189.224296] usb 3-1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[149189.224298] usb 3-1.1: Product: Titan Security Key v2
[149189.224299] usb 3-1.1: Manufacturer: Google
[149189.224301] usb 3-1.1: SerialNumber: 2
[149189.308434] hid-generic 0003:18D1:9470.000F: hiddev3,hidraw5: USB HID v=
1.11
Device [Google Titan Security Key v2] on usb-0000:13:00.3-1.1/input0
[149189.969354] audit: type=3D1400 audit(1716563707.612:38): apparmor=3D"DE=
NIED"
operation=3D"capable" class=3D"cap" profile=3D"/usr/sbin/cupsd" pid=3D216640
comm=3D"cupsd" capability=3D12  capname=3D"net_admin"
[149190.753488] Bluetooth: hci0: command 0xfc05 tx timeout
[149190.753505] Bluetooth: hci0: Reading Intel version command failed (-110)
[149192.255262] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[149192.258778] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[149192.304143] wlp15s0: authenticate with 68:7f:f0:00:74:ff
[149192.304148] wlp15s0: send auth to 68:7f:f0:00:74:ff (try 1/3)
[149192.305829] wlp15s0: authenticated
[149192.309434] wlp15s0: associate with 68:7f:f0:00:74:ff (try 1/3)
[149192.313848] wlp15s0: RX AssocResp from 68:7f:f0:00:74:ff (capab=3D0x1011
status=3D0 aid=3D21)
[149192.318570] wlp15s0: associated
[149192.350228] wlp15s0: Limiting TX power to 40 (40 - 0) dBm as advertised=
 by
68:7f:f0:00:74:ff
```

bluetoothctl:
```
Agent registered
[bluetooth]#
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
