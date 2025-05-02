Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF1214236
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222804; cv=none; b=o/pYS7CdI8BYjfS8jAQlBeSIrAhmfaVfn/4l0MoqZRTCusKXPa5NfrmKovZemugUBm38kUJhBcC1p4qQCEKHlHWyR4qwxJqHZTbUnF2x/+qRwE9SFNhOSQb2UKTJbth38PR7bNa4/lg+8FI6VmE+OO8KcZsnt5MNplbbC890Chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222804; c=relaxed/simple;
	bh=Z7jolS1SYvR356j/6JF5jD9wW/SN08wy8GP8TfAWJ8A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kg+nGvFO7tdv987jm5us8VW+Av2sXQTAHB0BHAaDicd0umbFLwknBIxoy7uHrJbnpOIVNfGDdFo4NJePqJHrUGMXPzXRr4v104Lfqls0NHBVX6oszEwXe9R3mFOVrM9Y/mPL/f8NdSypA2PU6RXW7TN3kcRav+okSjhHhky6aaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGOyjO6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGOyjO6r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3354C4CEEB
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222803;
	bh=Z7jolS1SYvR356j/6JF5jD9wW/SN08wy8GP8TfAWJ8A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OGOyjO6rsO0INxILrJwq0czULHkhJE33/k2FJMtBr1ZU/9A4z6l8jRbFP56lBmMrz
	 I36fDjPamxQRzYx5fXdoTgX0YKe2WW7SW8uZntbbe2mgcKToaPUD/VGZ0ltLwcH9RW
	 Yos63I2hU3cqHk3T6SB4BRFnZaMTPGBJw0Wf+BYeHa+OYBCQzKq8uz16zkKJ3gWTA0
	 wNUCWUz3ufBKD4m7LqLBukjVZlVOkc5qVKBwdmSb2H2QxvJIKoKHAcbCdLYFwNiQm0
	 EJUdmHQufCa8brSPWR2a60muBKpRmLsi0gwQZOkeSxHvLyhcWchgXJl1T0j7pPrFmI
	 m/pYxw8MJMWBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B7C05C53BBF; Fri,  2 May 2025 21:53:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Fri, 02 May 2025 21:53:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: sandroid@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220061-62941-LQgswhU1cP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--- Comment #13 from Sandro Forster (sandroid@posteo.net) ---
With v3 it is working flawlessly now. Thank you very much for working on th=
is!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
