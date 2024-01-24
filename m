Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140546AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114956; cv=none; b=Wks4KRSkCRXPSkyDcNQooh/CZeqE/1c3F/hnn8z3XjpkRTNeYfPTINJc4hhbotwZkFE9l5NNNjSxA1wm3Jmo86QzpDEuEyuoghlKdI5c+ISUbrTB59dOWAi8yQjYDww+/KjWCunCYzOyRnovtOcXoZe6Und1t0HyFhkvPPgMC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114956; c=relaxed/simple;
	bh=TrZzGqfxXP0T8j9T+wSJQtTvcmEtcVAxvI34vd14lok=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwltkNN6cjEDBNBGpb0OqhlCFX7dykyUq3vDcxzhWvI4xfPctm9DrLiBwh0DoNwZmWNH3SJJP5H5BS8qcSO9hMDYaT+PAcZBisBwqx7CzlFn2FuxXMl4AOelTb6icLq5f9Hs4GriN1ghDl79s5QACd02QQpfC124ODg+iNXOVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqei9oqR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqei9oqR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 472C2C433A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706114956;
	bh=TrZzGqfxXP0T8j9T+wSJQtTvcmEtcVAxvI34vd14lok=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tqei9oqRnm+CWFejIQfUmFPPfW+EpHpB32P9jRcmD2jjC1coy+h5C4saJPTP9dF62
	 o5Z9N87vFDQUQN9kc4khnfvkSaS694PZFKEwlafO2kmoK0/quTv5LJ4mzZY5mjCsET
	 DsgksdzK2P0s7V95ocnZ4c3pbICJN2Kd+1oEUWCYvTh30373oxteef22geXqABPEdJ
	 RRBfPRzc2LDeXAN2GrI/s8ZhbKrjSpl33tbOYY3AMasEDrCg7Kr7kO3fSCG3I204+m
	 kH6ZR3M3c9jpxLLkG3utXjdGhswCQaayhQDR+Uj3Dr5l7J002Eel/+OgeYuGgcec31
	 dEvwsjI3BhbsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38A73C53BD0; Wed, 24 Jan 2024 16:49:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date: Wed, 24 Jan 2024 16:49:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: LeeFlemingster@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204589-62941-7XGwsDL4Nc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

Lee Fleming (LeeFlemingster@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |LeeFlemingster@protonmail.c
                   |                            |om

--- Comment #20 from Lee Fleming (LeeFlemingster@protonmail.com) ---
I have been able to reproduce this problem.

OpenSuse Tumbleweed.
Framework AMD 13-inch laptop.

I've only seen the magic trackpad 2 disconnect under a specific condition.

I have an LG Xboom bluetooth speaker. When the speaker is on, connected to
bluetooth and connected to USB to charge, then when I stop moving the mouse
pointer for 5 seconds the trackpad disconnects.

This only happens when the speaker is connected to the USB A port (front le=
ft).
If connected to the USB C port (or physically disconnected entirely) then t=
he
problem goes away.

I have not tried swaping the USB modules on this laptop. Not all the ports =
are
made equal. The speaker was connected to port 2 in this diagram.
https://knowledgebase.frame.work/en_us/expansion-card-functionality-on-fram=
ework-laptop-13-amd-ryzen-7040-series-SkrVx7gAh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
