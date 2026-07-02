Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C5449EB0
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981688; cv=none; b=QM5oxWCaUk/v9KSyGJyeIrm9/RWPSHFdU4fBNFY7+RYKv9nxvbec2s28kePYWNFAhTG1ZzDa0nv750TFYbLJTZvMVXK4CDbm2YDb++P0CjybwBP/NgJZqyLLHeIED0iJGSwHkeqn/cXNn+LG9ebW8sw5SW7DtfOFDHIveCbpppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981688; c=relaxed/simple;
	bh=hOSB7Hf6x+qzres1xuiYhfWKZSdkEp3hruOtqqrIsNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meuXEWaW3uSJWmGUDZ0BRJZB7tmW7dO7REYwddsvinpoMIU0QxftzK52zNopTM1dyDbQ1g/6sy5yPDtGDlraKDBGfgdsz7U+CNASibLwi+A0bx+vcATJPle/jIc7QLfFOPjnU8zCR8OleSdBwcotyQIlBGwHaKc8R+oOFFsfS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCBmaoXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCBmaoXs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55E33C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782981688;
	bh=hOSB7Hf6x+qzres1xuiYhfWKZSdkEp3hruOtqqrIsNM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TCBmaoXsG4rHiWGwytKABBgqVDuS2IWUn9RzKIVlA6cw2J8B3VL+bO+C6uHYBK/ut
	 CKgcU46AFavHO2GEHchJRyxcSimNL8byr5Ji0fRG+iMig9gaU9tRF7EqmDt8jHHI7m
	 OBPfFI85rtl70oxjDg0zsgDY3JXcmhxRGrBHq6B5bRx+vNTEaPcrGXSSs4u6SO5Ph+
	 IWhswYvB+pTlEeFbn1TeWkunkn3m4z1EcQq3MDw9N4zbBw2Cm7cNF9nsLSW5VNAP52
	 9M0iijvILEYZXRJu8fFcpGgkZzSETYkeIReyTyuIhybgmRAajicI4Nnp6dosz6Yfe1
	 XTWdl7zrGcyhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 343D5C4160E; Thu,  2 Jul 2026 08:41:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 08:41:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@mattwhitlock.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-pMlnDSljQI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #4 from Matt Whitlock (kernel@mattwhitlock.name) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #3)
> (b) run a git bisection

# bad: [924b4a879cbb75aef37c160b955b92f6894b11a4] Linux 6.6.142
# good: [eac8889a3a1c81d7113cc4656b9420e84c379cf5] Linux 6.6.140
git bisect start '--no-checkout' 'refs/tags/v6.6.142' 'refs/tags/v6.6.140'
# good: [1ff46c9915c1cbf454db58a8cb87f7cac818e6a6] ksmbd: scope conn->bindi=
ng
slowpath to bound sessions only
git bisect good 1ff46c9915c1cbf454db58a8cb87f7cac818e6a6
# good: [9426265e157dd77ec237c795901ed4dea6d69b5c] mptcp: pm: ADD_ADDR rtx:
always decrease sk refcount
git bisect good 9426265e157dd77ec237c795901ed4dea6d69b5c
# good: [f85c81e93dbd6915970bd5f3bffcf62633c4c54c] hwmon: (pmbus/adm1266)
reject implausible blackbox record_count
git bisect good f85c81e93dbd6915970bd5f3bffcf62633c4c54c
# good: [acdc12b71c9aa4be5dcd2c8062753c6d2033e235] net: tls: prevent
chain-after-chain in plain text SG
git bisect good acdc12b71c9aa4be5dcd2c8062753c6d2033e235
# good: [60ef1675b652e912f3eb064767af4432393291fd] pds_core: fix debugfs_lo=
okup
dentry leak and error handling
git bisect good 60ef1675b652e912f3eb064767af4432393291fd
# bad: [c9ea01768903ae47f210cd457af1dead6de7a9c3] bpf, skmsg: fix verdict
sk_data_ready racing with ktls rx
git bisect bad c9ea01768903ae47f210cd457af1dead6de7a9c3
# good: [b748250d778e575ef1a0e09939bd1366ee9b6bbf] Bluetooth: btmtk: add the
function to get the fw name
git bisect good b748250d778e575ef1a0e09939bd1366ee9b6bbf
# bad: [f0457842215438786e2e205ad06a4fbb8ab63cd0] Bluetooth: btmtk: move
btusb_mtk_hci_wmt_sync to btmtk.c
git bisect bad f0457842215438786e2e205ad06a4fbb8ab63cd0
# good: [73377cf3056ad72b10df90f54ce6b9822057bc66] Bluetooth: btmtk: rename
btmediatek_data
git bisect good 73377cf3056ad72b10df90f54ce6b9822057bc66
# first 'bad' commit: [f0457842215438786e2e205ad06a4fbb8ab63cd0] Bluetooth:
btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c

f0457842215438786e2e205ad06a4fbb8ab63cd0 is the first 'bad' commit
commit f0457842215438786e2e205ad06a4fbb8ab63cd0
Author: Chris Lu <chris.lu@mediatek.com>
Date:   Thu Jul 4 14:01:13 2024 +0800

    Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c

    [ Upstream commit d019930b0049fc2648a6b279893d8ad330596e81 ]

    Move btusb_mtk_hci_wmt_sync from btusb.c to btmtk.c which holds
    vendor specific stuff and would make btusb.c clean.

    Add usb.h header to btmtksdio.c/btmtkuart.c for usb related element
    defined in btmtk.h

    Signed-off-by: Sean Wang <sean.wang@mediatek.com>
    Signed-off-by: Chris Lu <chris.lu@mediatek.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Stable-dep-of: dd1dda6b8d6e ("Bluetooth: btmtk: fix urb->setup_packet l=
eak
in error paths")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 drivers/bluetooth/btmtk.c     | 265 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h     |  31 +++++
 drivers/bluetooth/btmtksdio.c |   1 +
 drivers/bluetooth/btmtkuart.c |   1 +
 drivers/bluetooth/btusb.c     | 290 +-------------------------------------=
----
 5 files changed, 305 insertions(+), 283 deletions(-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
