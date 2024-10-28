Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E641DDA15
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101394; cv=none; b=ikRq1J2Y4tbtBawV1uutQu8mOGiCyc2WMIjx1aM9qY4rGkYx2BkuyOcoULiAcjf91df0GffP2ellIS3szDly/oWRyu+sBCYxPOUnMxbTkPhYIt/Q50ZmPmX9lf+tCLwlUvzQD1P3tfM0iuPic/2w1P6olHhaZkuQaiGbYIkzL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101394; c=relaxed/simple;
	bh=opQrGfcvf5ZDmni+qOij0d7BhZiqgLZNlLjOHZY+vgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAu/mYyFTll1aLTTjTUWs0Wl8El7c9UzWjr7d3ZIGHXD9qZ0YX1ntchBWJ0uom4wOlJX8vWPg5TqmtXPAHiRQ5LoXMttQOEgQhxyTRSMOWhSfaLUHo+aB2yMnAHPeRLmAqnPkDsLf/UQPtsZSoteBJHaA8lx1tvxcVNgscOdT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhVEmeTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhVEmeTY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C687C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730101393;
	bh=opQrGfcvf5ZDmni+qOij0d7BhZiqgLZNlLjOHZY+vgs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qhVEmeTYQZOVy7ElmmTrY7oBPPDutVY+u6bppq/cRCLroGs8rStEaBuMrkDRRFkkG
	 EfU/qUcoSF1PKEYDJAibkOtSdGjA0yAzKp3FIkFLXwO1PNZXHKBIhQyLqsmHlLHSHQ
	 aHDcwnhvXeks1f3myllLJAjT57jEUYPJCV6QvWaBC7slMh9aq69hy7b+vrx88X16wZ
	 M9kz2LufzpKkSfzl72xpt7dfIbGLMp3SjM/mgUa0he9KV9TdiVFHe2at3CbWMA8Ohc
	 tWGzJMc3InJVtu/4wPuTsOqPARkIxK2NXGG7EI5AVl2nEKOiIx6AZPCkbTCT4NOBvy
	 UbNED9tTjGlQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9453DC53BBF; Mon, 28 Oct 2024 07:43:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219433] RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
Date: Mon, 28 Oct 2024 07:43:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219433-62941-0rvmgJYNvX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219433-62941@https.bugzilla.kernel.org/>
References: <bug-219433-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219433

--- Comment #1 from sander44 (ionut_n2001@yahoo.com) ---
Created attachment 307078
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307078&action=3Dedit
dmesg 6.11.2 txt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
