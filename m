Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863129B217
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766502995; cv=none; b=bUPb1dC+xPD+ROcYj4BoLCbkcRQS4OuHNtCaotJZfIOTxAbcOKAIwPVXKZpk4OGu6xhHYCMV3Aoc2ectiRVy7shF6RIuAIgKNCISc49BVrk0ad1kfrnCesftix8yt+LzZZoZrBKSiYCeb4GmDZyMg2/5wngfljyUKJGZPUUjWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766502995; c=relaxed/simple;
	bh=BmVq/Jj3dbguIWJbRqBx7ekwvBDZRNcWfDW9AqLbYjs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVR0VkNNTEi4RVmzNg0FjrEbDqf+dRLMW2xSjq9inoY+VemX5KwUTZNDI2v/EstDmGY9szfKIWgQSiXqYInPu4PkLQyP0FDgljEAovxzVAhfH//TAH9c13iJ0T9n3jR43qdSuvAH89qiD+Fn6Ot/QO4WBgUWeeMd/c1kqsvajf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVMcftNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVMcftNf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFB9BC116C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766502994;
	bh=BmVq/Jj3dbguIWJbRqBx7ekwvBDZRNcWfDW9AqLbYjs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UVMcftNfy/7KVXbIc9zkEn0K52zuCYM6dG8+rj+UESXLN3uHOFTk7VnUyHHZSBSaA
	 mJ0A4QtLvStm6MwRRHU9yVr5EZvcxu0K+oJGRwjQecIFa/Cq7+nCwedp1pDqbbA93a
	 72pj2SU21ptvdxPa+SvNEtu3VcDSjsjB3kFhrCfC6gvtfZPbF/FTeykrErAAUjetqP
	 xGzMao4td8nr5but4HSf7F1RnkxQeEJF84xOEvLb1YqQUNE55yuzHmQcpXHZejswFi
	 oICEVnI6IxdzJPyF0wtntNfU8I1KXQ+EXZ/IxDG5bOZJkjDDl7/OhFdmKv4eRdqW8v
	 BlAwfw6SGUbCQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C750BC41612; Tue, 23 Dec 2025 15:16:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Tue, 23 Dec 2025 15:16:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mpearson-lenovo@squebb.ca
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-KTaXAG6FyA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #35 from Mark Pearson (mpearson-lenovo@squebb.ca) ---
Hi,

Few notes for the patches (though recommend you post these to the
platform-driver-x86 mailing list so they can be fully reviewed).

patch1 - put in which platform this is used on in the commit description
patch2 - typo in 'btusd'

I want to do some more digging into this problem though.

If this fixes the issue, then you've hit the same issue that is being seen =
on
multiple other newer platforms. The quirk list is OK, but I just worry about
side effects without understanding what changed, and why this issue is show=
ing
up now - especially as your platform is older.

Mark

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
