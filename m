Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE74B8DD1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198307; cv=none; b=SVot86cUsRatthW56Az5V6oGHSi0CH7DkW7DMZYLr3k+WwFaRw3Mi3tH7yWRGCJnHrLeAiDpWRWUqKL7b/dzOJkStSvs91l1NU5zbghOvgeeuCtwh/MyEqdchdbR92kww14ELeW8qb2MJh39OXJXSSr4APF63iYtIO6v7sBa1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198307; c=relaxed/simple;
	bh=7tDwiY5Z9XHQxODjRwO1uHm+bFuMgXE1A545VDwUmQU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nY5rKlhpHUG1eFIU37TFPw1STSgU+SEyayMAJ9ap0mcmBxdwpnbBtzlOTdK1ec9vBm3jAB1BoJ5bpQnZNJE0br6SJwpZgDEs/TbrTt6nNCVVaeXVil6GOQIYwSj4oVc91/fab2si+Zpf2bkY0rlp4yFfVo/0aAoLXxHS+2keuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InCkz4IK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InCkz4IK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F219FC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781198307;
	bh=7tDwiY5Z9XHQxODjRwO1uHm+bFuMgXE1A545VDwUmQU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=InCkz4IKDB060OeTpLwgzR9L209RnfxKMPQ4rVgyOHeOj4WjBlhMAfl1ERJPabUNR
	 FSe6fHPM3AN7qpdDiuej4dlyxNmxD0dfirQ1mKTRAHJ+WZpbc0xicKznzksANUX+S4
	 AX7XCXh1Y4PbRF2YBEIfFP/zTsg3vOGQ6ddvpZH5owazOv1ADEi4TwyTmQqPWdnqfm
	 D/qjN4rBMte4jTcSFdnGhomd15sM1g5tzi4/33AP5kg40N1clp5FzdPv65AX+NH78B
	 dorEEw91Btcl4hf1G/0NxjEK1JGkw+FZD0OuGftJrbW+MHmGQiMJJl+7Y4/afScnr9
	 LqSG2Y2isihVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA226C41614; Thu, 11 Jun 2026 17:18:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Thu, 11 Jun 2026 17:18:26 +0000
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
Message-ID: <bug-221637-62941-I9NVvYcXGO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
I also commented on the [Linux firmware merge
request](https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests=
/955).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
