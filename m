Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1D382F01
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786212645; cv=none; b=ke1ko/GGD+0Q6wnpzr8xrjbtzh0v4Rg33438TE57x/ge/QDUZi0YlMTzqvzxMOgugRo+jERT0TfdAu3dGkzPyFZIStH6bX5oNbWUd277acVFzl8dvW//sSxrpKwP84rbhHjjWkhSkYNSW0CVNUzKtaxjT9BZNyzQuzC9aiJsMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786212645; c=relaxed/simple;
	bh=/lCrfiLCQPzRhe+A7JZnwJOUFfUslqLj6FsjNMUfiFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9ntYAVRPp7oqeTRFggG51aU/7pT+pggf8TcgXOgvRpkrIXO6Ap/bgYCslZiN+aaHY3R+SI02QpqFR6vG2yg4Z6/Ya6awJAF9SgK9AEa59a/bitgVj2yqxeeIiqcf2d1HGapMxQeJIdERehoQzmA3NeMACADSydyaZ2TgZHwVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4dwdzxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4dwdzxm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46A0EC2BCB8
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786212645;
	bh=/lCrfiLCQPzRhe+A7JZnwJOUFfUslqLj6FsjNMUfiFk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t4dwdzxmKid7LXr7iuODocMSBAVEuPpt2yu0Is2eSC788fODYrYk4mn6vGpihRcnP
	 8cRI3qjoiOEsq3PtJElInYqA0aS57enQj9JzrnxhtaSnFumzubi16P9FX10WHV/91t
	 o8duy8PIOFcxgL3rV5A54TXW31iPi2svrHd3F7kIUKLcBEk780xPpWFfnB0BaWqxFN
	 yF+VHboM9xhPQ0ipCsYPS/6m7wQtHUO552JfSItUDO7QaRx++rwpznLw0JMkLKYuLA
	 Wq1hnY8u3OmNGCcHQVXPUDq4h3Cfxc6vqJupkaUu1qF/EJW0Cypcewp9581QQwghXX
	 1GT6N/ot5iPlg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 318F4C41612; Sat,  8 Aug 2026 18:10:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Sat, 08 Aug 2026 18:10:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-rrYm7AtU8e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
What's the output of:

sudo rfkill list

sudo rfkill unblock bluetooth

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
