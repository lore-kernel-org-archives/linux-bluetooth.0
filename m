Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F62144DC
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995104; cv=none; b=Xd8OPfXW0rRYbKC7MziSS5G4FdxRQ1dAfCrRX/jjpKSUrc0afryAfSWbGS/5h73HHyOjI6qcoLoOeRqzr10LWZ2yiqVmfINgCKBd+m2f/z9zhIw4hvvLD3GG49YOG/YEbNVhrF6SG0UDmJKAbzeOX7a9Zwn5Ti80vpm+/SeThsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995104; c=relaxed/simple;
	bh=sDCaM9AMGKfXEoBXcyVVi99W3G/YGVSYQjtrIHVNYnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVXt7ITcH69hBNxjfPz2hfcxLGfxoN1A0dGajEoG7/nK/svKK+3igUfrDsPMAmO9EpyxyW8WaoabKJ2zssZd0k5ICVR+IEwC/vz3bsyzdpyFjBpAKmZPD8rblWfSMCjl0HA6p1XWaQBjYkoHolzSCDHB1IFfrCyL8hRiPtZrXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx7E1d45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx7E1d45"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B31C4CECD
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730995104;
	bh=sDCaM9AMGKfXEoBXcyVVi99W3G/YGVSYQjtrIHVNYnM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nx7E1d45VtGBofa38vDwdKW9zxBQEYpEYW9TqPwTezoVh27POCVNiO9c5oVVjPket
	 KcUIpsoBE3ZfwbDsjeX9bX3r5YPced4fK4HbwhwyLUzeyCbzjDfvAndIA57DJSpIrh
	 u9CrD/VaqCPPBJZ/vpO6fzjA2136YLffa6hdd5wg6zf+pAAlEsRVlrzQnvVi4YdB0d
	 P9fOahFAExO7qf8GyfCtYXgwoIZKsBhCnmd5cUN0FdOarolBGJm+fLjXOmJx7mZHPP
	 Gzb0KYM36eiZ7ZB5pD6I98lVgRV+L8mNU9fS5g2KLflGnDWIqdU1bXdZ5kVP2hY2uf
	 lH3UZyNbNxyzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64299C53BC2; Thu,  7 Nov 2024 15:58:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219481] Buffer overflow vulnerability in btusb_write()
Date: Thu, 07 Nov 2024 15:58:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219481-62941-QyomCE1XFW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219481-62941@https.bugzilla.kernel.org/>
References: <bug-219481-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219481

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
There doesn't seem to be any function called btusb (git grep btusb_write), =
so
what are you talking about?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
