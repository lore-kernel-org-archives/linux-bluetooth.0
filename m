Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFF130A44
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670411; cv=none; b=JE3w/uvAEhQ/r1iWDiQ7rs8v/LvqY54gt8CwMH1Alpsz4nyPt0RSYMlnn0BKbApJmomrRIdAyp8w8W+MVTabqWqQw3d7rZenPCLOQz/kkDRoJ+ugNwJBRcCn5iVf8znZ4ybI067jGBrkRlTGDUyxxBjzm+mLNXs9cllEKwnBbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670411; c=relaxed/simple;
	bh=FbjwSxDO8sgorNqvOrrUCePdXVSxnx32kvBFPUEJbDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4NxccvKrF+YZqoX2y5CdFixJ5E+LHizHTN+wREdvsU5lD74mmrjoqmMIh+1FfPoI8pNmU/VS/of13ru/A8m/QEdJUggzrwwrE0w30ZiY61PrJ6F8lKTeH+gJLqx7YDczLS/jv2wpUUagjeXMFO8InLwa0SjzTHCdiQu4wnbPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stjeH831; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stjeH831"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AB2AC433A6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712670411;
	bh=FbjwSxDO8sgorNqvOrrUCePdXVSxnx32kvBFPUEJbDM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=stjeH831Bl6toPAJwEUq5B+JBnc1BqQc4Th2MY96qiXe+x9nqrLn2eJfRwSRS5SRk
	 Q0Pw1hBIIYYtMDQE1ZNmfRH49wnGR+/XGkaNcuZv7neFvF5HXSw1imXoYg6yt7lpaT
	 lB5aahFlrknSRisjpkGJZEdsAfuMIngdeFt1F00C/l8uzl140GCXjdUQVJ05RQZOfh
	 rx8vBZBiKBq9A2gi0auNcoF1T/4OQgCs5esBOq1T7wQLSM5ImwoQjDKhnYaOHbj3fk
	 WLXxXI0ETlFg0M6MzXC9Ys4kFnqsPMJbD7ELA9+COQEnuw7/0DQJmNV0ANfVoQ1ttr
	 IU1JdtIaKbRmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 01D18C53BDA; Tue,  9 Apr 2024 13:46:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 13:46:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-ibzHs5gaR3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #21 from Nickolas Gupton (nickolas@gupton.xyz) ---
Sorry, a typo in my last comment, firmware 20240312 is what I meant.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
