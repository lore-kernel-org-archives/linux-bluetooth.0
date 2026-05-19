Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F6320A04
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202357; cv=none; b=kHOeu2L0YUOPROGzgf0YH+2OU62D49u6/YBGsP9j26LAPTdk2/4nhD5uAvyctDz1xKh07Ni+S41ebytdjeDo8t/X0LoteZ9VVnZsJUb8p6w6Q3MoxWnJXPCqQdop7I946dz5EfTVLUalkKB1rQESBBABD6njNw5dQwgteSV4lUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202357; c=relaxed/simple;
	bh=cAmGsQdO/8hZuHnMF9FGzFvGcviAki7ZFuIOi7mz+Ek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DRi5AvjgMeQUG8pG0tNX6vyopR4CPOweIwnoeif9dEQakg6adihdPHgKNy0UJ+RtznNSsOFx3BO6oox5vrUIAdZF6GMN/KWhRd8pittUbGfbHvXaD6DTkljMp0Ccy4fwcce526uJn57pDhq0nW9S7CV0+F4aQalCvgGTLiYEdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7P5E4O5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7P5E4O5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 441CBC2BCC9
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202357;
	bh=cAmGsQdO/8hZuHnMF9FGzFvGcviAki7ZFuIOi7mz+Ek=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I7P5E4O5+05soQ0wCSgv5n7TgEGGU96GbqJLJr5R0z5ZhXFKp8xV6zyK3XDoiw18Z
	 tjBShoz6e3eOsRwWwK2OHRfJncD4fVUYF+wkXZo1PXwtoQMLNNg5qMTqlsd0WYCk9s
	 h4c0iaQiIXj/+C9GhwuEuD9lI4U9Rbv2qeQXfFYd5H4KRuVKdYtJXzllc0dRtB+fki
	 enujCVXOr16NM5GQe+zWPKzVOaNDM3nNrSai+uCUJpO4mtXB9UL1NzpRVErbmGP0Uw
	 DFas6d6yVCnWhiWBE2yseKY7Irs/W9+8hKTVM3iiPL4ek8N0U5jRU+d28TFxY/nBXR
	 RuWmJHl+X3oJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38617C53BC9; Tue, 19 May 2026 14:52:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Tue, 19 May 2026 14:52:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221521-62941-ADRH1ihB3M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

--- Comment #12 from Artem S. Tashkinov (aros@gmx.com) ---
The patch has landed in 7.0.10. Hooray.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
