Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA318477E48
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905233; cv=none; b=V7zz/G9P+nuuTKMpTUH7I54deHp+NXtYaU+LHP83mIAunKXl40IXENsT+kQ8MZZfyMb+YgAbHK2aJFeHQKiJtomxmJ9G0naUApvDx1fb29s2yk5bsdiEf7Wma0InHJX3sUPDZIPTB9pptk7EsRN4+L+rAkTBreab9L2lq4K4SbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905233; c=relaxed/simple;
	bh=VZuzlN/KGkPwKlYzsuMU8ghd8mTOZW2jrw1PmzVqOpY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mToiS/LNTLRnv8Y+JwhRmv9ude/F5FO2UWj31J5OOPyNdIUxicXzFhdiyqExITkzaMBgHU+OyZ/EnhnEqSuXOe0xCZf0dfYl1FBKl5npYMYgwWBH3EEPHMpgqHu6gpbfLtCUBn/RbkFpKZahFm53o3hRlSZzZpC5REusZ7bOAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHodQUqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHodQUqq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31E76C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782905233;
	bh=VZuzlN/KGkPwKlYzsuMU8ghd8mTOZW2jrw1PmzVqOpY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sHodQUqqOSU5pvnYpP5zarKWvVOsRxfUs3VteBA15y8gi0scag5j9aalufUp0Z3Td
	 svej/fCk1F/5VL0EDdgHVtWcDDkpc5pmjpAK63gslHdQqoSN2wsTuo/0t6DT3NUOeg
	 q2mFXVZA3/eVPiIoQPQfQJap5C344RgZQYYfycgeSrH7/9jb5lM/jNAEXkPT7t45w0
	 DhuXkv562f65t2ZKtAMscXn87x+EMYlvDCa2tzGZhXYMUiAqyzJiPDV1hjEIwgaieL
	 SysLawv9ktl4/OO6zlJPo5Yb64lK/JysYdWrUMvRXIwLgrqXUdyjutdRdfCcPieTV+
	 WqRlHxnTNfqiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1DFF6C41613; Wed,  1 Jul 2026 11:27:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 11:27:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robhogan@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220564-62941-S7WVgaYjAX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

Rob Hogan (robhogan@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |robhogan@gmail.com

--- Comment #9 from Rob Hogan (robhogan@gmail.com) ---
I also have this issue. Error appears every few minutes and the bluetooth
speaker disconnects and reconnects.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
