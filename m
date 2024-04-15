Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF95155A24
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212923; cv=none; b=HfaP92z3uavwyHw8o/wGJ0H1ONzBm5r1B5weJTJXXpbwCS1TFPoeR+79Jtx35j1DVz60Xc0kFjLbOY2IVsDRXODQAJB/5gRmlQExCVab4rhHR2oxBOCxLw3IXutavhQLbsfoKmF5jVwXcSbKEtbuk33mvLPNkvDacYSRDZcYbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212923; c=relaxed/simple;
	bh=9ocx91g0cw/+JjaVAkqw4Kub9IKLeiRT4BiXAd/L/6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GioeMWWUDLVBUz8QaPazlwAsaB009QKbFFxoqwezVSD18ysbAgBmudAPYr4nOWFDeub3gwcdZCA+iJRwVFumepwRteFpbv8OsDbIZl0XsfApoIVBVveYRHp5LeDwF08v6BMKxXuSIUGVJ6Xq8FoO85cFjCOVh1Dx7Ybl496NLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwiGtp2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwiGtp2+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9096EC113CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 20:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713212922;
	bh=9ocx91g0cw/+JjaVAkqw4Kub9IKLeiRT4BiXAd/L/6M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UwiGtp2+EbjnfszybGJZcIrkMqswyuPlJh9nzSyx9egli204/aOGzOsjCXH0+lIka
	 KyOLPhb5EPky9O6gkORmKvfovfiAcbuLfgIc371kLLZj7jh+2NvfZH0E65l9HnL3mZ
	 USn+9f2U1JpEYlNLz41DiSIgpegW840XSJ0CInZN+12id93rCmzVfuf/Zs74w4x4cO
	 MMk/r3dXWJPHoH+v7YQyeoZw/wQZZdDC62L+8Ed0BX8OTLJ9JtJdnIIh19W0Ev6Alk
	 qSFQt1Aqpsho6l2AYMOMYLloBU/Xf5UURHZvtlIQVdNyHK3Aw3L8tOZKAWJnAvDbDA
	 vWmEVVbS8s62A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F221C433DE; Mon, 15 Apr 2024 20:28:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 20:28:42 +0000
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
Message-ID: <bug-218726-62941-oHatMs9jEs@https.bugzilla.kernel.org/>
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

--- Comment #10 from Wren Turkal (wt@penguintechs.org) ---
So, I tried just reverting the commit (56d074d26c58) you mentioned on the
mailing list. That seems to have worked. I am building with that revert.
However, you debug messages patch conflicts, so I do not have the extra log=
ging
now. It's just mainline + the revert of the commit.

Is this what you were asking me to try? If so, please confirm. If not, what=
 did
you actually want me to try?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
