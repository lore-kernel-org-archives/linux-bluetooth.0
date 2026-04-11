Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC917BA6
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911290; cv=none; b=tTgsMKu8DrdXEtnFeLH1M3hTgg8iBq2F5PAtw0j6qUQEtnnKVgbWq2eiqizzJZ2fKR4VYCpUKFZI85X63z7V+TbAV7TPJ/CCRBOk2GOD0lHyaemyMMJucNE4x3uhqlKkJdvYwieI86/6XC6bVdRdFKUGCMQh/V5AE55JpupoHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911290; c=relaxed/simple;
	bh=4eVD8cUg0tRiFo//Hl3yO6W3h7ESOtLptPCPOeFY4vA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RV71U8qAaBGAy8No4e0yH30yZqqQP7xRENAfOmogT7xCCtIZqcAATJdkkPvlc9ANpmHc3W4NndnuSBMTi/YTZGA0dRmdZdkUcSKyDwRmlBStf05BvBaoYgicUWTEEy4rCtuoJXaNre4coS+UIgIVNjEkBgCF4xZAx6NZ89JHt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEAIU+ki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEAIU+ki"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 802B9C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775911290;
	bh=4eVD8cUg0tRiFo//Hl3yO6W3h7ESOtLptPCPOeFY4vA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pEAIU+kiE9LoIyFYIiq92wYpc/PBAH7B4zWR8jmIEfDNUWtPM7AQs8JZ/CoQs5XeS
	 xDc2fzwRULGFWh41OfijAKD03g6pOEEGxhlrye0hJyI1/CFgQwEyuVIcJIZBFz5Cp+
	 3vJyC0wzFTuVO1SognDuBuOG5D2xh1pwwy8XMxmruvasYBHPxvmNPmb846q6N3BuzQ
	 UqbrzJE31bGOlsZNUjiT+4ePxCmlX7qy8h3m9XFJq8Da5KHbo2DQI0E3K4YZXVMCdL
	 5E5MPt+wVWW68B6ZMy/+iSTeamvOZ+W4U4x/uYZL9n1icup16CUfVAKiz0OYE1DeZA
	 wCvhQjXWrb7Yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 74661C433E1; Sat, 11 Apr 2026 12:41:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Sat, 11 Apr 2026 12:41:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-221346-62941-8zauA7Z8nx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221346-62941@https.bugzilla.kernel.org/>
References: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

Zhang Zhigang (zhangzhigang1996@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.18.1

--- Comment #1 from Zhang Zhigang (zhangzhigang1996@gmail.com) ---
### Additional system information

#### Hardware

```
00:14.3 Network controller [0280]: Intel Corporation Device [8086:e440] (rev
01)
00:14.7 Bluetooth [0d11]: Intel Corporation Device [8086:e476] (rev 01)
```

#### PCI device details

```
00:14.7 Bluetooth [0d11]: Intel Corporation Device [8086:e476] (rev 01)
        Subsystem: Intel Corporation Device [8086:0011]
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie
```

#### Loaded Bluetooth-related modules

```
btintel_pcie           45056  0
btintel                69632  1 btintel_pcie
bluetooth             958464  43 btintel_pcie,btintel,bnep,rfcomm
```

#### Driver information

```
filename:=20=20=20=20=20=20
/lib/modules/6.18.1-01-perlis001-20260409003/kernel/drivers/bluetooth/btint=
el_pcie.ko
version:        0.1
description:    Intel Bluetooth PCIe transport driver ver 0.1
```

#### Kernel version

```
6.18.1-01-perlis001-20260409003
```

#### Firmware

Available firmware files under /lib/firmware/intel/ (ibt-*.sfi / .ddc prese=
nt)

Note:
No firmware loading messages observed in dmesg.

#### dmesg (Bluetooth-related)

```
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
```

#### udev device path

```
/devices/pci0000:00/0000:00:14.7/bluetooth/hci0
```

#### Interrupts

```
IR-PCI-MSIX-0000:00:14.7    btintel_pcie
```

#### Additional observations

* systemd-udevd enters D state during shutdown
* Issue disappears when btintel_pcie is unloaded or blacklisted
* Problem reproducible under reboot stress test

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
