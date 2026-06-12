Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736233123D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781300065; cv=none; b=gSsf3GRr2QVRWHoxBDDF7zcl2hU7JO6eMU/WM5nxyWMFFFkH8YZc/hYBCwHl1eP3RR4A++YxdjpZpbNbjGodqTfSUroGK0ylXDi+sWX06RpvTwIN7mI7gqeKPZjLi2lUrwcQCTI6qGrtv6FPkQ+oDpZx0nFNl5txVy4LbLH6Pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781300065; c=relaxed/simple;
	bh=VZugk3MtoX8QzZGmB0HerxYUTrxqej4910cInGVxRcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7UtZoCk9+gd1fA4bKrD1MtUV+nniOs4IiPCDfWJFQToG9mK8YpuJbYYTr2VEAc/iKEnapkTV6lcseYGwpbsRHuoubxTxim/qr4l7QhIl0f7RvbjhZBc3qSji8XaJcgbOvrWlcbcwLzx4ypYfnyynzlX+oRlBUq1VW6YE5QBZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXSWr6XP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXSWr6XP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11360C2BCB4
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781300065;
	bh=VZugk3MtoX8QzZGmB0HerxYUTrxqej4910cInGVxRcg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oXSWr6XPSP/g0BEzk/dF4GnRtIlIdSae9VGfG1Vffm63XAioov5alekGuJbNJ49k2
	 sTWEE5qRWvFxmo1w3ll/lfo7HheqwJ0A4ycjSn6s6GleeLhRMi514ZW+N4N0J4h4yc
	 V7yVy7goqx1cGm4YoGQQNQcxrRs77TlhBkfnTAEQGykY2/ZibsndHRx31cRlCWteS0
	 Cxn/U2mnIhI2etxpgaoJz6XgOWPBhhU6STZ+WhUgIA5o5T2cRQvq7UvnDl5jmvf0fe
	 RLNOmtLxuEH0UHdsUBmzuSU6moHH2DnKqSAlezDu+hkypBrgTrwYhvfvCe2AHBwBxs
	 N2QkeYTG5EtBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EDBF0C41612; Fri, 12 Jun 2026 21:34:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Fri, 12 Jun 2026 21:34:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hytham@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-6jphObKpbX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #6 from Hytham (hytham@gmail.com) ---
Thanks Paul, please find my dmesg.log and new issue here:

https://github.com/bluez/bluez/issues/2222

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
