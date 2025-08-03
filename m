Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7351634
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Aug 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754180185; cv=none; b=pyx5KBnH/YKIhRVkfznx/sVqBTUscaT9AIXxmL3P1cN1BIqRH4xmyBVWgiHqthCU24e1nQVPuqDdYJsWeJqyxnVFMeTG/E+vGGLoPp/wrPC60TrRxZzFkf0uitJ/TJlDWdJ2t1/Dgb86pDJeG9p5x2akN62cus4SFSmvuibRivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754180185; c=relaxed/simple;
	bh=OX+vD1uEmGtCEeEvFlG6DbJZuiUNf/FM72XLPjKu3Yw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QBPRr0sxgNpLER77bkeYtq2zQ/fW9ln6LFmZEbRPyX5A9+qfXaJKVoOz3dZ+pr55lj5tSZkzCucKxBwxB5H1Tjo0ldA69ycV06/W0bj5gqmJcBpExvmu4eB7K5g0kGiETJM5L5cRcmWWcVJe1amkZ54k3477suJjmLulwPXLy44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsmp45Ix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsmp45Ix"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B9D9C4CEEF
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Aug 2025 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754180185;
	bh=OX+vD1uEmGtCEeEvFlG6DbJZuiUNf/FM72XLPjKu3Yw=;
	h=From:To:Subject:Date:From;
	b=lsmp45IxTrw4DimM5psF+Xv4dKvd5G/I3tfCTeLbeAiIEA/3oGmI6cRVtxjUBmBYk
	 H6bSyaDxBSiN9dPB1y2jyWIo0T7+TDl1qVs0rwP83IjQkm6legH0Ki2oOu4A1wmJjS
	 y2gSA0i/IfgCfXpORb1+aomXCkLdhAlXRIBgn+UaUhiRjLhLKjnswcAJuyHfNeVNpC
	 3yDQxgrkpIkLIgwdnpocxbPMiTbxZre87dzemJzmkvpGX9JubqjWj7AeCBrGFrw90V
	 d6mXkW61QPUw3eU9EkLRGFdTcB1mEHyoAqSRL//nDp6+Ft4c2mirv2InkCKXV278A9
	 r5s4qOL3Fk8bw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 08F17C4160E; Sun,  3 Aug 2025 00:16:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220398] New: Bluetooth devices experience severe connection
 issues, frequent disconnections, and input lag in kernel 6.15.2, working fine
 in 6.15.1.
Date: Sun, 03 Aug 2025 00:16:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: dncp4312@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220398-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220398

            Bug ID: 220398
           Summary: Bluetooth devices experience severe connection issues,
                    frequent disconnections, and input lag in kernel
                    6.15.2, working fine in 6.15.1.
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: dncp4312@gmail.com
        Regression: No

Bluetooth Regression Bug Report

Summary:
Bluetooth devices experience severe connection issues, frequent disconnecti=
ons,
and input lag in kernel 6.15.2, working fine in 6.15.1.

Kernel Versions:
- Last working: 6.15.1
- First broken: 6.15.2=20=20
- Confirmed broken through: 6.15.8 (latest tested)
- Distribution: Arch Linux (vanilla upstream kernel packages)

Hardware Information:

lsusb | grep -i bluetooth
Bus 003 Device 002: ID 0bda:2852 Realtek Semiconductor Corp. Bluetooth Radio

Tested bluetooth devices:
- Sony WH-1000XM5 headphones (audio cutoffs ~5 times every 3 seconds)
- Keychron K8 Pro keyboard (severe input lag, duplicate keystrokes)


Symptoms:
- Connection issues when pairing/connecting bluetooth devices
- Frequent disconnections even during active use
- Audio playback cuts off frequently with bluetooth headphones
- Severe input lag with bluetooth keyboards
- Multiple keystrokes being registered for single key presses
- Issues affect all bluetooth device types (keyboards, headphones, etc.)

Steps to Reproduce:
1. Connect any bluetooth device (keyboard, mouse, headphone)
2. Use device normally
3. Observe connection drops and input lag

Expected Behavior:
Stable bluetooth connections with normal input responsiveness (as seen in
6.15.1)

Actual Behavior:
Unreliable connections, frequent disconnects, severe input lag, duplicate
keystrokes

