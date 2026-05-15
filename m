Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB13E5579
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829384; cv=none; b=hclSCX4fDO+INTl4M52d2rYcEV31iDoUtsmrxO/x+vHvuS1FAC0B6sxEej3uENibQKipowG00ympJQreGqzwjy3n0OZE8h/e4X5o88/x1Q4tio7DNk/Bv4fYXWThw9//tjqGjc3ikN51y6LBwrIa5Jf507XYYfo5tOhjR2tAITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829384; c=relaxed/simple;
	bh=try0CO4ZlcUISSq3KM9TaczWKxx/KpZGaZSwRvI+1tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CfNqZczNXTRRQbvcI8I7j5vnn6G2JM3hGlOXDe6lI4Z+XxluHMzeZnDtw0SezIm+lu9jX/VNGLz90zAheiDBTSXgzZSDo6O8p44yNvsfkuWIbqknIstxyM0yHcsgM88i+jmAhTCNaXDf1iIpuyatSlyy53uYLmWEwiHV8g3hhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmdUoXQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmdUoXQl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22543C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778829384;
	bh=try0CO4ZlcUISSq3KM9TaczWKxx/KpZGaZSwRvI+1tg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lmdUoXQlMqSw3F+y+GhvTYdQTGDKwJZ733/Enq3MosRxveR9wv+8C/AILP8qAAEue
	 PIZs+5JI40NLP42Qf3zPZJBe/x5qK5hFvON9diM6S5WdHEW4hs0HLc9ParETFO7hnD
	 hp+i1Nh5Ez+L3nu1CRx1tUlQH6ef0RxR8OXkHG9umfLxevbHFGjQoZulsuTX7h4VY+
	 ZqAoNKIyyor28/lovwzXMCCdncaa+d0y1RK+5YVBuJv1X9IbMfHUdDIU9jjqohRGht
	 lT0WPsFvvU6HQ28oy2SSSPN4A39gPbmZW5UfFCuxw+glKyfjGmHVRmvHW1JGHhfNJZ
	 1xLh+oZw2bxMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1291EC41612; Fri, 15 May 2026 07:16:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 07:16:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: txxlc@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221521-62941-9I1wdfoaMV@https.bugzilla.kernel.org/>
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

--- Comment #1 from txxlc@pm.me ---
Extra info:

Kernel info:
Linux pc 7.0.7-arch1-1.1 #1 SMP PREEMPT_DYNAMIC Fri, 15 May 2026 00:50:13 +=
0000
x86_64 GNU/Linux

Hardware:
% lspci -nn | grep -i '03:00.0\|mt7921'
03:00.0 Network controller [0280]: MEDIATEK Corp. MT7921 802.11ax PCIe Wire=
less
Network Adapter [Filogic 330] [14c3:7961]

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
