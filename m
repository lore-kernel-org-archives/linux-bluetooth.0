Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02F299A81
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766418183; cv=none; b=NXPVgcNiJxvnPi+Gjxr43DRL7fUJ7FtPUAqoTuLBX3Mx9vMw2Dm1nlfvXj8tc0wIc+CMhD12EOMi5Rak05Ipm/6ZJmgu4fOzQ9r4bQKfH0JR/nY7aGd5xzchJWtD3iBoKVHSd58aGtRlXMGdggZSr+fVgP0FTgtNpDL0NPkTg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766418183; c=relaxed/simple;
	bh=M7anJrgQThXDib4Dca+5bx1ndmTmV1pb/5XE7IaVsS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfPB/69MyNmnazx8PvAo04e7W1EIQ03Gtw/MdYDfl3QbIZBTVsySMZydvjOvEeJXLn21NVvTkY1zJANEWmBkiSixDEInewJSUaqjwqBfE6qgCb2AWkJxwYoGrj9c4SGX7C8h0jOpGnNejy1PYPRhBvUnsyKCRoS4/E5D754bKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr8sGoMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr8sGoMo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F5EDC116C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766418182;
	bh=M7anJrgQThXDib4Dca+5bx1ndmTmV1pb/5XE7IaVsS4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fr8sGoMoRqMfDNU/WQUn9i+reMfRN6JSgB0C+hBJIWeagzgx/JyBGV0DtyO4EzTd5
	 /SmCSTBsKQiqogt3zSWXuY6NtJq+nwSmUKFgB3bgKMAQVerzWQ5FaNA1pcYsdWoxdY
	 71XYTK+zC77DtfJuvwRU+Z4D2uIdo2UIn3YKvtIzNGUMGmc3/JAR09wPmAblBDzg4h
	 8scKoUaEmn7DQa9JCLyVJzLAiTys/qd3LlDf8Nhd/w+bjHXhb53ffBChRAmh7Zx6QP
	 AWjFwXL2wmxgeUCnQ4vQaD7PEkQZVm6uCQb8nwqqNv0Q8FbHK0ANCSfkRzhlcpbO0F
	 nSzrNf8TaaK6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78E0BC433E1; Mon, 22 Dec 2025 15:43:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Mon, 22 Dec 2025 15:43:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216936-62941-CXXAK282JA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #34 from cheako+kernel_org@mikemestnik.net ---
Created attachment 309061
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309061&action=3Dedit
This patch adds a new parameter, as suggested by myself

Sorry for this I know it's etiquette, but I didn't run a linter.  So this c=
ould
be missing a semicolon or something.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
