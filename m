Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184086250
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262522; cv=none; b=oi2tnujBrmkheKn/EpGQm6O3rX4cK1lWhoWbzgYnjdX9+zYBBkE29/WdLiqqf2hPizqv4ow6+IQvsiptykEAzirFInHBpvDrnmTfXhJVgmlbGtJRyaquvxs9iYD98HZgxHh5LWDVDxgUI0W3yTUy5AoiIqi5OcIsAyKSjpZBtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262522; c=relaxed/simple;
	bh=S+GIkuNlqW77TydXY8AKXLuWOMm/xMykLyb7+3fAPJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTUtN/fxED3at6mmZ6V8M9kMcVYqp55AxsViT0oA8yRMjoXPdSzdYduxgsoxlv9ykAeRICFNswIyfJ9x8ZUOczDiWFLr32M/alCO+sGy47y+fNyMNd4Wl+sdvzEHsNi0mqIZ9/dQ2YdKvLBIxMq5aitcQn7+WGZ9rAAt0+BD6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqmDYBd5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqmDYBd5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAFBAC2BD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262521;
	bh=S+GIkuNlqW77TydXY8AKXLuWOMm/xMykLyb7+3fAPJY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fqmDYBd5ZzcUhSFxgCZhLS9BAxi6oltTj9qLftsa+utiIfIVGo2eFlRkfp8BTGWb5
	 0Jjj3jEo9PNejMzTYOfpUV5jPUbGCM6PIOxTqXUxurh4ZF0qcx7DWHL0MmQs+kO4OB
	 3g95bY2Cnxu+nYPOieSqrZ+kI3F1MSOeEb1QQYUrV24oDyLH5PYCRjwhmBLq80XSkX
	 xG8QLN4pmnRe7qs9mr1VxiWfMlwGvCKCKAjzazn3O6h+vNNgTdl5WbPTF1WYFAyyC7
	 UQD+MCd87CL6VYDR2Xh5lq1Lirmcjv3JwQQ+qBBatRW8IzenN5UPG9LUHq59mg9YDD
	 QxO3NI6nmIoGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B995FC433E2; Tue, 16 Apr 2024 10:15:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 10:15:21 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-t6a1F8iv5w@https.bugzilla.kernel.org/>
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

--- Comment #22 from Wren Turkal (wt@penguintechs.org) ---
BTW, replicate my only change with "git revert 56d074d26c5828773" on top of
bluetooth-next or on top of linus' kernel. They both start allowing
disabling/re-enabling after a cold boot.

Warm boots still do not work on either kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
