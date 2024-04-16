Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9E2582
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231462; cv=none; b=tsGoPNJQoKifDKnTnfpXx9WK/ThrQ//0DbsrelfUcdoDYh9Ts415R+sbPEExDSmSWOjbzK0vVTXs+sKkvvCG58sFOk61f6QVT0CFGNMY8LApQlZPfs8wzEQuaZzW2Ft5lIulHSOas17l1461cddS6klhYpEayRWBCIhLrxUEbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231462; c=relaxed/simple;
	bh=TLWGlVmRz1Z8nZCv3XHzkVYtZPfOE3l3FWzTEUc2EIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cr8rjscrwBvbGPAnUp4grfnnKwLvJyLilR/wiU7A/SZSOQdclAbl4rq+gnt54otWnk8NotYzZGnxgOsEYgyl5xc4/i2jMF4X/ejMcyOqDzFWe2XOwh+Y9TT2QV03IK1dp2xNAM/5os92XSavjp6yXRIgGvnz3tQafZr8kO4Jx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8nDuzvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8nDuzvV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 163DAC113CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 01:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713231462;
	bh=TLWGlVmRz1Z8nZCv3XHzkVYtZPfOE3l3FWzTEUc2EIs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B8nDuzvVVu205ST9ZwO25wL4kBpKSlUYwxiVNQCxHVhPY3/3N4HkBE4JOvvWbyZXv
	 G5it3NpOqa0L2RKdOSphuvQwPT2/YIjEsmqFFMksKXiYgTziKSWw2UDCyhtxUQtLu9
	 gOQQ2bxksQ8IUCcsofE4v/bV7UdYq6jCvLC+rg9q/CECejB3tUpXWzqAk6nEoJ/URX
	 +9N3bAcGwRLCrrSmCPctGeAjEG4TrrcqNfBCVjHRJQ4LZMg2dmX36Oqw25wjbkK9xY
	 wf9K1Oi8ldnHqhwVvkVS890ZW5u0t1RyS0dWUkwZX2FOi/ddHKnGVMyxaqUs3Pkh+c
	 m7L/NINQf+EtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07B0EC433DE; Tue, 16 Apr 2024 01:37:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 01:37:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-CGYR9HNRNQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #11 from Wren Turkal (wt@penguintechs.org) ---
Okay, after reverting 56d074d26c58, disable/enable bluetooth appears to work
after a cold boot. I haven't tested a warm boot yet.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