Bisection Results:
Performed kernel bisection on Arch Linux:
- linux-6.15.1: Bluetooth works normally
- linux-6.15.2: Bluetooth exhibits all described issues
- Regression introduced between these exact versions

Error Logs:

dmesg output:
[    1.619605] usb 3-1: Product: Bluetooth Radio
[    6.641878] Bluetooth: Core ver 2.22
[    6.641900] NET: Registered PF_BLUETOOTH protocol family
[    6.641902] Bluetooth: HCI device and connection manager initialized
[    6.641905] Bluetooth: HCI socket layer initialized
[    6.641907] Bluetooth: L2CAP socket layer initialized
[    6.641912] Bluetooth: SCO socket layer initialized
[    6.761556] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000a
lmp_ver=3D0b lmp_subver=3D8852
[    6.763546] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    6.763551] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852au_fw.bin
[    6.764910] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852au_config.bin
[    6.765011] Bluetooth: hci0: RTL: cfg_sz 6, total sz 64499
[    7.299548] Bluetooth: hci0: RTL: fw version 0xd9d617da
[    7.427557] Bluetooth: hci0: AOSP extensions version v1.00
[    7.427563] Bluetooth: hci0: AOSP quality report is supported
[    7.493922] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.493926] Bluetooth: BNEP filters: protocol multicast
[    7.493930] Bluetooth: BNEP socket layer initialized
[    7.494833] Bluetooth: MGMT ver 1.23
[   24.601860] Bluetooth: RFCOMM TTY layer initialized
[   24.601867] Bluetooth: RFCOMM socket layer initialized
[   24.601871] Bluetooth: RFCOMM ver 1.11
[   51.185829] hid-sensor-hub 0005:054C:0DF0.0006: hidraw5: BLUETOOTH HID v=
2.41
Device [WH-1000XM5] on 10:6f:d9:24:c1:d2
[   71.308004] hid-generic 0005:3434:0280.0007: input,hidraw5: BLUETOOTH HID
v1.32 Keyboard [Keychron K8 Pro] on 10:6f:d9:24:c1:d2
[ 1577.292485] hid-generic 0005:3434:0280.0008: input,hidraw5: BLUETOOTH HID
v1.32 Keyboard [Keychron K8 Pro] on 10:6f:d9:24:c1:d2


journalctl output:
Aug 03 05:07:03 envy systemd[1]: Starting Bluetooth service...
Aug 03 05:07:03 envy (uetoothd)[564]: bluetooth.service: ConfigurationDirec=
tory
'bluetooth' already exists but the mode is different. (File system: 755
ConfigurationDirectoryMode: 555)
Aug 03 05:07:03 envy bluetoothd[564]: Bluetooth daemon 5.83
Aug 03 05:07:03 envy systemd[1]: Started Bluetooth service.
Aug 03 05:07:03 envy bluetoothd[564]: Starting SDP server
Aug 03 05:07:03 envy bluetoothd[564]: Bluetooth management interface 1.23
initialized
Aug 03 05:07:03 envy bluetoothd[564]: Battery Provider Manager created
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/ldac
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/aptx_hd
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aptx_hd
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/aptx
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aptx
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/aac
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aac
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/opus_g
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/opus_g
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/sbc
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/sbc
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aptx_ll_1
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aptx_ll_0
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aptx_ll_duplex_1
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/aptx_ll_duplex_0
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/faststream
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/faststream_duplex
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/opus_05
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/opus_05
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSink/opus_05_duplex
Aug 03 05:07:20 envy bluetoothd[564]: Endpoint registered: sender=3D:1.28
path=3D/MediaEndpoint/A2DPSource/opus_05_duplex
Aug 03 05:07:54 envy bluetoothd[564]:
profiles/audio/avdtp.c:handle_unanswered_req() No reply to Close request
Aug 03 05:07:54 envy bluetoothd[564]: No matching connection for device

Additional Notes:
Issue is reproducible across different bluetooth devices and persists after:
- Bluetooth service restart
- Module reload (btusb)
- Clearing bluetooth cache
- Device re-pairing

Workaround: Using kernel 6.15.1 or linux-lts resolves all issues.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
