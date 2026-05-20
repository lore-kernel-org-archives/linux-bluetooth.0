Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D1A6803
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263550; cv=none; b=VjvJbJRrQcriFffCvPBdIbAKclndweoeyvf+Gb6iFjjMPZHiuWYM2IlNsT6E57KM4Ok7LJOQoPJLaYWPc2VoA+/t6+sK+FBEdYLzGMpqwMbpV+UzHvNyHFVz8SZYdGaHxT9F3pVamusP2Bx6daEtfdws7TDOw+fMpTCkHY+VTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263550; c=relaxed/simple;
	bh=ZXAlaxY7Q8V9XJpcojnBUPmitTnYM8fpgWgJY4FtANc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1u8DkgHSyqwjewJ285oO4/HdpGsfOCKjyNW3LW6aEtSC3pflUHigOVncq3qWLkgpHhp8b+6VdtILrQppAFUwv3h8U6zUmg8N2tsYIhzKomO8Itr4HO/itO8DcPzyQtayc4OnV6kWlAITJN/2y4Gb0dAk62RYriCevX6eWPcUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVPz/IhC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVPz/IhC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D95FC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779263549;
	bh=ZXAlaxY7Q8V9XJpcojnBUPmitTnYM8fpgWgJY4FtANc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AVPz/IhCFIDknaBy5+MLyOZsLZTq/A/E942qasnhyDCfsAHQU9hiNR4wHrrZRgRF4
	 esIpq2ySeXI7ihH2XU6qhqsU3h2S/BlUpUFrK263REtDYtb7Oou4Jv1W6NpkT+DoUe
	 t955jzJk9m/suj5dN8InKymH5l/V5dgJGxoHUyPsWALHuqnpHTGZZwpNU49bxb6lAA
	 aOTQSFN4ecEH2uoAaDsh6Ofv786Mt2S6D7rSfuAjBJ+EL5Wozn5mNJAQySx8UbmjPp
	 I8QhFESmEjeS4azSIDzMIj9irVC/BFUvO8BslSJ5nvG2g2BDlzZDFKQVLALHJ36gIW
	 6NG6OU0LVLV+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 36EF6C53BC5; Wed, 20 May 2026 07:52:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Wed, 20 May 2026 07:52:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-bc9htlz9jw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |olle@vixit.nu

--- Comment #13 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221547 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
