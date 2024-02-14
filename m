Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1560269
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929170; cv=none; b=csk07TuJWUf6sC3p3llDV/wSlHliJjD8ZEybLk8XHLOUPMT/rd1kOtd7ePOVtKuQbqv90rjCE7U2TLfqme/RmJewgdEIgK74tijtiSvXUByrhg0vgC9tIkTyUrISIpQX1uvcdAaLNfRwpMJrFM/7ZrjgiZo8qekygiI0NrVSsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929170; c=relaxed/simple;
	bh=sJBBvColyJgtB4fGetPqcvSPj0RMatoJ2eP+x4DOQtU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spZQEI7HDjYEBGTp7ovfByAI6NGdFLqehTKN/UNVvIumEdXxBEN4ryc/D5PtLhQGXet63rfyqobunU2csTeHmCVNZF7CJP54CYVA64ayHkuO/XFDiUxg3zL0mCIl5T9PT/q9vWxZCf+AF8v9LhRQCPWXFv3vskZROFAWlpdvX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrMgFUyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrMgFUyK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EBD6C433C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929169;
	bh=sJBBvColyJgtB4fGetPqcvSPj0RMatoJ2eP+x4DOQtU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CrMgFUyKfwpIbDB48t0ICshUW9eMchvx5dxmZ8zIaiq7Z/fzTQXkv80y3ylQe+GwY
	 iRHZaxpUYQ4zIercZPya3EnpXJwvIVsnwnL0t3rSvrfGK5Ypgxn41/IoOQhUxmf7s6
	 hlBmp2UXrcOmGuxY3xNHV41zQCSV3A8AuN+4rXE8bxfj10ipwBlhrs2fW5osD7TSkj
	 nWrlK9G9+2NxGIz9OM6ruOTGzHK+UWj7085/Jzrtp2bq5LUbE7WM/QlHgWK6vpomGQ
	 mrTNNaXTm9tDK5NvbRQ18uBywTaj3N/G65KlzyTQ3qk+Fy74Ai5fz/WigPd/l0PwtI
	 lf3738gURbObw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8D98FC4332E; Wed, 14 Feb 2024 16:46:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218494] btrtl/rtl8761bu: RFCOMM is not working
Date: Wed, 14 Feb 2024 16:46:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manio@skyboo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218494-62941-vpjgfQQVFV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218494-62941@https.bugzilla.kernel.org/>
References: <bug-218494-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218494

--- Comment #4 from Mariusz Bialonczyk (manio@skyboo.net) ---
Created attachment 305871
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305871&action=3Dedit
good: log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
