Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E2EE60B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111874; cv=none; b=OwrYN9qXVuStelq6Vh51x2Iqe6Ahx9KcglluZOW5iICRI6cw5psfO0MnepgA9Asy7YFEldnL2+McYTSzLiWn3os/EfJl1XG6eRelfE1YWT5OQXd2WGF8PFmGj46MiyvpLGWqiqLt3UJavc/m9kUF/AzuE6iZmJfSiEWZOuOxpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111874; c=relaxed/simple;
	bh=VijmZCm9w47mE634UJ6WgPSvYWLyjCZ7Blj+Oe91Gno=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WeVkoo7v2IgYtT5o0jbyWB6RnigTrG3NEA158Hbe69SExt6nQ40rwcoSug5XDmYl8J3itjr3Gdlke9kRTUH524G9PwMUKk2om6m1ImoYp5CEzEF+hcvz3heg2+mqxHEWamv53rsyyqdTFeqmlV1UOImbb2NRiahHISCCQbm2UaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWo+pcsN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWo+pcsN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C4C3C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 05:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761111872;
	bh=VijmZCm9w47mE634UJ6WgPSvYWLyjCZ7Blj+Oe91Gno=;
	h=From:To:Subject:Date:From;
	b=bWo+pcsNrLM+NI2lzh962UPllwU2WjEhDJPiuK0vSaWpvaFJGopNefH70+ooCITa7
	 SAVGBQWNC6daCtUKAg6zso06QvqOrsT/k/83DHQ0Oi6Kp3HnXVOET1/QF3sUMbqWgR
	 aekjiioaQ6LxPmgmYMeQHXJmpZzdp8G8zg7vUhV5LnLHtL7G954ajNrXHftoNCIzE/
	 KNP3oeodyRKAwnkB4KOvguGIJYzJH+5gejEKdxATB8heHdEVCMrnilgEhERLjW5uYT
	 OgmIuVjPp4ntAsfy0INnbb5vd7t66g9DzErSYWJ5EsZ96+kV9exAVpZaltNiG2OHPp
	 PDVwVc4KppSsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8AE03C3279F; Wed, 22 Oct 2025 05:44:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220692] New: Intel BE201 Opcode 0x0c1a failed: -110
Date: Wed, 22 Oct 2025 05:44:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: mapengyu@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220692-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220692

            Bug ID: 220692
           Summary: Intel BE201 Opcode 0x0c1a failed: -110
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mapengyu@gmail.com
        Regression: No

Created attachment 308836
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308836&action=3Dedit
be201-bt-6.18rc2-Opcode-0x0c1a-dmesg.txt

Intel BE201 shows Opcode 0x0c1a when press airplane mode in gnome setting.

Kernel version: 6.18.0-061800rc2
Firmware is updated, please check the version info in dmesg.
Even when iwlwifi is not loaded, the issue is still reproduced.

Logs:
kernel: Bluetooth: hci0: Opcode 0x0c1a failed: -110
kernel: Bluetooth: hci0: Error when powering off device on rfkill (-110)
kernel: Bluetooth: hci0: command 0x0c1a tx timeout
kernel: Bluetooth: hci0: Initiating acpi reset method
kernel: Bluetooth: hci0: HCI reset during shutdown failed

Then the USB devices is reset:
kernel: usb 3-6: USB disconnect, device number 5
kernel: usb 3-6: new full-speed USB device number 6 using xhci_hcd
kernel: usb 3-6: New USB device found, idVendor=3D8087, idProduct=3D0037,
bcdDevice=3D 0.00
kernel: usb 3-6: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=
=3D0

Device info:
00:14.3 Network controller [0280]: Intel Corporation Device [8086:a840] (rev
10)
        Subsystem: Intel Corporation Device [8086:00e4]
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort-
<MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at 2051330000 (64-bit, non-prefetchable) [size=3D1=
6K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, M=
SI
00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag+ RBE- FLReset+
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP-
LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt-
EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+
10BitTagReq- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
        Capabilities: [80] MSI-X: Enable- Count=3D32 Masked-
                Vector table: BAR=3D0 offset=3D00002000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Kernel modules: iwlwifi

Bluetooth info:

Bus 003 Device 007: ID 8087:0037 Intel Corp.=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x0037=20
  bcdDevice            0.00
  iManufacturer           0=20
  iProduct                0=20
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00c8
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
