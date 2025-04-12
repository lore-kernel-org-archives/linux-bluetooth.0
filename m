Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F541DE4EC
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Apr 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744452925; cv=none; b=JvfNfmUS5pnjuUKuW+DrLlJXhyDrybhcTgNN+sYcZQ20VdstCHikA0lEQpFqr38UCdtzWVusB5NrZQ1Zga3qpzXE4wMfThUDPesyqIIFjdEzpnI7zJ62bvb6Q4iyAjTNHgY004gopUVHQmVnDxsFn7KS67nwGEyYUhQAEqwWp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744452925; c=relaxed/simple;
	bh=tPTfjhjsRV6S09LOFqa0K9lGLvvyR67TROac/Qn+LHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKPVB5xNkAao+CUliSyhEwv0yPbQJSNG0KbWPmZzSCk9BowCW0446XfOpIPYUm9i2E0VvcrAwr+4DWYHYVcs3/o/uKpuBjNYsPOyu5yBVEmUhosSLJ+8nGp+AgsUcABIepo2+Yxf5LAikxRy40tKdZNCskVSdaFV6f0a5rw1Z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW4GocOV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW4GocOV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC95BC4CEED
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Apr 2025 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744452924;
	bh=tPTfjhjsRV6S09LOFqa0K9lGLvvyR67TROac/Qn+LHQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cW4GocOVYwQ8siLW16PVwJJ799ONQBq0wkdtrvsX3+JKSLeVPAJk+HBOPML+/MbbB
	 PIPh4F78VbqLfDQwZc+eENdd29viWBWq1OMEEuw8qm/AA9K9XvY6shIZy8ImtflnYO
	 tp4zVOiKvfx8HnPJiDjNGw1NgaE0LjnXjcLjkid5xNM4dbngaBF4Y9ocYNIlup85hH
	 oggvIs6+MU35867mw5Ki8SDpeg9Ce2eSuSHWL3Kodbek3fA206C1A7ZQoP73gBXUbh
	 xtaBqmqUl5lafDWxcbin1zt/PvXdFuAYVXt6XqYkPq64ddqH7Ge8iDJrnxhwJ03OEc
	 faRrh/NJDQH6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9D6A1C41614; Sat, 12 Apr 2025 10:15:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] 0bda:b00a Realtek Bluetooth 4.2 adapter disappears
 after suspend
Date: Sat, 12 Apr 2025 10:15:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-217256-62941-039OYydfJo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Bluetooth disappears after  |0bda:b00a Realtek Bluetooth
                   |suspend                     |4.2 adapter disappears
                   |                            |after suspend

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
