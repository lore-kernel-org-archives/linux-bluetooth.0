Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A30350A35
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949341; cv=none; b=m1aOTKbuFrS3LhPUNTxRkzic+kNqFHdXYm4JC6zCXC1jgChsKSl8wxYx41OQzIgM12WPZ3jT2CUcgqrS/R+3EfLxg/yei+SKbvkivF2z4fcUU2aOlRk+C09CTa+aaI09yPH4xW1E4He2F/06duhvva5BRrOvw5F3nzbjTu+jCLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949341; c=relaxed/simple;
	bh=CTU5wjMuRvgvcexwj1yLY/xjisvTX9CHqG9/277qJJc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QmUF9lYBluRCN9V/A9ZpYD/olMYw/v1kzvZxbsXwpavnfmajFYy+iw4YZPWV+rMZ5TFSrIiSZhaWM9whL9283HCv9Ih3xi5yHMkWbur+tQO5lGV8FYAYUAxGkrOBwpVrWpoq3fODICMwLgA//XGAhnCkYP/lFSjMr5fueGboz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ5AQ9Hf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ5AQ9Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 518E1C19425
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785949341;
	bh=CTU5wjMuRvgvcexwj1yLY/xjisvTX9CHqG9/277qJJc=;
	h=From:To:Subject:Date:From;
	b=MQ5AQ9HfR/09kwApFHsCKma0TVkB5bXRZCEcByz1XSRBJt6q4RJ9ER3URZjtu6uJv
	 4mYj6DSNIOxl5gu4uLZ/lqmbnMKaurGHYkQX6L82Gzpbe/IKt9gdegjlrhTJXs8U4j
	 W16HQZMyOO0wTk1QRu+nnR0wOdb4cV1979+KOsT3Ug/QZmp2Hw8+rSnyqShVpI4d+i
	 TluLypxirSEPgN5z2cUPWSwLkt18I/Rd7PwhmPSnnHykPsqGqF5TofTFzEsrAkPnKh
	 mhkMRHo0+DpHLswDH+UvpZ9UrVZe5tZBzOEWQZBq1M0KQ3XNzgsvOiHqFK0HjV/Opi
	 hlodQmNCpxkkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2E2ADC433E1; Wed,  5 Aug 2026 17:02:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] New: Bluetooth (RTL8852BU, 0bda:b853) never
 initializes.  Opcode 0xfcf0
Date: Wed, 05 Aug 2026 17:02:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: rohanasrani3@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

            Bug ID: 221837
           Summary: Bluetooth (RTL8852BU, 0bda:b853) never initializes.
                    Opcode 0xfcf0
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: rohanasrani3@gmail.com
        Regression: No

## System information
- Distro: Linux Mint 22.3 (zena), Ubuntu 24.04 base
- Kernel: 6.11.0-17-generic (#17~24.04.2-Ubuntu SMP PREEMPT_DYNAMIC)
- linux-firmware package: 20240318.git3b128b60-0ubuntu2.27
- Laptop: Lenovo LOQ 15AHP11
- Bluetooth controller: Realtek RTL8852BU, USB ID 0bda:b853 (Bus 001 Device
004)
- WiFi: Realtek RTL8852BE, PCI ID 10ec:b852, driver rtw89_8852be

## Problem
hci0 never comes up. BD Address stays 00:00:00:00:00:00, state DOWN,
`bluetoothctl show` reports "No default controller available". Reproduces on
every boot.

## dmesg (current state, after updating rtl8852bu_fw.bin)
```
[    2.491778] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b
lmp_ver=3D0b lmp_subver=3D8852
[    2.494811] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[    2.494818] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    2.495778] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    2.503791] Bluetooth: hci0: Opcode 0xfcf0 failed: -16
[    2.507788] Bluetooth: hci0: AOSP extensions version v0.96
[    2.507793] Bluetooth: hci0: AOSP quality report is not supported
```

## What I've tried

1. Confirmed rfkill is not blocking (`Soft blocked: no`, `Hard blocked: no`=
 for
both `ideapad_bluetooth` and `hci0`).
2. Confirmed Bluetooth works fine from Windows on the same physical hardware
(dual-boot). (fast-boot is disabled)
3. The distro-packaged `rtl8852bu_fw.bin` (linux-firmware 20240318 snapshot)
additionally logged `Bluetooth: hci0: RTL: didn't find patch for chip id 3`
before the Opcode failure i.e. this chip's rom_version (2, reported as "chi=
p id
3") had no matching entry in that firmware build's internal patch table.
4. Replaced `/usr/lib/firmware/rtl_bt/rtl8852bu_fw.bin` with the current
upstream linux-firmware HEAD build (fetched from git.kernel.org, 129733 byt=
es,
md5 c97273d1bf9a715c46e4fc73eb0283b3, valid `RTBTCore` header). This resolv=
ed
the "didn't find patch" message but `Opcode 0xfcf0 failed: -16` still occurs
immediately after.
5. Confirmed via linux-firmware's WHENCE manifest that
`rtl_bt/rtl8852bu_config.bin -> rtl8761bu_config.bin` is the correct,
intentional upstream mapping =E2=80=94 ruled out using the wrong config fil=
e.
6. Full reboot
7. Attempted to isolate a WiFi/Bluetooth coexistence conflict (RTL8852B is a
combo WiFi+BT chip) by unloading the rtw89 WiFi stack before reloading btus=
b.
`rtw89_8852be`/`rtw89_8852b`/`rtw89_8852b_common` unloaded, but
`rtw89_pci`/`rtw89_core` stayed loaded (rmmod dependency-order limitation).
8. Set `usbcore.autosuspend=3D-1` as a kernel boot parameter.

The firmware's patch table now recognizes this chip's rom_version, but the
controller still returns "Command Disallowed" on the vendor download-config
opcode 0xfcf0. This looks like it needs additional handling in btrtl.c/btus=
b.c
for this specific RTL8852BU chip stepping (rom_version=3D2). Is there a kno=
wn
driver-side fix in progress, or would a btmon/HCI trace help narrow this do=
wn
further?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
