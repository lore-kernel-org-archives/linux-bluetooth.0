Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44379DF
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440208; cv=none; b=YUo3aZN3qBLq4iXNPRJPgxW4z6ll7x6r/2By4UwbZzjvf2QHalZB4M8x0qFDo/NJCxflTuuUffca2DhKCqiwbCkyaP48xY4J9JxfRv/dzzqW8W8GBxujoX0l0uCUX/O/3dDOEtrffbBjZXx3CzFqZDQOH1RJ90TkOq4cQX9GYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440208; c=relaxed/simple;
	bh=WqPKbPteZXZWVwiowJHa0GhY+Eq6bjUeSLDKM7MoUgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODvO+/pKp8xZ6s0uk3C9g81l7kLKMzgMG1MH6AsQsMxHlQCxL0WDt9iusjhBIRJUHVGpZ9GlYt5YMcVB/5ZVHWPiTolVOCefCPI8ji9/Bn2w4Vma+4bCgvzjHSHt1KV2aP+vVmTrhj6/a8baTA/UaU1ykCjVWmVQ0Q45/R7lSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WReumDVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WReumDVY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E56FC32782
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721440207;
	bh=WqPKbPteZXZWVwiowJHa0GhY+Eq6bjUeSLDKM7MoUgo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WReumDVY98qYjpWQAunrNsPdejCq71R7fyVrihH2rbrjeMqW6dIFsVbJk2M/gnAIh
	 IKZTuxoIa8xFH1uQfcfVAoU8WLjK3KZfDyRofApdz0U8+ogohNbNgpYa0bhsZs6jS/
	 wsiRyHcHl72WcwvzYCHxXMwwKZroik0cv9Cz7iAagaknxMX3fU8BFqIPFP0bZCqZt2
	 9wrcINs/C4nKr5hzfkOYVpTKIqe6gpjnLIzHhG2fK4sFiXOrO5kqyh11MNDj4FOSHx
	 ASIA19WQLq1FVg6HrCESDMEGNFg3zVLStsveGfW0yU0QJFMyhJITX29wLyYlzdii1d
	 H92kVI0KRVSnA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 93167C53B73; Sat, 20 Jul 2024 01:50:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sat, 20 Jul 2024 01:50:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-BaFL7lvM81@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #4 from ricardo (ricardo.andres.riquelmerios97@gmail.com) ---
command 'lsusb'=20

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 007: ID 0b05:1a51 ASUSTek Computer, Inc. ROG RYUO III
Bus 001 Device 006: ID 05e3:0608 Genesys Logic, Inc. Hub
Bus 001 Device 005: ID 33fa:0010  USB2.0-BT
Bus 001 Device 004: ID 045e:028e Microsoft Corp. Xbox360 Controller
Bus 001 Device 003: ID 062a:4101 MosArt Semiconductor Corp. Wireless
Keyboard/Mouse
Bus 001 Device 002: ID 2dc8:5201 8BitDo 8BitDo Retro Keyboard Receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
