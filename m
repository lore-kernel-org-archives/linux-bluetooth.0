Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB113BB10E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290748; cv=none; b=UJ0ewAO6ddMU1W046XNCbvhG2R8yS3KdJmhpX7x8A0r6+CzXM0V0Ak8KEHC97Ootrwks8USXbHSeAxbGp0PYZnrHZmPSdSDJJmLotsnraJ1AWlnDo3bire4ZIfRTwwySxFNgwls7xE+rF653colUcazbvzWt3dwFIcOnSrylNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290748; c=relaxed/simple;
	bh=JHx+JdCmyLJj0XqKFkH05UCBw/uaYv4W2uu0RYwjg6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfcJsSb7Zp/7Ma3plyMD3IE74tFO1aGB951urF7kjlakZeVPh4JEAMW7ncCkSMLPGa/H5WAuDsqmg5MzSvC6F8kwl9zKVsXmYxFw3RkIj2kkNuH36iXL0OMQINzOclmm/qca5hqu3/Hz38B8u9T/y0trQXW8NBa3PBti45fnX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn3uZBFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn3uZBFL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AED4FC4AF60
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791290747;
	bh=JHx+JdCmyLJj0XqKFkH05UCBw/uaYv4W2uu0RYwjg6w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fn3uZBFL7BjBLuofIRqD5yc2EuTk13Dj+QFZgU86IIXq8oXuWsR102CAbwwiXBpkr
	 rSu2J4TEH0ToyhZHnCPvNfBG1gbudXD5YL5JGdKs/hrRN4yP57HFtL/fPlTUz8dKGS
	 9R2Iek4N5sEt8KbN5FKXlzWlfKQv2oFbJYg2/HeUe14t56LwRfLORXAVuhT861Obx3
	 MbH78p2taXT3wI9/ZMAT5fcoxRS30CrVEd+r+fLzmJheYrSB+Rj9iG6RJqBXnl4cUm
	 nEAbbFDASnjvnG6EroDEWC9DP8PpekCM5OVcg+LKcZry0CdiUrvvX8x/PPo5B+afOe
	 S+jQqR3z0385w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FF47C53BBF; Tue,  6 Oct 2026 12:45:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Tue, 06 Oct 2026 12:45:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: martino.papero@lcb.to.it
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221754-62941-9gqwnvDyJa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

--- Comment #11 from Martino P. (martino.papero@lcb.to.it) ---
I can confirm the issue is still present on Fedora 44 / kernel 7.2.8

Hardware: Lenovo IdeaPad Slim 3 15IWC11, system product 83RR, BIOS U2CN21WW
(2026-05-13). Bluetooth USB 0bda:b853; Wi-Fi PCI 10ec:b852, driver
rtw89_8852be. Fedora 44 x86_64, kernel 7.2.8-200.fc44.x86_64;
linux-firmware/realtek-firmware 20260916-1.fc44; BlueZ
5.87+1.git8750129efca8-1.fc44.

With the stock Fedora modules:
- HCI version 0x0b, HCI revision 0x000b, LMP version 0x0b, LMP subversion
0x8852.
- rom_version status=3D0 version=3D3; key id 0.
- Requests rtl_bt/rtl8852bu_fw.bin and rtl_bt/rtl8852bu_config.bin.
- hci0 DOWN, zero BD_ADDR, no management adapter, no rfkill block.
- A single privileged HCIDEVUP returns ENODATA (errno 61).
- Opcode 0xfcf0 failed: -16 appears, but "didn't find patch for chip id 3" =
does
not.

The installed rtl8852bu_fw.bin.xz decompresses to an RTBTCore (v2) container
with two patch subsections: eco 1 (67133 bytes), eco 2 (62533 bytes), no ec=
o 4.=20

I checked the exact Fedora source RPM kernel-7.2.8-200.fc44.src.rpm. Its
btrtl.c/h and btusb.c are byte-identical to kernel-ark tag kernel-7.2.8-0, =
and
the Fedora patch does not seem to change these files. Static analysis shows
that the v2 parser selects eco =3D=3D rom_version + 1 (4 here), finds no ma=
tching
content, and returns -ENODATA before firmware download. The exact stock sou=
rce
has no BTNIC003 parser.

The user-provided Lenovo Windows installer for my laptop model
(7ns3020flz7uw5k0.exe) contains
Realtek_8852BE_18.4032.0.3008/rtl8852bd_mp_chip_new.dat. The INF explicitly
associates USB\VID_0BDA&PID_B853 with 8852BD. INF DriverVer:
10/10/2025,18.4032.0.3008. The .dat is 68176 bytes, magic BTNIC003.

For a temporary test, I ported only the multi-record eco4 download path from
mihaits/rtl8852bd-bt-linux onto the exact Fedora btrtl source, adding
pre-download container validation and a check of the final commit response.=
 The
repack uses that project's extractor. I signed the module with an enrolled
akmods MOK; Secure Boot remained enabled.=20

Three records loaded, hci0 UP with a nonzero address, one adapter visible to
btmgmt/BlueZ. Read Local Version returns status 0, HCI/LMP 0x0d, HCI revisi=
on
0x3c91, manufacturer 93, LMP subversion 0x950e (combined version 0x3C91950E=
). A
Bluetooth mouse connects and works.

Regarding comment #10: the installer named above does contain the required
.dat, although its Realtek driver version is also 18.4032.0.3008. I cannot
infer the content of a different Lenovo installer from the driver version
alone, and I can't provide the binary directly. You can try downloading the
same driver for my model, the firmware for the device should be the same.

Regarding comment #8: I found a v8 revision of Hilda Wu's firmware-v3 series
dated 2026-09-23:
https://lore.kernel.org/linux-bluetooth/20260923104521.1706251-1-hildawu@re=
altek.com/
Mirror: https://patchew.org/linux/20260923104521.1706251-1-hildawu@realtek.=
com/
The submission uses RTL8922D as its example. Could Realtek confirm whether =
this
older 8852BD cut / Windows BTNIC003 file is covered, and which official
firmware should be used? I have not applied or tested that series.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
