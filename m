Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B03A901E
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952501; cv=none; b=Od/8rRFtRT+OVqKpCZBTvczQF1e1LcjqyhhEouyl6svqln0C71Tw/GvVIBQt+hmTz6t2v08ou3hDx/if+b4otKmreZNqFnAzx8KVHY1ftooKjpdOQzce0N/OkqSkzjpdevO8Hj9bVazAd5X5epOKkJepQTwfTIbWHGij3H6fPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952501; c=relaxed/simple;
	bh=8HqEu+H/hjEdiK+L63LsgvDIATaCEjw1vpvr3BsOUYY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbW0c5sfjXjO/rrf2d6hQQRocy4glecT5Y0x0PxI94y+Wa/p5GR+OU3zL5OddZHI6UZvs+avA8qX3u3JCCMjz8IXIRq8irwhD+dea6Aa33G1S5r8bseCSXM2RZ5+UpZlZFh6kXjAuoRILo/5UiqTMYRrxPXp6GsJXRKmoxPgEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4CnN/r+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4CnN/r+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FB53C19423
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 23:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768952501;
	bh=8HqEu+H/hjEdiK+L63LsgvDIATaCEjw1vpvr3BsOUYY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H4CnN/r+T3easa0z+cDB9wkGGlllgYWLhSELjWiDONtjEha4zxo5zLJdyQ33Iky2/
	 f71+hzSUT6kw7851GLvJf69OWq7Iz2QyNIb1L1Hnl7QoHiU9VIjigjcd+9t1NfhCWX
	 eCMTxPouzOWrCnOUJmjB9YcERupRaXb2D3NTl59rfoKeC3flRafoz8oT2n/YHQGYVr
	 0FbDgAfCu3ea2nyyChzDFR8CoAMWAMsz5AM3GN1nHOs1j3EnHuFbWQy1PmQkDtxnWc
	 Asr/8ea+yLTAkxPo1nBTlCoyiK7AjFqk6AnnFBXzBYbblPxL6LgrQOb7EMQeeZTDIf
	 T3bpo086jmUeA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 556A0C433E1; Tue, 20 Jan 2026 23:41:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220986] MediaTek MT7902 Bluetooth adapter (USB 13d3:3596) -
 missing kernel support for hardware variant 0x7902
Date: Tue, 20 Jan 2026 23:41:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aamolodc@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220986-62941-sbF7NKkm7o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220986-62941@https.bugzilla.kernel.org/>
References: <bug-220986-62941@https.bugzilla.kernel.org/>
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

--- Comment #4 from Alex (aamolodc@gmail.com) ---
UPDATE 2026-01-21: Root cause identified, kernel fix still needed

CORRECTION: This chip is MT7902, not MT7925.
Evidence:
- PCIe ID: 14c3:7902 ("MT7902 802.11ax PCIe Wireless Network Adapter")
- Hardware variant reports: 0x7902
- Firmware build: 20220107141051

KERNEL CHANGES REQUIRED:

1. drivers/bluetooth/btusb.c - Add USB ID:
   { USB_DEVICE(0x13d3, 0x3596), .driver_info =3D BTUSB_MEDIATEK |
BTUSB_WIDEBAND_SPEECH }

2. drivers/bluetooth/btmtk.c - Add hardware variant 0x7902 to switch statem=
ent:
   case 0x7902:
   (alongside existing 0x7922, 0x7925, 0x7961)

3. linux-firmware - Include MT7902 Bluetooth firmware
(BT_RAM_CODE_MT7902_1_1_hdr.bin)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
