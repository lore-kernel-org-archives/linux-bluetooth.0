Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B12E8E16
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270714; cv=none; b=Gg0Ciln2CwZcSFcly67pdyMQSoV/u64QxyzB6O8QWx2E/oK5qp78l0fRjNuCtZhE6IZ/XAQWnYGEUZ5Zl43EOL4Q7w2k8NWupwYidhEFWXKm17+pgk9HKGmKTkQXLm44KtVes9ocYMoDnvIS7GVPA65m3lnWa1w35h3XtcTZgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270714; c=relaxed/simple;
	bh=jDppkbzlblo1mKfkWg+LHybRpuzgjH/6skTHvjxj2X8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jpGT3dol3LXWx+AZshe4Ojy3FqfKlMXKq68ZjGpWiY8ATrhLq1d3EvIKoJ6UwJmXF7upgu508DubrQogAxhpF/UMBdGfXKiVtT0AxSO1wwvS9Wh74TF1/M/VmxtMa7F1NkwMKL4mBfVRzQuexF0j/dgKPnercuaheAQZtviBQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTmzmEOy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTmzmEOy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED38C116B1
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766270713;
	bh=jDppkbzlblo1mKfkWg+LHybRpuzgjH/6skTHvjxj2X8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QTmzmEOyI11A6LBGbO0fAR+90IMEYuECzQvCTGagMPUzufDN83KCG2ReqbhNADMA6
	 fIZlkDnmlb7PRy1xGn/FWPFUzOqspuIwMfOWPf3DtTtNkkWuZF8yznyUnap2vkDhE3
	 IjW1XMo+/N24u5wOx3GVaj+qmQr0Pf4myg/upIDzTa3T8OoWz/mxBd5oZ3oqhPwIfk
	 7UKsUYJxunJTE7R0LPxli7vlzlX0kjIj7ZVysp8hcEBndSZtczVBeJ73+DB/tKRWdf
	 iVDbwbsx/qc2vCXTIBGXWvywXiMW38ETTaOzpVTy22RsJKfMLiLQOJeIO8bfMVvSkA
	 B1y+MFAENJxBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 98073C3279F; Sat, 20 Dec 2025 22:45:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Sat, 20 Dec 2025 22:45:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-sywfq3qUE0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #32 from cheako+kernel_org@mikemestnik.net ---
I just added my device to the bt ignore list...
https://github.com/torvalds/linux/blob/master/drivers/platform/x86/lenovo/t=
hinkpad_acpi.c#L4299

from this:
0001C320   86 80 00 00  F3 24 00 00  FF FF FF FF  FF FF FF FF  .....$......=
....
0001C330   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....
0001C340   00 00 00 00  00 00 00 00  86 80 00 00  FD 24 00 00  ............=
.$..
0001C350   FF FF FF FF  FF FF FF FF  00 00 00 00  00 00 00 00  ............=
....
0001C360   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....
0001C370   86 80 00 00  26 25 00 00  FF FF FF FF  FF FF FF FF  ....&%......=
....
0001C380   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....
0001C390   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....

04:00.0 0280: 8086:2723 (rev 1a)
        Subsystem: 8086:0084
        Flags: bus master, fast devsel, latency 0, IRQ 69, IOMMU group 12
        Memory at c0700000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: <access denied>
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

to this:
0001C320   86 80 00 00  F3 24 00 00  FF FF FF FF  FF FF FF FF  .....$......=
....
0001C330   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....
0001C340   00 00 00 00  00 00 00 00  86 80 00 00  FD 24 00 00  ............=
.$..
0001C350   FF FF FF FF  FF FF FF FF  00 00 00 00  00 00 00 00  ............=
....
0001C360   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....
# This entry was only two nibbles off.
0001C370   86 80 00 00  23 27 00 00  FF FF FF FF  FF FF FF FF  ....#'......=
....
0001C380   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....
0001C390   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  ............=
....

and then used `modprobe -f` to ignore the signature I just broke.

[   88.214055] btusb:btusb_bulk_complete:1520: hci0 urb 000000001b608b6b st=
atus
0 count 23
[   88.225307] btusb:btusb_bulk_complete:1520: hci0 urb 0000000022c725e5 st=
atus
0 count 23
[  117.676394] stoped logging
[  127.123667] sparse_keymap: bad vermagic: kernel tainted.
[  127.123678] Disabling lock debugging due to kernel taint
[  127.124287] sparse_keymap: module verification failed: signature and/or
required key missing - tainting kernel
[  127.136514] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[  127.136522] thinkpad_acpi: http://ibm-acpi.sf.net/
[  127.136524] thinkpad_acpi: ThinkPad BIOS R0UET78W (1.58 ), EC R0UHT78W
[  127.136528] thinkpad_acpi: Lenovo ThinkPad E585, model 20KV000YUS
[  127.137603] thinkpad_acpi: radio switch found; radios are enabled
[  127.137623] thinkpad_acpi: This ThinkPad has standard ACPI backlight
brightness control, supported by the ACPI video driver
[  127.137628] thinkpad_acpi: Disabling thinkpad-acpi brightness events by
default...
[  127.166948] thinkpad_acpi: Standard ACPI backlight interface available, =
not
loading native one
[  127.290709] thinkpad_acpi: battery 1 registered (start 75, stop 80,
behaviours: 0xb)
[  127.290735] ACPI: battery: new hook: ThinkPad Battery Extension
[  127.291397] input: ThinkPad Extra Buttons as
/devices/platform/thinkpad_acpi/input/input16

1. Please add a mod option to force this.
2. Add this device.

My dmsgs are still above, but here is more.

Handle 0x000E, DMI type 0, 24 bytes
BIOS Information
        Vendor: LENOVO
        Version: R0UET78W (1.58 )
        Release Date: 11/17/2020
        Address: 0xE0000
        Runtime Size: 128 kB
        ROM Size: 16 MB
        Characteristics:
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                EDD is supported
                3.5"/720 kB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 1.58
        Firmware Revision: 1.58

Handle 0x000F, DMI type 1, 27 bytes
System Information
        Manufacturer: LENOVO
        Product Name: 20KV000YUS
        Version: ThinkPad E585
        Wake-up Type: Power Switch
        SKU Number: LENOVO_MT_20KV_BU_Think_FM_ThinkPad E585
        Family: ThinkPad E585

Handle 0x0010, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: LENOVO
        Product Name: 20KV000YUS
        Version: SDK0J40697 WIN
        Asset Tag: Not Available
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis: Not Available
        Chassis Handle: 0x0000
        Type: Motherboard
        Contained Object Handles: 0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
