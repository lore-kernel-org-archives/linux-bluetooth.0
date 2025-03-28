Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E861E1DFA
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160792; cv=none; b=CZdUqzAZgWynjDLBzdsULcqi2QKOYC/dvIb4+fXoTZyccX1aXtngpGYfG+kppPlQ2T7HF4Nsbu6HmLBlPVwxDVmlDCSFo6k3zQqVDIs1jyIsFTYvD9ALtoSL4AF719PoszNxUQqsbT+tmJftMh6Q+NqgvXB3D1hW1cmPmhLhuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160792; c=relaxed/simple;
	bh=jW02BpMJjz+7mNt8SPw6ulxkh8sbJd3voo5akh/VagQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFE9uvNRjJK3Y+4ymVbcBmLKJ0B3N6tGcNxgK3Cqu54UdCzuCYCbckwiVNsRsA2htYnhLpJI6KjUzATocL3PIUeBDxH0znlbYY8qs69mZM/hqcbs8r/8u9Y7euuOq//vVb96hiTAin9Kv+YnC6P0yE8FB/HJOcrW+BHVa7rs7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I28AkVPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I28AkVPl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 884DFC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743160791;
	bh=jW02BpMJjz+7mNt8SPw6ulxkh8sbJd3voo5akh/VagQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I28AkVPlZo5cdmEsaZlmrjrvyNahdRXaM2L+5NB6XGke6nhjGxh1OsTYNIjx2+/57
	 WoaZpP/DeFkYVehP3I6C3PBf6YwG4aP/V2hud8CTcAoxqnL1/lpV7sOeLzbrftOmrf
	 Nz6pCpIigdeL92vSlNFGX0SIwEsZ3q7AAbiR+HBUBY2glXMcGfgZ4SBG4J1PG25iR8
	 1n89+N5POZMPQVP8IGID+Q79SNjf0lWW7VBntWDsTgV5Clv3QSvpRDL9a7ViU/M5O6
	 iUZmfhzNjTH9wmrE9H1ChfyG/aksO/xafRkxPkBHrL3dcH6AgZCg1M8XWaGkHAGPGY
	 I6gsoLdROXclg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 72587C3279F; Fri, 28 Mar 2025 11:19:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219894] Bluetooth Qualcomm WCN785x - Input/output error
Date: Fri, 28 Mar 2025 11:19:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219894-62941-aAbQeSJ7iE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219894-62941@https.bugzilla.kernel.org/>
References: <bug-219894-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219894

--- Comment #2 from Gurenko Alex (agurenko@protonmail.com) ---
Interesting and unpleasant development, I've upgraded kernel from 6.14.0-rc=
.7
to 6.14.0 and again it stopped working, until I passed Bluetooth into the V=
M,
disconnected from VM and it immediately started working, so it's not a
permanent solution

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
