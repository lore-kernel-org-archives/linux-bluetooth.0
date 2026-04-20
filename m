Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A273845A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686180; cv=none; b=TyxYj+6xgaRjwRJI6a9fDOc51ufTt+iRE4zx9lTSd9ct95It5n68aSIO8vzIUtxZCSyCNsCWwOAW4lourEnXCGYwPGHZo/YkUNKRti0zuWelbwrBjmc9omwWtZliJca4oINDmBBSS+njqV5eLyqHF3xQJWu/MOUZdYg1Ze4H78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686180; c=relaxed/simple;
	bh=UlI/ppDP6kZTb/1s/zHocOUcZ3Ev8+o7yXQ6vzzqJw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kcn9+RrPcUYdIRyB7PLenK0bVmLFHYbq24xD8ySFrc3qmxfeSdGHLmoW+MvKerdKVC3ZKOpZ1O3adPK9rn7lfbAZOa+4tU9jsWGyw9NOJTchvW+YGfHyzMRTWRY+je0EzY0XihOUqJP4QFoFcPNM9j6cNAdZVTs1EXy7gvW5mBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phwFD7rU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phwFD7rU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5B4DC2BCB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776686179;
	bh=UlI/ppDP6kZTb/1s/zHocOUcZ3Ev8+o7yXQ6vzzqJw0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=phwFD7rUARaog6a5R4mJyGw0rlIM2615jX1ZGInYybKU4MsJhXGHnr0R5tOsBUJ5V
	 NA6pKU0adciP9lHGaXt82exceT1OYAl8rf7F40A2XLAzyMCrtkHBEo7u5ZXdHv48Lt
	 g9Cqn6Juf32RgaTwBvUYtFXuCvpqGDGDkcatJ+nySOERK0MpNI+UypSGwp5pgsmx2H
	 ELXxoA3e+wfRc+PwkS8HQHcP3pN4rNCY6TvTUHIEvO0Q9p0HR0olZXPKSdfPMQJjxC
	 arlIoOSY9K/gF1jMPccfd/lcQzUwb2LS1fH+/xOoIj2Lv7vQIiyglR7GdkseCuLqWs
	 u+FVGJ7yIu7fw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 98D1EC4160E; Mon, 20 Apr 2026 11:56:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Mon, 20 Apr 2026 11:56:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-Iy0E8EvYOY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

--- Comment #11 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
Reported this by mail to the linux firmware maintainers:
https://lore.kernel.org/all/f689f4a3-e5fa-40d3-9038-8ddc12eec241@leemhuis.i=
nfo/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
