Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3618785C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463649; cv=none; b=M8TU54Z6x3uX91otofzwelNyXWqBkrCz+bQAc0gGtsE/9bL1XPDgkKZuRlR8WsJTXH4ohpyV3JOMZ2EYUvdTl6dN9m8AULAK9OuqxSAPrebex7BX8ZzXiq/FLSOpinVvnBIKPwdxGV7ZOlm+tvH28nDltcUxhnCAR4g9Cacg58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463649; c=relaxed/simple;
	bh=b57/ZueSdeHqfyRzIeiqcPTSNWs28qYN4/5U9Q0rssU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCosstCHNkRyuYdXY+tZ+R/K8gRvHPgUWKEGZABZqqLWnugP8ELgzC/aVuEInH1nlClJXOovWHjFCn7+FKNxQmgHqgoK+NE3XvUcjSUS1dCmUF2cmFhsZ33o0go7+ZDizqzhKg4wiIZPIJJUWTIG0op2l1f9+A5iYVdfVKRxJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPxpfQL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPxpfQL8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44823C4CECE
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728463649;
	bh=b57/ZueSdeHqfyRzIeiqcPTSNWs28qYN4/5U9Q0rssU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qPxpfQL84yIH/3M7/mpxrKJ77x1MdOyOjAvm3OvZZ5A4qLvazQmrt2RoJeoJZSJRZ
	 9Qn9o4GdCmWzW79mr4gL5DPiaiCvi412sCevNrm4s+y6NxFu4DB0uf/Z+HwX2/eG0Q
	 CgDushumCPzT4ij9yZWVOvwPEOKh2LQ5X4swAXMLTZc3j8DIDXsWX/Ut4HTlbihR7P
	 24fiPgRTyokIHJ55i5mDhtHK4EbU6sMgNJ9h+PNkAnbkc1wN0Bqj0aRyKdPIZaNc9h
	 omm49PNqFD3H8aNcCF9cJdKJ0GSrqkk05gtrqaj+oTLwtDo0LAsR4nMa4cmttmJVMk
	 EWh5KJ2XUPjKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37BBAC53BBF; Wed,  9 Oct 2024 08:47:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 09 Oct 2024 08:47:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219365-62941-SceBOU2Q3E@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for your report, and great that you can build the Linux kernel
yourself.

> Maybe is one or all commits has caused the regression on my BT dongle

It=E2=80=99d be great if you tested each of the three commits. (Normally, `=
git bisect
start -- drivers/bluetooth/btusb.c net/bluetooth/`, and then `git bisect go=
od
v6.11.1` and `git bisect bad v6.11.2`, would do that automatically.)

If you already have git clone, then:

    git remote add stable
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
    git fetch stable

or, if you do not,

    git clone
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

Then

    git reset --hard f68f72d04b60d3af36b63b888fe084966bca07b9

build and test. If it does *not* work, it=E2=80=99s the fault commit.

Then

    git reset --hard 846a6fc7860119ee72737391856497b3fcf7c2b5

If it does *not* work, it=E2=80=99s the fault commit.

Then

    git reset --hard 8603daa4300b84abb3c68e48f3b607d7d5a2a207

If it does *not* work, it=E2=80=99s the fault commit.

It=E2=80=99d be also good to know, if it works with current Linux master br=
anch, or
6.12-rc2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
