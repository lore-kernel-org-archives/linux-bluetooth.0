Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA962809
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155145; cv=none; b=duS2+BqmHgRRDvNAgH2D3flqZjhqhyk/9HCudTdtFXnftn6M0UXE4ouIcz8MFI4oZirp1us2MuW6VggYS2PxCnDNoZMVxOxf15jAxhuTAK4YNDgF9y5lQcgrbMDpLZIkCSVTpqPVdPobwI9v/sPkR8/kQ3zsLXz/e7yv9FT6VOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155145; c=relaxed/simple;
	bh=1ufAmrzqxLQjRqPwC50H08abW5/SzxTpkiHhapg4C/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AG8mXd+4NqAYlfxzb59WGp89asSiIdplZTcLs3/HLuwMf6zqG2GlY+cQGOnpt9r3zN9z/YaA8bu48AipxVa+0A+V5ZFBuJcu8ojdPsqBXaKqJ/Po4GAAJbeOMdwepeWNkcDTf5m05dHOPWxhm8pl4ISl2gz5fZ5qDVzpwgNL7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOH6F20Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOH6F20Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D72CC2BCC4
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780155145;
	bh=1ufAmrzqxLQjRqPwC50H08abW5/SzxTpkiHhapg4C/8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gOH6F20QHLwJl3sZKydhc9ElS8J9WSG7k6AbTLaCxfbWKvjuY4lDV4mHU3FMBKgbV
	 jlEYegeQ/uowX9AqB4do99aREdUx23VxrRyFiwASJXm3K7ATyxNnPWEUsoJkWfAImp
	 7vf86weRSIM1aPvBvUeswYICKacXQvrgecfWm/Ecb2+Y6vWlQsgrXAFeNjxjFYRUcL
	 c2gWlVQYZGjUo7oWmDtlOGdhQo8FQlogkcEof0speOS8g760qlEFSEsycEDvOzXLLu
	 M8bj+rEaQyve4PlnGu5AZq8poCmh0mt/gsJch6DXL7XK/QPYhcRTu8nw142S0uTb88
	 3bw99dRLnAd0w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E61A9C3279F; Sat, 30 May 2026 15:32:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 15:32:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-221598-62941-Y4aG6ocpoU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

Alexander Paderin (apocarteres@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |Intel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
