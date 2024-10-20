Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE02904
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729390493; cv=none; b=VKqwqNZycPvkbj/tZr2pf6QVYFqvv3ZVFSxXX/7GT6SS0wWI/0r8knoFQtp6aHhAZA7QRyrRHR+OiFO/AIMp/gOjMVxVkV8Jj93JG/Tblxz1IZ2aiE8OsECDS+aCKLC++E/81CPQCcc+2ATJJAKQjrx+feaNU7yH7ycEnHtXjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729390493; c=relaxed/simple;
	bh=BlSqh7E324S/zf5b7TcRt+jBZVSG7+deUkHF0eKgwik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYpnTgLxEf4ZY5fCb+DAqJ3tXpDCYQq0pchu45bA2lYghgVyI8M0vY8GHbVXu2tu+qDf3oa1ltxSbo0LoH8RpcEK4yTe7RQUkuBGeethuRri6pBp4BC6LOlkCQrvljgV2PWPltMhIV3xQQrL1etcIxKVVzHW/m1B7IF9GAOerx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvOu9CiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvOu9CiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D436BC4CED0
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729390492;
	bh=BlSqh7E324S/zf5b7TcRt+jBZVSG7+deUkHF0eKgwik=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QvOu9CiQGrAcPCFaVsBb/osgBCN+m8DHZGZEB6SJrg0Px7arjKom6RMXdguypDW2C
	 paCEbsSzorYiLG1gKR0sDA5C7bgB6+qCryqqSyczVBIhEnuJUrPIEIuRgLlkljlXpt
	 3IZdQ91MvPe0jRRZUByweRJnBIDvrlsHWLxRS1r0jewhBkbqScc09Ze3zmpvdyD4UH
	 Pp8mI+RwA1TaXrOy/ytfqQ+MaoCncKTiTGAowIUhsVTVPXirLBmEwQBJwEn5GnBWxz
	 LNz0bNEhFUyhEKhANLYPSI/vpJ4Udbakchfw3wLd7YiRgum2VaUuLJ3Mm2pCnIgZGh
	 l4gdaz+fspMAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C4A53C53BCB; Sun, 20 Oct 2024 02:14:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Sun, 20 Oct 2024 02:14:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matoro_bugzilla_kernel@matoro.tk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219385-62941-APaOgSSk8w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

matoro (matoro_bugzilla_kernel@matoro.tk) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matoro_bugzilla_kernel@mato
                   |                            |ro.tk

--- Comment #6 from matoro (matoro_bugzilla_kernel@matoro.tk) ---
Confirming that this patch applied to 6.11.4 also fixes bluetooth on my Int=
el
AX210.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
