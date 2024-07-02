Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423C14BF97
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908657; cv=none; b=sxr2Pn8h8xFvGmMoHXCBlTdNW0kQ51SVzRp0V5RvfI6NPCt2YjH6xvX/+GQfPws/4d4y3SLO13TMUEj1cEqV/MGRHJfzT/ZsEo0UgiqS+wmBGnipXlOxsRQhpzXd8zTgjNcCkLV598/aj5SHoRGf7ldyfMhqScJnq063Y3TP12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908657; c=relaxed/simple;
	bh=bhfv95ZhkRAg+nc13M/M+0o63nhRE2KGGFticP/wZik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HMt/yMwFntPcD2m+jVeQYactwS89NZ8C+AIDN8Tbm4DMDQn05IDX7SSL94P2wdKMjUUFg+Hup82pqihuEVy8qXK+y0BeDUY1hGIdbclUfrdq1U7kSjDrj87+TCJkd51RNL1J5HogjXkbNsS8iCYNFluQHBf887lRO3Tqa3WEulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmt0xjMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmt0xjMn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44BAEC116B1
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719908657;
	bh=bhfv95ZhkRAg+nc13M/M+0o63nhRE2KGGFticP/wZik=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zmt0xjMnn3vNPdNOb0eq6DObjaP/mCuqD8UKINVDMU5d2jasHrUTYNoTh8aa2VYeJ
	 B1MDkTEkB9XPgMuJc7vvc5PVVRzvwZosw+/9hbDX/sfmDRWAHBz9J27/Wym+P1rzZr
	 FbYL5Q8EvvRPmGvgjylLVti9c9LmTvw01WJ1m/XVpPkmhiI8IxHY6p4QVJmGUt+lsq
	 xMOdlNkJlWs8gBb7CJAGbBmdfI8oevlROmAw9kMfeKini4Zh2lTriOn2wTpLbRf4+S
	 zMPJBxH97peKf0B8jRxIoeamXfIVpdpiTSEbxTxQaO1u9cg7APuNNwg17y1/JVIfVd
	 XnxUS/PsWr/LA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 26DB4C53B73; Tue,  2 Jul 2024 08:24:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219001] mt7921e: hibernate/resume not working | Bluetooth:
 hci0: Failed to get fw version (-108)
Date: Tue, 02 Jul 2024 08:24:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: g.wenzel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219001-62941-izRAI4aeYY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219001-62941@https.bugzilla.kernel.org/>
References: <bug-219001-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219001

--- Comment #2 from Georg (g.wenzel@gmail.com) ---
It is a new mini pc. I only tested with Arch Linux kernel 6.9.7.arch1-1 but=
 the
bluetooth device was not supported. Then I tested 6.10.0-rc5-x86_64 and
6.10.0-rc6-x86_64 kernel. Both have the same hibernate/resume problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
