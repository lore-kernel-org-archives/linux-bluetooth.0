Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312501171C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143982; cv=none; b=TDshT0MO1RwPwQFAfrrm67u2sP/EUUp0h9Q8wkvl8hOC2k4XJROsV8MhOChrJfNIuiZXGRKb2NfZuNejbh/kGlbS9rpJzbL0/bqf6GTuukI/7te2oF+80sPAc9AZb3elqQJ1K2O1s4MhjJgZ2uzUa2ymicGqJK73d5NJDl4Kbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143982; c=relaxed/simple;
	bh=L7uJ65DnqM4pqlwyew9cAxkM13ZMHgmSfBf+NHss1w4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByLpFQy+UQP0mF64lvSOdJ9yDIZ5KQe6fbTMuWvYlDiVACooPL1UhEXJchxMamdLHVodF4PyBQs6jjBkzp2awXfL2+iMB2n3qs0vd4MHXe2fVmX7j8t4SqdP9bnAAL5hQUaH4nKqEsfTeluKqQ0EQ9kfrJSveakAuwf82dU/OJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjtWC1kg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjtWC1kg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A522DC4AF0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143981;
	bh=L7uJ65DnqM4pqlwyew9cAxkM13ZMHgmSfBf+NHss1w4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NjtWC1kgF3UXWdKUO9HqvSBY9CpUcCtiJXXGM/T4AyZaeBt6e99AuFX+Mz3vMiHvD
	 LmW3ZYmO6DoBxDFTb6LVTB/9Ug30f3Jti5QFP3J8ow3JsYXy97tQdgX/NIUgBnF4T3
	 0c9wxZ+1ZN0vkR45TWzTkpVzxWL7hrJk7lBrmJ3dVDwRNwvTWjNm4zt46qrkVi6P+t
	 azqU3Nxb+u740nDRXNWpny2UL+r9xYdRMMO2IVPMuBZ8S5JzPFzUb7ry8S77cTqRs5
	 AJ2II5Rph1dStSTJXsahNZAEHMuT65CzyLSiFfJP2K6Tfy13Y9JztUt8DxRoNDlIoD
	 ZIuJE5r4cuVDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9E407C53BA7; Tue, 20 Aug 2024 08:53:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219182] MT7925 new USBID 13d3:3608
Date: Tue, 20 Aug 2024 08:53:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219182-62941-FIbdgEDfPV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219182-62941@https.bugzilla.kernel.org/>
References: <bug-219182-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219182

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Dear Pavel, thank you for the diff. It=E2=80=99d be great if you sent a pro=
perly
git-formatted patch to the mailing list.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
