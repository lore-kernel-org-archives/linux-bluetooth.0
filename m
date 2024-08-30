Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5631531C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000537; cv=none; b=Tr2kDDA/DhyZmMM+DUgY4v6mUYvv4QKewF8pymujgkdqxVdBG1f+FXtt/C5HHZNUm9mym+r+n2dIILR4h6qcxlOgvxueY1c3XFMOfbpamfAIKnNNo4GkIcSYb73uyG676OAFDa9FafT0SzPAY0ct992GTKeEjio+MSVkBZ278z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000537; c=relaxed/simple;
	bh=zHLYd2KRLzavTg7pgSZpDygcFcZzFY6D3hqo/awKYdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oe1L8w0lLKFJpoqh262ZfKOhn8mn8hsBNsROy9yGALYVDqgLyJlDshSuoLekw7wHkpd4YHfgmxuEgzuB6mERulRCF69bHpRBZiGGLbMJE+IE31c7Vl69ZH9W5D3LPkS8VG4L0uSzb7jZCSbi17X2fRgEtQO8kRfyo7PW6ted+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7MBuVsE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7MBuVsE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2DF3C4CEC4
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000537;
	bh=zHLYd2KRLzavTg7pgSZpDygcFcZzFY6D3hqo/awKYdk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e7MBuVsEJgjZqDcO6W+4teUdxA+Sa5759L18tTM9wk67KuwRfQvr1rc+iIx/JjyW7
	 IGueL+6O7XRGQoGXa9dWHkRTkSZ8Ur/Jt4415ZuikzRLjXD5DvKo/YE26NiFL8Tgr7
	 p/CAbmT+ZKsL+GEmTq8LPXdaqgJ50W6A1ZnYB88ZCVUPRSIyb678XGJIe8J5DV6zuP
	 YmvJAu4iX8XDSMYTFSNxbifpJtcYcKrtPH3PAfRnUJUTkbX7G++Dy3OOG95FXw0jGE
	 6hoscR7js+DZh53dHq5hiDJbDAbjzhKqy2KAcTd34zcH8R9mx2SjoF+tE6pCWk/iT2
	 JLjTruqRb9ibg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E053DC53BB9; Fri, 30 Aug 2024 06:48:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Fri, 30 Aug 2024 06:48:56 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219211-62941-5kGBxfHe6g@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Kernel version?

lsusb output?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
