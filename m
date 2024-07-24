Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703315689A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818462; cv=none; b=i7Ex8UbgTxzgGJm70VH3tl/EcRlhpxHq9DN0fBXMAaMlC3gKL3bl8KY4xDla9I5VyDYn0wQclOx/lNMMf/tBpgF0UNv8U04+nUVoYMJXGVzMTQr3PFtuqgq71FeUHGe/DpnUtuXDWHXLS4vqpYUmzHngjD+3quzb0hn7pmK6IFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818462; c=relaxed/simple;
	bh=oOY21LYjciSHRKhQ/vciTjCJv6KVmbBJc+g9qfFzfWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CilULdPpPL2DXeI91jbnuP1DQ6/KLJs9z2OMfRMrEczjhKWvHLiWJxQs1TkeiLT4fCAgR/Z/84NB02jxPiTb8kgbBNaWcuLh9bpYFZpHavg0uAyKmypy250Tyq7j5/3vKerEhvkKFqbq/YzehBFpPNiL0Q1yekT8KZpZ9Z6nyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKH7ob5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKH7ob5w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F1A5C4AF0C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721818462;
	bh=oOY21LYjciSHRKhQ/vciTjCJv6KVmbBJc+g9qfFzfWc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aKH7ob5wyMu+X1CLWIhzehNFf/f7Q0iFo4OMtLS+F4zY73qOKxj2L9kD6plgj31/d
	 TzDClblJrQovkU96G01jAxMdOvCApEwrEjSER0/ndrw2jH4VJOlygfAFCASZ8IvCFo
	 7jaP1sBjrJxOJ30pQloDUhUjDgr1N4Xz2i1Rrn1a0mqU59IqEvwLTRnpYtvjbArAeF
	 fJHWfMomyU4RdHFqv95kO4ZNaIGeY+2/tXc5F/F8IhLpBGBVcFYkKtQeTTNU8KaxEy
	 ABZleSbFBf5pXq1PSXEcSU2PEmnL5UNw5yPna27CGLqCHvckRDgVZAmU52fuADj8FO
	 dHFfb97M4FPsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 593A6C53B50; Wed, 24 Jul 2024 10:54:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Wed, 24 Jul 2024 10:54:22 +0000
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
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-219088-62941-5UfyJq6Mdx@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.10
         Regression|No                          |Yes

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Please perform regression testing:

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
