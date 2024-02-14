Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A960273
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929103; cv=none; b=ZlBgs4HmlOivJqhv9NC3lE3OYdtrbOA+yzzB+xeUsT+bNnGmSKc9E3G2IgeD/GifBgsJDavH7DgcoiMTTqTiJCjjguFjsiR2jB2jbwZfp6/eg8TKfFDI7QxZ56g66FhKjBjcWWORSTpRGbfPGEkGX71ebDkXMe5BOfqqDwJLqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929103; c=relaxed/simple;
	bh=iQLObXU9mydkN8umhMRw6Sicvw6JQX8JmqQhd3RdE50=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCEJgu5AwYFHa46/666ssq3AISBCbVTW58ebB4220K38vXGlttoBTbv2lz/6zyX+U9wDshrMSh7pmpiXh/dUV2BYIsAQUHP5fqAvIhQZNtjx/4V8sgx6ixNQGZrExdHbSvdATAaXH+m9QUfjfLZ2DNHzn2l6Vck+EUIgBXYbwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faXwBOkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faXwBOkG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A7CFC433F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929102;
	bh=iQLObXU9mydkN8umhMRw6Sicvw6JQX8JmqQhd3RdE50=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=faXwBOkGwAH0uFyDQ0T7pl4BWZZ0i8TTjKTE1oUnzmo0fSkNBfELjGPFgccI9Sc4q
	 30v0xG7lOA5v993VodflP9jM70I+nkWdtgJlSk5iDW9DLdli8Y6Eor1+vK9Lqp0cFy
	 kOfLtBnCXxfHiSIgBKeqKthR2UnWI/nqaBx1sDJo9daMo2Zwmy/9v8Aw9vkeb/IB1G
	 UslF0MBnRQ50IAZxdaSahnjhSRH+QO7s5lP8QLZUz4BBS/ld7WuLrMdGK5dizRUr1I
	 NJdtzyA3lyL2/05vMNmGybPNSW/kr0BV4Dk1MmrheFWALsWgWx78Kmvpyq/Z7eKU5h
	 I+Y28bQz6A1Lg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 681C2C4332E; Wed, 14 Feb 2024 16:45:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218494] btrtl/rtl8761bu: RFCOMM is not working
Date: Wed, 14 Feb 2024 16:45:02 +0000
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
Message-ID: <bug-218494-62941-y2ESseYr6q@https.bugzilla.kernel.org/>
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

--- Comment #1 from Mariusz Bialonczyk (manio@skyboo.net) ---
Created attachment 305868
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305868&action=3Dedit
bad: dvbsnoop

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
