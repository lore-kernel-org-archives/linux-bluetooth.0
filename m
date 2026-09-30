Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CE246783
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744499; cv=none; b=A5nv3xzkanlC1GMvsJgZOipyy6SvLjV956aWQooxOaM+yl+o7RcKieFm9c2JoOYvIjTvFeZdXRCD88BEKE46xXxRNS6wgFXmapHMkSQyx4oOvyc4nLjhzBNQa63HqHJUehdewRKVbEhjigAOiPczHvEyDu2f/7usbvAxshgXXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744499; c=relaxed/simple;
	bh=m47D7wtdxNyZyAPvFWvy/W/6itY/SOyFmupdVbQStd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6YUdUcfMOs/ICM42ZvC285Rtze9Gi8wzXpVHDfyXGTX6oKKL/hrI3c0O8COtQwKbXi9tbeZ0BlTLAEvzSZx2Ih2GKIjO4FxGUMwlwG8+PbFeIIImlJmd7VhtRzG4Uq9tSeiIxILgUAd7E4dQo5T1E+LCG3pRCbeU8woiwK4Snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZnP1+BU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZnP1+BU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E286C4AF15
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790744498;
	bh=m47D7wtdxNyZyAPvFWvy/W/6itY/SOyFmupdVbQStd8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oZnP1+BUWlebLLqjU9j5gT/lMyUAAs7+K04ijhDo1pCaylZfp9cU/Xp2J+qeyX+0c
	 A0yXE3JSmvyNo1OxJlWtCXzfC+SxZ44Zr5e/QHaJfO1jkUC5iKb+pztDtbcAi2KUgY
	 pJ9Ky3TVnpTWB17u66+hq4xOsxSgX0a6aiZPlMNzDXDqO6ZtFF3Npl2HNNXXxQTAFj
	 5kfr6qdbxQbBeR34su2/LZqmmQiFKvBGKy4MqoS2D6RL+zd7Vp85mWQRfV30qo47/n
	 7GtS3HmgO8jynigOh0BTKhLz46q4Qvwu4e0LtRmPocELwJE5Ds9izyw3nNRWNRlIJx
	 ksgzCHuMdRSow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5238BC41614; Wed, 30 Sep 2026 05:01:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221511] MT7925  7.1 rc does not work, but it works in kernel
 7.0
Date: Wed, 30 Sep 2026 05:01:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ultimateminecart@atomicmail.io
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221511-62941-liFIWMbnUP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221511-62941@https.bugzilla.kernel.org/>
References: <bug-221511-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221511

gurglelucky (ultimateminecart@atomicmail.io) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ultimateminecart@atomicmail
                   |                            |.io

--- Comment #5 from gurglelucky (ultimateminecart@atomicmail.io) ---
Ran into the exact same issue with MT7925 on 7.1-rc; will monitor the main
thread for the patch=20
https://docs.kernel.org/admin-guide/bug-bisect.html
https://connectionshint.tips

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
