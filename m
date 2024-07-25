Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B132C8C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947122; cv=none; b=YmG38UUY1wkDojsQp8pZgGYnoeQfe3dKIbhyL4Njgwt1rN4Yju8ODj3Xk7ngMiPMh/9vJMB8g+Rv3PmGvE0yxsxVacHOh6rIdf7XzKCGOD90O/QywLYWrH8CkjVo3/COvmlCSdeJ/uwJs+UbtC8YGFVy04acZQwgEP9n6XWwRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947122; c=relaxed/simple;
	bh=dbvEDWgwh1FwM5gTEGdbhpxrStCYehsKudVTGdI6v9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxOhQKCzFgqiI02jPY1DDKdskGf9G+2rhOZykc4CW7iSh/lRNvTWstKNeU+jYh/ZaY3lzFOzj6FGgE5K8IV2VyO5KnOrF42EkK9fFW9hU5OAupux2OsLKXunGNq5hZa0RLQlgtafzRDdInNd3fTKa1P6XfZLwnBT0h9pBLrtxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1lzt5gA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1lzt5gA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BD2DC116B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721947121;
	bh=dbvEDWgwh1FwM5gTEGdbhpxrStCYehsKudVTGdI6v9M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a1lzt5gAAswCSfhywGUmiJsceVlTWD6vmiiX1mx5Zb3GifkKr5DDBLJ1DBj2DeQEp
	 N35ojP74t9Is+tFthCbOi8WzbmGg/UMx3hM8G00UBx29Mj5bC7YLIV2725OPkWLPEa
	 CDGo9JMIAMdbcC+Gaq9S6fi5io755SjqEkB26+44zw/Hanfix8XiGhR2vptfSI40bQ
	 Kdxc4/+UreKDALw2t06SFQfsOoEp+R+Gt/JoxFt2FZQtFcUcQvBsnQ0dERWssva9nq
	 sfKRE5F6KzobkLcqK+GsRwJMe4hVZmbvnQYfTrBCE1Ybsw2HHWEDHbHH1LiZ3kTZ2P
	 CAU4RgIM+Ygtw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8DF6DC53B7F; Thu, 25 Jul 2024 22:38:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 22:38:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-RpaPZcFsS5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #17 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Looks like I found what it was, is is passive scanning triggering
DISCOVERY_FINDING state when in fact it shouldn't because passive scanning
doesn't generate events such as MGMT Device Found, it is just meant to
auto-connect devices already know/paired/bonded.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
