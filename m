Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE325DB18
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614113; cv=none; b=NwHYTQzft0YYqV08X8wn6yWto1knHy7DqsGat279sI6jz+Prt11JQa3mlckupCjyhF5DjMbIzc4TEt36Dmtt2X+zpWXMOlgY9zRUCAdFSbEIZHfuWb9JDjpOwy4g7DQi8PfZdA1pgcKraYfvIG67OpFd9zHJak+kydRBn4labSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614113; c=relaxed/simple;
	bh=MTkNEf9xFk/Jc4MiGFLtDABckJ1cUWedMizsBhJ/g1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lt0xNiyReoMxMw6TUM1oSTh6IIwMr9IQkrKX1uIRar0Lw4zivFJ1mdnHPHcuc3pGMajC0NphsJGn3+vInY9mYZenPpPV3qnFFg5e/Y1rFKpv/bQCAq2QC1UfM+a73/2PEZ/42/0ElRt1w8WAjal+qeG9ViHYXwIX4bkkTBMSH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaxM+qhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaxM+qhf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D9A9C4CEEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740614113;
	bh=MTkNEf9xFk/Jc4MiGFLtDABckJ1cUWedMizsBhJ/g1g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KaxM+qhfHa7Enp8zzj7GPHr1FkwKN1ItesOexI7Ez+94upmEmQRSNdfP4U2aKb9LB
	 S+2Yk6bzQ10X7ezXiH/o+u6KIKOCZ2QXnho+82xhxg9NXgN6sGmFZSJLsNyQKJkV4C
	 YyF1vAeXRUrTHLikqsWjtGHExHb3efM7BUMM/6adGA/VbJgocaiTH34LkK8IgqsZrd
	 g11HtmYOOW7JypQtz/i/imhLLzxvDZZX7nSJo7bifdAoJ7VROfDIDX0iG72v6BUzbW
	 HvVyop6pKYgJ8+wk4GqbAmAJkKxYBzqSRZcqpJJdVMSHwlU86JjFBRMexXZbEcx2+n
	 vKNSO0Z5NJgYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 529FDC53BBF; Wed, 26 Feb 2025 23:55:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 26 Feb 2025 23:55:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: foliden163@envoes.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: IMPLEMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219365-62941-VNP6HR9L2e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

foliden163@envoes.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |foliden163@envoes.com

--- Comment #13 from foliden163@envoes.com ---
(In reply to Luiz Von Dentz from comment #5)
> Crap, looks like these old CSR dongle don't really handle the
> ZPL/sort-transfers, so we will likely need some workaround for these, most
> likely a new quirk.

Same issue (with same BT adapter) after upgrade from 6.8.0-52 to 6.8.0-53
and/or 6.8.0-54 (Ubuntu 24.04 LTS, Linux Mint 22.1)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
