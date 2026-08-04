Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013E430301
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831178; cv=none; b=ogAQtqJo3uuEtU4JxDO48WtmMCvpUBv+aZvy3oLyzfkv/VjpDNDnLleVsmPR3mfbDejSJdTJrmDXSbZVfbr7FklKJFt/9HLoN7cp+u+4ThdhqzYhK+yikj7kB84GPT7C0yP8MWLoUZAWSrcdY8I2I2Nvc47upWxNmqufe+s9JRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831178; c=relaxed/simple;
	bh=kw2NOs+2sDylbViPxuvN2WC+2RwWUq83YIR36BMnBNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRZmWyWroRFKWTY2lVQikRhM0ZqcDX6Kz5n+M7JTcqCpkpV2SZUTGRNe2E7KU+08lyv8c8/2Sj3TLifWPtZoPfLoe0p0Q2xEbKiUWgVpq01gKDe/CMtRrHDshP5Ane2CAwyPkiupL2LqN5yKtPR9lK7AP0ItXsebEukVLhQR8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrL6YvgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrL6YvgW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F3B9C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785831178;
	bh=kw2NOs+2sDylbViPxuvN2WC+2RwWUq83YIR36BMnBNg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hrL6YvgWKueQoqYVSCZlc3Bs+JpLi5/lmpa4UofF7X5i6ptHrRs5dsDQoc4LOZcwA
	 U9z6w8gt+c5ukZ5O9TKM6wS8BYuzjoZP7nMxW3dxV0JMXT0dbmUw67J8cGHHD9z6rB
	 vpIqy31zjjtD96I0ccJ9GP+hnrLrVNS/o9i5OQeC00wGcHgL1uoSDMzM75qNIWZRyp
	 5wTRpIV0WyAcheLIU94zRMiFockIRZ9pFCF90QGe4TJshn6Rb/EmFZVJOvoRBZy8E/
	 Q7BKKCCpUFNigkE7b8R0eBafaiFQM/9m9k3gfu2+q2w+MieD614h0bzaewpeDT1w+P
	 109D7cpxZmDug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1FB45C41612; Tue,  4 Aug 2026 08:12:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Tue, 04 Aug 2026 08:12:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: serge.brun@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221754-62941-WAGHhCMp7O@https.bugzilla.kernel.org/>
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

--- Comment #4 from serge.brun@gmail.com ---
(In reply to jeremy from comment #3)
> (In reply to serge.brun from comment #1)
> > Created attachment 310453 [details]
> > rtl8852be-bluetooth-bug-report.md
>=20
> My Bluetooth-7.0 repo only recently included the ID of your bluetooth
> device, you may want to try it again


Thanks for getting back. I saw the newer commit (61e58e8) adds an explicit
id_table entry for 0x0bda:0xb853 with BTUSB_WIDEBAND_SPEECH.=20
Pulled it, rebuilt via DKMS, confirmed the rebuilt module loaded (checked v=
ia
modinfo), and reloaded.

Result:

$ sudo dmesg | grep -i hci0 | tail -15
[    4.309610] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[    4.311125] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[    4.311129] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    4.311965] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    4.315931] Bluetooth: hci0: Opcode 0xfcf0 failed: -16
[    4.317327] Bluetooth: hci0: AOSP extensions version v0.96
[    4.317331] Bluetooth: hci0: AOSP quality report is not supported
[ 1524.160747] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b
lmp_ver=3D0b lmp_subver=3D8852
[ 1524.162741] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[ 1524.164738] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[ 1524.164744] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[ 1524.165315] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[ 1524.168747] Bluetooth: hci0: Opcode 0xfcf0 failed: -16
[ 1524.170741] Bluetooth: hci0: AOSP extensions version v0.96
[ 1524.170745] Bluetooth: hci0: AOSP quality report is not supported

$ sudo btmgmt info
Index list with 0 items

In case it's useful: my device was already binding to the stock in-kernel b=
tusb
driver before testing any of your patches (the original bug report shows the
same RTL: examining/loading sequence without this repo installed at all), so
0x0bda:0xb853 seems to already be present in mainline's id_table.=20
That would mean BTUSB_WIDEBAND_SPEECH is the main functional change here, a=
nd
since that quirk affects SCO/audio codec negotiation rather than the initial
power-on handshake, it may not be positioned to affect the Opcode 0xfcf0
failure specifically. Could be wrong about that though.=20
Let me know if you want me to check anything else (e.g. instrument btrtl.c
around the vendor command send/response for opcode 0xfcf0, or test a specif=
ic
rom_version=3D3 code path).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
