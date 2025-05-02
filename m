Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52591C5D59
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210590; cv=none; b=Ae2Bv8RDa26sHPgOhVuGcmSZ/qGKPYgbU18yIy311lrX5NBG+13qN0pJJ51jFa7VVxBYAJRhI6HPneIQu8tv+8SXmQOh5TP4URlitOVPcVSfq6Oc1/lmG4ye6E4ozgRukqzD+ntxyrZI6ILkgXQAAyCBc4LoVyBq62ULYm+oibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210590; c=relaxed/simple;
	bh=CKS/T/Sva4/xTKYzvEQthEGxvfJ6I/d6WZGf5/ZiyVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gm7sviRyD+riqIhD30zTB3XG8nM5MT73Kl4L2VSAy9cCFNF7TT4+7prb/FuhsD5JlZyL7aGC3SjP8MgQL2wkJr4af9GcaULMn2JV/Za4i2Q45Y5yIITvk+YSoKpzyp7tg+ThwojoifrL60eHRNYGumy4lJ8QJfhWafYwbvIV+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3of7N0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3of7N0b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B74DC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746210590;
	bh=CKS/T/Sva4/xTKYzvEQthEGxvfJ6I/d6WZGf5/ZiyVs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D3of7N0bWvXtl7y8MPITnnFeYzgQVph5oDMrw/IVgNfcL/l7bDutW9/ZzRdKwZ49B
	 LWnKZTwDGQFBwzWag7ptcounlLYHJFrv1BM+tHdnh8T5SyqrYR9UvqJt7Fjbfmw12M
	 4kzDnXDb2cBEbm0mhsb3NBZ8qQ8A1UcTOrfZ8qSaaZLJ7bTBViFVVfK9xZifbHmumD
	 uqUZzh0IbTF2VENqDnuDqmzudjbEsKlNQDC64lbCb8K8HsR6Iyi3t/zSHtJccvmHBr
	 +105AZ/7U+a6MBrDeiATEGLPXV8mQGSt2E2aJwTMbsuhGSibcuF44KoW+Wv8UNOe1S
	 iXp/f1LO+EewA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83F1BC53BBF; Fri,  2 May 2025 18:29:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Fri, 02 May 2025 18:29:50 +0000
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
Message-ID: <bug-220061-62941-46WtZSOFlR@https.bugzilla.kernel.org/>
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

--- Comment #10 from Sandro Forster (sandroid@posteo.net) ---
Created attachment 308074
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308074&action=3Dedit
btmon of a successfull connection attempt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
