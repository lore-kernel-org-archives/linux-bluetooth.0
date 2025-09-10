Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD102C11CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541917; cv=none; b=CfZG/9HSLdRF3LXTqrTUoEsW702D5QqmysQQPhq4leyCsRG8KMzuTTwKRm4rSJuQbKJ4zGGvTbUNBqgJ6sgsumE1X0eDjwQR70Oe6bZrsq6dwaxieXEn0GZvs4CIXoEhZkwpG/ipcjrVk9zTNYCdrKqYv6mrZ5prOh3M6XX2k/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541917; c=relaxed/simple;
	bh=juvWc6Fz2ejLk2xVqWgb6Ieylu3p8Bar3NM/Jpq/Ado=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwZm64u2RVGyHmc8ZmOD3XLNKxxSsx+xxMn2JGwjR3R+tjHZIPhpZ6oSCbIga6K6o0qc4L3TJT8zScR6vjHSXvptP9mYqAbDYaSdiShN2ZOuwArhs7ZxmD47QyAxMlHi2/cJ3r7kvG8siO6DChWLbBzGjZUo72fYDFsZAi2XI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv4NLZ6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv4NLZ6y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CECCCC4CEF9
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757541914;
	bh=juvWc6Fz2ejLk2xVqWgb6Ieylu3p8Bar3NM/Jpq/Ado=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mv4NLZ6yBtLdKdjvH0PRmBcSF4kHPkM1pmNf/f9NY+IyRLIVY+VdYyegojko96zLb
	 M8AAs53mwzvtW1JyvUhmRMD3i1IL9PkpjhawAsA6i4kMy4Zv5Va9AVCC5up2In7I39
	 YXZqdEP8O8ncCtf9nml8RxQJ5YbJpNTdjFPHrnh0U/jr3ZSzsuZtlG6mUVUJFZH1a6
	 +lYFTvKr7UagNFIvBK6xXLrkhuoBrE5TY9/efuPwj+Im7IJjsubO77yNH6R8Enf1Y9
	 N9F458jAh0oZIsVKkquKD++zzBS6hieSq68oc8aB951K6MtB95WzWK4U0gP4LGBGix
	 ZNa4VZEHKPtKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C3D65C3279F; Wed, 10 Sep 2025 22:05:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date: Wed, 10 Sep 2025 22:05:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-EijKej2Hmf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--- Comment #12 from Jakub Jankiewicz (jcubic@onet.pl) ---
I think this is a real bug, I've just noticed with latest Kernel 6.16.5 (Fe=
dora
testing 6.16.5-200.fc42.x86_64), the music I play via Bluetooth speakers is
interrupted when this happens. And it happens a lot. So this is a bug in the
driver that needs to be fixed, not hidden.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
