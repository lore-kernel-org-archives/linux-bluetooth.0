Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBC145355
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Jul 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751783994; cv=none; b=gJtKSbqMG8AFOEREvO6Hs7pacHFMnpSE6A1lxToi5CyzyOgq7RmuqdNjQ6ul7m1yp2O6TZsr8cLQWfKulSCdktXjk78VBq6EDcC/wLlkSXLE2g4PRTZyTi43A4jsqTFmsNTGmRM0T42Lz1jOGbAnPUJaoCq8z9sbvbUBxNg+trg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751783994; c=relaxed/simple;
	bh=aqKWB+U/xA+QwYBhOSU4hUBeFzyukh59cC5xeV9vGBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VR2Bp+Qw38VA3losDZQAJMu8PfZgcbbfGZuqLCkub9afHx0WGwRMQJkGGiDBtnRUHd4foNT5z7kUFWf/isyagqVsm7RPSymZwE96dKv4wDULFV6GGrW/zq62ud7ObscqiUTQaHjcsWkivP71i7HIAKqSQqkxnIoNXsLzr7+A7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxQ99P+r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxQ99P+r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E73FC4CEED
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Jul 2025 06:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751783994;
	bh=aqKWB+U/xA+QwYBhOSU4hUBeFzyukh59cC5xeV9vGBI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QxQ99P+r+24Hr2rszVfhK2DBBrMnnDIApO4S8UW+JHt4cROm461tMxzkChb3Synr9
	 vCWeiMhE7FXQVjlPQWlVEtQ7Usu+zJzY94RvCecPWL/Pst6lyfgMXUjKXcEz0QchCv
	 6CbVzSFt0QZBHGYaX959asZHlWP1PghH2565YqFIb4JGT+S6eOt0he5s0/1Ah0cUKL
	 gqnwU1UVDZ8fvac1qbTQoyyys1d0WlXEA3trPw6XsqUDVb64EonYizcrFptoiAiT4T
	 X8BFDVreuYng5Y1GzUcEci7AEgX/YQ1KiwOEwFu+eRwJ0VooH7w8MkVK1xvAcrK/9z
	 d/vAfaLPdgUDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3EF65C3279F; Sun,  6 Jul 2025 06:39:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Sun, 06 Jul 2025 06:39:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220306-62941-ge1Cub7MsI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220306-62941@https.bugzilla.kernel.org/>
References: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
Kiran,

If not you, who else could I CC to have this bug report looked at?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
