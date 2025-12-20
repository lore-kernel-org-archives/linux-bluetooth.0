Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508381C69D
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766245346; cv=none; b=Dd955hWCnt/uqlRYxDTxmu2Yn7/7L3fl85HnbX4pZRbPEaEI0FyMbsIGdQ7YrhkdZPMkoq9Mu3+MUzPlsBxvNUHgdMY3i/eRe7WhOfv01MRxiln5OJMJDe8brCY4BerlWxT6Ixx8Ds5oXV8+MEvO4Ln3CoHknF9Gkq7UOrFdY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766245346; c=relaxed/simple;
	bh=Ihu1iLIL1hVykRRR9hfk+MQOIpwAyh+vTUg1/kzrNUU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HANRYDCvvl+udkIR3xpQkCrPGq1V41LhcZ8EOwTdy+PKNMZ1YQjnMIneOB5gBZ5DyARG1+JgIB0C0PvNte2DP+PypJ2h0863EER8hYwuXrVyuCb2Amq1ZA0C0xPMC6TxmHiaCqd+9C+yph9NlWqNJWp5kzCFV5Jao7l6wctqI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyUuRShB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyUuRShB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23BE8C4CEF5
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766245346;
	bh=Ihu1iLIL1hVykRRR9hfk+MQOIpwAyh+vTUg1/kzrNUU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IyUuRShB6vUMABFIR+XTAkBviRRWU91/GHqbWmdHLB9R39I2hJoEZk4D3+Mru3zJc
	 eH+qJEG0k6HJXtKk/xf+7nrAdJnTz8pKv8IZWLL9tmP9/E1wtyUkjM/a7O1/nx4tLf
	 wRbC4tvx2TaJNI4rQTgKWWiN9yq0Jyfyn7+1DN+1gL5nTeAqU0TPKAbjcvNfEASMob
	 +R+VRFyGL39eukdqmkZxnf4GXgp36xdsuAkol1i0mtBydZVpU+FHvCw/XWupcJihCH
	 z4YWy998E4xbdP4E6r/JOM2GBNy5yFPFWy3SKmPOj6EGBijWMFFrgK47oXCEzLXVi8
	 x6NtUTK7PfaIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1BE26C433E1; Sat, 20 Dec 2025 15:42:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Sat, 20 Dec 2025 15:42:25 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-YOsOrWz8AL@https.bugzilla.kernel.org/>
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

--- Comment #30 from cheako+kernel_org@mikemestnik.net ---
Moved: https://marc.info/?l=3Dlinux-bluetooth&m=3D176624588529966&w=3D2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
