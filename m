Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAA3CAE66
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041249; cv=none; b=E4wucz56le87bury7j+aFQTcOEcRPNaTTAS0/XKgEgZxGocngJiWmYPiJEU4SQnnyLr2fTG9qw9yEpUX5h4CpLQD0+VKTKghGg4TvY4SRFLCpW4X9e2O6nxU7x/HlHihISOgjR/lWLcrQI48qMPat7AnJBxKwscDOwS6ua3zAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041249; c=relaxed/simple;
	bh=7LoqH8yLo6eIGMNybQaVKiPHLTdBaGi9j7TiVXz5T4o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PLqnyYxgz4fB4tYVBRhzYy5fcwMH9j4T3EN8dHNPfDDVLpK1rZtbya2tNYmWv84F1ZxkBZa+XLMiTxg7ywFK4I+jIOLpHnWCC56jA6sUMWTuVu8kZa7C+81GvUx36eZM0kqCH4Mf3xG+kTHH6Lu7LtClKUfka/Eqfer68LD/N44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epayASHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epayASHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA19EC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041248;
	bh=7LoqH8yLo6eIGMNybQaVKiPHLTdBaGi9j7TiVXz5T4o=;
	h=From:To:Subject:Date:From;
	b=epayASHZcS9rA92xK1FYTtLuPoH4fLvww5LpzPMlyzqJRoSt3dG6FZtLEf97JxeW8
	 HKuD/tRaIYzzWOVJ5XB4Iod+xUsLR6XQBUsRxGjLKZt6t99SSLA/D0EvrRPH7XI7vo
	 0Qx3wQDHXtWH1a8DxMyjuDQ7rZ2QsHKhwINAXxOUxgiLbJ5HN6vJgHVsfq2wnSQDIU
	 iSzO/Bd95G4NSiEuNekv5QwZoiS17jbOQm5mDAbeH9i/A/PMah6oqPqIjB0uoJDw37
	 +AO+P3DaWMVVoAPgFYqaYmek2EyY1sHMGHnibfmTeAxjWpaEAlREGjyd6elsACsehn
	 7R4QqfEfhxxtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9571EC433E1; Sun, 17 May 2026 18:07:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE1MzldIE5ldzogTVQ3OTI1IEJsdWV0b290aCBmYWls?=
 =?UTF-8?B?cyB0byBpbml0aWFsaXplIHNpbmNlIGtlcm5lbCA3LjAuOCDigJQgcmVncmVz?=
 =?UTF-8?B?c2lvbiBmcm9tIDcuMC41?=
Date: Sun, 17 May 2026 18:07:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sphinx-rift-sector@duck.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221539-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221539

            Bug ID: 221539
           Summary: MT7925 Bluetooth fails to initialize since kernel
                    7.0.8 =E2=80=94 regression from 7.0.5
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: sphinx-rift-sector@duck.com
        Regression: No

**Hardware:**
- Framework Laptop 13 (AMD AI 300 series)
- WiFi/BT chip: MediaTek MT7925 (RZ717)
- PCIe ID: MEDIATEK Corp. MT7925 (RZ717) Wi-Fi 7 160MHz
- BT interface: USB (hci0)

**Working kernel:** 7.0.5
**Broken kernel:** 7.0.8
**Firmware:** linux-firmware 20260410
(mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin)
**Distro:** NixOS 26.05 (unstable)

**Description:**

Bluetooth on the MediaTek MT7925 stopped working after upgrading the kernel
from 7.0.5 to 7.0.8. WiFi continues to work via the mt7925e PCIe driver. Th=
e BT
USB device enumerates and hci0 is created, but the WMT firmware handshake f=
ails
with EINVAL (-22). The adapter cannot be brought up.

This is a regression: the same firmware and hardware work on kernel 7.0.5.

**Symptoms:**

- `hciconfig hci0` shows BD Address: 00:00:00:00:00:00, state DOWN
- `hciconfig hci0 up` returns: "Can't init device hci0: Invalid argument (2=
2)"
- `modprobe -r btusb && modprobe btusb` does not resolve the issue
- Rebooting does not resolve the issue
- rfkill shows hci0 not blocked (soft or hard)

**dmesg (relevant lines):**

```
Bluetooth: Core ver 2.22
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
usbcore: registered new interface driver btusb
Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260106153314
Bluetooth: hci0: Failed to send wmt func ctrl (-22)
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.
mt7925e 0000:c0:00.0: WM Firmware Version: ____000000, Build Time:
20260106153120
```

Note: `HW/SW Version: 0x00000000` indicates the chip is not responding to
version queries during the WMT protocol handshake.

**Steps to reproduce:**

1. Boot a system with MediaTek MT7925 on kernel 7.0.8
2. Check `hciconfig hci0` =E2=80=94 adapter is DOWN with null BD address
3. Attempt `hciconfig hci0 up` =E2=80=94 fails with EINVAL
4. Downgrade to kernel 7.0.5 =E2=80=94 Bluetooth works

**Related:**
- Bug 219sp688 reports MT7925 BT initialization failures on kernels 6.12=E2=
=80=936.15,
but with USB enumeration timeouts (-110). This bug is different: USB
enumeration succeeds, but the WMT func ctrl command fails (-22).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
