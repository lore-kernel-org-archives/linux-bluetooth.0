Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE259376
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210624; cv=none; b=CuIuOsnmZOme33onDHG9aSrNKnz+ZtDlPWz7No2qFkZs1HSobw85XT6ADkfMxtGKCVe5f0zotKZT1SvX4qCQwmwE1F9En2Jok7K+QVXL1m3EpYVe5Zub8V2mVzuOJPssCLHnbJ3vmvfCWR5XAQnNlLb85J3YLVj1sKPObJcb7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210624; c=relaxed/simple;
	bh=N7XxsOogLiJtfD+9dVMVBNcBnVM7bISbLIRBEhZAm1I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIvdsoA9XLvb7WggG6a4jefirundtbb8y5Bc7uHb4wCML9cPFT1/WbLl+QopmhZom5Vo4norROiax/z0V60ebfVsuMObEW6tsl9lNvps4Sy2qt+uyQiR4N5++gyiBNYrmJODN/zy6nAI0OF5XTFgy7rY1YK3yaQoUuFdtZuPCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLcom58F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLcom58F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CDB5C4CEED
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746210624;
	bh=N7XxsOogLiJtfD+9dVMVBNcBnVM7bISbLIRBEhZAm1I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dLcom58FTPMKNU3i27yW+nCkYnTzDNGfWEnLmHpLa+xQj06WmeC9RHUhPJNccqtGp
	 eBFH7xarT/I3xYHBGknd3skK6B/6RIYV73O6EdziKZjOk2IV/Qodz7OCmT4jojR6+0
	 q+J9Lql62kUmFQlZdEadi3eJxCEZoEuhiVHcZw4GVsU6cAU5tF6OmS60SaAuhm6Qaw
	 Vn9H13ifEsfj83OVK1860Q4yqgrsYVyPdLyhwF3WZsiHLa9TtpV5PO+K1euLdUghD5
	 X4X5+t/87WrhpyzjGc3rLGI5KF5Oy99nuJhOy9DG5l2wB4lCsZzH7GD1FuAqVfsoBs
	 /YoV2Xh8ZhfgA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44F3DC433E1; Fri,  2 May 2025 18:30:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Fri, 02 May 2025 18:30:24 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220061-62941-8E9p7EtT8f@https.bugzilla.kernel.org/>
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

--- Comment #11 from Sandro Forster (sandroid@posteo.net) ---
I've tested v2 of the fix with a DualShock 4 v1 and v2 (the firmware is
probably the same, but just to be sure). Both had the same behavior. Connec=
ting
failed on the first attempt, but every following connection succeeded. When
bluetooth is restarted, the first connection fails again. Here is the outpu=
t of
btmon for a unsuccessful and successful connection attempt. I've attached to
logs above.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
