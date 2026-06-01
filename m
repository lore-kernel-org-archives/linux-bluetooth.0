Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3C349B0A
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340612; cv=none; b=FQMZ9tikIOjyMKAtmKH9ZsyXRrf1PgazNzZJ5JzYdDh/SHXaaemVZS3eLgybBW4irAqFJx6TcifIWWyJWPsLdBAxTMAZ+z4f6QsdBtUtnfMTCyVbWc+UqdVZC4nIMGfB0iqQ8AZU1WrgtnRIhj8NfqNjvpdaUm8nlmjw6/UOqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340612; c=relaxed/simple;
	bh=bxVB+Gjqj6PoNxD11qzLpgPofueS0E+Hd+MJ/6E6OAM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePjYfUSXfdaceubAsMsYENa/395Q4fa8JUJ383psOy+8GK123GwEXK5akD5agbPsIihqoRlzQFP8BolFmsD/s4TijBDeizAitfy0itbrDlZG3gUZkDcpphFHGfey8wH1KbwwEKv7+X0JJ9vJlKqLan2VktCcHLoP1eGQyhDxrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsjRmQX/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsjRmQX/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B85C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780340612;
	bh=bxVB+Gjqj6PoNxD11qzLpgPofueS0E+Hd+MJ/6E6OAM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NsjRmQX/raUaNgSwNCU4EOHCdjxPpmK6F0sP7IT38JPumiI1ftZ3zqd//IpSQExCg
	 I3COLTO5ZjeFGZSGf+uginkUgu8wEu3qgAL+pSNTXeLM6uN0mAyeK4lgqPq7Ns1yPQ
	 g82OtPCOfp8vhN0GN300FfiFG20000jIaEt8DzKPzpQrPM1jLaZAnDlYWx6qnrULDV
	 rlvuTE4PQJ8fGROWEcWuh1HaHgbttEjSfjMSImhiReLE7M11/cMSPtwTogCuRllLTY
	 Wpr9mkrFRh9mvaTZPgKc3l5G/A0PDKagtaeIjeebHzQHXRCAmKBJVq1WM/JpQpqPEV
	 GGya0R2VeFSNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 517FFC53BBF; Mon,  1 Jun 2026 19:03:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221552] btmtk: MT7921 (USB 0e8d:e020 / PCI 14c3:7920) Bluetooth
 broken since 7.0.7 - fix for 0489:e0e2 does not cover this PID
Date: Mon, 01 Jun 2026 19:03:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: gpbagayatkar@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221552-62941-Eu1Y388iBP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221552-62941@https.bugzilla.kernel.org/>
References: <bug-221552-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221552

--- Comment #3 from Gunjan Bagayatkar (gpbagayatkar@gmail.com) ---
While I cannot speak for OP,

what I can confirm is,

I was facing similar issue as OP on similar machine, and after upgrading to
7.0.10 it is fixed.

Bluetooth works (discovering devices, pairing, listening to music, all work)

My specs:

model: Lenovo LOQ 15AHP10
wifi chip: MediaTek MT7921
OS: openSUSE Tumbleweed
previous known-good kernel: unknown (newly bought machine)
kernel with failing bluetooth: 7.0.9
kernel with working bluetooth: 7.0.10
I received new kernel via distribution rolling upgrade

lspci -nnk :
  03:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7920]
        DeviceName: Realtek
        Subsystem: Lenovo Device [17aa:e020]
        Kernel driver in use: mt7921e
(same as OP)

lsusb :
Bus 001 Device 004: ID 0e8d:e020 MediaTek Inc. Wireless_Device
(same as OP)

modinfo btmtk
  filename:=20=20=20=20=20=20
/usr/lib/modules/7.0.10-2-default/kernel/drivers/bluetooth/btmtk.ko.zst
  firmware:       mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin
  firmware:       mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
  firmware:       mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
  firmware:       mediatek/mt7668pr2h.bin
  firmware:       mediatek/mt7663pr2h.bin
  firmware:       mediatek/mt7622pr2h.bin
  (2 new lines than OP. this is working state)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
