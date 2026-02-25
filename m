Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52F3ECBC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049507; cv=none; b=DaPK027jR5rvg2pdZtdkZpSTXuxu4YFlRi+WZtXbln2WgLP42QR2zFML5YYk4ADe4CZbJwurRKQekfqwAB1hMueN4OyPyT1gxxT/nAI/GG+lGRVLgFQW/MUu2PJNJL3Vb5axpj2b6nGvU4ZFEt1/+fL9PRt7ZULYOLcKX4L9obs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049507; c=relaxed/simple;
	bh=WkUFTJtEz7dV8gtyIcn8aMI5f2FyVSzZb7zN5d/3tq8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AYpNioWHRE4qeSIK27t9ezdsYaHxJMqIGSzq6upgZpUd3KXSae2KxoefZB16l4W5B2TnA7/VRO9+RBgHgEi2pgXnji+so5mKiec6vRhBCoKPKVD62j/rd5FhTbtVw/PH1bZpDsnb4RwljJ/myIaO4TnwcxnC6+5k4nwiS+3oB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsHwI2C4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsHwI2C4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D04DDC116D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772049506;
	bh=WkUFTJtEz7dV8gtyIcn8aMI5f2FyVSzZb7zN5d/3tq8=;
	h=From:To:Subject:Date:From;
	b=GsHwI2C4Ih9FAcnssxAAq5e+BRdcr+t8B60t1otMscCRKjJA2nwuOWU49FwNF9rNk
	 RekPft6VsiduAG4dS4W1Wh2R+Jx3dzHxAHXpP2c7L35IPdsK6LKeOu1ZaIp/0b0CV0
	 MKAe8dfO+QP3ylSxTesI+AAYyhM1cC+18dz8WftkpHL7y+OBpXKtYHz6CLFHZ9i98T
	 nr1NI9MFjRsc10sGRHJUyAfUDT7xSK3MPGtoGlJgHFUCKt7RKvWv9nD4skgpDd6AND
	 VWCftwjP1hUbzE8wWPHkXJ669rFKWyEDjJs3wS2pvQ3bC88idIXnYLDcxhqLO1Kfmn
	 IzqwgFxtZkPIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C12F1C433E1; Wed, 25 Feb 2026 19:58:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221140] New: 0000:00:14.7 btintel_pcie ibt-0190-0291 HP
 Omnibook Ultra Flip 14
Date: Wed, 25 Feb 2026 19:58:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: paolo.baruffa@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221140-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221140

            Bug ID: 221140
           Summary: 0000:00:14.7 btintel_pcie ibt-0190-0291 HP Omnibook
                    Ultra Flip 14
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: paolo.baruffa@protonmail.com
        Regression: No

There are some problems on loading of bluetooth firmware on HP Omnibook Ult=
ra
Flip 14

Here's the dmesg error:

[    8.684465] Bluetooth: Core ver 2.22
[    8.684492] NET: Registered PF_BLUETOOTH protocol family
[    8.684494] Bluetooth: HCI device and connection manager initialized
[    8.684498] Bluetooth: HCI socket layer initialized
[    8.684500] Bluetooth: L2CAP socket layer initialized
[    8.684503] Bluetooth: SCO socket layer initialized
[    8.709513] Bluetooth: hci0: Device revision is 0
[    8.709518] Bluetooth: hci0: Secure boot is enabled
[    8.709519] Bluetooth: hci0: OTP lock is disabled
[    8.709520] Bluetooth: hci0: API lock is enabled
[    8.709520] Bluetooth: hci0: Debug lock is disabled
[    8.709521] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    8.709522] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[    8.710085] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[    8.710089] Bluetooth: hci0: Boot Address: 0x30098800
[    8.710090] Bluetooth: hci0: Firmware Version: 15-3.26
[    8.786307] Bluetooth: hci0: Waiting for firmware download to complete
[    8.786311] Bluetooth: hci0: Firmware loaded in 74436 usecs
[    8.788788] Bluetooth: hci0: Waiting for device to boot
[    8.788790] Bluetooth: hci0: Device booted in 2413 usecs
[    8.788790] Bluetooth: hci0: Waiting for device transition to d0
[    8.788790] Bluetooth: hci0: Device moved to D0 in 0 usecs
[    8.788940] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[    8.792639] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[    8.792648] Bluetooth: hci0: Boot Address: 0x10000800
[    8.792649] Bluetooth: hci0: Firmware Version: 15-3.26
[   10.947311] Bluetooth: hci0: command 0xfc09 tx timeout
[   10.947406] Bluetooth: hci0: Failed to send firmware data (-110)
[   10.947458] Bluetooth: hci0: Firmware download retry count: 1
[   10.993178] Bluetooth: hci0: Device revision is 0
[   10.993184] Bluetooth: hci0: Secure boot is enabled
[   10.993186] Bluetooth: hci0: OTP lock is disabled
[   10.993187] Bluetooth: hci0: API lock is enabled
[   10.993188] Bluetooth: hci0: Debug lock is disabled
[   10.993190] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.993193] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[   10.993615] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[   10.993619] Bluetooth: hci0: Boot Address: 0x30098800
[   10.993623] Bluetooth: hci0: Firmware Version: 15-3.26
[   11.053096] Bluetooth: hci0: Waiting for firmware download to complete
[   11.053108] Bluetooth: hci0: Firmware loaded in 58096 usecs
[   11.055474] Bluetooth: hci0: Waiting for device to boot
[   11.055483] Bluetooth: hci0: Device booted in 2288 usecs
[   11.055486] Bluetooth: hci0: Waiting for device transition to d0
[   11.055488] Bluetooth: hci0: Device moved to D0 in 1 usecs
[   11.055789] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[   11.062520] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[   11.062551] Bluetooth: hci0: Boot Address: 0x10000800
[   11.062554] Bluetooth: hci0: Firmware Version: 15-3.26
[   12.513763] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.513766] Bluetooth: BNEP filters: protocol multicast
[   12.513768] Bluetooth: BNEP socket layer initialized
[   13.251304] Bluetooth: hci0: command 0xfc09 tx timeout
[   13.251322] Bluetooth: hci0: Failed to send firmware data (-110)
[   13.251406] Bluetooth: hci0: Received gp1 mailbox interrupt
[   13.251450] Bluetooth: hci0: MSFT supported features length mismatch

kernel version: 6.18.9
linux-firmware version: 20260221-1

The only fix found for now is resetting the bluetooth device with this scri=
pt:

#!/bin/sh
echo 1 > /sys/bus/pci/devices/0000:00:14.7/remove
sleep 1
echo 1 > /sys/bus/pci/rescan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
