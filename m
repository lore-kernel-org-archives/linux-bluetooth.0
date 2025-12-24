Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD01DF736
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766591153; cv=none; b=FTfOkHeDGRXWIEUnHmszqp11tRreik1HLWC88KkUCSRUYxAkkKLvRzxwxFg/mwQksBuSH+5jArQR7Aq8BvkveugJq8pYKK8Mhjwn7Mj52R6VYKbuurK/S0dbRF9YPqjPYJD8akaDBMj+lJb3nZ/wJ2XE2KPrDHLK3C193GsFUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766591153; c=relaxed/simple;
	bh=Xeq4dzkRJmwORy0mNbrpMXCiDIPDk/oB3TyGHlE0Zpo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iNqC2lCXeMMSWdLmoeG8GgrvZ85C0jMP4qtGrVzKRd69rPe9LpsdJR1hq9hzelw4RJVcC5dAyeDJ0xZf4pntU4iopJzmqx2tZOBPc7yNQQX9iWTE7x5rFqp/sPuJA/A+AJy0mvDZ14TbnbxSG5aNBFyHh5D2LXb4hZT7y9GrZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrF4No31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrF4No31"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6864BC16AAE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766591152;
	bh=Xeq4dzkRJmwORy0mNbrpMXCiDIPDk/oB3TyGHlE0Zpo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jrF4No31PCwbkW14+awzdvEAwsx/w5oVeRIy6pX5QapgqeU7Lit1k8EhNE4GisX8s
	 o1GnQjFTrTn6ykTrGG1T8bNROYQrH00zk6rtNY3NASbdLGBld41xlWMf2ozrpD/Epl
	 8Ce8bO6F6RDroWyx9JrLMS6g0t765UYj8S9NhYbGScotN5+mi/6TADvG+WqTZgpDJK
	 JXBqsv0m35HrLmt/FqsWegPe5b/LBf7llTu9THR8OnrdgzWKNt6xQNKPSOzUIGEbkf
	 etBg2dIZ/m60Ocmct2CIDFT7PoJRjMisBb/M2oOXgmVQf26R4H4hoUnmlf3zyDUcbo
	 ewTxHPXA4O20g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 59A3FC4160E; Wed, 24 Dec 2025 15:45:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Wed, 24 Dec 2025 15:45:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219387-62941-7dJF1rR7oO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

cheako+kernel_org@mikemestnik.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |cheako+kernel_org@mikemestn
                   |                            |ik.net

--- Comment #14 from cheako+kernel_org@mikemestnik.net ---
This could be a duplicate of #216936 ?

Do you get sometime nothing, like there is no btusb, and sometime firmware
loading failed, and sometimes this?

Try adding `blacklist thinkpad_acpi` to `/etc/modprobe.d/` and update the
initramfs.

Also, you could to what I did and hexedit your wifi's PCI id into that btbug
table.

There is still much more to learn about 936, so try and add the debug flags
that I used and see what you get.


The key line to look for is `kernel: usb 3-1: USB disconnect, device number=
 2`,
your numbers may be different but generally during boot you should not have
anything usb disconnecting.

