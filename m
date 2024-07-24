Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC7D29E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804203; cv=none; b=N3XXUKY336TZ3iwEYlOGggir4NPsb2bBYtP5q3Kbo8wYgWyGlsiWpNHlE2rEWfkI/Du8Ur5GcsNBxT/yN4l0iG53+tyPMHY2CG7WglO1aaP7Bodl/Xp4iBx28wL646Gh6rI5AARnR0HioFp4KHuMd1AXv4RMGuJXcmAWCiEqG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804203; c=relaxed/simple;
	bh=hvqsQvFLMP25syCGEfwJVlzZN1zg+Mz6S8vtr7GMQLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EBnNkLrGTdb1TjDQIQflPPXtF4Y3jzT4Vvu865XFsMhkeYnAybrJtmsAzu2cssmkEsVoV05/kDfmxm+vI/FZ0YS+DfayThlErycWRRotMwNIYjYppgCoxIIXOuSGYkN6mxPKUA2DruQnGbBgYbe6Ohxn6lGNXt5zu2+kIEpgMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdhUW/Zz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdhUW/Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8D72C32782
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721804202;
	bh=hvqsQvFLMP25syCGEfwJVlzZN1zg+Mz6S8vtr7GMQLM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XdhUW/ZzqRvq4D4u6I30BsFk5wKXM34QrDmzVHrxK3cjYAiBBEflvMb7jRjKtfzug
	 5FaYyTI9SvabuJgX8PCozYXWdOfmU0Rq9+M98CJ9YtmTJrGl1X7DveMDNAEFInTaiJ
	 DsaaxUUZVHnxYYl2DQzJM8X0YwEX9bX1XJuTaB1Vbr9JXMm7mK61vhpiyUJ0aEDWNm
	 HaUxpp5Sca7MRvsql01UAaGekZpHT3XfOW4C/JF1olXmSrlzd0x6uegJvdzaJPF8oM
	 3ZimUvwRSlgkuNTjK2VuDOrCZZkZWlK6jELHBNB17eajfccGnugQ59U/VsOz6ozcYf
	 O1baZRyr5+6kQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97F63C53B73; Wed, 24 Jul 2024 06:56:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Wed, 24 Jul 2024 06:56:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-1W35sKDWiu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #1 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
$ dmesg | grep -e 'iwlwifi\|Bluetooth'=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
[    2.633116] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
[    2.643454] Bluetooth: Core ver 2.22
[    2.646521] Bluetooth: HCI device and connection manager initialized
[    2.647920] Bluetooth: HCI socket layer initialized
[    2.648885] Bluetooth: L2CAP socket layer initialized
[    2.649972] Bluetooth: SCO socket layer initialized
[    2.658734] iwlwifi 0000:03:00.0: Detected crf-id 0x400410, cnv-id 0x400=
410
wfpm id 0x80000000
[    2.660717] iwlwifi 0000:03:00.0: PCI dev 2725/0024, rev=3D0x420,
rfid=3D0x10d000
[    2.662120] Loading firmware: iwlwifi-ty-a0-gf-a0-89.ucode
[    2.667789] iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version:
0.0.2.42
[    2.668164] iwlwifi 0000:03:00.0: loaded firmware version 89.202a2f7b.0
ty-a0-gf-a0-89.ucode op_mode iwlmvm
[    2.693021] Bluetooth: hci0: Device revision is 0
[    2.694469] Bluetooth: hci0: Secure boot is enabled
[    2.698894] Bluetooth: hci0: OTP lock is enabled
[    2.700339] Bluetooth: hci0: API lock is enabled
[    2.701262] Bluetooth: hci0: Debug lock is disabled
[    2.702069] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    2.702719] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[    2.703431] Bluetooth: hci0: No support for _PRR ACPI method
[    2.708740] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[    2.711227] Bluetooth: hci0: Boot Address: 0x100800
[    2.711230] Bluetooth: hci0: Firmware Version: 120-18.24
[    2.773104] iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz,
REV=3D0x420
[    2.783598] iwlwifi 0000:03:00.0: WRT: Invalid buffer destination
[    2.943521] iwlwifi 0000:03:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    2.943552] iwlwifi 0000:03:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    2.943578] iwlwifi 0000:03:00.0: WFPM_AUTH_KEY_0: 0x90
[    2.943602] iwlwifi 0000:03:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    2.943608] Loading firmware: iwlwifi-ty-a0-gf-a0.pnvm
[    2.944080] iwlwifi 0000:03:00.0: loaded PNVM version 35148b80
[    2.959773] iwlwifi 0000:03:00.0: Detected RF GF, rfid=3D0x10d000
[    3.029643] iwlwifi 0000:03:00.0: base HW address: 2c:33:58:e9:d5:1d
[    3.822131] Bluetooth: hci0: Waiting for firmware download to complete
[    3.822963] Bluetooth: hci0: Firmware loaded in 1085762 usecs
[    3.822999] Bluetooth: hci0: Waiting for device to boot
[    3.848969] Bluetooth: hci0: Device booted in 25377 usecs
[    3.848982] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    3.858349] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0041-0041.ddc
[    3.864001] Bluetooth: hci0: Applying Intel DDC parameters completed
[    3.872025] Bluetooth: hci0: Firmware timestamp 2024.18 buildtype 1 build
81528
[    3.872028] Bluetooth: hci0: Firmware SHA1: 0xa8bb3f39
[    3.882989] Bluetooth: hci0: Fseq status: Success (0x00)
[    3.883003] Bluetooth: hci0: Fseq executed: 00.00.02.41
[    3.883014] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[    6.943128] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.943131] Bluetooth: BNEP filters: protocol multicast
[    6.943133] Bluetooth: BNEP socket layer initialized
[    6.943661] Bluetooth: MGMT ver 1.22
[    6.946103] Bluetooth: ISO socket layer initialized
[    7.068883] iwlwifi 0000:03:00.0: WRT: Invalid buffer destination
[    7.224190] iwlwifi 0000:03:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    7.225614] iwlwifi 0000:03:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    7.226232] iwlwifi 0000:03:00.0: WFPM_AUTH_KEY_0: 0x90
[    7.226803] iwlwifi 0000:03:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    7.384675] iwlwifi 0000:03:00.0: WRT: Invalid buffer destination
[    7.539920] iwlwifi 0000:03:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    7.541272] iwlwifi 0000:03:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    7.541861] iwlwifi 0000:03:00.0: WFPM_AUTH_KEY_0: 0x90
[    7.542422] iwlwifi 0000:03:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   16.078066] Bluetooth: RFCOMM TTY layer initialized
[   16.078073] Bluetooth: RFCOMM socket layer initialized
[   16.078077] Bluetooth: RFCOMM ver 1.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
