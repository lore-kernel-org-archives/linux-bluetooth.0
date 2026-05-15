Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CA3932E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851553; cv=none; b=u0Iz0Zj34A4Ibr32Fag9OuZjAWiLVEsvizV9bKfbdZ3jhEab2fAyayY5zIIvs98Iqyp4RTOQgI8J7QXgj1uSfKVTMCgVfKbO1PEjKQp0Q4+l8BNyDz2YrAaGorswcZAYlfC3/8C0g4WdXohHLLdY9t01q3Fydl4r6YJqynDfyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851553; c=relaxed/simple;
	bh=ma+LD8J80wrcKYx66YOs0Bar/0n+UkPjWaooILOtFCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ls7xFWCbZRfI/q0nEvz+bVFpzlq6a43DOPK7DHEQvyJDoUpJreAZhHOlAj1iUUoNma9UZuYdx0S8yJsxCFPj82TBOLkIdtQBiZdN7aUoc24WSBh+Mj2Nv3wkDEr26WkLsreGgHnS8islRHjbG6cBYQ3t+SM51ji9edliElo5itU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf/Ztnw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf/Ztnw7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3021FC2BCF5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851553;
	bh=ma+LD8J80wrcKYx66YOs0Bar/0n+UkPjWaooILOtFCc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mf/Ztnw7QSOH5M9d55sFPX91fmJ/A1hwoIuWhrumFUs0BnlU9onQXH7irLq6lEbNk
	 RwlF6yswYxCszvxwuTHxeXAcsoREfdX3mEBHipMvTO52WWVsC7sViJVHomGaO3sYQC
	 P0zZy7JxQuheINTsrmj5EXfPJKJDhDtToi2pR9V9597n1W6GXlPZAxuKoasC0ite7D
	 FTv7Y1Cmblv1rNrkK96RlmRUu0GT+G8ikE5LnFQfKfNt9/RVp/DnT6JaEL+tFzKs8J
	 jWWQlD5oy7FaOM2krXLTikB2h09ItSPvTamnoPbzA8YbNmkAjZeg6VG6EdAQSMXMDd
	 0yG/DSGfmz0Ow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 255BBC53BBF; Fri, 15 May 2026 13:25:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 13:25:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-8uq71NJASs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |flavio.caetano@gmail.com

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221525 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
