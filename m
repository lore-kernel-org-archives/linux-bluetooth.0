Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFF107A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg4gRr4I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64447C433C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703561762;
	bh=eHvqKv4VSg98zPgdmig4YOeMCNOgYOx0CHh185THWKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dg4gRr4Ir0CZu6j0SYMUyv3xmCYTYrV8WMvW9zoKvAJ3893zdBiIQXY3sv/QONLqP
	 6Nw78ZPDxE8Dz7xHkeDSGtp26PFsv7BBLsat+weeMvj3rJeFDgy+yWusIcHiolsrvV
	 W7M4oyI8hZonJH+key8Am6RzA7fhPpj4qFZ2+SaxkQd0MSxpzj0BMxfAr0tQ9lUgwv
	 jpt5AuMF+1UkkmC7CokUGvJRgunCGXZt8u1sEv/IT1RCdnX780IE65QfiXfl6HPAko
	 fdMDK1pdPu2S/+gD7//4VbmAmeCPCORMHOp0FSDXdvvJmpI8eFlZpuW3ktOWoV4cXP
	 8Obwc8Bk4R0JA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 540D8C4332E; Tue, 26 Dec 2023 03:36:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218323] KASAN: null-ptr-deref in rfcomm_check_security in
 Kernel 6.7-rc2
Date: Tue, 26 Dec 2023 03:36:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: 20373622@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218323-62941-pgtJunLWM8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218323-62941@https.bugzilla.kernel.org/>
References: <bug-218323-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218323

--- Comment #2 from Yuxuan Hu (20373622@buaa.edu.cn) ---
Created attachment 305658
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305658&action=3Dedit
Place of Encryption Key Size Response in our testcase

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
