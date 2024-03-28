Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826537E586
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623631; cv=none; b=brLeqnpDHZzd71Me75avUQnc75LLc9ZdqIaSDKpyJ65VeT/AC6iETyahgd5SJYvqHz+lSw61qWOxSGZjIo4514CjUZT4srZeNqIaH6OBSHekwHnNfutoUbD6w1ZjRAmOOBPgxLBqrBjsky+2fQjXxQ3qo//Pc1ugsCV9ffzwbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623631; c=relaxed/simple;
	bh=x3NTT1Em41/dUQvohRau1Xrt6UcdJcXFhe8KJiLXQN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ov6aaYHva3HTpE31GR23oLmsMH6kWUZ5kKHp3rQx1rB5P8INhVWrAX7Wgr6Dac9i8pcaveQ8AzXlisOuLFFhkMwUpCWDwIpWsWk8vD34yHprqjbcpl0I4vb3sZ9HcXC9OCWaSeXTZQiqLnT861lMHNq5TvLFPLWw4Rm+ub7Vrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgNb7QoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgNb7QoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F370DC433C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711623631;
	bh=x3NTT1Em41/dUQvohRau1Xrt6UcdJcXFhe8KJiLXQN0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tgNb7QoQJSLZPOS7P7RSOZJkc/B6kiRVVUmuL9OL66QBmGiZ06bJlhtxWXXOos8AO
	 cfV6KGJqMkHd1b2nh3qQ/p59VJbmQo0mTCHNAy6CU3ibJklY+/XXpdLDNSoooaq84g
	 DerXUwZX7VXXQ+soVG7hl1c8zFrNCWB+wGlXudwxSXYLqsa7rlnQIZNAE4mlW5Y83F
	 jVeqA2ArM751a67D0m7pF7lax8ZBdZKgszjNSY3ZT8oF2MHn/BdYlJxZT4AwGvWcXL
	 QmmdVf31LqdgSYOHa9Bih1/PSgZRGJGQBIINLwWhe7MOCvldhYg40h5NL9dqBcNyi2
	 /dWzEWAnmU/ug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E450CC4332E; Thu, 28 Mar 2024 11:00:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 11:00:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218651-62941-yk7ytCx0us@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

jb (jb.1234abcd@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.8.2

--- Comment #3 from jb (jb.1234abcd@gmail.com) ---
Per
https://bbs.archlinux.org/viewtopic.php?id=3D294292

Same here with ThinkPad T14 Gen1 and Intel Corp. AX200 Bluetooth.
Therefore I have doubts that the Qualcomm related commit from v6.8-rc7 is t=
he
cause, furthermore a downgrade to linux-6.8.1 fixes this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
