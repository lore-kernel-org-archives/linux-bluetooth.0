Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23206346774
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812866; cv=none; b=S5et4jaca2xjD9lpjoWJSkKmiG4EW1/zggAf+qklPqUMjJDb6iERsX1Rg2pv/nLlHR7hi6Jf0XAOP7Tjo4nc3L9mxJRse3ArLd127gITM5CosehOs9TRvreReL0DepvDzx8oR+U82++TwzeVgPdVWWDmm6tmRQJnffQiAfWMDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812866; c=relaxed/simple;
	bh=blHJx9YQ9hzZntm0GAseQWxXIfkFtlsJENnG16vNlZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eeDjyFmp5j1WNNTjGYiU4gQUjTfTOVlxhX3InfXgYEsgwU9E6Vz2U6jQIWW1NDFr3ZOGX0538uYEjBSAwx5+ZOn8G/WhznIhBo+APe2r7uwEiD76/x+ZiumvQCmq8Vd7E4BQAH1ZuKD9y+3kgRK5E8WuLvbHiPOZJEEEsOIYJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maqlwzqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maqlwzqc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4645C19421
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775812865;
	bh=blHJx9YQ9hzZntm0GAseQWxXIfkFtlsJENnG16vNlZc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=maqlwzqcrsXzzsa3tnpIW5rjS+c+AW67h5wO/ELLlTk+CYcVE2cuMXqfSO0DVylGB
	 r/NkQdIGokUOm6Ikl33L015Rs8rf0HgJuD2dSkCY48dT4/iKBGFXKMFKqdut9z3+5I
	 5B7qlj9F5Z598Qamll+eY0XhodkGSq9Sw+Iu9D+c3BC8hTy7eAvSMs9tJkXKiru2Gz
	 vVUg4l0zc68uvIB/xKnmsZP98FnAEs4zGkJLGda7Ni+CoUkgd0PT3SbstttU3qZGOv
	 uo6go2rQDvXlcw0uK/0tREnrFhOAfaPpcV0AHP4W8CKGWeEh5ucNX6v/YXpyTaJZk3
	 9+yRej8MxgPyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A8499C53BBF; Fri, 10 Apr 2026 09:21:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Fri, 10 Apr 2026 09:21:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pallaswept@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-4ZrIIO7G7Z@https.bugzilla.kernel.org/>
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

--- Comment #4 from pallaswept@proton.me ---
Sorry Paul I'm not very experienced with filing kernel bugs but I'll keep i=
t in
mind for next time.

Yes I have confirmed that it was that file, if I roll back to the previous
version the issues are resolved.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
