Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666933A8F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171014; cv=none; b=p4u9UGzKeCYeYfEOFfW0PrvmHE2HHhSNjvztEvctgW+HhImAUAJSwr/pwgfQfdH+CkYzJ+ccWwL/Uj8X7ngN+WgsvOqCSCDqJW1YqugAf/VFOB8TWIG14iJF2h6ezbO/P9jRFVpyj8/H5P49fJ0aCB4LElrKN7N5pFRkzXC6WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171014; c=relaxed/simple;
	bh=OdU2H5WXpvm+5Qt0sVK/v14WqZx+0V4s6rFvRz/AWgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZZFC0kciXwou++hr0UZwAhcLzh03Rs3us0VSyUFttMPnJHQsi5lsz37gim1SPk0vRwbswZks8nRWACDFWcSLDMatc62SqV+Z1cw2A9aBOKBrsUVwAdYlJHEHPh4VMCNHku+0hIJqgCd1WyecG6Q+CddIOskNH9L0Sz5p000t3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXCAMVav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXCAMVav"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F00FBC113CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713171014;
	bh=OdU2H5WXpvm+5Qt0sVK/v14WqZx+0V4s6rFvRz/AWgY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UXCAMVavRBM9eXtST+6aXz4AV2YwC/fWYLQ/8rHwCEh9ihgmROzPl80A8GTDfviSt
	 IHAXNjcwKDScHagdmhEuh2rBj1V4+lou++8AjjyXX9SqMu00qtYDWPhXAHR6sS1af2
	 8OO1Yt0Xy6TBZujefa1cayMjkMBuFy76jfD++UVpfKZcPEWEVduVT1+71XaWqqx+lb
	 s+ipL8z0Nh9NrbKfwi40V/lSqkrcoEyvICpHT6VGisPigZvLRZeXPQ2eBHZNfs2T7S
	 5u3MZ5IYE2YcoCDcDsNltUVk6mcX+4nvwvYOqksqE2B6NaTY5OGxS93cfXQZxG2zTD
	 VsX4m+tK6cX5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E28F4C433E2; Mon, 15 Apr 2024 08:50:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 08:50:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218726-62941-T6HksKAkhj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #1 from Warren Turkal (wt@penguintechs.org) ---
Created attachment 306152
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306152&action=3Dedit
6.9.0-rc4 + logging patch - kernel logs during bt disable/enable

I have applied the patchset at
https://patchwork.kernel.org/project/bluetooth/list/?series=3D844357 on top=
 of
6.9.0-rc4. Here's the kenrnel logs starting just before disabling bluetooth=
 via
the GNOME UI.

I pretty consistently got a very similar log to the above, so I only attach=
ed
the one copy.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
