Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F718035
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000571; cv=none; b=G2U/2dfilPI62vUmApsGdSUu25IEmEVTsLOk45LNkqWaHXvojMxXB8/lwvtEC8htNjo9tK1694e/oK7sGkt3gw5z/gjDn2J54ibl93g+9xGE1ZEBYs3zF8IeA6uhHdzF8LlzjaHqg0TSOUocmTJkPrdMF6Qy4dQAyU9SFdGbMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000571; c=relaxed/simple;
	bh=70R9UTPbenisiBD4Xx4Bv/8kZJhzpBokcUcTPqRcsyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fM7gL1xAY3DG42nsb9hoKF/lNcNZK+Whi3kUPU4wOrlIArEpRbVVra0i5nyQjlGnYNInc+bsyswhaocpqzCqf8F/JLuf81H/GccVyY1YAMIQsfmVz36kdBPWcCaTkDhyZIFkgPmixrsUc04LQiyhk7KoqGBJdjwXx+Bt7kbwN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXAx1j7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXAx1j7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B0B0C4CEC2
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000571;
	bh=70R9UTPbenisiBD4Xx4Bv/8kZJhzpBokcUcTPqRcsyw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rXAx1j7ZPo780I4zopv85FLw6bPzBn7p8tZKC8Q57Waw0GvcJT/mpvTocWkh6mGGG
	 6MHkS6RR/J4A0HrQuiHea3zR+BpHRTeNSln0RM/eiELi8PAby7pXlttwmzpktT0e43
	 5RSeFF4L7f3Cr9zKN9AsKVvEWf7zAb/FxrJW/Ymzt3N3zGYZEBESFS9PWt35tD2wck
	 npyk5cU23XgI3orsLZSaCGgTOuIIfM6O7aoIUHKuoYtIrgpyz89RTx4pRcu3OgleLM
	 NNQDwHEGeyPqbXaJe3d3GFQK8Z8ItJzswRDUqAJHN1f2EcHG79PAuk3Van/jIJiAE0
	 Jw9+iZaVSm1pA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 520DFC53BC3; Fri, 30 Aug 2024 06:49:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Fri, 30 Aug 2024 06:49:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219211-62941-nnHeYbDxrf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Full dmesg output? (attach it as a file)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