Here is the log I got:
```text
Dec 20 01:16:46 nysa systemd-journald[339]: Received client request to flush
runtime journal.
Dec 20 01:16:46 nysa kernel: mousedev: PS/2 mouse device common for all mice
Dec 20 01:16:46 nysa kernel: Adding 33554428k swap on /dev/nvme0n1p2.=20
Priority:-2 extents:1 across:33554428k SSDsc
Dec 20 01:16:46 nysa kernel: acpi_cpufreq: overriding BIOS provided _PSD da=
ta
Dec 20 01:16:46 nysa kernel: ccp 0000:05:00.2: enabling device (0000 -> 000=
2)
Dec 20 01:16:46 nysa kernel: ccp 0000:05:00.2: ccp enabled
Dec 20 01:16:46 nysa kernel: ccp 0000:05:00.2: psp: unable to access the
device: you might be running a broken BIOS.
Dec 20 01:16:46 nysa systemd-fsck[460]: fsck.fat 4.2 (2021-01-31)
Dec 20 01:16:46 nysa systemd-fsck[460]: /dev/nvme0n1p3: 5 files, 660/130812
clusters
Dec 20 01:16:46 nysa kernel: mc: Linux media interface: v0.10
Dec 20 01:16:46 nysa kernel: input: PC Speaker as
/devices/platform/pcspkr/input/input11
Dec 20 01:16:46 nysa kernel: RAPL PMU: API unit is 2^-32 Joules, 2 fixed
counters, 163840 ms ovfl timer
Dec 20 01:16:46 nysa kernel: RAPL PMU: hw unit of domain package 2^-16 Joul=
es
Dec 20 01:16:46 nysa kernel: RAPL PMU: hw unit of domain core 2^-16 Joules
Dec 20 01:16:46 nysa kernel: ee1004 0-0050: 512 byte EE1004-compliant SPD
EEPROM, read-only
Dec 20 01:16:46 nysa kernel: Bluetooth: Core ver 2.22
Dec 20 01:16:46 nysa kernel: NET: Registered PF_BLUETOOTH protocol family
Dec 20 01:16:46 nysa kernel: Bluetooth: HCI device and connection manager
initialized
Dec 20 01:16:46 nysa kernel: Bluetooth: HCI socket layer initialized
Dec 20 01:16:46 nysa kernel: Bluetooth: L2CAP socket layer initialized
Dec 20 01:16:46 nysa kernel: Bluetooth: SCO socket layer initialized
Dec 20 01:16:46 nysa kernel: videodev: Linux video capture interface: v2.00
Dec 20 01:16:46 nysa kernel: cfg80211: Loading compiled-in X.509 certificat=
es
for regulatory database
Dec 20 01:16:46 nysa kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea=
7'
Dec 20 01:16:46 nysa kernel: Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.26
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: ThinkPad BIOS R0UET78W (1.58 ),=
 EC
R0UHT78W
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: Lenovo ThinkPad E585, model
20KV000YUS
Dec 20 01:16:46 nysa kernel: cfg80211: loaded regulatory.db is malformed or
signature is missing/invalid
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: radio switch found; radios are
enabled
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: This ThinkPad has standard ACPI
backlight brightness control, supported by the ACPI video driver
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: Disabling thinkpad-acpi brightn=
ess
events by default...
Dec 20 01:16:46 nysa kernel: usbcore: registered new interface driver btusb
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa systemd[1]: Finished systemd-journal-flush.service - F=
lush
Journal to Persistent Storage.
Dec 20 01:16:46 nysa systemd[1]: proc-sys-fs-binfmt_misc.automount: Got
automount request for /proc/sys/fs/binfmt_misc, triggered by 474
(systemd-binfmt)
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000def208cd status 0 count 4
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Bootloader revision 0.3 build=
 0
week 24 2017
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: enabling device (0000 ->
0002)
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
000000007a2689cd status 0 count 3
Dec 20 01:16:46 nysa systemd[1]: Starting systemd-tmpfiles-setup.service -
Create System Files and Directories...
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Device revision is 1
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Secure boot is enabled
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: OTP lock is enabled
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: API lock is enabled
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Debug lock is disabled
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Minimum firmware build 1 week=
 10
2014
Dec 20 01:16:46 nysa kernel: ACPI: \: failed to evaluate _DSM
2c176672-0b22-294b-814f-75e4dd26b5fd rev:0 func:0 (0x1001)
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Boot Address: 0x24800
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Firmware Version: 193-33.24
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: ACPI: \: failed to evaluate _DSM
2c176672-0b22-294b-814f-75e4dd26b5fd rev:0 func:0 (0x1001)
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000e181074e status 0 count 132
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: Detected crf-id 0x3617,
cnv-id 0x100530 wfpm id 0x80000000
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: PCI dev 2723/0084,
rev=3D0x340, rfid=3D0x10a100
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6
AX200 160MHz
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
0000000047350e5b status 0 count 256
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000df769fe6 status 0 count 8
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 256
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 8
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000109a812f status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000f473cfbe status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000f473cfbe status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000f473cfbe status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000f473cfbe status 0 count 252
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status 0 count 6
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: usb 3-1: USB disconnect, device number 2
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000d89c849e status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_bulk_complete:1520: hci0 urb
00000000c3a9ce16 status -71 count 0
Dec 20 01:16:46 nysa kernel: btusb:btusb_tx_complete:1862: hci0 urb
00000000f473cfbe status -71 count 0
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Failed to send firmware data
(-19)
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: sending frame failed (-19)
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: FW download error recovery fa=
iled
(-19)
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: sending frame failed (-19)
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Reading supported features fa=
iled
(-19)
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Error reading debug features
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: HCI LE Coded PHY feature bit =
is
set, but its usage is not supported.
Dec 20 01:16:46 nysa kernel: btusb:btusb_send_frame_intel:2616: hci0
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: sending frame failed (-19)
Dec 20 01:16:46 nysa kernel: Bluetooth: hci0: Failed to read MSFT supported
features (-19)
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: loaded firmware version
77.30b1cbd8.0 cc-a0-77.ucode op_mode iwlmvm
Dec 20 01:16:46 nysa systemd[1]: Mounting proc-sys-fs-binfmt_misc.mount -
Arbitrary Executable File Formats File System...
Dec 20 01:16:46 nysa systemd-tmpfiles[537]: /usr/lib/tmpfiles.d/legacy.conf=
:14:
Duplicate line for path "/run/lock", ignoring.
Dec 20 01:16:46 nysa kernel: uvcvideo 3-2:1.0: Found UVC 1.00 device Integr=
ated
Camera (5986:2113)
Dec 20 01:16:46 nysa kernel: kvm_amd: TSC scaling supported
Dec 20 01:16:46 nysa kernel: kvm_amd: Nested Virtualization enabled
Dec 20 01:16:46 nysa kernel: kvm_amd: Nested Paging enabled
Dec 20 01:16:46 nysa kernel: kvm_amd: LBR virtualization supported
Dec 20 01:16:46 nysa kernel: kvm_amd: SEV disabled (ASIDs 0 - 15)
Dec 20 01:16:46 nysa kernel: kvm_amd: SEV-ES disabled (ASIDs 1 - 4294967295)
Dec 20 01:16:46 nysa kernel: kvm_amd: Virtual VMLOAD VMSAVE supported
Dec 20 01:16:46 nysa kernel: kvm_amd: Virtual GIF supported
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: Standard ACPI backlight interfa=
ce
available, not loading native one
Dec 20 01:16:46 nysa systemd[1]: Mounted proc-sys-fs-binfmt_misc.mount -
Arbitrary Executable File Formats File System.
Dec 20 01:16:46 nysa kernel: pps_core: LinuxPPS API ver. 1 registered
Dec 20 01:16:46 nysa kernel: pps_core: Software ver. 5.3.6 - Copyright
2005-2007 Rodolfo Giometti <giometti@linux.it>
Dec 20 01:16:46 nysa kernel: snd_hda_intel 0000:05:00.1: enabling device (0=
000
-> 0002)
Dec 20 01:16:46 nysa kernel: PTP clock support registered
Dec 20 01:16:46 nysa systemd[1]: Finished systemd-binfmt.service - Set Up
Additional Binary Formats.
Dec 20 01:16:46 nysa kernel: usbcore: registered new interface driver uvcvi=
deo
Dec 20 01:16:46 nysa kernel: snd_hda_intel 0000:05:00.1: Handle vga_switche=
roo
audio client
Dec 20 01:16:46 nysa kernel: snd_hda_intel 0000:05:00.6: enabling device (0=
000
-> 0002)
Dec 20 01:16:46 nysa systemd[1]: Starting binfmt-support.service - Enable
support for additional executable binary formats...
Dec 20 01:16:46 nysa systemd[1]: Finished networking.service - Raise network
interfaces.
Dec 20 01:16:46 nysa systemd[1]: Finished systemd-tmpfiles-setup.service -
Create System Files and Directories.
Dec 20 01:16:46 nysa systemd[1]: ldconfig.service - Rebuild Dynamic Linker
Cache was skipped because no trigger condition checks were met.
Dec 20 01:16:46 nysa systemd[1]: systemd-firstboot.service - Initial Setup =
was
skipped because of an unmet condition check (ConditionFirstBoot=3Dyes).
Dec 20 01:16:46 nysa systemd[1]: first-boot-complete.target - First Boot
Complete was skipped because of an unmet condition check
(ConditionFirstBoot=3Dyes).
Dec 20 01:16:46 nysa systemd[1]: systemd-journal-catalog-update.service -
Rebuild Journal Catalog was skipped because of an unmet condition check
(ConditionNeedsUpdate=3D/var).
Dec 20 01:16:46 nysa systemd[1]: systemd-machine-id-commit.service - Save
Transient machine-id to Disk was skipped because of an unmet condition check
(ConditionPathIsMountPoint=3D/etc/machine-id).
Dec 20 01:16:46 nysa systemd[1]: systemd-update-done.service - Update is
Completed was skipped because no trigger condition checks were met.
Dec 20 01:16:46 nysa systemd[1]: Reached target sysinit.target - System
Initialization.
Dec 20 01:16:46 nysa systemd[1]: Started acpid.path - ACPI Events Check.
Dec 20 01:16:46 nysa systemd[1]: Started anacron.timer - Trigger anacron ev=
ery
hour.
Dec 20 01:16:46 nysa systemd[1]: Started apt-daily.timer - Daily apt downlo=
ad
activities.
Dec 20 01:16:46 nysa systemd[1]: Started apt-daily-upgrade.timer - Daily apt
upgrade and clean activities.
Dec 20 01:16:46 nysa kernel: snd_hda_intel 0000:05:00.1: bound 0000:05:00.0
(ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Dec 20 01:16:46 nysa systemd[1]: Started btrfs-balance.timer - Balance block
groups on a btrfs filesystem.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0: CX20753/4:
BIOS auto-probing.
Dec 20 01:16:46 nysa systemd[1]: Started btrfs-scrub.timer - Scrub btrfs
filesystem, verify block checksums.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0: CX20753/4:
picked fixup  for PCI SSID 17aa:0000
Dec 20 01:16:46 nysa systemd[1]: Started btrfs-trim.timer - Discard unused
blocks on a mounted filesystem.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0: autoconfig=
 for
CX20753/4: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker
Dec 20 01:16:46 nysa systemd[1]: Started certbot.timer - Run certbot twice
daily.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0:=20=20=20
speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Dec 20 01:16:46 nysa systemd[1]: Started dpkg-db-backup.timer - Daily dpkg
database backup timer.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0:    hp_outs=
=3D1
(0x16/0x0/0x0/0x0/0x0)
Dec 20 01:16:46 nysa systemd[1]: Started e2scrub_all.timer - Periodic ext4
Online Metadata Check for All Filesystems.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0:    mono:
mono_out=3D0x0
Dec 20 01:16:46 nysa systemd[1]: Started exim4-base.timer - Daily exim4-base
housekeeping.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0:    inputs:
Dec 20 01:16:46 nysa systemd[1]: Started fwupd-refresh.timer - Refresh fwupd
metadata regularly.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0:      Mic=
=3D0x19
Dec 20 01:16:46 nysa systemd[1]: Started logrotate.timer - Daily rotation of
log files.
Dec 20 01:16:46 nysa kernel: snd_hda_codec_conexant hdaudioC2D0:      Inter=
nal
Mic=3D0x1a
Dec 20 01:16:46 nysa systemd[1]: Started man-db.timer - Daily man-db
regeneration.
Dec 20 01:16:46 nysa kernel: input: HD-Audio Generic HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input13
Dec 20 01:16:46 nysa systemd[1]: Started plocate-updatedb.timer - Update the
plocate database daily.
Dec 20 01:16:46 nysa kernel: input: HD-Audio Generic HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input14
Dec 20 01:16:46 nysa systemd[1]: Started snapper-boot.timer - Take snapper
snapshot of root on boot.
Dec 20 01:16:46 nysa kernel: input: HD-Audio Generic HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input15
Dec 20 01:16:46 nysa systemd[1]: Started snapper-cleanup.timer - Daily Clea=
nup
of Snapper Snapshots.
Dec 20 01:16:46 nysa kernel: amd_atl: AMD Address Translation Library
initialized
Dec 20 01:16:46 nysa systemd[1]: Started snapper-timeline.timer - Timeline =
of
Snapper Snapshots.
Dec 20 01:16:46 nysa systemd[1]: Started systemd-tmpfiles-clean.timer - Dai=
ly
Cleanup of Temporary Directories.
Dec 20 01:16:46 nysa systemd[1]: Reached target paths.target - Path Units.
Dec 20 01:16:46 nysa systemd[1]: Reached target timers.target - Timer Units.
Dec 20 01:16:46 nysa systemd[1]: Listening on acpid.socket - ACPID Listen
Socket.
Dec 20 01:16:46 nysa systemd[1]: Listening on avahi-daemon.socket - Avahi
mDNS/DNS-SD Stack Activation Socket.
Dec 20 01:16:46 nysa systemd[1]: Listening on dbus.socket - D-Bus System
Message Bus Socket.
Dec 20 01:16:46 nysa systemd[1]: Starting docker.socket - Docker Socket for=
 the
API...
Dec 20 01:16:46 nysa systemd[1]: Listening on netavark-dhcp-proxy.socket -
Netavark DHCP proxy socket.
Dec 20 01:16:46 nysa systemd[1]: Listening on sshd-unix-local.socket - Open=
SSH
Server Socket (systemd-ssh-generator, AF_UNIX Local).
Dec 20 01:16:46 nysa systemd[1]: Listening on systemd-hostnamed.socket -
Hostname Service Socket.
Dec 20 01:16:46 nysa systemd[1]: Listening on systemd-logind-varlink.socket=
 -
User Login Management Varlink Socket.
Dec 20 01:16:46 nysa systemd[1]: Listening on systemd-machined.socket - Vir=
tual
Machine and Container Registration Service Socket.
Dec 20 01:16:46 nysa systemd[1]: Listening on uuidd.socket - UUID daemon
activation socket.
Dec 20 01:16:46 nysa systemd[1]: systemd-pcrphase-sysinit.service - TPM PCR
Barrier (Initialization) was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
Dec 20 01:16:46 nysa systemd[1]: Listening on docker.socket - Docker Socket=
 for
the API.
Dec 20 01:16:46 nysa systemd[1]: Reached target sockets.target - Socket Uni=
ts.
Dec 20 01:16:46 nysa systemd[1]: Reached target basic.target - Basic System.
Dec 20 01:16:46 nysa systemd[1]: System is tainted: unmerged-bin
Dec 20 01:16:46 nysa systemd[1]: Starting accounts-daemon.service - Accounts
Service...
Dec 20 01:16:46 nysa kernel: input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card2/input16
Dec 20 01:16:46 nysa kernel: input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card2/input17
Dec 20 01:16:46 nysa systemd[1]: Started anacron.service - Run anacron jobs.
Dec 20 01:16:46 nysa systemd[1]: Starting avahi-daemon.service - Avahi
mDNS/DNS-SD Stack...
Dec 20 01:16:46 nysa systemd[1]: Starting chrony.service - chrony, an NTP
client/server...
Dec 20 01:16:46 nysa systemd[1]: Starting cosmic-greeter-daemon.service -
COSMIC Greeter Daemon...
Dec 20 01:16:46 nysa systemd[1]: Started cron.service - Regular background
program processing daemon.
Dec 20 01:16:46 nysa systemd[1]: Starting dbus.service - D-Bus System Messa=
ge
Bus...
Dec 20 01:16:46 nysa anacron[611]: Anacron 2.3 started on 2025-12-20
Dec 20 01:16:46 nysa systemd[1]: Starting e2scrub_reap.service - Remove Sta=
le
Online ext4 Metadata Check Snapshots...
Dec 20 01:16:46 nysa anacron[611]: Normal exit (0 jobs run)
Dec 20 01:16:46 nysa systemd[1]: getty-static.service - getty on tty2-tty6 =
if
dbus and logind are not available was skipped because of an unmet condition
check (ConditionPathExists=3D!/usr/bin/dbus-daemon).
Dec 20 01:16:46 nysa systemd[1]: Reached target getty.target - Login Prompt=
s.
Dec 20 01:16:46 nysa systemd[1]: Starting gnunet.service - A framework for
secure peer-to-peer networking...
Dec 20 01:16:46 nysa cron[621]: (CRON) INFO (pidfile fd =3D 3)
Dec 20 01:16:46 nysa systemd[1]: Starting gpm.service - Console Mouse
manager...
Dec 20 01:16:46 nysa avahi-daemon[614]: Found user 'avahi' (UID 114) and gr=
oup
'avahi' (GID 118).
Dec 20 01:16:46 nysa avahi-daemon[614]: Successfully dropped root privilege=
s.
Dec 20 01:16:46 nysa cron[621]: (CRON) INFO (Running @reboot jobs)
Dec 20 01:16:46 nysa systemd[1]: Starting grub-common.service - Record
successful boot for GRUB...
Dec 20 01:16:46 nysa avahi-daemon[614]: avahi-daemon 0.8 starting up.
Dec 20 01:16:46 nysa kernel: intel_rapl_common: Found RAPL domain package
Dec 20 01:16:46 nysa kernel: intel_rapl_common: Found RAPL domain core
Dec 20 01:16:46 nysa systemd[1]: Starting lm-sensors.service - Initialize
hardware monitoring sensors...
Dec 20 01:16:46 nysa systemd[1]: low-memory-monitor.service - Low Memory
Monitor was skipped because of an unmet condition check
(ConditionPathExists=3D/proc/pressure).
Dec 20 01:16:46 nysa systemd[1]: Starting netavark-dhcp-proxy.service -
Netavark DHCP proxy service...
Dec 20 01:16:46 nysa systemd[1]: Starting networkd-dispatcher.service -
Dispatcher daemon for systemd-networkd...
Dec 20 01:16:46 nysa systemd[1]: Starting rsyslog.service - System Logging
Service...
Dec 20 01:16:46 nysa systemd[1]: Starting smartmontools.service - Self
Monitoring and Reporting Technology (SMART) Daemon...
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: Detected RF HR B3,
rfid=3D0x10a100
Dec 20 01:16:46 nysa /usr/sbin/gpm[652]: *** info [daemon/startup.c(131)]:
Dec 20 01:16:46 nysa /usr/sbin/gpm[652]: Started gpm successfully. Entered
daemon mode.
Dec 20 01:16:46 nysa systemd[1]: Starting snapper-boot.service - Take snapp=
er
snapshot of root on boot...
Dec 20 01:16:46 nysa systemd[1]: Starting snapperd.service - DBus interface=
 for
snapper...
Dec 20 01:16:46 nysa systemd[1]: sshd-keygen.service - Generate sshd host k=
eys
on first boot was skipped because of an unmet condition check
(ConditionFirstBoot=3Dyes).
Dec 20 01:16:46 nysa systemd[1]: Starting switcheroo-control.service -
Switcheroo Control Proxy service...
Dec 20 01:16:46 nysa systemd[1]: Starting systemd-logind.service - User Log=
in
Management...
Dec 20 01:16:46 nysa kernel: thinkpad_acpi: battery 1 registered (start 75,
stop 80, behaviours: 0xb)
Dec 20 01:16:46 nysa systemd[1]: systemd-pcrphase.service - TPM PCR Barrier
(User) was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
Dec 20 01:16:46 nysa kernel: ACPI: battery: new hook: ThinkPad Battery
Extension
Dec 20 01:16:46 nysa systemd[1]: Starting tor.service - Anonymizing overlay
network for TCP (multi-instance-master)...
Dec 20 01:16:46 nysa systemd[1]: Starting udisks2.service - Disk Manager...
Dec 20 01:16:46 nysa systemd[1]: Started uptimed.service - uptime record
daemon.
Dec 20 01:16:46 nysa kernel: input: ThinkPad Extra Buttons as
/devices/platform/thinkpad_acpi/input/input12
Dec 20 01:16:46 nysa systemd[1]: Started
beesd@b333a6e7-1449-4209-a685-8b85aca25dfa.service - Bees
(b333a6e7-1449-4209-a685-8b85aca25dfa).
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0: base HW address:
e0:d4:e8:79:22:4b
Dec 20 01:16:46 nysa systemd[1]: Started netavark-dhcp-proxy.service - Neta=
vark
DHCP proxy service.
Dec 20 01:16:46 nysa systemd[1]: Finished binfmt-support.service - Enable
support for additional executable binary formats.
Dec 20 01:16:46 nysa systemd[1]: anacron.service: Deactivated successfully.
Dec 20 01:16:46 nysa systemd[1]: Finished tor.service - Anonymizing overlay
network for TCP (multi-instance-master).
Dec 20 01:16:46 nysa gnunet-arm[689]: 2025-12-20T01:16:46.843921-0600 arm-6=
89
ERROR `open' failed on file `/var/log/gnunet/gnunet.log' at
common_logging.c:418 with error: Permission denied
Dec 20 01:16:46 nysa gnunet-arm[689]: 2025-12-20T01:16:46.843975-0600 arm-6=
89
ERROR Assertion failed at service.c:2068.
Dec 20 01:16:46 nysa avahi-daemon[614]: Successfully called chroot().
Dec 20 01:16:46 nysa avahi-daemon[614]: Successfully dropped remaining
capabilities.
Dec 20 01:16:46 nysa smartd[648]: smartd 7.5 2025-04-30 r5714
[x86_64-linux-6.18.1-x64v3-xanmod1] (local build)
Dec 20 01:16:46 nysa smartd[648]: Opened configuration file /etc/smartd.conf
Dec 20 01:16:46 nysa smartd[648]: Drive: DEVICESCAN, implied '-a' Directive=
 on
