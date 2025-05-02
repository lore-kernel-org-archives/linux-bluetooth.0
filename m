Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70015350B
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210562; cv=none; b=lEHzd+D5Nl1oJlo88JaPXFMo3K67l5fq/8eB4YygMUFodzBgEaBtYotnAWw0NP5Fa5LfJUg20gegide8bnFrPctjlqO8iqrhV4Zv73/vzpX+yrTu6oxQsom+BMJ/cAb7HQKoDt8YHh5sx5wdDua7xiJzpLsKy0dEA1Ee4UguuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210562; c=relaxed/simple;
	bh=RFEtBmzXrhLfs4+2PU2PvPPmBhZzotKaiwxIyjXmcBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MSSl8awOe1bGvxSRt1d76zLsBnmeXvsxgmHMTmu3Zq78RFqIrVOAHcgNlesBcaPVrZtTrKrMk6rINkt1UbUWy9NF9dfCbj6Wnicp6FvIyTiestJxctXBgmO9DNgVfmXQyt7GRZ0fsfVPFH3M7bblYoFoeRH8w/vIJ1umfAtXgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqCwhhfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqCwhhfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73177C4CEED
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746210561;
	bh=RFEtBmzXrhLfs4+2PU2PvPPmBhZzotKaiwxIyjXmcBc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qqCwhhfZIHSfaf7CoI3iF1V0Rf3VtGhXdZmcDKPhn2z1RPXnInVnkKhClgJ7YhXfb
	 NhiK5vThYdysNwOVciK7bELzn44MGzKKSzSMrMNtOXFSHCXPRGWR2QXeqa7P+ltCbK
	 OHgZc7rkMm7Y0WymK/M+oXggfWlnO75Z5D/IZRxVHHGS7gjVQ0ZXJPpEAbzmwUn4wH
	 KG1031hEjQtoGXQd03HIIs5cbL80E+Sgj7nt8vk4SMeh6ms7a+g5IYIR49i3putGn8
	 hC1R/ZPiZZ0T+WqyOYR8h/WHkxxBJzaxUW4qc5o8sZLLSmyxCRo3Wr3SF4l1VKsOfk
	 rxez3aHBAMfhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 66BCEC53BBF; Fri,  2 May 2025 18:29:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Fri, 02 May 2025 18:29:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: sandroid@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220061-62941-TOmdyRVTvD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--- Comment #9 from Sandro Forster (sandroid@posteo.net) ---
Created attachment 308073
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308073&action=3Dedit
btmon of a failed connection attempt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
