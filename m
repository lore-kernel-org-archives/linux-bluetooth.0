Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB7125B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112569; cv=none; b=Pr7BSncfAlhuIz0PR+ud+gulA37Cwgu/ciomAN10uN1ZYnOoL96L/S7uUfy8rJh92pXYdGjkdFK7k98JMPHDrYrurVCxtXndBnhexGbcwI1MP5qYi5+Ny44a+oenfGe7DUXReVDqSzjP9sLscIMOeur1PEx3kY+CvU306yBh1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112569; c=relaxed/simple;
	bh=D14yrp2PaQkVnkBqFC4mgkWlAr/cPsE6TIBkjcH2cUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joi4Sj89b/uap1JOkItErlfRAON+ahT0bWw0FoJBlEECty00g2uR52sv6XDwsDafuzAXBRKzN2YgX15WUDHQ0VHIOZPxZ4yPtH08ZuV60q0/FUKBAj+W7FrUTK47aJV1VtBlBVPBbNxfPgx11CzX5Zy/HFj5Cn5abqKD2GynkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaFy0QWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaFy0QWC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86510C4CECD
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729112568;
	bh=D14yrp2PaQkVnkBqFC4mgkWlAr/cPsE6TIBkjcH2cUQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TaFy0QWCGrAX7gy8X76yEXBsuSN4ZBK0xzuM6Fhb+4CK3255dmDbZ1MnK3F9uYaMK
	 8Z8WnJBwKNw7xBxzdQU9FVqUNqPLivwI6FClJBjg7wukhW7VXcpt5a398JJq039w/r
	 5eJnZpiv9foqz0H+LxA1TilBfYjXM98UT2ePwjIpyK4aaPuRpTDBOHcZTlYuPzogN3
	 bYZE5ukeT0Lq/V+yYoXGl+xdKnTCt2kGk+NTscyR4Jyv+gAGeKaC7H/GcSSFY7z6ym
	 GjVhSDFjjp1KhSee2cBOgGk1CdIF2cGd6iM57H4LfBRXC1YZv76j8dkaVfSELuDkaP
	 jIxuwr1eQAxIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 79FA2C53BBF; Wed, 16 Oct 2024 21:02:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Wed, 16 Oct 2024 21:02:48 +0000
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
Message-ID: <bug-219387-62941-X4lvUgAUTE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
> I am not sure when it first broke

But you are certain it worked in the past?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
