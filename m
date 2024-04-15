Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826C3B28F
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171708; cv=none; b=XLYNonsjrXs1cv73Uias+05WgE/R+OAGFUzzZ+AOkCEV9VHSHqWDPPpnGz6y538KChQZnNMd1DbCr+dPBcb1cHmESMkAWZnXSByAF5GRXaAdue6ajwmNDiwuZDNLR/JrU/aHwvIW083xb4aw+tf9AW/GB4e2G6YtZY5pgedGLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171708; c=relaxed/simple;
	bh=DcJzKLPv8cwt4KINoYBEzpkkNunHzYuJaRJNdtoh/L0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGTsu7JrMCkax6KcbXrediBY3zohigZ7Q1vD5CChinb4ENccIV9MWB9uzyWdHP5tWr/dEuqpNP4Mxxma3a3fwaamQyWt03QMjsc3OamQ/crV8czf6k7X6suibfSQl+yu8aLThTZZPkyyMa9pb6edQ0hWQ5sSy0lM49VE22SJdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI/nO4cT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI/nO4cT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26F3C113CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713171707;
	bh=DcJzKLPv8cwt4KINoYBEzpkkNunHzYuJaRJNdtoh/L0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UI/nO4cTG1i/Ns4zDVE16vNyhuvTQSQTDJ5zt+piXg5//guz0FguGv2iJfKE9CfOI
	 FVt9RtyOjK6mwrjTtVdjG2hJZHLZfwWUJxUGpYJj1K7UlWm/Q38e7WjbI0S/PqNvoI
	 lZ9Up3KJ2aDifIef5a1eydbTL9vwYqDiuatW0rqb3BUjSQucx1vkbJxWaZGhPRhCAm
	 +qBhZArD+wWKjNn100CASU4mFN0l0jW7cSWQxuDrBQZWWPKW3GwF4LHuYb/2W3s1BN
	 cR4lIvKjNj1LztvPTw09tqjIjQwgAfa/IciZmJ7zHoVZkHPtNFxuZxrTSvrawHd8O4
	 lNHMw85pxgMLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 933CBC433DE; Mon, 15 Apr 2024 09:01:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 09:01:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-hvSMhX7LWQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #2 from Warren Turkal (wt@penguintechs.org) ---
How logs were captured

1) Apply below patch series
https://patchwork.kernel.org/project/bluetooth/list/?series=3D844357

2) Disable BT

3) Power off

4) Power on

5) enable more logs

after boot:
echo "module hci_uart  +pft, module btqca  +pft" >
/sys/kernel/debug/dynamic_debug/control

as kernel args:
dyndbg=3D"module hci_uart  +pft; module btqca  +pft"

6) enable BT

7) then check this issue again. several disable/enable or reboot cycles.


As for step 7, I will investigate other disable/enable reboot cycles if I f=
ind
differences.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
