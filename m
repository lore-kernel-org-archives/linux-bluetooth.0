Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540316419
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907312; cv=none; b=IrjQdwwi/SP5jODme+9bHeRMqqU21vi2ocSbNXIM8VZiX9I7tzAdoDL7hwKDlyO6m/b+sTsUk/hwWW6n2fw8vu6oAbnaF9X4l/QywnesL+xjGf3X8fck08cIPiQgabrmTbkSoDBMg1rRZ4wn7y3yXxeCTrgMWj7Qe9+EvG82SYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907312; c=relaxed/simple;
	bh=Qf03flAX6FrMLFUMdOjfnzKX+xS0+FH+rr1qneMn8/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7iI2k3QGSHjSiBlgEVrP3LeOCqO46i/+HyQRXqCr9D3Lte26f9DVRGw1bxxdiVFtwEerAEvvop51g8siEyVwfnuWV+ioN9WVc9QKCtG1J8ExfyboEIvGnhECK1gEwFpadj1iCbArJ+/VwuL2m1/1pUg+6CFY3t3V9SZS0VNIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA/DG5OD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA/DG5OD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19479C32781
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719907312;
	bh=Qf03flAX6FrMLFUMdOjfnzKX+xS0+FH+rr1qneMn8/Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XA/DG5ODd88Kacu1ylQZL2Gwcq2ytZdOiQ3zQXefuAnrQl7cYkutGE10BTKlNQWsk
	 g6m7jReh5nYv3XXfQdEIUIhMQWELPuoyq4F93BfqiIsWFW55ysciKFj+3r6nXRX4Lq
	 zR80yEtgsYeflTRVj9qVDTKzFTtmpgQOesDYhujpIxEJrh4S+OBSc5CCcmXNPZInas
	 Iei5KGN/EtLaMbXncA4yafDAqbyHZQURgkVU6SJEqt+nFSKDcpmV5I4OXE2WaBIdUw
	 aDLjM7NbEduAZdyFYd2LC9vmnDm9UiyEHU2pkk28JgKU4OX8tzW155n/erk8Mj1d7r
	 nsSykxj6vzVMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 057C0C53B7E; Tue,  2 Jul 2024 08:01:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219001] mt7921e: hibernate/resume not working | Bluetooth:
 hci0: Failed to get fw version (-108)
Date: Tue, 02 Jul 2024 08:01:51 +0000
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
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219001-62941-IWsvdKLViU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219001-62941@https.bugzilla.kernel.org/>
References: <bug-219001-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219001

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.10.0-rc6

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Is this a regression? What was the last kernel version that worked? Could y=
ou
bisect?

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
