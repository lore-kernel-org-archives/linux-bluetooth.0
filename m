Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB221112
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C//UbR6T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54208C433C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700737952;
	bh=gZCynIn8aoedwOOys4CAwjQYVIe1T4XJFXLSqzV7cqA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C//UbR6TDwEMXjo8axJcQpJ7Xe6zIbwRjZj+lmDAio0RbxhVHgDmIGr6QfoSZEhyA
	 edJZjotwwzyzcb1sIwOKPuKpXHVMEeyHK8PSDyv7R75sHr3y2Q9zt3KEPBmqTkk0x0
	 Htm7KFMEi5xa4qjPFaG1MSVG63hZDfLFDgNrDTMMrFZMkXwT+jyv/19WKBn2hk7Baf
	 qbDYUwoBjIdxj9fHQi+4fkHPk3LnM71G81P1uVVZ2r7fJrSEdRFaA6s16yYAs3496C
	 d4mMQEv9RScCEVVgDb1FWEOx3HatTzTzG5bqXfHBhvh4o/EZfyXH8QqGVmdo2ohSzj
	 er1szXS8wQ8xA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38FFBC53BD1; Thu, 23 Nov 2023 11:12:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Thu, 23 Nov 2023 11:12:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sy2239101@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218151-62941-vqP4CtbhTM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218151-62941@https.bugzilla.kernel.org/>
References: <bug-218151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218151

--- Comment #7 from Si-Jie Bai (sy2239101@buaa.edu.cn) ---
(In reply to Luiz Von Dentz from comment #6)
> (In reply to Si-Jie Bai from comment #5)
> > (In reply to Luiz Von Dentz from comment #3)
> > >
> >
> https://patchwork.kernel.org/project/bluetooth/patch/20231120151039.32306=
8-1-
> > > luiz.dentz@gmail.com/
> >=20
> > Thank you for your valuable input and feedback! I greatly appreciate yo=
ur
> > response.
> >=20
> > I have confirmed that the bug has been effectively resolved on the late=
st
> > mainline with this patch.
> >=20
> > I sincerely appreciate your valuable input and solution once again. It =
has
> > greatly assisted us in the bug fixing process!
>=20
> Do you mind replying with a Tested-by on the mailing list.

Hello Luiz Von Dentz,

I have tested the patch related to bug report 218151 in the Linux kernel
version v6.7-rc1.=20

My testing focused on reproducing the steps outlined in the bug report to
evaluate Bluetooth connectivity.

During my tests, I executed the steps to reproduce the bug, and I am please=
d to
report that the Bluetooth connection was successful, indicating that the is=
sue
has been resolved in this kernel version.

Based on these results, I can confirm that the patch effectively addresses =
the
issue in the specified environment.

Tested-by: Si-Jie Bai <sy2239101@buaa.edu.cn>

Best regards,
Si-Jie Bai

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
