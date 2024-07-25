Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D91C6BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943793; cv=none; b=FJ3h2A3b0vgr2evr/gIWzGTQw7npBnSthyeOi4Gkhr4Vmkvl/b2/wr2imJb4L+okluSXiaozUOoQJg3RT0MQOnbaXCr/GGDN8gCIQnI+YXZEjh0SyGjZotEDXpohAfdCc4Y9l2jVfNVxXD4T2Nhc6ABJNbrpQGY4I7Qw5NyGwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943793; c=relaxed/simple;
	bh=cdVzvyOp+NQWICU5ow0RD89tpesYYDSIXkiJp0bP/lM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNi1dDI+YQjx9OH0681VxavMzmpt8Vuij3lj+88OQJaa+Rju1/B68Y+UKrtJr4dDHit8Q3vyTi9DVScTTbc3LXWq/bdWU3uZeJw8UunfTpzhTgn6RIvwfZh0AT5B3PYjdLPrx90yeQ70fPn+nDdLa/e73oiWFOMPjoo/I92g+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvagwEpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvagwEpd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F6B3C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721943792;
	bh=cdVzvyOp+NQWICU5ow0RD89tpesYYDSIXkiJp0bP/lM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NvagwEpdvEpUEJTyJhYsfKLcJz6KXztwRYzFB32HvOUzG/ovKoKkkueq8mAWNmV0O
	 acF+bLAygEHUIjpc/XHGaw2fUCv/xuur781z1btTARhzCTsisJrfP3ucNlvLvXRmDz
	 BFdecv79sZFjs9MXtATtrFM9nDvohYP3K7RojEy0kek1p6qDwfyg7IsZqFNidgZt0G
	 zF3FN/i7VUMSEzNqOSb5L7O2jUGND3ILNjIOHNZw7kxcYSmwaE86Qahk2Otd3DgVpS
	 /7yHWQY3wQmhp448cTzUiFF4qJMIoapBFGIrktPFwu10Z712NQOpUXM1e9+de7WFQy
	 /7P8hBLVcPeNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7E928C53BB7; Thu, 25 Jul 2024 21:43:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 21:43:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-Z7Zn2jrCv3@https.bugzilla.kernel.org/>
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

--- Comment #14 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Yes, I'm sure. Nothing new appears in the btmon log after issuing scan on in
bluetoothctl, scan off results in:

@ MGMT Event: Command Complete (0x0001) plen 4=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
                                                                    {0x0001}
[hci0] 89.970607
      Stop Discovery (0x0024) plen 1
        Status: Rejected (0x0b)
        Address type: 0x00

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
