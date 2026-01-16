Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBC357727
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556102; cv=none; b=Ea/+C3pq+J7IA3p6Q0aGrNrQMvvM8evcotbyuBr5rOxFrxKOxCxxHWakNpNtJ9/0bEiETu+M1ajixHZ84cDsqFKcGSU4T94fJu35QksOa9SkUZqmkenfatNiYAUvgJDmH82jwzWI/oIWyg5D6wcX7nzkcBKXk0792u6k7P+jLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556102; c=relaxed/simple;
	bh=xlmRFGoX954HoRklT8/417Bxwkf2QRmEBZE+L4KR+hQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jrH9k2NCUZTAm+rQNcddVwpa7VHQqroXmidvt9R1ueg93bPLzMBk1t59gCq4HyE1HVAzeVVK+nL4hROW1WYz0wddS32ei8hfZ2XiPiWk5yfiCUQI8xo5Ewt3X9wnlgTARQ+EyWLXU3c2NNvZK2/dPZ+CTsUFjClWrfz4qVM/Xxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmUggFJQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmUggFJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A583C116C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768556101;
	bh=xlmRFGoX954HoRklT8/417Bxwkf2QRmEBZE+L4KR+hQ=;
	h=From:To:Subject:Date:From;
	b=CmUggFJQK3PXj3fWmFlYmk0Rlu+thjHelGTQULptNJ/0XQaMUk4lSsIgTAc6S1LHT
	 4Hs7Mc+FXMtJaH+RvFCfHXjfTnr3i1kt3vnsw2Gf7vROXh7eih8Qu1dwn3+580wOq1
	 WDzOTNGbvFu+2FQA3GYjXAALF6lMLQKC3k9F7HBSjLg5r71Cuxo7HnyWnKMcwWd3UF
	 lY2ba/XZTna5JuJ5rz0HzW2rV5YOi4H8VNHsOhJJNH0JKwfr5wfiO9fBP91EMIbef/
	 QXVnFfXQhnEJClbt591w9RdnxBvWHGssCEcoiTi2zyVyMC41WOZf1ZHZ92yOBnOH+X
	 KGH81NGMZ7Cmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 89F4BC41612; Fri, 16 Jan 2026 09:35:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220986] New: MediaTek MT7925 Bluetooth adapter (USB 13d3:3596)
 fails to initialize - reports as unsupported hardware variant 0x7902
Date: Fri, 16 Jan 2026 09:35:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aamolodc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220986-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 220986
           Summary: MediaTek MT7925 Bluetooth adapter (USB 13d3:3596)
                    fails to initialize - reports as unsupported hardware
                    variant 0x7902
           Product: Drivers
           Version: 2.5
          Hardware: Other
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aamolodc@gmail.com
        Regression: No

The MediaTek MT7925 WiFi/Bluetooth combo card with USB ID 13d3:3596 fails to
initialize Bluetooth functionality. The chip reports hardware variant 0x7902
instead of the expected 0x7925, causing the btmtk driver to request
non-existent firmware (mt7902/BT_RAM_CODE_MT7902_1_1_hdr.bin).

When attempting to use MT7925 firmware via symlink, the chip fails with
HCI_Reset timeout (Opcode 0x0c03 failed: -110).

WiFi functionality works (slowly) via the mt7925 driver, but Bluetooth is
completely non-functional.

STEPS TO REPRODUCE:
1. Boot Linux with MediaTek MT7925 (USB 13d3:3596) present
2. Observe Bluetooth fails to initialize
3. Check dmesg for firmware load failure or HCI timeout

ACTUAL RESULT:
- Without firmware symlink: "Direct firmware load for
mediatek/mt7902/BT_RAM_CODE_MT7902_1_1_hdr.bin failed with error -2"
- With MT7925 firmware symlinked as MT7902: "Opcode 0x0c03 failed: -110"
(HCI_Reset timeout)
- No Bluetooth controller available

EXPECTED RESULT:
Bluetooth adapter should initialize and be usable

SYSTEM INFORMATION:

Kernel: 6.18.5-200.fc43.x86_64
Distro: Fedora 43 (Workstation Edition)

USB Device:
  Bus 001 Device 003: ID 13d3:3596 IMC Networks Wireless_Device
  Manufacturer: MediaTek Inc.
  Product: Wireless_Device

Loaded modules:
  btusb, btmtk, bluetooth

DMESG OUTPUT:

[    5.657894] usbcore: registered new interface driver btusb
[    5.669557] bluetooth hci0: Direct firmware load for
mediatek/mt7902/BT_RAM_CODE_MT7902_1_1_hdr.bin failed with error -2
[    5.669561] Bluetooth: hci0: Failed to load firmware file (-2)
[    5.669563] Bluetooth: hci0: Failed to set up firmware (-2)
[    5.669565] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.

After symlinking MT7925 firmware as MT7902 and reloading btusb:
[  304.624964] Bluetooth: hci0: Opcode 0x0c03 failed: -110

ANALYSIS:
The btmtk driver reads hardware variant 0x7902 from the chip and constructs
firmware path accordingly. However:
1. No MT7902 Bluetooth firmware exists in linux-firmware
2. MT7925 firmware is not compatible with the 0x7902 variant (causes HCI
timeout)
3. The 0x7902 variant may need specific firmware or driver modifications

ADDITIONAL NOTES:
- This device works correctly on Windows
- WiFi portion of the combo card works (via mt7925 WiFi driver)
- Multiple users report similar issues with MT7925 variants on various lapt=
ops
- Related: Launchpad bug #2078878

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