line 18 of file /etc/smartd.conf
Dec 20 01:16:46 nysa avahi-daemon[614]: Loading service file
/services/ssh.service.
Dec 20 01:16:46 nysa chronyd[695]: chronyd version 4.6.1 starting (+CMDMON =
+NTP
+REFCLOCK +RTC +PRIVDROP +SCFILTER +SIGND +ASYNCDNS +NTS +SECHASH +IPV6 -DE=
BUG)
Dec 20 01:16:46 nysa smartd[648]: Configuration file /etc/smartd.conf was
parsed, found DEVICESCAN, scanning devices
Dec 20 01:16:46 nysa chronyd[695]: Loaded 0 symmetric keys
Dec 20 01:16:46 nysa smartd[648]: Device: /dev/nvme0, opened
Dec 20 01:16:46 nysa chronyd[695]: Using leap second list
/usr/share/zoneinfo/leap-seconds.list
Dec 20 01:16:46 nysa smartd[648]: Device: /dev/nvme0, Samsung SSD 970 EVO P=
lus
1TB, S/N:S59ANJ0N516812Z, FW:2B2QEXM7, 1.00 TB
Dec 20 01:16:46 nysa chronyd[695]: Frequency -7.059 +/- 5.761 ppm read from
/var/lib/chrony/chrony.drift
Dec 20 01:16:46 nysa kernel: nvme nvme0: using unchecked data buffer
Dec 20 01:16:46 nysa chronyd[695]: Loaded seccomp filter (level 1)
Dec 20 01:16:46 nysa smartd[648]: Device: /dev/nvme0, is SMART capable. Add=
ing
to "monitor" list.
Dec 20 01:16:46 nysa smartd[648]: Device: /dev/nvme0, state read from
/var/lib/smartmontools/smartd.Samsung_SSD_970_EVO_Plus_1TB-S59ANJ0N516812Z.=
nvme.state
Dec 20 01:16:46 nysa smartd[648]: Monitoring 0 ATA/SATA, 0 SCSI/SAS and 1 N=
VMe
devices
Dec 20 01:16:46 nysa smartd[648]: Device: /dev/nvme0, NVMe error count
increased from 1502 to 1505 (0 new, 1 ignored, 2 unknown)
Dec 20 01:16:46 nysa smartd[648]: Device: /dev/nvme0, state written to
/var/lib/smartmontools/smartd.Samsung_SSD_970_EVO_Plus_1TB-S59ANJ0N516812Z.=
nvme.state
Dec 20 01:16:46 nysa udisksd[676]: udisks daemon version 2.10.1 starting
Dec 20 01:16:46 nysa (udev-worker)[388]: controlC2: Process '/usr/sbin/alsa=
ctl
-E HOME=3D/run/alsa -E XDG_RUNTIME_DIR=3D/run/alsa/runtime restore 2' faile=
d with
exit code 99.
Dec 20 01:16:46 nysa systemd[1]: Started dbus.service - D-Bus System Message
Bus.
Dec 20 01:16:46 nysa systemd[1]: Started smartmontools.service - Self
Monitoring and Reporting Technology (SMART) Daemon.
Dec 20 01:16:46 nysa systemd[1]: Started chrony.service - chrony, an NTP
client/server.
Dec 20 01:16:46 nysa systemd-logind[673]: New seat seat0.
Dec 20 01:16:46 nysa (udev-worker)[416]: controlC0: Process '/usr/sbin/alsa=
ctl
-E HOME=3D/run/alsa -E XDG_RUNTIME_DIR=3D/run/alsa/runtime restore 2' faile=
d with
exit code 99.
Dec 20 01:16:46 nysa systemd-logind[673]: Watching system buttons on
/dev/input/event3 (Power Button)
Dec 20 01:16:46 nysa rsyslogd[647]: imuxsock: Acquired UNIX socket
'/run/systemd/journal/syslog' (fd 3) from systemd.  [v8.2504.0]
Dec 20 01:16:46 nysa rsyslogd[647]: [origin software=3D"rsyslogd"
swVersion=3D"8.2504.0" x-pid=3D"647" x-info=3D"https://www.rsyslog.com"] st=
art
Dec 20 01:16:46 nysa systemd-logind[673]: Watching system buttons on
/dev/input/event0 (Power Button)
Dec 20 01:16:46 nysa avahi-daemon[614]: Joining mDNS multicast group on
interface lo.IPv6 with address ::1.
Dec 20 01:16:46 nysa avahi-daemon[614]: New relevant interface lo.IPv6 for
mDNS.
Dec 20 01:16:46 nysa systemd[1]: Started rsyslog.service - System Logging
Service.
Dec 20 01:16:46 nysa avahi-daemon[614]: Joining mDNS multicast group on
interface lo.IPv4 with address 127.0.0.1.
Dec 20 01:16:46 nysa avahi-daemon[614]: New relevant interface lo.IPv4 for
mDNS.
Dec 20 01:16:46 nysa avahi-daemon[614]: Network interface enumeration
completed.
Dec 20 01:16:46 nysa avahi-daemon[614]: Registering new address record for =
::1
on lo.*.
Dec 20 01:16:46 nysa avahi-daemon[614]: Registering new address record for
127.0.0.1 on lo.IPv4.
Dec 20 01:16:46 nysa dbus-daemon[623]: [system] Activating via systemd: ser=
vice
name=3D'org.freedesktop.PolicyKit1' unit=3D'polkit.service' requested by ':=
1.2'
(uid=3D0 pid=3D676 comm=3D"/usr/libexec/udisks2/udisksd")
Dec 20 01:16:46 nysa kernel: iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
Dec 20 01:16:46 nysa systemd[1]: Started cosmic-greeter-daemon.service - CO=
SMIC
Greeter Daemon.
Dec 20 01:16:46 nysa systemd[1]: Started avahi-daemon.service - Avahi
mDNS/DNS-SD Stack.
Dec 20 01:16:46 nysa systemd[1]: Started switcheroo-control.service -
Switcheroo Control Proxy service.
Dec 20 01:16:46 nysa systemd-logind[673]: Watching system buttons on
/dev/input/event1 (Lid Switch)
Dec 20 01:16:46 nysa systemd-logind[673]: Watching system buttons on
/dev/input/event2 (Sleep Button)
Dec 20 01:16:46 nysa systemd[1]: Listening on systemd-rfkill.socket - Load/=
Save
RF Kill Switch Status /dev/rfkill Watch.
Dec 20 01:16:46 nysa systemd-logind[673]: Watching system buttons on
/dev/input/event4 (AT Translated Set 2 keyboard)
Dec 20 01:16:46 nysa systemd[1]: Starting NetworkManager.service - Network
Manager...
Dec 20 01:16:46 nysa systemd[1]: alsa-state.service - Manage Sound Card Sta=
te
(restore and store) was skipped because of an unmet condition check
(ConditionPathExists=3D/etc/alsa/state-daemon.conf).
Dec 20 01:16:46 nysa systemd[1]: Starting alsa-restore.service - Save/Resto=
re
Sound Card State...
Dec 20 01:16:46 nysa systemd[1]: Starting bluetooth.service - Bluetooth
service...
Dec 20 01:16:46 nysa systemd-logind[673]: Watching system buttons on
/dev/input/event16 (ThinkPad Extra Buttons)
Dec 20 01:16:46 nysa systemd[1]: Starting polkit.service - Authorization
Manager...
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib
parser.c:2796:(load_toplevel_config) Unable to find the top-level configura=
tion
file '/usr/share/alsa/ucm2/ucm.conf'.
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib main.c:1554:(snd_use_case_mgr_o=
pen)
error: failed to import hw:0 use case configuration -2
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib
parser.c:2796:(load_toplevel_config) Unable to find the top-level configura=
tion
file '/usr/share/alsa/ucm2/ucm.conf'.
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib main.c:1554:(snd_use_case_mgr_o=
pen)
error: failed to import hw:0 use case configuration -2
Dec 20 01:16:46 nysa alsactl[735]: Found hardware: "HDA-Intel" "ATI R6xx HD=
MI"
"HDA:1002aa01,00aa0100,00100700" "0x17aa" "0x506f"
Dec 20 01:16:46 nysa alsactl[735]: Hardware is initialized using a generic
method
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #1 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #2 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #3 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #4 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #5 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #6 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #7 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #8 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #9 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #10 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #11 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #12 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #13 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #14 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #15 (No such file or directory)
Dec 20 01:16:46 nysa systemd[1]: Starting wpa_supplicant.service - WPA
supplicant...
Dec 20 01:16:46 nysa gnunet-arm[708]: 2025-12-20T01:16:46.957242-0600
gnunet-arm-708 WARNING GNUnet not running, cannot stop the peer
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #16 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #17 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #18 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #19 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib
parser.c:2796:(load_toplevel_config) Unable to find the top-level configura=
tion
file '/usr/share/alsa/ucm2/ucm.conf'.
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib main.c:1554:(snd_use_case_mgr_o=
pen)
error: failed to import hw:2 use case configuration -2
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib
parser.c:2796:(load_toplevel_config) Unable to find the top-level configura=
tion
file '/usr/share/alsa/ucm2/ucm.conf'.
Dec 20 01:16:46 nysa alsactl[735]: alsa-lib main.c:1554:(snd_use_case_mgr_o=
pen)
error: failed to import hw:2 use case configuration -2
Dec 20 01:16:46 nysa alsactl[735]: Found hardware: "HDA-Intel" "Conexant
CX20753/4" "HDA:14f15111,17aa5070,00100101" "0x17aa" "0x5070"
Dec 20 01:16:46 nysa alsactl[735]: Hardware is initialized using a generic
method
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #1 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #2 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #3 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #4 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #5 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #6 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #7 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #8 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #9 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #10 (No such file or directory)
Dec 20 01:16:46 nysa systemd[1]: Started systemd-logind.service - User Login
Management.
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #11 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #12 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #13 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #14 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #15 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #16 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #17 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #18 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #19 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #20 (No such file or directory)
Dec 20 01:16:46 nysa alsactl[735]: /usr/sbin/alsactl: set_control:1346: fai=
led
to obtain info for control #21 (No such file or directory)
Dec 20 01:16:46 nysa systemd[1]: gnunet.service: Deactivated successfully.
Dec 20 01:16:46 nysa systemd[1]: Started gnunet.service - A framework for
secure peer-to-peer networking.
Dec 20 01:16:46 nysa systemd[1]: grub-common.service: Deactivated successfu=
lly.
Dec 20 01:16:46 nysa systemd[1]: Finished grub-common.service - Record
successful boot for GRUB.
Dec 20 01:16:46 nysa systemd[1]: Finished alsa-restore.service - Save/Resto=
re
Sound Card State.
Dec 20 01:16:46 nysa systemd[1]: Reached target sound.target - Sound Card.
Dec 20 01:16:46 nysa systemd[1]: Starting systemd-rfkill.service - Load/Sav=
e RF
Kill Switch Status...
Dec 20 01:16:46 nysa dbus-daemon[623]: [system] Activating via systemd: ser=
vice
name=3D'org.opensuse.Snapper' unit=3D'snapperd.service' requested by ':1.6'=
 (uid=3D0
pid=3D661 comm=3D"/usr/bin/snapper --config root create --cleanup-al")
Dec 20 01:16:46 nysa systemd[1]: Started systemd-rfkill.service - Load/Save=
 RF
Kill Switch Status.
Dec 20 01:16:46 nysa systemd[1]: e2scrub_reap.service: Deactivated
successfully.
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
