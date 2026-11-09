Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221594;
	b=eCVwy8zkBBLQHugf5wgFxquNeRUIk1KehQViBz5GOQpf3GZ5vuNe8bxo2XkMtA80Boh4
	 dUYIRa3efaT1jrpKz5c+P851EeCMmyNyhFrnzUA5u3D0iG49WBjcSmt4a9m1iiAWVN9q/
	 TqQV6VBhY1NrgfM6+2GtRFNOfXzSpWcbnYHEvC/gYKc00S4zxuRA414NgX7ck9YcxoKeW
	 SFD7290JiUEPv0YrhOuJYf2kmWOJ5KkwwnAYPYNZOCF+MkG7ar0pbeKwsjYJtFQAm7Bof
	 biihhqQ0aCxBXGAaOI2lXAvd7vRElWTg/zevzrXQ17I8APL2IB7IzAwZuxLpZZFnz2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221594;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=nmLN9acd94Sgz/2W3Zvz71i7GPZoBhuKM8CabBSe1pA=;
	b=YHrHBRTYcBPmaW1M0fBosiDUhMKLaQRd9hvuUyykSVkrR/SAwZBdEG1INMViTQBhwLYK
	 9M1e+4+mE6mGPshXELRxhTVcJfxEOQoSDBixWWQkoIbH0DeOcMTg56SYdKMWr+zZXsp9z
	 QBhq4Hytbl8KKkmnGBNk29mqTS2Glm1/Nb7HzUranBcnBW+2ryr5stDX0Ki1R1ZslTseV
	 Vc2VT736Wcxu7abGOj7QCnQuh3WE65IdfRiHXn7fJ8niCk/maqjAyOnNefZLWZkXVCWnq
	 f5GMjsUvH13hXtWO8PAJJ9sgppmtm+UyMQN0Yj5iiPnZPhpsX5vhsPRPzaXtnKJBXkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwWtKdQC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE084606A334
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwWtKdQC
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E2081F0089F
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221593;
	bh=nmLN9acd94Sgz/2W3Zvz71i7GPZoBhuKM8CabBSe1pA=;
	h=From:To:Subject:Date;
	b=hwWtKdQCesypMH9UScoEXHfG6mv7zNLdlCQkjM1pmsZ+LndSt1oE2oxrciEQ+HBR/
	 8Kn2MFvrf25NVGeotvxcl0pP3goJ3usOjgqbypmOECpyw3fafyugb/MY1veUksefcF
	 ak2/OCrinSKMq3X3O8ILnxfVbTcwFntRgMfwAhz9AQt0yczeeKC71fJXZWOpNdyaWR
	 PvaIobHZbyyS5vd0jeiz7jmdy+z9WwehselgSZVIsltv/iGko3msrudWGvkwR4JPQ1
	 xdxqcce4aidLhVjplJiMNOnZCw6+rJ4A+NY69eU5+M0oZ87P+iYgNVzA8c/eftmxMD
	 ciorRhzfNSblg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1E83FC4160E; Mon,  9 Nov 2026 10:53:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222250] New: v7.4-rc2: Bluetooth: hci0: Opcode 0x041a failed:
 -22
Date: Mon, 09 Nov 2026 10:53:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-222250-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222250

            Bug ID: 222250
           Summary: v7.4-rc2: Bluetooth: hci0: Opcode 0x041a failed: -22
           Product: Drivers
           Version: 2.5
    Kernel Version: v7.4-rc2
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: frc.gabriel@gmail.com
        Regression: Yes

Hi, good morning,


I just booted v7.4-rc2 and noticed that bluetooth no longer connects to pai=
red
headphones. Removing + trying to repair doesn't work either.


Dmesg shows:


root@localhost:~# journalctl -b -1 | grep -i "Opcode 0x041a failed:" -A2 -B=
100
| grep -i "kernel\|bluetooth"
Nov 09 09:50:45 localhost kernel: Bluetooth: hci0: Loading BT firmware:
mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin
Nov 09 09:50:45 localhost kernel: Bluetooth: hci0: BT HW ver: 0x7925, SW ve=
r:
0x0000, Build Time: 20260813113236
Nov 09 09:50:46 localhost kernel: Bluetooth: hci0: Device setup in 349484 u=
secs
Nov 09 09:50:46 localhost kernel: Bluetooth: hci0: HCI Enhanced Setup
Synchronous Connection command is advertised, but not supported.
Nov 09 09:50:54 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX: Protocol not availa=
ble
Nov 09 09:51:57 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:51:58 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:51:58 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:51:59 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:51:59 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:52:00 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:52:00 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:52:02 localhost kernel: Bluetooth: hci0: Opcode 0x041a failed: -22
Nov 09 09:52:07 localhost bluetoothd[7697]: src/service.c:btd_service_conne=
ct()
a2dp-sink profile connect failed for XX:XX:XX:XX:XX:XX:: Protocol not avail=
able
Nov 09 09:52:07 localhost kernel: Bluetooth: hci0: Opcode 0x041a failed: -22


It works OK with v7.4-rc1.

Greetings,
Gabriel Francisco

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
